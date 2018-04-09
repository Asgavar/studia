#lang racket

(define (const? t)
  (number? t))

(define (binop? t)
  (and (list? t)
       (= (length t) 3)
       (member (car t) '(+ - * /))))

(define (binop-op e)
  (car e))

(define (binop-left e)
  (cadr e))

(define (binop-right e)
  (caddr e))

(define (binop-cons op l r)
  (list op l r))

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

(define (hole? t)
  (eq? t 'hole))

(define (arith/let/holes? t)
  (or (hole? t)
      (const? t)
      (and (binop? t)
           (arith/let/holes? (binop-left  t))
           (arith/let/holes? (binop-right t)))
      (and (let? t)
           (arith/let/holes? (let-expr t))
           (arith/let/holes? (let-def-expr (let-def t))))
      (var? t)))

(define (num-of-holes t)
  (cond [(hole? t) 1]
        [(const? t) 0]
        [(binop? t)
         (+ (num-of-holes (binop-left  t))
            (num-of-holes (binop-right t)))]
        [(let? t)
         (+ (num-of-holes (let-expr t))
            (num-of-holes (let-def-expr (let-def t))))]
        [(var? t) 0]))

(define (arith/let/hole-expr? t)
  (and (arith/let/holes? t)
       (= (num-of-holes t) 1)))

(define (cons-distinct new-el els)
  (if (andmap (lambda (e) (not (eq? new-el e)))
              els)
      (cons new-el els)
      els))

(define (append-distinct xs ys)
  (if (null? xs)
      ys
      (cons-distinct (car xs) (append-distinct (cdr xs) ys))))

(define (hole-context e)
  (cond [(hole? e)  '()]
        [(var? e)   '()]
        [(const? e) '()]
        [(let? e) (cond [(hole? (let-def-expr (let-def e))) '()]
                        [(arith/let/hole-expr? (let-expr e)) (cons-distinct (let-def-var (let-def e))
                                                                            (hole-context (let-expr e)))]
                        [else '()])]
        [(binop? e) (append-distinct (hole-context (binop-left e))
                                     (hole-context (binop-right e)))]))

(define (test)
  (and (equal? (hole-context '(let (x hole)
                                (let (y 7) (+ x y)))) '())
       (equal? (hole-context (let-cons (let-def-cons 'p 7)
                                       'hole))
               '(p))
       (equal? (hole-context (binop-cons '/
                                         (let-cons (let-def-cons 'invisible 42)
                                                   (binop-cons '+ 1 'invisible))
                                         'hole))
               '())
       (equal? (hole-context (binop-cons '+ 1 'hole))
               '())
       (equal? (sort (hole-context (let-cons (let-def-cons 'a_one 1)
                                             (let-cons (let-def-cons 'b_two 2)
                                                       (let-cons (let-def-cons 'c_three 3)
                                                                 (let-cons (let-def-cons 'b_two 22)
                                                                           'hole)))))
                     symbol<?)
               '(a_one b_two c_three))
       (equal? (hole-context (let-cons (let-def-cons 'x 'hole)
                                       (let-cons (let-def-cons 'y 7)
                                                 (binop-cons '+ 'x 'y))))
               '())))

;(test)
