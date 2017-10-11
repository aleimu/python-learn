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


'''
yield from 与 yield 的区别:
#http://www.cnblogs.com/aademeng/articles/7236768.html
Python3.3版本的PEP 380中添加了yield from语法，允许一个generator生成器将其部分操作委派给另一个生成器。其产生的主要动力在于使生成器能够很容易分为多个拥有send和throw方法的子生成器，像一个大函数可以分为多个子函数一样简单。Python的生成器是协程coroutine的一种形式，但它的局限性在于只能向它的直接调用者yield值。这意味着那些包含yield的代码不能想其他代码那样被分离出来放到一个单独的函数中。这也正是yield from要解决的。
虽然yield from主要设计用来向子生成器委派操作任务，但yield from可以向任意的迭代器委派操作；
对于简单的迭代器，yield from iterable 本质上等于 for item in iterable: yield item的缩写版
def func():
    # for i in 'AB':
    #     yield i
    yield from 'AB'  # 等同于上面两行

yield from 允许外界与子协程直接交互，这样就允许代码重构：把一部分包含 yield 的代码放到另外的函数，再使用 yield from 调用该函数。这样，就实现委托工作.
yield from 的主要功能是打开双向通道，把最外层的调用方与最内层的子生成器连接起来，使两者可以直接发送和产出值，还可以直接传入异常，而不用在中间的协程添加异常处理的代码。

'''
