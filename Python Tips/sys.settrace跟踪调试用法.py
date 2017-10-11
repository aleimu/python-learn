import sys


def test(n):
    j = 0
    for i in range(n):
        j = j + 1
    return n

"""
# 跟踪函数应该有三个参数：frame，event和arg。
# frame是当前堆栈帧,event是一个字符串：'call'，'line'，'return'，'exception'，'c_call'，'c_return'或'c_exception'。arg取决于事件类型。

事件具有以下含义：
'call'
调用一个函数（或者输入一些其他代码块）。全局跟踪功能被调用; arg是None;返回值指定本地跟踪功能。
'line'
解释器即将执行新的代码行或重新执行循环的条件。调用本地跟踪函数; arg是None;返回值指定新的本地跟踪函数。有关如何工作的详细说明，请参阅对象/ lnotab_notes.txt。
'return'
函数（或其他代码块）即将返回。调用本地跟踪函数; arg是要返回的值，如果事件是由引发的异常引起的，则返回None。跟踪函数的返回值被忽略。
'exception'
发生了例外。调用本地跟踪函数; arg是一个元组（异常，值，追溯）;返回值指定新的本地跟踪函数。
'c_call'
C函数即将被调用。这可能是扩展功能或内置的。 arg是C函数对象。
'c_return'
C函数已返回。 arg是C函数对象。
'c_exception'
C函数引发了异常。 arg是C函数对象。

"""


def tracer(frame, event, arg):
    print(event, frame.f_code.co_name, frame.f_lineno, "->", arg)
    return tracer

# trace is activated on the next call,return,or exception
sys.settrace(tracer)  # settrace(function) 设置全局调试跟踪功能。 每一个都会被呼叫函数调用。
test(1)  # disable tracing
sys.settrace(None)  # don't trace this call
print("-------------")
test(2)

"""
Trace函数|Trace装饰器
有时候出于演示目的或者调试目的，我们需要程序运行的时候打印出每一步的运行顺序 和调用逻辑。类似写bash的时候的bash -x调试功能，
当然也可以使用Python解释器内置的trace模块:python -mtrace --trace dome8.py 这样是对整个文件执行。
"""
import sys
import os
import linecache


def trace(f):
    def globaltrace(frame, why, arg):
        if why == "call":
            return localtrace
        return None
    def localtrace(frame, why, arg):
        if why == "line":
            # record the file name and line number of every trace
            filename = frame.f_code.co_filename
            lineno = frame.f_lineno
            bname = os.path.basename(filename)
            print("{}({}): {}".format(bname,
                                      lineno,
                                      linecache.getline(filename, lineno)))
        return localtrace
    def _f(*args, **kwds):
        sys.settrace(globaltrace)
        result = f(*args, **kwds)
        sys.settrace(None)
        return result
    return _f


@trace
def dome():
    print(1)
    print(22)
    print(333)

dome()
