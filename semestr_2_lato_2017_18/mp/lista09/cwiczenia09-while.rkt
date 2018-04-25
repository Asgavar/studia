#lang racket

;; pomocnicza funkcja dla list tagowanych o określonej długości

(define (tagged-tuple? tag len p)
  (and (list? p)
       (= (length p) len)
       (eq? (car p) tag)))

(define (tagged-list? tag p)
  (and (pair? p)
       (eq? (car p) tag)
       (list? (cdr p))))

;;
;; WHILE
;;

; memory

(define empty-mem
  null)

(define (set-mem x v m)
  (cond [(null? m)
         (list (cons x v))]
        [(eq? x (caar m))
         (cons (cons x v) (cdr m))]
        [else
         (cons (car m) (set-mem x v (cdr m)))]))

(define (get-mem x m)
  (cond [(null? m) 0]
        [(eq? x (caar m)) (cdar m)]
        [else (get-mem x (cdr m))]))

; arith and bools

(define (const? t)
  (number? t))

(define (op? t)
  (and (list? t)
       (member (car t) '(+ - * / = > >= < <= mod))))

(define (op-op e)
  (car e))

(define (op-args e)
  (cdr e))

(define (op->proc op)
  (cond [(eq? op '+) +]
        [(eq? op '*) *]
        [(eq? op '-) -]
        [(eq? op '/) /]
        [(eq? op '=) =]
        [(eq? op '>) >]
        [(eq? op '>=) >=]
        [(eq? op '<)  <]
        [(eq? op '<=) <=]
        [(eq? op 'mod) modulo]))

(define (var? t)
  (symbol? t))

(define (eval-arith e m)
  (cond [(var? e) (get-mem e m)]
        [(op? e)
         (apply
          (op->proc (op-op e))
          (map (lambda (x) (eval-arith x m))
               (op-args e)))]
        [(const? e) e]))

;;

(define (assign? t)
  (and (list? t)
       (= (length t) 3)
       (eq? (second t) ':=)))

(define (assign-var e)
  (first e))

(define (assign-expr e)
  (third e))

(define (if? t)
  (tagged-tuple? 'if 4 t))

(define (if-cond e)
  (second e))

(define (if-then e)
  (third e))

(define (if-else e)
  (fourth e))

(define (while? t)
  (tagged-tuple? 'while 3 t))

(define (while-cond t)
  (second t))

(define (while-expr t)
  (third t))

(define (inc? e)
  (and (list? e)
       (= (length e) 2)
       (eq? (car e) 'inc)))

(define (inc-var e)
  (second e))

(define (dec? e)
  (and (list? e)
       (= (length e) 2)
       (eq? (car e) 'dec)))

(define (dec-var e)
  (second e))

(define (for? e)
  (and (tagged-tuple? 'for 5 e)
       (assign? (second e))))

(define (for-assignment e)
  (second e))

(define (for-condition e)
  (third e))

(define (for-op-after-each e)
  (fourth e))

(define (for-expression e)
  (fifth e))

(define (block? t)
  (list? t))

;;

(define (eval e m)
  (cond [(assign? e)
         (set-mem
          (assign-var e)
          (eval-arith (assign-expr e) m)
          m)]
        [(if? e)
         (if (eval-arith (if-cond e) m)
             (eval (if-then e) m)
             (eval (if-else e) m))]
        [(while? e)
         (if (eval-arith (while-cond e) m)
             (eval e (eval (while-expr e) m))
             m)]
        [(inc? e) (set-mem (inc-var e)
                           (+ (get-mem (inc-var e) m) 1)
                           m)]
        [(for? e) (letrec ([assignment (for-assignment e)]
                           [condition (for-condition e)]
                           [op-after-each (for-op-after-each e)]
                           [expr (for-expression e)]
                           [f (λ (current-mem) (if (eval-arith condition current-mem)
                                                   (f (eval op-after-each
                                                            (eval expr current-mem)))
                                                   current-mem))])
                           (f (eval assignment m)))]
        [(block? e)
         (if (null? e)
             m
             (eval (cdr e) (eval (car e) m)))]))

(define (run e)
  (eval e empty-mem))

(define (transform-for-to-while expr)
  (cond [(assign? expr) expr]
        [(if? expr) (list 'if (if-cond expr)
                          (transform-for-to-while (if-then expr))
                          (transform-for-to-while (if-else expr)))]
        [(while? expr) (list 'while
                             (while-cond expr)
                             (transform-for-to-while (while-expr expr)))]
        [(for? expr) (list (for-assignment expr)
                           (list 'while (for-condition expr)
                                 (list (transform-for-to-while (for-expression expr))
                                       (for-op-after-each expr))))]
        [else expr]))

;;

(define fact10
  '( (i := 10)
     (r := 1)
     (while (> i 0)
       ( (r := (* i r))
         (i := (- i 1)) ))))

(define (computeFact10)
  (run fact10))

(define (fib n)
  `((index := 0)
     (prev := 1)
     (prevprev := 1)
     (current := 1)
     (while (< index ,n)
       ((newprev := current)
         (current := (+ prev prevprev))
         (prevprev := prev)
         (prev := newprev)
         (index := (+ index 1))))))

(define (first-n-primes-sum n)
  `((sum := 0)
    (prime-count := 0)
    (current := 2)
    (while (< prime-count n)
      (is-prime := 1)
      (divisor := 2)
      (while (< divisor current)
        (current-modulo-divisor := (mod current divisor))
        (if (= current-modulo-divisor 0)
            (nop := 111)
            (is-prime := 0)))
      (if (= is-prime 1)
          ((sum := (+ sum i))
           (prime-count := (+ prime-count 1)))
          (sum := sum))
      (current := (+ current 1)))))

(define (variables-used program-text)
  (let ([state-after-running (run program-text)])
    (map (λ (var) (car var)) state-after-running)))
