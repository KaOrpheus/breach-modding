#include <stdio.h>
#include <sys/stat.h>
#include <malloc.h>
#include <string.h>

struct dar_header {
	char magic[4];
	int version;
	unsigned int directory_offset;
	unsigned int data_offset_relative;
	unsigned int data_offset;
	unsigned int file_length;
};

struct dar_descriptor {
	char *group_name;
	char *file_name;
};

struct dar_entry {
	char *file_name;
	unsigned int hash;
	unsigned int unknown;
	unsigned int data_offset_relative;
	unsigned int data_length;
	unsigned int descriptor_count;
	struct dar_descriptor *descriptors;
};

struct dar_directory {
	char *directory_name;
	unsigned int file_count;
	struct dar_entry *entries;
};

void read_int(FILE *f, int *i) {
	fread(i, sizeof(*i), 1, f);
}

char *read_string(FILE *f) {
	char *string;
	unsigned int len;
	fread(&len, sizeof(len), 1, f);
	string = (char*)malloc(len + 1);
	if (!string) {
		printf("malloc fail in read_string\n");
		return 0;
	}
	fread(string, len, 1, f);
	string[len] = 0;
	return string;
}

int max(int a, int b) {
	return (a>b) ? a : b;
}

static void mkdir_recursive(const char *dir) {
	char tmp[256];
	char *p = NULL;
	size_t len;
	memcpy(tmp, dir, max(strlen(dir), 255));
	tmp[255] = 0;
	len = strlen(tmp);
	if(tmp[len - 1] == '\\') {
		tmp[len - 1] = 0;
	}
	for(p = tmp + 1; *p; p++) {
		if(*p == '\\') {
			*p = 0;
#ifdef _WIN32
			_mkdir(tmp);
#else
			mkdir(tmp, 0744);
#endif
			*p = '\\';
		}
	}
#ifdef _WIN32
	_mkdir(tmp);
#else
	mkdir(tmp, 0744);
#endif
}

void extract_single_file(char *dir, char *filename, FILE *f, unsigned int offset, unsigned int length) {
	FILE *f2;
	int dirlen = strlen(dir), filelen = strlen(filename);
	char *path = (char*)malloc(dirlen + filelen + 2);
	char *buffer = (char*)malloc(length);

	memcpy((char*)(path), dir, dirlen);
	path[dirlen] = '\\';
	memcpy((char*)(path + dirlen + 1), filename, filelen);
	path[dirlen + filelen + 1] = 0;

	mkdir_recursive(dir);

	fseek(f, offset, SEEK_SET);
	fread(buffer, length, 1, f);
	f2 = fopen(path, "wb");
	fwrite(buffer, 1, length, f2);
	fclose(f2);
	free(buffer);

}

int main(int argc, char *argv[]) {
	int list = 0;
	unsigned int i, j, k, len;
	FILE *f;
	struct dar_header head;
	struct dar_directory *directories;
	unsigned int directory_count;
	struct dar_directory *dir;
	struct dar_entry *ent;
	struct dar_descriptor *des;

	struct dar_directory *extract_dir = 0;
	struct dar_entry *extract_file = 0;

	if (argc < 2) {
		printf("Usage: %s <file.dar> [directory to extract] [file to extract] [output file]\n", argv[0]);
		return 1;
	}

	if (argc == 2)
		list = 1;

	f = fopen(argv[1], "rb");
	if (!f) {
		printf("Could not open '%s'\n", argv[1]);
		return 1;
	}

	fread(&head, sizeof(struct dar_header), 1, f);

	fseek(f, head.directory_offset, SEEK_SET);
	read_int(f, &directory_count);
	if (list) printf("Directory count: %u\n", directory_count);
	directories = (struct dar_directory*)malloc(directory_count * sizeof(struct dar_directory));
	for (i = 0; i < directory_count; i++) {
		dir = &directories[i];
		dir->directory_name = read_string(f);
		if (list) printf("%s\n", dir->directory_name);

		if (argc > 2)  // Extract dir specified
			if (stricmp(dir->directory_name, argv[2]) == 0)
				extract_dir = dir;

		read_int(f, &dir->file_count);
		dir->entries = (struct dar_entry*)malloc(dir->file_count * sizeof(struct dar_entry));
		for (j = 0; j < dir->file_count; j++) {
			ent = &dir->entries[j];
			ent->file_name = read_string(f);
			if (list) printf("\t%s\n", ent->file_name);

			if (argc > 3 && extract_dir == dir)  // Extract file specified and this is the matching dir
				if (stricmp(ent->file_name, argv[3]) == 0)
					extract_file = ent;

			read_int(f, &ent->hash);
			read_int(f, &ent->unknown);
			read_int(f, &ent->data_offset_relative);
			read_int(f, &ent->data_length);
			read_int(f, &ent->descriptor_count);

			if (list) {
				long int floc = ftell(f);
				extract_single_file(dir->directory_name, ent->file_name, f, head.data_offset + ent->data_offset_relative, ent->data_length);
				fseek(f, floc, SEEK_SET);
			}

			ent->descriptors = (struct dar_descriptor*)malloc(ent->descriptor_count * sizeof(struct dar_descriptor));
			for (k = 0; k < ent->descriptor_count; k++) {
				des = &ent->descriptors[k];
				des->group_name = read_string(f);
				des->file_name = read_string(f);
				if (list) printf("\t\t%s - %s\n", des->file_name, des->group_name);
			}
		}
	}
	
	if (extract_file) {
		extract_single_file(extract_dir->directory_name, extract_file->file_name, f, head.data_offset + extract_file->data_offset_relative, extract_file->data_length);
	}

	// TODO: A whole lot of free()ing


	fclose(f);
	return 0;
}
