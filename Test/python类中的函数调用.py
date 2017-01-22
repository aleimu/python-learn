# coding: utf-8
class MyClass:
    '''I simple example class'''
    val1 = 'Value 1'            #类变量
    val4 = 1
    def __init__(self):
        self.val2 = 'Value 2'   #公有实例变量
        self.__val3 = 'Value 3' #私有实例变量

    def __func():
        print( 'val1 : ', MyClass.val1)
        print( 'static method cannot access val2')
        print( 'static method cannot access __val3')
        print( 'val4 : ', MyClass.val4)
        MyClass.val4 = ((MyClass.val4 + 1))

    smd = staticmethod(__func)

    def __func2(cls):
        print( 'val1 : ', cls.val1)
        print( 'class method cannot access val2')
        print( 'class method cannot access __val3')
        print( 'val4 : ', cls.val4)
        cls.val4 = ((cls.val4 + 1))

    cmd = classmethod(__func2)

    def func3(self):
        print( 'val1 : ', self.val1)
        print( 'val2 : ', self.val2)
        print( 'instance method cannot access __val3')
        print( 'val4 : ', self.val4)
        self.val4 = ((self.val4 + 1))

print ('--------------------MyClass.smd()-------------------')
MyClass.smd()        #类调用静态方法
print ('--------------------MyClass.cmd()-------------------')
MyClass.cmd()        #类调用类方法
#MyClass.func3()        #类无法直接调用实例方法

x = MyClass()
print( '--------------------x.smd()-------------------')
x.smd()            #实例调用静态方法
print( '--------------------x.cmd()-------------------')
x.cmd()            #实例调用类方法
print ('--------------------x.func3()-------------------')
x.func3()        #实例调用实例方法
