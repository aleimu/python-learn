# 1. 普通装饰漆，单功能附加，任意参数，需要2个return
def debug(func):
    def wrapper(*args, **kwargs):  # 指定宇宙无敌参数
        print ("[DEBUG]: enter {}()".format(func.__name__))
        print ('Prepare and say...')
        return func(*args, **kwargs)
    return wrapper  # 返回

@debug
def say(something):
    print ("hello {}!".format(something))

say('hello，1层装饰器') 

# 2. 两层装饰
#进入某个函数后打出log信息，而且还需指定log的级别
def logging(level):
    def wrapper(func):
        def inner_wrapper(*args, **kwargs):
            print ("[{level}]: enter function {func}()".format( level=level, func=func.__name__))
            return func(*args, **kwargs)
        return inner_wrapper
    return wrapper
#需要3个return
@logging(level='INFO')
def say(something):
    print ("say {}!".format(something))

# 如果没有使用@语法，等同于
# say = logging(level='INFO')(say)
#@logging(level='DEBUG')，它其实是一个函数，会马上被执行，它返回的结果是一个装饰器，再去装饰do()
@logging(level='DEBUG')
def do(something):
    print ("do {}...".format(something))

print("2层装饰器")
say('hello')
do("my work")


# 3. 带参数的类装饰器
class logging(object):
    def __init__(self, level='INFO'):
        self.level = level
        
    def __call__(self, func): # 接受函数
        def wrapper(*args, **kwargs):
            print( "[{level}]: enter function {func}()".format( level=self.level, func=func.__name__))
            func(*args, **kwargs)
        return wrapper  #返回函数

@logging(level='INFO')
def say(something):
    print ("say {}!".format(something) )

say('hello，类装饰器！')

# 4. 包装时需要几个return ，以及包装函数中，各层次的运行顺序  举例如下：
def html_tags(tag_name):
    print ('begin 1')
    def wrapper_(func):
        print ('begin 2')
        def wrapper(*args, **kwargs):
            content = func(*args, **kwargs)
            print ("<{tag}>{content}</{tag}>".format(tag=tag_name, content=content))
        print ('end 2')
        return wrapper
    print ('end 1')
    return wrapper_

@html_tags('b')
def hello(name='Toby'):
    return 'Hello {}!'.format(name)

#print(hello())
#print(hello())

#不包装
def hello(name='Toby'):
    return 'Hello {}!'.format(name)

#print(hello())

#上面的包装方式，少了一个return，包装时代参数后被包装的函数有返回值时被包装后会被改变成无返回值的函数
#两层包装

def a_b(tag_name):
    print ('begin 1')
    def ab(func):
        print ('begin 2')
        def and1(*args, **kwargs):
            content = func(*args, **kwargs)
            return content
        print ('end 2')
        return and1
    print ('end 1')
    return ab

@a_b('b')
def hello(a=1,b=2):
       return ("a+b=",a+b)

print(hello())
print(hello())

#不包装
def hello(a=1,b=2):
       return ("a+b=",a+b)

print(hello())

#对比可知，代参数包装时，应该加三个return
