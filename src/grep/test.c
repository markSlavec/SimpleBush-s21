#include <stdio.h>
#include <string.h> 
#include <stdlib.h> 
#include <getopt.h>
#include <ctype.h>
#include <regex.h>
#include <unistd.h>
#include "s21_grep.h"

void parse_option(int argc, char* argv[], char* opt_user, int *counter, char ***arguments_e, int *counter_arguments, int *start_parametr) {
    char opt;
    *counter = 0;

    while ((opt = getopt(argc, argv, short_option)) != -1) {
        if (opt != '?') {
            opt_user[*counter] = opt;
            *counter += 1;
            if (opt == 'e') {
                *counter_arguments += 1;
                *arguments_e = realloc(*arguments_e, *counter_arguments * sizeof(char *));
                if (*arguments_e == NULL) {
                    perror("Failed to allocate memory");
                    exit(EXIT_FAILURE);
                }

                (*arguments_e)[*counter_arguments - 1] = strdup(optarg);
                if ((*arguments_e)[*counter_arguments - 1] == NULL) {
                    perror("Failed to allocate memory");
                    exit(EXIT_FAILURE);
                }
            }
        }
    }
    *start_parametr = optind;
}

void convert_to_lower(char* str) {
    int len = strlen(str);
    for (int i = 0; i < len; i++) {
        if (isupper((unsigned char)str[i])) {
            str[i] = tolower((unsigned char)str[i]);
        } else if ((unsigned char)str[i] >= 192) {
            str[i] += 32;
        }
    }
}

void flag_n(char* user_option, int counter_line) {
    if (strchr(user_option, 'n') != NULL) {
        printf("%d:", counter_line);
    }
}

void check_words_and_print(char* words_line, char* necessary_words, char* user_option, int* counter, int *flag_l, int counter_line, char** arguments_e, int counter_e, int size_words_line, int flag_many_files, char* path) {
    int flag_many_files_work = 1;

    if (strchr(user_option, 'e')) {
        int reti;
        regex_t regex[300];

        for (int i = 0; i < counter_e; i++) {
            reti = regcomp(&regex[i], arguments_e[i], REG_EXTENDED);
            if (reti) {
                fprintf(stderr, "Could not compile regex\n");
                exit(EXIT_FAILURE);
            }
        }
        
        for (int i = 0; i < counter_e; i++) {
            reti = regexec(&regex[i], words_line, 0, NULL, 0);
            if (!reti) {
                if (flag_many_files && flag_many_files_work) {
                    printf("%s:", path);
                    flag_many_files_work = 0;
                }
                printf("%s", words_line);
                break;
            }
        }

        for (int i = 0; i < counter_e; i++) {
            regfree(&regex[i]);
        }
    } else if (strchr(user_option, 'c')) {
        if (strstr(words_line, necessary_words) != NULL) {
            *counter += 1;
        }
    } else if (strchr(user_option, 'l')) {
        if (strstr(words_line, necessary_words) != NULL) {
            *flag_l = 1;
        }
    } else {
        if (strchr(user_option, 'v')) {
            if (strstr(words_line, necessary_words) == NULL) {
                if (flag_many_files && flag_many_files_work) {
                    printf("%s:", path);
                    flag_n(user_option, counter_line);
                    flag_many_files_work = 0;
                }
                printf("%s", words_line);
            }
        } else if (strchr(user_option, 'i')) {
            char* words_line_copy = malloc(size_words_line * sizeof(char));
            char necessary_words_copy[1024];
            strcpy(words_line_copy, words_line);
            strcpy(necessary_words_copy, necessary_words);
            convert_to_lower(words_line_copy);
            convert_to_lower(necessary_words_copy);
            if (strstr(words_line_copy, necessary_words_copy) != NULL) {
                flag_n(user_option, counter_line);
                if (flag_many_files && flag_many_files_work) {
                    printf("%s:", path);
                    flag_many_files_work = 0;
                }
                printf("%s", words_line);
            }
            free(words_line_copy);
        } else if (strstr(words_line, necessary_words) != NULL) {
            if (flag_many_files && flag_many_files_work) {
                printf("%s:", path);
                flag_many_files_work = 0;
            }
            flag_n(user_option, counter_line);
            printf("%s", words_line);
        }
    }
}

void print_identical_lines(char* path, char* user_option, char* necessary_words, char** arguments_e, int counter_e, int flag_many_files) {
    FILE *fp;
    int size = 100;
    char* words_line = (char*)malloc(size * sizeof(char));
    int counter = 0;
    int flag_l = 0;
    int counter_line = 1;

    if ((fp = fopen(path, "r")) != NULL) {
        char c;
        int index = 0;

        while (1) {
            if ((c = fgetc(fp)) != EOF) {
                words_line[index] = c;
                index++;

                if (c == '\n') {
                    words_line[index] = '\0';
                    check_words_and_print(words_line, necessary_words, user_option, &counter, &flag_l, counter_line, arguments_e, counter_e, size, flag_many_files, path);
                    size = 100;
                    words_line = (char*)realloc(words_line, size * sizeof(char));
                    index = 0;
                    counter_line++;

                    if (flag_l) {
                        printf("%s\n", path);
                        flag_l = 0;
                        break;
                    }
                }

                if (index + 30 > size) {
                    size *= 2;
                    words_line = realloc(words_line, size * sizeof(char));
                }
            } else {
                break;
            }
        }

        if (strchr(user_option, 'c')) {
            if (flag_many_files) printf("%s:", path);
            printf("%d\n", counter);
        }

        fclose(fp);
    } else {
        printf("\n /// Error read file /// \n");
    }
    free(words_line);
}

int main(int argc, char** argv) {
    char opt_user[20];
    char** arguments_e = NULL;
    int counter_arguments = 0;
    int counter;
    int start_files;
    int flag_many_files = 0;

    parse_option(argc, argv, opt_user, &counter, &arguments_e, &counter_arguments, &start_files);

    if (counter_arguments > 0)
        start_files -= 1;

    if (argc - start_files - 1 > 1) {
        flag_many_files = 1;
    }

    if (start_files < argc) {
        for (int i = start_files + 1; i < argc; i++) {
            print_identical_lines(argv[i], opt_user, argv[start_files], arguments_e, counter_arguments, flag_many_files);
        }
    } else {
        fputs("misspelled file name", stdout);
    }

    if (counter_arguments > 0) {
        for (int i = 0; i < counter_arguments; i++) {
            free(arguments_e[i]);
        }
        free(arguments_e);
    }

    return 0;
}
