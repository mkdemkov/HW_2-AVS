#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* digits[10] = {"0", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"};

void print(int len, char* str, FILE *ptr) {
	for (int i = 0; i < len; i++) {
		fprintf(ptr, "%c", str[i]);
	}
}

void solve_task(char* result, int *len, char* str, int n) {
	for (int i = 0; i < n; i++) {
		if (str[i] >= '1' && str[i] <= '9') {
			int tmp = strlen(digits[str[i] - '0']);
			for (int j = 0; j < tmp; j++) {
				result[*len] = digits[str[i] - '0'][j];
				*len = (*len) + 1;
			}
		}
		else {
			result[*len] = str[i];
			*len = (*len) + 1;
		}
	}
}

void parse_str(char* str, int *n, FILE *ptr) {
	*n = fread(str, sizeof(char), 1000000, ptr);
}

void generate(char* str, int* n) {
	if ((*n) == -1)
		*n = (rand() % 100) + 1;
	for (int i = 0; i < *n; i++) {
		str[i] = (char)(rand() % 128);
	}
}

int main(int argc, char* argv[]) {
	if (argc != 4) {
        puts("Формат ввода из командной строки должен быть ЛИБО: program_file -d input_file output_file");
		puts("ЛИБО: \nprogram_file -g size_of_str output_file\n");
		return 0;
	}
	char *type, *file_in, *file_out;
	type = argv[1];
	if ((strcmp(type, "-g") != 0 && strcmp(type, "-d") != 0)) {
		puts("Формат ввода из командной строки должен быть ЛИБО: program_file -d input_file output_file");
		puts("ЛИБО: \nprogram_file -g size_of_str output_file\n");
		return 0;
	}

	char str[1000000];
	int n = 0;

	if (strcmp(type, "-d") == 0) {
		file_in = argv[2];
		file_out = argv[3];
		FILE *fin_ptr = fopen(file_in, "r");

		if (fin_ptr == NULL) {
			puts("Видимо, такого файла не существует\n");
			return 0;
		}

		parse_str(str, &n, fin_ptr);
		fclose(fin_ptr);
	} else {
		n = atoi(argv[2]);
		file_out = argv[3];
		generate(str, &n);
	}

	char result[1000000];
	int res_len = 0;

	solve_task(result, &res_len, str, n);


	FILE *fout_ptr = fopen(file_out, "w");

	if (fout_ptr == NULL) {
		puts("Видимо, такого файла не существует\n");
		return 0;
	}

	fprintf(fout_ptr, "Исходная строка:\n");
	print(n, str, fout_ptr);
	fprintf(fout_ptr, "\n\nПосле преобразования:\n");
	print(res_len, result, fout_ptr);
	fclose(fout_ptr);
	return 0;
}