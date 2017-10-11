import threading
import time
import random

# http://www.cnblogs.com/xybaby/p/6420873.html


# 线程的私有命名空间实现

# 例子1
threading_namespace = threading.local()  # 命名空间


def print_country():
    thread_name = threading.current_thread().getName()
    country = threading_namespace.country      # 获取变量
    print('{}  {}'.format(thread_name, country))


def my_func(country):
    threading_namespace.country = country  # 设置变量

    for i in range(4):
        time.sleep(random.randrange(1, 7))
        print_country()


if __name__ == '__main__':

    countries = ['America', 'China', 'Jappen', 'Russia']

    threads = []
    for country in countries:
        threads.append(threading.Thread(target=my_func, args=(country,)))

    for t in threads:
        t.start()

    for t in threads:
        t.join()

# 例子2


class Widgt(object):
    pass

import threading


def test():
    local_data = threading.local()
    #local_data = Widgt()
    local_data.x = 1

    def thread_func():
        print('Has x in new thread: %s' % hasattr(local_data, 'x'))
        local_data.x = 2

    t = threading.Thread(target=thread_func)
    t.start()
    t.join()
    print('x in pre thread is %s' % local_data.x)

if __name__ == '__main__':
    test()

# 例子3
import threading

local = threading.local()
local.tname = "main"


def func(info):
    local.tname = info
    print(local.tname)

t1 = threading.Thread(target=func, args=['funcA'])
t2 = threading.Thread(target=func, args=['funcB'])

t1.start()
t1.join()

t2.start()
t2.join()

print(local.tname)
