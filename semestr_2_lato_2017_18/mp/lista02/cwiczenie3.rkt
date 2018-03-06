#lang racket

(define (square x)
  (* x x))

(define (compose f g)
  (λ (x) (f (g x))))

(define (repeated p n)
  (if (= n 0)
      p
      (repeated (compose p p) (- n 1))))
