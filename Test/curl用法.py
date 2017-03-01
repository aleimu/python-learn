linux curl是通过url语法在命令行下上传或下载文件的工具软件，它支持http,https,ftp,ftps,telnet等多种协议，常被用来抓取网页和监控Web服务器状态。
一、Linux curl抓取网页{
1. linux curl抓取网页：
抓取百度：
curl http://www.baidu.com
如发现乱码，可以使用iconv转码：

curl http://iframe.ip138.com/ic.asp|iconv -fgb2312
iconv的用法请参阅：在Linux/Unix系统下用iconv命令处理文本文件中文乱码问题

2. Linux curl使用代理：
linux curl使用http代理抓取页面：
curl -x 111.95.243.36:80 http://iframe.ip138.com/ic.asp|iconv -fgb2312
curl -x 111.95.243.36:80 -U aiezu:password http://www.baidu.com

使用socks代理抓取页面：	
curl --socks4 202.113.65.229:443 http://iframe.ip138.com/ic.asp|iconv -fgb2312
curl --socks5 202.113.65.229:443 http://iframe.ip138.com/ic.asp|iconv -fgb2312

代理服务器地址可以从爬虫代理上获取。

3. linux curl处理cookies
接收cookies:
curl -c /tmp/cookies http://www.baidu.com #cookies保存到/tmp/cookies文件

发送cookies:
curl -b "key1=val1;key2=val2;" http://www.baidu.com #发送cookies文本
curl -b /tmp/cookies http://www.baidu.com #从文件中读取cookies

4. linux curl发送数据：
linux curl get方式提交数据：
curl -G -d "name=value&name2=value2" http://www.baidu.com

linux curl post方式提交数据：
curl -d "name=value&name2=value2" http://www.baidu.com #post数据
curl -d a=b&c=d&txt@/tmp/txt http://www.baidu.com  #post文件

以表单的方式上传文件：
curl -F file=@/tmp/me.txt http://www.aiezu.com

相当于设置form表单的method="POST"和enctype='multipart/form-data'两个属性。

5. linux curl http header处理：
设置http请求头信息：
curl -A "Mozilla/5.0 Firefox/21.0" http://www.baidu.com #设置http请求头User-Agent
curl -e "http://pachong.org/" http://www.baidu.com #设置http请求头Referer
curl -H "Connection:keep-alive \n User-Agent: Mozilla/5.0" http://www.aiezu.com
设置http响应头处理：
curl -I http://www.aiezu.com #仅仅返回header
curl -D /tmp/header http://www.aiezu.com #将http header保存到/tmp/header文件


6. linux curl认证：
curl -u aiezu:password http://www.aiezu.com #用户名密码认证
curl -E mycert.pem https://www.baidu.com #采用证书认证


7. 其他：
curl -# http://www.baidu.com #以“#”号输出进度条
curl -o /tmp/aiezu http://www.baidu.com #保存http响应到/tmp/aiezu
}

