#参考博客
http://www.cnblogs.com/xybaby/p/7183854.html
http://www.cnblogs.com/wilber2013/p/5178620.html

1. 以可变对象作为默认参数{

默认参数确实是个好东西，可以让函数调用者忽略一些细节（比如GUI编程，Tkinter，QT），对于lambda表达式也非常有用。但是如果使用了可变对象作为默认参数，需要注意场合:
　　>>> def f(lst = []):
　　...     lst.append(1)
　　...     return lst
　　...
　　>>> f()
　　[1]
　　>>> f()
　　[1, 1]
　　
究其原因，python中一切都是对象，函数也不列外，默认参数只是函数的一个属性。而默认参数在函数定义的时候已经求值了。
#Default parameter values are evaluated when the function definition is executed. 
stackoverflow上有一个更适当的例子来说明默认参数是在定义的时候求值，而不是调用的时候。
　　>>> import time
　　>>> def report(when=time.time()):
　　...     return when
　　... 
　　>>> report()
　　1500113234.487932
　　>>> report()
　　1500113234.487932
python docoment 给出了标准的解决办法：
#A way around this is to use None as the default, and explicitly test for it in the body of the function
　　
　　>>> def report(when=None):
　　...     if when is None:
　　...             when = time.time()
　　...     return when
}

2. lambda的绑定{

>>> def create():
...     return [lambda x: x * i for i in range(5)]
... 
>>> for i in create():
...     i(2)
... 
8
8
8
8
8

#这是后期绑定(late binding)导致的，这是指内层函数被执行时，才会去查找该变量的值。请注意上面讲的，for循环会导致变量泄漏，所以当函数执行的时候,i已经等于4了。上面的代码等价于:
>>> def create():
...     result = []
...     for i in range(5):
...         def lala(x):
...             return x * i
...         result.append(lala)
...     return result

#解决方法：带默认函数的函数将会在函数定义时完成赋值,y应该立即绑定
>>> def create():
...     return [lambda x, y=i: x * y for i in range(5)]
... 
>>> for i in create():
...     i(2)
... 
0
2
4
6
8

}

3. x =x + y vs x += y{

一般来说，二者是等价的，至少看起来是等价的（这也是陷阱的定义 -- 看起来都OK，但不一定正确）。

具体分数据类型来看:

#对于int
>>> a=1
>>> id(a)
10055552
>>> a=a+1
>>> id(a)
10055584
>>> 
>>> a
2
>>> a+=1
>>> id(a)
10055616
>>> a
3

#对于list
　　>>> x=[1];print id(x);x=x+[2];print id(x)
　　4357132800
　　4357132728
　　>>> x=[1];print id(x);x+=[2];print id(x)
　　4357132800
　　4357132800
　　
#x=x+[2]中x指向一个新的对象，x+=[2]中x是对原来的对象的修改，当然，那种效果是正确的取决于应用场景。至少，得知道二者有时候并不一样

>>> a=[1,2,3]
>>> id(a)
140630101328456
>>> a+=[4]
>>> id(a)
140630101328456
>>> a=a+[5]
>>> id(a)
140630101432008

#对于tuple
>>> t = ([],)
>>> t[0] += [2, 3]
Traceback (most recent call last):
  File "<input>", line 1, in ?
TypeError: object does not support item assignment
>>> t
([2, 3],)
#元组不支持对其中元素的赋值——但是在对他使用+=后，元组里的list确实改变了！原因依然是+=就地改变list的值。但是元组的赋值不被允许，当异发生时，元组中的list已经被就地改变了。

#解决方法：避免使用+=，或者仅仅在整数时使用它。
}

4. UnboundLocalError{
>>> a=1
>>> def f():
...     a+=1
... 
>>> f()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 2, in f
UnboundLocalError: local variable 'a' referenced before assignment
>>> 

a = [1, 2, 3]
def f():
    a = a + 1
    print(a)

def f1():
    a += 1
    print(a)

f()
f1()


#在一个作用域里面给一个变量赋值的时候，Python会认为这个变量是当前作用域的本地变量，无论变量的类型！
}

