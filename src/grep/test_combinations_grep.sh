TEST_FILE1=test.txt
TEST_FILE2=test2.txt
GREP_PATTERN="t"
SUCC_COUNTS=0
FAIL_COUNTS=0

function assert {
    echo -e "\t\t========================="
    echo -e  "\t\t\t_ TEST $1 _"
    echo -e "\t\t========================="
    echo ""
    diff <(grep $GREP_ARGS $GREP_PATTERN $TEST_FILE1) <(./s21_grep $GREP_ARGS $GREP_PATTERN $TEST_FILE1)
    if [ $? -ne 0 ]; then
        echo -e  "\t\t for $TEST_FILE1 FAILED"
        echo ""
        ((FAIL_COUNTS++))
        exit
    else
        echo -e  "\t\t for $TEST_FILE1 OK"
        echo ""
        ((SUCC_COUNTS++))
    fi
    diff <(grep $GREP_ARGS $GREP_PATTERN $TEST_FILE2) <(./s21_grep $GREP_ARGS $GREP_PATTERN $TEST_FILE2)
    if [ $? -ne 0 ]; then
        echo -e  "\t\t for $TEST_FILE2 FAILED"
        echo ""
        ((FAIL_COUNTS++))
        exit
    else
        echo -e  "\t\t for $TEST_FILE2 OK"
        echo ""
        ((SUCC_COUNTS++))
    fi
    diff <(grep $GREP_ARGS $GREP_PATTERN $TEST_FILE1 $TEST_FILE2) <(./s21_grep $GREP_ARGS $GREP_PATTERN $TEST_FILE1 $TEST_FILE2)
    if [ $? -ne 0 ]; then
        echo -e  "\t\t for all files FAILED"
        echo ""
        ((FAIL_COUNTS++))
        exit
    else
        echo -e  "\t\t for all files OK"
        echo ""
        ((SUCC_COUNTS++))
    fi
    
   # echo ""
   echo -e "\t\t-------------------------"
    echo -e "\t\t|\tSUCCESS $SUCC_COUNTS\t|"
    echo -e "\t\t|\tFAIL $FAIL_COUNTS\t\t|"
    echo -e "\t\t-------------------------"
    echo ""
    echo ""
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

GREP_ARGS="-i -v"
assert 9

GREP_ARGS="-i -c"
assert 10

GREP_ARGS="-i -l"
assert 11

GREP_ARGS="-i -n"
assert 12

GREP_ARGS="-i -h"
assert 13

GREP_ARGS="-i -s"
assert 14

GREP_ARGS="-i -o"
assert 15

GREP_ARGS="-v -c"
assert 16

GREP_ARGS="-v -l"
assert 17

GREP_ARGS="-v -n"
assert 18

GREP_ARGS="-v -h"
assert 19

GREP_ARGS="-v -s"
assert 20

GREP_ARGS="-v -o"
assert 21

GREP_ARGS="-c -l"
assert 22

GREP_ARGS="-c -n"
assert 23

GREP_ARGS="-c -h"
assert 24

GREP_ARGS="-c -s"
assert 25

GREP_ARGS="-c -o"
assert 26

GREP_ARGS="-l -n"
assert 27

GREP_ARGS="-l -h"
assert 28

GREP_ARGS="-l -s"
assert 29

GREP_ARGS="-l -o"
assert 30

GREP_ARGS="-n -h"
assert 31

GREP_ARGS="-n -s"
assert 32

GREP_ARGS="-n -o"
assert 33

GREP_ARGS="-h -s"
assert 34

GREP_ARGS="-h -o"
assert 35

GREP_ARGS="-s -o"
assert 36

GREP_ARGS="-i -v -c"
assert 37

GREP_ARGS="-i -v -l"
assert 38

GREP_ARGS="-i -v -n"
assert 39

GREP_ARGS="-i -v -h"
assert 40

GREP_ARGS="-i -v -s"
assert 41

GREP_ARGS="-i -v -o"
assert 42

GREP_ARGS="-i -c -l"
assert 43

GREP_ARGS="-i -c -n"
assert 44

GREP_ARGS="-i -c -h"
assert 45

GREP_ARGS="-i -c -s"
assert 46

GREP_ARGS="-i -c -o"
assert 47

GREP_ARGS="-i -l -n"
assert 48

GREP_ARGS="-i -l -h"
assert 49

GREP_ARGS="-i -l -s"
assert 50

GREP_ARGS="-i -l -o"
assert 51

GREP_ARGS="-i -n -h"
assert 52

GREP_ARGS="-i -n -s"
assert 53

GREP_ARGS="-i -n -o"
assert 54

GREP_ARGS="-i -h -s"
assert 55

GREP_ARGS="-i -h -o"
assert 56

GREP_ARGS="-i -s -o"
assert 57

GREP_ARGS="-v -c -l"
assert 58

GREP_ARGS="-v -c -n"
assert 59

GREP_ARGS="-v -c -h"
assert 60

GREP_ARGS="-v -c -s"
assert 61

GREP_ARGS="-v -c -o"
assert 62

GREP_ARGS="-v -l -n"
assert 63

GREP_ARGS="-v -l -h"
assert 64

GREP_ARGS="-v -l -s"
assert 65

GREP_ARGS="-v -l -o"
assert 66

GREP_ARGS="-v -n -h"
assert 67

GREP_ARGS="-v -n -s"
assert 68

GREP_ARGS="-v -n -o"
assert 69

GREP_ARGS="-v -h -s"
assert 70

GREP_ARGS="-v -h -o"
assert 71

GREP_ARGS="-v -s -o"
assert 72

GREP_ARGS="-c -l -n"
assert 73

GREP_ARGS="-c -l -h"
assert 74

GREP_ARGS="-c -l -s"
assert 75

GREP_ARGS="-c -l -o"
assert 76

GREP_ARGS="-c -n -h"
assert 77

GREP_ARGS="-c -n -s"
assert 78

GREP_ARGS="-c -n -o"
assert 79

GREP_ARGS="-c -h -s"
assert 80

GREP_ARGS="-c -h -o"
assert 81

GREP_ARGS="-c -s -o"
assert 82

GREP_ARGS="-l -n -h"
assert 83

GREP_ARGS="-l -n -s"
assert 84

GREP_ARGS="-l -n -o"
assert 85

GREP_ARGS="-l -h -s"
assert 86

GREP_ARGS="-l -h -o"
assert 87

GREP_ARGS="-l -s -o"
assert 88

GREP_ARGS="-n -h -s"
assert 89

GREP_ARGS="-n -h -o"
assert 90

GREP_ARGS="-n -s -o"
assert 91

GREP_ARGS="-h -s -o"
assert 92

GREP_ARGS="-i -v -c -l"
assert 93

GREP_ARGS="-i -v -c -n"
assert 94

GREP_ARGS="-i -v -c -h"
assert 95

GREP_ARGS="-i -v -c -s"
assert 96

GREP_ARGS="-i -v -c -o"
assert 97

GREP_ARGS="-i -v -l -n"
assert 98

GREP_ARGS="-i -v -l -h"
assert 99

GREP_ARGS="-i -v -l -s"
assert 100

GREP_ARGS="-i -v -l -o"
assert 101

GREP_ARGS="-i -v -n -h"
assert 102

GREP_ARGS="-i -v -n -s"
assert 103

GREP_ARGS="-i -v -n -o"
assert 104

GREP_ARGS="-i -v -h -s"
assert 105

GREP_ARGS="-i -v -h -o"
assert 106

GREP_ARGS="-i -v -s -o"
assert 107

GREP_ARGS="-i -c -l -n"
assert 108

GREP_ARGS="-i -c -l -h"
assert 109

GREP_ARGS="-i -c -l -s"
assert 110

GREP_ARGS="-i -c -l -o"
assert 111

GREP_ARGS="-i -c -n -h"
assert 112

GREP_ARGS="-i -c -n -s"
assert 113

GREP_ARGS="-i -c -n -o"
assert 114

GREP_ARGS="-i -c -h -s"
assert 115

GREP_ARGS="-i -c -h -o"
assert 116

GREP_ARGS="-i -c -s -o"
assert 117

GREP_ARGS="-i -l -n -h"
assert 118

GREP_ARGS="-i -l -n -s"
assert 119

GREP_ARGS="-i -l -n -o"
assert 120

GREP_ARGS="-i -l -h -s"
assert 121

GREP_ARGS="-i -l -h -o"
assert 122

GREP_ARGS="-i -l -s -o"
assert 123

GREP_ARGS="-i -n -h -s"
assert 124

GREP_ARGS="-i -n -h -o"
assert 125

GREP_ARGS="-i -n -s -o"
assert 126

GREP_ARGS="-i -h -s -o"
assert 127

GREP_ARGS="-v -c -l -n"
assert 128

GREP_ARGS="-v -c -l -h"
assert 129

GREP_ARGS="-v -c -l -s"
assert 130

GREP_ARGS="-v -c -l -o"
assert 131

GREP_ARGS="-v -c -n -h"
assert 132

GREP_ARGS="-v -c -n -s"
assert 133

GREP_ARGS="-v -c -n -o"
assert 134

GREP_ARGS="-v -c -h -s"
assert 135

GREP_ARGS="-v -c -h -o"
assert 136

GREP_ARGS="-v -c -s -o"
assert 137

GREP_ARGS="-v -l -n -h"
assert 138

GREP_ARGS="-v -l -n -s"
assert 139

GREP_ARGS="-v -l -n -o"
assert 140

GREP_ARGS="-v -l -h -s"
assert 141

GREP_ARGS="-v -l -h -o"
assert 142

GREP_ARGS="-v -l -s -o"
assert 143

GREP_ARGS="-v -n -h -s"
assert 144

GREP_ARGS="-v -n -h -o"
assert 145

GREP_ARGS="-v -n -s -o"
assert 146

GREP_ARGS="-v -h -s -o"
assert 147

GREP_ARGS="-c -l -n -h"
assert 148

GREP_ARGS="-c -l -n -s"
assert 149

GREP_ARGS="-c -l -n -o"
assert 150

GREP_ARGS="-c -l -h -s"
assert 151

GREP_ARGS="-c -l -h -o"
assert 152

GREP_ARGS="-c -l -s -o"
assert 153

GREP_ARGS="-c -n -h -s"
assert 154

GREP_ARGS="-c -n -h -o"
assert 155

GREP_ARGS="-c -n -s -o"
assert 156

GREP_ARGS="-c -h -s -o"
assert 157

GREP_ARGS="-l -n -h -s"
assert 158

GREP_ARGS="-l -n -h -o"
assert 159

GREP_ARGS="-l -n -s -o"
assert 160

GREP_ARGS="-l -h -s -o"
assert 161

GREP_ARGS="-n -h -s -o"
assert 162

GREP_ARGS="-i -v -c -l -n"
assert 163

GREP_ARGS="-i -v -c -l -h"
assert 164

GREP_ARGS="-i -v -c -l -s"
assert 165

GREP_ARGS="-i -v -c -l -o"
assert 166

GREP_ARGS="-i -v -c -n -h"
assert 167

GREP_ARGS="-i -v -c -n -s"
assert 168

GREP_ARGS="-i -v -c -n -o"
assert 169

GREP_ARGS="-i -v -c -h -s"
assert 170

GREP_ARGS="-i -v -c -h -o"
assert 171

GREP_ARGS="-i -v -c -s -o"
assert 172

GREP_ARGS="-i -v -l -n -h"
assert 173

GREP_ARGS="-i -v -l -n -s"
assert 174

GREP_ARGS="-i -v -l -n -o"
assert 175

GREP_ARGS="-i -v -l -h -s"
assert 176

GREP_ARGS="-i -v -l -h -o"
assert 177

GREP_ARGS="-i -v -l -s -o"
assert 178

GREP_ARGS="-i -v -n -h -s"
assert 179

GREP_ARGS="-i -v -n -h -o"
assert 180

GREP_ARGS="-i -v -n -s -o"
assert 181

GREP_ARGS="-i -v -h -s -o"
assert 182

GREP_ARGS="-i -c -l -n -h"
assert 183

GREP_ARGS="-i -c -l -n -s"
assert 184

GREP_ARGS="-i -c -l -n -o"
assert 185

GREP_ARGS="-i -c -l -h -s"
assert 186

GREP_ARGS="-i -c -l -h -o"
assert 187

GREP_ARGS="-i -c -l -s -o"
assert 188

GREP_ARGS="-i -c -n -h -s"
assert 189

GREP_ARGS="-i -c -n -h -o"
assert 190

GREP_ARGS="-i -c -n -s -o"
assert 191

GREP_ARGS="-i -c -h -s -o"
assert 192

GREP_ARGS="-i -l -n -h -s"
assert 193

GREP_ARGS="-i -l -n -h -o"
assert 194

GREP_ARGS="-i -l -n -s -o"
assert 195

GREP_ARGS="-i -l -h -s -o"
assert 196

GREP_ARGS="-i -n -h -s -o"
assert 197

GREP_ARGS="-v -c -l -n -h"
assert 198

GREP_ARGS="-v -c -l -n -s"
assert 199

GREP_ARGS="-v -c -l -n -o"
assert 200

GREP_ARGS="-v -c -l -h -s"
assert 201

GREP_ARGS="-v -c -l -h -o"
assert 202

GREP_ARGS="-v -c -l -s -o"
assert 203

GREP_ARGS="-v -c -n -h -s"
assert 204

GREP_ARGS="-v -c -n -h -o"
assert 205

GREP_ARGS="-v -c -n -s -o"
assert 206

GREP_ARGS="-v -c -h -s -o"
assert 207

GREP_ARGS="-v -l -n -h -s"
assert 208

GREP_ARGS="-v -l -n -h -o"
assert 209

GREP_ARGS="-v -l -n -s -o"
assert 210

GREP_ARGS="-v -l -h -s -o"
assert 211

GREP_ARGS="-v -n -h -s -o"
assert 212

GREP_ARGS="-c -l -n -h -s"
assert 213

GREP_ARGS="-c -l -n -h -o"
assert 214

GREP_ARGS="-c -l -n -s -o"
assert 215

GREP_ARGS="-c -l -h -s -o"
assert 216

GREP_ARGS="-c -n -h -s -o"
assert 217

GREP_ARGS="-l -n -h -s -o"
assert 218

GREP_ARGS="-i -v -c -l -n -h"
assert 219

GREP_ARGS="-i -v -c -l -n -s"
assert 220

GREP_ARGS="-i -v -c -l -n -o"
assert 221

GREP_ARGS="-i -v -c -l -h -s"
assert 222

GREP_ARGS="-i -v -c -l -h -o"
assert 223

GREP_ARGS="-i -v -c -l -s -o"
assert 224

GREP_ARGS="-i -v -c -n -h -s"
assert 225

GREP_ARGS="-i -v -c -n -h -o"
assert 226

GREP_ARGS="-i -v -c -n -s -o"
assert 227

GREP_ARGS="-i -v -c -h -s -o"
assert 228

GREP_ARGS="-i -v -l -n -h -s"
assert 229

GREP_ARGS="-i -v -l -n -h -o"
assert 230

GREP_ARGS="-i -v -l -n -s -o"
assert 231

GREP_ARGS="-i -v -l -h -s -o"
assert 232

GREP_ARGS="-i -v -n -h -s -o"
assert 233

GREP_ARGS="-i -c -l -n -h -s"
assert 234

GREP_ARGS="-i -c -l -n -h -o"
assert 235

GREP_ARGS="-i -c -l -n -s -o"
assert 236

GREP_ARGS="-i -c -l -h -s -o"
assert 237

GREP_ARGS="-i -c -n -h -s -o"
assert 238

GREP_ARGS="-i -l -n -h -s -o"
assert 239

GREP_ARGS="-v -c -l -n -h -s"
assert 240

GREP_ARGS="-v -c -l -n -h -o"
assert 241

GREP_ARGS="-v -c -l -n -s -o"
assert 242

GREP_ARGS="-v -c -l -h -s -o"
assert 243

GREP_ARGS="-v -c -n -h -s -o"
assert 244

GREP_ARGS="-v -l -n -h -s -o"
assert 245

GREP_ARGS="-c -l -n -h -s -o"
assert 246

GREP_ARGS="-i -v -c -l -n -h -s"
assert 247

GREP_ARGS="-i -v -c -l -n -h -o"
assert 248

GREP_ARGS="-i -v -c -l -n -s -o"
assert 249

GREP_ARGS="-i -v -c -l -h -s -o"
assert 250

GREP_ARGS="-i -v -c -n -h -s -o"
assert 251

GREP_ARGS="-i -v -l -n -h -s -o"
assert 252

GREP_ARGS="-i -c -l -n -h -s -o"
assert 253

GREP_ARGS="-v -c -l -n -h -s -o"
assert 254

GREP_ARGS="-i -v -c -l -n -h -s -o"
assert 255

GREP_ARGS="-e 2 -e r -ic -s"
assert 256

echo "3" > tmp_patt.txt
GREP_ARGS="-f tmp_patt.txt -s"
assert 257

echo "p" > tmp_patt2.txt
GREP_ARGS="-f tmp_patt.txt -s -f tmp_patt2.txt"
assert 258
