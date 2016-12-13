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

##Build
-------------------
$ ./rebar get-deps  
$ ./rebar compile

##Run
------------
***e.g.***
###Run Server -- Precondition -- Java
```bash

```
###Run Client -- Erlang
```erlang

```
