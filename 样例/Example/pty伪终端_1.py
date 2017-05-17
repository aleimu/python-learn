#! /usr/bin/env python
#coding=utf-8

import pty
import os
import select
#python虚拟串口
#pty是假串口的意思，但是支持硬件串口的所有操作
#import serial   serial是个串口的专门的库
def mkpty():
    # 打开伪终端
    master1, slave = pty.openpty()
    slaveName1 = os.ttyname(slave)
    master2, slave = pty.openpty()
    slaveName2 = os.ttyname(slave)
    print ('\nslave device names: ', slaveName1, slaveName2)
    return master1, master2

if __name__ == "__main__":

    master1, master2 = mkpty()
    while True:
        rl, wl, el = select.select([master1,master2], [], [], 1)
        for master in rl:
            data = os.read(master, 128)
            print ("read %d data." % len(data))
            if master==master1:
                os.write(master2, data)
            else:
                os.write(master1, data)

#os.openpty()                    # 打开一个新的伪终端对。返回 pty 和 tty的文件描述符。				
#os.write(fd, str)               # 写入字符串到文件描述符 fd中. 返回实际写入的字符串长度
#os.read(fd, n)                  # 从文件描述符 fd 中读取最多 n 个字节，返回包含读取字节的字符串，文件描述符 fd对应文件已达到结尾, 返回一个空字符串。
#os.ttyname(fd)                  # 返回一个字符串，它表示与文件描述符fd 关联的终端设备。如果fd 没有与终端设备关联，则引发一个异常。
#os.dup(fd)                      # 复制文件描述符 fd
#os.dup2(fd, fd2)                # 将一个文件描述符 fd 复制到另一个 fd2

'''
############################################
>>> import os
>>> a,b=os.openpty()
>>> a
3
>>> b
4
>>> os.write(a,b"this is a test data")
19
>>> os.read(a,5)
b'this '
>>> os.ttyname(a)
'/dev/ptmx'
>>> os.ttyname(b)
'/dev/pts/2'
>>> os.dup(a)
6
>>> os.dup2(a,7)
############################################
>>> import pty
>>> pty.fork()
(42490, 3)
>>> os.ttyname(3)
'/dev/ptmx'
>>> 
>>> 
>>> pty.fork()
(42552, 4)
>>> os.ttyname(4)
'/dev/ptmx'
>>> import os
>>> os.fork()
84868

root@api:~# ps -ef|grep python
root      42480 109655  0 Feb25 pts/15   00:00:00 python3.4
root      42490  42480  0 Feb25 pts/2    00:00:00 python3.4
root      42552  42480  0 Feb25 pts/5    00:00:00 python3.4	 #pty.fork()
root      84868  42480  0 04:01 pts/15   00:00:00 python3.4  #os.fork
root      84885  40716  0 04:01 pts/10   00:00:00 grep --color=auto python

对比可以看出，os.fork还是在同一个pts中，pty.fork()会产生一个新的pts。

>>> import pty
>>> pty.fork()
(85983, 3)

root@api:~# ps -ef|grep python
root      85932  85875  0 04:18 pts/2    00:00:00 python3.4 #原shell
root      85983  85932  0 04:19 pts/5    00:00:00 python3.4 #fork出的pty
root      86073  40716  0 04:20 pts/10   00:00:00 grep --color=auto python




'''
