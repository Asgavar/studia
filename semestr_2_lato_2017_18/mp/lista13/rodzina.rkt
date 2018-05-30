#lang racket

(require racklog)

;; predykat unarny %male reprezentuje zbiór mężczyzn
(define %male
  (%rel ()
        [('adam)]
        [('john)]
        [('joshua)]
        [('mark)]
        [('david)]))

;; predykat unarny %female reprezentuje zbiór kobiet
(define %female
  (%rel ()
        [('eve)]
        [('helen)]
        [('ivonne)]
        [('anna)]))

;; predykat binarny %parent reprezentuje relację bycia rodzicem
(define %parent
  (%rel ()
        [('adam 'helen)]
        [('adam 'ivonne)]
        [('adam 'anna)]
        [('eve 'helen)]
        [('eve 'ivonne)]
        [('eve 'anna)]
        [('john 'joshua)]
        [('helen 'joshua)]
        [('ivonne 'david)]
        [('mark 'david)]))

;; predykat binarny %sibling reprezentuje relację bycia rodzeństwem
(define %sibling
  (%rel (a b c)
        [(a b)
         (%parent c a)
         (%parent c b)]))

;; predykat binarny %sister reprezentuje relację bycia siostrą
(define %sister
  (%rel (a b)
        [(a b)
         (%sibling a b)
         (%female a)]))

;; predykat binarny %ancestor reprezentuje relację bycia przodkiem
(define %ancestor
  (%rel (a b c)
        [(a b)
         (%parent a b)]
        [(a b)
         (%parent a c)
         (%ancestor c b)]))

(define %grandson
  (%rel (a b c)
        [(c a)
         (%parent a b)
         (%parent b c)
         (%male c)]))

(define %cousin
  (%rel (a b a-parent b-parent)
        [(a b)
         (%parent a-parent a)
         (%parent b-parent b)
         (%sibling a-parent b-parent)]))

(define %is_mother
  (%rel (a potential-child)
        [(a)
         (%female a)
         (%parent a potential-child)]))

(define %is_father
  (%rel (a potential-child)
        [(a)
         (%male a)
         (%parent a potential-child)]))

;; czy John jest potomkiem Marka?
(%find-all () (%ancestor 'mark 'john))
;; kto jest potomkiem Adama?
(%find-all (x) (%ancestor 'adam x))
;; kto jest siostrą Ivonne?
(%find-all (x) (%sister x 'ivonne))
;; kto w tej rodzinie ma kuzyna i kim ten kuzyn jest?
(%find-all (x y) (%cousin x y))
