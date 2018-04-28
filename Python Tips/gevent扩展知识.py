# 两个优秀的参考博客
http://hhkbp2.github.io/gevent-tutorial/#_1
https://softlns.github.io/2015/11/28/python-gevent/


#grequests库就可以在python里使用gevent基于coroutines(协程)解决并发请求

import grequests
import requests
import cProfile

urls = [
    'http://www.xiachufang.com/downloads/baidu_pip/2016030101.json',
    'http://www.xiachufang.com/downloads/baidu_pip/2016030102.json',
    'http://www.xiachufang.com/downloads/baidu_pip/2016030103.json',
    'http://www.xiachufang.com/downloads/baidu_pip/2016030104.json',
    'http://www.xiachufang.com/downloads/baidu_pip/2016030105.json',
    'http://www.xiachufang.com/downloads/baidu_pip/2016030106.json',
    'http://www.xiachufang.com/downloads/baidu_pip/2016030107.json',
    'http://www.xiachufang.com/downloads/baidu_pip/2016030108.json',
]
def haha(urls):
    rs = (grequests.get(u) for u in urls)
    return grequests.map(rs)

cProfile.run("haha(urls)")

def hehe(urls):
    hehe = [requests.get(i) for i in urls]
    return hehe

cProfile.run("hehe(urls)")


#队列
import gevent
from gevent.queue import Queue, Empty

tasks = Queue(maxsize=3)

def worker(n):
    try:
        while True:
            task = tasks.get(timeout=1) # decrements queue size by 1
            print('Worker %s got task %s' % (n, task))
            gevent.sleep(0)
    except Empty:
        print('Quitting time!')

def boss():
    """
    Boss will wait to hand out work until a individual worker is
    free since the maxsize of the task queue is 3.
    """

    for i in xrange(1,10):
        tasks.put(i)
    print('Assigned all work in iteration 1')

    for i in xrange(10,20):
        tasks.put(i)
    print('Assigned all work in iteration 2')

gevent.joinall([
    gevent.spawn(boss),
    gevent.spawn(worker, 'steve'),
    gevent.spawn(worker, 'john'),
    gevent.spawn(worker, 'bob'),
])


#给gevent上下文来指定那些数据是本地的。

import gevent
from gevent.local import local

stash = local()

def f1():
    stash.x = 1
    print(stash.x)

def f2():
    stash.y = 2
    print(stash.y)

    try:
        stash.x
    except AttributeError:
        print("x is not local to f2")

g1 = gevent.spawn(f1)
g2 = gevent.spawn(f2)

gevent.joinall([g1, g2])


#组是一个由greenlet组成的集合，并且能够被统一管理。

import gevent
from gevent.pool import Group

def talk(msg):
    for i in xrange(3):
        print(msg)

g1 = gevent.spawn(talk, 'bar')
g2 = gevent.spawn(talk, 'foo')
g3 = gevent.spawn(talk, 'fizz')

group = Group()
group.add(g1)
group.add(g2)
group.join()

group.add(g3)
group.join()


# server.py
#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import socket
import time
import gevent
from gevent import socket,monkey,pool    #导入pool
monkey.patch_all()

def server(port, pool):
    s = socket.socket()
    s.bind(('0.0.0.0', port))
    s.listen()
    while True:
        cli, addr = s.accept()
        #print("Welcome %s to SocketServer" % str(addr[0]))
        pool.spawn(handle_request, cli)    #通过pool.spawn()运行协程

def handle_request(conn):
    try:
        data = conn.recv(1024)
        print("recv:", data)
        data = 'From SockeServer:192.168.88.118---%s' % data.decode("utf8")
        conn.sendall(bytes(data, encoding="utf8"))
        if not data:
            conn.shutdown(socket.SHUT_WR)
    except Exception as ex:
        print(ex)
    finally:
        conn.close()

if __name__ == '__main__':
    pool = pool.Pool(5)    #限制并发协程数量5
    server(8888, pool)
    
#client.py
import socket
import gevent
from gevent import socket, monkey
from gevent.pool import Pool
import time

monkey.patch_all()

HOST = '192.168.88.118'
PORT = 8888
def sockclient(i):
    #time.sleep(2)
    s = socket.socket()
    s.connect((HOST, PORT))
    #print(gevent.getcurrent())
    msg = bytes(("This is gevent: %s" % i),encoding="utf8")
    s.sendall(msg)
    data = s.recv(1024)
    print("Received", data.decode())

    s.close()

pool = Pool(5)
threads = [pool.spawn(sockclient, i) for i in range(2000)]
gevent.joinall(threads)


from werkzeug.local import LocalProxy
from werkzeug.wrappers import Request
from contextlib import contextmanager

from gevent.wsgi import WSGIServer

_requests = local()
request = LocalProxy(lambda: _requests.request)

@contextmanager
def sessionmanager(environ):
    _requests.request = Request(environ)
    yield
    _requests.request = None

def logic():
    return "Hello " + request.remote_addr

def application(environ, start_response):
    status = '200 OK'

    with sessionmanager(environ):
        body = logic()

    headers = [
        ('Content-Type', 'text/html')
    ]

    start_response(status, headers)
    return [body]

WSGIServer(('', 8000), application).serve_forever()


# 子进程
import gevent
from gevent.subprocess import Popen, PIPE

def cron():
    while True:
        print "cron"
        gevent.sleep(0.2)

g = gevent.spawn(cron)
sub = Popen(['sleep 1; uname'], stdout=PIPE, shell=True)
out, err = sub.communicate()
g.kill()
print out.rstrip()
