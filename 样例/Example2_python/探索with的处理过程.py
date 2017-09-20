# 探索with的处理过程
# http://www.cnblogs.com/chenny7/p/4213447.html
# http://www.cnblogs.com/xu-rui/p/6477271.html

# 例1


class Context:
    def __init__(self, name):
        self.name = name

    def __enter__(self):
        print("Begin.__enter__")
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        print("End.__exit__")

    def context(self):
        print("This is context ...{}".format(self.name))

# 如果带上 as 变量,那么__enter__()方法必须得返回一个东西,要不然会报错..
with Context("xurui") as context:
    print("1...........")
    context.context()
    print("2...........")
with Context("xurui"):
    print("3...........")
    Context("xurui").context()
    print("4...........")


# 不能对Python的任意符号使用with语句，它仅能工作于支持上下文管理协议（context management protocol）的对象
# file
# decimal.Context
# thread.LockType
# threading.Lock
# threading.RLock
# threading.Condition
# threading.Semaphore
# threading.BoundedSemaphore

# 当我们需要自定义一个上下文管理器类型的时候，就需要实现__enter__和__exit__方法，这对方法就称为上下文管理协议
# __enter__ 方法将在进入代码块前被调用。
# __exit__ 方法则在离开代码块之后被调用(即使在代码块中遇到了异常)。


# 进阶
# 例2
print("python库中还有一个模块contextlib，使你不用构造含有__enter__, __exit__的类就可以使用with")
from contextlib import contextmanager


@contextmanager
def context():
    print('entering the zone')
    try:
        yield
    except (Exception, e):
        print('with an error %s' % e)
        raise e
    else:
        print('with no error')

with context():
    print('----in context call------')


print("python库中还有一个模块contextlib，使你不用构造含有__enter__, __exit__的类就可以使用with")

# 例3
import queue
import contextlib


@contextlib.contextmanager
def worker_state(xxx, val):
    xxx.append(val)
    # print(xxx)
    try:
        yield
    finally:
        xxx.remove(val)
        # print(xxx)


q = queue.Queue()
li = []
q.put("xurui")
with worker_state(li, 1):
    print("before", li)
    q.get()
print("after", li)


print("python库中还有一个模块contextlib，使你不用构造含有__enter__, __exit__的类就可以使用with")

# 例4
import contextlib


@contextlib.contextmanager
def MyOpen(filename, mode):
    try:
        print("create file begin")
        # 如果open filename失败就会立即执行Exception不会执行 print("create file end")
        f = open(filename, mode, encoding='utf')
        print("create file end")
    except Exception as e:
        print("open异常就会立即执行这句话 create file filed:", e)
    else:
        print("没有出现异常就会执行else中的语句")
        yield f  # f return 给 as f的f    ----不是很懂啊,这里换成return就失败,哦,运行到这里会被暂停,等待f的调用,yield是生成的意思，但是在python中则是作为生成器理解，生成器的用处主要可以迭代
        # return f
    finally:
        print("最后都会执行 close file 这句 print,但下一句f.close() 会不会执行就要看f创建成功没有")
        f.close()


with MyOpen("1.py", 'w+') as f:
    ret = f.readlines()
    print("这里会在finally前执行,主要是yield的原因:", ret)

###例5
# 执行with后面的函数时,先进入函数中执行,遇到yield时,跳出,执行下面的,最后执行函数中的finally，此种用法也可用来自动关闭socket

import contextlib
import socket


@contextlib.contextmanager
def context_socket(host, port):
    sk = socket.socket()
    sk.bind((host, port))
    sk.listen(5)
    try:
        yield sk  # 将sk返回,赋值给sock
    finally:
        sk.close()

with context_socket('127.0.0.1', 8888) as sock:
    print(sock)
