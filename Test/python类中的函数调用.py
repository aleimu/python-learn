# coding: utf-8
class MyClass:
    '''my simple example class'''
    val1 = 'Value 1'                #类变量
    val4 = 1                        #类变量
    def __init__(self):
        self.val2 = 'Value 2'       #公有实例变量
        self.__val3 = 'Value 3'     #私有实例变量

    def func3(self):                #定义实例方法
        print( 'val1 : ', self.val1)
        print( 'val2 : ', self.val2)
        print( 'instance method cannot access __val3')
        print( 'val4 : ', self.val4)
        self.val4 = ((self.val4 + 1))

    @classmethod                    #定义类方法
    def func2(cls):
        print( 'val1 : ', cls.val1)
        print( 'class method cannot access val2')
        print( 'class method cannot access __val3')
        print( 'val4 : ', cls.val4)
        cls.val4 = ((cls.val4 + 1))

    @staticmethod                   #定义静态方法
    def func():
        print( 'val1 : ', MyClass.val1)
        print( 'static cannot access val2')
        print( 'static method cannot access __val3')
        print( 'val4 : ', MyClass.val4)
        MyClass.val4 = ((MyClass.val4 + 1))

    @property                       #私有实例变量get属性
    def val3(self):
        return self.__val3

    @val3.setter                    #私有实例变量set属性
    def val3(self, value):
        self.__val3 = value

    @val3.deleter                   #私有实例变量del属性
    def val3(self):
        del self.__val3
		

print( '-------------------MyClass.func()------------------')
MyClass.func()

x = MyClass()
print( '-------------------x.func()------------------')
x.func()
print( '-------------------x.func2()------------------')
x.func2()
print( '-------------------x.func3()------------------')
x.func3()

print( '')
print( 'MyClass().val3 : ',MyClass().val3  )      #类调用property
MyClass().val3 = 'New Value'            #类调用setter
print( 'after "MyClass().val3 = New Value" val3 :', MyClass().val3)

print('')
print( 'val3 : ',x.val3 )            #实例调用property
x.val3 = 'New Value'                #实例调用setter
print( 'after "x.val3 = New Value" val3 :', x.val3 )
del x.val3                    #实例调用deleter
#print( 'after "del x.val3"  val3 : ', x.val3 )	
