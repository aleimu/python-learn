# python socket实现http请求
import socket
import time
# curl -k -v -X GET http://10.175.102.22:8091/sessions
# coding:UTF-8
# 发送的http包头
header_send = 'GET /sessions HTTP/1.1\r\nHost: 10.175.102.22:8091\r\nConnection: close\r\n\r\n'
i = 0
# 请求次数
num = 1
# 请求间隔
tinktime = 1
# 目的地址
ip_dst = '10.175.102.22'
# 目的端口
port_dst = 8091
while i < num:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((ip_dst, port_dst))
    s.send(header_send.encode("utf-8"))
    i = i + 1
buffer = []
while True:
    # 每次最多接收1k字节:
    d = s.recv(1024)
    if d:
        buffer.append(d)
    else:
        break
data = b''.join(buffer)
s.close()
result = b'200 OK' in data
if result:
    print(data)
else:
    print('web error')
    i = i + 1
    time.sleep(tinktime)


#进阶版
#使用socket模拟http请求，完成全过程协程操作
# curl -k -v -X GET http://10.175.102.22:8091/sessions
import asyncio
import time
# python socket 实现http请求,asyncio.open_connection包装了socket
async def wget(host):
    #print("wget %s..." % host)
    connect = asyncio.open_connection(host, 8091)
    reader, writer = await connect
    header = 'GET /sessions HTTP/1.1\r\nHost: 10.175.102.22:8091\r\nConnection: close\r\n\r\n'
    writer.write(header.encode("utf-8"))
    # writer.write("/sessions".encode("utf-8"))
    await writer.drain()
    while True:
        line = await reader.readline()
        #print("line:", line)
        if line == b"":
            break
        #print('%s header > %s' % (host, line.decode('utf-8').rstrip()))
    writer.close()
t1 = time.time()
for x in range(10):
    loop = asyncio.get_event_loop()
    tasks = [wget('10.175.102.22') for x in range(100)]
    loop.run_until_complete(asyncio.wait(tasks))
loop.close()
t2 = time.time()
print(t2 - t1)
#3.35s
#
#
#
"""

# curl -k -v -X GET http://10.175.102.22:8091/sessions

root@api:~# curl -k -v -X GET http://10.175.102.22:8091/sessions
* Hostname was NOT found in DNS cache
*   Trying 10.175.102.22...
* Connected to 10.175.102.22 (10.175.102.22) port 8091 (#0)
> GET /sessions HTTP/1.1
> User-Agent: curl/7.35.0
> Host: 10.175.102.22:8091
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: application/xml
< Date: Fri, 08 Sep 2017 08:08:30 GMT
< Connection: keep-alive
< Transfer-Encoding: chunked
<
* Connection #0 to host 10.175.102.22 left intact
<session><status>NOTFOUND</status><success>true</success><token>697a4e434b6c7775664448686247446d425574467258686c4c784e44724e7a58466d4d6b5251784f77576a4b</token><id>4d0f05de165151129d5c5c96f13ca3aa</id></session


第1行：方法，请求的内容，HTTP协议的版本
下载一般可以用GET方法，请求的内容是"/index.html"，HTTP协议的版本是指浏览器支持的版本，对于下载软件来说无所谓，所以用1.1版 "HTTP/1.1"；
"GET /index.html HTTP/1.1"
第2行：主机名，格式为"Host:主机"
在这个例子中是："Host:www.sina.com.cn"
第3行：接受的数据类型，下载软件当然要接收所有的数据类型，所以：
"Accept:*/*"
第4行：指定浏览器的类型
有些服务器会根据客户服务器种类的不同会增加或减少一些内容，在这个例子中可以这样写：
"User-Agent:Mozilla/4.0 (compatible; MSIE 5.00; Windows 98)"
第5行：连接设置
设定为一直保持连接："Connection:Keep-Alive"
第6行：若要实现断点续传则要指定从什么位置起接收数据，格式如下：
"Range: bytes=起始位置 - 终止位置"
比如要读前500个字节可以这样写："Range: bytes=0 - 499"；从第 1000 个字节起开始下载：
"Range: bytes=999 -"

最后，别忘了加上一行空行，表示请求头结束。整个请求头如下：
GET /index.html HTTP/1.1
Host:www.sina.com.cn
Accept:*/*
User-Agent:Mozilla/4.0 (compatible; MSIE 5.00; Windows 98)
Connection:Keep-Alive

"""
