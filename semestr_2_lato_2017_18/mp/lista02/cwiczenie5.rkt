#lang racket

(define (cont-frac-recursive num den k)
  (define (rec num den k current)
    (if (= k current)
        (/ (num k) (den k))
        (/ (num current) (+ (den current) (rec num den k (+ current 1))))))
  (rec num den k 1))

(define (cont-frac-iter num den k)
  (define (iter num den k current value-so-far)
    (if (= current 1)
        value-so-far
        (iter num den k (- current 1) (/ (num current) (+ (den current) value-so-far)))))
  (iter num den k k 0))