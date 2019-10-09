#include <math.h>
#include <stdio.h>

double neg_pow_of_ten(double sofar, int left) {
    if (left == 0) return sofar;
    return neg_pow_of_ten(sofar / 10, left - 1);
}   

float f_as_float(float x) {
    return 4038 * ((1 - cos(x)) / (x*x));
}   


float f_as_double(double x) {
    return (4038 * ((1 - cos(x)) / x) / x);
}   

int main(void) {
    for (int _ = 1; _ <= 10; _++) {
        printf("%.25f\n", neg_pow_of_ten(1, _));
        printf("%.25f\n", cos(0.000000000000001));
        printf("FLOAT %d %.25f\n", _, f_as_float(neg_pow_of_ten(1, _)));
        printf("DOUBLE %d %.25f\n", _, f_as_double(neg_pow_of_ten(1, _)));
    }   
}   
