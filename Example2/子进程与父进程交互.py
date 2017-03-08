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
os.dup2(fd，fd2，inheritable = True)  #最大的作用就是重定向，将fd2重定向到fd。
#将文件描述符fd重复到fd2，如有必要，关闭后者。
'''
# encoding: utf-8
import os
import sys
import time

def child(master, slave):
    os.close(master) #关闭不需要的主设备，因为主设备是给父进程传送指令到子进程的
    os.dup2(slave, 0) #最大的作用就是重定向，将子进程中的0,1,2 都重定向到从端。
    os.dup2(slave, 1)
    os.dup2(slave, 2)
    os.execvp("/bin/bash", ["bash", "-l", "-i"])
	#os.execvp("/bin/ls", ["bash", "-l", "-i"])


def parent():
    master, slave = os.openpty() #新建虚拟终端，将从端分配给子进程，主端给主进程。#打开一个新的伪终端对。 分别为pty和tty返回一对文件描述符（主，从）
    new_pid = os.fork()
    if new_pid == 0:
        child(master, slave)

    time.sleep(0.1)
    os.close(slave) #关闭主进程中的从设备

    os.write(master, b"fg\n") #把作业放置前台执行，下发指令到子进程，将子进程中的执行放到前台
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
解析1，注释掉后会多打印这些东西。这些是父进程中的多余数据，可以先读出丢弃
bash: no job control in this shell
root@api:/home/lgj/pty# fg
bash: fg: no job control
root@api:/home/lgj/pty# ll

bg（将作业放置于后台执行）（在前台执行时间过长，则可以按ctrl+z，暂停进程，用bg放其至后台）
bg 作业ID
fg（把作业放置前台执行）
jobs（查看后台作业）

#http://www.cnblogs.com/nufangrensheng/p/3577853.html
通常一个进程打开伪终端设备，然后调用fork。子进程建立了一个新会话，打开一个相应的伪终端从设备，将其描述符复制到标准输入、标准输出和标准出错，然后调用exec。伪终端从设备成为子进程的控制终端。

对于ssh，telnet等远程登录程序而言，当你ssh到某个sshd服务器上去时，这个sshd会打开一个伪终端主设备，然后fork出一个子进程，在子进程中打开一个从设备，
这样，主进程和子进程之间就可以通过伪终端的主从设备进行交流，任何从主设备的输入都会输出到从设备上
使用主从伪终端之后，当sshd收到指令时会将指令输入到主设备，然后主设备会把执行输出到从设备，这样就相当于指令输入到了从设备，而从设备是和某个shell连接的,从而这个指令或者毫无意义的字符串就被发往了远程的shell去解释
'''

#使用 python3.4 cmd_pty1.py ls


