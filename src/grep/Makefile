all: s21_grep

s21_grep : s21_grep.o
	gcc -std=c11 -Wall -Werror -Wextra s21_grep.o -o s21_grep


s21_grep.o : s21_grep.c
	gcc -std=c11 -Wall -Werror -Wextra -c s21_grep.c -o s21_grep.o


clean:
	mv *.o s21_grep 

rm:
	clean all