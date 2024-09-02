#include <stdio.h>
#include <string.h> 
#include <stdlib.h> 
#include <getopt.h>
#include <ctype.h>
#include "s21_grep.h"
#include <regex.h>
#include <unistd.h>



void parse_option(int argc, char* argv[], char* opt_user, int *counter, char ***arguments_e, int *counter_arguments, int *start_parametr)
{
  char opt;
  *counter = 0;

  while ((opt = getopt(argc, argv, short_option)) != -1) // флаг -f с аргументом разобраться позже
  {
    if (opt != '?')
    {
      opt_user[*counter] = opt;
      *counter += 1; 
      if (opt == 'e')
      {
        *counter_arguments += 1;
        *arguments_e = realloc(*arguments_e, *counter_arguments * sizeof(char *));
        if (*arguments_e == NULL)
        {
          perror("Failed to allocate memory");
          exit(EXIT_FAILURE);
        }

        (*arguments_e)[*counter_arguments - 1] = strdup(optarg);
        if ((*arguments_e)[*counter_arguments - 1] == NULL)
        {
          perror("Failed to allocate memory");
          exit(EXIT_FAILURE);
        }
      }
    }
  }
  *start_parametr = optind;   // началоа параметров
}



void convert_to_lower(char* str) {
    int len = strlen(str);
    for (int i = 0; i < len; i++) {
        if (isupper((unsigned char)str[i])) { // Проверяем, является ли символ заглавным
            str[i] = tolower((unsigned char)str[i]); // Преобразуем в нижний регистр
        } else if ((unsigned char)str[i] >= 192) { // Диапазон для русских букв в кодировке Windows-1251
            str[i] += 32; // Сдвигаем на 32 позиции вниз
        }
    }
}

void flag_n(char* user_option, int counter_line)
{
  if (strchr(user_option, 'n') != NULL) {
    printf("%d:", counter_line);
  }
}

// Пока без флагов
void check_words_and_print(char* words_line, char* necessary_words, char* user_option, int* counter, int *flag_l, int counter_line, char** arguments_e, int counter_e, int size_words_line, int flag_many_files, char* path)
{
  int flag_many_files_work = 1;

  if (strchr(user_option, 'e'))   // Шаблон.
  {
    int reti;
    regex_t regex[300];

    for (int i = 0; i < counter_e; i++)   // Компиляция регулярных выражений
    {
      reti = regcomp(&regex[i], arguments_e[i], REG_EXTENDED);
    }
    
    for (int i = 0; i < counter_e; i++)
    {
      reti = regexec(&regex[i], words_line, 0, NULL, 0);
      if (!reti)
      {
        if (flag_many_files && flag_many_files_work) {
          printf("%s:", path);   // Если файлов больше 1
          flag_many_files_work = 0;
        }
        printf("%s", words_line);
        break;
      }
    }

    for (int i = 0; i < counter_e; i++) {
            regfree(&regex[i]);
        }
  }

  else if (strchr(user_option, 'c'))   // Выводит только количество совпадающих строк.
  {
    if (strstr(words_line, necessary_words) != NULL)
      *counter += 1;
  }

  else if (strchr(user_option, 'l'))    // Выводит только совпадающие файлы.
  {
    if (strstr(words_line, necessary_words) != NULL)
      *flag_l = 1;
  }

  else 
  {
    if (strchr(user_option, 'v'))   // Инвертирует смысл поиска соответствий.
    {
      if (strstr(words_line, necessary_words) == NULL) {
        if (flag_many_files && flag_many_files_work) {
          printf("%s:", path);   // Если файлов больше 1
          flag_n(user_option, counter_line);    // Флаг n Предваряет каждую строку вывода номером строки из файла ввода.
          flag_many_files_work = 0;
        }       
        printf("%s", words_line);
      }
    }
    

    else if (strchr(user_option, 'i'))    // Игнорирует различия регистра.
    {
      char* words_line_copy = malloc(size_words_line * sizeof(char));
      char necessary_words_copy [1024];
      strcpy(words_line_copy, words_line);
      strcpy(necessary_words_copy, necessary_words);
      convert_to_lower(words_line_copy);  // Все в нижний регистр
      convert_to_lower(necessary_words_copy); // Все в нижний регистр
      if (strstr(words_line_copy, necessary_words_copy) != NULL) {
        flag_n(user_option, counter_line);  // Флаг n Предваряет каждую строку вывода номером строки из файла ввода.
        if (flag_many_files && flag_many_files_work) {
          printf("%s:", path);   // Если файлов больше 1
          flag_many_files_work = 0;
        }       
        printf("%s", words_line);   // Выводим строку без преобразований
      } 
      free(words_line_copy);
      // free(necessary_words);
    }



    else if (strstr(words_line, necessary_words) != NULL) {    // Потом подумаем как это все собрать вместе, пока просто реализуем флаги
        if (flag_many_files && flag_many_files_work) {
          printf("%s:", path);   // Если файлов больше 1
          flag_many_files_work = 0;
        }
        flag_n(user_option, counter_line);  // Флаг n Предваряет каждую строку вывода номером строки из файла ввода.
        printf("%s", words_line);
    }

  }



}


