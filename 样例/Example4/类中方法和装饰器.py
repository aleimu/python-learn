"""
1.静态方法，可以认为是一种全局方法，因为它不需要类实例化就能访问，和模块内的方法没什么区别，可以通过类和实例进行调用，它不能访问实例变量。当然，但能够通过类名访问类变量，如MyClass.val1。
2.类方法，类似是个全局方法，它也能如静态方法那样被类调用，也能被实例调用，不同的是它通过实例来访问类变量，有类变量cls传入，并且有子类继承时，调用该类方法时，传入的类变量cls是子类，而非父类，如x.val1。
3.实例方法，实例方法只能通过实例访问，它能够访问实例变量（公有）和类变量。私有方法，无法被类和实例调用。
4.类变量，能够被类、类方法、实例和实例方法等访问。且在类和实例中进行传递（不停累加），如__val4。
5.实例变量（公有），能被实例和实例方法访问，但不能被类和类方法访问。
6.实例变量（私有），不能被任何实例访问，但我们可以通过装饰器对其增加get/set方法来进行操作，具体在下面介绍。
7.私有属性，通过在变量和方法前增加__（两个下划线）来定义。

1. _单下划线开头：弱“内部使用”标识，如：”from M import *”，将不导入所有以下划线开头的对象，包括包、模块、成员
单下划线结尾_：只是为了避免与python关键字的命名冲突
2. __双下划线开头：模块内的成员，表示私有成员，外部无法直接调用
3. __双下划线开头双下划线结尾__：指那些包含在用户无法控制的命名空间中的“魔术”对象或属性，如类成员的__name__ 、__doc__、__init__、__import__、__file__、等。推荐永远不要将这样的命名方式应用于自己的变量或函数。
4. 类名都使用首字母大写开头(Pascal命名风格)的规范。使用_单下划线开头的类名为内部使用，上面说的from M import *默认不被告导入的情况。

"""
# coding: utf-8
class MyClass:
    '''my simple example class'''
    val1 = 'Value 1'                #类变量 -->公有静态字段：类可以访问；类内部可以访问；派生类中可以访问
    __val4 = 1                        #类变量 -->私有静态字段：仅类内部可以访问
    def __init__(self):                 #类方法和普通方法的区别是：类方法只能访问类变量，不能访问实例变量
        self.val2 = 'Value 2'       #公有实例变量 -->公有普通字段：对象可以访问；类内部可以访问；派生类中可以访问
        self.__val3 = 'Value 3'     #私有实例变量 -->私有普通字段：仅类内部可以访问
        print("-------------------------------------1")

    def func3(self):                #定义实例方法
        print( 'val1 : ', self.val1)
        print( 'val2 : ', self.val2)
        print( 'instance method cannot access __val3') #类方法和普通方法的区别是：类方法只能访问类变量，不能访问实例变量
        print( '__val4 : ', self.__val4)
        self.__val4 = ((self.__val4 + 1))
        print("-------------------------------------2")

    def __func4(self):                #内部方法1
        print( 'val1 : ', self.val1)
        #print( 'val2 : ', self.val2)
        #print( 'val3 : ', self.__val3)
        print( 'instance method cannot access val2,__val3')
        print( '__val4 : ', self.__val4)
        self.__val4 = ((self.__val4 + 1))
        print("-------------------------------------3")

    def __func5():                #内部方法2
        #print( 'val1 : ', val1)
        print( 'instance method cannot access val1,__val4,__val2,__val3')
        #__val4 = (__val4 + 1)
        #print( '__val4 : ', __val4)
        print("-------------------------------------4")

    def func6():                #内部方法3
        #print( 'val1 : ', val1)
        print( 'instance method cannot access val1,__val4,__val2,__val3')
        #__val4 = (__val4 + 1)
        #print( '__val4 : ', __val4)
        print("-------------------------------------7")

    # @classmethod                    #定义类方法,self还是cls都不影响函数功能
    # def func2(cls):
    #     print( 'val1 : ', cls.val1)
    #     print( 'class method cannot access val2')
    #     print( 'class method cannot access __val3')
    #     print( '__val4 : ', cls.__val4)
    #     cls.__val4 = ((cls.__val4 + 1))

    @classmethod                    #定义类方法
    def func2(self):
        print( 'val1 : ', self.val1)
        #print( 'val2 : ', self.val2) #类方法和普通方法的区别是：类方法只能访问类变量，不能访问实例变量
        print( 'class method cannot access val2')
        print( 'class method cannot access __val3')
        print( '__val4 : ', self.__val4)
        self.__val4 = (self.__val4 + 1)
        self.__func4(self)
        print("-------------------------------------5")

    @staticmethod                   #定义静态方法
    def func():
        print( 'val1 : ', MyClass.val1)
        print( 'static cannot access val2') #类方法和普通方法的区别是：类方法只能访问类变量，不能访问实例变量
        print( 'static method cannot access __val3')
        print( '__val4 : ', MyClass.__val4)
        MyClass.__val4 = (MyClass.__val4 + 1)
        MyClass.__func5()
        print("-------------------------------------6")

    #@property 把一个方法变成一个静态属性
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
MyClass.func2()
#MyClass.__func5()
MyClass.func6()
#MyClass.func3() #类可以调用 静态方法和类方法，但不能调用实例方法

x = MyClass()
print( '-------------------x.func()------------------')
x.func()
print( '-------------------x.func2()------------------')
x.func2()
print( '-------------------x.func3()------------------')
x.func3()
#实例 x 可以调用

##@property 把一个方法变成一个静态属性
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


"""
#Python中的类有经典类和新式类，新式类的属性比经典类的属性丰富。（ 如果类继object，那么该类是新式类 ）---python3.6中已不区分

# ############### 定义 ###############
class Goods:

    @property
    def price(self):
        return "wupeiqi"
# ############### 调用 ###############
obj = Goods()
result = obj.price  # 自动执行 @property 修饰的 price 方法，并获取方法的返回值


# ############### 定义 ###############
class Goods(object):

    def __init__(self):
        # 原价
        self.original_price = 100
        # 折扣
        self.discount = 0.8

    @property
    def price(self):
        # 实际价格 = 原价 * 折扣
        new_price = self.original_price * self.discount
        return new_price

    @price.setter
    def price(self, value):
        self.original_price = value

    @price.deltter
    def price(self, value):
        del self.original_price
# ############### 调用 ###############
obj = Goods()
obj.price         # 获取商品价格
obj.price = 200   # 修改商品原价
del obj.price     # 删除商品原价


# ############### 定义 ###############
#property的构造方法中有个四个参数
class Goods(object):

    def __init__(self):
        # 原价
        self.original_price = 100
        # 折扣
        self.discount = 0.8

    def get_price(self):
        # 实际价格 = 原价 * 折扣
        new_price = self.original_price * self.discount
        return new_price

    def set_price(self, value):
        self.original_price = value

    def del_price(self, value):
        del self.original_price

    PRICE = property(get_price, set_price, del_price, '价格属性描述...')

obj = Goods()
obj.PRICE         # 获取商品价格
obj.PRICE = 200   # 修改商品原价
del obj.PRICE     # 删除商品原价

"""
