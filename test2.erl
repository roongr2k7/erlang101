-module(test2).
-export([double_list/1, map/2, foldr/3, foldl/3]).

double_list([]) -> [];
double_list([H|T]) -> [H * 2|double_list(T)].

map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F, T)].

foldr(F, Acc, [X]) -> F(X, Acc);
foldr(F, Acc, [H|T]) -> F(H, foldr(F, Acc, T)).

foldl(F, Acc, [X]) -> F(X, Acc);
foldl(F, Acc, [H|T]) -> foldl(F, F(H, Acc), T).
