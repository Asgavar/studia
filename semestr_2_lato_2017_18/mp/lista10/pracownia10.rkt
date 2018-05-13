#lang racket

(require rackunit
         "calc.rkt")

(define (def-name p)
  (car p))

(define (def-prods p)
  (cdr p))

(define (rule-name r)
  (car r))

(define (rule-body r)
  (cdr r))

(define (lookup-def g nt)
  (cond [(null? g) (error "unknown non-terminal" g)]
        [(eq? (def-name (car g)) nt) (def-prods (car g))]
        [else (lookup-def (cdr g) nt)]))

(define parse-error 'PARSEERROR)

(define (parse-error? r) (eq? r 'PARSEERROR))

(define (res v r)
  (cons v r))

(define (res-val r)
  (car r))

(define (res-input r)
  (cdr r))

;;

(define (token? e)
  (and (list? e)
       (> (length e) 0)
       (eq? (car e) 'token)))

(define (token-args e)
  (cdr e))

(define (nt? e)
  (symbol? e))

;;

(define (parse g e i)
  (cond [(token? e) (match-token (token-args e) i)]
        [(nt? e) (parse-nt g (lookup-def g e) i)]))

(define (parse-nt g ps i)
  (if (null? ps)
      parse-error
      (let ([r (parse-many g (rule-body (car ps)) i)])
        (if (parse-error? r)
            (parse-nt g (cdr ps) i)
            (res (cons (rule-name (car ps)) (res-val r))
                 (res-input r))))))

(define (parse-many g es i)
  (if (null? es)
      (res null i)
      (let ([r (parse g (car es) i)])
        (if (parse-error? r)
            parse-error
            (let ([rs (parse-many g (cdr es) (res-input r))])
              (if (parse-error? rs)
                  parse-error
                  (res (cons (res-val r) (res-val rs))
                       (res-input rs))))))))

(define (match-token xs i)
  (if (and (not (null? i))
           (member (car i) xs))
      (res (car i) (cdr i))
      parse-error))

;;

(define num-grammar
  '([digit {DIG (token #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)}]
    [numb {MANY digit numb}
          {SINGLE digit}]))

(define (node-name t)
  (car t))

(define (c->int c)
  (- (char->integer c) (char->integer #\0)))

(define (walk-tree-acc t acc)
  (cond [(eq? (node-name t) 'MANY)
         (walk-tree-acc
          (third t)
          (+ (* 10 acc) (c->int (second (second t)))))]
        [(eq? (node-name t) 'SINGLE)
         (+ (* 10 acc) (c->int (second (second t))))]))

(define (walk-tree t)
  (walk-tree-acc t 0))

(define (binop-left-assoc? expr)
  (if (number? expr)
      true
      (and (number? (binop-right expr))
           (binop-left-assoc? (binop-left expr)))))

(define (binop-left-associative expr)
  (if (or (number? expr)
          (binop-left-assoc? expr))
      expr
      (let* ([expr-ops-and-numbers (binop-ops-and-numbers '() '() expr)]
             [expr-ops (car expr-ops-and-numbers)]
             [expr-numbers (cdr expr-ops-and-numbers)]
             [binop-to-start-with (binop-cons (first expr-ops)
                                              (first expr-numbers)
                                              (second expr-numbers))])
        (binop-construct-left-assoc (cdr expr-ops)
                                    (cddr expr-numbers)
                                    binop-to-start-with))))

(define (binop-construct-left-assoc ops numbers expr-so-far)
  (if (null? ops)
      expr-so-far
      (let ([new-ops (cdr ops)]
            [new-numbers (cdr numbers)])
        (binop-construct-left-assoc new-ops
                                    new-numbers
                                    (binop-cons (car ops)
                                                expr-so-far
                                                (car numbers))))))

(define (binop-ops-and-numbers ops numbers expr)
  (if (number? expr)
      (cons ops (append numbers
                        (list expr)))
      (let* ([left-binop (binop-left expr)]
             [right-binop (binop-right expr)]
             [new-ops (append ops (list (binop-op expr)))]
             [left-processed (binop-ops-and-numbers new-ops numbers left-binop)]
             [left-ops (car left-processed)]
             [left-numbers (cdr left-processed)]
             [right-processed (binop-ops-and-numbers left-ops left-numbers right-binop)])
        right-processed)))

;;

(define arith-grammar
  (append num-grammar
     '([add-expr {ADD-MANY   mult-expr (token #\+) arith-expr}]
       [sub-expr {SUB-MANY mult-expr (token #\-) arith-expr}]
       [mult-expr {MULT-MANY base-expr (token #\*) arith-expr}
                  {MULT-SINGLE base-expr}]
       [div-expr {DIV-MANY mult-expr (token #\/) arith-expr}]
       [arith-expr {ARITH-ADD add-expr}
                   {ARITH-SUB sub-expr}
                   {ARITH-DIV div-expr}
                   {ARITH-MULT mult-expr}
                   {ARITH-BASE base-expr}]
       [base-expr {BASE-NUM numb}
                  {PARENS (token #\() arith-expr (token #\))}])))

(define (arith-walk-tree t)
  (cond [(eq? (node-name t) 'MULT-SINGLE)
         (arith-walk-tree (second t))]
        [(member (node-name t) '(ADD-MANY
                                 SUB-MANY
                                 MULT-MANY
                                 DIV-MANY))
         (let* ([appropriate-op (node-name->op-symbol (node-name t))]
                [default-binop (binop-cons appropriate-op
                                           (arith-walk-tree (second t))
                                           (arith-walk-tree (fourth t)))])
           (if (parens-inside? t)
               default-binop
               (binop-left-associative default-binop)))]
        [(eq? (node-name t) 'BASE-NUM)
         (walk-tree (second t))]
        [(eq? (node-name t) 'PARENS)
         (arith-walk-tree (third t))]
        [else (arith-walk-tree (second t))]))

(define (node-name->op-symbol nn)
  (cond [(eq? nn 'ADD-MANY) '+]
        [(eq? nn 'SUB-MANY) '-]
        [(eq? nn 'MULT-MANY) '*]
        [(eq? nn 'DIV-MANY) '/]))

(define caadadr (compose car car cdr car cdr))

(define (parens-inside? t)
  (and (> (length t) 2)
       (let ([left-subtree (second t)]
             [right-subtree (fourth t)])
         (or (eq? (caadr left-subtree) 'PARENS)
             (eq? (caadr right-subtree) 'PARENS)
             (eq? (caadadr left-subtree) 'PARENS)
             (eq? (caadadr right-subtree) 'PARENS)
             (and (>= (length left-subtree) 4)
                  (parens-inside? left-subtree))
             (and (>= (length right-subtree) 4)
                  (parens-inside? right-subtree))
             (parens-inside? (second left-subtree))
             (parens-inside? (second right-subtree))))))

(define (calc s)
 (eval
  (arith-walk-tree
   (car
    (parse
       arith-grammar
       'arith-expr
       (string->list s))))))

;;

(check-equal? (binop-left-associative '(+ 41 (+ 42 (- 43 44))))
              '(- (+ (+ 41 42) 43) 44))
(check-equal? (arith-walk-tree (car (parse arith-grammar
                                           'arith-expr
                                           (string->list "21-90/3"))))
              '(/ (- 21 90) 3))
(check-eq? (calc "1000/50/2") 10)
(check-not-eq? (calc "1000/50/2") 40)
(check-eq? (calc "90-10-20-40-5") 15)
(check-eq? (calc "9-(8-2)") 3)
(check-eq? (calc "2-9-10") -17)
(check-eq? (calc "2*(7-2)") 10)
(check-equal? (calc "88/37/21/14")
              (calc "(((88/37)/21)/14)"))
(check-eq? (calc "2-(3/(4-1))") 1)
