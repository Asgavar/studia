#lang racket


(define (reverse xs)
  (if (null? xs)
      xs
      (append (reverse (cdr xs)) (list (car xs)))))


(define (reverse-iter xs)
  (define (iter src dest)
    (if (null? src)
        dest
        (iter (cdr src) (append (list (car src)) dest))))
  (iter xs '()))


(reverse (list 1 2 3 4 5))
(reverse-iter (list 6 7 8 9 10))