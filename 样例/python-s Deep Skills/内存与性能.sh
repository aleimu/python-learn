#分析一个程序的性能，总结下来就是要回答4个问题：
1.它运行的有多块？
2.它的瓶颈在哪？
3.它占用了多少内存？
4.哪里有内存泄漏？

#基础知识
　　（1）python使用引用计数和垃圾回收来释放（free）Python对象
　　（2）引用计数的优点是原理简单、将消耗均摊到运行时；缺点是无法处理循环引用
　　（3）Python垃圾回收用于处理循环引用，但是无法处理循环引用中的对象定义了__del__的情况，而且每次回收会造成一定的卡顿
　　（4）gc module是python垃圾回收机制的接口模块，可以通过该module启停垃圾回收、调整回收触发的阈值、设置调试选项
　　（5）如果没有禁用垃圾回收，那么Python中的内存泄露有两种情况：要么是对象被生命周期更长的对象所引用，比如global作用域对象；要么是循环引用中存在__del__
　　（6）使用gc module、objgraph可以定位内存泄露，定位之后，解决很简单
　　（7）垃圾回收比较耗时，因此在对性能和内存比较敏感的场景也是无法接受的，如果能解除循环引用，就可以禁用垃圾回收。
　　（8）使用gc module的DEBUG选项可以很方便的定位循环引用，解除循环引用的办法要么是手动解除，要么是使用weakref
  
