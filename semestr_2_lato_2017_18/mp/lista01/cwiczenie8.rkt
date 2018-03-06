#lang racket

(define (power-close-to b n)
  (define (greater-than? number)
    (if (> number n)
        #t
        #f))
  (define (increment-pow pow)
    (if (greater-than? (expt b pow))
        pow
        (increment-pow (+ pow 1))))
  (increment-pow 1))