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


(define (all-but-kth xs k)
  (define (iter accum current)
    (if (= current (length xs))
        accum
        (if (not (= current k))
            (iter (append accum (list (list-ref xs current))) (+ current 1))
            (iter accum (+ current 1)))))
  (iter '() 0))


(define (all-permutations xs)
  (define (perm-iter accum curr-index)
    (if (= curr-index (length xs))
        accum
        (perm-iter (append accum (n-on-each-position (all-but-kth xs curr-index) (list-ref xs curr-index))) (+ curr-index 1))))
  (perm-iter '() 0))


;(n-on-each-position (list 1 1 1 1) 7)

;(all-but-kth (list 1 2 3 4) 2)

(all-permutations (list 1 2 3 4))
(all-permutations '())
(all-permutations (list 42))