#lang racket


(define (make-rat num den)
  (list num den))


(define (rat-num rat)
  (car rat))


(define (rat-den rat)
  (cdr rat))


(define (rat? rat-or-not)
  (and (not (= (rat-den rat-or-not) 0))
       (let ([numerator (rat-num rat-or-not)]
             [denominator (rat-den rat-or-not)])
         (= (make-rat numerator denominator) rat-or-not))))