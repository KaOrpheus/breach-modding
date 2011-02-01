#include <stdio.h>
#include <malloc.h>
#include <string.h>

struct dar_header {
	char magic[4];
	int version;
	uint directory_offset;
	uint data_offset_relative;
	uint data_offset;
	uint file_length;
};

struct dar_descriptor {
	char *group_name;
	char *file_name;
};

struct dar_entry {
	char *file_name;
	uint hash;
	uint unknown;
	uint data_offset_relative;
	uint data_length;
	uint descriptor_count;
	struct dar_descriptor *descriptors;
};

struct dar_directory {
	char *directory_name;
	uint file_count;
	struct dar_entry *entries;
};

inline void endian_swap(unsigned int *x) {
	*x = (*x>>24) | 
		((*x<<8) & 0x00FF0000) |
		((*x>>8) & 0x0000FF00) |
		(*x<<24);
}

void read_int(FILE *f, int *i) {
	fread(i, sizeof(*i), 1, f);
}

char *read_string(FILE *f) {
	char *string;
	uint len;
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

int main(int argc, char *argv[]) {
	int list = 0;
	uint i, j, k, len;
	FILE *f;
	struct dar_header head;
	struct dar_directory *directories;
	uint directory_count;
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

	f = fopen(argv[1], "r");
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
		FILE *f2;
		int i;
		char *buffer = (char*)malloc(extract_file->data_length);
		fseek(f, head.data_offset + extract_file->data_offset_relative, SEEK_SET);
		i = fread(buffer, extract_file->data_length, 1, f);
		if (argc > 4)
			f2 = fopen(argv[4], "w");
		else
			f2 = fopen(argv[3], "w");
		i = fwrite(buffer, 1, extract_file->data_length, f2);
		fclose(f2);
	}
	// TODO: A whole lot of free()ing


	fclose(f);
	return 0;
}
