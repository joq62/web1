-module(ws_h).

-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/2]).
-export([websocket_info/2]).

init(Req, Opts) ->
    io:format("~p~n",[{?MODULE,?LINE}]),
    {cowboy_websocket, Req, Opts}.

websocket_init(State) ->
    io:format("~p~n",[{?MODULE,?LINE}]),
	{[{text, "Hellow world"}], State}.

websocket_handle({text, Msg}, State) ->
    io:format("~p~n",[{?MODULE,?LINE}]),
	{[{text, << "That's what she said! ", Msg/binary >>}], State};
websocket_handle(_Data, State) ->
	{[], State}.

websocket_info({timeout, _Ref, Msg}, State) ->
	erlang:start_timer(1000, self(), <<"How' you doin'?">>),
	{[{text, Msg}], State};
websocket_info(_Info, State) ->
	{[], State}.
