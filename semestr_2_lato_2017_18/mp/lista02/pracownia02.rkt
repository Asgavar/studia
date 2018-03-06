#lang racket

;; Artur Juraszek
;; Podczas tworzenia rozwiązania nie używałem źródeł informacji
;; innych niż treści poleceń ćwiczeń 6., 7. i 10.

(define (approx-cont-frac num den)

  (define (close-enough? f1 f2)
    (let ([tolerable-diff 0.000001])
      (< (abs (- f1 f2)) tolerable-diff)))

  (define (approx current-index a-2 b-2 a-1 b-1)
    (define previous-value (/ a-1 b-1))
    (let* ([curr-num (num current-index)]
           [curr-den (den current-index)]
           [curr-a (+ (* curr-den a-1) (* curr-num a-2))]
           [curr-b (+ (* curr-den b-1) (* curr-num b-2))])
      (define current-value (/ curr-a curr-b))
      (if (close-enough? current-value previous-value)
          ;; zgodnie z poleceniem zwracamy pierwszy wyraz, ktorego "nastepnik"
          ;; jest odpowiednio bliski, a nie ten nastepnik
          previous-value
          (approx (+ current-index 1) a-1 b-1 curr-a curr-b))))

  (approx 1 1 0 0 1))

;; test na podstawie ćwiczenia 6. -> 1/φ
(approx-cont-frac (lambda (i) 1.0) (lambda (i) 1.0))
;; test na podstawie ćwiczenia 7. -> wartość π
(+ 3
   (approx-cont-frac (lambda (i) (expt (- (* 2 i) 1) 2)) (lambda (i) 6.0)))