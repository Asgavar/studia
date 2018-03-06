#include <stdio.h>
#include <stdbool.h>
#include <string.h>

int main(int argc, char* argv[]) {
    char* numb = argv[1];
    short pointer = 0;
    short numb_len = strlen(numb);
    bool is_palindrome = true;
    while (pointer < numb_len / 2) {
        if (numb[pointer] != numb[numb_len - pointer - 1]) {
            is_palindrome = false;
            break;
        }
        ++pointer;
    }
    printf("%s %s\n", numb,
        is_palindrome ? "jest palindromem" : "nie jest palindromem");
}
