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
