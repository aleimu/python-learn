Python 3.6.0 (v3.6.0:41df79263a11, Dec 23 2016, 07:18:10) [MSC v.1900 32 bit (Intel)] on win32
Type "copyright", "credits" or "license()" for more information.
>>> a=[1,2,3,6,7,5]
>>> b=a.__iter__()
>>> next(b)
1
>>> next(b)
2
>>> next(b)
3
>>> next(b)
6
>>> next(b)
7
>>> next(b)
5
>>> next(b)
Traceback (most recent call last):
  File "<pyshell#8>", line 1, in <module>
    next(b)
StopIteration
>>> b=a.__iter__()
>>> b.__next__()
1
>>> b.__next__()
2
>>> b.__next__()
3
>>> b.__next__()
6
>>> b.__next__()
7
>>> b.__next__()
5
>>> b.__next__()
Traceback (most recent call last):
  File "<pyshell#16>", line 1, in <module>
    b.__next__()
StopIteration
>>> b.__next__()
Traceback (most recent call last):
  File "<pyshell#17>", line 1, in <module>
    b.__next__()
StopIteration
>>>
>>> a
[1, 2, 3, 6, 7, 5]
>>> next(a)
Traceback (most recent call last):
  File "<pyshell#20>", line 1, in <module>
    next(a)
TypeError: 'list' object is not an iterator
>>> type(a)
<class 'list'>
>>> type(b)
<class 'list_iterator'>
>>>
当使用for ... in ... 来遍历元素时候，实际上python内部会使用内置函数iter获得可迭代对象的迭代器，在迭代器上重复使用next来调用可迭代对象的下一个元素。

__iter()__:   用来返回一个迭代器
__next()__:  用来生成下一个值
对于一个对象，如果实现了__iter()__就是可迭代的，如果实现了__next__就是迭代器。
list是可迭代对象，但不是迭代器，因为只实现了__iter__，但是可以根据__iter__返回的迭代器访问list中的所有元素。
