#include <stdio.h>

int main(int argc, char** argv) {
    int n = 3;
    int m = 4;
    int ret[n+1][m+1];  // tabela, m wierszy i n kolumn
    /* gorny wiersz*/
    for (int x = 0; x <= n; x++)
        ret[x][0] = x;
    /* lewa kolumna */
    for (int y = 0; y <= m; y++)
        ret[0][y] = y;
    /* cala reszta */
    for (int x = 1; x <= n; x++) {
        for (int y = 1; y <= m; y++) {
            ret[x][y] = ret[x-1][y] + 2*ret[x][y-1];
        }
    }
    printf("%d\n", ret[n][m]);
    return 0;
}
