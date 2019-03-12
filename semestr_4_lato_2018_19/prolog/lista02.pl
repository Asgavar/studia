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
iperm(X, [H|T]) :-
    iperm(Z, T),
    select(H, X, Z).

sperm([], []).
sperm([Xh|Xt], P) :-
    select(Xh, P, Z),
    sperm(Xt, Z).

% zadanie 4.
monotone([]).
monotone([_]).
monotone([A,B|T]) :-
    @=<(A, B),
    monotone(T).

newiperm([], []).
newiperm(X, [H|T]) :-
    iperm(Z, T),
    select(H, X, Z).

newsperm([], []).
newsperm([Xh|Xt], P) :-
    select(Xh, P, Z),
    sperm(Xt, Z).

newsort(X, Y) :-
    iperm(X, Y),
    monotone(Y).
