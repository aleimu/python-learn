#http://www.cnblogs.com/huyuedong/p/5882510.html
Python-09-线程、进程、协程、异步IO

目录

0. 什么是线程(thread)？
0. 进程和线程的区别
1. 线程
1.1 普通的多线程
1.2 自定义线程类
1.3 线程锁(互斥锁Mutex)
1.4 信号量(Semaphore)
1.5 事件(Event)
1.6 条件（Condition）
1.7 全局解释器锁（GIL）
1.8 定时器（Timer）
2. queue队列
3. 生产者消费者模型
4. 线程池
5. 进程
5.1 进程的数据共享
5.2 进程锁
5.3 进程池
6. 协程
6.1 greenlet
6.2 gevent
7. 论事件驱动与异步IO
7.1 Select\Poll\Epoll异步IO
 

0. 什么是线程(thread)？

线程，有时被称为轻量级进程(Lightweight Process，LWP），是程序执行流的最小单元。一个标准的线程由线程ID，当前指令指针(PC），寄存器集合和堆栈组成。

另外，线程是进程中的一个实体，是被CPU独立调度和分派的基本单位，线程自己不独立拥有系统资源，但它可与同属一个进程的其它线程共享该进程所拥有的全部资源。

一个线程可以创建和撤消另一个线程，同一进程中的多个线程之间可以并发执行。由于线程之间的相互制约，致使线程在运行中呈现出间断性。线程也有就绪、阻塞和运行三种基本状态。就绪状态是指线程具备运行的所有条件，逻辑上可以运行，在等待处理机；运行状态是指线程占有处理机正在运行；阻塞状态是指线程在等待一个事件（如某个信号量），逻辑上不可执行。

每一个应用程序都至少有一个进程和一个线程。线程是程序中一个单一的顺序控制流程。在单个程序中同时运行多个线程完成不同的被划分成一块一块的工作，称为多线程。

0. 进程和线程的区别

进程和线程的主要差别在于它们是不同的操作系统资源管理方式。进程有独立的地址空间，一个进程崩溃后，在保护模式下不会对其它进程产生影响，而线程只是一个进程中的不同执行路径。线程有自己的堆栈和局部变量，但线程之间没有单独的地址空间，一个线程死掉就等于整个进程死掉，所以多进程的程序要比多线程的程序健壮，但在进程切换时，耗费资源较大，效率要差一些。但对于一些要求同时进行并且又要共享某些变量的并发操作，只能用线程，不能用进程。

简而言之：

一个程序至少有一个进程,一个进程至少有一个线程。
线程的划分尺度小于进程，使得多线程程序的并发性高。
另外，进程在执行过程中拥有独立的内存单元，而多个线程共享内存，从而极大地提高了程序的运行效率。
线程在执行过程中与进程还是有区别的。每个独立的线程有一个程序运行的入口、顺序执行序列和程序的出口。但是线程不能够独立执行，必须依存在应用程序中，由应用程序提供多个线程执行控制。
从逻辑角度来看，多线程的意义在于一个应用程序中，有多个执行部分可以同时执行。但操作系统并没有将多个线程看做多个独立的应用，来实现进程的调度和管理以及资源分配。
1. 线程

1.1 普通的多线程

在python中，threading模块提供线程的功能。通过它，我们可以轻易的在进程中创建多个线程。下面是个例子：

import threading
import time
   
def show(arg):
    time.sleep(1)
    print('thread'+str(arg))
   
for i in range(10):
    t = threading.Thread(target=show, args=(i,))
    t.start()
   
print('main thread stop')
上述代码创建了10个“前台”线程，然后控制器就交给了CPU，CPU根据指定算法进行调度，分片执行指令。
下面是Thread类的主要方法：

start 线程准备就绪，等待CPU调度
setName 为线程设置名称
getName 获取线程名称
setDaemon 设置为后台线程或前台线程（默认是False，前台线程）

如果是后台线程，主线程执行过程中，后台线程也在进行，主线程执行完毕后，后台线程不论成功与否，均停止。如果是前台线程，主线程执行过程中，前台线程也在进行，主线程执行完毕后，等待前台线程也执行完成后，程序停止。

join 该方法非常重要。它的存在是告诉主线程，必须在这个位置等待子线程执行完毕后，才继续进行主线程的后面的代码。但是当setDaemon为True时，join方法是无效的。
run 线程被cpu调度后自动执行线程对象的run方法　　

1.2 自定义线程类

对于threading模块中的Thread类，本质上是执行了它的run方法。因此可以自定义线程类，让它继承Thread类，然后重写run方法。

import threading
import time

class MyThread(threading.Thread):
    def __init__(self,num):
        threading.Thread.__init__(self)
        self.num = num
 
    def run(self):#定义每个线程要运行的函数
        print("running on number:%s" %self.num)
        time.sleep(3)
 
if __name__ == '__main__':
    t1 = MyThread(1)
    t2 = MyThread(2)
    t1.start()
    t2.start()
1.3 线程锁(互斥锁Mutex)

CPU执行任务时，在线程之间是进行随机调度的，并且每个线程可能只执行n条代码后就转而执行另外一条线程。由于在一个进程中的多个线程之间是共享资源和数据的，这就容易造成资源抢夺或脏数据，于是就有了锁的概念，限制某一时刻只有一个线程能访问某个指定的数据。

1.3.1 未使用锁时：

import time
import threading

def addNum():
    global num #在每个线程中都获取这个全局变量
    print('--get num:',num )
    time.sleep(1)
    num  -=1 #对此公共变量进行-1操作

num = 100  #设定一个共享变量
thread_list = []
for i in range(100):
    t = threading.Thread(target=addNum)
    t.start()
    thread_list.append(t)

for t in thread_list: #等待所有线程执行完毕 
    t.join()

print('final num:', num )
上面未加锁的程序多运行几次你会发现，最后打印出来的num结果不总是0，为什么每次运行的结果不一样呢？是因为线程同时访问一个数据，产生了错误的结果。

为了解决这个问题，python在threading模块中定义了几种线程锁类，每个线程在要修改公共数据时，为了避免自己在还没改完的时候别人也来修改此数据，可以给这个数据加一把锁， 这样其它线程想修改此数据时就必须等待你修改完毕并把锁释放掉后才能再访问此数据。

1.3.2 普通锁（Lock）

类名：Lock
普通锁，也叫互斥锁，是独占的，同一时刻只有一个线程被放行。
import time
import threading

def addNum():
    global num #在每个线程中都获取这个全局变量
    print('--get num:',num )
    time.sleep(1)
    lock.acquire() #修改数据前加锁
    num  -=1 #对此公共变量进行-1操作
    lock.release() #修改后释放

num = 100  #设定一个共享变量
thread_list = []
lock = threading.Lock() #生成全局锁

for i in range(100):
    t = threading.Thread(target=addNum)
    t.start()
    thread_list.append(t)

for t in thread_list: #等待所有线程执行完毕
    t.join()

print('final num:', num )
以上是threading模块的Lock类，它不支持嵌套锁。

1.3.3 递归锁（RLock）

RLcok类的用法和Lock一模一样，但它支持嵌套。

import threading,time

def run1():
    print("grab the first part data")
    lock.acquire()
    global num
    num +=1
    lock.release()
    return num

def run2():
    print("grab the second part data")
    lock.acquire()
    global  num2
    num2+=1
    lock.release()
    return num2

def run3():
    lock.acquire()
    res = run1()
    print('--------between run1 and run2-----')
    res2 = run2()
    lock.release()
    print(res,res2)

if __name__ == '__main__':
    num,num2 = 0,0
    lock = threading.RLock()
    for i in range(10):
        t = threading.Thread(target=run3)
        t.start()

while threading.active_count() != 1:
    print(threading.active_count())
else:
    print('----all threads done---')
    print(num,num2)
1.4 信号量(Semaphore)

类名：BoundedSemaphore
这种锁允许一定数量的线程同时更改数据，它不是互斥锁。比如地铁安检，排队人很多，工作人员只允许一定数量的人进入安检区，其它的人继续排队。
import threading,time

def run(n):
    semaphore.acquire()
    time.sleep(1)
    print("run the thread: %s\n" %n)
    semaphore.release()

if __name__ == '__main__':
    num= 0
    semaphore  = threading.BoundedSemaphore(5) #最多允许5个线程同时运行

    for i in range(20):
        t = threading.Thread(target=run,args=(i,))
        t.start()

while threading.active_count() != 1:
    pass #print threading.active_count()
else:
    print('----all threads done---')
    print(num)
1.5 事件(Event)

Python线程的事件用于主线程控制其他线程的执行，事件主要提供了三个方法 set、wait、clear。

事件处理的机制：全局定义了一个“Flag”，如果“Flag”值为 False，那么当程序执行 event.wait 方法时就会阻塞，如果“Flag”值为True，那么event.wait 方法时便不再阻塞。

clear：将“Flag”设置为False
set：将“Flag”设置为True
import threading

def func(e,i):
    print(i)
    e.wait()  # 检测当前event是什么状态，如果是红灯，则阻塞，如果是绿灯则继续往下执行。默认是红灯。
    print(i+100)

event = threading.Event()
for i in range(10):
    t = threading.Thread(target=func, args=(event, i))
    t.start()

event.clear()  # 主动将状态设置为红灯
inp = input(">>>")
if inp == "1":
    event.set() # 主动将状态设置为绿灯
1.6 条件（Condition）

使得线程等待，只有满足某条件时，才释放n个线程

import threading

def condition():
    ret = False
    r = input(">>>")
    if r == "yes":
        ret = True
    return ret

def func(conn, i):
    print(i)
    conn.acquire()
    conn.wait_for(condition)  # 这个方法接受一个函数的返回值
    print(i+100)
    conn.release()

c = threading.Condition()
for i in range(10):
    t = threading.Thread(target=func, args=(c, i,))
    t.start()
上面的例子，每输入一次“yes”放行了一个线程。下面这个，可以选择一次放行几个线程。

#!/usr/bin/env python
# -*- coding:utf-8 -*-

import threading

def run(n):
    con.acquire()
    con.wait()
    print("run the thread: %s" %n)
    con.release()

if __name__ == '__main__':

    con = threading.Condition()
    for i in range(10):
        t = threading.Thread(target=run, args=(i,))
        t.start()

    while True:
        inp = input('>>>')
        if inp == "q":
            break
        # 下面这三行是固定语法
        con.acquire()
        con.notify(int(inp))  # 这个方法接收一个整数，表示让多少个线程通过
        con.release()
1.7 全局解释器锁（GIL）

既然介绍了多线程和线程锁，那就不得不提及python的GIL，也就是全局解释器锁。在编程语言的世界，python因为GIL的问题广受诟病，因为它在解释器的层面限制了程序在同一时间只有一个线程被CPU实际执行，而不管你的程序里实际开了多少条线程。所以我们经常能发现，python中的多线程编程有时候效率还不如单线程，就是因为这个原因。那么，对于这个GIL，一些普遍的问题如下：

每种编程语言都有GIL吗？

以python官方Cpython解释器为代表....其他语言好像未见。

为什么要有GIL？

作为解释型语言，Python的解释器必须做到既安全又高效。我们都知道多线程编程会遇到的问题。解释器要留意的是避免在不同的线程操作内部共享的数据。同时它还要保证在管理用户线程时总是有最大化的计算资源。那么，不同线程同时访问时，数据的保护机制是怎样的呢？答案是解释器全局锁GIL。GIL对诸如当前线程状态和为垃圾回收而用的堆分配对象这样的东西的访问提供着保护。

为什么不能去掉GIL？

首先，在早期的python解释器依赖较多的全局状态，传承下来，使得想要移除当今的GIL变得更加困难。其次，对于程序员而言，仅仅是想要理解它的实现就需要对操作系统设计、多线程编程、C语言、解释器设计和CPython解释器的实现有着非常彻底的理解。

在1999年，针对Python1.5，一个“freethreading”补丁已经尝试移除GIL，用细粒度的锁来代替。然而，GIL的移除给单线程程序的执行速度带来了一定的负面影响。当用单线程执行时，速度大约降低了40%。虽然使用两个线程时在速度上得到了提高，但这个提高并没有随着核数的增加而线性增长。因此这个补丁没有被采纳。
另外，在python的不同解释器实现中，如PyPy就移除了GIL，其执行速度更快（不单单是去除GIL的原因）。然而，我们通常使用的CPython占有着统治地位的使用量，所以，你懂的。

在Python3.2中实现了一个新的GIL，并且带着一些积极的结果。这是自1992年以来 ，GIL的一次最主要改变。旧的GIL通过对Python指令进行计数来确定何时放弃GIL。在新的GIL实现中，用一个固定的超时时间来指示当前的线程以放弃这个锁。在当前线程保持这个锁，且当第二个线程请求这个锁的时候，当前线程就会在5ms后被强制释放掉这个锁（这就是说，当前线程每5ms就要检查其是否需要释放这个锁）。当任务是可行的时候，这会使得线程间的切换更加可预测。

GIL对我们有什么影响？

最大的影响是我们不能随意使用多线程。要区分任务场景。
在单核cpu情况下对性能的影响可以忽略不计，多线程多进程都差不多。在多核CPU 时，多线程效率较低。GIL对单进程和多进程没有影响。

在实际使用中有什么好的建议？

建议在IO密集型任务中使用多线程，在计算密集型任务中使用多进程。深入研究python的协程机制，你会有惊喜的。

1.8 定时器（Timer）

定时器，指定n秒后执行某操作。

from threading import Timer

def hello():
    print("hello, world")
    
t = Timer(1, hello)  # 表示1秒后执行hello函数
t.start() 
2. queue队列

通常而言，队列是一种先进先出的数据结构，与之对应的是堆栈这种后进先出的结构。但是在python中，它内置了一个queue模块，它不但提供普通的队列，还提供一些特殊的队列。具体如下：

queue.Queue ：先进先出队列
queue.LifoQueue ：后进先出队列
queue.PriorityQueue ：优先级队列
queue.deque ：双向队列
2.1 queue.Queue 先进先出队列

这是最常用也是最普遍的队列，先看一个例子：

import queue
q = queue.Queue(5)
q.put(1)
q.put(2)
q.put(3)

print(q.get())    # output:1
print(q.get())    # output:2
print(q.get())    # output:3
Queue类的参数和方法:

maxsize 队列的最大元素个数，也就是queue.Queue(5)中的5，默认为0。当队列内的元素达到这个值时，后来的元素默认会阻塞，等待队列腾出位置。
qsize() 获取当前队列中元素的个数，也就是队列的大小
empty() 判断当前队列是否为空，返回True或者False
full() 判断当前队列是否已满，返回True或者False
put(self, block=True, timeout=None)

往队列里放一个元素，默认是阻塞和无时间限制的。如果，block设置为False，则不阻塞，这时，如果队列是满的，放不进去，就会弹出异常。如果timeout设置为n秒，则会等待这个秒数后才put，如果put不进去则弹出异常。

get(self, block=True, timeout=None)

从队列里获取一个元素。参数和put是一样的意思。

join() 阻塞进程，直到所有任务完成，需要配合另一个方法task_done。

def join(self):
    with self.all_tasks_done:
        while self.unfinished_tasks:
            self.all_tasks_done.wait()
task_done() 表示某个任务完成。每一条get语句后需要一条task_done。
import queue
q = queue.Queue(5)
q.put(11)
q.put(22)
print(q.get())
q.task_done()
print(q.get())
q.task_done()
q.join()
2.2 LifoQueue：后进先出队列

类似于“堆栈”，后进先出。也较常用。

import queue
q = queue.LifoQueue()
q.put(123)
q.put(456)
print(q.get())   # output: 456
2.3 PriorityQueue：优先级队列

带有权重的队列，每个元素都是一个元组，前面的数字表示它的优先级，数字越小优先级越高，同样的优先级先进先出

q = queue.PriorityQueue()
q.put((1,"one"))
q.put((2,"two"))
q.put((3,"three"))
q.put((4,"four"))
print(q.get())   # output: one
2.4 deque：双向队列

Queue和LifoQueue的“综合体”，双向进出。方法较多，使用复杂，慎用！

q = queue.deque()
q.append(123)
q.append(333)
q.appendleft(456)
q.pop()
q.popleft()
3. 生产者消费者模型

在并发编程中使用生产者和消费者模式能够解决绝大多数并发问题。该模式通过平衡生产线程和消费线程的工作能力来提高程序的整体处理数据的速度。

为什么要使用生产者和消费者模式？

在线程世界里，生产者就是生产数据的线程，消费者就是消费数据的线程。在多线程开发当中，如果生产者处理速度很快，而消费者处理速度很慢，那么生产者就必须等待消费者处理完，才能继续生产数据。同样的道理，如果消费者的处理能力大于生产者，那么消费者就必须等待生产者。为了解决这个问题于是引入了生产者和消费者模式。

什么是生产者消费者模式？

生产者消费者模式是通过一个容器来解决生产者和消费者的强耦合问题。生产者和消费者彼此之间不直接通讯，而通过阻塞队列来进行通讯，所以生产者生产完数据之后不用等待消费者处理，直接扔给阻塞队列，消费者不找生产者要数据，而是直接从阻塞队列里取，阻塞队列就相当于一个缓冲区，平衡了生产者和消费者的处理能力。

下面来学习一个最基本的生产者消费者模型的例子：

#!/usr/bin/env python
# -*- coding:utf-8 -*-

import time
import queue
import threading

q = queue.Queue(10)
def productor(i):
    while True:
        q.put("厨师 %s 做的包子！"%i)
        time.sleep(2)

def consumer(k):
    while True:
        print("顾客 %s 吃了一个 %s"%(k,q.get()))
        time.sleep(1)

for i in range(3):
    t = threading.Thread(target=productor,args=(i,))
    t.start()

for k in range(10):
    v = threading.Thread(target=consumer,args=(k,))
    v.start()
4. 线程池

在使用多线程处理任务时也不是线程越多越好，由于在切换线程的时候，需要切换上下文环境，依然会造成cpu的大量开销。为解决这个问题，线程池的概念被提出来了。预先创建好一个较为优化的数量的线程，让过来的任务立刻能够使用，就形成了线程池。在python中，没有内置的较好的线程池模块，需要自己实现或使用第三方模块。下面是一个简单的线程池：

#!/usr/bin/env python
# -*- coding:utf-8 -*-

import queue
import time
import threading

class MyThreadPool:
    def __init__(self, maxsize=5):
        self.maxsize = maxsize
        self._q = queue.Queue(maxsize)
        for i in range(maxsize):
            self._q.put(threading.Thread)
            
    def get_thread(self):
        return self._q.get()
        
    def add_thread(self):
        self._q.put(threading.Thread)

def task(i, pool):
    print(i)
    time.sleep(1)
    pool.add_thread()

pool = MyThreadPool(5)
for i in range(100):
    t = pool.get_thread()
    obj = t(target=task, args=(i,pool))
    obj.start()
上面的例子是把线程类当做元素添加到队列内。实现方法比较糙，每个线程使用后就被抛弃，一开始就将线程开到满，因此性能较差。下面是一个相对好一点的例子，在这个例子中，队列里存放的不再是线程对象，而是任务对象，线程池也不是一开始就直接开辟所有线程，而是根据需要，逐步建立，直至池满。通过详细的代码注释，应该会有个清晰的理解。

#!/usr/bin/env python
# -*- coding:utf-8 -*-

"""
一个基于thread和queue的线程池，以任务为队列元素，动态创建线程，重复利用线程，
通过close和terminate方法关闭线程池。
"""
import queue
import threading
import contextlib
import time

# 创建空对象,用于停止线程
StopEvent = object()


def callback(status, result):
    """
    根据需要进行的回调函数，默认不执行。
    :param status: action函数的执行状态
    :param result: action函数的返回值
    :return:
    """
    pass


def action(thread_name,arg):
    """
    真实的任务定义在这个函数里
    :param thread_name: 执行该方法的线程名
    :param arg: 该函数需要的参数
    :return:
    """
    # 模拟该函数执行了0.1秒
    time.sleep(0.1)
    print("第%s个任务调用了线程 %s，并打印了这条信息！" % (arg+1, thread_name))


class ThreadPool:

    def __init__(self, max_num, max_task_num=None):
        """
        初始化线程池
        :param max_num: 线程池最大线程数量
        :param max_task_num: 任务队列长度
        """
        # 如果提供了最大任务数的参数，则将队列的最大元素个数设置为这个值。
        if max_task_num:
            self.q = queue.Queue(max_task_num)
        # 默认队列可接受无限多个的任务
        else:
            self.q = queue.Queue()
        # 设置线程池最多可实例化的线程数
        self.max_num = max_num
        # 任务取消标识
        self.cancel = False
        # 任务中断标识
        self.terminal = False
        # 已实例化的线程列表
        self.generate_list = []
        # 处于空闲状态的线程列表
        self.free_list = []

    def put(self, func, args, callback=None):
        """
        往任务队列里放入一个任务
        :param func: 任务函数
        :param args: 任务函数所需参数
        :param callback: 任务执行失败或成功后执行的回调函数，回调函数有两个参数
        1、任务函数执行状态；2、任务函数返回值（默认为None，即：不执行回调函数）
        :return: 如果线程池已经终止，则返回True否则None
        """
        # 先判断标识，看看任务是否取消了
        if self.cancel:
            return
        # 如果没有空闲的线程，并且已创建的线程的数量小于预定义的最大线程数，则创建新线程。
        if len(self.free_list) == 0 and len(self.generate_list) < self.max_num:
            self.generate_thread()
        # 构造任务参数元组，分别是调用的函数，该函数的参数，回调函数。
        w = (func, args, callback,)
        # 将任务放入队列
        self.q.put(w)

    def generate_thread(self):
        """
        创建一个线程
        """
        # 每个线程都执行call方法
        t = threading.Thread(target=self.call)
        t.start()

    def call(self):
        """
        循环去获取任务函数并执行任务函数。在正常情况下，每个线程都保存生存状态，
        直到获取线程终止的flag。
        """
        # 获取当前线程的名字
        current_thread = threading.currentThread().getName()
        # 将当前线程的名字加入已实例化的线程列表中
        self.generate_list.append(current_thread)
        # 从任务队列中获取一个任务
        event = self.q.get()
        # 让获取的任务不是终止线程的标识对象时
        while event != StopEvent:
            # 解析任务中封装的三个参数
            func, arguments, callback = event
            # 抓取异常，防止线程因为异常退出
            try:
                # 正常执行任务函数
                result = func(current_thread, *arguments)
                success = True
            except Exception as e:
                # 当任务执行过程中弹出异常
                result = None
                success = False
            # 如果有指定的回调函数
            if callback is not None:
                # 执行回调函数，并抓取异常
                try:
                    callback(success, result)
                except Exception as e:
                    pass
            # 当某个线程正常执行完一个任务时，先执行worker_state方法
            with self.worker_state(self.free_list, current_thread):
                # 如果强制关闭线程的flag开启，则传入一个StopEvent元素
                if self.terminal:
                    event = StopEvent
                # 否则获取一个正常的任务，并回调worker_state方法的yield语句
                else:
                    # 从这里开始又是一个正常的任务循环
                    event = self.q.get()
        else:
            # 一旦发现任务是个终止线程的标识元素，将线程从已创建线程列表中删除
            self.generate_list.remove(current_thread)

    def close(self):
        """
        执行完所有的任务后，让所有线程都停止的方法
        """
        # 设置flag
        self.cancel = True
        # 计算已创建线程列表中线程的个数，然后往任务队列里推送相同数量的终止线程的标识元素
        full_size = len(self.generate_list)
        while full_size:
            self.q.put(StopEvent)
            full_size -= 1

    def terminate(self):
        """
        在任务执行过程中，终止线程，提前退出。
        """
        self.terminal = True
        # 强制性的停止线程
        while self.generate_list:
            self.q.put(StopEvent)

    # 该装饰器用于上下文管理
    @contextlib.contextmanager
    def worker_state(self, state_list, worker_thread):
        """
        用于记录空闲的线程，或从空闲列表中取出线程处理任务
        """
        # 将当前线程，添加到空闲线程列表中
        state_list.append(worker_thread)
        # 捕获异常
        try:
            # 在此等待
            yield
        finally:
            # 将线程从空闲列表中移除
            state_list.remove(worker_thread)

# 调用方式
if __name__ == '__main__':
    # 创建一个最多包含5个线程的线程池
    pool = ThreadPool(5)
    # 创建100个任务，让线程池进行处理
    for i in range(100):
        pool.put(action, (i,), callback)
    # 等待一定时间，让线程执行任务
    time.sleep(3)
    print("-" * 50)
    print("\033[32;0m任务停止之前线程池中有%s个线程，空闲的线程有%s个！\033[0m"
          % (len(pool.generate_list), len(pool.free_list)))
    # 正常关闭线程池
    pool.close()
    print("任务执行完毕，正常退出！")
    # 强制关闭线程池
    # pool.terminate()
    # print("强制停止任务！")
    
5. 进程

在python中multiprocess模块提供了Process类，实现进程相关的功能。但是，由于它是基于fork机制的，因此不被windows平台支持。想要在windows中运行，必须使用if __name__ == '__main__:的方式，显然这只能用于调试和学习，不能用于实际环境。

下面是一个简单的多进程例子，你会发现Process的用法和Thread的用法几乎一模一样。

from multiprocessing import Process
import time

def f(name):
    time.sleep(2)
    print('hello', name)

if __name__ == '__main__':
    p = Process(target=f, args=('bob',))
    p.start()
    p.join()
5.1 进程的数据共享

每个进程都有自己独立的数据空间，不同进程之间通常是不能共享数据，创建一个进程需要非常大的开销。

from multiprocessing import Process
list_1 = []
def foo(i):
    list_1.append(i)
    print("This is Process ", i," and list_1 is ", list_1)

if __name__ == '__main__':
    for i in range(5):
        p = Process(target=foo, args=(i,))
        p.start()

    print("The end of list_1:", list_1)
运行上面的代码，你会发现列表list_1在各个进程中只有自己的数据，完全无法共享。想要进程之间进行资源共享可以使用queues/Array/Manager这三个multiprocess模块提供的类。

5.1.1 使用Array共享数据

from multiprocessing import Process
from multiprocessing import Array

def Foo(i,temp):
    temp[0] += 100
    for item in temp:
        print(i,'----->',item)

if __name__ == '__main__':
    temp = Array('i', [11, 22, 33, 44])
    for i in range(2):
        p = Process(target=Foo, args=(i,temp))
        p.start()
对于Array数组类，括号内的“i”表示它内部的元素全部是int类型，而不是指字符i，列表内的元素可以预先指定，也可以指定列表长度。概括的来说就是Array类在实例化的时候就必须指定数组的数据类型和数组的大小，类似temp = Array('i', 5)。对于数据类型有下面的表格对应：

'c': ctypes.c_char, 'u': ctypes.c_wchar,
'b': ctypes.c_byte, 'B': ctypes.c_ubyte,
'h': ctypes.c_short, 'H': ctypes.c_ushort,
'i': ctypes.c_int, 'I': ctypes.c_uint,
'l': ctypes.c_long, 'L': ctypes.c_ulong,
'f': ctypes.c_float, 'd': ctypes.c_double
5.1.2 使用Manager共享数据

from multiprocessing import Process,Manager

def Foo(i,dic):
    dic[i] = 100+i
    print(dic.values())

if __name__ == '__main__':
    manage = Manager()
    dic = manage.dict()
    for i in range(10):
        p = Process(target=Foo, args=(i,dic))
        p.start()
        p.join()
Manager比Array要好用一点，因为它可以同时保存多种类型的数据格式。

5.1.3 使用queues的Queue类共享数据

import multiprocessing
from multiprocessing import Process
from multiprocessing import queues

def foo(i,arg):
    arg.put(i)
    print('The Process is ', i, "and the queue's size is ", arg.qsize())

if __name__ == "__main__":
    li = queues.Queue(20, ctx=multiprocessing)
    for i in range(10):
        p = Process(target=foo, args=(i,li,))
        p.start()
这里就有点类似上面的队列了。从运行结果里，你还能发现数据共享中存在的脏数据问题。另外，比较悲催的是multiprocessing里还有一个Queue，一样能实现这个功能。

5.2 进程锁

为了防止和多线程一样的出现数据抢夺和脏数据的问题，同样需要设置进程锁。与threading类似，在multiprocessing里也有同名的锁类RLock, Lock, Event, Condition, Semaphore，连用法都是一样的！

from multiprocessing import Process
from multiprocessing import queues
from multiprocessing import Array
from multiprocessing import RLock, Lock, Event, Condition, Semaphore
import multiprocessing
import time

def foo(i,lis,lc):
    lc.acquire()
    lis[0] = lis[0] - 1
    time.sleep(1)
    print('say hi',lis[0])
    lc.release()

if __name__ == "__main__":
    # li = []
    li = Array('i', 1)
    li[0] = 10
    lock = RLock()
    for i in range(10):
        p = Process(target=foo,args=(i,li,lock))
        p.start()
5.3 进程池

既然有线程池，那必然也有进程池。但是，python给我们内置了一个进程池，不需要像线程池那样需要自定义，你只需要简单的from multiprocessing import Pool

#!/usr/bin/env python
# -*- coding:utf-8 -*-
from multiprocessing import Pool
import time

def f1(args):
    time.sleep(1)
    print(args)

if __name__ == '__main__':
    p = Pool(5)
    for i in range(30):
        p.apply_async(func=f1, args= (i,))
    p.close()           # 等子进程执行完毕后关闭进程池
    # time.sleep(2)
    # p.terminate()     # 立刻关闭进程池
    p.join()
进程池内部维护一个进程序列，当使用时，去进程池中获取一个进程，如果进程池序列中没有可供使用的进程，那么程序就会等待，直到进程池中有可用进程为止。

进程池中有以下几个主要方法：

apply：从进程池里取一个进程并执行
apply_async：apply的异步版本
terminate:立刻关闭进程池
join：主进程等待所有子进程执行完毕。必须在close或terminate之后。
close：等待所有进程结束后，才关闭进程池。
6. 协程

线程和进程的操作是由程序触发系统接口，最后的执行者是系统，它本质上是操作系统提供的功能。而协程的操作则是程序员指定的，在python中通过yield，人为的实现并发处理。

协程存在的意义：对于多线程应用，CPU通过切片的方式来切换线程间的执行，线程切换时需要耗时。协程，则只使用一个线程，分解一个线程成为多个“微线程”，在一个线程中规定某个代码块的执行顺序。

协程的适用场景：当程序中存在大量不需要CPU的操作时（IO）。

在不需要自己“造轮子”的年代，同样有第三方模块为我们提供了高效的协程，这里介绍一下greenlet和gevent。本质上，gevent是对greenlet的高级封装，因此一般用它就行，这是一个相当高效的模块。在使用它们之前，需要先安装，可以通过源码，也可以通过pip。

6.1 greenlet

from greenlet import greenlet

def test1():
    print(12)
    gr2.switch()
    print(34)
    gr2.switch()

def test2():
    print(56)
    gr1.switch()
    print(78)

gr1 = greenlet(test1)
gr2 = greenlet(test2)
gr1.switch()
实际上，greenlet就是通过switch方法在不同的任务之间进行切换。

6.2 gevent

from gevent import monkey; monkey.patch_all()
import gevent
import requests

def f(url):
    print('GET: %s' % url)
    resp = requests.get(url)
    data = resp.text
    print('%d bytes received from %s.' % (len(data), url))

gevent.joinall([
        gevent.spawn(f, 'https://www.python.org/'),
        gevent.spawn(f, 'https://www.yahoo.com/'),
        gevent.spawn(f, 'https://github.com/'),
])
通过joinall将任务f 和它的参数进行统一调度，实现单线程中的协程。代码封装层次很高，实际使用只需要了解它的几个主要方法即可。

7. 论事件驱动与异步IO

通常，我们写服务器处理模型的程序时，有以下几种模型：

每收到一个请求，创建一个新的进程，来处理该请求；
每收到一个请求，创建一个新的线程，来处理该请求；
每收到一个请求，放入一个事件列表，让主进程通过非阻塞I/O方式来处理请求
上面的几种方式，各有千秋，

第1种方法，由于创建新的进程的开销比较大，所以，会导致服务器性能比较差,但实现比较简单。
第2种方式，由于要涉及到线程的同步，有可能会面临死锁等问题。
第3种方式，在写应用程序代码时，逻辑比前面两种都复杂。
综合考虑各方面因素，一般普遍认为第3种方式是大多数网络服务器采用的方式

7.1 Select\Poll\Epoll异步IO

7.1.1 Select

select最早于1983年出现在4.2BSD中，它通过一个select()系统调用来监视多个文件描述符的数组，当select()返回后，该数组中就绪的文件描述符便会被内核修改标志位，使得进程可以获得这些文件描述符从而进行后续的读写操作。

select目前几乎在所有的平台上支持，其良好跨平台支持也是它的一个优点，事实上从现在看来，这也是它所剩不多的优点之一。

select的一个缺点在于单个进程能够监视的文件描述符的数量存在最大限制，在Linux上一般为1024，不过可以通过修改宏定义甚至重新编译内核的方式提升这一限制。

另外，select()所维护的存储大量文件描述符的数据结构，随着文件描述符数量的增大，其复制的开销也线性增长。同时，由于网络响应时间的延迟使得大量TCP连接处于非活跃状态，但调用select()会对所有socket进行一次线性扫描，所以这也浪费了一定的开销。

7.1.2 Poll

poll在1986年诞生于System V Release 3，它和select在本质上没有多大差别，但是poll没有最大文件描述符数量的限制。

poll和select同样存在一个缺点就是，包含大量文件描述符的数组被整体复制于用户态和内核的地址空间之间，而不论这些文件描述符是否就绪，它的开销随着文件描述符数量的增加而线性增大。

另外，select()和poll()将就绪的文件描述符告诉进程后，如果进程没有对其进行IO操作，那么下次调用select()和poll()的时候将再次报告这些文件描述符，所以它们一般不会丢失就绪的消息，这种方式称为水平触发（Level Triggered）。

7.1.3 epoll

直到Linux2.6才出现了由内核直接支持的实现方法，那就是epoll，它几乎具备了之前所说的一切优点，被公认为Linux2.6下性能最好的多路I/O就绪通知方法。

epoll可以同时支持水平触发和边缘触发（Edge Triggered，只告诉进程哪些文件描述符刚刚变为就绪状态，它只说一遍，如果我们没有采取行动，那么它将不会再次告知，这种方式称为边缘触发），理论上边缘触发的性能要更高一些，但是代码实现相当复杂。

epoll同样只告知那些就绪的文件描述符，而且当我们调用epoll_wait()获得就绪文件描述符时，返回的不是实际的描述符，而是一个代表就绪描述符数量的值，你只需要去epoll指定的一个数组中依次取得相应数量的文件描述符即可，这里也使用了内存映射（mmap）技术，这样便彻底省掉了这些文件描述符在系统调用时复制的开销。

另一个本质的改进在于epoll采用基于事件的就绪通知方式。在select/poll中，进程只有在调用一定的方法后，内核才对所有监视的文件描述符进行扫描，而epoll事先通过epoll_ctl()来注册一个文件描述符，一旦基于某个文件描述符就绪时，内核会采用类似callback的回调机制，迅速激活这个文件描述符，当进程调用epoll_wait()时便得到通知。

看到这里，貌似有了epoll，select之流可以退休了。但实际情况不是这样的。

windows暂时只支持seclet，它没有epoll....
select的各平台支持度比较好，API也比较通用，通俗点就是“皮实耐操通用性好舒适度差”；
epoll是linux内核原生支持的机制，虽然强大，但是各平台支持度不一样，API也差别较大，就是那种“高大上但局限性高”的东西。不过epoll显然是未来的大趋势。
