#lang racket

(require rackunit)

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

; arith and bool expressions: syntax and semantics

(define (const? t)
  (number? t))

(define (true? t)
  (eq? t 'true))

(define (false? t)
  (eq? t 'false))

(define (op? t)
  (and (list? t)
       (member (car t) '(+ - * / = > >= < <= not and or mod))))

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
        [(eq? op 'not) not]
        [(eq? op 'and) (lambda x (andmap identity x))]
        [(eq? op 'or) (lambda x (ormap identity x))]
        [(eq? op 'mod) modulo]))

(define (var? t)
  (symbol? t))

(define (eval-arith e m)
  (cond [(true? e) true]
        [(false? e) false]
        [(var? e) (get-mem e m)]
        [(rand? e) (rand-result-result ((rand (eval-arith (rand-upto e) m))
                                        (seed-current m)))]
        [(op? e)
         (apply
          (op->proc (op-op e))
          (map (lambda (x) (eval-arith x m))
               (op-args e)))]
        [(const? e) e]))

(define (eval-arith-mem-after e m)
  (if (not (rand? e))
      m
      (seed-update (rand-result-newseed ((rand (eval-arith (rand-upto e) m))
                                         (seed-current m))) m)))

;; syntax of commands

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

(define (rand? e)
  (tagged-tuple? 'rand 2 e))

(define (block? t)
  (list? t))

;; state

(define (res v s)
  (cons v s))

(define (res-val r)
  (car r))

(define (res-state r)
  (cdr r))

;; psedo-random generator

(define initial-seed
  123456789)

(define (rand max)
  (lambda (i)
    (let ([v (modulo (+ (* 1103515245 i) 12345) (expt 2 32))])
      (res (modulo v max) v))))

(define (rand-upto rand-expr)
  (second rand-expr))

(define (rand-result-result rr)
  (car rr))

(define (rand-result-newseed rr)
  (cdr rr))

(define seed-magic-var '__seed__)

(define (seed-current m)
  (get-mem seed-magic-var m))

(define (seed-update newseed m)
  (set-mem seed-magic-var newseed m))

;; WHILE interpreter

(define (old-eval e m)
  (cond [(assign? e)
         (set-mem
          (assign-var e)
          (eval-arith (assign-expr e) m)
          (eval-arith-mem-after (assign-expr e) m))]
        [(if? e)
         (let ([newmem (eval-arith-mem-after (if-cond e) m)])
           (if (eval-arith (if-cond e) m)
               (old-eval (if-then e) newmem)
               (old-eval (if-else e) newmem)))]
        [(while? e)
         (let ([newmem (eval-arith-mem-after (while-cond e) m)])
           (if (eval-arith (while-cond e) m)
               (old-eval e (old-eval (while-expr e) newmem))
               newmem))]
        [(block? e)
         (if (null? e)
             m
             (old-eval (cdr e) (old-eval (car e) m)))]))

(define (eval e m seed)
  (let ([mem-for-old-eval (set-mem '__seed__ seed m)])
    (old-eval e mem-for-old-eval)))

(define (run e)
  (eval e empty-mem initial-seed))

;;

(define fermat-test
  '{(iteration-counter := 0)
    (was-prime := true)

    (while (< iteration-counter k)

      {(randomly-chosen := 0)
       (while (< randomly-chosen 2)
         (randomly-chosen := (rand (- n 2))))

       (randchos-raised-to-n-minus-1 := randomly-chosen)
       (power-counter := 1)
       (while (< power-counter (- n 1))
         {(randchos-raised-to-n-minus-1 := (* randchos-raised-to-n-minus-1
                                              randomly-chosen))
          (power-counter := (+ 1 power-counter))})

       (if (not (= 1 (mod randchos-raised-to-n-minus-1 n)))
           (was-prime := false)
           (was-prime := was-prime))  ; nop
       (iteration-counter := (+ 1 iteration-counter))})

    (if was-prime
        (composite := false)
        (composite := true))})


(define (probably-prime? n k) ; check if a number n is prime using
                              ; k iterations of Fermat's primality
                              ; test
  (let ([memory (set-mem 'k k
                (set-mem 'n n empty-mem))])
    (not (get-mem
           'composite
           (eval fermat-test memory initial-seed)))))

(check-equal? (probably-prime? 17 3) true)
(check-equal? (probably-prime? 22 4) false)
(check-equal? (probably-prime? 23 4) true)
(check-equal? (probably-prime? 42 17) false)
(check-equal? (probably-prime? 37 21) true)
(check-equal? (probably-prime? 88 14) false)

(check-equal? (run '(rrrrr := (rand 42)))
              (run '(rrrrr := (rand (+ 41 1)))))

(check-equal? (run '{(ab := (rand 4321))
                     (cd := (rand ab))})
              (run '{(ab := (rand 4321))
                     (cd := (rand ab))}))

(check-not-equal? (run '(x := (rand 99999)))
                  (run '{(x := (rand 99999))
                         (x := (rand 99999))}))
