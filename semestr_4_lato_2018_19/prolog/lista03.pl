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

%% zadanie 2.
count(_, [], 0).
count(Elem, [Elem|Tail], Count) :-
    count(Elem, Tail, PrevCount),
    Count is PrevCount + 1, !.
count(Elem, [_|Tail], Count) :-
    count(Elem, Tail, Count), !.

%% zadanie 3.
% TODO dokończyć
mylength([], 0).
mylength([_|Tail], Length) :-
    mylength(Tail, TailLength),
    Length is TailLength + 1.

%% zadanie 5.
append([LastList], LastList).
append([HeadList|TailList], Appended) :-
    append(TailList, TailAppended),
    append(HeadList, TailAppended, Appended), !.
