#include <stdio.h>
#include <stdlib.h>

#include "ulamki.h"

int main(int argc, char* argv) {
    Fraction f1;
    Fraction f2;
    Fraction f3;
    /* f1 = 1/2 */
    f1.numerator = 1;
    f1.denominator = 2;
    /* f2 = 1/8 */
    f2.numerator = 1;
    f2.denominator = 8;
    /* f3 = 7/8 */
    f3.numerator = 7;
    f3.denominator = 8;
    /* dodawanie */
    Fraction* f2_plus_f3 = add(f2, f3);
    printf("1/8 + 7/8 = %d/%d\n", f2_plus_f3->numerator, f2_plus_f3->denominator);
    /* odejmowanie */
    Fraction* f3_minus_f2 = substract(f3, f2);
    printf("7/8 - 1/8 = %d/%d\n", f3_minus_f2->numerator, f3_minus_f2->denominator);
    /* mnozenie */
    Fraction* f1_times_f3 = multiply(f1, f3);
    printf("1/2 * 7/8 = %d/%d\n", f1_times_f3->numerator, f1_times_f3->denominator);
    /* dzielenie */
    Fraction* f1_divided_by_f3 = divide(f1, f3);
    printf("1/2 / 7/8 = %d/%d\n", f1_divided_by_f3->numerator, f1_divided_by_f3->denominator);
    printf("\na teraz to co wyzej, ale w miejscu:\n");
    /* kopie f2 i f3 do pozniejszego podmieniania */
    Fraction initial_f2;
    Fraction initial_f3;
    copy_fraction(&f2, &initial_f2);
    copy_fraction(&f3, &initial_f3);
    /* wszystkie powyzsze dzialania powtorzone w miejscu */
    add_in_place(&f2, &f3);
    printf("1/8 + 7/8 = %d/%d\n", f3.numerator, f3.denominator);
    copy_fraction(&initial_f3, &f3);
    substract_in_place(&f3, &f2);
    printf("7/8 - 1/8 = %d/%d\n", f2.numerator, f2.denominator);
    copy_fraction(&initial_f2, &f2);
    multiply_in_place(&f1, &f3);
    printf("1/2 * 7/8 = %d/%d\n", f3.numerator, f3.denominator);
    copy_fraction(&initial_f3, &f3);
    divide_in_place(&f1, &f3);
    printf("1/2 / 7/8 = %d/%d\n", f3.numerator, f3.denominator);
    /* test dla liczb ujemnych */
    printf("\nLiczby ujemne: \n");
    Fraction nf1, nf2;
    nf1.numerator = -7;
    nf1.denominator = 8;
    nf2.numerator = 8;
    nf2.denominator = 7;
    Fraction* nf1_times_nf2 = multiply(nf1, nf2);
    printf("-7/8 * 8/7 = %d/%d\n", nf1_times_nf2->numerator, nf1_times_nf2->denominator);
    return 0;
}
