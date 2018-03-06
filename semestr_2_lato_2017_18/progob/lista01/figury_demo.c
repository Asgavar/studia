#include "figury.h"

int main(int argc, char* argv) {
    Point tr_a, tr_b, tr_c;
    Point cir_a, cir_b;
    Point sq_a, sq_b, sq_c, sq_d;
    /* przykladowy trojkat */
    tr_a.x = 3.0; tr_a.y = 6.0;
    tr_b.x = 0.0; tr_b.y = 0.0;
    tr_c.x = 6.0; tr_c.y = 0.0;
    Figure* triangle = new_triangle(tr_a, tr_b, tr_c);
    /* przykladowe kolo */
    cir_a.x = 0.0; cir_a.y = 0.0;
    cir_b.x = 4.0; cir_b.y = 4.0;
    Figure* circle = new_circle(cir_a, cir_b);
    /* przykladowy kwadrat */
    sq_a.x = 0.0; sq_a.y = 0.0;
    sq_b.x = 0.0; sq_b.y = 4.0;
    sq_c.x = 4.0; sq_c.y = 4.0;
    sq_d.x = 4.0; sq_d.y = 0.0;
    Figure* square = new_square(sq_a, sq_b, sq_c, sq_d);
    /* pole kazdej figury z osobna */
    printf("Pole trojkata: %f\n", area(triangle));
    printf("Pole kola: %f\n", area(circle));
    printf("Pole kwadratu: %f\n", area(square));
    /* suma wszystkich pol*/
    Figure fig_arr[] = {
        *triangle, *circle, *square
    };
    printf("Suma tych trzech pol: %f\n", areas_sum(fig_arr, 3));
    return 0;
}
