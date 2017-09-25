# 无限递归的正确姿势
#姿势1
def test1():
    while True:
        data = yield (gr2, 'msg from test1')
        print('test1 ', data)

def test2():
    while True:

        data = yield (gr1, 'msg from test2')
        print('test2 ', data)

gr1 = test1()
gr2 = test2()
gr1.__next__()
gr2.__next__()
def run():
    co, data = gr1, 'init'
    while True:
        co, data = co.send(data)
run()

# 姿势二
from greenlet import greenlet
def test1():
    while True:
        z = gr2.switch('msg from test1')
        print('test1 ', z)

def test2(v):
    while True:
        u = gr1.switch('msg from test2')
        print('test2 ', u)

if __name__ == '__main__':
    gr1 = greenlet(test1)
    gr2 = greenlet(test2)
    print(gr1.switch())

# python专门设置的一种机制用来防止无限递归造成Python溢出崩溃， 最大递归次数是可以重新调整的。
#（http://docs.python.org/2/library/sys.html#sys.setrecursionlimit），修改代码如下：
import sys
sys.setrecursionlimit(1500)  # set the maximum depth as 1500
def recursion(n):
    if(n <= 0):
        return
    print(n)
    recursion(n - 1)

if __name__ == "__main__":
    recursion(1200)

# 遍历的正确姿势
# Python多维/嵌套字典数据无限遍历
person = {"male": {"name": "Shawn"}, "female": {"name": "Betty", "age": 23}, "children": {
    "name": {"first_name": "李", "last_name": {"old": "明明", "now": "铭"}}, "age": 4}}
def list_all_dict(dict_a):
    if isinstance(dict_a, dict):  # 使用isinstance检测数据类型
        for x in range(len(dict_a)):
            temp_key = list(dict_a.keys())[x]
            temp_value = dict_a[temp_key]
            print("%s : %s" % (temp_key, temp_value))
            list_all_dict(temp_value)  # 自我调用实现无限遍历

list_all_dict(person)

# 递增无限列表
def increment():
    i = 0
    while True:
        yield i
        i += 1
