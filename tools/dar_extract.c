#include <stdio.h>
#include <malloc.h>

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
	if (!string) printf("malloc fail in read_string\n");
	fread(string, len, 1, f);
	string[len] = 0;
	return string;
}

int main(int argc, char *argv[]) {
	uint i, j, k, len;
	FILE *f;
	struct dar_header head;
	struct dar_directory *directories;
	uint directory_count;
	struct dar_directory *dir;
	struct dar_entry *ent;
	struct dar_descriptor *des;

	f = fopen(argv[1], "r");
	if (!f) return 1;

	fread(&head, sizeof(struct dar_header), 1, f);

	fseek(f, head.directory_offset, SEEK_SET);
	read_int(f, &directory_count);
	printf("Directory count: %u\n", directory_count);
	directories = (struct dar_directory*)malloc(directory_count * sizeof(struct dar_directory));
	for (i = 0; i < directory_count; i++) {
		dir = &directories[i];
		dir->directory_name = read_string(f);
		printf("%s\n", dir->directory_name);

		read_int(f, &dir->file_count);
		dir->entries = (struct dar_entry*)malloc(dir->file_count * sizeof(struct dar_entry));
		for (j = 0; j < dir->file_count; j++) {
			ent = &dir->entries[j];
			ent->file_name = read_string(f);
			printf("\t%s\n", ent->file_name);
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
				printf("\t\t%s - %s\n", des->file_name, des->group_name);
			}
		}
	}
	
	fclose(f);
	return 0;
}
