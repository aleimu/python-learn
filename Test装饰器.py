import time
def shoe_time(f):
    print("33333")
    def inner():
        start = time.time()
        f()
        print("22222")
        end = time.time()
        print(end-start)
    print("1111")
    return inner

def foo():
    print("foo......")
    time.sleep(1)

#嵌套函数    
print("===========0")
foo
print(type(foo))
print("===========0")    
a=shoe_time(foo)
a()
print(type(a))
print("===========0")
shoe_time(shoe_time(foo))
print("===========0")
#嵌套函数的总结：先计算最内部的表达式，一层一层剥离。
#foo 是函数,foo()是运行这个foo函数
print("===========11")
foo()    
print("===========11")    
a=shoe_time(foo())
#a()   #其实a 里什么也没接收到,所以不能运行a()函数
print('aaa:',a)
print(type(a))
print("===========11")
shoe_time(shoe_time(foo()))
print("===========11")
###############上面的例子都懂了后,开始下面的装饰器例子##################
print("===========装饰1")
foo=shoe_time(foo)  #装饰时shoe_time会运行一次,返回inner函数,给foo,其实就是用inner装饰了foo
print("===========装饰1.0")
foo()
print("===========装饰1")
#@shoe_time  等同于bar = shoe_time(bar)  
def bar():              
    print("bar......")
    time.sleep(2)

bar=shoe_time(bar)  
bar()
print("===========装饰2")
foo()       #被装饰后,函数可以重复调用，且不会失效,全靠了 return                       
bar()
foo()                              
bar()                    
                         
