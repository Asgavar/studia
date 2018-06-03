#lang racket

(require racklog)

;; transpozycja tablicy zakodowanej jako lista list
(define (transpose xss)
  (cond [(null? xss) xss]
        ((null? (car xss)) (transpose (cdr xss)))
        [else (cons (map car xss)
                    (transpose (map cdr xss)))]))

;; procedura pomocnicza
;; tworzy listę n-elementową zawierającą wyniki n-krotnego
;; wywołania procedury f
(define (repeat-fn n f)
  (if (eq? 0 n) null
      (cons (f) (repeat-fn (- n 1) f))))

;; tworzy tablicę n na m elementów, zawierającą świeże
;; zmienne logiczne
(define (make-rect n m)
  (repeat-fn m (lambda () (repeat-fn n _))))

;; predykat binarny
;; (%row-ok xs ys) oznacza, że xs opisuje wiersz (lub kolumnę) ys
(define %row-ok
  (%rel (x x-minus-one xs y ys)
        [((cons x xs) (cons '* ys))
         (%= x 1)
         (%row-ok (cons 0 xs) ys)]
        [((cons x xs) (cons '* (cons '* ys)))
         (%> x 1)
         (%is x-minus-one (- x 1))
         (%row-ok (cons x-minus-one xs) (cons '* ys))]
        [(null ys)]
        [('(0) null)]
        [((cons 0 xs) (cons '_ ys))
         (%row-ok xs ys)]
        [((cons x xs) (cons '_ ys))
         (%> x 0)
         (%row-ok (cons x xs) ys)]))

(define %all-rows-ok
  (%rel (all-rows-numbers all-rows-symbols first-row-symbols first-row-numbers)
        [(null null)]
        [((cons first-row-numbers all-rows-numbers)
          (cons first-row-symbols all-rows-symbols))
         (%row-ok first-row-numbers first-row-symbols)
         (%all-rows-ok all-rows-numbers all-rows-symbols)]))

;; funkcja rozwiązująca zagadkę
(define (solve rows cols)
  (define board (make-rect (length cols) (length rows)))
  (define tboard (transpose board))
  (define ret (%which (xss yss)
                      (%= xss board)
                      (%= yss tboard)
                      (%all-rows-ok rows board)
                      (%all-rows-ok cols tboard)))
  (and ret (cdar ret)))

(displayln (%which () (%row-ok '(1 2 3 4)
                               '(_ * _ * * _ _ _ * * * _ * * * *))))

;; testy
(equal? (solve '((2) (1) (1)) '((1 1) (2)))
        '((* *)
          (_ *)
          (* _)))

(equal? (solve '((2) (2 1) (1 1) (2)) '((2) (2 1) (1 1) (2)))
        '((_ * * _)
          (* * _ *)
          (* _ _ *)
          (_ * * _)))
