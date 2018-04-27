def fab(max):
    n, a, b = 0, 0, 1
    while n < max:
        yield b
        # print b
        a, b = b, a + b
        n = n + 1

for n in fab(5):
    print(n)


# 简单地讲，yield 的作用就是把一个函数变成一个 generator，带有 yield 的函数不再是一个普通函数，
# Python 解释器会将其视为一个 generator，调用 fab(5) 不会执行 fab 函数，而是返回一个 iterable 对象！在 for 循环执行时，
# 每次循环都会执行 fab 函数内部的代码，执行到 yield b 时，fab 函数就返回一个迭代值，下次迭代时，代码从 yield b 的下一条语句继续执行，
# 而函数的本地变量看起来和上次中断执行前是完全一样的，于是函数继续执行，直到再次遇到 yield。

# python yield用法总结
# http://www.cnblogs.com/python-life/articles/4549996.html

def read_file(fpath):
    BLOCK_SIZE = 5
    with open(fpath, 'rb') as f:
        while True:
            block = f.read(BLOCK_SIZE)
            if block:
                yield block
            else:
                return

for x in read_file("./1.py"):
    print(x)

# 当一个函数中含有yield时, 它不再是一个普通的函数, 而是一个生成器.当该函数被调用时不会自动执行, 而是暂停,
# 调用函数.next()才会被执行,如一个函数中出现多个yield则next()会停止在下一个yield前

#-*- coding:utf-8 -*-
def test1():
    def fun():
        print 'start'
        a = yield 5
        print a
        print 'middle'
        b = yield 12
        print b
        c = yield 12
        print c
        print 'end'

    m = fun()                               #创建一个对象
    print("-----------------")
    print("return:",m.next())               #会使函数执行到一个yield,并停下
    print("-----------------")
    print("return:",m.send('message'))      #利用send()传递值
    print("-----------------")
    print("return:",m.close())              #throw() 与 close()中断 Generator
    print("return:",m.next())
    print("-----------------")

def test2():
    def gen():
        for x in range(5):
            print("x3:", x)
            y = yield x
            print("x,y:", x, y)
            print("---------")

    a = gen()
    for x in a: # 开始迭代 Generator 时就会执行 print("x3:", x),相当于x = a.next()
        print("x1:", x)
        if x == 2:
            print("x=2:", x)
            print("get next:", a.send("lgj"))
            # 获取了下一个yield表达式的参数,也就是3-->导致a的迭代直接少了x=3的片段-->跳过了print("x1:", x)--->也就是说send包含了next的迭代功能同时也有传送值给y的功能
            # g.next()和g.send(None)是相同的 ,send(msg) 和 next()是有返回值的，它们的返回值很特殊，返回的是下一个yield表达式的参数
        print("x2:", x)
