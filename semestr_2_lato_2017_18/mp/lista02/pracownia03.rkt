#lang racket

;; Artur Juraszek
;; W rozwiązaniu użyłem fragmentów zaprezentowanego na wykładzie kodu (oznaczonych przez (*)),
;; swoich rozwiązań poprzednich ćwiczeń z listy 2., oraz [1] do potwierdzenia
;; swoich obserwacji nt ilości złożeń average-dump i wyciągnięcia z nich wniosków.
;;
;; [1] https://github.com/kenspirit/SICP/blob/master/c-1/1.45-nth-root.md

;; (*)
(define (average-damp func)
  (lambda (x) (/ (+ x (func x)) 2)))


;; (*)
(define (fix-point func x)

  (define (close-enough? x y)
    (< (abs (- x y)) 0.000001))
  
  (let ([y (func x)])
   (if (close-enough? x y)
       x
       (fix-point func y))))


(define (repeated func how-many)
  (if (= how-many 0)
      (lambda (x) x)
      (compose func (repeated func (- how-many 1)))))


(define (nth-root x n)

  ;; n-krotne złożenie average-damp
  (define (nth-average-damp func n)
    ((repeated average-damp n) func))

  ;; wygląda na to, ze ilość potrzebnych zlożeń jest równa logarytmowi przy podst. 2
  ;; z n zaokrąglonemu w dół, gdzie n jest potęgą do której podnosimy
  (define (necessary-repeats n)
    (floor (log n 2)))
  
  (define (initial-func y)
    (/ x (expt y (- n 1))))
  
  (let ([avg-damp-depth (necessary-repeats n)])
    (fix-point (nth-average-damp initial-func avg-damp-depth) 1.0)))


;; testy przeprowadzałem ręcznie zmieniając wartość parametru avg-damp-depth
(printf "2^2\n")
(nth-root 4 2)
(printf "2^3\n")
(nth-root 8 3)
;; granica dla depth = 1
(printf "2^4\n")
(nth-root 16 4)
(printf "2^5\n")
(nth-root 32 5)
(printf "2^6\n")
(nth-root 64 6)
(printf "2^7\n")
(nth-root 128 7)
;; granica dla depth = 2
(printf "2^8\n")
(nth-root 256 8)
(printf "2^9\n")
(nth-root 512 9)
(printf "2^10\n")
(nth-root 1024 10)
(printf "2^11\n")
(nth-root 2048 11)
(printf "2^12\n")
(nth-root 4096 12)
;; granica dla depth = 2
(printf "2^13\n")
(nth-root (expt 2 13) 13)
(printf "2^14\n")
(nth-root (expt 2 14) 14)
(printf "2^15\n")
(nth-root (expt 2 15) 15)
;; granica dla depth = 3
(printf "2^16\n")
(nth-root (expt 2 16) 16)
(printf "2^17\n")
(nth-root (expt 2 17) 17)
(printf "2^18\n")
(nth-root (expt 2 18) 18)
(printf "2^19\n")
(nth-root (expt 2 19) 19)

