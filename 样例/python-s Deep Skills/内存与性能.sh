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
