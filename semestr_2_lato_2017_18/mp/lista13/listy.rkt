#lang racket

(require racklog)

(define %my-append
  (%rel (x xs ys zs)
        [(null ys ys)]
        [((cons x xs) ys (cons x zs))
         (%my-append xs ys zs)]))

(define %my-member
  (%rel (x xs y)
        [(x (cons x xs))]
        [(y (cons x xs))
         (%my-member y xs)]))

(define %select
  (%rel (x xs y ys)
        [(x (cons x xs) xs)]
        [(y (cons x xs) (cons x ys))
         (%select y xs ys)]))

;; prosta rekurencyjna definicja
(define %simple-length
  (%rel (x xs n m)
        [(null 0)]
        [((cons x xs) n)
         (%simple-length xs m)
         (%is n (+ m 1))]))

;; test w trybie +- (działa)
(%find-all (a) (%simple-length (list 1 2) a))
;; test w trybie ++ (działa)
(%find-all () (%simple-length (list 1 2) 2))
;; test w trybie -+ (1 odpowiedź, pętli się)
(%which (xs) (%simple-length xs 2))
;; test w trybie -- (nieskończona liczba odpowiedzi)
(%which (xs a) (%simple-length xs a))

;; definicja zakładająca, że długość jest znana
(define %gen-length
  (%rel (x xs n m)
        [(null 0) !]
        [((cons x xs) n)
         (%is m (- n 1))
         (%gen-length xs m)]))
;; test w trybie ++ (działa)
(%find-all () (%gen-length (list 1 2) 2))
;; test w trybie -+ (działa)
(%find-all (xs) (%gen-length xs 2))

(define %sublist
  (%rel (x xs ys)
        [(null ys)]
        [((cons x xs) (member x ys))
         (%sublist (cdr xs) (cdr (member x ys)))]))

(%find-all (xs ys) (%= ys (%append xs xs ys)))
(%which (x) (%select x '(1 2 3 4) '(1 2 4)))
(%which (ys) (%append '(1 2 3) ys '(1 2 3 4 5)))

(define (list->num digit-list)
  (if (null? digit-list) 0
      (+ (* (car digit-list)
            (expt 10 (- (length digit-list) 1)))
         (list->num (cdr digit-list)))))

;; (define %send-more-money
;;   (%rel (D E M N O R S Y)
;;         [(= (+ (list->num (list S E N D))
;;                (list->num (list M O R E)))
;;             (list->num (list M O N E Y)))
;;          (%sublist '(0 1 2 3 4 5 6 7 8 9)
;;                    (list D E M N O R S Y))]))
