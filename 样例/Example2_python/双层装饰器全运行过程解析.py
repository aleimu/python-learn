#两层包装,加入全局变量 和 y 用来跟踪函数运行过程
global x
x=1
def ab1(y):
    global x
    print ('begin1,x=',x)
    print("包装时的参数1:",y)
    def ab2(func):
        global x
        print ('begin2,x=',x)
        print("包装时的参数2:",y)
        def ab3(*args, **kwargs):
            global x
            content = func(*args, **kwargs)
            x=x+1
            print ('begin3,x=',x)
            print("包装时的参数3:",y)
            return content
        x=x+1
        print ('end2,x=',x)
        return ab3
    x=x+1
    print ('end1,x=',x)
    return ab2

#尝试剥离每一层装饰
test1=ab1('1111') # >>返回是的已传入11111111111的ab2函数 >>return ab2
print(type(test1)) 
print("===========0")

def hello(a,b):
       return ("a+b=",a+b)
  
test2=ab1('2222')(hello) # >>返回是的已传入hello的ab3函数 >>return ab3
print(type(test2))
print("===========1")

@ab1('3333')
# hello=ab1('3333')(hello) 结合y值的运行,可以将装饰分成两个包装步骤:
#可以理解成ab1先自己包装了'3333',返回ab1('3333')也就是ab2(func)，但fun未传入，ab1('3333')(hello)再次包装hello传入func
#返回的是 ab3(*args, **kwargs)但(*args, **kwargs)未传入，hello=ab3(*args, **kwargs)，包装后调用hello(a=1,b=2)就是传入参数的过程
def hello(a,b):
       return ("a+b=",a+b)

print("===========2")
print(hello(a=1,b=2)) #ab3函数,第一次运行，包装后就不会再运行包装外的语句
print("===========3")
print(hello(a=1,b=2)) #ab3函数,第二次运行，包装后就不会再运行包装外的语句
print("===========4")
#对比 不包装
def hello(a,b):
       return ("a+b=",a+b)

print(hello(a=1,b=2))
