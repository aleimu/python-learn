import socket, subprocess
ip_port = ('127.0.0.1', 9999)
server = socket.socket()
server.bind(ip_port)
server.listen(3)
while True:  	##此while循环为了持续的接收连接（当一个连接断开，接收另一个）
    conn,addr = server.accept()
    while True:  	##此while循环为了持续收发消息
        try:  	##客户端异常关闭处理
            recv_data = conn.recv(1024)
            print(recv_data,'xxx')
            if recv_data == bytes('exit', encoding='utf8'):
                break
            elif len(recv_data) == 0:  		## 当客户端发送空后，服务端退出本次连接
                break
            p = subprocess.Popen(str(recv_data,encoding='utf8'),shell=True,stdout=subprocess.PIPE)
            res = p.stdout.read()
            if len(res) == 0:  		##客户端输入错误命令时，服务端返回空
                send_data = 'cmd error'
            else:               
                send_data = str(res, encoding='gbk') 	##将gbk转为utf8，需要先转为str作为过度
                send_data = bytes(send_data, encoding='utf8')
            ready_flag = 'Ready|{}'.format(len(send_data)) 	 	## 发送一个说明，告诉客户端要发送多大的包（解决粘包问题）
            conn.send(bytes(ready_flag, encoding='utf8'))
            feed_back = conn.recv(1024)
            feed_back = str(feed_back,encoding='utf8')
            if feed_back == 'Start':
                conn.send(send_data)
                print(str(send_data, encoding='utf8'))
        except Exception as e:
            print(e)
            break
    conn.close()

    
    
    	socket.gethostname()     # 获取主机名
	from socket import *     # 避免 socket.socket()
	s=socket()
	s.bind()         # 绑定地址到套接字
	s.listen()       # 开始TCP监听
	s.accept()       # 被动接受TCP客户端连接，等待连接的到来
	s.connect()      # 主动初始化TCP服务器连接
	s.connect_ex()   # connect()函数的扩展版本，出错时返回出错码，而不是跑出异常
	s.recv()         # 接收TCP数据
	s.send()         # 发送TCP数据
	s.sendall()      # 完整发送TCP数据
	s.recvfrom()     # 接收UDP数据
	s.sendto()       # 发送UDP数据
	s.getpeername()  # 连接到当前套接字的远端的地址(TCP连接)
	s.getsockname()  # 当前套接字的地址
	s.getsockopt()   # 返回指定套接字的参数
	s.setsockopt()   # 设置指定套接字的参数
	s.close()        # 关闭套接字
	s.setblocking()  # 设置套接字的阻塞与非阻塞模式
	s.settimeout()   # 设置阻塞套接字操作的超时时间
	s.gettimeout()   # 得到阻塞套接字操作的超时时间
	s.filen0()       # 套接字的文件描述符
	s.makefile()     # 创建一个与该套接字关联的文件对象
	socket.AF_UNIX	 # 只能够用于单一的Unix系统进程间通信
	socket.AF_INET 	 # 服务器之间网络通信
	socket.AF_INET6	 # IPv6
	socket.SOCK_STREAM	  # 流式socket , for TCP
	socket.SOCK_DGRAM	  # 数据报式socket , for UDP
	socket.SOCK_RAW	      # 原始套接字，普通的套接字无法处理ICMP、IGMP等网络报文，而SOCK_RAW可以；其次，SOCK_RAW也可以处理特殊的IPv4报文；此外，利用原始套接字，可以通过IP_HDRINCL套接字选项由用户构造IP头。
	socket.SOCK_RDM 	  # 是一种可靠的UDP形式，即保证交付数据报但不保证顺序。SOCK_RAM用来提供对原始协议的低级访问，在需要执行某些特殊操作时使用，如发送ICMP报文。SOCK_RAM通常仅限于高级用户或管理员运行的程序使用。
	socket.SOCK_SEQPACKET	 # 可靠的连续数据包服务
