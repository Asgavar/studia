%% zadanie 1.
revall(X, Y) :-
    revall(X, [], Y).

revall([], Acc, Acc).
revall([H|T], Acc, Y) :- (
    is_list(H) ->
    revall(H, [], X),
    revall(T, [X|A], R);
    revall(T, [H|A], R)
).

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
allnumlists([H|T], [HNum|TNum]) :-
    %% write("HEAD: "),
    %% write(H), nl,
    %% write("TAIL: "),
    %% write(T), nl,
    %% write("przed NUMLIST"), nl,
    numlist(H, HNum),
    %% write("H: "), write(H), nl,
    %% write("HNum: "), write(HNum), nl,
    %% write("przed ALLNUMLISTS"), nl,
    allnumlists(T, TNum).

mult([FirstSC,SecondSC,ThirdSC,FourthSC|TailSC], Result) :-
    length([FirstSC,SecondSC|TailSC], Length),
    TensPower is Length - 4,
    %% allnumlists(SquaresAndCircles, [First,Second|Rest]),
    numlist(FirstSC, First),
    numlist(SecondSC, Second),
    concat_number(First, FirstNumber),
    concat_number(Second, SecondNumber),
    Result is FirstNumber * SecondNumber,
    %% decimal(Result, ResultDigits),
    %% last(TailSC, ResultSC),
    %% numlist(ResultSC, ResultDigits),
    %% TODO: uogólnić
    numlist(ThirdSC, Third),
    write("First: "), write(FirstNumber), nl,
    write("Second: "), write(SecondNumber), nl,
    ThirdInteger is FirstNumber * (SecondNumber mod 10),
    write("Third: "), write(ThirdInteger), nl,
    concat_number(Third, ThirdInteger),
    write("ThirdInteger: "), write(ThirdInteger), nl,
    FourthInteger is Result - ThirdInteger,
    numlist(FourthSC, Fourth),
    concat_number(Fourth, FourthInteger).
    %% concat_number(ResultDigits, ResultInteger),
    %% write("finding intermediates"), nl,
    %% intermediatemults(FirstNumber, Second, TensPower, RevIntermediateMults),
    %% write("REVERSED INTERMEDIATE MULTS"), write(RevIntermediateMults), nl,
    %% write("reversing them"), nl,
    %% reverse(RevIntermediateMults, [ThirdNumber,FourthNumber]),
    %% write("FirstNumber: "), write(FirstNumber), nl,
    %% write("SecondNumber: "), write(SecondNumber), nl,
    %% write("Result: "), write(ResultDigits), nl,
    %%write("Intermediates: "), write(IntermediateMults), nl,
    %% write("Intermediates: "), write([ThirdNumber,FourthNumber]), nl,
    %% write("INTERMEDIATE MULTS"), write(IntermediateMults), nl,
    %% write("TailSC: "), write(TailSC), nl,
    %% conformtorules(IntermediateMults, TailSC),
    %% write(IntermediateMults), nl,
    %% append(IntermediateMults, [ResultDigits], Rest),
    %% write("Rest: "), write(Rest), nl,
    %% write("finding allnumlists for:"), nl,
    %% write(TailSC), nl,
    %% write(Rest), nl,
    %% allnumlists(TailSC, Rest).
    %% write(Rest), nl.

intermediatemults(_, _, -1, []).
intermediatemults(First, [SecondHead|SecondTail], CurrentTensPower, [HRes|TRes]) :-
    HResAsNumber is First * SecondHead * (10^CurrentTensPower),
    %% write("First: "), write(First), nl,
    %% write("Second: "), write([SecondHead|SecondTail]), nl,
    %% write("HResAsNumber: "), write(HResAsNumber), nl,
    decimal(HResAsNumber, HRes),
    %% write("HRes Decimal: "), write(HRes), nl,
    NextTensPower is CurrentTensPower - 1,
    %% write("NEXT TENS POWER: "), write(NextTensPower), nl,
    intermediatemults(First, SecondTail, NextTensPower, TRes).

conformturules([], _).
conformtorules([HInter|Intermediates], [HLetters|Letters]) :-
    numlist(HLetters, HInter),
    conformtorules(Intermediates, Letters).

last([X], X).
last([_|T], X) :-
    last(T, X).

%% zadanie 4.
puzzle4(N, Res) :-
    puzzle4(N, N, Res).
puzzle4(0, N, []) :- !.
%% puzzle4(1, N, [Position]) :-
%%     between(1, N, Position).
puzzle4(Left, N, [H|T]) :-
    LessLeft is Left - 1,
    puzzle4(LessLeft, N, T),
    between(1, N, H),
    issafe(H, T),
    donotlayonsamediagonal(H, T, 2).

issafe(NewOne, []).
issafe(NewOne, [H|T]) :-
    \+ NewOne = H,
    issafe(NewOne, T).

donotlayonsamediagonal(_, [], _).
donotlayonsamediagonal(NewOne, [H|T], CurrentColumn) :-
    NewOneSubstr is NewOne - 1,
    NewOneAdd is NewOne + 1,
    HSubstr is H - CurrentColumn,
    HAdd is H + CurrentColumn,
    HSubstr \= NewOneSubstr,
    HAdd \= NewOneAdd,
    NextColumn is CurrentColumn + 1,
    donotlayonsamediagonal(NewOne, T, NextColumn).

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

%% skopiowane 1:1 ze SKOSa
decimal(Num, _) :-
    \+ integer(Num),
    !,
    throw(error(type_error('integer argument',Num), context(digits/2,_))).
decimal(Num, _) :-
    Num < 0,
    !,
    throw(error(domain_error('nonnegative argument',Num), context(digits/2,_))).
decimal(0, [0]) :-                                  % wyjątek: zero nieznaczące
    !.
decimal(Num, Digits) :-
    decimal(Num, [], Digits).

decimal(0, Acc, Acc) :-
    !.
decimal(Num, Acc, Digits) :-
    divmod(Num, 10, Num1, D),
    decimal(Num1, [D|Acc], Digits).
