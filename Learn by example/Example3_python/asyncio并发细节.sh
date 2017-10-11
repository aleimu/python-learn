http://www.cnblogs.com/mypath/articles/7395850.html
#摘自
http://www.cnblogs.com/vincenshen/articles/7250315.html
http://www.cnblogs.com/vincenshen/category/1031978.html 中后几章说的不错，可以参考
#使用asyncio处理并发
1、asyncio是一个异步IO非阻塞框架
2、async/await是Python提供的异步编程API，而asyncio只是一个利用 async/await API进行异步编程的框架
3、异步编程的一个原则：一旦决定使用异步，则系统每一层都必须是异步。原因在于yield from——asyncio 就是一条从IO底层库一直到最上层逻辑的一条yield from链，在调用的每个层次必须都使用yield from。一旦IO发生，yield from——Python 的生成器，会让渡出CPU，直到IO 完成以及别调度发生。(同第10条)
4、并发：一次处理多件事  并行：一次做多件事
5、asyncio使用事件循环驱动的协程实现并发，这是Python中最大也是最具雄心壮志的库之一
6、应该摒弃线程或进程，使用异步编程管理网络应用中的高并发
7、在异步编程中，与回调相比，协程是显著提升性能的方式
8、除非想阻塞主线程，否则不要在asyncio协程中使用time.sleep(), 应该使用yield from asyncip.sleep()
9、asyncio.wait()协程的参数是一个由Feture或Coroutine构成的可迭代对象；wait会分别把各个协程包装进一个Task对象。最终的结果是，wait处理的所有对象都通过某种方式变成Future类的实例。
10、为了使用asyncio包，我们必须把每个访问网络的函数变成异步版，使用yield from处理网络操作，这样才能把控制权交还给事件循环。同第3条原则
11、yield from foo句法能防止阻塞，是因为当前协程暂停后，控制权回到事件循环手中，再去驱动其他协程；foo期物或协程运行完毕后把结果返回给暂停的协程，将其恢复。
12、yield from两点陈述：
　　（1）使用yield from链接的多个协程最终必须由不是协程的调用方驱动，调用方显示或隐式（例for循环中）在最外委派生成器上调用next()函数或send()方法。
　　（2）链条中最内层的子生成器必须是简单的生成器（只使用yield）或可迭代的对象。
　　（3）我们编写的协程链条始终通过把最外层委派生成器传给asyncio包API中的某个函数（如：loop.run_until_complete(...)）驱动
　　（4）使用asyncio包时，我们编写的代码不通过调用next()函数或者.send()方法驱动协程 ——这一点由asyncio包实现的事件循环（loop）去做。
　　（5）最内层的子生成器是库中真正执行IO操作的函数，而不是我们自己编写的函数。
13、asyncio.ensure_future(coroutine) 和 loop.create_task(coroutine)都可以创建一个task.
14、run_until_complete的参数是一个futrue对象。当传入一个协程，其内部会自动封装成task，task是Future的子类。
15、asyncio.wait(...) 通过它可以获取一个协同程序的列表，同时返回一个将它们全包括在内的单独的协同程序，并交给loop_run_until_complete处理。


访问模拟端1000次
{
# curl -k -v -X GET http://10.175.102.22:8091/sessions
#一般方法
def hello():
    response = requests.get("http://10.175.102.22:8091/sessions")
    return response.text
print(hello())
print(timeit.timeit(stmt=hello, number=1000))

#大概17s

#使用协程1
import asyncio
from aiohttp import ClientSession
import time

async def fetch(url):
    async with ClientSession() as session:
        async with session.get(url) as response:
            return await response.read()

url = "http://10.175.102.22:8091/sessions"
t1 = time.time()
for x in range(10):
    # tasks太多会报错，ValueError: too many file descriptors in select()
    tasks = [fetch(url) for x in range(100)]
    loop = asyncio.get_event_loop()
    loop.run_until_complete(asyncio.wait(tasks))
loop.close()

t2 = time.time()
print(t2 - t1)
#4s

#使用协程2
import asyncio
from aiohttp import ClientSession
import time

async def fetch(url):
    async with ClientSession() as session:
        async with session.get(url) as response:
            return await response.read()

async def run(loop, r):
    url = "http://10.175.102.22:8091/sessions"
    tasks = []
    for i in range(r):
        task = asyncio.ensure_future(fetch(url))
        tasks.append(task)
    responses = await asyncio.gather(*tasks)
    # print(responses)
t1 = time.time()
for x in range(10):
    loop = asyncio.get_event_loop()
    future = asyncio.ensure_future(run(loop, 100))
    loop.run_until_complete(future)
t2 = time.time()
print(t2 - t1)
#4.2s
#yield from处理网络操作，这样才能把控制权交还给事件循环
#错误的示例，未全程使用协程
import asyncio
import time
import requests
#
async def hello(url):
    response = requests.get(url)
    return response.text

url = "http://10.175.102.22:8091/sessions"
t1 = time.time()
for x in range(10):
    # ValueError: too many file descriptors in select()
    tasks = [hello(url) for x in range(100)]
    loop = asyncio.get_event_loop()
    loop.run_until_complete(asyncio.wait(tasks))
    # loop.close()

t2 = time.time()
print(t2 - t1)
#18s

#使用socket模拟http请求，完成全过程协程操作
# curl -k -v -X GET http://10.175.102.22:8091/sessions
import asyncio
import time
# python socket 实现http请求,asyncio.open_connection包装了socket
async def wget(host):
    #print("wget %s..." % host)
    connect = asyncio.open_connection(host, 8091)
    reader, writer = await connect
    header = 'GET /sessions HTTP/1.1\r\nHost: 10.175.102.22:8091\r\nConnection: close\r\n\r\n'
    writer.write(header.encode("utf-8"))
    # writer.write("/sessions".encode("utf-8"))
    await writer.drain()
    while True:
        line = await reader.readline()
        #print("line:", line)
        if line == b"":
            break
        #print('%s header > %s' % (host, line.decode('utf-8').rstrip()))
    writer.close()
t1 = time.time()
for x in range(10):
    loop = asyncio.get_event_loop()
    tasks = [wget('10.175.102.22') for x in range(100)]
    loop.run_until_complete(asyncio.wait(tasks))
loop.close()
t2 = time.time()
print(t2 - t1)
#3.35s
}

