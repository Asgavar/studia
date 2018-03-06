#include <stdlib.h>

#define MIN(a, b) ((a < b) ? a : b)

typedef struct {
    int numerator;
    int denominator;
} Fraction;

void to_common_denominator(Fraction* p, Fraction* q) {
    int p_initial_denom = p->denominator;
    int q_initial_denom = q->denominator;
    p->numerator *= q_initial_denom;
    p->denominator *= q_initial_denom;
    q->numerator *= p_initial_denom;
    q->denominator *= p_initial_denom;
}

void to_irreducible_form(Fraction* p) {
    int divisor = MIN(p->numerator, p->denominator);
    for (; abs(divisor) >= 1; divisor--) {
        if (p->numerator % divisor == 0 && p->denominator % divisor == 0) {
            p->numerator /= divisor;
            p->denominator /= divisor;
            break;
        }
    }
    /* przeniesienie liczby ujemnej do licznika */
    if (p->denominator < 0) {
        p->numerator *= -1;
        p->denominator *= -1;
    }
}

void copy_fraction(Fraction* from, Fraction* to) {
    to->numerator = from->numerator;
    to->denominator = from->denominator;
}

Fraction* add(Fraction p, Fraction q) {
    to_common_denominator(&p, &q);
    Fraction* new_frac = malloc(sizeof(Fraction));
    new_frac->numerator = p.numerator + q.numerator;
    new_frac->denominator = p.denominator;
    to_irreducible_form(new_frac);
    return new_frac;
}

Fraction* substract(Fraction p, Fraction q) {
    to_common_denominator(&p, &q);
    Fraction* new_frac = malloc(sizeof(Fraction));
    new_frac->numerator = p.numerator - q.numerator;
    new_frac->denominator = p.denominator;
    to_irreducible_form(new_frac);
    return new_frac;
}

Fraction* multiply(Fraction p, Fraction q) {
    Fraction* new_frac = malloc(sizeof(Fraction));
    new_frac->numerator = p.numerator * q.numerator;
    new_frac->denominator = p.denominator * q.denominator;
    to_irreducible_form(new_frac);
    return new_frac;
}

Fraction* divide(Fraction p, Fraction q) {
    Fraction* new_frac = malloc(sizeof(Fraction));
    new_frac->numerator = p.numerator * q.denominator;
    new_frac->denominator = p.denominator * q.numerator;
    to_irreducible_form(new_frac);
    return new_frac;
}

void add_in_place(Fraction* p, Fraction* q) {
    Fraction* result = add(*p, *q);
    copy_fraction(result, q);
}

void substract_in_place(Fraction* p, Fraction* q) {
    Fraction* result = substract(*p, *q);
    copy_fraction(result, q);
}

void multiply_in_place(Fraction* p, Fraction* q) {
    Fraction* result = multiply(*p, *q);
    copy_fraction(result, q);
}

void divide_in_place(Fraction* p, Fraction* q) {
    Fraction* result = divide(*p, *q);
    copy_fraction(result, q);
}
