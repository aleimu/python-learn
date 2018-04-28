# -*- coding:utf-8 -*-

import time
import gevent
from gevent.pool import Pool


"""
参考Openstack_lgj\Python\线程池与阻塞、非阻塞、同步、异步的问题.sh

注意 print("domeX before iter :", alist)的位置，可以帮助理解协程运行的顺序，有些API方法必须要触发才会去执行任务
对比from multiprocessing.dummy import Pool as ThreadPool  from multiprocessing.pool import ThreadPool API样式基本相同，效果也相似，但dome5 中apply_async API效果不一样


运行结果：
('Spend time :', 2.0369999408721924)
('dome0 alist:', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
------------------------------
('Spend time :', 0.40599989891052246)
('dome1 alist:', [0, 4, 3, 2, 1, 5, 9, 8, 7, 6])
------------------------------
('dome2 before iter :', [])
<class 'gevent.pool.IMap'>
('Spend time :', 0.4049999713897705)
('dome2 after iter :', [0, 4, 3, 2, 1, 5, 9, 8, 7, 6])
------------------------------
('dome3 before iter :', [])
('Spend time :', 0.40799999237060547)
('dome3 after iter :', [0, 4, 3, 2, 1, 5, 9, 8, 7, 6])
------------------------------
('dome4 before iter :', [])
('Spend time :', 2.0320000648498535)
('dome4 after iter :', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
------------------------------
('dome5 before iter :', [])
('Spend time :', 0.20300006866455078)
('dome5 after iter :', [0, 4, 3, 2, 1])
------------------------------
('dome6 before iter :', [])
('Spend time :', 0.6080000400543213)
('dome6 after iter :', [5, 9, 8, 7, 6, 0, 4, 3, 2, 1, 5, 9, 8, 7, 6])
------------------------------
('dome7 before iter :', [])
<class 'gevent.pool.IMapUnordered'>
('Spend time :', 0.40599989891052246)
('dome7 after iter :', [0, 4, 3, 2, 1, 5, 9, 8, 7, 6])
------------------------------
('dome8 before iter :', [])
('Spend time :', 0.20099997520446777)
('dome8 after iter :', [0, 9, 8, 7, 6, 5, 4, 3, 2, 1])
------------------------------
(xrange(10), <type 'xrange'>)
([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], <type 'list'>)
"""
# 协程池大小,这个size大小还是比较影响运行速度的，对比dome5和dome8的情况理解
pool = Pool(size=5)
alist = []


def hello_from(n):
    def task(n):
        gevent.sleep(0.2)
        alist.append(n)
    task(n)
    #print('Size of pool', len(pool))


def dome0():
    global alist
    alist = []
    t1 = time.time()
    for x in range(10):
        hello_from(x)
    t2 = time.time()
    print("Spend time :", t2 - t1)
    print("dome0 alist:", alist)


dome0()
print("------------------------------")


def dome1():
    global alist
    alist = []
    t1 = time.time()
    pool.map(hello_from, xrange(10))
    t2 = time.time()
    print("Spend time :", t2 - t1)
    print("dome1 alist:", alist)


dome1()
print("------------------------------")


def dome2():
    global alist
    alist = []
    t1 = time.time()
    iimap = pool.imap(hello_from, xrange(10))
    # imap(func, *iterables, maxsize=None) -> iterable
    # imap是懒惰 - 直到您真正使用结果迭代器才会做任何工作 imap在multiprocessing和gevent遵守同样的规则。
    print("dome2 before iter :", alist)
    print(type(iimap))
    list(iimap)  # 触发iterable
    t2 = time.time()
    print("Spend time :", t2 - t1)
    print("dome2 after iter :", alist)


dome2()
print("------------------------------")


def dome3():
    global alist
    alist = []
    t1 = time.time()
    map_async_test = pool.map_async(hello_from, xrange(10))  # 返回一个Greenlet对象
    print("dome3 before iter :", alist)
    # 方法1--缺一不可
    # pool.start(map_async_test)
    # pool.join()
    # 方法2
    map_async_test.run()
    # map_async(self, func, iterable, callback=None) -> Greenlet
    # map_async是懒惰 - 直到您真正run返回的Greenlet才会做任何工作
    # map_async在multiprocessing和gevent遵守同样的规则。
    t2 = time.time()
    print("Spend time :", t2 - t1)
    print("dome3 after iter :", alist)


dome3()
print("------------------------------")


def dome4():
    global alist
    alist = []
    print("dome4 before iter :", alist)
    t1 = time.time()
    for number in range(10):
        pool.apply(hello_from, args=(number,))
    # pool.join()
    # apply 在multiprocessing和gevent遵守同样的规则。
    t2 = time.time()
    print("Spend time :", t2 - t1)
    print("dome4 after iter :", alist)


dome4()
print("------------------------------")


def dome5():
    global alist
    alist = []
    t1 = time.time()
    # Pool(5) 时alist只有[0, 4, 3, 2, 1],Pool()时是[0, 9, 8, 7, 6, 5, 4, 3, 2, 1]
    for number in range(10):
        pool.apply_async(hello_from, args=(number,))    # 只运行了5次,很奇怪,这里需要注意和线程池、进程池不一样
    print("dome5 before iter :", alist)
    pool.join()
    # apply_async 必须在pool.join()后才会执行任务,apply_async
    # 在multiprocessing和gevent遵守同样的规则。
    t2 = time.time()
    print("Spend time :", t2 - t1)
    print("dome5 after iter :", alist)


dome5()
print("------------------------------")

# dome5 和dome6有影响啊！dome5没接收完的9, 8, 7, 6, 5 被dome6接收了！

def dome6():
    global alist
    alist = []
    t1 = time.time()
    print("dome6 before iter :", alist)
    for i in range(10):
        pool.spawn(hello_from, i)
    print("dome6 before iter :", alist)
    pool.join()
    t2 = time.time()
    print("Spend time :", t2 - t1)
    print("dome6 after iter :", alist)


dome6()
print("------------------------------")


def dome7():
    global alist
    alist = []
    t1 = time.time()
    iimap = pool.imap_unordered(hello_from, xrange(10))
    # imap_unordered(func, *iterables, maxsize=None) -> iterable
    # imap_unordered是懒惰 - 直到您真正使用结果迭代器才会做任何工作。
    print("dome7 before iter :", alist)
    print(type(iimap))
    list(iimap)  # 触发iterable
    t2 = time.time()
    print("Spend time :", t2 - t1)
    print("dome7 after iter :", alist)


dome7()

print("------------------------------")


def dome8():
    global alist
    alist = []
    t1 = time.time()
    jobs = []
    for x in range(10):
        # 比上面的方法都快，主要原因是未使用协程池，一波走完，和Pool(10)一样效果
        jobs.append(gevent.spawn(hello_from, x))
    print("dome8 before iter :", alist)
    gevent.joinall(jobs)
    t2 = time.time()
    print("Spend time :", t2 - t1)
    print("dome8 after iter :", alist)


dome8()

print("------------------------------")
print(xrange(10), type(xrange(10)))  # xrange(10)
print(range(10), type(range(10)))    # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
