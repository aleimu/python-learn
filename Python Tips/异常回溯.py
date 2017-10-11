"""
sys.last_type 
sys.last_value 
sys.last_traceback 
#这三个变量并不总是定义的; 当未处理异常时，它们被设置，并且解释器打印出错误消息和堆栈追溯。 它们的目的用途是允许交互式用户导入调试器模块并进行验尸调试，
而无需重新执行导致错误的命令。--------->python shell中可以与用户交互，但不能用在脚本中?!
也许你会问，cgitb为什么会这么屌？能获取这么详细的出错信息？其实它的工作原理同它的使用方式一样的简单，
它只是覆盖了默认的sys.excepthook函数，sys.excepthook是一个默认的全局异常拦截器
"""
def func(a, b):
        return a / b

# 解释器将使用三个参数（异常类，异常实例和追溯对象）来调用sys.excepthook。
def my_exception_handler(exc_type, exc_value, exc_tb):
        print("i caught the exception:", exc_type)
        while exc_tb:
                print("the line no:", exc_tb.tb_lineno)
                print("the frame locals:", exc_tb.tb_frame.f_locals)
                exc_tb = exc_tb.tb_next

# if __name__ == '__main__':
#         import sys
#         sys.excepthook = my_exception_handler
#         import traceback
#         func(1, 0)

print("------------------")
# Python库中提供了cgitb模块来帮助做这些事情，它能够输出异常上下文所有相关变量的信息，不必每次自己再去手 动加debug log。
if __name__ == '__main__':
        import cgitb
        import sys
        cgitb.enable(format='text')
        func(1, 0)
