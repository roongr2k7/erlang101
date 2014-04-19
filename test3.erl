-module(test3).
-export([process_loop/0, list_loop/1, server/1, client/1]).

process_loop() ->
  receive
    Message ->
      io:format("Say: ~s~n", [Message]),
      process_loop()
  end.

list_loop(List) ->
  receive
    {push, Val} ->
      NewList = [Val | List],
      list_loop(NewList);
    {Pid, pop} ->
      [H|T] = List,
      Pid ! H,
      list_loop(T);
    print ->
      io:format("~p~n", [List]),
      list_loop(List)
  end.

server(Clients) ->
  receive
    {Client, connect} ->
      Client ! {self(), connected},
      NewClients = [Client | Clients],
      server(NewClients);
    {Client, message, Message} ->
      lists:foreach(
        fun(C) ->
            if 
              C =/= Client ->
                C ! {Client, received, Message}
          end
        end,
        Clients
      ),
      server(Clients)
  end.

client(S) ->
  receive
    {S, connected} ->
      io:format("~p accept your connection.~n", [S]),
      client(S);
    {Client, received, Message} ->
      io:format("~p say: ~s~n", [Client, Message]),
      client(S)
  end.
