import os
import sys
import time
import pty
import select
#################使用pty和select 处理子进程的返回， 这样的用例是不能在shell中一步一步敲的，因为存在两个进程
pid, fd = pty.fork()
mystr=""
#处理子进程
if pid == 0:
	os.execvp('/bin/ls', ['/bin/ls', '-l'])
while True:
	i, o, e = select.select([fd], [], [], 2)
	if fd in i:
		try:
			bytes = os.read(fd,600)
			mystr=bytes.decode("utf-8")+mystr
			print(bytes.decode("utf-8"))
		except OSError:
			print("子进程结束")
			break
#继续处理父进程
print("==============")
print(mystr) #父进程中取得了子进程的返回！

#################使用os.fork,pipe 处理子进程的返回，	
'''
os.dup2(fd，fd2，inheritable = True)
#将文件描述符fd重复到fd2，如有必要，关闭后者。
'''

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
