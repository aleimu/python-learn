#http://www.cnblogs.com/f-ck-need-u/p/7048359.html

查看文件{

ls -l -h #-h：(human)人类可读的格式，将字节换成k,将K换成M，将M换成G
tree 	#显示树状的文件结构

文件的时间属性有三种：atime/ctime/mtime。atime是access time，即上一次的访问时间；mtime是modify time，是文件的修改时间；ctime是change time，也是文件的修改时间。
(1).atime只在文件被打开访问时才改变，若不是打开文件编辑内容(如重定向内容到文件中)，则ctime和mtime的改变不会引起atime的改变
(2).mtime的改变一定引起ctime的改变，而atime的改变不总是会影响ctime(如touch atime时会改变ctime，但cat文件时不会改变ctime)，atime也是文件的元数据信息

touch {1..10} # 创建文件名为1-10的文件
touch {a,b}_{c,d} # 创建a_c、a_d、b_c、b_d四个文件
touch		#主要是修改文件的时间戳信息，当touch的文件不存在时就自动创建该文件。可以使用 touch –c 来取消创建动作。
touch -a修改atime，-m修改mtime，没有修改ctime的选项。因为使用touch改变atime或mtime，同时也都会改变ctime，虽说atime并不总是会影响ctime(如cat文件时)。

file	#查看文件是属于二进制文件还是数据文件还是ASCII文件

scp -v	#输出详细信息，可以用来调试或查看scp的详细过程，分析scp的机制
scp -p	#拷贝时保持源文件的mtime,atime,owner,group,privileges
scp -C	#拷贝时先压缩，节省带宽

从远程主机192.168.100.60拷贝文件到另一台远程主机192.168.100.62上。
scp root@192.168.100.60:/tmp/copy.txt root@192.168.100.62:/tmp


nl 以行号的方式查看内容。
常用"-b a"，表示不论是否空行都显示行号，等价于cat -n；不写选项时，默认"-b t"，表示空行不显示行号，等价于cat -b。


#比较文件内容
diff file1 file2
vimdiff file1 file2
}

用户和密码{

passwd options [username]
选项说明：
-l：锁定指定用户的密码，在/etc/shadow的密码列加上前缀"!"或"!!"。这种锁定不是完全锁定，使用ssh公钥还是能登录。要完全锁定，使用chage -E 0来设置帐户过期。
-u：解锁-l锁定的密码，解锁的方式是将/etc/shadow的密码列的前缀"!"或"!!"移除掉。但不能移除只有"!"或"!!"的项。
--stdin：从标准输入中读取密码
-d：删除用户密码，将/etc/shadow的密码列设置为空
-f：指定强制操作
-e：强制密码过期，下次登录将强制要求修改密码
-n：密码最小使用天数
-x：最大密码使用天数
-w：过期前几天开始提示用户密码将要过期
-i：设置密码过期后多少天，用户才过期。用户过期将被禁用，修改密码也无法登陆。

批量修改密码chpasswd
#以批处理模式从标准输入中获取提供的用户和密码来修改用户密码，可以一次修改多个用户密码。也就是说不用交互。适用于一次性创建了多个用户时为他们提供密码。

chpasswd [-e -c] "user:passwd"
-c：指定加密算法，可选的算法有DES,MD5,NONE,SHA256和SHA512
user:passwd为用户密码对，其中默认passwd是明文密码，可以指定多对，每行一个用户密码对。前提是用户是已存在的。
-e：passwd默认使用的是明文密码，如果要使用密文，则使用-e选项。参见man chpasswd
chpasswd会读取/etc/login.defs中的相关配置，修改成功后会将密码信息写入到密码文件中。

该命令的修改密码的处理方式是先在内存中修改，如果所有用户的密码都能设置成功，然后才写入到磁盘密码文件中。在内存中修改过程中出错，则所有修改都回滚，但若在写入密码文件过程中出错，则成功的不会回滚。
修改单个用户密码。
shell> echo "user1:123456" | chpasswd -c SHA512
修改多个用户密码，则提供的每个用户对都要分行。

shell> echo  -e 'usertest:123456\nusertest2:123456' | chpasswd
更方便的是写入到文件中，每行一个用户密码对。

shell> cat /tmp/passwdfile
zhangsan:123456
lisi:123456

shell> chapasswd -c SHA512 </tmp/passwdfile

chage命令主要修改或查看和密码时间相关的内容。具体的看man文档，可能用到的两个选项如下：
-l：列出指定用户密码相关信息
-E：指定帐户(不是密码)过期时间，所以是强锁定，如果指定为0，则立即过期，即直接锁定该用户



users 	#查看当前正在登陆的用户名。

last	#查看最近登录的用户列表，其实last查看的是/var/log/wtmp文件。
-n 显示行数：列出最近几次登录的用户

lastb
#查看谁尝试登陆过但没有登录成功的。即能够审核和查看谁曾经不断的登录，可能那就是黑客。
-n:只列出最近的n个尝试对象

who和w
#都是查看谁登录过，并干了什么事，w查看的信息比who多。

lastlog
#可以查看登录的来源IP
-u 指定查看用户
}

