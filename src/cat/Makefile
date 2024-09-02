all: s21_cat

s21_cat : s21_cat.o 
	gcc -std=c11 -Wall -Werror -Wextra s21_cat.o -o s21_cat

s21_cat.o : s21_cat.c
	gcc -std=c11 -Wall -Werror -Wextra -c s21_cat.c -o s21_cat.o

clear :
	rm -rf *.out *.o s21_cat

rm :
	make clear all 
