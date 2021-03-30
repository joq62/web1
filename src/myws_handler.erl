-module(myws_handler).
-export([init/2, websocket_init/1, websocket_handle/2, websocket_info/2]).


init(Req, State) ->
    io:format("~p~n",[{?MODULE,?FUNCTION_NAME,?LINE}]),
    {cowboy_websocket, Req, State}.  %Perform websocket setup

%websocket_init(State) ->
 %   io:format("~p~n",[{?MODULE,?FUNCTION_NAME,?LINE}]),
  %  {ok, State}.
websocket_init(State) ->
    io:format("~p~n",[{?MODULE,?FUNCTION_NAME,?LINE}]),
    {reply, {text, <<"Let's roll">>}, State}.

websocket_handle({text, MsgBin}, State) ->
    Msg=binary_to_list(MsgBin),
    io:format("~p~n",[{?MODULE,?FUNCTION_NAME,?LINE,Msg}]),
    {Hours, Minutes, Secs} = time(),
    
    {
     reply, 
     {text, io_lib:format("[~w:~w:~w]: Server received: ~s", [Hours, Minutes, Secs, Msg]) },
     State
    };
websocket_handle(Other, State) ->  %Ignore
    io:format("[Other,State~p~n",[{?MODULE,?LINE,Other,State}]),
    {ok, State}.


websocket_info({text, Text}, State) ->
    {reply, {text, Text}, State};
websocket_info(_Other, State) ->
    {ok, State}.