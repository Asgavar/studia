#lang racket

(define (inc n)
  (+ n 1))

;;; ordered elements
(define (make-elem pri val)
  (cons pri val))

(define (elem-priority x)
  (car x))

(define (elem-val x)
  (cdr x))

;;; leftist heaps (after Okasaki)

;; data representation
(define leaf 'leaf)

(define (leaf? h) (eq? 'leaf h))

(define (hnode? h)
  (and (list? h)
       (= 5 (length h))
       (eq? (car h) 'hnode)
       (natural? (caddr h))))

(define (make-node elem heap-a heap-b)
  (let* ([rank-a (rank heap-a)]
         [rank-b (rank heap-b)]
         [new-node-rank (+ (min rank-a rank-b) 1)])
    (if (<= rank-b rank-a) ; to satisfy the leftist invariant without swapping
        (list 'hnode elem new-node-rank heap-a heap-b)
        (list 'hnode elem new-node-rank heap-b heap-a))))

(define (node-elem h)
  (second h))

(define (node-left h)
  (fourth h))

(define (node-right h)
  (fifth h))

(define (hord? p h)
  (or (leaf? h)
      (<= p (elem-priority (node-elem h)))))

(define (heap? h)
  (or (leaf? h)
      (and (hnode? h)
           (heap? (node-left h))
           (heap? (node-right h))
           (<= (rank (node-right h))
               (rank (node-left h)))
           (= (rank h) (inc (rank (node-right h))))
           (hord? (elem-priority (node-elem h))
                  (node-left h))
           (hord? (elem-priority (node-elem h))
                  (node-right h)))))

(define (rank h)
  (if (leaf? h)
      0
      (third h)))

;; operations

(define empty-heap leaf)

(define (heap-empty? h)
  (leaf? h))

(define (heap-insert elt heap)
  (heap-merge heap (make-node elt leaf leaf)))

(define (heap-min heap)
  (node-elem heap))

(define (heap-pop heap)
  (heap-merge (node-left heap) (node-right heap)))

(define (heap-merge h1 h2)
  (cond
    [(leaf? h1) h2]
    [(leaf? h2) h1]
    [(> (elem-priority (node-elem h1))
        (elem-priority (node-elem h2)))
     (heap-merge h2 h1)] ; so we can later assume that h1's rank is lower
    [else
     (let* ([new-root (node-elem h1)]
            [left-subtree-of-root (node-left h1)]
            [right-subtree-of-root (node-right h1)]
            [newly-merged-rightside (heap-merge right-subtree-of-root h2)])
       (make-node new-root left-subtree-of-root newly-merged-rightside))]))

;;; heapsort. sorts a list of numbers.
(define (heapsort xs)
  (define (popAll h)
    (if (heap-empty? h)
        null
        (cons (elem-val (heap-min h)) (popAll (heap-pop h)))))
  (let ((h (foldl (lambda (x h)
                    (heap-insert (make-elem x x) h))
            empty-heap xs)))
    (popAll h)))

;;; check that a list is sorted (useful for longish lists)
(define (sorted? xs)
  (cond [(null? xs)              true]
        [(null? (cdr xs))        true]
        [(<= (car xs) (cadr xs)) (sorted? (cdr xs))]
        [else                    false]))

;;; generate a list of random numbers of a given length
(define (randlist len max)
  (define (aux len lst)
    (if (= len 0)
        lst
        (aux (- len 1) (cons (random max) lst))))
  (aux len null))

;;; Testy.

(define fixt1 (heapsort '(8 7 4 3 2)))
(define fixt2 (heapsort '(1 2 3 4 5 6 7 8)))
(define fixt3 (heapsort '(0 0 0 0)))
(define fixt4 (heapsort '(-37 -88 42)))
(define fixt5 (heapsort '(99 98 97 13)))

fixt1
fixt2
fixt3
fixt4
fixt5

(and [sorted? fixt1]
     [sorted? fixt2]
     [sorted? fixt3]
     [sorted? fixt4]
     [sorted? fixt5])