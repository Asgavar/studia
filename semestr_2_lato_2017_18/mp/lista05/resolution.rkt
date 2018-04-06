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
         (clause-lits c)))
  (define (run-res x cpos cneg)
    (displayln (list 'checking 'resolution 'of x 'for cpos 'and cneg))
    (and (findf (lambda (l) (and (literal-pol l)
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

;; czy zmienna występuje w liście xs?
(define (var-present? v xs)
  (cond [(null? xs) false]
        [(var=? v (car xs)) true]
        [else (var-present? v (cdr xs))]))

;; czy zmienna występuje w obydwu listach, xs i ys?
(define (var-present-in-both? v xs ys)
  (and (var-present? v xs)
       (var-present? v ys)))

;; zwraca listę zmiennych pozbawioną wszystkich wystąpień zmiennej v
(define (var-cut-from v xs)
  (filter (lambda (x) (not (var=? v x)))
          xs))

;; zwraca zmienną, która występuje zarówno w xs jak i w ys, lub, jeśli takiej zmiennej
;; nie ma: false
(define (repeated-var xs ys)
  (cond [(null? xs) false]
        [(var-present-in-both? (car xs) xs ys) (car xs)]
        [else (repeated-var (cdr xs) ys)]))

;; zwraca odpowiedź na pytanie: "czy istnieje zmienna, która jest w obydwu listach
;; zmiennych klauzuli c?"
(define (clause-trivial? c)
  (not (not (repeated-var (res-clause-neg c) (res-clause-pos c)))))

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
          (res-clause newborn-pos newborn-neg newborn-proof))
        ;; jeśli nie, zwracamy fałsz
        false)))

(define (resolve-single-prove s-clause checked pending)
  ;(displayln (map (lambda (c) (if (resolve c s-clause)
  ;                     (resolve c s-clause)
  ;                     (c)))
  ;     checked))
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

;; czy klauzula c1 jest łatwiejsza od klauzuli c2?
;; tzn czy wszystkie zmienne zawarte w c2 są też w c1 z taką samą wartością logiczną?
(define (clause-easier-than? c1 c2)
  (let* ([c1-pos (res-clause-pos c1)]
         [c1-neg (res-clause-neg c1)]
         [c2-pos (res-clause-pos c2)]
         [c2-neg (res-clause-neg c2)])
    (and (andmap (lambda (x) (var-present? x c1-pos))
                 c2-pos)
         (andmap (lambda (x) (var-present? x c1-neg))
                 c2-neg))))

;; jeśli c jest łatwiejsza od którejś z klauzul w cs, zwraca 'throw-it-out.
;; zwraca listę klauzul z cs, które są łatwiejsze od c, być może jest to pusta lista
(define (easier-than-list c cs)
  (define (inner todo acc)
    (cond [(null? todo) acc]
          [clause-easier-than? c (car cs) 'throw-it-out]
          [(clause-easier-than? (car cs) c) (inner (cdr todo) (insert (car cs) acc))]
          [else (inner (cdr todo) acc)]))
  (inner cs '()))

;; procedura upraszczająca stan obliczeń biorąc pod uwagę świeżo wygenerowane klauzule i
;; kontynuująca obliczenia.
(define (subsume-add-prove checked pending new)
  (cond
   [(null? new)                 (resolve-prove checked pending)]
   ;; jeśli klauzula do przetworzenia jest sprzeczna to jej wyprowadzenie jest dowodem sprzeczności
   ;; początkowej formuły
   [(clause-false? (car new))   (list 'unsat (res-clause-proof (car new)))]
   ;; jeśli klauzula jest trywialna to nie ma potrzeby jej przetwarzać
   [(clause-trivial? (car new)) (subsume-add-prove checked pending (cdr new))]
   [else
    (let ([checked-easier (easier-than-list (car new) checked)]
          [pending-easier (easier-than-list (car new) pending)])
      (cond [(or (eq? checked-easier 'throw-it-out)
                 (eq? pending-easier 'throw-it-out))
             (subsume-add-prove checked pending (cdr new))] ; wyrzucamy klauzulę
            [else (subsume-add-prove checked-easier
                                     (insert (car new) pending-easier)
                                     (cdr new))]))]))
    ;(subsume-add-prove checked (insert (car new) pending) (cdr new))]))

;; zwraca dowolną (prawie, pierwszą) zmienną zawartą w klauzuli c.
;; wiemy, że c nie może być pusta, więc możemy sobie pozwolić na takiego ifa
(define (take-any-var c)
  (if (null? (res-clause-pos c))
      (literal #f (car (res-clause-neg c)))
      (literal #t (car (res-clause-pos c)))))

;; procedura przeznaczona dla klauzul jednoelementowych, w obecnej implementacji
;; działa tak samo jak procedura dla klauzul wieloelementowych
(define (take-only-var c)
  (take-any-var c))

;; jeśli literał v występuje w klauzuli c jako zmienna o takim samym wartościowaniu,
;; jest ona kandydatem do usunięcia - procedura ta zwróci wtedy symbol
;; 'already-satisfied.
;; w przeciwnym wypadku - niezmienioną klauzulę c
(define (ease-one v c)
  (let ([side-to-search (if (literal-pol v)
                            (res-clause-pos c)
                            (res-clause-neg c))])
    (if (var-present? (literal-var v) side-to-search)
        'already-satisfied
        c)))

;; zwraca listę klauzul oczyszczoną względem literału v
(define (ease-all-in-list v cs)
  (sort-clauses (filter (lambda (c) (not (eq? c 'already-satisfied)))
          (map (lambda (cc) (ease-one v cc))
               cs))))

(define (generate-valuation resolved)
  ;; opierając się na tym, że klauzule w resolved są posortowane względem ilości
  ;; posiadanych w sobie zmiennych:
  ;; 1) dopóki wśród klauzul do przetworzenia są klauzule jednoelementowe pobieramy
  ;; ich wartość
  ;; 2) w momencie dojścia do klauzul o rozmiarze większym niż 1 pobieramy
  ;; dowolną z ich zmiennych
  ;; 3) po każdej operacji dodania nowej zwartościowanej zmiennej do finalnego zbioru
  ;; wykonujemy "ułatwienie" wszystkich już przetworzonych klauzul
  (define (inner-gen to-process acc)
    (if (null? to-process)
        acc
        (let* ([first-clause (car to-process)]
               [new-var (cond [(= (res-clause-size first-clause) 1)
                               (take-only-var first-clause)]
                              [else (take-any-var first-clause)])]
               [easiered-to-process (ease-all-in-list new-var (cdr to-process))])
          (inner-gen (sort-clauses easiered-to-process) (cons new-var acc)))))
  (list 'sat (inner-gen resolved '())))

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

;; testy i eksperymenty

(define test-clause-1
  (res-clause (list 'a 'b) (list 'c) (proof-axiom (clause (literal true 'a)
                                                          (literal true 'b)
                                                          (literal false 'c)))))
(define test-clause-2
  (res-clause (list 'c) (list 'd 'e) (proof-axiom (clause (literal true 'c)
                                                          (literal false 'd)
                                                          (literal false 'e)))))
(define test-clause-3
  (res-clause (list 'x 'y) (list 'x) (proof-axiom (clause (literal true 'x)
                                                          (literal true 'y)
                                                          (literal false 'x)))))

(resolve test-clause-1 test-clause-2)  ; rezolwenta powinna być pozbawiona zm. c
(resolve test-clause-1 test-clause-3)  ; nie rezolwują się
(resolve test-clause-2 test-clause-3)  ; również się nie rezolwują

(clause-trivial? test-clause-3)  ; jest trywialna, zmienna x się powtarza
(clause-trivial? test-clause-2)  ; nie jest trywialna w
(clause-trivial? test-clause-1)  ; również nie jest trywialna

(axiom-clause (res-clause-proof test-clause-1))
(axiom-clause (res-clause-proof test-clause-2))
(axiom-clause (res-clause-proof test-clause-3))

;; sprawdźmy, czy przykładowy wygenerowany dowód jest poprawny syntaktycznie.
;; check-proof określi go jako #f, jednak słusznie, ponieważ nie dowodzi on
;; sprzeczności tej formuły (w ogóle nie jest ona sprzeczna)
(let* ([c1-c2-resolvent (resolve test-clause-1 test-clause-2)]
       [proof-of-this-resolvent (res-clause-proof c1-c2-resolvent)]
       [clause-1-in-cnf (axiom-clause (res-clause-proof test-clause-1))]
       [clause-2-in-cnf (axiom-clause (res-clause-proof test-clause-2))]
       [initial-cnf (cnf clause-1-in-cnf clause-2-in-cnf)])
  (displayln (proof? proof-of-this-resolvent))
  (displayln (check-proof proof-of-this-resolvent initial-cnf)))

;; sprawdźmy teraz co się stanie, jeśli zaserwujemy programowi formułę sprzeczną
(define test-contr-1
  (res-clause (list 'p) '() (proof-axiom (clause (literal true 'p)))))
(define test-contr-2
  (res-clause '() (list 'p) (proof-axiom (clause (literal false 'p)))))

(resolve test-contr-1 test-contr-2)

(define test-pending-sat
  (list test-clause-1 test-clause-2 test-clause-3))

(define test-pending-contradictory
  (list test-contr-1 test-contr-2))

(displayln "resolve-prove dla formuły sprzecznej:")
(resolve-prove '() test-pending-contradictory)
(displayln "resolve-prove dla formuły spełnialnej:")
(resolve-prove '() test-pending-sat)

;; to powinna być klauzula trywialna
(clause-trivial? (clause (literal #t 'h)
                         (literal #f 'h)))

;; to jedyna zmienna w test-contr-1, więc powinno się poddać ją "ułatwieniu""
(displayln (ease-one (literal #t 'p) test-contr-1))
(displayln (ease-one (literal #t 'p) test-contr-2)) ; formuła bez zmian
(displayln (ease-one (literal #t 'x) test-clause-3)) ; tak jak test-contr-1

;; wynikiem jest klauzula <c lub -d lub -e>, ponieważ zmienna a
;; występuje zarówno w test-clause-1 jak i rezolwencie obydwu tych klauzul
(displayln (ease-all-in-list (literal #t 'a)
                             (list test-clause-1
                                   test-clause-2
                                   (resolve test-clause-1 test-clause-2))))
