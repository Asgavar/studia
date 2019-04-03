%% nieco naciągany predykat bycia drzewem
tree(leaf).
tree(MaybeNode) :-
    MaybeNode = node(L, _, R),
    tree(L),
    tree(R),
    !.
tree(Var) :-
    var(Var).

:- discontiguous insert/3.

%% wyłapywanie błędów
insert(_, Tree, _) :-
    \+ tree(Tree),
    domain_error("A tree", "Something that is not a tree").
insert(_, _, ResultTree) :-
    \+ tree(ResultTree),
    domain_error("A tree", "Something that is not a tree").
insert(_, Tree, ResultTree) :-
    var(Tree),
    var(ResultTree),
    domain_error(aaa, bbb).

%% usunięcie elementu
insert(Elem, Tree, ResultTree) :-
    var(Tree),
    remove(Elem, Tree, ResultTree).

%% wierzchołek zakończony dwoma liściami
remove(Elem, node(leaf, Elem, leaf), leaf) :- !.

%% liść z lewej strony
remove(Elem, node(leaf, Elem, R), R) :- !.

%% liść z prawej strony
remove(Elem, node(L, Elem, leaf), L) :- !.

%% odpowiedni element w korzeniu, ale dwa poddrzewa.
%% szukamy najmniejszego elementu w prawym z nich i zamieniamy.
remove(Elem, node(L, Elem, R), node(L, RMin, RWithoutRMin)) :-
    minel(R, RMin),
    remove(RMin, R, RWithoutRMin),
    !.

remove(Elem, node(L, ElemEncountered, R), node(LResult, ElemEncountered, R)) :-
    Elem @=< ElemEncountered,
    remove(Elem, L, LResult),
    !.

remove(Elem, node(L, ElemEncountered, R), node(L, ElemEncountered, RResult)) :-
    Elem @> ElemEncountered,
    remove(Elem, R, RResult),
    !.

%% remove(12, node(node(leaf, 9, leaf), 12, node(node(leaf, 19, leaf), 21, node(lea f, 25, leaf))), R).

minel(node(leaf, Min, _), Min) :- !.
minel(node(L, _, _), LMin) :-
    minel(L, LMin),
    !.

maxel(node(_, Max, leaf), Max) :- !.
maxel(node(_, _, R), RMax) :-
    max(R, RMax),
    !.

%% wstawienie do liścia
insert(Elem, leaf, node(leaf, Elem, leaf)) :- !.

%% powtarzający się klucz
insert(Elem, node(L, Elem, R), node(L, Elem, R)) :- !.

%% wstawienie z lewej strony
insert(Elem, node(L, ElemEncountered, R), node(LResult, ElemEncountered, R)) :-
    Elem @=< ElemEncountered,
    insert(Elem, L, LResult),
    !.

%% wstawienie z prawej strony
insert(Elem, node(L, ElemEncountered, R), node(L, ElemEncountered, RResult)) :-
    Elem @> ElemEncountered,
    insert(Elem, R, RResult),
    !.

mirror(leaf, leaf).
mirror(node(L, Elem, R), node(RMirr, Elem, LMirr)) :-
    mirror(L, LMirr),
    mirror(R, RMirr),
    !.
