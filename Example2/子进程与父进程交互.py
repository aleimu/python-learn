import os
import sys
import time
import pty
import select
#################使用pty和select 处理子进程的返回， 这样的用例是不能在shell中一步一步敲的，因为存在两个进程
pid, fd = pty.fork()
print(pid) #你会发现这里打印了两个值
mystr=""
#处理子进程
if pid == 0:
	os.execvp('/bin/ls', ['/bin/ls', '-l'])
#处理父进程，监听子进程中的返回	
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
程序分叉。 将子进程的控制终端连接到伪终端，返回值为(pid，fd)。注意: 子进程获取pid为0，fd在子进程中是无效的。fork返回非0的pid是子进程的在父进程中的pid，fd是连接到子进程的控制终端（以及子进程的标准输入和输出）的文件描述符。

fd_r_list, fd_w_list, fd_e_list = select.select(rlist, wlist, xlist, [timeout])
 select方法用来监视文件描述符(当文件描述符条件不满足时，select会阻塞)，当某个文件描述符状态改变后，会返回三个列表
1、当参数1 序列中的fd满足“可读”条件时，则获取发生变化的fd并添加到fd_r_list中
2、当参数2 序列中含有fd时，则将该序列中所有的fd添加到 fd_w_list中
3、当参数3 序列中的fd发生错误时，则将该发生错误的fd添加到 fd_e_list中
'''
#################使用os.fork,pipe 处理子进程的返回，不使用pty又怎么写呢？pty.fork会把子进程的fd返回给父进程读取，这样很方便进程间的交流。
'''
os.dup2(fd，fd2，inheritable = True)
#将文件描述符fd重复到fd2，如有必要，关闭后者。
'''
# encoding: utf-8
import os
import sys
import time

def child(master, slave):
    os.close(master)
    os.dup2(slave, 0)
    os.dup2(slave, 1)
    os.dup2(slave, 2)
    os.execvp("/bin/bash", ["bash", "-l", "-i"])


def parent():
    master, slave = os.openpty()
    new_pid = os.fork()
    if new_pid == 0:
        child(master, slave)

    time.sleep(0.1)
    os.close(slave)

    os.write(master, b"fg\n")
    time.sleep(0.1)
    _ = os.read(master, 1024)

    os.write(master, (sys.argv[1] + "\n").encode('utf8'))
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

#使用 python3.4 cmd_pty1.py ls

'''
#创建管道给来子程序中的输出和错误
fdin, fdout = os.pipe()

#a_pid,b_fd=os.forkpty()
a_pid=os.fork()
print("a_pid:",a_pid)

#处理子程序中的输出
if a_pid ==0:
	os.close(fdin)
	os.dup2(fdout, sys.stdout.fileno())
	os.dup2(fdout, sys.stderr.fileno())
	#os.close(fdout)
	#os.dup2(fdin, sys.stdin.fileno())
	os.execvp('/bin/ls', ['/bin/ls', '-l'])
time.sleep(2)
if a_pid !=0:
	print(os.read(fdout,100))
	print(os.read(fdout,100))
	print(os.read(fdout,100))

'''

