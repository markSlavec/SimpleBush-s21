#include "s21_cat.h"
#include <ctype.h>


void print_symb(char c, char* user_option, int *index, char* prev, int *empty_string)
{
  // Для флага s
  if (!(strchr(user_option, 's') != NULL && *prev == '\n' && c == '\n' && *empty_string)) {

    if (*prev == '\n' && c == '\n') // Ввод пустой строки
      *empty_string = 1;
    else 
      *empty_string = 0;

    if (((strchr(user_option, 'n') != NULL && strchr(user_option, 'b') == NULL) //  Флаги b и n
      || (strchr(user_option, 'b') != NULL && c != '\n')) 
      && *prev == '\n')
    {
      printf("%6d\t", *index);
      // printf("%c", c);
      *index += 1;
    }

    if (strchr(user_option, 'E') != NULL && c == '\n') printf("$");

        if (strchr(user_option, 'T') != NULL && c == '\t') {
            printf("^");
            c = '\t' + 64;
        }
        if (strchr(user_option, 'v') != NULL && c >= 0 && c <= 31 && c != '\n' && c !='\t') {
            printf("^");
            c = c + 64;
        }

    fputc(c, stdout);
  }
  *prev = c;
  
}



void print_file(char* path, char* user_option)
{
  FILE *fp;

  if ((fp = fopen(path, "r")) != NULL)
  {
    // fputs("file opened", stdout);
    char c;

    // int flag_b = 1;
    int index = 1;
    char prev = '\n';
    int empty_string = 0;

    while (1)
    {
      if ((c = fgetc(fp)) != EOF) {
        print_symb(c, user_option, &index, &prev, &empty_string);
      }

      else {
        // printf("\n /// file is comletely read ///\n");
        break;
      }
    }
    
  }
  else
    printf("\n /// Error read file /// \n");
  
  fclose(fp);
}


void parse_option(int argc, char* argv[], char* opt_user, int *counter)
{
  char opt;
  *counter = 0;

  while ((opt = getopt_long(argc, argv, short_option, long_options, NULL)) != -1)
  {
    if (opt != '?')
    {
      if (opt == 't' || opt == 'e') {
        opt = toupper(opt);
        opt_user[*counter] = opt;
        opt_user[*counter + 1] = 'v';
        *counter += 2;
      }
      else {
      opt_user[*counter] = opt;
      *counter += 1;
      }
    }
  }

}


int main(int argc, char* argv[])
{
  char opt_user [20];
  int counter;

  parse_option(argc, argv, opt_user, &counter);   // Узнаем флаги

  // for (int i = 0; i < counter; i++)
  // {
  //   printf("%c", opt_user[i]);
  // }
  // printf("\n");



  int start_files = 0;
  int flag_files = 0;
  for (int i = 1; i < argc; i++)  // Находим иденкс начала файлов
  {
    if (argv[i][0] != '-') {
        start_files = i;
        flag_files = 1;
        break;
      }
  }
  
  if (flag_files) {
    for (int i = start_files; i < argc; i++) {
      // puts(argv[i]);
      print_file(argv[i], opt_user);
    }
  }
  else
    fputs("misspelled file name", stdout);



  return 0;
}


