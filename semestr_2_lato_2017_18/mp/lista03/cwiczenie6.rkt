#lang racket


(define (n-on-kth-pos xs n k)
  
  (define (leftmost count)
    (define (leftmost-iter accum current)
      (if (= current count)
          accum
          (leftmost-iter (append (list (list-ref xs current)) accum) (+ current 1))))
    (leftmost-iter '() 0))
  
  (append (leftmost k) (list n) (list-tail xs k)))


(define (n-on-each-position xs n)
  (define (iter accum-list k)
    (if (< k 0)
        accum-list
        (let ([new-perm (n-on-kth-pos xs n k)])
          (iter (append (list new-perm) accum-list) (- k 1)))))
  (iter '() (length xs)))


;; TODO
(define (all-permutations xs)
  (if (or (null? xs)
          (= (length xs) 1))
      xs
      (map (lambda (perm) (append (n-on-each-position perm (car xs)) (all-permutations (cdr xs)))))))


(n-on-each-position (list 1 1 1 1) 7)

(all-permutations (list 1 2 3 4))