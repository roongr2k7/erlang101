-module(test).
-export([hello/0, hello/1, factorial/1, avr/1, avr_trail/1]).

hello() ->
  io:format("Hello World. Erlang~n").

hello(joe) ->
  io:format("Hello Joe.~n");
hello(mike) ->
  io:format("Hello Mike.~n").

factorial(0) -> 1;
factorial(1) -> 1;
factorial(N) when (N > 1) -> N * factorial(N-1);
factorial(N) when (N < 0) -> "error".

sum([]) -> 0;
sum([H|T]) -> H + sum(T).

sum_trail([], Acc) -> Acc;
sum_trail([H|T], Acc) -> sum_trail(T, Acc + H).

count([]) -> 0;
count([_|T]) -> 1 + count(T).

count_trail([], Acc) -> Acc;
count_trail([_|T], Acc) -> count_trail(T, Acc + 1).

avr(L) -> 
  if
    L =/= [] -> sum(L) / count(L);
    true -> error
  end.

avr_trail(L) -> sum_trail(L, 0) / count_trail(L, 0).
