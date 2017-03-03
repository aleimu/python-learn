import argparse
import os
import pty
import sys
import time
def printsomething():
    print("这就是printsomething!")
	
parser = argparse.ArgumentParser(description='<<反弹shell>>',epilog="欢迎使用，遇到问题请联系 lgj")
parser.add_argument('-a', dest='append',help='记录文件日志的方式append,默认覆盖上次记录', action='store_true') #记录文件日志的方式
parser.add_argument('-p', dest='use_python',help='选择进入python', action='store_true') #-p 选择python    action='store_true' 返回的值为true or false
parser.add_argument('filename', nargs='?', default='typescript.log') #可以自己指定，也可以默认
parser.add_argument('-t', action=printsomething(),help='触发一个函数',default='-t和t是一样的')  #自定义动作

options = parser.parse_args()
print(options)
print('按 exit or exit() 退出!')
print(options.t) #Namespace(append=False, filename='typescript.log', t='-t和t是一样的', use_python=False)

shell = sys.executable if options.use_python else os.environ.get('SHELL', 'sh') #options.use_python为判断条件，为真时调用python
filename = options.filename
mode = 'ab' if options.append else 'wb'

with open(filename, mode) as script:
    def read(fd):
        data = os.read(fd, 1024)
        script.write(data)
        return data

    print('Script started, file is', filename)
    script.write(('Script started on %s\n' % time.asctime()).encode())

    pty.spawn(shell, read)

    script.write(('Script done on %s\n' % time.asctime()).encode())
    print('Script done, file is', filename)
	
	

"""样例2，精简版
import os
import pty
import time
'''
#python3.4 -c 'import pty; pty.spawn("/bin/bash")' #下面的各种形式都不对，第二个参数应该是函数

#python3.4 -c 'import pty,os; pty.spawn("/bin/bash",open("log.sh","ab").write(str(os.read(os.getuid(),1024))))' #只能执行一句话
#spawn("/bin/bash", master_read=, stdin_read=) #参数是function
'''	

with open('lgj.log','ab') as script:
    def read(fd):
        data = os.read(fd, 1024)
        script.write(data)
        return data
    pty.spawn('/bin/bash', read)

	
"""	

'''
ArgumentParser.add_argument(name or flags...[, action][, nargs][, const][, default][, type][, choices][, required][, help][, metavar][, dest])
定义应该如何解析一个命令行参数。下面每个参数有它们自己详细的描述，简单地讲它们是：

name or flags - 选项字符串的名字或者列表，例如foo 或者-f, --foo。 #可选的参数将以 - 前缀标识，剩余的参数将被假定为位置参数
action - 在命令行遇到该参数时采取的基本动作类型。#action='store_true' 返回的值为true or false
nargs - 应该读取的命令行参数数目。
const - 某些action和nargs选项要求的常数值。
default - 如果命令行中没有出现该参数时的默认值。
type - 命令行参数应该被转换成的类型。
choices - 参数可允许的值的一个容器。
required - 该命令行选项是否可以省略（只针对可选参数）。
help - 参数的简短描述。
metavar - 参数在帮助信息中的名字。
dest - 给 parse_args() 返回的对象要添加的属性名称。 
'''



	