二、参数大全
{
 -a/--append 上传文件时，附加到目标文件
 -A/--user-agent <string>  设置用户代理发送给服务器
 - anyauth   可以使用“任何”身份验证方法
 -b/--cookie <name=string/file> cookie字符串或文件读取位置
 - basic 使用HTTP基本验证
 -B/--use-ascii 使用ASCII /文本传输
 -c/--cookie-jar <file> 操作结束后把cookie写入到这个文件中
 -C/--continue-at <offset>  断点续转
 -d/--data <data>   HTTP POST方式传送数据
 --data-ascii <data>  以ascii的方式post数据
 --data-binary <data> 以二进制的方式post数据
 --negotiate     使用HTTP身份验证
 --digest        使用数字身份验证
 --disable-eprt  禁止使用EPRT或LPRT
 --disable-epsv  禁止使用EPSV
 -D/--dump-header <file> 把header信息写入到该文件中
 --egd-file <file> 为随机数据(SSL)设置EGD socket路径
 --tcp-nodelay   使用TCP_NODELAY选项
 -e/--referer 来源网址
 -E/--cert <cert[:passwd]> 客户端证书文件和密码 (SSL)
 --cert-type <type> 证书文件类型 (DER/PEM/ENG) (SSL)
 --key <key>     私钥文件名 (SSL)
 --key-type <type> 私钥文件类型 (DER/PEM/ENG) (SSL)
 --pass  <pass>  私钥密码 (SSL)
 --engine <eng>  加密引擎使用 (SSL). "--engine list" for list
 --cacert <file> CA证书 (SSL)
 --capath <directory> CA目录 (made using c_rehash) to verify peer against (SSL)
 --ciphers <list>  SSL密码
 --compressed    要求返回是压缩的形势 (using deflate or gzip)
 --connect-timeout <seconds> 设置最大请求时间
 --create-dirs   建立本地目录的目录层次结构
 --crlf          上传是把LF转变成CRLF
 -f/--fail          连接失败时不显示http错误
 --ftp-create-dirs 如果远程目录不存在，创建远程目录
 --ftp-method [multicwd/nocwd/singlecwd] 控制CWD的使用
 --ftp-pasv      使用 PASV/EPSV 代替端口
 --ftp-skip-pasv-ip 使用PASV的时候,忽略该IP地址
 --ftp-ssl       尝试用 SSL/TLS 来进行ftp数据传输
 --ftp-ssl-reqd  要求用 SSL/TLS 来进行ftp数据传输
 -F/--form <name=content> 模拟http表单提交数据
 -form-string <name=string> 模拟http表单提交数据
 -g/--globoff 禁用网址序列和范围使用{}和[]
 -G/--get 以get的方式来发送数据
 -h/--help 帮助
 -H/--header <line>自定义头信息传递给服务器
 --ignore-content-length  忽略的HTTP头信息的长度
 -i/--include 输出时包括protocol头信息
 -I/--head  只显示文档信息
 从文件中读取-j/--junk-session-cookies忽略会话Cookie
 - 界面<interface>指定网络接口/地址使用
 - krb4 <级别>启用与指定的安全级别krb4
 -j/--junk-session-cookies 读取文件进忽略session cookie
 --interface <interface> 使用指定网络接口/地址
 --krb4 <level>  使用指定安全级别的krb4
 -k/--insecure 允许不使用证书到SSL站点
 -K/--config  指定的配置文件读取
 -l/--list-only 列出ftp目录下的文件名称
 --limit-rate <rate> 设置传输速度
 --local-port<NUM> 强制使用本地端口号
 -m/--max-time <seconds> 设置最大传输时间
 --max-redirs <num> 设置最大读取的目录数
 --max-filesize <bytes> 设置最大下载的文件总量
 -M/--manual  显示全手动
 -n/--netrc 从netrc文件中读取用户名和密码
 --netrc-optional 使用 .netrc 或者 URL来覆盖-n
 --ntlm          使用 HTTP NTLM 身份验证
 -N/--no-buffer 禁用缓冲输出
 -o/--output 把输出写到该文件中
 -O/--remote-name 把输出写到该文件中，保留远程文件的文件名
 -p/--proxytunnel   使用HTTP代理
 --proxy-anyauth 选择任一代理身份验证方法
 --proxy-basic   在代理上使用基本身份验证
 --proxy-digest  在代理上使用数字身份验证
 --proxy-ntlm    在代理上使用ntlm身份验证
 -P/--ftp-port <address> 使用端口地址，而不是使用PASV
 -Q/--quote <cmd>文件传输前，发送命令到服务器
 -r/--range <range>检索来自HTTP/1.1或FTP服务器字节范围
 --range-file 读取（SSL）的随机文件
 -R/--remote-time   在本地生成文件时，保留远程文件时间
 --retry <num>   传输出现问题时，重试的次数
 --retry-delay <seconds>  传输出现问题时，设置重试间隔时间
 --retry-max-time <seconds> 传输出现问题时，设置最大重试时间
 -s/--silent静音模式。不输出任何东西
 -S/--show-error   显示错误
 --socks4 <host[:port]> 用socks4代理给定主机和端口
 --socks5 <host[:port]> 用socks5代理给定主机和端口
 --stderr <file>
 -t/--telnet-option <OPT=val> Telnet选项设置
 --trace <file>  对指定文件进行debug
 --trace-ascii <file> Like --跟踪但没有hex输出
 --trace-time    跟踪/详细输出时，添加时间戳
 -T/--upload-file <file> 上传文件
 --url <URL>     Spet URL to work with
 -u/--user <user[:password]>设置服务器的用户和密码
 -U/--proxy-user <user[:password]>设置代理用户名和密码
 -v/--verbose
 -V/--version 显示版本信息
 -w/--write-out [format]什么输出完成后
 -x/--proxy <host[:port]>在给定的端口上使用HTTP代理
 -X/--request <command>指定什么命令
 -y/--speed-time 放弃限速所要的时间。默认为30
 -Y/--speed-limit 停止传输速度的限制，速度时间'秒'
 -z/--time-cond  传送时间设置
 -0/--http1.0  使用HTTP 1.0
 -1/--tlsv1  使用TLSv1（SSL）
 -2/--sslv2 使用SSLv2的（SSL）
 -3/--sslv3         使用的SSLv3（SSL）
 --3p-quote      like -Q for the source URL for 3rd party transfer
 --3p-url        使用url，进行第三方传送
 --3p-user       使用用户名和密码，进行第三方传送
 -4/--ipv4   使用IP4
 -6/--ipv6   使用IP6
 -#/--progress-bar 用进度条显示当前的传送状态
}

三、样例
{
179上访问文库
curl -x 172.18.32.134:8080 -U'mingzi:mima' GET 'http://wenku.baidu.com/?fr=swsy'

curl -o index.html -x 172.18.32.134:8080 -U'mingzi:mima' GET 'http://wenku.baidu.com/?fr=swsy'

curl -o index.html -x 172.18.32.134:8080 -U'mingzi:mima' GET 'http://wenku.baidu.com/?fr=swsy' |iconv -f utf8 -t gb2312 

179xshell设置为utf8 百度文库网页编码是gb2312 
curl -x 172.18.32.134:8080 -U'mingzi:mima' GET 'http://wenku.baidu.com/?fr=swsy' |iconv -f gb2312 -t utf8 -c
本地保存
curl -x 172.18.32.134:8080 -U'mingzi:mima' GET 'http://wenku.baidu.com/?fr=swsy' |iconv -f gb2312 -t utf8 -c - -o baidu.xml

iconv -c -f utf-8 -t gb2312 aaa.txt >bbb.txt
读取aaa.txt文件，从utf-8编码转换为gb2312编码,忽略无效的字符，其输出定向到bbb.txt文件。
}