void print_identical_lines(char* path, char* user_option, char* necessary_words, char** arguments_e, int counter_e, int flag_many_files)
{
  FILE *fp;
  int size = 100;
  char* words_line = (char*)malloc(size * sizeof(char));
  int counter = 0;
  int flag_l = 0;
  int counter_line = 1;

  if ((fp = fopen(path, "r")) != NULL)
  {
    char c;
    int index = 0;

    while (1)
    {
      if ((c = fgetc(fp)) != EOF) {
        words_line[index] = c;
        index++;

        if (c == '\n') {    // Заканчиваем считывание абзацы и проверяем его
            check_words_and_print(words_line, necessary_words, user_option, &counter, &flag_l, counter_line, arguments_e, counter_e, size, flag_many_files, path);
            free(words_line);   // Не забываем чистить память
            size = 100;
            words_line = (char*)malloc(size * sizeof(char));
            index = 0;
            counter_line++;

            if (flag_l)   
            {
              printf("%s\n", path);  
              flag_l = 0; 
              break;
            }
        }

        if (index + 30 > size){     // Увеличиваем память
            size *= 2;
            words_line = calloc(size, sizeof(char));
        }
      }

      else {
        // printf("\n /// file is comletely read ///\n");
        break;
      }
    
    }

    if (strchr(user_option, 'c'))   // Ввыод числа совпадающих строк 
      {
        if (flag_many_files) printf("%s:", path);   // Если файлов больше 1
        printf("%d\n", counter);
      }
    
  }
  else
    printf("\n /// Error read file /// \n");
  
  fclose(fp);

  free(words_line);   // Не забываем чистить в конце
}





int main(int argc, char** argv)
{
    
    char opt_user [20];
    char** arguments_e = NULL;
    int counter_arguments = 0;
    int counter;
    int start_files;
    int flag_many_files = 0;


    parse_option(argc, argv, opt_user, &counter, &arguments_e, &counter_arguments, &start_files);   // Узнаем флаги

    // for (int i = 0; i < counter; i++)
    //     {
    //         printf("%c", opt_user[i]);
    //     }
    // printf("\n");

    // int flag_files = 0;
    // if (counter_arguments == 0)   // Если нет флага -e
    // {
    //   for (int i = 1; i < argc; i++)  // Находим иденкс начала файлов
    //       {
    //           if (argv[i][0] != '-') {
    //               start_files = i;
    //               flag_files = 1;
    //               break;
    //           }
    //       }
    // }


    // printf("%d", start_files);

    // for (int i = 0; i < counter_arguments; i++)
    // {
    //   printf("arguments: %s\n", arguments_e[i]);
    // }
    

    // printf("startfile: %d\nargc: %d", start_files, argc);

    if (counter_arguments > 0)  // Костыль для флага -е
      start_files -= 1;

    if (argc - start_files - 1 > 1) {
            flag_many_files = 1;
          }
      
    // printf("%d\n", start_files);

    if (start_files < argc) {
        for (int i = start_files + 1; i < argc; i++) {
          
          // printf("%d %d\n", start_files + 1, argc);

          print_identical_lines(argv[i], opt_user, argv[start_files], arguments_e, counter_arguments, flag_many_files);
        }
    }
    else
        fputs("misspelled file name", stdout);




    if (counter_arguments > 0) {
      for (int i = 0; i < counter_arguments; i++)
      {
        free(arguments_e[i]);
      }
      free(arguments_e);
    }

    return 0;
}