5. 生成一个元素是列表的列表{
这个有点像二维数组，当然生成一个元素是字典的列表也是可以的，更通俗的说，生成一个元素是可变对象的序列
　　>>> a= [[]] * 10
　　>>> a
　　[[], [], [], [], [], [], [], [], [], []]
　　>>> a[0].append(10)
　　>>> a[0]
　　[10]
　　>>> a[1]
　　[10]
　　>>> a
　　[[10], [10], [10], [10], [10], [10], [10], [10], [10], [10]]
　　究其原因，还是因为python中list是可变对象，上述的写法大家都指向的同一个可变对象:
	>>> id(a[1])
	139683273394440
	>>> id(a[2])
	139683273394440
	>>> id(a[3])
	139683273394440
	#正确的姿势:
　　>>> a = [[] for _ in xrange(10)]
　　>>> a[0].append(10)
　　>>> a
　　[[10], [], [], [], [], [], [], [], [], []]
 
另外一个在实际编码中遇到的问题，dict.fromkeys, 也有异曲同工之妙： 创建的dict的所有values指向同一个对象。
fromkeys(seq[, value]) # Create a new dictionary with keys from seq and values set to value.　
}	

6. 深浅copy{

深浅copy的区别体现在可变元素中包含可变元素时，下面的操作的时候，会产生浅拷贝的效果：
1. 使用切片[:]操作
2. 使用工厂函数（如list/dir/set）
3. 使用copy模块中的copy()函数

import copy

will = ["Will", 28, ["Python", "C#", "JavaScript"]]
wilber = copy.copy(will)
will = ["Will", 28, ["Python", "C#", "JavaScript"]]
wilber = copy.deepcopy(will)


}
	
7. 元组与小括号{

小括号（parenthese）在各种编程语言中都有广泛的应用，python中，小括号还能表示元组（tuple）这一数据类型, 元组是immutable的序列。
　　>>> a = (1, 2)
　　>>> type(a)
　　<type 'tuple'>
　　>>> type(())
　　<type 'tuple'>
　　但如果只有一个元素呢
　　>>> a=(1)
　　>>> type(a)
　　<type 'int'>

>>> t = ([],)
>>> t[0] += [2, 3]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'tuple' object does not support item assignment
>>> t
([2, 3],)
#元组不支持对其中元素的赋值——但是在对他使用+=后，元组里的list确实改变了！原因依然是+=就地改变list的值。但是元组的赋值不被允许，当异发生时，元组中的list已经被就地改变了。
 　　
#如果要表示只有一个元素的元组，正确的姿势是:
　　>>> a=(1,)
　　>>> type(a)
　　<type 'tuple'>
}

8. tuple是'可变的'{
在Python中，tuple是不可变对象，但是这里的不可变指的是tuple这个容器总的元素不可变（确切的说是元素的id），但是元素的值是可以改变的。
tpl = (1, 2, 3, [4, 5, 6])
print id(tpl)
print id(tpl[3])
tpl[3].extend([7, 8])
print tpl
print id(tpl)
print id(tpl[3])


36764576
38639896
(1, 2, 3, [4, 5, 6, 7, 8])
36764576
38639896
}

9. 在访问列表的时候，修改列表{

a = [0, 9, 8, 8, 8, 7, 6, 5, 4, 3, 2, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
# 出现漏删的情况都是两个偶数在一起的时候

#错误的姿势
def ff(li):
    for x, y in enumerate(li):
        if y % 2 == 0:
            print(x)
            print(li)
            del li[x]

#原处删除偶数
def ff2(li):
    global sub, ss
    for x, y in enumerate(li):
        sub = sub + 1
        if y % 2 == 0:
            ss = ss + 1
            del li[x]
            for m, n in enumerate(li):
                sub = sub + 1
                if n % 2 == 0:
                    ss = ss + 1
                    #del li[m]
                    li.pop(m)

print(id(a))
ff2(a)
print(id(a))
print(a)

# 使用过度列表
tmp = []
def ff3(li):
    for x in li:
        if x % 2 != 0:
            tmp.append(x)
ff3(a)
print(tmp)

# 使用列表推导 应对简单的列表修改很方便
tmp2 = [x for x in a if x % 2 != 0]
print(tmp2)

}

10. py版本之间的坑{
在python2.7中，range的返回值是一个列表；而在python3.x中，返回的是一个range对象。
map()、filter()、 dict.items()在python2.7返回列表，而在3.x中返回迭代器。当然迭代器大多数都是比较好的选择，更加pythonic，但是也有缺点，就是只能遍历一次。
}


