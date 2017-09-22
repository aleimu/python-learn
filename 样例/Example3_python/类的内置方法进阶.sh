#!/usr/bin/python
# -*- coding: UTF-8 -*-
# http://www.cnblogs.com/linhaifeng/articles/6204014.html#_label7
__str__,__repr__,__format__{
#例子1
class Fruit:
    '''Fruit类'''  # 为Fruit类定义了文档字符串__doc__
    def __str__(self):          # 定义对象的字符串表示
        return self.__doc__
fruit = Fruit()
print(str(fruit))            # 调用内置函数str()出发__str__()方法，输出结果为:Fruit类
print(fruit)  # 直接输出对象fruit,返回__str__()方法的值，输出结果为:Fruit类

#例子2
format_dict = {
    'nat': '{obj.name}-{obj.addr}-{obj.type}',  # 学校名-学校地址-学校类型
    'tna': '{obj.type}:{obj.name}:{obj.addr}',  # 学校类型:学校名:学校地址
    'tan': '{obj.type}/{obj.addr}/{obj.name}',  # 学校类型/学校地址/学校名
}
class School:
    def __init__(self, name, addr, type):
        self.name = name
        self.addr = addr
        self.type = type
    def __repr__(self):
        return 'School(%s,%s)' % (self.name, self.addr)

    def __str__(self):
        return '(%s,%s)' % (self.name, self.addr)

    def __format__(self, format_spec):
        # if format_spec
        if not format_spec or format_spec not in format_dict:
            format_spec = 'nat'
        fmt = format_dict[format_spec]
        return fmt.format(obj=self)

s1 = School('oldboy1', '北京', '私立')
print('from repr: ', repr(s1))
print('from str: ', str(s1))
print(s1)

'''
str函数或者print函数--->obj.__str__()
repr或者交互式解释器--->obj.__repr__()
如果__str__没有被定义,那么就会使用__repr__来代替输出
注意:这俩方法的返回值必须是字符串,否则抛出异常
'''
print(format(s1, 'nat'))
print(format(s1, 'tna'))
print(format(s1, 'tan'))
print(format(s1, 'asfdasdffd'))
print("===================================")
}
__new__{

#例子1
class Singleton(object):
    __instance = None                       # 定义实例

    def __init__(self):
        print("2")

    def __new__(cls, *args, **kwd):         # 在__init__之前调用
        print("1")
        if Singleton.__instance is None:    # 生成唯一实例
            Singleton.__instance = object.__new__(cls, *args, **kwd)
        return Singleton.__instance

singleton = Singleton()
print("===================================")
}
__getitem__,__setitem__,__delitem__ 字典类的内置方法{

# 例子1
class Foo:
    def __init__(self, name):
        self.name = name

    def __getitem__(self, item):
        print(self.__dict__[item])

    def __setitem__(self, key, value):
        self.__dict__[key] = value

    def __delitem__(self, key):
        print('del obj[key]时,我执行')
        self.__dict__.pop(key)

    def __delattr__(self, item):
        print('del obj.key时,我执行')
        self.__dict__.pop(item)

f1 = Foo('sb')
f1['age'] = 18
f1['age1'] = 19
del f1.age1
del f1['age']
f1['name'] = 'alex'
print(f1.__dict__)

# 例子2
class A(dict):
    def __getitem__(self, key):
        print('__getitem__')
        return super(A, self).__getitem__(key)

    def __setitem__(self, key, value):
        print('__setitem__')
        return super(A, self).__setitem__(key, value)

    def __delitem__(self, key):
        print('__delitem__')
        return super(A, self).__delitem__(key)

a = A()
a[1] = 1
print(a[1])
del a[1]
print(a.get(1))

# 上面的代码中a[1] = 1实际上调用的就是a.__setitem__(1, 1), a[1]调用的是a.__get__item__(1),
# del a[1]调用的是a.__setitem__(1)。需要注意的是，字典示例的get方法和__getitem__方法不存在调用关系，两者互不影响。

print("===================================")
}
__getattribute__,__setattr__,__getattr__,__delattr__ 对象示例中成员变量的方法{

#例子1
class A(object):
    x = []

    def __getattribute__(self, name):
        print('__getattribute__')
        return super(A, self).__getattribute__(name)

    def __setattr__(self, key, value):
        print('__setattr__')
        return super(A, self).__setattr__(key, value)

    def __getattr__(self, item):
        print('__getattr__')

    def __delattr__(self, item):
        print('__delattr__')
        return super(A, self).__delattr__(item)

a = A()
print("----------1")
a.x
print("----------2")
a.y
print("----------3")
b = getattr(a, 'x')
print("----------4")
b = getattr(a, 'y')
print("----------5")
a.x = 1
print("----------6")
a.y = 1
print("----------7")
setattr(a, 'x', 1)
print("----------8")
setattr(a, 'y', 1)
print("----------9")
del a.x
print("----------10")
del a.y

"""
__getattribute__和__getattr__都是从python对象示例中获取成员变量的方法，
差别在于__getattribute__在任何时候都会调用，而__getattr__只有在__getattribute__执行完成之后并且没有找到成员变量的时候才会执行。
__setattr__在给成员变量赋值的时候调用
__delattr__在回收成员变量的时候调用

----------1
__getattribute__
----------2
__getattribute__
__getattr__     #y不是a的成员变量，在调用a.__getattribue__('y')之后还会调用a.__getattr__('y')
----------3
__getattribute__
----------4
__getattribute__
__getattr__
----------5
__setattr__
----------6
__setattr__
----------7
__setattr__
----------8
__setattr__
----------9
__delattr__
----------10
__delattr__
"""

print("===================================")
}
__call__{
# 所有的函数都是可调用对象。
# 一个类实例也可以变成一个可调用对象，只需要实现一个特殊方法__call__()--> 模糊了函数和对象之间的概念
# 相当于 重载了括号运算符,__call__是模拟()的调用

# 例子1
class Fib(object):
    def __init__(self):
        pass

    def __call__(self, num):
        a, b = 0, 1
        self.l = []

        for i in range(num):
            self.l.append(a)
            a, b = b, a + b
        return self.l

    def __str__(self):
        return str(self.l)
    __rept__ = __str__

f = Fib()
print(f(10))
print(Fib()(10))


# 例子2
class test:
    def __init__(self, a):
        self.a = a

    def __call__(self, b):
        c = self.a + b
        print(c)

    def display(self):
        print(self.a)

Test = test("This is test!")
Test.display()
Test("##Append something")

print("===================================")

}
__get__,__set__,__delete__{
# 描述符(__get__,__set__,__delete__)
# 描述符是什么:描述符本质就是一个新式类,在这个新式类中,至少实现了__get__(),__set__(),__delete__()中的一个,这也被称为描述符协议
# __get__():调用一个属性时,触发
# __set__():为一个属性赋值时,触发
# __delete__():采用del删除属性时,触发
# 静态属性property本质就是实现了get，set，delete三种方法

# 例子1
class AA(object):

    def __get__(self, instance, owner):
        print('__get__')

    def __set__(self, instance, value):
        print('__set__')


class B(object):
    a = AA()

b = B()
c = b.a
b.a = 1
print("----------")
f = B()
g = f.a
f.a = 2
print("----------")
print(f.a)
print(b.a)

print("----------")


# 例子2
class Descriptor(object):
    def __get__(self, obj, type=None):
        return 'get', self, obj, type

    def __set__(self, obj, val):
        print('set', self, obj, val)

    def __delete__(self, obj):
        print('delete', self, obj)


class T(object):
    d = Descriptor()

t = T()
t.d = 1
print(t.d)
del t.d


# 例子3
# 利用描述符原理完成一个自定制@classmethod
class ClassMethod:
    def __init__(self, func):
        self.func = func

    def __get__(self, instance, owner):  # 类来调用,instance为None,owner为类本身,实例来调用,instance为实例,owner为类本身,
        def feedback(*args, **kwargs):
            print('在这里可以加功能啊...')
            return self.func(owner, *args, **kwargs)
        return feedback


class People:
    name = 'linhaifeng'

    @ClassMethod  # say_hi=ClassMethod(say_hi)
    def say_hi(cls, msg):
        print('你好啊,帅哥 %s %s' % (cls.name, msg))

People.say_hi('你是那偷心的贼')

p1 = People()
p1.say_hi('你是那偷心的贼')

#例子4
# 利用描述符原理完成一个自定制的 @staticmethod
class StaticMethod:
    def __init__(self, func):
        self.func = func

    def __get__(self, instance, owner):  # 类来调用,instance为None,owner为类本身,实例来调用,instance为实例,owner为类本身,
        def feedback(*args, **kwargs):
            print('在这里可以加功能啊...')
            return self.func(*args, **kwargs)
        return feedback


class People:
    @StaticMethod  # say_hi=StaticMethod(say_hi)
    def say_hi(x, y, z):
        print('------>', x, y, z)

People.say_hi(1, 2, 3)

p1 = People()
p1.say_hi(4, 5, 6)

print("===================================")
}
__slots__{
# 可以作为一个封装工具来防止用户给实例增加新的属性。尽管使用__slots__可以达到这样的目的,但是这个并不是它的初衷。更多的是用来作为一个内存优化工具。
#例子1
class Foo:
    __slots__ = 'x'


f1 = Foo()
f1.x = 1
f1.y = 2  # 报错
print(f1.__slots__)  # f1不再有__dict__

#例子2
class Bar:
    __slots__ = ['x', 'y']

n = Bar()
n.x, n.y = 1, 2
n.z = 3  # 报错

print("===================================")

}
__all__{
# 模块级别暴露接口 __all__
import os
import sys

__all__ = ["process_xxx"]  # 排除了 `os` 和 `sys`
def process_xxx():
    pass  # omit

print("===================================")

}
__get__, __getattr__, __getattribute__的区别{
#python中__get__, __getattr__, __getattribute__的区别

__get__, __getattr__和__getattribute都是访问属性的方法，但不太相同。
object.__getattr__(self, name)
当一般位置找不到attribute的时候，会调用getattr，返回一个值或AttributeError异常。

object.__getattribute__(self, name)
无条件被调用，通过实例访问属性。如果class中定义了__getattr__()，则__getattr__()不会被调用（除非显示调用或引发AttributeError异常）

object.__get__(self, instance, owner)
如果class定义了它，则这个class就可以称为descriptor。owner是所有者的类，instance是访问descriptor的实例，如果不是通过实例访问，而是通过类访问的话，instance则为None。（descriptor的实例自己访问自己是不会触发__get__，而会触发__call__，只有descriptor作为其它类的属性才有意义。）（所以下文的d是作为C2的一个属性被调用）

#例子1
class C(object):
    a = 'abc'

    def __getattribute__(self, *args, **kwargs):
        print("__getattribute__() is called")
        return object.__getattribute__(self, *args, **kwargs)
#       return "haha"

    def __getattr__(self, name):
        print("__getattr__() is called ")
        return name + " from getattr"

    def __get__(self, instance, owner):
        print("__get__() is called", instance, owner)
        return self

    def foo(self, x):
        print(x)


class C2(object):
    d = C()

if __name__ == '__main__':
    c = C()
    c2 = C2()
    print(c.a)
    print(c.zzzzzzzz)
    c2.d
    print(c2.d.a)


#输出结果是：
__getattribute__() is called
abc
__getattribute__() is called
__getattr__() is called
zzzzzzzz from getattr
__get__() is called < __main__.C2 object at 0x16d2310 > <class '__main__.C2' >
__get__() is called < __main__.C2 object at 0x16d2310 > <class '__main__.C2' >
__getattribute__() is called
abc

小结：可以看出，每次通过实例访问属性，都会经过__getattribute__函数。而当属性不存在时，仍然需要访问__getattribute__，不过接着要访问__getattr__。这就好像是一个异常处理函数。
每次访问descriptor（即实现了__get__的类），都会先经过__get__函数。
需要注意的是，当使用类访问不存在的变量是，不会经过__getattr__函数。而descriptor不存在此问题，只是把instance标识为none而已。
}
