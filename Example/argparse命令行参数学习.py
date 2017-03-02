import argparse

def get_args():
    parser = argparse.ArgumentParser(prog='argparse学习样例.py',usage='%(prog)s [options]',
                description = "A simple argument parser", #help信息的行首
                epilog = "This is where you might put example usage" #help信息的行尾
                )
    # required argument，如果我们想使用长选项，我们仅仅需要在短选项的右边添加长选项，如下所示:
    parser.add_argument('-x','--execute',action = "store",required = True,help = "Help text for option X") #help="提示信息"，required是否必须
    # optional argument
    parser.add_argument('-y',help = "Help text for option Y",default = False) #default默认值
    parser.add_argument('-z',help = "Help text for option Z",type = int)
    group = parser.add_mutually_exclusive_group() #不能同时在两种模式 a,b不能同时运行
    group.add_argument('-a', action = "store",help = "Help text for option a")
    group.add_argument('-b',help = "Help text for option b",default = False)
    group.add_argument('-c', choices=['rock', 'paper', 'scissors']) #-c只能选choices中的一个
    group.add_argument('-d', type=int, choices=range(1, 4)) #type
    print(parser.parse_args())

if __name__ == "__main__":
    get_args()

	
"""
#http://www.cnblogs.com/xiaofeiIDO/p/6154953.html  #就是api文档中文翻译

运行结果：
root@api:/home/lgj/pty# python3.4 argparse_test.py -x 1 -y 2 -z 3
Namespace(x='1', y='2', z=3)

#-h ,默认有的，就算上面没有自己定义，也会有
root@api:/home/lgj/pty# python3.4 argparse_test.py -h
usage: argparse_test.py [-h] -x X [-y Y] [-z Z]

A simple argument parser

optional arguments:
  -h, --help  show this help message and exit
  -x X        Help text for option X
  -y Y        Help text for option Y
  -z Z        Help text for option Z

This is where you might put example usage

#不加必须参数-x
root@api:/home/lgj/pty# python3.4 argparse_test.py -z 1
usage: argparse_test.py [-h] -x X [-y Y] [-z Z]
argparse_test.py: error: the following arguments are required: -x
#-a，-b同时出现
root@api:/home/lgj/pty# python3.4 argparse_test.py -a 1 -x 1 -b 2
usage: argparse_test.py [-h] -x EXECUTE [-y Y] [-z Z] [-a A | -b B]
argparse_test.py: error: argument -b: not allowed with argument -a
#-z 类型错误
root@api:/home/lgj/pty# python3.4 argparse_test.py -x 1 -z "a"
usage: argparse_test.py [-h] -x EXECUTE [-y Y] [-z Z] [-a A | -b B]
argparse_test.py: error: argument -z: invalid int value: 'a'

"""


'''
argparse.ArgumentParser(prog=None, usage=None, description=None, epilog=None, parents=[],formatter_class=argparse.HelpFormatter, prefix_chars='-', fromfile_prefix_chars=None, argument_default=None,conflict_handler='error', add_help=True)
创建一个新的ArgumentParser对象。所有的参数应该以关键字参数传递。下面有对每个参数各自详细的描述，但是简短地讲它们是：

prog - 程序的名字（默认：sys.argv[0]）
usage - 描述程序用法的字符串（默认：从解析器的参数生成）
description - 参数帮助信息之前的文本（默认：空）
epilog - 参数帮助信息之后的文本（默认：空）
parents - ArgumentParser 对象的一个列表，这些对象的参数应该包括进去
formatter_class - 定制化帮助信息的类
prefix_chars - 可选参数的前缀字符集（默认：‘-‘）
fromfile_prefix_chars - 额外的参数应该读取的文件的前缀字符集（默认：None）
argument_default - 参数的全局默认值（默认：None）
conflict_handler - 解决冲突的可选参数的策略（通常没有必要）
add_help - 给解析器添加-h/–help 选项（默认：True）


ArgumentParser.add_argument(name or flags...[, action][, nargs][, const][, default][, type][, choices][, required][, help][, metavar][, dest])
定义应该如何解析一个命令行参数。下面每个参数有它们自己详细的描述，简单地讲它们是：

name or flags - 选项字符串的名字或者列表，例如foo 或者-f, --foo。
action - 在命令行遇到该参数时采取的基本动作类型。
nargs - 应该读取的命令行参数数目。
const - 某些action和nargs选项要求的常数值。
default - 如果命令行中没有出现该参数时的默认值。
type - 命令行参数应该被转换成的类型。
choices - 参数可允许的值的一个容器。
required - 该命令行选项是否可以省略（只针对可选参数）。
help - 参数的简短描述。
metavar - 参数在帮助信息中的名字。
dest - 给parse_args()返回的对象要添加的属性名称


'store' - 只是保存参数的值


'''
