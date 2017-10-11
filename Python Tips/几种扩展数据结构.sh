#关于数据结构在python中除了基础数据其他的结构都放在了collections这个库中，可以参考下面的博文
http://www.cnblogs.com/zhbzz2007/p/5986369.html
http://www.cnblogs.com/George1994/p/7204880.html

#默认字典
defaultdict{
#使用dict时，如果引用的Key不存在，就会抛出KeyError。如果希望key不存在时，返回一个默认值，就可以用defaultdict：

>>> from collections import defaultdict
>>> dd = defaultdict(lambda: 'N/A')
>>> dd['key1'] = 'abc'
>>> dd['key1'] # key1存在
'abc'
>>> dd['key2'] # key2不存在，返回默认值
'N/A'
注意默认值是调用函数返回的，而函数在创建defaultdict对象时传入。

除了在Key不存在时返回默认值，defaultdict的其他行为跟dict是完全一样的。
}

#有序字典
OrderedDict{

#使用dict时，Key是无序的。在对dict做迭代时，我们无法确定Key的顺序。如果要保持Key的顺序，可以用OrderedDict：

>>> from collections import OrderedDict
>>> d = dict([('a', 1), ('b', 2), ('c', 3)])
>>> d # dict的Key是无序的
{'a': 1, 'c': 3, 'b': 2}
>>> od = OrderedDict([('a', 1), ('b', 2), ('c', 3)])
>>> od # OrderedDict的Key是有序的
OrderedDict([('a', 1), ('b', 2), ('c', 3)])
注意，OrderedDict的Key会按照插入的顺序排列，不是Key本身排序：

>>> od = OrderedDict()
>>> od['z'] = 1
>>> od['y'] = 2
>>> od['x'] = 3
>>> od.keys() # 按照插入的Key的顺序返回
['z', 'y', 'x']

items = {'c': 3, 'b': 2, 'a': 1}
regular_dict = dict(items)
ordered_dict = OrderedDict(items)
print(regular_dict)  # {'c': 3, 'b': 2, 'a': 1}
print(ordered_dict)  # [('c', 3), ('b', 2), ('a', 1)]
# 按照插入顺序进行排序而不是
ordered_dict['f'] = 4
ordered_dict['e'] = 5
print(ordered_dict)  # [('c', 3), ('b', 2), ('a', 1), ('f', 4), ('e', 5)]
# 把最近加入的删除
print(ordered_dict.popitem(last=True))  # ('e', 5)
# 按照加入的顺序删除
print(ordered_dict.popitem(last=False))  # ('c', 3)
print(ordered_dict)  # [('b', 2), ('a', 1), ('f', 4)]
# 移动到末尾
ordered_dict.move_to_end('b', last=True)
print(ordered_dict)  # [('a', 1), ('f', 4), ('b', 2)]
# 移动到开头
ordered_dict.move_to_end('b', last=False)
print(ordered_dict)  # [('b', 2), ('a', 1), ('f', 4)]
ordered_dict['a'] = 3
# 说明更改值并不会影响加入顺序
print(ordered_dict.popitem(last=True))  # ('f', 4)
}

#元素计数
Counter{
from collections import Counter
# init
# 可迭代
counter = Counter("accab")  # Counter({'a': 2, 'c': 2, 'b': 1})
print(counter)
counter2 = Counter([1, 2, 3, 4])  # Counter({1: 1, 2: 1, 3: 1, 4: 1})
print(counter2)
counter5 = Counter([('a', 3), ('b', 2)])  # Counter({('a', 3): 1, ('b', 2): 1})
print(counter5)
# 字典
counter3 = Counter({'a': 1, 'b': 2, 'a': 3})  # Counter({'a': 3, 'b': 2})
counter4 = Counter(a=1, b=2, c=1)  # Counter({'b': 2, 'a': 1, 'c': 1})
# elements
# 键值以无序的方式返回，并且只返回值大于等于1的键值对
elememts = counter.elements()
print([x for x in elememts])  # ['a', 'a', 'c', 'c', 'b']
# 为空是因为elements是generator
print(sorted(elememts))  # []
# most_common
# 键值以无序的方式返回
print(counter.most_common(1))  # [('a', 2)]
print(counter.most_common())  # [('a', 2), ('c', 2), ('b', 1)]
# update
# 单纯是增加的功能，而不是像dict.update()中的替换一样
counter.update("abb")
print(counter)  # Counter({'a': 3, 'b': 3, 'c': 2})
# subtract
counter.subtract(Counter("accc"))
print(counter)  # Counter({'b': 3, 'a': 2, 'c': -1})
print([x for x in counter.elements()])  # ['a', 'a', 'b', 'b', 'b']
# get
# 键不存在则返回0，但是不会加入到counter键值对中
print(counter['d'])
print(counter)  # Counter({'b': 3, 'a': 2, 'c': -1})
del counter['d']
# 还可以使用数学运算
c = Counter(a=3, b=1)
d = Counter(a=1, b=2)
# add two counters together:  c[x] + d[x]
print(c + d)  # Counter({'a': 4, 'b': 3})
# subtract (keeping only positive counts)
print(c - d)  # Counter({'a': 2})
# # intersection:  min(c[x], d[x])
print(c & d)  # Counter({'a': 1, 'b': 1})
# union:  max(c[x], d[x])
print(c | d)  # Counter({'a': 3, 'b': 2})
# 一元加法和减法
c = Counter(a=3, b=-1)
# 只取正数
print(+c)  # Counter({'a': 3})
print(-c)  # Counter({'b': 1})
}

