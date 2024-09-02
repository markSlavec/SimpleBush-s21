#ifndef S21_CAT_H
#define S21_CAT_H

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


char short_option[] = "beEnstTv";

// Разобраться с флагами t e и особенно с v
struct option long_options[] = {
    {"number-nonblank", no_argument, NULL, 'b'},
    {"number", no_argument, NULL, 'n'},
    {"squeeze-blank)", no_argument, NULL, 's'},
    
};

#endif