# 提高性能的几种方式：
1.使用迭代器iterator，for example：
　　dict的iteritems 而不是items（同itervalues，iterkeys）
　　使用generator，特别是在循环中可能提前break的情况
2.判断是否是同一个对象使用 is 而不是 ==
3.判断一个对象是否在一个集合中，使用set而不是list
4.利用短路求值特性，把“短路”概率过的逻辑表达式写在前面。其他的lazy ideas也是可以的
5.对于大量字符串的累加，使用join操作
6.使用for else（while else）语法
7.交换两个变量的值使用： a, b = b, a
8.减少函数的调用层次
9.优化属性查找，如果在一段代码中频繁访问一个属性（比如for循环），那么可以考虑用局部变量代替对象的属性。
10.如果程序确定是单线程，那么修改checkinterval为一个更大的值(https: // pypi.python.org / pypi / jarn.checkinterval)
11.使用__slots__, slots最主要的目的是用来节省内存，但是也能一定程度上提高性能。
12.关闭GC(不推荐)
13.使用C扩展


#对于基本类型，可以通过sys.getsizeof()来查看对象占用的内存大小

# python 内存检测工具的博客整理
http://www.cnblogs.com/lxmhhy/p/6133018.html #python性能检测工具整理
http://www.cnblogs.com/xybaby/p/7488216.html #Python内存优化
http://www.cnblogs.com/xybaby/p/7491656.html
http://3ms.huawei.com/km/blogs/details/1336379
http://3ms.huawei.com/km/groups/2833243/blogs/details/2138701?l=zh-cn
http://www.cnblogs.com/qytang/p/5580912.html

#例子1
# -*- coding: utf-8 -*-
import objgraph
import sys

class OBJ(object):
    pass

def show_direct_cycle_reference():
    a = OBJ()
    a.attr = a
    objgraph.show_backrefs(a, max_depth=5, filename="direct.dot")

def show_indirect_cycle_reference():
    a, b = OBJ(), OBJ()
    a.attr_b = b
    b.attr_a = a
    objgraph.show_backrefs(a, max_depth=5, filename="indirect.dot")

if __name__ == '__main__':
    if len(sys.argv) > 1:
        show_direct_cycle_reference()
    else:
        show_indirect_cycle_reference()
    objgraph.show_most_common_types(25) #返回Python gc管理的所有对象中，数目前N多的对象
    
    
#例子2
import tracemalloc

NUM_OF_ATTR = 10
NUM_OF_INSTANCE = 100

class Slots(object):
    __slots__ = ['attr%s' % i for i in range(NUM_OF_ATTR)]
    def __init__(self):
        value_lst = (1.0, True, [], {}, ())
        for i in range(NUM_OF_ATTR):
            setattr(self, 'attr%s' % i, value_lst[i % len(value_lst)])

class NoSlots(object):
    def __init__(self):
        value_lst = (1.0, True, [], {}, ())
        for i in range(NUM_OF_ATTR):
            setattr(self, 'attr%s' % i, value_lst[i % len(value_lst)])
def generate_some_objs():
    lst = []
    for i in range(NUM_OF_INSTANCE):
        o = Slots() if i % 2 else NoSlots()
        lst.append(o)
    return lst

if __name__ == '__main__':
    tracemalloc.start(3)
    t = generate_some_objs()
    # print(t)
    snapshot = tracemalloc.take_snapshot()
    top_stats = snapshot.statistics('lineno')  # lineno filename traceback
    print(tracemalloc.get_traced_memory())
    for stat in top_stats[:10]:
        print(stat)

"""
pytracemalloc hook住了python申请和释放内存的接口，从而能够追踪对象的分配和回收情况。
对内存分配的统计数据可以精确到每个文件、每一行代码，也可以按照调用栈做聚合分析。而且还支持快照（snapshot）功能，
比较两个快照之间的差异可以发现潜在的内存泄露。
"""
###############分析运行时间################
1.用上下文管理器来细粒度的测量时间

import time
 
class Timer(object):
    def __init__(self, verbose=False):
        self.verbose = verbose
 
    def __enter__(self):
        self.start = time.time()
        return self
 
    def __exit__(self, *args):
        self.end = time.time()
        self.secs = self.end - self.start
        self.msecs = self.secs * 1000  # millisecs
        if self.verbose:
            print 'elapsed time: %f ms' % self.msecs
为了使用它，将你想要测量时间的代码用Python关键字with和Timer上下文管理器包起来。它会在你的代码运行的时候开始计时，并且在执行结束的完成计时。

下面是一个使用它的代码片段：
from timer import Timer
from redis import Redis
rdb = Redis()
 
with Timer() as t:
    rdb.lpush("foo", "bar")
print "=> elasped lpush: %s s" % t.secs
 
with Timer as t:
    rdb.lpop("foo")
print "=> elasped lpop: %s s" % t.secs
我会经常把这些计时器的输入记录进一个日志文件来让我知道程序的性能情况。



2.用分析器一行一行地计时和记录执行频率
Robert Kern有一个很棒的项目名叫 line_profiler。我经常会用它来测量我的脚本里每一行代码运行的有多快和运行频率。
为了用它，你需要通过pip来安装这个Python包：
$ pip install line_profiler
在你安装好这个模块之后，你就可以使用line_profiler模块和一个可执行脚本kernprof.py。
为了用这个工具，首先需要修改你的代码，在你想测量的函数上使用@profiler装饰器。不要担心，为了用这个装饰器你不需要导入任何其他的东西。Kernprof.py这个脚本可以在你的脚本运行的时候注入它的运行时。
#Primes.py

@profile
def primes(n): 
    if n==2:
        return [2]
    elif n<2:
        return []
    s=range(3,n+1,2)
    mroot = n ** 0.5
    half=(n+1)/2-1
    i=0
    m=3
    while m <= mroot:
        if s[i]:
            j=(m*m-3)/2
            s[j]=0
            while j<half:
                s[j]=0
                j+=m
        i=i+1
        m=2*i+3
    return [2]+[x for x in s if x]
primes(100)
 

一旦你在你的代码里使用了@profile装饰器，你就要用kernprof.py来运行你的脚本：
$ kernprof.py -l -v fib.py
-l这个选项是告诉kernprof将@profile装饰器注入到你的脚本的内建里，-v是告诉kernprof在脚本执行完之后立马显示计时信息。


3.分析代码用了多少内存
幸运的是，Fabian Pedregosa已经完成了一个很好的memory_profiler，它模仿了Robert Kern的line_profile。

首先，用pip来安装它：
$ pip install -U memory_profiler
$ pip install psutil
（推荐安装psutils包，这是因为这能大大提升memory_profiler的性能）

跟line_profiler类似，memory_profiler需要用@profiler装饰器来装饰你感兴趣的函数，就像这样：
@profile
def primes(n): 
    ...
    ...
用一下的命令来查看你的函数在运行时耗费的内存：
$ python -m memory_profiler primes.py




