%% @author liang
%% @doc @todo Add description to howto.

-module(howto).

%% ====================================================================
%% API functions
%% ====================================================================
-export([call/0]).

call() ->
	%% connect
	{ok, Pid} = h2_client:start_link(http, "localhost", 50051),
	
	%% 1st send
	RequestHeaders = [
					  {<<":method">>, <<"POST">>},
					  {<<":scheme">>, <<"http">>},
					  {<<":path">>, <<"/helloworld.Greeter/SayHello">>},
					  {<<":authority">>, <<"localhost">>},
					  {<<"content-type">>, <<"application/grpc">>},
					  {<<"user-agent">>, <<"chatterbox-client/0.0.1">>},
					  {<<"te">>, <<"trailers">>}
					 ],
	%%	"world"
	RequestBody = <<0:8, 7:32, <<16#0a,16#05,16#77,16#6f,16#72,16#6c,16#64>>/binary>>,
	{ok, StreamId} = h2_client:send_request_combine(Pid, RequestHeaders, RequestBody),
	timer:sleep(500),
	% recv
	{ok, {ResponseHeaders, ResponseBody}} = h2_client:get_response(Pid, StreamId),
	%%	"Hello world"
	io:format("ResponseHeaders:~p~n",[ResponseHeaders]),
	io:format("ResponseBody:~p~n",[ResponseBody]),
	
	%% 2st send
	{ok, {ResponseHeaders2, ResponseBody2}} = h2_client:sync_request_combine(Pid, RequestHeaders, RequestBody),
	%%	"Hello world"
	io:format("ResponseHeaders2:~p~n",[ResponseHeaders2]),
	io:format("ResponseBody2:~p~n",[ResponseBody2]),
	
	%% stop
	h2_client:stop(Pid).
