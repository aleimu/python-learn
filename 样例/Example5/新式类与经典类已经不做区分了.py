#Python中的类有经典类和新式类，新式类的属性比经典类的属性丰富。（ 如果类继object，那么该类是新式类 ）

# ############### 定义 ###############
class Goods:
    def __init__(self):                 #类方法和普通方法的区别是：类方法只能访问类变量，不能访问实例变量
        self.val2 = 'Value 2'       #公有实例变量 -->公有普通字段：对象可以访问；类内部可以访问；派生类中可以访问
        self.__val3 = 'Value 3'     #私有实例变量 -->私有普通字段：仅类内部可以访问
    @property                       #私有实例变量get属性
    def val3(self):
        return self.__val3

    @val3.setter                    #私有实例变量set属性
    def val3(self, value):
        self.__val3 = value

    @val3.deleter                   #私有实例变量del属性
    def val3(self):
        del self.__val3
# ############### 调用 ###############
obj = Goods()
result = obj.val3  # 自动执行 @property 修饰的 price 方法，并获取方法的返回值
print(obj.val3)         # 获取商品价格
obj.val3 = 200   # 修改商品原价
print(obj.val3)
del obj.val3     # 删除商品原价

"""
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

# a=(2.2323, 3.43242, 1.0)
# # b,c,d=list(a)
# # print(a,b,c,d)

# print(type(a))
# print(type([a]))
# print(hasattr(1,"__getitem__"))
# print(getattr(a,"__getitem__"))
# print(hasattr([a],"__getitem__"))

# class aaaa(object):
#     def __init__(self, *args):
#         print(*args)
#         b,c,d= list(*args)
#         print(b,c,d)

# w=aaaa(a)

# ma={"a":1,"b":2}
# print(ma.values())

self=1
# a=Test()
# print(a)
# a.a1()
# a.a2()
# a.a3()
# a.a4(self)

Test.a4(self)
"""
""" 好像3.6版本不再区分新旧类了，2.7版本还是区分的
Python 3.6.0 (v3.6.0:41df79263a11, Dec 23 2016, 07:18:10) [MSC v.1900 32 bit (Intel)] on win32
Type "copyright", "credits" or "license()" for more information.
>>> class A():
    pass

>>> dir(A)
['__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__init_subclass__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__']
>>>
>>> class B(object):
    pass

>>> dir(B)
['__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__init_subclass__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__']
>>>
>>>
"""
