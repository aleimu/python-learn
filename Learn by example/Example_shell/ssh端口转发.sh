10.175.102.220/225/226 #三者可互ping通

#如何禁止端口转发
设置ssh服务配置文件/etc/ssh/sshd_config
AllowTcpForwarding no

#端口转发需要sshd允许
AllowTcpForwarding yes
GatewayPorts yes
X11Forwarding yes

/etc/init.d/sshd restart
reboot


#http://www.cnblogs.com/linuxprobe/p/5643684.html 只写了几个这次用到的
查看 IPtables 防火墙策略：
iptables -L -n -v

如果你发现有某个IP向服务器导入攻击或非正常流量，可以使用如下规则屏蔽其 IP 地址：
iptables -A INPUT -s xxx.xxx.xxx.xxx -j DROP
注意需要将上述的 XXX 改成要屏蔽的实际 IP 地址，其中的 -A 参数表示在 INPUT 链的最后追加本条规则。（IPTables 中的规则是从上到下匹配的，一旦匹配成功就不再继续往下匹配）

如果你只想屏蔽 TCP 流量，可以使用 -p 参数的指定协议，例如：
iptables -A INPUT -p tcp -s xxx.xxx.xxx.xxx -j DROP

#在220上新建防火墙规则，使220 ping不通 226，ssh 10.175.102.226不上
iptables -A INPUT -s 10.175.102.226 -j DROP


ssh -N -f -L 2121:234.234.234.234:21 123.123.123.123


ssh -L <local port>:<remote host>:<remote port> <SSH hostname>
ssh -R <local port>:<remote host>:<remote port> <SSH hostname>

这里我们用到了SSH客户端的三个参数：
-N 告诉SSH客户端，这个连接不需要执行任何命令。仅仅做端口转发
-f 告诉SSH客户端在后台运行
-L 做本地映射端口，
-R 远程端口转发

被冒号分割的三个部分含义分别是:
需要使用的本地端口号
需要访问的目标机器IP地址（IP: 234.234.234.234）
需要访问的目标机器端口（端口: 21)
-L X:Y:Z 的含义是，将IP为Y的机器的Z端口通过中间服务器Z映射到本地机器的X端口。

最后一个参数是我们用来建立隧道的中间机器的IP地址(IP: 123.123.123.123)



#在225上执行
ssh -N -f -L 2121:10.175.102.225:21 10.175.102.220
ssh -N -f -L 2121:234.234.234.234:21 123.123.123.123


ssh的三个强大的端口转发命令：

ssh -C -f -N -g -L listen_port:DST_Host:DST_port user@Tunnel_Host 
ssh -C -f -N -g -R listen_port:DST_Host:DST_port user@Tunnel_Host 
ssh -C -f -N -g -D listen_port user@Tunnel_Host

本地主机映射：ssh -Nf -L   本地主机IP：本地主机指定端口:远程主机IP：远程主机端口  跳转机IP
远程主机映射：ssh -Nf -R   远程主机IP：远程主机指定端口:本地主机IP（可以是局域网中可访问到的机器）：本地主机端口  远程主机IP
动态端口转发：ssh -Nf -D   本地主机IP：本地主机端口  远程主机IP 

转发到远端：ssh -C -f -N -g -L 本地端口:目标IP:目标端口 用户名@目标IP
转发到本地：ssh -C -f -N -g –R 本地端口:目标IP:目标端口 用户名@目标IP
ssh -C -f -N -g -D listen_port user@Tunnel_Host

-C：压缩数据传输。
-f ：后台认证用户/密码，通常和-N连用，不用登录到远程主机。
-N ：不执行脚本或命令，通常与-f连用。
-g ：在-L/-R/-D参数中，允许远程主机连接到建立的转发的端口，如果不加这个参数，只允许本地主机建立连接。
-L 本地端口:目标IP:目标端口

应用举例

1.将发往本机的80端口访问转发到174.139.9.66的8080端口
ssh -C -f -N -g -L 80:174.139.9.66:8080  master@174.139.9.66
2.将发往174.139.9.66的8080访问转发到本机的80端口
ssh -C -f -N -g -R 80:174.139.9.66:8080  master@174.139.9.66
-N - 不使用Shell窗口，纯做转发的时候用，如果你在映射完成后继续在服务器上输入命令，去掉这个参数即可





curl -v -k -X GET http://10.175.102.179:8091/sessions

curl -v -X GET -H "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" 'http://10.175.102.218:7900/appmgt/api/v1/?name=appTest01'
curl -v -X GET -H "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" 'http://10.175.102.225:9580/appmgt/api/v1/?name=appTest01'



#端口转发成功，但信息有错误

ssh -t -v -Nf -L 10.175.102.218:7900:10.175.102.225:8580 root@10.175.102.226

curl -k -v -X GET -H "Authorization:Basic cHJvdmlkZXI6UHYmODlJam4=" "http://10.175.102.218:7900/apimgt/api/v1/list?pageSize=10&pageIndex=1"
curl -k -v -X GET -H "Authorization:Basic cHJvdmlkZXI6UHYmODlJam4=" "http://10.175.102.225:9580/apimgt/api/v1/list?pageSize=10&pageIndex=1"


[2017-08-18 17:16:31,449] [0] INFO  - [SYSTEM]  STATUS = Message dispatched to the main sequence. Invalid URL., RESOURCE = /apimgt/api/v1/list?pageSize=10&pageIndex=1 {SERVICE_LOGGER.__SynapseService}[99]
[2017-08-18 17:16:35,593] [0] INFO  - [SYSTEM]  'provider@carbon.super [-1234]' logged in at [2017-08-18 17:16:35,593+0000] {org.wso2.carbon.core.services.util.CarbonAuthenticationUtil}[113]
[2017-08-18 17:16:35,594] [0] INFO  - [SYSTEM]  'provider@carbon.super [-1234]' logged in at [2017-08-18 17:16:35,593+0000] {AUDIT_LOG}[114]


ssh -t -v -Nf -L 10.175.102.179:7900:10.175.102.22:8091 root@10.175.102.218

#curl -v -k -X GET http://10.175.102.179:7900/sessions
 
channel 1: open failed: administratively prohibited: open failed
debug1: channel 1: free: direct-tcpip: listening port 7900 for 10.175.102.22 port 8091, connect from 10.175.102.179 port 59212 to 10.175.102.179 port 7900, nchannels 2


iptables -t nat -A PREROUTING -i eth2 -p tcp --dport 8000 -j REDIRECT --to-port 8091
上述命令会将所有到达 eth2 网卡 25 端口的流量重定向转发到 2525 端口
#保存配置，也能用于查看一些看不到的配置
iptables-save > hehe
iptables -X #清除用户设定
iptables -F #清除所有规则
iptables -L #查看设定

#windows上常用ipop.exe来实现端口映射，很好用
