Python中的进程分支fork和exec详解

这篇文章主要介绍了Python中的进程分支fork和exec详解,本文用实例讲解fork()的使用,并讲解了exec相关的8个方法等内容,需要的朋友可以参考下

在python中,任务并发一种方式是通过进程分支来实现的.在linux系统在,通过fork()方法来实现进程分支.

1.fork()调用后会创建一个新的子进程,这个子进程是原父进程的副本.子进程可以独立父进程外运行.
2.fork()是一个很特殊的方法,一次调用,两次返回.
3.fork()它会返回2个值,一个值为0,表示在子进程返回;另外一个值为非0,表示在父进程中返回子进程ID.

以下只能在linux中运行,不能在window下运行.

进程分支fork()

实例如下:


复制代码 代码如下:


 #!/usr/bin/python
 #coding=utf-8
 import os

def child():
     print('hello from child', os.getpid())
     os._exit(0)
 def parent():
     pid = os.fork()
     if pid == 0:
         child()
         print 'fork child process error!'#如果打印该字符串,说明调用child()出错
    else:
         print('hello from parent', os.getpid(), pid)

parent()



运行结果如下:


复制代码 代码如下:


 ('hello from parent', 29888, 29889)
 ('hello from child', 29889)


从结果不难看出, child()后的print字符并没有打印处理,说明调用child()是没有返回的.

fork和exec的组合

从上面的例子来看,调用child()方法后就直接退出了.但在实际的应用中,我们希望分支出来的子进程能独立运行另外一个新的程序.这时需要用到exec方法替换子进程,并且替换后进程的pid不会改变.exec方法不会返回.

首先解释一下exec相关的8个方法组:

os.execv(program, cmdargs) 

基本的”v”执行形式,需要传入可执行的程序名,以及用来运行程序的命令行参数字符的列表或元组.

os.execl(program, cmdarg1, cmdarg2, …, cmdargN) 

基本的”l”执行形式,需要传入可执行的程序名,以及用来运行程序的命令行多个字符参数.

os.execvp(program, args) 

“p”模式下,基本的”v”执行形式,需要传入可执行的程序名,以及用来运行程序的命令行参数字符的列表或元组.运行新程序的搜索路径为当前文件的搜索路径.

os.execlp(program, cmdarg1, cmdarg2, …, cmdargN) 

“p”模式下,基本的”l”执行形式,需要传入可执行的程序名,以及用来运行程序的命令行多个字符参数.运行新程序的搜索路径为当前文件的搜索路径.

os.execve(program, args, env) 

“e”模式下,基本的”v”执行形式,需要传入可执行的程序名,以及用来运行程序的命令行参数字符的列表或元组.最后还要传入运行新程序的需要的环境变量env字典参数.

os.execle(program, cmdarg1, cmdarg2, …, cmdargN, env) 

“e”模式下,基本的”l”执行形式,需要传入可执行的程序名,以及用来运行程序的命令行多个字符参数.最后还要传入运行新程序的需要的环境变量env字典参数.

os.execvpe(program, args, env) 

在”p”和”e”的组合模式下,基本的”v”执行形式,需要传入可执行的程序名,以及用来运行程序的命令行参数字符的列表或元组.最后还要传入运行新程序的需要的环境变量env字典参数.运行新程序的搜索路径为当前文件的搜索路径.

os.execlpe(program, cmdarg1, cmdarg2, …, cmdargN, env) 

在”p”和”e”的组合模式下,基本的”l”执行形式,需要传入可执行的程序名,以及用来运行程序的命令行多个字符参数.最后还要传入运行新程序的需要的环境变量env字典参数.运行新程序的搜索路径为当前文件的搜索路径.

newprocess.py代码如下:


复制代码 代码如下:


 #!/usr/bin/python
 #coding=utf-8
 import os

def child():
     print('hello from child', os.getpid())
     os._exit(0)

child()



主代码如下:


复制代码 代码如下:


 #!/usr/bin/python
 #coding=utf-8
 import os

def child():
     print('hello from child', os.getpid())
     os._exit(0)

def parent():
     pid = os.fork()
     if pid == 0:
         os.execlp('python', 'python', 'newprocess.py')
         assert False, 'fork child process error!'
     else:
         print('hello from parent', os.getpid(), pid)
 parent()


输出如下:

复制代码 代码如下:


 $ python TestFork.py 
 ('hello from parent', 30791, 30792)
 $ ('hello from child', 30792)