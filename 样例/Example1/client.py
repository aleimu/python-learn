#!/usr/bin/env python
# Version = 3.5.2
# __auth__ = '无名小妖'
import socket
ip_port = ('127.0.0.1', 9999)
# 买手机
client = socket.socket()
# 拨号
client.connect(ip_port)
while True:
    # 发消息
    send_data = input('>>>').strip()
    client.send(bytes(send_data, encoding='utf8'))
    if send_data == 'exit':
        print("will exit!")	
        break
    elif send_data == '':
        continue
    # 处理服务端发送过来的说明，明确即将收多大包（解决粘包问题）
    ready_tag = client.recv(1024)
    ready_tag = str(ready_tag, encoding='utf8')
    if ready_tag.startswith('Ready'):
        print("we Ready!")
        msg_size = int(ready_tag.split('|')[-1])
    start_tag = 'Start'
    print("we Start!")
    client.send(bytes(start_tag,encoding='utf8'))

    recv_size = 0
    recv_msg = b''
    while recv_size < msg_size:
        recv_data = client.recv(1024)
        recv_msg += recv_data
        recv_size += len(recv_data)
        print("we Ready!")		
        print(recv_size,msg_size)
    # 收消息
    print('>>>{}'.format(str(recv_msg, encoding='utf8')))
