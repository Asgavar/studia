#lang racket


(define (make-point x y)
  (cons x y))


(define (point-x p)
  (car p))


(define (point-y p)
  (cdr p))


(define (point? p)
  (let ([x (point-x p)]
        [y (point-y p)])
    (= (make-point x y) p)))


(define (make-vect begin end)
  (cons begin end))


(define (vect-begin v)
  (car v))


(define (vect-end v)
  (cdr v))


(define (vect? p)
  (let ([begin (vect-begin p)]
        [end (vect-end p)])
    (= (make-point begin end) p)))



(define (square x)
  (* x x))


(define (vect-length v)
  (let* ([x1 (point-x (vect-begin v))]
         [y1 (point-y (vect-begin v))]
         [x2 (point-x (vect-end v))]
         [y2 (point-y (vect-end v))]
         [x-diff (- x1 x2)]
         [y-diff (- y1 y2)])
    (sqrt (+ (square x-diff) (square y-diff)))))


(define (vect-scale v k)
  
  (define (point-multiply p)
    (let ([x (point-x p)]
          [y (point-y p)])
      (make-point (* x k) (* y k))))
  
  (let ([begin (vect-begin v)]
        [end (vect-end v)])
    (make-vect begin (point-multiply end))))


(define (vect-translate v p)

  (define (point-add p x-value y-value)
    (let ([x (point-x p)]
          [y (point-y p)])
      (make-point (+ x x-value) (+ y y-value))))
  
  (let* ([p-x (point-x p)]
         [p-y (point-y p)]
         [v-begin (vect-begin v)]
         [v-end (vect-end v)]
         [begin-x (point-x v-begin)]
         [begin-y (point-y v-begin)]
         [x-diff (- p-x begin-x)]
         [y-diff (- p-y begin-y)])
    (make-vect p (point-add v-end x-diff y-diff))))


(define (display-point p)
  (display "(")
  (display (point-x p))
  (display ", ")
  (display (point-y p))
  (display ")"))


(define (display-vect v)
  (display "[")
  (display-point (vect-begin v))
  (display ", ")
  (display-point (vect-end v))
  (display "]"))


(define p1 (make-point 0 0))
(define p2 (make-point 3 4))

(define example-vect (make-vect p1 p2))
(display "początkowy wektor:\n")
(display-vect example-vect)
(newline)
(vect-length example-vect)

(define example-times-3 (vect-scale example-vect 3))
(display "po przeskalowaniu x3:\n")
(display-vect example-times-3)
(newline)
(vect-length example-times-3)

(define moved-begin (make-point 7 7))
(define example-moved (vect-translate example-vect moved-begin))
(display "po takim przesunięciu, żeby jego początek był w (7, 7):\n")
(display-vect example-moved)
(newline)
(vect-length example-moved)