#改

def child(master, slave):
    global test
    test=1
    print (111,test)
    os.close(master) #关闭不需要的主设备，因为主设备是给父进程传送指令到子进程的
    os.dup2(slave, 0) #最大的作用就是重定向，将子进程中的0,1,2 都重定向到从端。
    os.dup2(slave, 1)
    os.dup2(slave, 2)
    print (555,test)
    os.execvp("/bin/bash", ["bash", "-l", "-i"])
    #os.execvp("/bin/ls", ["bash", "-l", "-i"])


def parent():
    global output,test
    print (222,test)
    master, slave = os.openpty() #新建虚拟终端，将从端分配给子进程，主端给主进程。#打开一个新的伪终端对。 分别为pty和tty返回一对文件描述符（主，从）
    new_pid = os.fork()
    if new_pid == 0:
        child(master, slave)

    time.sleep(0.1)
    print (333,test)
    os.close(slave) #关闭主进程中的从设备
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
    print (444,test)
	

output=""
test=0
parent()
#可以看出 test 虽然是global 但并不能真正的父进程和子进程之间传递变化
#root@api:/home/lgj/pty# python3.4 cmd_pty1.py tty
