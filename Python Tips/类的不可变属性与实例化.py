# 构造一个只可以删除和定义的字典类，不可以二次赋值--->主要是通过__setattr__实现------>顺便回顾一下实例和类的属性的区别
class Dict:
    '''
    通过使用__setattr__,__getattr__,__delattr__
    可以重写dict,使之通过“.”调用
    '''

    def __init__(self):
        pass

    def __setattr__(self, key, value):
        print("1self.__dict__.get(key):", self.__dict__.get(key))
        if self.__dict__.get(key) != None:
            raise NameError('not allow change value!')
        print("设置 '__setattr__")
        self.__dict__[key] = value
        print("2self.__dict__.get(key):", self.__dict__.get(key))

    def __getattr__(self, key):
        try:
            print("引用 '__getattr__")
            return self.__dict__[key]
        except KeyError as k:
            return None

    def __delattr__(self, key):
        try:
            print("删除 '__delattr__")
            self.__dict__.pop(key)
        except KeyError as k:
            return None

    # __call__方法用于实例自身的调用,达到 s(key) 调用的效果
    def __call__(self, key):    # 带参数key的__call__方法
        try:
            print("调用 '__call__'")
            return self.__dict__[key]
        except KeyError as k:
            return "In '__call__' error"

print("<===================================>实现了不可更改的属性")
s = Dict()
print(s.__dict__)
s.name = "hello"    # 调用__setattr__
# s.name = "hello"  # 触发异常 NameError('not allow change value!')
print(s.__dict__)
print(s.name)   # 调用 __getattr__
print(s('name'))  # 调用 __call__
del s.name      # 调用 __delattr__
print(s.name)   # 调用 __getattr__
print(s.name)   # 调用 __getattr__

# 下面这样的方式调用不到__XXX___内置函数..........
print("<===================================>类的属性更改会影响实例的属性")
Dict.name1 = "abcdefg"
Dict.name1 = "1234567"
print(Dict.name1)
print(id(Dict.name1))
print(Dict.__dict__)  # name1成为了Dict类的属性,所以的实例都能找到它
print("dir(Dict():", dir(Dict()))  # 有name1
print(Dict().__dict__)  # 没有name1
print(s.__dict__)       # 没有name1
print("dir(s):", dir(s))  # 有name1
print("<===================================>验证")
a = Dict()  # 新建一个实例
a.name3 = "hello"
print("a.name3:", a.name3)  # 新的实例下有name3,实例之间属性和存储是相互独立的
print("a.name1:", a.name1)  # 新的实例下有name1,name1是类新增的属性
print("s.name3:", s.name3)  # 旧的实例下没有name3
print("s.name1:", s.name1)  # 旧的实例下有name1
# 这样未实例化的类，是没有记忆的
print("<===================================>type|id")
print("type(Dict()):", type(Dict()))  # <class '__main__.Dict'>
print("id(Dict()):", id(Dict()))  # 2597904

print("type(Dict):", type(Dict))  # <class 'type'>
print("id(Dict):", id(Dict))  # 6147352

print("type(a):", type(a))  # <class '__main__.Dict'>
print("id(a):", id(a))  # 2598000
print("<===================================>tmp1")
Dict().tmp = "tmp1"
# None --->这样设置value是无效的！其实是进入了except KeyError as k: return None
print("1尝试查找设置后的值:", Dict().tmp)  # 未将实例固定下来，每次赋值都是临时的
print(id(Dict().tmp))
print("<===================================>tmp2")
Dict().tmp = "tmp2"
print("2尝试查找设置后的值:", Dict().tmp)
print(id(Dict().tmp))
