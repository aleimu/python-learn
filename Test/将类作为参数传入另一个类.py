
class a1():
      global p
      def __init__(self,master=None):
            p.c() #期望将a2传入到这里，可以直接调用c()
      def a(self):
            print('a1')
      def b(self):
            print('b')


class a2():
      def c(self):
            print('c')

print("-------")
p=a2()
q=a1(p.c())
print("-------")

#经常会发生这样的错 AttributeError: 'NoneType' object has no attribute 'c'

class a3():
      c=1
      #global p
      def __init__(self,master=None):
            print("a3进程初始化")
            self.master=master
      def a(self):
            self.master.c()
            print('a1')
      def b(self):
            print('b')


class a4():
      def __init__(self):
            print("a4进程初始化")
      def c(self):
            print('c')

p=a4()
print("-------")
#将a4类的实例传出入类a3中，实例化a3后再调用a4中的函数（不通过继承实现）
q=a3(p).a()
print("-------")
'''
a4进程初始化
-------
a3进程初始化
c
a1
-------
'''
