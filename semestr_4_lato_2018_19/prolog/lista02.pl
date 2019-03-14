bin([0]).
bin([1]).
bin([1,0|T]) :-
    bin(T).

rbin([0]).
rbin([1]).

% zadanie 2.
prefix([], _).
prefix([H|T1], [H|T2]) :-
    prefix(T1, T2).

suffix([], _).
suffix([H|T1], [H|T2]) :-
    T1 = T2.
suffix(X, [_|T]) :-
    suffix(X, T).

segment(X, Y) :-
    prefix(X, Y).
segment(X, [_|T]) :-
    segment(X, T).

sublist([], _).
sublist([H|T1], [H|T2]) :-
    sublist(T1, T2).
sublist(X, [_|T]) :-
    sublist(X, T).

% zadanie 3.
iperm([], []).
iperm([Xh|Xt], P) :-
    iperm(Xt, Z),
    select(Xh, P, Z).

sperm([], []).
sperm(X, [H|T]) :-
    select(H, X, Z),
    sperm(Z, T).

% zadanie 4.
monotone([]).
monotone([_]).
monotone([H|T]) :-
    [H] @=< T,
    monotone(T).

lessthan(_, []).
lessthan(X, Y) :-
    X @=< Y.

newiperm([], []).
newiperm([Xh|Xt], P) :-
    newiperm(Xt, Z),
    monotone([Xh|Z]).

newsperm([], []).
newsperm(X, [H|T]) :-
    select(H, X, Z),
    sperm(Z, T),
    monotone([H|T]).
