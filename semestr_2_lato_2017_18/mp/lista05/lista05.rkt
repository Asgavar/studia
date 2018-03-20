#lang racket


(define (var? t)
   (symbol? t))


(define (neg? t)
   (and (list? t)
         (= 2 (length t))
         (eq? 'neg (car t))))


(define (conj? t)
   (and (list? t)
         (= 3 (length t))
         (eq? 'conj (car t))))


(define (disj? t)
   (and (list? t)
         (= 3 (length t))
         (eq? 'disj (car t))))


(define (make-neg f)
  (list 'neg f))


(define (neg-subf f)
  (second f))


(define (make-conj f-left f-right)
  (list 'conj f-left f-right))


(define (conj-left f)
  (second f))


(define (conj-right f)
  (third f))


(define (make-disj f-left f-right)
  (list 'disj f-left f-right))


(define (disj-left f)
  (second f))


(define (disj-right f)
  (third f))


(define (free-vars f)
  (cond [(var? f) (list f)]
        [(neg? f) (list (neg-subf f))]
        [(conj? f) (append (free-vars (conj-left f))
                           (free-vars (conj-right f)))]
        [(disj? f) (append (free-vars (disj-left f))
                           (free-vars (disj-right f)))]))


(define super-complicated-formula
  (make-conj (make-disj 'p 'q)
             (make-disj (make-neg 'p)
                        (make-neg 'q))))


;super-complicated-formula
;(free-vars super-complicated-formula)


(define (gen-vals xs)
  (if (null? xs)
      (list null)
      (let*
          ((vss (gen-vals (cdr xs)))
           (x (car xs))
           (vst (map (lambda (vs) (cons (list x true) vs)) vss))
           (vsf (map (lambda (vs) (cons (list x false) vs)) vss)))
      (append vst vsf))))


;(gen-vals '(a b c d))


(define (var-val var vals)
  (if (null? vals)
      (error "Nie dostarczono wartosci:" var)
      (if (eq? (caar vals) var)
          (cadar vals) ; cadar a nie cdar xD
          (var-val var (cdr vals)))))


(define (eval-formula f vals)
  (cond [(var? f) (var-val f vals)]
        [(neg? f) (not (eval-formula (neg-subf f) vals))]
        [(conj? f) (and (eval-formula (conj-left f) vals)
                        (eval-formula (conj-right f) vals))]
        [(disj? f) (or (eval-formula (disj-left f) vals)
                       (eval-formula (disj-right f) vals))]))

;(eval-formula super-complicated-formula
;              '((p #t) (q #t)))
;(eval-formula super-complicated-formula
;              '((p #t) (q #f)))
;(eval-formula (make-disj (make-neg 'p) 'p)
;              '((p #t)))


(define (falsifiable-eval f)
  (define (falsifiable-eval-inner vals-s)
    (if (null? vals-s)
        false
        (if (not (eval-formula f (car vals-s)))
            (car vals-s)
            (falsifiable-eval-inner (cdr vals-s)))))
  
  (let* ([vars (free-vars f)]
         [all-possible-vals (gen-vals vars)])
    (falsifiable-eval-inner all-possible-vals)))

;(falsifiable-eval (make-disj (make-neg 'p) 'p))
;(falsifiable-eval 'p)


(define (nnf? f)
  (cond [(var? f) #t]
        [(neg? f) (var? (neg-subf f))]
        [(conj? f) (and (nnf? (conj-left f))
                        (nnf? (conj-right f)))]
        [(disj? f) (and (nnf? (disj-left f))
                        (nnf? (disj-right f)))]))

;(nnf? 'p)
;(nnf? (make-neg 'q))
;(nnf? (make-neg (make-disj 'r 's)))