#队列
deque{
from collections import deque
# 从尾部进入，从头部弹出，保证长度为5
dq1 = deque('abcdefg', maxlen=5)
print(dq1)  # ['c', 'd', 'e', 'f', 'g']
print(dq1.maxlen)  # 5
# 从左端入列
dq1.appendleft('q')
print(dq1)  # ['q', 'c', 'd', 'e', 'f']
# 从左端入列
dq1.extendleft('abc')
print(dq1)  # ['c', 'b', 'a', 'q', 'c']
# 从左端出列并且返回
dq1.popleft()  # c
print(dq1)  # ['b', 'a', 'q', 'c']
# 将队头n个元素进行右旋
dq1.rotate(2)
print(dq1)  # ['q', 'c', 'b', 'a']
# 将队尾两个元素进行左旋
dq1.rotate(-2)
print(dq1)  # ['b', 'a', 'q', 'c']
def tail(filename, n=10):
    'Return the last n lines of a file'
    with open(filename) as f:
        return deque(f, n)
def delete_nth(d, n):
    """
    实现队列切片和删除，pop之后再放会原处
    :param d: deque
    :param n: int
    :return:
    """
    d.roatte(-n)
    d.popleft()
    d.rotate(n)
"""
deque是栈和队列的一种广义实现，deque是double-end queue的简称；deque支持线程安全、有效内存地以近似O(1)的性能在deque的两端插入和删除元素，尽管list也支持相似的操作，
但是它主要在固定长度操作上的优化，从而在pop(0)和insert(0,v)（会改变数据的位置和大小）上有O(n)的时间复杂度。

deque支持如下方法:
append(x)， 将x添加到deque的右侧；
appendleft(x)， 将x添加到deque的左侧；
clear()， 将deque中的元素全部删除，最后长度为0；
count(x)， 返回deque中元素等于x的个数；
extend(iterable)， 将可迭代变量iterable中的元素添加至deque的右侧；
extendleft(iterable)， 将变量iterable中的元素添加至deque的左侧，往左侧添加序列的顺序与可迭代变量iterable中的元素相反；
pop()， 移除和返回deque中最右侧的元素，如果没有元素，将会报出IndexError；
popleft()， 移除和返回deque中最左侧的元素，如果没有元素，将会报出IndexError；
remove(value)， 移除第一次出现的value，如果没有找到，报出ValueError；
reverse()， 反转deque中的元素，并返回None；
rotate(n)， 从右侧反转n步，如果n为负数，则从左侧反转，d.rotate(1)等于d.appendleft(d.pop())；
maxlen， 只读的属性，deque的最大长度，如果无解，就返回None；
除了以上的方法之外，deque还支持迭代、序列化、len(d)、reversed(d)、copy.copy(d)、copy.deepcopy(d)，通过in操作符进行成员测试和下标索引，索引的时间复杂度是在两端是O(1)，在中间是O(n)，为了快速获取，可以使用list代替。
"""	
	
}

#自定义tuple
namedtuple{

如果我们想要在tuple中使用名字的参数，而不是位置，namedtuple提供这么一个创建名称tuple的机会。
from collections import namedtuple
Point = namedtuple('Point', ['x', 'y'])
p = Point(10, y=20)
print(p)  # Point(x=10, y=20)
print(p.x + p.y)  # 30
}
