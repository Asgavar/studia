#lang racket

;; expressions

(define (const? t)
  (number? t))

(define (op? t)
  (and (list? t)
       (member (car t) '(+ - * /))))

(define (op-op e)
  (car e))

(define (op-args e)
  (cdr e))

(define (op-cons op args)
  (cons op args))

(define (op->proc op)
  (cond [(eq? op '+) +]
        [(eq? op '*) *]
        [(eq? op '-) -]
        [(eq? op '/) /]))

(define (let-def? t)
  (and (list? t)
       (= (length t) 2)
       (symbol? (car t))))

(define (let-def-var e)
  (car e))

(define (let-def-expr e)
  (cadr e))

(define (let-def-cons x e)
  (list x e))

(define (let? t)
  (and (list? t)
       (= (length t) 3)
       (eq? (car t) 'let)
       (let-def? (cadr t))))

(define (let-def e)
  (cadr e))

(define (let-expr e)
  (caddr e))

(define (let-cons def e)
  (list 'let def e))

(define (var? t)
  (symbol? t))

(define (var-var e)
  e)

(define (var-cons x)
  x)

(define (arith/let-expr? t)
  (or (const? t)
      (and (op? t)
           (andmap arith/let-expr? (op-args t)))
      (and (let? t)
           (arith/let-expr? (let-expr t))
           (arith/let-expr? (let-def-expr (let-def t))))
      (var? t)))

;; let-lifted expressions

(define (arith-expr? t)
  (or (const? t)
      (and (op? t)
           (andmap arith-expr? (op-args t)))
      (var? t)))

(define (let-lifted-expr? t)
  (or (and (let? t)
           (let-lifted-expr? (let-expr t))
           (arith-expr? (let-def-expr (let-def t))))
      (arith-expr? t)))

;; generating a symbol using a counter

(define (number->symbol i)
  (string->symbol (string-append "x" (number->string i))))

;; environments (could be useful for something)

(define empty-env
  null)

(define (add-to-env x v env)
  (cons (list x v) env))

(define (find-in-env x env)
  (cond [(null? env) (error "undefined variable" x)]
        [(eq? x (caar env)) (cadar env)]
        [else (find-in-env x (cdr env))]))

;; lifted-inter to dwa elementy: lista let-defów oraz wyrażenie arytmetyczne
(define (lifted-inter? li)
  (and (list? li)
       (= (length li) 2)
       (andmap let-def? (first li))
       (arith-expr? (second li))))

(define (lifted-inter-cons defs aexpr)
  (list defs aexpr))

(define (lifted-inter-let-defs li)
  (first li))

(define (lifted-inter-arith-expr li)
  (second li))

(define (lifted-inter-list? lis)
  (andmap (lifted-inter? lis)))

(define (lifted-inter-list-merge lis operator)
  (displayln "EEE")
  (displayln (map (lambda (li) (lifted-inter-let-defs li))
                  lis))
  (lifted-inter-cons (append (map (lambda (li) (lifted-inter-let-defs li))
                                  lis))
                     (cons operator
                           (append (map (lambda (li) (lifted-inter-arith-expr li))
                                        lis)))))


;; the let-lift procedure

(define (let-lift e)
  (cond [(let? e) (let* ([e-def (let-def e)]
                         [e-def-var (let-def-var e-def)]
                         [e-def-expr (let-def-expr e-def)]
                         [e-expr (let-expr e)])
                    (cond [(and (arith-expr? e-def-expr)  ; trywialny let
                                (arith-expr? e-expr))
                           (lifted-inter-cons (list e-def)
                                              e-expr)]
                          [(and (not (arith-expr? e-def-expr))
                                (arith-expr? e-expr))  ; mniej trywialny let
                           (let ([nested-inter (let-lift e-def-expr)])
                             (lifted-inter-cons (append (lifted-inter-let-defs nested-inter)
                                                        (list (let-def-cons e-def-var
                                                                            (lifted-inter-arith-expr nested-inter))))
                                                e-expr))]
                          [(and (arith-expr? e-def-expr)
                                (not (arith-expr? e-expr)))
                           (let ([nested-inter (let-lift e-expr)])
                             (lifted-inter-cons (append (list e-def)
                                                        (lifted-inter-let-defs nested-inter))
                                                (lifted-inter-arith-expr nested-inter)))]
                          [else (let ([def-expr-inter (let-lift e-def-expr)]
                                      [expr-inter (let-lift e-expr)])
                                  (lifted-inter-cons (append (lifted-inter-let-defs def-expr-inter)
                                                             (list (let-def-cons e-def-var
                                                                                 (lifted-inter-arith-expr def-expr-inter)))
                                                             (lifted-inter-let-defs expr-inter))
                                                     (lifted-inter-arith-expr expr-inter)))]))]
        [(var? e) (lifted-inter-cons '() e)]
        [(const? e) (lifted-inter-cons '() e)]))



;; generacja nowych nazw dla zmiennych
;;
;; świeże nazwy nie są nadawane po kolei, jednak są unikatowe, co dla naszych
;; celów powinno wystarczyć
(define (rename-with-counter expr i)
  (cond [(const? expr) expr]
        [(var? expr) expr]
        [(let? expr) (let-cons (let-def-cons (number->symbol i)
                                             (rename-with-counter (let-def-expr (let-def expr))
                                                                  (+ i 1)))
                               (rename-with-counter (rename-all-occurences (let-def-var (let-def expr))
                                                                           (number->symbol i)
                                                                           (let-expr expr))
                                                    (+ i 2)))]
        [(op? expr) (op-cons (op-op expr) (rename-with-counter-op-args (op-args expr) i))]))

(define (rename-with-counter-op-args args i)
  (if (null? args)
      null
      (cons (rename-with-counter (car args) i)
            (rename-with-counter-op-args (cdr args) (+ i 2)))))

(define (rename-all-occurences from to expr)
  (cond [(const? expr) expr]
        [(var? expr) (if (eq? (var-var expr) from)
                         to
                         expr)]
        [(op? expr) (op-cons (op-op expr)
                             (map (lambda (arg) (rename-all-occurences from to arg))
                                  (op-args expr)))]
        [(let? expr) (let* ([expr-def (let-def expr)]
                            [expr-def-var (let-def-var expr-def)]
                            [expr-def-expr (let-def-expr expr-def)])
                       (if (not (eq? expr-def-var from))
                           ; jeśli nie doszło do kolizji, po prostu podmieniamy dalej
                           (let-cons (let-def-cons expr-def-var
                                                   (rename-all-occurences from to expr-def-expr))
                                     (rename-all-occurences from to (let-expr expr)))
                           ; jeśli doszło, ograniczamy się do wyrażenia w let-defie
                           (let-cons (let-def-cons expr-def-var
                                                   (rename-all-occurences from to expr-def-expr))
                                     (let-expr expr))))]))

(define (gen-new-varnames expr)
  (rename-with-counter expr 0))

(define (run-tests)
  (displayln "rename-all-occurences")
  (displayln (rename-all-occurences 'x 'a '(+ x (let (x (+ x 2)) (- x 1)))))
  (displayln "rename-with-counter-op-args")
  (displayln (rename-with-counter-op-args (op-args '(+ (let (a 2) a)
                                                       (let (b 3) b)
                                                       (let (c 4) c))) 0))
  (displayln "rename-with-counter")
  (displayln (rename-with-counter '(let (p 1) (+ p
                                                 (- 2 p)
                                                 (let (q p) (/ q 2 (let (q 77) q))))) 0))
  (displayln (lifted-inter? '(((x 1) (a 3) (b 14)) (+ x a b))))
  (displayln "let-lift-with-inter")
  ;(displayln (let-lift '(let (x (- 2 (let (z 3) z))) (+ x 2) )))
  (displayln (let-lift '(let (x (let (y 2) y)) x)))
  (displayln (let-lift '(let (x (let (y 2) y)) (let (f x) f))))
  (displayln "lifted-inter-list-merge")
  (displayln (lifted-inter-list-merge '(
                                        ( ((x 1) (y 2))
                                          (+ x y) )
                                        ( ((a 33) (b 74))
                                          a ) )
                                      '*
  )))

(run-tests)
