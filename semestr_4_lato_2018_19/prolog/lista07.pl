%% Zadanie 1.
%% Niestety, po dodaniu odcięcia phrase/2 nie jest już
%% w stanie generować słów z tego języka.
%% W zliczaniu liter A korzystam z obserwacji, że jest ich
%% tyle samo co B - tzn każde użycie produkcji #2 zwiększa
%% ich liczbę o 1.
%%
%% Podgląd tego, co się wygenerowało:
%% listing(zadanie01)
%%
%% Faktyczne zliczanie liter:
%% phrase(zadanie01(N), [a,a,a,a,a,b,b,b,b,b])
zadanie01(0) --> [].
zadanie01(A) --> [a], zadanie01(A1), [b],
                 {A is 1 + A1},
                 !.

%% Zadanie 2.
%%
%% Przykład parsowania z wynikiem (40 i 41 to odpowiednio '(' i ')'):
%% phrase(tree(AST),[40,40,*,*,41,40,*,*,41,41]).
tree(leaf) --> [*].
tree(node(Left, Right)) --> "(", tree(Left), tree(Right), ")", !.
