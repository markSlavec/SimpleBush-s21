TEST_FILE1=test.txt
GREP_PATTERN="it"

function assert {
   
        echo -e "\t\t=========================" 
        echo -e  "\t\t\t_ TEST $1 _" 
        echo -e "\t\t=========================" 
        echo "" 
        echo ""
        echo ""
        echo -e  "\t\t\t for flag $GREP_ARGS " 
        echo "" 
        echo ""
        echo ""

    grep $GREP_ARGS $GREP_PATTERN $TEST_FILE1
    ./s21_grep $GREP_ARGS $GREP_PATTERN $TEST_FILE1
}



GREP_ARGS="-i"
assert 1

GREP_ARGS="-v"
assert 2

GREP_ARGS="-c"
assert 3

GREP_ARGS="-l"
assert 4

GREP_ARGS="-n"
assert 5

GREP_ARGS="-h"
assert 6

GREP_ARGS="-s"
assert 7

GREP_ARGS="-o"
assert 8

GREP_ARGS="-k"
assert 9