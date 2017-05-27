#服务端
import socket,os

service=socket.socket()
service.bind(('localhost',1024)) #绑定要监听的端口
service.listen()###监听端口
con,adder=service.accept()#等对方的连接，把对方的连接在本地生成一个实例并赋值个给con
while True:
    data=con.recv(1024).decode('utf-8')##接收对方传过来的值(接收的最大值为1024个字节)并且赋值
    x=os.popen(data).read()
    print(x)
    con.send(str(len(x)).encode('utf-8')) #先发送将要发送的的数据的大小
    #time.sleep(0.5)  ###防止粘包,但是会有延迟（不推荐）
    check_ack=con.recv(1024)##两次send之间在进行一次交互来防止粘包（推荐），同时在客户端也进行回应
    con.send(x.encode('utf-8'))#向对方发送数据
service.close()

#客户端运行输入命令获取服务端上的运行结果

#客服端　
import socket
client=socket.socket()
client.connect(('localhost',1024))
while True:
    msg=input(':').encode('utf-8')
    client.send(msg)
    datasize=client.recv(1024).decode('utf-8') #先接受将要接受的数据的大小
    client.send("我收到了,可以传下面的内容了".encode())###客户端进行一次自动的确认
    x=0
    while x != int(datasize):
        a=client.recv(1024).decode('utf-8')
        x+=len(a)
        print(a)
    else:
        print(datasize,x)
