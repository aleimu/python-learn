#同过cgitb 异常调试
def func(a, b):
        return a / b
if __name__ == '__main__':
        import cgitb
        cgitb.enable(format='text')
        #import sys
        #import traceback
        func(1, 0)

#同sys.excepthook 异常调试
def my_exception_handler(exc_type, exc_value, exc_tb):
        print ("i caught the exception:", exc_type)
        while exc_tb:
                print ("the line no:", exc_tb.tb_lineno)
                print ("the frame locals:", exc_tb.tb_frame.f_locals)
                exc_tb = exc_tb.tb_next

if __name__ == '__main__':
        import sys
        sys.excepthook = my_exception_handler
        import traceback
        func(1, 0)

# """
# traceback.print_exc(limit =2,file = open(r"D:\taclog.txt","w"))将错误打印到文件,不带参数print_exc()则直接给打印出来，来代替print e 可以输出异常的详细信息。
# 又不产生程序中断和用户界面不想看到的带红字错误。
# traceback.format_exc() 将错误以字符串形式输出
# traceback.extract_stack()元素为元组，输出为列表，每个为栈的入口。
# """

#通过 traceback 异常调试。应该算是异常的输出设置
import traceback
import sys
def func(a,b):
    c = a/b
    print c
a = []
try:
    func(10,0)
except Exception as e:
    print e
    print "str=",traceback.format_exc()
    traceback.print_exc(limit =2,file = open(r"D:\taclog.txt","w"))
    #print "list=",traceback.format_list(traceback.extract_stack())
    print traceback.extract_stack()
print "continue "
f = open(r"D:\taclog.txt","r")
t = f.read()
print t


# >>>
# integer division or modulo by zero
# str= Traceback (most recent call last):
#   File "C:/Python27/tra.py", line 8, in <module>
#     func(10,0)
#   File "C:/Python27/tra.py", line 4, in func
#     c = a/b
# ZeroDivisionError: integer division or modulo by zero

# [('<string>', 1, '<module>', None), ('C:\\Python27\\lib\\idlelib\\run.py', 97, 'main', 'ret = method(*args, **kwargs)'), ('C:\\Python27\\lib\\idlelib\\run.py', 298, 'runcode', 'exec code in self.locals'), ('C:/Python27/tra.py', 14, '<module>', 'print traceback.extract_stack()')]
# continue
# Traceback (most recent call last):
#   File "C:/Python27/tra.py", line 8, in <module>
#     func(10,0)
#   File "C:/Python27/tra.py", line 4, in func
#     c = a/b
# ZeroDivisionError: integer division or modulo by zero

# >>>

