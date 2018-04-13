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

;; lifted-atom to dwa elementy: lista let-defów oraz wyrażenie arytmetyczne
(define (lifted-atom? la)
  (and (list? la)
       (= (length la) 2)
       (andmap let-def? (first la))
       (arith-expr? (second la))))

(define (lifted-atom-cons defs aexpr)
  (list defs aexpr))

(define (lifted-atom-let-defs la)
  (first la))

(define (lifted-atom-arith-expr la)
  (second la))

(define (lifted-atom-list? las)
  (andmap (lifted-atom? las)))

;; the let-lift procedure

(define (let-lift e)
  ;; TODO: Zaimplementuj!
  (error "nie zaimplementowano!")
  )

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
                       ; jeśli nie doszło do kolizji, po prostu podmieniamy dalej
                       (if (not (eq? expr-def-var from))
                           (let-cons (let-def-cons expr-def-var
                                                   (rename-all-occurences from to expr-def-expr))
                                     (rename-all-occurences from to (let-expr expr)))
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
  (displayln (lifted-atom? '(((x 1) (a 3) (b 14)) (+ x a b)))))

(run-tests)
