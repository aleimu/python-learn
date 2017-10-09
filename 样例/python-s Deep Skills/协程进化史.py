# http://www.cnblogs.com/aademeng/articles/7239587.html
# http://www.cnblogs.com/aademeng/articles/7239480.html

'''
Python中的协程经历了很长的一段发展历程。其大概经历了如下三个阶段：
1. 最初的生成器变形yield / send
2. Python3.4中引入@asyncio.coroutine和yield from
3. 在最近的Python3.5版本中引入async / await关键字替代@asyncio.coroutine和yield from
4. async和await在Python 3.5与3.6版本中并不是关键字，Python 3.7中会作为关键字。

在GIL之下，同一时刻只能有一个线程在运行，那么对于CPU密集的程序来说，线程之间的切换开销就成了拖累(进程间切换靠的是操作系统的控制会更加慢)，而以I / O为瓶颈的程序正是协程所擅长的：
多任务并发（非并行），每个任务在合适的时候挂起（发起I / O）和恢复(I / O结束)
'''

# 1. 简单yield生成器


def dome1():
    def fib(n):
        index = 0
        a = 0
        b = 1
        while index < n:
            yield b
            a, b = b, a + b
            index += 1
            print('-' * 10 + 'test yield fib' + '-' * 10)
    for fib_res in fib(10):
        print(fib_res)

# dome1()

# 目前只有数据从fib(20)中通过yield流向外面的for循环；如果可以向fib(20)发送数据，那不是就可以在Python中实现协程。


def dome2():
    import random
    import time

    def stupid_fib(n):
        index = 0
        a = 0
        b = 1
        while index < n:
            sleep_cnt = yield b
            print('let me think {0} secs'.format(sleep_cnt))
            time.sleep(sleep_cnt)
            a, b = b, a + b
            index += 1
            print('-' * 10 + 'test yield send' + '-' * 10)

    N = 10
    sfib = stupid_fib(N)
    fib_res = next(sfib)
    while True:
        print('fib_res1:', fib_res)
        try:
            fib_res = sfib.send(random.uniform(0, 0.3))
            print('fib_res2:', fib_res)
        except StopIteration:
            break

    '''
    其中 next(sfib) 相当于 sfib.send(None) ，可以使得sfib运行至第一个yield处返回。后续的sfib.send(random.uniform(0, 0.5))则将一个随机的秒数发送给sfib，作为当前中断的yield表达式的返回值。这样，我们可以从“主”程序中控制协程计算斐波那契数列时的思考时间，协程可以返回给“主”程序计算结果，

    fib_res1: 1
    let me think 0.04133022742519982 secs
    ----------test yield send----------
    fib_res2: 1
    '''
# dome2()

# 2. yield from


def dome3():
    import random
    import time

    def stupid_fib(n):
        index = 0
        a = 0
        b = 1
        while index < n:
            sleep_cnt = yield b
            print('let me think {0} secs'.format(sleep_cnt))
            time.sleep(sleep_cnt)
            a, b = b, a + b
            index += 1
            print('-' * 10 + 'test yield send' + '-' * 10)

    def copy_stupid_fib(n):
        print('I am copy from stupid fib')
        yield from stupid_fib(n)
        print('Copy end')
        print('-' * 10 + 'test yield from and send' + '-' * 10)

    N = 10
    csfib = copy_stupid_fib(N)
    fib_res = next(csfib)
    while True:
        print(fib_res)
        try:
            fib_res = csfib.send(random.uniform(0, 0.2))
        except StopIteration:
            break

# dome3()

# 2.1 asyncio.coroutine和yield from


def dome33():
    import asyncio
    import random

    @asyncio.coroutine
    def smart_fib(n):
        index = 0
        a = 0
        b = 1
        while index < n:
            sleep_secs = random.uniform(0, 0.2)
            yield from asyncio.sleep(sleep_secs)
            print('Smart one think {} secs to get {}'.format(sleep_secs, b))
            a, b = b, a + b
            index += 1
    @asyncio.coroutine
    def stupid_fib(n):
        index = 0
        a = 0
        b = 1
        while index < n:
            sleep_secs = random.uniform(0, 0.4)
            yield from asyncio.sleep(sleep_secs)
            print('Stupid one think {} secs to get {}'.format(sleep_secs, b))
            a, b = b, a + b
            index += 1

    loop = asyncio.get_event_loop()
    tasks = [
        asyncio.async(smart_fib(10)),
        asyncio.async(stupid_fib(10)),
    ]
    loop.run_until_complete(asyncio.wait(tasks))
    print('All fib finished.')
    loop.close()

dome33()

'''
yield from 与 yield 的区别:
#http://www.cnblogs.com/aademeng/articles/7236768.html
Python3.3版本的PEP 380中添加了yield from语法，允许一个generator生成器将其部分操作委派给另一个生成器。其产生的主要动力在于使生成器能够很容易分为多个拥有send和throw方法的子生成器，
像一个大函数可以分为多个子函数一样简单。Python的生成器是协程coroutine的一种形式，但它的局限性在于只能向它的直接调用者yield值。这意味着那些包含yield的代码不能想其他代码那样被分离出来放到一个单独的函数中。
这也正是yield from要解决的。
虽然 yield from 主要设计用来向子生成器委派操作任务，但yield from可以向任意的迭代器委派操作；
对于简单的迭代器，yield from iterable 本质上等于 for item in iterable: yield item的缩写版
def func():
    # for i in 'AB':
    #     yield i
    yield from 'AB'  # 等同于上面两行


def writer_wrapper(coro1):
    # 手工处理异常被抛给子生成器
    coro1.send(None)    # 生成器准备好接收数据
    while True:
        try:
            try:
                x = (yield)
            except Exception as e:   # 捕获异常
                coro1.throw(e)
            else:
                coro1.send(x)
        except StopIteration:
            pass
包装器也是个生成器，上面所有复杂的写法也可以用yield from替换：

def writer_wrapper(coro2):
    yield from coro2


yield from 允许外界与子协程直接交互，这样就允许代码重构：把一部分包含 yield 的代码放到另外的函数，再使用 yield from 调用该函数。这样，就实现委托工作.
yield from 的主要功能是打开双向通道，把最外层的调用方与最内层的子生成器连接起来，使两者可以直接发送和产出值，还可以直接传入异常，而不用在中间的协程添加异常处理的代码。

'''


# 3.
# asyncio是一个基于事件循环的实现异步I/O的模块。通过yieldfrom，我们可以将协程asyncio.sleep的控制权交给事件循环，然后挂起当前协程；之后，由事件循环决定何时唤醒asyncio.sleep,接着向后执行代码。

def dome4():
    import asyncio
    import random
    async def smart_fib(n):
        index = 0
        a = 0
        b = 1
        while index < n:
            sleep_secs = random.uniform(0, 0.2)
            await asyncio.sleep(sleep_secs)
            print('Smart one think {} secs to get {}'.format(sleep_secs, b))
            a, b = b, a + b
            index += 1
    async def stupid_fib(n):
        index = 0
        a = 0
        b = 1
        while index < n:
            sleep_secs = random.uniform(0, 0.4)
            await asyncio.sleep(sleep_secs)
            print('Stupid one think {} secs to get {}'.format(sleep_secs, b))
            a, b = b, a + b
            index += 1

    loop = asyncio.get_event_loop()
    tasks = [
        asyncio.ensure_future(smart_fib(10)),
        asyncio.ensure_future(stupid_fib(10)),
    ]
    loop.run_until_complete(asyncio.wait(tasks))
    print('All fib finished.')
    loop.close()

dome4()
