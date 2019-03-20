%% zadanie 1.
exp(Base, 1, Base).
exp(Base, Exp, Result) :-
    PrevExp is Exp - 1,
    exp(Base, PrevExp, Prev),
    Result is Base * Prev, !.

exp(Base, 1, Mod, Res) :-
    Res is Base mod Mod.
exp(Base, Exp, Mod, Result) :-
    PrevExp is Exp - 1,
    exp(Base, PrevExp, Prev),
    Result is (Base * Prev) mod Mod, !.

factorial(1, 1).
factorial(N, M) :-
    PrevN is N - 1,
    factorial(PrevN, PrevM),
    M is N * PrevM, !.

digit(0).
digit(1).
digit(2).
digit(3).
digit(4).
digit(5).
digit(6).
digit(7).
digit(8).
digit(9).

concat_number(Digits, Num) :-
    reverse(Digits, DigitsReversed),
    concat_number_(DigitsReversed, Num).

concat_number_([Digit], Digit) :-
    digit(Digit).
concat_number_([DigitsHead|DigitsTail], Num) :-
    digit(DigitsHead),
    concat_number_(DigitsTail, NumSoFar),
    Num is (NumSoFar*10) + DigitsHead, !.

% TODO
decimal_(Num, [Num]) :-
    digit(Num).

filter([], []).
filter([HNum|TNum], LPos) :-
    HNum < 0,
    filter(TNum, LPos).
filter([HNum|TNum], [HPos|TPos]) :-
    HNum >= 0,
    HNum = HPos,
    filter(TNum, TPos).

%% zadanie 2.
count(_, [], 0).
count(Elem, [Head|Tail], Count) :-
    unifiable(Elem, Head, _),
    count(Elem, Tail, PrevCount),
    Count is PrevCount + 1, !.
count(Elem, [_|Tail], Count) :-
    count(Elem, Tail, Count), !.

%% zadanie 3.
mylength([], 0).
mylength([_|Tail], Length) :-
    var(Length),
    mylength(Tail, TailLength),
    Length is TailLength + 1.
mylength([_|Tail], Length) :-
    PrevLength is Length - 1,
    mylength(Tail, PrevLength), !.

%% zadanie 5.
append([LastList], LastList).
append([HeadList|TailList], Appended) :-
    append(TailList, TailAppended),
    append(HeadList, TailAppended, Appended), !.

%% zadanie 6.
puzzle(U, S, A, R, P, E, C) :-
    sublist(AllNums, [0,1,2,3,4,5,6,7,8,9]),
    permutation(AllNums, [U,S,A,R,P,E,C]),
    concat_number([U,S,A], Usa),
    concat_number([U,S,S,R], Ussr),
    concat_number([P,E,A,C,E], Peace),
    Peace is Usa + Ussr,
    U \= 0,
    P \= 0, !.

%% backport z listy drugiej
sublist([], _).
sublist([H|T1], [H|T2]) :-
    sublist(T1, T2).
sublist(X, [_|T]) :-
    sublist(X, T).

%% zadanie 7.
sum(X, 0, X).
sum(0, Y, Y).
