nmap{
#参考博客 http://www.cnblogs.com/f-ck-need-u/p/7064323.html
TCP扫描和UDP扫描以及它们的区别
主要是以下几点：
1. TCP是有连接的协议，而UDP是无连接的；
2. TCP扫描检测(ACK SYN)或者是(RST)报文，而UDP检测ICMP端口不可达报文；
3. TCP协议是可靠但低效的，可以有效进行端口扫描，范围广，效率低，可以应用于任何网络中；UDP协议不可靠但高效，范围小但效率高，一般应用于局域网内部，随着网络规模的增大，UDP端口扫描的结果精度会越来越差。


nmap -O 10.177.241.210  # 扫描操作系统类型

nmap -sn -n -PE --min -hostgroup 1024 --min -parallelism 1024 192.168.100.1/24  # 快速扫描存活的主机

要快速扫描存活的主机，需要使用的几个重要选项是：
-n：永远不要DNS解析。这个不管是给定地址扫描还是给定网址扫描，加上它速度都会极速提升
-sn：禁止端口扫描
-PE：只根据echo回显判断主机在线，这种类型的选项使用越多，速度越慢，如 - PM - PP选项都是类似的，但他们速度要慢的多的多，PE有个缺点，不能穿透防火墙
--min - hostgroup N：当IP太多时，nmap需要分组，然后并扫描，使用该选项可以指定多少个IP一组
--min - parallelism N：这个参数非常关键，为了充分利用系统和网络资源，设置好合理的探针数。一般来说，设置的越大速度越快，且和min - hostgroup的值相等或大于它性能才会提升

nmap -sn -PE -n --min-hostgroup 1024 --min-parallelism 1024 -oX nmap_output.xml proxy.huawei.com/16


快速扫描端口
nmap -n -p 20-2000 --min-hostgroup 1024 --min-parallelism 1024 192.168.100.70/24

可以指定"-p [1-65535]"来扫描所有端口，或者使用"-p-"选项也是全面扫描。
nmap -p- 127.0.0.1

}


tcpdump{

tcpdump [ -DenNqvX ] [ -c count ] [ -F file ] [ -i interface ] [ -r file ]
        [ -s snaplen ] [ -w file ] [ expression ]

抓包选项：
-c：指定要抓取的包数量。注意，是最终要获取这么多个包。例如，指定"-c 10"将获取10个包，但可能已经处理了100个包，只不过只有10个包是满足条件的包。
-i interface：指定tcpdump需要监听的接口。若未指定该选项，将从系统接口列表中搜寻编号最小的已配置好的接口(不包括loopback接口，要抓取loopback接口使用tcpdump -i lo)，
            ：一旦找到第一个符合条件的接口，搜寻马上结束。可以使用'any'关键字表示所有网络接口。
-n：对地址以数字方式显式，否则显式为主机名，也就是说-n选项不做主机名解析。
-nn：除了-n的作用外，还把端口显示为数值，否则显示端口服务名。
-N：不打印出host的域名部分。例如tcpdump将会打印'nic'而不是'nic.ddn.mil'。
-P：指定要抓取的包是流入还是流出的包。可以给定的值为"in"、"out"和"inout"，默认为"inout"。
-s len：设置tcpdump的数据包抓取长度为len，如果不设置默认将会是65535字节。对于要抓取的数据包较大时，长度设置不够可能会产生包截断，若出现包截断，
      ：输出行中会出现"[|proto]"的标志(proto实际会显示为协议名)。但是抓取len越长，包的处理时间越长，并且会减少tcpdump可缓存的数据包的数量，
      ：从而会导致数据包的丢失，所以在能抓取我们想要的包的前提下，抓取长度越小越好。

输出选项：
-e：输出的每行中都将包括数据链路层头部信息，例如源MAC和目标MAC。
-q：快速打印输出。即打印很少的协议相关信息，从而输出行都比较简短。
-X：输出包的头部数据，会以16进制和ASCII两种方式同时输出。
-XX：输出包的头部数据，会以16进制和ASCII两种方式同时输出，更详细。
-v：当分析和打印的时候，产生详细的输出。
-vv：产生比-v更详细的输出。
-vvv：产生比-vv更详细的输出。

其他功能性选项：
-D：列出可用于抓包的接口。将会列出接口的数值编号和接口名，它们都可以用于"-i"后。
-F：从文件中读取抓包的表达式。若使用该选项，则命令行中给定的其他表达式都将失效。
-w：将抓包数据输出到文件中而不是标准输出。可以同时配合"-G time"选项使得输出文件每time秒就自动切换到另一个文件。可通过"-r"选项载入这些文件以进行分析和打印。
-r：从给定的数据包文件中读取数据。使用"-"表示从标准输入中读取。


#常用命令：
tcpdump -i any - s0 port 1813 -v -vv  //在主机上抓取1813端口的报文，详细显示
tcpdump -i any -s0 host 10.175.102.179 and port 9543 -v -w lgj.cap  //在主机上抓取Host_IP和端口指定的报文，并保存为.cap格式。
tcpdump -i any icmp -vv   //详细显示主机所有网卡的icmp报文，输出在终端界面上。
tcpdump -i any icmp and host 10.187.60.150 -vv
tcpdump -i any -w 218.cap

#wireshark分析命令
tcp contains scheduleConferenceResult #查找关键词simple
tcp.port==8680
http.request.uri =="10.175.125"
http.request.method == "PUT"
ip.addr==10.175.102.218 and tcp contains "abclgj/v1/abc" #查找相应的主机ip和context字段
tcp.port==7280 and tcp contains sessions
}

#自定义回收站功能
myrm(){ D=/tmp/$(date +%Y%m%d%H%M%S); mkdir -p $D; mv "$@" $D && echo "moved to $D ok"; }
alias rm='myrm'
