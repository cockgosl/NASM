#include <stdlib.h>
extern void my_printf(const char* string, ...);

int main() {
    char m = 'm';
    char e = 'e';
    char o = 'o';
    char w = 'w';
    my_printf("%c%c%c%c", m,e,o,w);
    return 0;
}