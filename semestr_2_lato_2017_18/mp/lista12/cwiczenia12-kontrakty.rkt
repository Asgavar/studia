#lang racket

(require quickcheck)

(define (tails/c xs)
  (when (null? xs) true)
  (when (not (equal? (cdar xs) (cadr xs))) false)
  (tails/c (cdr xs)))

(define/contract (suffixes xs)
  (let* ([a (new-∀/c 'a)])
    (-> (listof a) (and/c (listof (listof a)) tails/c)))
  (let ([indexes (build-list (+ (length xs) 1) values)])
    (map (λ (n) (list-tail xs n)) indexes)))

(define (square-almost-equal/c what)
  (λ (n) ((almost-equal/c what) (* n n))))

(define (almost-equal/c what)
  (λ (n) (< (dist n what) 0.0001)))

(define/contract (sqrt x)
  (->i ([x (and/c number? (>/c 0))])
       (result (x) (and/c number? (square-almost-equal/c x))))
  (define (improve approx)
    (average (/ x approx) approx))
  (define (good-enough? approx)
    (< (dist x (square approx)) 0.0001))
  (define (iter approx)
    (cond
      [(good-enough? approx) approx]
      [else (iter (improve approx))]))
  (iter 1.0))

(define (dist x y)
  (abs (- x y)))

(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))

(define (all/c pred-func)
  (letrec ([ret-func (λ (xs) (cond [(null? xs) true]
                                   [(not (pred-func (car xs))) false]
                                   [else (ret-func (cdr xs))]))])
    ret-func))

(define/contract (super-filter pred-func xs)
  (->i ([pred-func predicate/c]
        [xs list?])
       (result (pred-func) (and/c list? (all/c pred-func))))
  (filter pred-func xs))

(define-signature monoid^
  ((contracted
    [elem? (-> any/c boolean?)]
    [neutral elem?]
    [oper (-> elem? elem? elem?)])))

(define-unit monoid-ints-with-zero-and-addition@
  (import)
  (export monoid^)
  (define elem? integer?)
  (define neutral 0)
  (define oper +)

  (quickcheck
   (property
    ([first-int arbitrary-integer]
     [second-int arbitrary-integer]
     [third-int arbitrary-integer])
    (= (oper (oper first-int second-int) third-int)
       (oper first-int (oper second-int third-int)))))

  (quickcheck
   (property
    ([some-int arbitrary-integer])
    (= (oper some-int neutral)
       (oper neutral some-int)
       some-int))))

(define-unit monoid-lists-with-null-and-append@
  (import)
  (export monoid^)
  (define elem? list?)
  (define neutral null)
  (define oper append)

  (quickcheck
   (property
    ([first-list (arbitrary-list arbitrary-integer)]
     [second-list (arbitrary-list arbitrary-integer)]
     [third-list (arbitrary-list arbitrary-integer)])
    (equal? (oper (oper first-list second-list) third-list)
            (oper first-list (oper second-list third-list)))))

  (quickcheck
   (property
    ([some-list (arbitrary-list arbitrary-integer)])
    (and (equal? (oper some-list neutral)
                 (oper neutral some-list))
         (equal? (oper some-list neutral)
                 some-list)
         (equal? (oper neutral some-list)
                 some-list)))))

(invoke-unit monoid-ints-with-zero-and-addition@)
(invoke-unit monoid-lists-with-null-and-append@)
