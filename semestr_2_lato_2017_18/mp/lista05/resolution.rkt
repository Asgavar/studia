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

;; reprezentacja danych wejściowych (z ćwiczeń)
(define (var? x)
  (symbol? x))

(define (var x)
  x)

(define (var-name x)
  x)

;; przydatne predykaty na zmiennych
(define (var<? x y)
  (symbol<? x y))

(define (var=? x y)
  (eq? x y))

(define (literal? x)
  (and (tagged-tuple? 'literal 3 x)
       (boolean? (cadr x))
       (var? (caddr x))))

(define (literal pol x)
  (list 'literal pol x))

(define (literal-pol x)
  (cadr x))

(define (literal-var x)
  (caddr x))

(define (clause? x)
  (and (tagged-list? 'clause x)
       (andmap literal? (cdr x))))

(define (clause . lits)
  (cons 'clause lits))

(define (clause-lits c)
  (cdr c))

(define (cnf? x)
  (and (tagged-list? 'cnf x)
       (andmap clause? (cdr x))))

(define (cnf . cs)
    (cons 'cnf cs))

(define (cnf-clauses x)
  (cdr x))

;; oblicza wartość formuły w CNF z częściowym wartościowaniem. jeśli zmienna nie jest
;; zwartościowana, literał jest uznawany za fałszywy.
(define (valuate-partial val form)
  (define (val-lit l)
    (let ((r (assoc (literal-var l) val)))
      (cond
       [(not r)  false]
       [(cadr r) (literal-pol l)]
       [else     (not (literal-pol l))])))
  (define (val-clause c)
    (ormap val-lit (clause-lits c)))
  (andmap val-clause (cnf-clauses form)))

;; reprezentacja dowodów sprzeczności

(define (axiom? p)
  (tagged-tuple? 'axiom 2 p))

(define (proof-axiom c)
  (list 'axiom c))

(define (axiom-clause p)
  (cadr p))

(define (res? p)
  (tagged-tuple? 'resolve 4 p))

(define (proof-res x pp pn)
  (list 'resolve x pp pn))

(define (res-var p)
  (cadr p))

(define (res-proof-pos p)
  (caddr p))

(define (res-proof-neg p)
  (cadddr p))

;; sprawdza strukturę, ale nie poprawność dowodu
(define (proof? p)
  (or (and (axiom? p)
           (clause? (axiom-clause p)))
      (and (res? p)
           (var? (res-var p))
           (proof? (res-proof-pos p))
           (proof? (res-proof-neg p)))))

;; procedura sprawdzająca poprawność dowodu
(define (check-proof pf form)
  (define (run-axiom c)
    (displayln (list 'checking 'axiom c))
    (and (member c (cnf-clauses form))
         (clause-lits c)))  ; FIXME
  (define (run-res x cpos cneg)
    (displayln (list 'checking 'resolution 'of x 'for cpos 'and cneg))
    (and (findf (lambda (l) (and (literal-pol l) ; FIXME to chyba nie predykat?
                                 (eq? x (literal-var l))))
                cpos)
         (findf (lambda (l) (and (not (literal-pol l))
                                 (eq? x (literal-var l))))
                cneg)
         (append (remove* (list (literal true x))  cpos)
                 (remove* (list (literal false x)) cneg))))
  (define (run-proof pf)
    (cond
     [(axiom? pf) (run-axiom (axiom-clause pf))]
     [(res? pf)   (run-res (res-var pf)
                           (run-proof (res-proof-pos pf))
                           (run-proof (res-proof-neg pf)))]
     [else        false]))
  (null? (run-proof pf)))


;; reprezentacja wewnętrzna

;; sprawdza posortowanie w porządku ściśle rosnącym, bez duplikatów
(define (sorted? vs)
  (or (null? vs)
      (null? (cdr vs))
      (and (var<? (car vs) (cadr vs))
           (sorted? (cdr vs)))))

(define (sorted-varlist? x)
  (and (list? x)
       (andmap (var? x))
       (sorted? x)))

;; klauzulę reprezentujemy jako parę list — osobno wystąpienia pozytywne i negatywne. Dodatkowo
;; pamiętamy wyprowadzenie tej klauzuli (dowód) i jej rozmiar.
(define (res-clause? x)
  (and (tagged-tuple? 'res-int 5 x)
       (sorted-varlist? (second x))
       (sorted-varlist? (third x))
       (= (fourth x) (+ (length (second x)) (length (third x))))
       (proof? (fifth x))))

(define (res-clause pos neg proof)
  (list 'res-int pos neg (+ (length pos) (length neg)) proof))

(define (res-clause-pos c)
  (second c))

(define (res-clause-neg c)
  (third c))

(define (res-clause-size c)
  (fourth c))

(define (res-clause-proof c)
  (fifth c))

;; przedstawia klauzulę jako parę list zmiennych występujących odpowiednio pozytywnie i negatywnie
(define (print-res-clause c)
  (list (res-clause-pos c) (res-clause-neg c)))

;; sprawdzanie klauzuli sprzecznej
(define (clause-false? c)
  (and (null? (res-clause-pos c))
       (null? (res-clause-neg c))))

;; pomocnicze procedury: scalanie i usuwanie duplikatów z list posortowanych
(define (merge-vars xs ys)
  (cond [(null? xs) ys]
        [(null? ys) xs]
        [(var<? (car xs) (car ys))
         (cons (car xs) (merge-vars (cdr xs) ys))]
        [(var<? (car ys) (car xs))
         (cons (car ys) (merge-vars xs (cdr ys)))]
        [else (cons (car xs) (merge-vars (cdr xs) (cdr ys)))]))

(define (remove-duplicates-vars xs)
  (cond [(null? xs) xs]
        [(null? (cdr xs)) xs]
        [(var=? (car xs) (cadr xs)) (remove-duplicates-vars (cdr xs))]
        [else (cons (car xs) (remove-duplicates-vars (cdr xs)))]))

(define (rev-append xs ys)
  (if (null? xs) ys
      (rev-append (cdr xs) (cons (car xs) ys))))

(define (var-present? v xs)
  (cond [(null? xs) false]
        [(var=? v (car xs)) true]
        [else (var-present? v (cdr xs))]))

(define (var-present-in-both? v xs ys)
  (and (var-present? v xs)
       (var-present? v ys)))

;; zwraca listę zmiennych pozbawioną wszystkich wystąpień zmiennej v
(define (var-cut-from v xs)
  (filter (lambda (x) (not (var=? v x)))
          xs))

(define (ensure-it-is-not-the-end c)
  (if (clause-false? c)
      (raise "Formuła jest sprzeczna")
      c))


;; zwraca zmienną, która występuje zarówno w xs jak i w ys, lub, jeśli takiej zmiennej
;; nie ma: false
(define (repeated-var xs ys)
  (cond [(null? xs) false]
        [(var-present-in-both? (car xs) xs ys) (car xs)]
        [else (repeated-var (cdr xs) ys)]))

;; zwraca odpowiedź na pytanie: "czy istnieje zmienna, która jest w obydwu listach
;; zmiennych klauzuli c?"
(define (clause-trivial? c)
  (not (repeated-var (res-clause-neg c) (res-clause-pos c))))

(define (resolve c1 c2)
  ;; zaczynamy od pobrania odpowiednich elementów klauzul c1 i c2
  (let* ([c1-pos-vars (res-clause-pos c1)]
         [c1-neg-vars (res-clause-neg c1)]
         [c2-pos-vars (res-clause-pos c2)]
         [c2-neg-vars (res-clause-neg c2)]
         [c1-proof (res-clause-proof c1)]
         [c2-proof (res-clause-proof c2)]
         ;; sprawdzamy, czy istnieje zmienna zanegowana w jednej i niezanegowana
         ;; w drugiej klauzuli (albo odwrotnie)
         [pos-in-c1-neg-in-c2 (repeated-var c1-pos-vars c2-neg-vars)]
         [neg-in-c1-pos-in-c2 (repeated-var c1-neg-vars c2-pos-vars)])
    ;; jeśli istnieje, przystępujemy do tworzenia nowej klauzuli (rezolwenty c1 i c2)
    (if (or pos-in-c1-neg-in-c2 neg-in-c1-pos-in-c2)
        (let* ([newborn-proof
                (cond [pos-in-c1-neg-in-c2 (proof-res pos-in-c1-neg-in-c2
                                                      c1-proof c2-proof)]
                      [neg-in-c1-pos-in-c2 (proof-res neg-in-c1-pos-in-c2
                                                      c2-proof c1-proof)])]
               [var-which-repeated
                (cond [pos-in-c1-neg-in-c2 pos-in-c1-neg-in-c2]
                      [neg-in-c1-pos-in-c2 neg-in-c1-pos-in-c2])]
               [c1-pos-stripped (var-cut-from var-which-repeated c1-pos-vars)]
               [c1-neg-stripped (var-cut-from var-which-repeated c1-neg-vars)]
               [c2-pos-stripped (var-cut-from var-which-repeated c2-pos-vars)]
               [c2-neg-stripped (var-cut-from var-which-repeated c2-neg-vars)]
               [newborn-pos (merge-vars c1-pos-stripped c2-pos-stripped)]
               [newborn-neg (merge-vars c1-neg-stripped c2-neg-stripped)])
          (ensure-it-is-not-the-end (res-clause newborn-pos newborn-neg newborn-proof)))
        ;; jeśli nie, zwracamy fałsz
        false)))

(define (resolve-single-prove s-clause checked pending)
  ;; TODO: zaimplementuj!
  ;; Poniższa implementacja działa w ten sam sposób co dla większych klauzul — łatwo ją poprawić!
  (let* ((resolvents   (filter-map (lambda (c) (resolve c s-clause))
                                     checked))
         (sorted-rs    (sort resolvents < #:key res-clause-size)))
    (subsume-add-prove (cons s-clause checked) pending sorted-rs)))

;; wstawianie klauzuli w posortowaną względem rozmiaru listę klauzul
(define (insert nc ncs)
  (cond
   [(null? ncs)                     (list nc)]
   [(< (res-clause-size nc)
       (res-clause-size (car ncs))) (cons nc ncs)]
   [else                            (cons (car ncs) (insert nc (cdr ncs)))]))

;; sortowanie klauzul względem rozmiaru (funkcja biblioteczna sort)
(define (sort-clauses cs)
  (sort cs < #:key res-clause-size))

;; główna procedura szukająca dowodu sprzeczności
;; zakładamy że w checked i pending nigdy nie ma klauzuli sprzecznej
(define (resolve-prove checked pending)
  (cond
   ;; jeśli lista pending jest pusta, to checked jest zamknięta na rezolucję czyli spełnialna
   [(null? pending) (generate-valuation (sort-clauses checked))]
   ;; jeśli klauzula ma jeden literał, to możemy łatwo i efektywnie ją przetworzyć
   [(= 1 (res-clause-size (car pending)))
    (resolve-single-prove (car pending) checked (cdr pending))]
   ;; w przeciwnym wypadku wykonujemy rezolucję z wszystkimi klauzulami już sprawdzonymi, a
   ;; następnie dodajemy otrzymane klauzule do zbioru i kontynuujemy obliczenia
   [else
    (let* ((next-clause  (car pending))
           (rest-pending (cdr pending))
           (resolvents   (filter-map (lambda (c) (resolve c next-clause))
                                     checked))
           (sorted-rs    (sort-clauses resolvents)))
      (subsume-add-prove (cons next-clause checked) rest-pending sorted-rs))]))

;; procedura upraszczająca stan obliczeń biorąc pod uwagę świeżo wygenerowane klauzule i
;; kontynuująca obliczenia. Do uzupełnienia.
(define (subsume-add-prove checked pending new)
  (cond
   [(null? new)                 (resolve-prove checked pending)]
   ;; jeśli klauzula do przetworzenia jest sprzeczna to jej wyprowadzenie jest dowodem sprzeczności
   ;; początkowej formuły
   [(clause-false? (car new))   (list 'unsat (res-clause-proof (car new)))]
   ;; jeśli klauzula jest trywialna to nie ma potrzeby jej przetwarzać
   [(clause-trivial? (car new)) (subsume-add-prove checked pending (cdr new))]
   [else
    ;; TODO: zaimplementuj!
    ;; Poniższa implementacja nie sprawdza czy nowa klauzula nie jest lepsza (bądź gorsza) od już
    ;; rozpatrzonych; popraw to!
    (subsume-add-prove checked (insert (car new) pending) (cdr new))
    ]))

(define (generate-valuation resolved)
  ;; TODO: zaimplementuj!
  ;; Ta implementacja mówi tylko że formuła może być spełniona, ale nie mówi jak. Uzupełnij ją!
  'sat)

;; procedura przetwarzające wejściowy CNF na wewnętrzną reprezentację klauzul
(define (form->clauses f)
  (define (conv-clause c)
    (define (aux ls pos neg)
      (cond
       [(null? ls)
        (res-clause (remove-duplicates-vars (sort pos var<?))
                    (remove-duplicates-vars (sort neg var<?))
                    (proof-axiom c))]
       [(literal-pol (car ls))
        (aux (cdr ls)
             (cons (literal-var (car ls)) pos)
             neg)]
       [else
        (aux (cdr ls)
             pos
             (cons (literal-var (car ls)) neg))]))
    (aux (clause-lits c) null null))
  (map conv-clause (cnf-clauses f)))

(define (prove form)
  (let* ((clauses (form->clauses form)))
    (subsume-add-prove '() '() clauses)))

;; procedura testująca: próbuje dowieść sprzeczność formuły i sprawdza czy wygenerowany
;; dowód/waluacja są poprawne. Uwaga: żeby działała dla formuł spełnialnych trzeba umieć wygenerować
;; poprawną waluację.
(define (prove-and-check form)
  (let* ((res (prove form))
         (sat (car res))
         (pf-val (cadr res)))
    (if (eq? sat 'sat)
        (valuate-partial pf-val form)
        (check-proof pf-val form))))

;; testy

(define test-clause-1
  (res-clause (list 'a 'b) (list 'c) (proof-axiom (clause (literal true 'a)
                                                          (literal true 'b)
                                                          (literal false 'c)))))

(define test-clause-2
  (res-clause (list 'c) (list 'd 'e) (proof-axiom (clause (literal true 'c)
                                                          (literal false 'd)
                                                          (literal false 'e)))))

(resolve test-clause-1 test-clause-2)
