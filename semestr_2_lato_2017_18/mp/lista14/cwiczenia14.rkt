#lang racket

(define (make-cycle some-list)
  (define (link-tail-with-head head current-head)
    (if (null? (mcdr current-head))
        (set-mcdr! current-head head)
        (link-tail-with-head head (mcdr current-head))))
  (link-tail-with-head some-list some-list))

(define mutant
  (mcons 1 (mcons 2 (mcons 3 (mcons 4 null)))))

(displayln mutant)

(make-cycle mutant)

(displayln mutant)

(define (print-and-hang hopefully-cycle-list)
  (displayln (mcar hopefully-cycle-list))
  (print-and-hang (mcdr hopefully-cycle-list)))

;; xD
(define (has-cycle? some-list)
  (let ([already-visited null]
        [was-a-cycle false])
    (map (λ (elem) (begin (if (member elem already-visited)
                              (set! was-a-cycle true)
                              (begin (set! already-visited
                                           (cons elem already-visited))))))
         some-list)
    was-a-cycle))

(define one (list 1 2 3))
(define two (cons 1 (cons 2 (cons 3 one))))

(has-cycle? one)
(has-cycle? two)

(define (make-monitored proc)
  (define call-count 0)
  (define decorated-proc
    (λ arg-list (begin (set! call-count (+ 1 call-count))
                       (apply proc arg-list))))
  (define (control-panel command)
    (cond [(eq? command 'how-many?) call-count]
          [(eq? command 'reset) (set! call-count 0)]))
  (cons decorated-proc control-panel))

(define mm (make-monitored +))

((car mm) 1 2 3)
((cdr mm) 'reset?)
((cdr mm) 'reset)
((cdr mm) 'how-many?)

(define (bucket-sort list-to-sort)
  (let* ([max-key (max-list (map (λ (elem) (car elem)) list-to-sort))]
         [buckets (make-vector max-key '())])
    (map (λ (elem) (let* ([elem-key (- (car elem) 1)]
                          [prev-bucket-val (vector-ref buckets elem-key)])
                     (vector-set! buckets elem-key
                                  (append prev-bucket-val (list elem)))))
         list-to-sort)
    (unflatten-key-value-pairs (flatten (vector->list buckets)))))

(define (max-list some-list)
  (define (max-list-iter current-head current-max)
    (if (null? current-head)
        current-max
        (if (> (car current-head) current-max)
            (max-list-iter (cdr current-head) (car current-head))
            (max-list-iter (cdr current-head) current-max))))
  (max-list-iter some-list (car some-list)))

(define (unflatten-key-value-pairs xs)
  (define (aux remaining acc)
    (if (null? remaining)
        acc
        (append (list (cons (first remaining)
                            (second remaining)))
                (unflatten-key-value-pairs (cddr xs)))))
  (aux xs '()))

(bucket-sort (list (cons 42 'aa) (cons 1 'x) (cons 3 'x) (cons 1 'a)))
