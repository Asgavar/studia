% zadanie 1.
mortal(X) :-
    human(X).
human(socrates).

% zadanie 2.
male(adam).
male(john).
male(mark).
male(joshua).
male(david).
female(eve).
female(helen).
female(ivonne).
female(anna).

parent(adam, john).
parent(adam, helen).
parent(adam, ivonne).
parent(adam, anna).
parent(adam, mark).
parent(eve, john).
parent(eve, helen).
parent(eve, ivonne).
parent(eve, anna).
parent(eve, mark).

parent(john, joshua).
parent(helen, joshua).

parent(ivonne, david).
parent(mark, david).

sibling(X, Y) :-
    parent(Parent, X),
    parent(Parent, Y).

sister(X, Y) :-
    sibling(X, Y),
    female(Y).

grandson(X, Y) :-
    parent(Z, X),
    parent(Y, Z).

cousin(X, Y) :-
    parent(A, X),
    parent(B, Y),
    sibling(A, B).

descendant(Younger, Older) :-
    parent(Older, Younger).
descendant(Younger, Older) :-
    parent(P, Younger),
    descendant(P, Older).

is_mother(X) :-
    parent(X, _),
    female(X).

is_father(X) :-
    parent(X, _),
    male(X).

% zadanie 3.
directly(wroclaw, warszawa).
directly(wroclaw, krakow).
directly(wroclaw, szczecin).
directly(szczecin, lublin).
directly(szczecin, gniezno).
directly(warszawa, katowice).
directly(gniezno, gliwice).
directly(lublin, gliwice).

connection(M1, M2) :-
    directly(M1, M2).
connection(M1, M2) :-
    directly(M1, M3),
    connection(M3, M2).

with_one(M1, M2) :-
    directly(M1, M3),
    directly(M3, M2).

with_max_two(M1, M2) :-
    directly(M1, M2).
with_max_two(M1, M2) :-
    with_one(M1, M2).
with_max_two(M1, M2) :-
    directly(M1, M3),
    with_one(M3, M2).


% zadanie 4.
append([], X, X).
append([H|T], X, [H|Y]) :-
    append(T, X, Y).

% zadanie 5.
select(H, [H|T], T).
select(X, [H|T], [H|S]) :-
    select(X, T, S).

% zadanie 6.
%% append(X, Y, _), append(X, X, Y).
%% select(Removed, [a,b,c,d], [a,c,d]).
%% append([a,b,c], X, [a,b,c,d,e]).

% zadanie 7.
even([]).
even(X) :-
    append([_,_], T, X),
    even(T).

palindrom([]).
palindrom([_]).
palindrom([H|T]) :-
    append(M, [H], T),
    palindrom(M).

singleton([_]).

head(H, L) :-
    append([H], _, L).

last(L, H) :-
    append(_, [H], L).

tail(T, L) :-
    append([_], T, L).

init(L, T) :-
    append(T, [_], L).

prefix([], _).
prefix([H|T1], [H|T2]) :-
    prefix(T1, T2).

suffix(_, []).
% TODO