进程{

Linux上创建子进程的方式有三种(极其重要的概念)：一种是fork出来的进程，一种是exec出来的进程，一种是clone出来的进程。

(1).fork是复制进程，它会复制当前进程的副本(不考虑写时复制的模式)，以适当的方式将这些资源交给子进程。所以子进程掌握的资源和父进程是一样的，包括内存中的内容，所以也包括环境变量和变量。但父子进程是完全独立的，它们是一个程序的两个实例。

(2).exec是加载另一个应用程序，替代当前运行的进程，也就是说在不创建新进程的情况下加载一个新程序。exec还有一个动作，在进程执行完毕后，退出exec所在的shell。所以为了保证进程安全，若要形成新的且独立的子进程，都会先fork一份当前进程，然后在fork出来的子进程上调用exec来加载新程序替代该子进程。例如在bash下执行cp命令，会先fork出一个bash，然后再exec加载cp程序覆盖子bash进程变成cp进程。

(3).clone用于实现线程。clone的工作原理和fork相同，但clone出来的新进程不独立于父进程，它只会和父进程共享某些资源，在clone进程的时候，可以指定要共享的是哪些资源。

一般情况下，兄弟进程之间是相互独立、互不可见的，但有时候通过特殊手段，它们会实现进程间通信。例如管道协调了两边的进程，两边的进程属于同一个进程组，它们的PPID是一样的，管道使得它们可以以"管道"的方式传递数据。





举例分析进程状态转换过程{

进程间状态的转换情况可能很复杂，这里举一个例子，尽可能详细地描述它们。

以在bash下执行cp命令为例。在当前bash环境下，处于可运行状态(即就绪态)时，当执行cp命令时，首先fork出一个bash子进程，然后在子bash上exec加载cp程序，cp子进程进入等待队列，由于在命令行下敲的命令，所以优先级较高，调度类很快选中它。在cp这个子进程执行过程中，父进程bash会进入睡眠状态(不仅是因为cpu只有一颗的情况下一次只能执行一个进程，还因为进程等待)，并等待被唤醒，此刻bash无法和人类交互。当cp命令执行完毕，它将自己的退出状态码告知父进程，此次复制是成功还是失败，然后cp进程自己消逝掉，父进程bash被唤醒再次进入等待队列，并且此时bash已经获得了cp退出状态码。根据状态码这个"信号"，父进程bash知道了子进程已经终止，所以通告给内核，内核收到通知后将进程列表中的cp进程项删除。至此，整个cp进程正常完成。

假如cp这个子进程复制的是一个大文件，一个cpu时间片无法完成复制，那么在一个cpu时间片消耗尽的时候它将进入等待队列。

假如cp这个子进程复制文件时，目标位置已经有了同名文件，那么默认会询问是否覆盖，发出询问时它等待yes或no的信号，所以它进入了睡眠状态(可中断睡眠)，当在键盘上敲入yes或no信号给cp的时候，cp收到信号，从睡眠态转入就绪态，等待调度类选中它完成cp进程。

在cp复制时，它需要和磁盘交互，在和硬件交互的短暂过程中，cp将处于不可中断睡眠。

假如cp进程结束了，但是结束的过程出现了某种意外，使得bash这个父进程不知道它已经结束了(此例中是不可能出现这种情况的)，那么bash就不会通知内核回收进程列表中的cp表项，cp此时就成了僵尸进程。
}

pstree	命令查看下当前的进程，不难发现在某个终端执行的进程其父进程或上几个级别的父进程总是会是终端的连接程序
pstree [-a] [-c] [-h] [-l] [-p] [pid]
选项说明：
-a：显示进程的命令行
-c：展开分支
-h：高亮当前正在运行的进程及其父进程
-p：显示进程pid，此选项也将展开分支
-l：允许显示长格式进程。默认在显示结果中超过132个字符时将截断后面的字符。
[root@server2 ~]# pstree -c | grep bash
        |-login---bash---bash---vim
        |-sshd-+-sshd---bash
        |      -sshd---bash-+-grep
		
#fuser 	可以显示出当前哪个程序在使用磁盘上的某个文件、挂载点、甚至网络端口，并给出程序进程的详细信息.  http://www.cnblogs.com/276815076/archive/2011/10/10/2205682.html
#lsof	则反过来，它是通过进程来查看进程打开了哪些文件，但要注意的是，一切皆文件，包括普通文件、目录、链接文件、块设备、字符设备、套接字文件、管道文件，所以lsof出来的结果可能会非常多。


lsof的各种用法：
lsof  /path/to/somefile：显示打开指定文件的所有进程之列表；建议配合grep使用
lsof -c string：显示其COMMAND列中包含指定字符(string)的进程所有打开的文件；可多次使用该选项
lsof -p PID：查看该进程打开了哪些文件
lsof -U：列出套接字类型的文件。一般和其他条件一起使用。如lsof -u root -a -U
lsof -u uid/name：显示指定用户的进程打开的文件；可使用脱字符"^"取反，如"lsof -u ^root"将显示非root用户打开的所有文件
lsof +d /DIR/：显示指定目录下被进程打开的文件
lsof +D /DIR/：基本功能同上，但lsof会对指定目录进行递归查找，注意这个参数要比grep版本慢
lsof -a：按"与"组合多个条件，如lsof -a -c apache -u apache
lsof -N：列出所有NFS（网络文件系统）文件
lsof -n：不反解IP至HOSTNAME
lsof -i：用以显示符合条件的进程情况
lsof -i[46] [protocol][@host][:service|port]
    46：IPv4或IPv6
    protocol：TCP or UDP
    host：host name或ip地址，表示搜索哪台主机上的进程信息
    service：服务名称(可以不只一个)
    port：端口号 (可以不只一个)
	
#大概"-i"是使用最多的了，而"-i"中使用最多的又是服务名或端口了。
root@ubuntu10:/home/lgj2/testfile1# lsof -i :22
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
sshd     337 root    3u  IPv4  99897      0t0  TCP *:ssh (LISTEN)
sshd     337 root    4u  IPv6  99899      0t0  TCP *:ssh (LISTEN)
sshd     639 root    3u  IPv4 103583      0t0  TCP 10.175.102.22:ssh->10.177.241.210:52935 (ESTABLISHED)
sshd    1010 root    3u  IPv4 107746      0t0  TCP 10.175.102.22:ssh->10.177.241.210:21144 (ESTABLISHED)
sshd    3752 root    3u  IPv4 106088      0t0  TCP 10.175.102.22:ssh->10.177.241.210:37702 (ESTABLISHED)

	
	
	
}

