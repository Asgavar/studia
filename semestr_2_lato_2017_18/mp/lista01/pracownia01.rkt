#lang racket

(define (cube-root number acceptable-relative-error)
  (define (between? number lower higher)
    (and (> number lower) (< number higher)))
  (cond
    [(not (between? acceptable-relative-error 0 100))
      (raise "Niepoprawna wartosc dopuszczalnego bledu")])
  (define epsilon (abs (* (/ acceptable-relative-error 100) number)))
  (define (cube n)
    (* n n n))
  (define (abs-diff a b)
    (abs (- a b)))
  (define (good-enough? approx)
    (<= (abs-diff (cube approx) number) epsilon))
  (define (improve-approx approx)
    (/ (+ (/ number (expt approx 2)) (* 2 approx)) 3))
  (define (iter approx)
    (if (good-enough? approx)
      approx
      (iter (improve-approx approx))))
  (cond
    [(= number 0) 0]
    [else (iter 1.0)]))

; wartoscia powinny byc okolice 42
(cube-root 74088 5)
; teraz wartosc powinna byc blizsza 42 niz wczesniej
(cube-root 74088 0.1)
; pierwiastek z 0 obliczamy z perfekcyjna dokladnoscia!
(cube-root 0 5)
; stopien pierwiastka jest nieparzysty, wiec mozemy go wyliczyc dla l. ujemnych
(cube-root -27 2)
; w tym przypadku iter powinien zakonczyc dzialanie bez zaglebiania sie
; sam w siebie ani razu
(cube-root 8 87.5)
; ale w tym juz nie
(cube-root 8 87.4)
; kilka przypadkowych sprawdzen
(cube-root -64 0.00001)
(cube-root 64 0.00001)
(cube-root 63 0.00001)
(cube-root 65 0.00001)
; na koniec powinien zostac wyrzucony wyjatek
(cube-root 27 -1)
