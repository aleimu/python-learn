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

>> > def fun():
... print 'start...'
...  a, b = 1, 1
...  m = yield 5
... print m
... print 'middle...'
...  d = yield 12
... print d
... print 'end...'
...
>> > m = fun() // 函数未调用，而是创建一个生成器对象
>> > next(m) // 调用next()执行函数，执行到下一个yield前，返回yield后面的值, 并且保留当前区域所有变量状态a = 1, b = 1
start...
5
>> > m.send('message') // send(value)与next类似, 唤醒到上一次生成器暂停的位置执行，并把value值传给yield表达式, 即yield 5表达式的值是message
message // send()传递进来的
middle...
12
>> > next(m)
None // next()相当于send(None), 传递给yield表达式的值是None，所以d的值是None
end...
Traceback(most recent call last):
    File "<stdin>", line 1, in < module >
StopIterationf

