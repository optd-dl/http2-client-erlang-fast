#Http/2 Client for Erlang -- Fast version
*******************************

##DESCRIPTION
-------------
**This is a fast version of Http/2 implementation for the Erlang programming language.**  
**The so-called fast version is that WINDOW_UPDATE, HEADERS and DATA are not separately sent, but are unifiedly sent.**  
e.g.  

* slow verion -- base version  
    Frame#1: WINDOW_UPDATE(Stream#n-2)  
    Frame#2: WINDOW_UPDATE(Connection)  
    Frame#3: HEADERS(Stream#n)  
    Frame#4: DATA(Stream#n)

* fast verion  
    Frame#1:  WINDOW_UPDATE(Stream#n-2)+WINDOW_UPDATE(Connection)+HEADERS(Stream#n)+DATA(Stream#n)

###Base protocol:
* [Hypertext Transfer Protocol Version 2 (HTTP/2)](https://tools.ietf.org/html/rfc7540 "http/2")

###Base source code:
* [chatterbox](https://github.com/joedevivo/chatterbox "chatterbox")

###Motive of creating this branch from [chatterbox](https://github.com/joedevivo/chatterbox):
* WINDOW_UPDATE, HEADERS and DATA of [chatterbox](https://github.com/joedevivo/chatterbox) are separately sent.
* This cost network delay.
* When [chatterbox](https://github.com/joedevivo/chatterbox)'s TPS is below 5k, the fast version is 10k.

###Author:
* **RongCapital(DaLian) information service Ltd.**

###Contact us:
* [gaoliang@rongcapital.cn](mailto:gaoliang@rongcapital.cn)

##HowTo
-------------------
***Refer to:***  
[src/howto.erl](https://github.com/optd-dl/http2-client-erlang-fast/blob/master/src/howto.erl "howto.erl")  
***e.g.***
```erlang
    %% connect
	{ok, Pid} = h2_client:start_link(http, "localhost", 50051),
    %% header
	RequestHeaders = [
					  {<<":method">>, <<"POST">>},
					  {<<":scheme">>, <<"http">>},
					  {<<":path">>, <<"/helloworld.Greeter/SayHello">>},
					  {<<":authority">>, <<"localhost">>},
					  {<<"content-type">>, <<"application/grpc">>},
					  {<<"user-agent">>, <<"chatterbox-client/0.0.1">>},
					  {<<"te">>, <<"trailers">>}
					 ],
	%% body -- "world"
	RequestBody = <<0:8, 7:32, <<16#0a,16#05,16#77,16#6f,16#72,16#6c,16#64>>/binary>>,
	%% send and receive
	{ok, {ResponseHeaders, ResponseBody}} = h2_client:sync_request_combine(Pid, RequestHeaders, RequestBody).
```

##Build
-------------------
$ ./rebar get-deps  
$ ./rebar compile

##Run
------------
***e.g.***
###Run Server -- Precondition -- Java
$ ./start-server.sh  
#####Notice
***The first running will take a long time, because need to download gradle and jars.***

###Run Client -- Erlang
$ ./rebar shell
```erlang
howto:call().
```

##Dependencies
-------------------
***The following is the environment of author, may not be mandatory dependencies.***  

* Linux -- CentOS-7-x86_64-Everything-1503-01
* Erlang -- otp 18.1
* Java -- jdk-8u111-linux-x64
* Gradle -- gradle-2.13 (audo download in [start-server.sh](https://github.com/optd-dl/http2-client-erlang-fast/blob/master/start-server.sh "howto.erl"))
* Git -- git x86_64 1.8.3.1

