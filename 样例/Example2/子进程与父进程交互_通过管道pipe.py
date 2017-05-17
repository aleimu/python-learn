#Python进程间通信之匿名管道
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
我们也可以改进代码,不用os.read()从管道中读取二进制字节,而是从文件对象中读取字符串.这时需要用到os.fdopen()把底层的文件描述符(管道)包装成文件对象,然后再用文件对象中的readline()方法读取.这里请注意文件对象的readline()方法总是读取有换行符’\n’的一行,而且连换行符也读取出来.还有一点要改进的地方是,把父进程和子进程的管道中不用的一端关闭掉.

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

如果要与子进程进行双向通信,只有一个pipe管道是不够的,需要2个pipe管道才行.以下示例在父进程新建了2个管道,然后再fork子进程.os.dup2()实现输出和输入的重定向.spawn功能类似于subprocess.Popen(),既能发送消息给子进程,由能从子子进程获取返回数据. 
​

#!/usr/bin/python
#coding=utf-8
import os, sys

def spawn(prog, *args):
    stdinFd = sys.stdin.fileno()
    stdoutFd = sys.stdout.fileno()

    parentStdin, childStdout = os.pipe()
    childStdin, parentStdout= os.pipe()

    pid = os.fork()
    if pid:
        os.close(childStdin)
        os.close(childStdout)
        os.dup2(parentStdin, stdinFd)#输入流绑定到管道,将输入重定向到管道一端parentStdin
        os.dup2(parentStdout, stdoutFd)#输出流绑定到管道,发送到子进程childStdin
    else:
        os.close(parentStdin)
        os.close(parentStdout)
        os.dup2(childStdin, stdinFd)#输入流绑定到管道
        os.dup2(childStdout, stdoutFd)
        args = (prog, ) + args
        os.execvp(prog, args)
        assert False, 'execvp failed!'

if __name__ == '__main__':
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
