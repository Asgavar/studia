#lang racket


(define (insert xs n)
  (if (and (null? (cdr xs)) (<= (car xs) n))
      (append xs (list n))
      (if (>= (car xs) n)
          (append (list n) xs)
          (append (list (car xs)) (insert (cdr xs) n)))))


(define (insertion-sort xs)
  (define (iter src dest)
    (if (null? src)
        dest
        (iter (cdr src) (insert dest (car src)))))
  (iter (cdr xs) (list (car xs))))


(define example-list (list 1 2 3 5 6 7))
(insert example-list 4)

(insertion-sort (list 88 37 42 7))
(insertion-sort (list 0 0 0 0))
(insertion-sort (list 1 2 3))
(insertion-sort (list 6 5 4))