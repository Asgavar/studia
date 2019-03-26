flatten([], []) :- !.
flatten([H|T], Flat) :-
    !,
    flatten(H, FlatHead),
    flatten(T, FlatTail),
    append(FlatHead, FlatTail, Flat).
flatten(X, [X]).

numlist([], []).

numlist([s|X], [0|Y]) :-
    numlist(X, Y).
numlist([s|X], [2|Y]) :-
    numlist(X, Y).
numlist([s|X], [4|Y]) :-
    numlist(X, Y).
numlist([s|X], [6|Y]) :-
    numlist(X, Y).
numlist([s|X], [8|Y]) :-
    numlist(X, Y).

numlist([c|X], [1|Y]) :-
    numlist(X, Y).
numlist([c|X], [3|Y]) :-
    numlist(X, Y).
numlist([c|X], [5|Y]) :-
    numlist(X, Y).
numlist([c|X], [7|Y]) :-
    numlist(X, Y).
numlist([c|X], [9|Y]) :-
    numlist(X, Y).

allnumlists([], []).
allnumlists([H|T], [HNum|Tnum]) :-
    %% write("HEAD: "),
    %% write(H), nl,
    %% write("TAIL: "),
    %% write(T), nl,
    write("przed NUMLIST"), nl,
    numlist(H, HNum),
    write("H: "), write(H), nl,
    write("HNum: "), write(HNum), nl,
    write("przed ALLNUMLISTS"), nl,
    allnumlists(T, TNum),
    append([HNum], TNum, Ret).

mult([FirstSC,SecondSC|TailSC], Result) :-
    length([FirstSC,SecondSC|TailSC], Length),
    TensPower is Length - 4,
    %% allnumlists(SquaresAndCircles, [First,Second|Rest]),
    numlist(FirstSC, First),
    numlist(SecondSC, Second),
    concat_number(First, FirstNumber),
    concat_number(Second, SecondNumber),
    Result is FirstNumber * SecondNumber,
    write("finding intermediates"), nl,
    intermediatemults(FirstNumber, Second, TensPower, RevIntermediateMults),
    write("reversing them"), nl,
    reverse(RevIntermediateMults, IntermediateMults),
    write(IntermediateMults), nl,
    append(IntermediateMults, [Result], Rest),
    write("finding allnumlists for:"), nl,
    write(TailSC), nl,
    write(Rest), nl,
    allnumlists(TailSC, Rest),
    write(FirstNumber), nl, write(SecondNumber).

intermediatemults(_, [], _, []).
intermediatemults(First, [SecondHead|SecondTail], CurrentTensPower, [HRes|TRes]) :-
    HRes is First * SecondHead * (10^CurrentTensPower),
    NextTensPower is CurrentTensPower - 1,
    intermediatemults(First, SecondTail, NextTensPower, TRes).


%% port z listy trzeciej
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

allconcatnumbers([], []).
allconcatnumbers([H|T], Ret) :-
    concat_number(H, HNum),
    allconcatnumbers(T, TNum),
    append([HNum], TNum, Ret).
