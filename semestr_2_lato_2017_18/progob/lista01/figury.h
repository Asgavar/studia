#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

enum FigureType {
    TRIANGLE,
    CIRCLE,
    SQUARE
};

typedef struct {
    float x;
    float y;
} Point;

typedef struct {
    enum FigureType fig_type;
    Point alpha;
    Point beta;
    Point gamma;
    Point delta;
} Figure;

float distance(Point a, Point b) {
    float x_diff = a.x - b.x;
    float y_diff = a.y - b.y;
    return sqrt(pow(x_diff, 2) + pow(y_diff, 2));
}

float triangle_area (Point alpha, Point beta, Point gamma) {
    Point base_middle;
    base_middle.x = (beta.x + gamma.x) / 2;
    base_middle.y = (beta.y + gamma.y) / 2;
    float height = distance(base_middle, alpha);
    float base_length = distance(beta, gamma);
    return base_length * height * 1/2;
}

float circle_area(Point alpha, Point beta) {
    float radius = distance(alpha, beta);
    return M_PI * pow(radius, 2);
}

float square_area(Point alpha, Point beta, Point gamma, Point delta) {
    float side_length = distance(alpha, beta);
    return pow(side_length, 2);
}

float area(Figure* f) {
    switch (f->fig_type) {
        case TRIANGLE:
            return triangle_area(f->alpha, f->beta, f->gamma);
        case CIRCLE:
            return circle_area(f->alpha, f->beta);
        case SQUARE:
            return square_area(f->alpha, f->beta, f->gamma, f->delta);
    }
}

void move(Figure* f, float x, float y) {
    Point* vertices[] = {
        &f->alpha, &f->beta, &f->gamma, &f->delta
    };
    short vertex_count;
    switch (f->fig_type) {
        case TRIANGLE:
            vertex_count = 3;
            break;
        case CIRCLE:
            vertex_count = 2;
            break;
        case SQUARE:
            vertex_count = 4;
            break;
    }
    for(short i = 0; i < vertex_count; i++) {
        vertices[i]->x += x;
        vertices[i]->y += y;
    }
}

float areas_sum(Figure* f, int size) {
    float sum = 0;
    for (int i = 0; i < size; i++)
        sum += area(f+i);  // czemu f[i] nie dziala?
    return sum;
}

bool points_overlap(Point a, Point b){
    return (a.x == b.x && a.y == b.y);
}

void abort_because_overlapping() {
    printf("Wierzcholki zachodza na siebie\n");
    abort();
}

Figure* new_triangle(Point alpha, Point beta, Point gamma) {
    if (points_overlap(alpha, beta) ||
        points_overlap(beta, gamma) ||
        points_overlap(alpha, gamma)) {
        abort_because_overlapping();
    }
    Figure* new_fig = malloc(sizeof(Figure));
    new_fig->fig_type = TRIANGLE;
    new_fig->alpha = alpha;
    new_fig->beta = beta;
    new_fig->gamma = gamma;
    return new_fig;
}

Figure* new_circle(Point alpha, Point beta) {
    if (points_overlap(alpha, beta)) {
        abort_because_overlapping();
    }
    Figure* new_fig = malloc(sizeof(Figure));
    new_fig->fig_type = CIRCLE;
    new_fig->alpha = alpha;
    new_fig->beta = beta;
    return new_fig;
}

Figure* new_square(Point alpha, Point beta, Point gamma, Point delta) {
    Point vertices[] = {
        alpha, beta, gamma, delta
    };
    for (short i = 0; i < 4; i++) {
        for (short ii = 0; ii < 4; ii++) {
            if (i != ii && points_overlap(vertices[i], vertices[ii])) {
                abort_because_overlapping();
            }
        }
    }
    float sides[4];
    sides[0] = distance(alpha, beta);
    sides[1] = distance(beta, gamma);
    sides[2] = distance(gamma, delta);
    sides[3] = distance(delta, alpha);
    float proper_distance = (sides[0] + sides[1] + sides[2] + sides[3]) / 4;
    for (int i = 0; i < 4; i++) {
        if (sides[i] != proper_distance) {
            printf("Kwadrat nie jest kwadratem\n");
            abort();
        }
    }
    Figure* new_fig = malloc(sizeof(Figure));
    new_fig->fig_type = SQUARE;
    new_fig->alpha = alpha;
    new_fig->beta = beta;
    new_fig->gamma = gamma;
    new_fig->delta = gamma;
    return new_fig;
}
