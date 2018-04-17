#lang racket

(define (lcons x f)
  (cons x f))

(define (lhead l)
  (car l))

(define (ltail l)
  ((cdr l)))

(define (nats-from m)
  (lcons
   m
   (lambda () (nats-from (+ m 1)))))

(define nats
  (nats-from 0))

(define (take n l)
  (if (or (null? l) (= n 0))
      null
      (cons (lhead l)
            (take (- n 1) (ltail l)))))

(define (filter p l)
  (cond [(null? l) null]
        [(p (lhead l))
         (lcons (lhead l)
                (lambda ()
                  (filter p (ltail l))))]
        [else (filter p (ltail l))]))

(define (prime? n)
  (define (div-by? m)
    (cond [(= m n) true]
          [(= (modulo n m) 0) false]
          [else (div-by? (+ m 1))]))
  (if (< n 2)
      false
      (div-by? 2)))

(define (fib-from-nth n)
  (if (or (= n 1)
          (= n 2))
      (lcons 1
             (lambda () (fib-from-nth (+ n 1))))
      (lcons (+ (lhead (fib-from-nth (- n 1)))
                (lhead (fib-from-nth (- n 2))))
             (lambda () (fib-from-nth (+ n 1))))))

(define fib
  (fib-from-nth 1))

(define (integers-from n)
  (let ([next (if (> n 0)
                  (* -1 n)
                  (+ 1 (abs n)))])
    (lcons n
           (lambda () (integers-from next)))))

(define integers
  (integers-from 0))

(take 20 fib)
(take 20 integers)