线程与协程对比
{
1.1 线程与协程对比
示例1： 多个协程切换

import asyncio
import threading
@asyncio.coroutine
def hello():
    print("Hello world! (%s)" % threading.currentThread())
    yield from asyncio.sleep(10)
    print('Hello again! (%s)' % threading.currentThread())
@asyncio.coroutine
def hello2():
    print("Hello world2! (%s)" % threading.currentThread())
    yield from asyncio.sleep(10)
    print('Hello again! (%s)' % threading.currentThread())
loop = asyncio.get_event_loop()
tasks = [hello(), hello2()]
wait = asyncio.wait(tasks)
res, _ = loop.run_until_complete(wait)
loop.close()
print(res)
>>>>
Hello world2! (<_MainThread(MainThread, started 35116)>)
Hello world! (<_MainThread(MainThread, started 35116)>)
Hello again! (<_MainThread(MainThread, started 35116)>)
Hello again! (<_MainThread(MainThread, started 35116)>)
{<Task finished coro=<hello() done, defined at C:/Users/gck1d6o/Desktop/FTP/Speed Python/16/async for.py:5> result=None>, <Task finished coro=<hello2() done, defined at C:/Users/gck1d6o/Desktop/FTP/Speed Python/16/async for.py:12> result=None>}


示例2： 异步IO执行HTTP

import asyncio
@asyncio.coroutine
def wget(host):
    print("wget %s..." % host)
    connect = asyncio.open_connection(host, 80)
    reader, writer = yield from connect
    header = "GET / HTTP/1.0\r\nHost: %s\r\n\r\n" % host
    writer.write(header.encode("utf-8"))
    yield from writer.drain()
    while True:
        line = yield from reader.readline()
        if line == b"\r\n":
            break
        print('%s header > %s' % (host, line.decode('utf-8').rstrip()))
    writer.close()
loop = asyncio.get_event_loop()
tasks = [wget(host) for host in ('www.sina.com.cn', 'www.sohu.com', 'www.163.com')]
loop.run_until_complete(asyncio.wait(tasks))
loop.close()
>>>>
wget www.sina.com.cn...
wget www.163.com...
wget www.sohu.com...
...


示例3： 异步IO爬虫

import asyncio
import aiohttp
import os
import sys
import time
POP20_CC = ("CN IN US ID BR PK NG BD RU JP MX PH VN ET EG DE IR TR CD FR").split()
BASE_URL = "http://flupy.org/data/flags"
DEST_DIR = "downloads/"
def save_flag(img, filename):
    path = os.path.join(DEST_DIR, filename)
    with open(path, "wb") as fp:
        fp.write(img)
def show(text):
    print(text, end=" ")
    sys.stdout.flush()
def main(download):
    t0 = time.time()
    count = download(POP20_CC)
    elapsed = time.time() - t0
    msg = "\n{} flags downloaded in {:.2f}s"
    print(msg.format(count, elapsed))
@asyncio.coroutine
def get_flag(cc):
    url = "{}/{cc}/{cc}.gif".format(BASE_URL, cc=cc.lower())
    resp = yield from aiohttp.request("GET", url)
    image = yield from resp.read()
    return image
@asyncio.coroutine
def download_one(cc):
    image = yield from get_flag(cc)
    show(cc)
    save_flag(image, cc.lower() + ".gif")
    return cc
def download_many(cc_list):
    loop = asyncio.get_event_loop()
    tasks = [download_one(cc) for cc in sorted(cc_list)]
    wait_coro = asyncio.wait(tasks)
    res, _ = loop.run_until_complete(wait_coro)
    loop.close()
    return len(res)
if __name__ == '__main__':
    main(download_many)
>>>>
ID TR FR RU EG IN VN CN BD BR DE NG JP MX ET PK PH US CD IR
20 flags downloaded in 0.89


1.3 避免阻塞型调用
有两种方法能避免阻塞型调用中止整个应用程序的进程：
　　1、在单独的线程或进程中运行各个阻塞型操作
　　2、把每个阻塞型操作转换为非阻塞的异步调用

1.4 使用Executor对象，防止阻塞事件循环

import asyncio
import os
DEST_DIR = "downloads/"
def save_flag(img, filename):
    path = os.path.join(DEST_DIR, filename)
    with open(path, "wb") as fp:
        fp.write(img)
loop = asyncio.get_event_loop()
loop.run_in_executor(None, save_flag, image, cc.lower() + ".gif")


1.5 Semaphore 信号量

import asyncio
import aiohttp
import os
import sys
import time
POP20_CC = ("CN IN US ID BR PK NG BD RU JP MX PH VN ET EG DE IR TR CD FR").split()
BASE_URL = "http://flupy.org/data/flags"
DEST_DIR = "downloads/"
def save_flag(img, filename):
    path = os.path.join(DEST_DIR, filename)
    with open(path, "wb") as fp:
        fp.write(img)
def show(text):
    print(text, end=" ")
    sys.stdout.flush()
def main(download):
    t0 = time.time()
    count = download(POP20_CC)
    elapsed = time.time() - t0
    msg = "\n{} flags downloaded in {:.2f}s"
    print(msg.format(count, elapsed))
@asyncio.coroutine
def get_flag(cc):
    url = "{}/{cc}/{cc}.gif".format(BASE_URL, cc=cc.lower())
    resp = yield from aiohttp.request("GET", url)
    image = yield from resp.read()
    return image
@asyncio.coroutine
def download_one(cc, semaphore):
    with (yield from semaphore):　　# 把semaphore当成上下文管理器使用
        image = yield from get_flag(cc)
    show(cc)
    save_flag(image, cc.lower() + ".gif")
    return cc
def download_many(cc_list):
    loop = asyncio.get_event_loop()
    semaphore = asyncio.Semaphore(5)　　# 给予5个信号
    tasks = [download_one(cc, semaphore) for cc in sorted(cc_list)]
    wait_coro = asyncio.wait(tasks)
    res, _ = loop.run_until_complete(wait_coro)
    loop.close()
    return len(res)
if __name__ == '__main__':
    main(download_many)


1.6 绑定回调函数

import time
import asyncio
now = lambda : time.clock()
async def do_some_work(x):
    print("Waiting:", x)
    return "Done after {}s".format(x)
def callback(future):
    print("Callback:", future.result())
start = now()
coroutine = do_some_work(2)
loop = asyncio.get_event_loop()
task = asyncio.ensure_future(coroutine)
task.add_done_callback(callback)
loop.run_until_complete(task)
print("Time:", now() - start)
>>>>
Waiting: 2
Callback: Done after 2s
Time: 0.0015685070140109125


1.7 获取协程的result
示例1： 获取result

import asyncio
import time
now = lambda: time.clock()
async def do_some_work(x):
    print("Waiting:", x)
    await asyncio.sleep(x)
    return "Done after {}s".format(x)
start = now()
tasks = [do_some_work(x) for x in range(1, 4)]
wait_coro = asyncio.wait(tasks)
loop = asyncio.get_event_loop()
res, _ = loop.run_until_complete(wait_coro)
for re in res:
    print(re.result())
>>>>
Waiting: 1
Waiting: 2
Waiting: 3
Done after 3s
Done after 2s
Done after 1s


示例2： 获取result

import asyncio
import time
now = lambda: time.clock()
async def do_some_work(x):
    print("Waiting:", x)
    await asyncio.sleep(x)
    return "Done after {}s".format(x)
start = now()
tasks = [asyncio.ensure_future(do_some_work(x)) for x in range(1, 4)]
wait_coro = asyncio.wait(tasks)
loop = asyncio.get_event_loop()
loop.run_until_complete(wait_coro)
for task in tasks:
    print("Task ret:", task.result())
>>>>
Waiting: 1
Waiting: 2
Waiting: 3
Task ret: Done after 1s
Task ret: Done after 2s
Task ret: Done after 3s


前面两个示例都是需要等待所有协程都运行完毕后才能查看到result, 有时候我们需要协程运行结束后要求立即获取结果，这里可以用asyncio.as_completed来实现
示例3：asyncio.as_completed

import asyncio
import time
async def do_some_work(x):
    print("Waiting:", x)
    await asyncio.sleep(x)
    return "Done after {}s".format(x)
async def main():
    tasks = [do_some_work(x) for x in range(1, 4)]
    wait_coro = asyncio.wait(tasks)
    for task in asyncio.as_completed(tasks):
        result = await task
        print("Task ret:{}".format(result))
loop = asyncio.get_event_loop()
loop.run_until_complete(main())
>>>>
Waiting: 2
Waiting: 3
Waiting: 1
Task ret:Done after 1s
Task ret:Done after 2s
Task ret:Done after 3s


示例4：  asyncio.as_completed + tqdm实现进度条
to_do_iter = asyncio.as_completed(to_do)
to_do_iter = tqdm.tqdm(to_do_iter, total=len(cc_list))


}