Linux的网络管理{

Linux数据包转发功能{

如果Linux主机有多块网卡，如果不开启数据包转发功能，则这些网卡之间是无法互通的，除非它们是同网段地址。例如eth0是172.16.10.0/24网段，而eth1是192.168.100.0/24网段，到达该Linux主机的数据包无法从eth0交给eth1或者从eth1交给eth0，除非Linux主机开启了数据包转发功能。这是和路由器设备不同的地方，路由器本质就是跨网段转发数据包，所以路由器设备默认都是开启了转发功能的。

#查看是否开启：
sysctl net.ipv4.ip_forward
cat /proc/sys/net/ipv4/ip_forward
sysctl -a | grep ip_forward

#在Linux上开启转发功能有多种方法：
shell> echo 1 > /proc/sys/net/ipv4/ip_forward
shell> sysctl -w net.ipv4.ip_forward=1
以上两种方法是临时生效的，若要永久生效，则应该写入配置文件。
将/etc/sysctl.conf文件中的"net.ipv4.ip_forward"值改为1即可
shell> echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/ip_forward.conf

实验：10.175.102.22/9.91.6.22/172.17.0.1, 10.175.102.218/9.91.6.218
22上已开启转发，为218指定22路由
route add default gw 10.175.102.22 
route add -net 172.17.0.0 netmask 255.0.0.0 gw 10.175.102.22
route add -host 172.17.0.1 netmask 0.0.0.0 gw 10.175.102.22
/etc/init.d/network restart #可使路由失效
newspo218:~ # route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         10.175.102.22   0.0.0.0         UG    0      0        0 eth1
default         10.175.100.1    0.0.0.0         UG    0      0        0 eth1
9.91.0.0        *               255.255.0.0     U     0      0        0 eth0
10.175.100.0    *               255.255.252.0   U     0      0        0 eth1
loopback        *               255.0.0.0       U     0      0        0 lo

在218上ping172.17.0.1 成功！


#下面这句话存疑
IP地址是属于内核的(不仅如此，整个tcp/ip协议栈都属于内核，包括端口号)，只要能和其中一个地址通信，就能和另一个地址通信，而不管是否开启了数据包转发功能。
例如某Linux主机有两网卡eth0:172.16.10.5和eth1:192.168.100.20，某192.168.100.22主机网关指向192.168.100.20，若它ping 172.16.10.5，结果将是通的，因为地址属于内核，从eth1进来的数据包被内核分析时，发现目标地址为本机地址，直接就回应192.168.100.22，回应数据包继续从eth1出去，除非路由明确设置了不走eth1。#(已验证)
尽管网段1主机能ping通ip_addr2，但数据包并没有交给eth1。
假如网段1主机ping网段2主机，在ping的请求数据包从eth0流入Linux主机时，内核将分析该数据包，发现数据包目标是网段2地址，根据路由表，这类数据包一般都会从直连接口eth1出去，所以eth0的数据包将要转给eth1，但是未开启转发功能，数据包到不了eth1，所以被丢弃。假如开启了数据包转发功能，上面的蓝色虚线和红色虚线将是连通的，数据包转发到达eth1接口，然后出去到网段2的主机上。#(验证未通过)
#数据包转发开启与否，在218上加上 route add -net 9.91.0.0 netmask 255.255.0.0 gw 10.175.102.22 再ping 9.91.6.225 都失败，只能ping 9.91.6.22

}




logrotate的配置{
http://www.cnblogs.com/kevingrace/p/6307298.html

logrotate 的默认配置文件是 /etc/logrotate.conf。主要参数如下表：
man logrotate

logrotate [OPTION...] <configfile>
-d, --debug ：debug模式，测试配置文件是否有错误。
-f, --force ：强制转储文件。
-m, --mail=command ：压缩日志后，发送日志到指定邮箱。
-s, --state=statefile ：使用指定的状态文件。
-v, --verbose ：显示转储过程。

参数 功能
compress                                   通过gzip 压缩转储以后的日志
nocompress                                不做gzip压缩处理
copytruncate                              用于还在打开中的日志文件，把当前日志备份并截断；是先拷贝再清空的方式，拷贝和清空之间有一个时间差，可能会丢失部分日志数据。
nocopytruncate                           备份日志文件不过不截断
create mode owner group             轮转时指定创建新文件的属性，如create 0777 nobody nobody
nocreate                                    不建立新的日志文件
delaycompress                           和compress 一起使用时，转储的日志文件到下一次转储时才压缩
nodelaycompress                        覆盖 delaycompress 选项，转储同时压缩。
missingok                                 如果日志丢失，不报错继续滚动下一个日志
errors address                           专储时的错误信息发送到指定的Email 地址
ifempty                                    即使日志文件为空文件也做轮转，这个是logrotate的缺省选项。
notifempty                               当日志文件为空时，不进行轮转
mail address                             把转储的日志文件发送到指定的E-mail 地址
nomail                                     转储时不发送日志文件
olddir directory                         转储后的日志文件放入指定的目录，必须和当前日志文件在同一个文件系统
noolddir                                   转储后的日志文件和当前日志文件放在同一个目录下
sharedscripts                           运行postrotate脚本，作用是在所有日志都轮转后统一执行一次脚本。如果没有配置这个，那么每个日志轮转后都会执行一次脚本
prerotate                                 在logrotate转储之前需要执行的指令，例如修改文件的属性等动作；必须独立成行
postrotate                               在logrotate转储之后需要执行的指令，例如重新启动 (kill -HUP) 某个服务！必须独立成行
daily                                       指定转储周期为每天
weekly                                    指定转储周期为每周
monthly                                  指定转储周期为每月
rotate count                            指定日志文件删除之前转储的次数，0 指没有备份，5 指保留5 个备份
dateext                                  使用当期日期作为命名格式
dateformat .%s                       配合dateext使用，紧跟在下一行出现，定义文件切割后的文件名，必须配合dateext使用，只支持 %Y %m %d %s 这四个参数
size(或minsize) log-size            当日志文件到达指定的大小时才转储，log-size能指定bytes(缺省)及KB (sizek)或MB(sizem).
当日志文件 >= log-size 的时候就转储。 以下为合法格式：（其他格式的单位大小写没有试过）
size = 5 或 size 5 （>= 5 个字节就转储）
size = 100k 或 size 100k
size = 100M 或 size 100M
执行logrotate：
/usr/sbin/logrotate -vf /etc/logrotate.conf


[root@SZV1000283912 pap]# cat paplogrotate.conf 
/var/paas/sys/log/arbitrator-proxy/*.log
{
  missingok
  rotate 10
  compress
  copytruncate
  notifempty
  size 3M
  dateext
  dateformat _%Y%m%d%s
}

#s使用自己定义的日志策略
/usr/sbin/logrotate -s ./split_status.log paplogrotate.cnf  2>./split_err.out 
}

















}
