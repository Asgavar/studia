#lang racket

;; sygnatura: grafy
(define-signature graph^
  ((contracted
    [graph        (-> list? (listof edge?) graph?)]
    [graph?       (-> any/c boolean?)]
    [graph-nodes  (-> graph? list?)]
    [graph-edges  (-> graph? (listof edge?))]
    [edge         (-> any/c any/c edge?)]
    [edge?        (-> any/c boolean?)]
    [edge-start   (-> edge? any/c)]
    [edge-end     (-> edge? any/c)]
    [has-node?    (-> graph? any/c boolean?)]
    [outnodes     (-> graph? any/c list?)]
    [remove-node  (-> graph? any/c graph?)]
    )))

;; prosta implementacja grafów
(define-unit simple-graph@
  (import)
  (export graph^)

  (define (graph? g)
    (and (list? g)
         (eq? (length g) 3)
         (eq? (car g) 'graph)))

  (define (edge? e)
    (and (list? e)
         (eq? (length e) 3)
         (eq? (car e) 'edge)))

  (define (graph-nodes g) (cadr g))

  (define (graph-edges g) (caddr g))

  (define (graph n e) (list 'graph n e))

  (define (edge n1 n2) (list 'edge n1 n2))

  (define (edge-start e) (cadr e))

  (define (edge-end e) (caddr e))

  (define (has-node? g n) (not (not (member n (graph-nodes g)))))

  (define (outnodes g n)
    (filter-map
     (lambda (e)
       (and (eq? (edge-start e) n)
            (edge-end e)))
     (graph-edges g)))

  (define (remove-node g n)
    (graph
     (remove n (graph-nodes g))
     (filter
      (lambda (e)
        (not (eq? (edge-start e) n)))
      (graph-edges g)))))

;; sygnatura dla struktury danych
(define-signature bag^
  ((contracted
    [bag?       (-> any/c boolean?)]
    [bag-empty? (-> bag? boolean?)]
    [empty-bag  (and/c bag? bag-empty?)]
    [bag-insert (-> bag? any/c (and/c bag? (not/c bag-empty?)))]
    [bag-peek   (-> (and/c bag? (not/c bag-empty?)) any/c)]
    [bag-remove (-> (and/c bag? (not/c bag-empty?)) bag?)])))

;; struktura danych - stos
(define-unit bag-stack@
  (import)
  (export bag^)

  (define (bag? stack-or-not)
    (list? stack-or-not))

  (define (bag-empty? some-stack)
    (null? some-stack))

  (define empty-bag null)

  (define (bag-insert stack-to-extend new-element)
    (cons new-element stack-to-extend))

  (define (bag-peek some-stack)
    (car some-stack))

  (define (bag-remove some-stack)
    (cdr some-stack)))

;; struktura danych - kolejka FIFO
;; do zaimplementowania przez studentów
(define-unit bag-fifo@
  (import)
  (export bag^)

  (struct fifo (input-list output-list))

  (define (make-fifo input-list output-list)
    (if (null? output-list)
        (fifo '() (reverse input-list))
        (fifo input-list output-list)))

  (define (bag? fifo-or-not)
    (fifo? fifo-or-not))

  (define (bag-empty? some-fifo)
    (and (null? (fifo-input-list some-fifo))
         (null? (fifo-output-list some-fifo))))

  (define empty-bag (fifo '() '()))

  (define (bag-insert fifo-to-extend new-element)
    (make-fifo (cons new-element (fifo-input-list fifo-to-extend))
               (fifo-output-list fifo-to-extend)))

  (define (bag-peek some-fifo)
    (car (fifo-output-list some-fifo)))

  (define (bag-remove some-fifo)
    (make-fifo (fifo-input-list some-fifo)
               (cdr (fifo-output-list some-fifo)))))

(define (drain-bag bag-to-be-drained acc)
  (if (bag-empty? bag-to-be-drained)
      acc
      (drain-bag (bag-remove bag-to-be-drained)
                 (cons (bag-peek bag-to-be-drained) acc))))

(define (put-n-things-in-bag bag-to-put-in things)
  (if (null? things)
      bag-to-put-in
      (put-n-things-in-bag (bag-insert bag-to-put-in (car things)) (cdr things))))

;; sygnatura dla przeszukiwania grafu
(define-signature graph-search^
  (search))

;; implementacja przeszukiwania grafu
;; uzależniona od implementacji grafu i struktury danych
(define-unit/contract graph-search@
  (import bag^ graph^)
  (export (graph-search^
           [search (-> graph? any/c (listof any/c))]))
  (define (search g n)
    (define (it g b l)
      (cond
        [(bag-empty? b) (reverse l)]
        [(has-node? g (bag-peek b))
         (it (remove-node g (bag-peek b))
             (foldl
              (lambda (n1 b1) (bag-insert b1 n1))
              (bag-remove b)
              (outnodes g (bag-peek b)))
             (cons (bag-peek b) l))]
        [else (it g (bag-remove b) l)]))
    (it g (bag-insert empty-bag n) '())))

;; otwarcie komponentu grafu
(define-values/invoke-unit/infer simple-graph@)

;; graf testowy
(define test-graph
  (graph
   (list 1 2 3 4)
   (list (edge 1 3)
         (edge 1 2)
         (edge 2 4))))

(define test-graph-2
  (graph
   (list 1 2 3 4 5)
   (list (edge 1 2)
         (edge 2 3)
         (edge 3 4)
         (edge 4 5))))

(define test-graph-3
  (graph
   (list -9 38 88 22 42 14)
   (list (edge -9 42)
         (edge -9 38)
         (edge 42 14)
         (edge 14 22)
         (edge 22 38)
         (edge 38 88))))

;; otwarcie komponentu stosu
;(define-values/invoke-unit/infer bag-stack@)
;; opcja 2: otwarcie komponentu kolejki
(define-values/invoke-unit/infer bag-fifo@)

(define (whatever->boolean whatever)
  (not (not whatever)))

;; testy w Quickchecku
(require quickcheck)

;; test przykładowy: jeśli do pustej struktury dodamy element
;; i od razu go usuniemy, wynikowa struktura jest pusta
(quickcheck
 (property ([s arbitrary-symbol])
           (bag-empty? (bag-remove (bag-insert empty-bag s)))))

;; gdy wrzucimy pewne elementy do torby, to możemy spodziewać się,
;; że je w tej torbie znajdziemy
(quickcheck
 (property ([list-to-put (arbitrary-one-of equal? (list (arbitrary-list arbitrary-char)
                                                        (arbitrary-list arbitrary-string)
                                                        (arbitrary-list arbitrary-symbol)
                                                        (arbitrary-list arbitrary-integer)))])
            (let ([bag-full-of-things (foldl (λ (elem bag-so-far) (bag-insert bag-so-far elem))
                                             empty-bag
                                             list-to-put)])
              (andmap (λ (elem) (whatever->boolean (member elem list-to-put)))
                      (drain-bag bag-full-of-things '())))))

;; uzupełnianie dwóch różnych toreb niezależnie, ale tymi samymi elementami
;; powinno sprawić, że torby te będą od siebie nieodróżnialne pod względem zawartości
(quickcheck
 (property ([element-1 arbitrary-integer]
            [element-2 arbitrary-symbol]
            [element-3 arbitrary-string])
           (let ([bag-1 (bag-insert
                         (bag-insert
                          (bag-insert empty-bag element-1) element-2) element-3)]
                 [bag-2 (bag-insert
                         (bag-insert
                          (bag-insert empty-bag element-1) element-2) element-3)])
             (equal? (drain-bag bag-1 '())
                     (drain-bag bag-2 '())))))

;; ;; własność specyficzna dla stosu:
;; ;; elementy umieszczone na stosie będą ściągane z niego w odwrotnej kolejności
;; ;; uwaga: drain-bag zwraca listę już odwróconą
;; (quickcheck
;;  (property ([elements-to-put (arbitrary-list arbitrary-integer)])
;;            (equal? elements-to-put
;;                    (drain-bag (put-n-things-in-bag empty-bag elements-to-put) '()))))

;; ;; własność specyficzna dla kolejki:
;; ;; elementy umieszczone na kolejce będą ściągane z niej w kolejności układania
;; (quickcheck
;;  (property ([elements-to-put (arbitrary-list arbitrary-integer)])
;;            (equal? (reverse elements-to-put)
;;                    (drain-bag (put-n-things-in-bag empty-bag elements-to-put) '()))))

;; otwarcie komponentu przeszukiwania
(define-values/invoke-unit/infer graph-search@)

;; uruchomienie przeszukiwania na przykładowym grafie
(displayln (search test-graph 1))
;; niezależnie od implementacji przeszukiwania wynikiem powinny być kolejne
;; liczby naturalne
(displayln (search test-graph-2 1))
(displayln (search test-graph-2 2))
(displayln (search test-graph-2 4))
;;
(displayln (search test-graph-3 -9))
(displayln (search test-graph-3 42))
(displayln (search test-graph-3 38))
