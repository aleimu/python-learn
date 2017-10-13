# 参考博客  http://www.cnblogs.com/elie/p/5876210.html


def dome1():
    class A(object):

        def foo(self, x):
            print("实例方法 foo(%s,%s)" % (self, x))
            print('self:', self)
            print('---------------foo')

        @classmethod
        def class_foo(self, x):
            print("类方法 class_foo(%s,%s)" % (self, x))  # 未加@classmethod前也是 实例方法
            print('self:', self)
            print('---------------class_foo')

        @staticmethod
        def static_foo(x):
            print("类静态方法 static_foo(%s)" % x)
            print('---------------static_foo')

    a = A()

    a.foo(1)  # 必须有 self
    a.class_foo(2)  # 有没有 @classmethod都可以调用
    a.static_foo(3)  # 必须要有 @staticmethod
    print("****************************A")
    A.class_foo(4)  # 必须要加 @classmethod
    A.static_foo(5)  # 有没有 @staticmethod 都可以调用

dome1()

print("********************************************************")


def dome2():
    # 利用描述符原理完成一个自定制@classmethod
    class ClassMethod:
        def __init__(self, func):
            self.func = func
        # 类来调用,instance为None,owner为类本身,实例来调用,instance为实例,owner为类本身,
        def __get__(self, instance, owner):
            def feedback(*args, **kwargs):
                print('在这里可以加功能啊...')
                return self.func(owner, *args, **kwargs)
            return feedback

    # 利用描述符原理完成一个自定制的 @staticmethod
    class StaticMethod:
        def __init__(self, func):
            self.func = func
        # 类来调用,instance为None,owner为类本身,实例来调用,instance为实例,owner为类本身,
        def __get__(self, instance, owner):
            def feedback(*args, **kwargs):
                print('在这里可以加功能啊...')
                return self.func(*args, **kwargs)
            return feedback
    # 测试类
    class AA(object):

        def foo(self, x):
            print("实例方法 foo(%s,%s)" % (self, x))
            print('self:', self)
            print('---------------foo')

        @ClassMethod
        def class_foo(self, x):
            print("类方法 class_foo(%s,%s)" % (self, x))  # 未加@classmethod前也是 实例方法
            print('self:', self)
            print('---------------class_foo')

        @StaticMethod
        def static_foo(x):
            print("类静态方法 static_foo(%s)" % x)
            print('---------------static_foo')

    # 实例化
    a = AA()
    a.foo(1)  # 必须有 self
    a.class_foo(2)  # 有没有 @classmethod都可以调用
    a.static_foo(3)  # 必须要有 @staticmethod
    print("****************************A")
    # 类调用
    AA.class_foo(4)  # 必须要加 @classmethod
    AA.static_foo(5)  # 有没有 @staticmethod 都可以调用

dome2()
