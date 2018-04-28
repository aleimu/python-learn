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

def fab(max):
    n, a, b = 0, 0, 1
    while n < max:
        yield b
        # print b
        a, b = b, a + b
        n = n + 1

for n in fab(5):
    print(n)


# 简单地讲，yield 的作用就是把一个函数变成一个 generator，带有 yield 的函数不再是一个普通函数，
# Python 解释器会将其视为一个 generator，调用 fab(5) 不会执行 fab 函数，而是返回一个 iterable 对象！在 for 循环执行时，
# 每次循环都会执行 fab 函数内部的代码，执行到 yield b 时，fab 函数就返回一个迭代值，下次迭代时，代码从 yield b 的下一条语句继续执行，
# 而函数的本地变量看起来和上次中断执行前是完全一样的，于是函数继续执行，直到再次遇到 yield。

# python yield用法总结
# http://www.cnblogs.com/python-life/articles/4549996.html

def read_file(fpath):
    BLOCK_SIZE = 5
    with open(fpath, 'rb') as f:
        while True:
            block = f.read(BLOCK_SIZE)
            if block:
                yield block
            else:
                return

for x in read_file("./1.py"):
    print(x)

# 当一个函数中含有yield时, 它不再是一个普通的函数, 而是一个生成器.当该函数被调用时不会自动执行, 而是暂停,
# 调用函数.next()才会被执行,如一个函数中出现多个yield则next()会停止在下一个yield前

#-*- coding:utf-8 -*-
def test1():
    def fun():
        print 'start'
        a = yield 5
        print a
        print 'middle'
        b = yield 12
        print b
        c = yield 12
        print c
        print 'end'

    m = fun()                               #创建一个对象
    print("-----------------")
    print("return:",m.next())               #会使函数执行到一个yield,并停下
    print("-----------------")
    print("return:",m.send('message'))      #利用send()传递值
    print("-----------------")
    print("return:",m.close())              #throw() 与 close()中断 Generator
    print("return:",m.next())
    print("-----------------")

def test2():
    def gen():
        for x in range(5):
            print("x3:", x)
            y = yield x
            print("x,y:", x, y)
            print("---------")

    a = gen()
    for x in a: # 开始迭代 Generator 时就会执行 print("x3:", x),相当于x = a.next()
        print("x1:", x)
        if x == 2:
            print("x=2:", x)
            print("get next:", a.send("lgj"))
            # 获取了下一个yield表达式的参数,也就是3-->导致a的迭代直接少了x=3的片段-->跳过了print("x1:", x)--->也就是说send包含了next的迭代功能同时也有传送值给y的功能
            # g.next()和g.send(None)是相同的 ,send(msg) 和 next()是有返回值的，它们的返回值很特殊，返回的是下一个yield表达式的参数
        print("x2:", x)



def test3():
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
# test3()

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


# 3. asyncio是一个基于事件循环的实现异步I/O的模块。通过yieldfrom，我们可以将协程asyncio.sleep的控制权交给事件循环，然后挂起当前协程；之后，由事件循环决定何时唤醒asyncio.sleep,接着向后执行代码。

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



def writer():
    # 读取send传进的数据，并模拟写进套接字或文件
    while True:
        w = (yield)    # w接收send传进的数据
        print('>> ', w)


def writer_wrapper(coro1):
    # 手工处理异常被抛给子生成器
    print('2222:', coro1.send(None))    # 生成器准备好接收数据
    while True:
        try:
            try:
                x = (yield)
                print('3333:', x)
            except Exception as e:   # 捕获异常
                coro1.throw(e)
            else:
                coro1.send(x)
        except StopIteration:
            pass

# 上面的writer_wrapper等效于下面的writer_wrapper2，yield from隐式处理了传值和抛出异常给子生成器


def writer_wrapper2(coro):
    yield from coro


w = writer()
wrap = writer_wrapper(w)
print('1111:', wrap.send(None))  # 生成器准备好接收数据

for i in range(4):
    wrap.send(i)




