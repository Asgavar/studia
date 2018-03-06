#lang racket
(define (sum-of-squares-of-bigger-two a b c)
    (define (square x)
      (* x x))
    (cond
      [(and (<= c a) (<= c b)) (+ (square a) (square b))]
      [(and (<= b a) (<= b c)) (+ (square a) (square c))]
      [else (+ (square b) (square c))]))
