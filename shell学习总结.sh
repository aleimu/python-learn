ls /usr/bin/
info
#路径操作
dirname
basename
#“”和‘’与 ` ` 在shell变量中的区别       
“ ” 允许通过$符引用其他变量
‘’禁止引用其他变量符，视为普通字符
`` 将命令执行的结果输出给变量

#执行一个命令，但不保存在命令历史记录中
<space>command
man ascii

HISTSIZE=1000
export HISTSIZE

#并行执行的命令之间添加&，多条命令就可以并行执行。
ls & echo 'aaaaaaaa' & echo 'fesfsfse'
#串行执行命令“&&”。如果要查看一个程序所执行的时间，可以使用命令date&&./需要执行的程序&&date来查看
#shell1 && shell2 ,如果是用&&符连接的，那只有在shell1返回0（即正常）时，shell2才会执行，否则shell2根本就不执行，所以前面说得最后一种cd&&rm的这种做法是可行的，而且是安全的。那||呢，对于shell1||shell2，只有在shell1执行失败时，shell2才会执行，否则shell2是不执行得
常用的 for 循环{
#for循环
a="a b c d e f"
for x in $a; do  echo $x+'q'; done
for x in {1..9}; do  echo $x; done
for x in `seq 30`; do echo $x; done
select a in 1 2 3 4 5 6 7; do echo $a; done #创建选择菜单，无限循环 
sh -v install.sh #查看执行的代码
sh -n install.sh #语法检查，没有错误不显示内容
f=/home/config.ini
while read -r b; do echo $b+'dada'; done < "$f" #一行一行读取文件
while read b; do echo $b+'dada'; done < $f 
while read b; do echo "your input is $b"; done #读入键入的内容
cat 1.txt |while read line; do echo $line; done #读取文件
for x in `cat 1.txt`; do echo $x; done #按空格和回车读取文件
}
done & #后台执行循环
echo $SHELL  #查看当前环境所使用的shell解释器
#脚本一般第一行为：#!/bin/bash
chsh -l #查看系统支持哪些shell解释器

#=======常用命令========
常用命令{
	whereis ls                  # 查找命令的目录
	which                       # 查看当前要执行的命令所在的路径
	echo -n 123456 | md5sum     # md5加密
	vi /etc/hosts               # 查询静态主机名
	alias                       # 别名
	vmstat 1 9            # 每隔一秒报告系统性能信息9次
	ps aux |grep -v USER | sort -nk +4 | tail       # 显示消耗内存最多的10个运行中的进程，以内存使用量排序.cpu +3
	uname -a              # 查看Linux内核版本信息
	stty 用来改变并打印终端行设置的常用命令 >密码
	read -t 10 varname    # 更简单的方法就是利用read命令的-t选项
	iptables -F                        # 将防火墙中的规则条目清除掉
	/etc/init.d/sendmail start                   # 启动服务  
	/etc/init.d/sendmail stop                    # 关闭服务
	/etc/init.d/sendmail status                  # 查看服务当前状态
	/date/mysql/bin/mysqld_safe --user=mysql &   # 启动mysql后台运行
	vi /etc/rc.d/脚本.sh                         # 开机启动执行  可用于开机启动脚本
	/etc/rc.d/rc3.d/S55sshd                      # 开机启动和关机关闭服务连接    # S开机start  K关机stop  55级别 后跟服务名
	rsync -avzP -e "ssh -p 22" /dir user@$IP:/dir              # 同步目录 # --delete 无差同步 删除目录下其它文件
	ifconfig eth0:0 192.168.1.221 netmask 255.255.255.0        # 增加逻辑IP地址
	mtr -r www.baidu.com                                       # 测试网络链路节点响应时间 # trace ping 结合
	echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all           # 禁ping
	ipcalc -m "$ip" -p "$num"                                  # 根据IP和主机最大数计算掩码
	ssh -p 22 root@192.168.1.209 CMD                        # 利用ssh操作远程主机
	scp -P 22 文件 root@ip:/目录                            # 把本地文件拷贝到远程主机
	scp -r root@192.168.1.209:远程目录 本地目录                # 把远程指定文件拷贝到本地
	sshpass -p '密码' ssh -n root@$IP "echo hello"          # 指定密码远程操作
	ssh -o StrictHostKeyChecking=no $IP                     # ssh连接不提示yes
	du -h 目录                            # 检测目录下所有文件大小
	du -sh *                              # 显示当前目录中子目录的大小
	#鸟整理
	ls -l --full-time #显示具体时间
	ls --full-time resource/
	LANG=en_US #修改诧系
	ls -R resource/ #递归显示
	
	users                   # 显示所有的登录用户
	groups                  # 列出当前用户和他所属的组
	who -q                  # 显示所有的登录用户
	groupadd                # 添加组
	useradd user            # 建立用户
	passwd 用户             # 修改密码
	
	chown -R user:group     # 修改目录拥有者(R递归)
	chown y\.li:mysql       # 修改所有者用户中包含点"."
	umask                   # 设置用户文件和目录的文件创建缺省屏蔽值
	chgrp                   # 修改用户组
	finger                  # 查找用户显示信息
	
	echo "xuesong" | passwd user --stdin       # 非交互修改密码   newspo218:~ # echo "Huawei@123" |passwd root --stdin    好用！
	
	useradd -g www -M  -s /sbin/nologin  www   # 指定组并不允许登录的用户,nologin允许使用服务
	useradd -g www -M  -s /bin/false  www      # 指定组并不允许登录的用户,false最为严格
	usermod -l 新用户名 老用户名               # 修改用户名
	usermod -g user group                      # 修改用户所属组
	usermod -d 目录 -m 用户                    # 修改用户家目录
	usermod -G group user                      # 将用户添加到附加组
	gpasswd -d user group                      # 从组中删除用户
	su - user -c " #命令1; "                   # 切换用户执行
	
	脚本{
	
	#!/bin/sh         # 在脚本第一行脚本头 # sh为当前系统默认shell,可指定为bash等shell
	sh -x             # 执行过程
	sh -n             # 检查语法
	(a=bbk)           # 括号创建子shell运行
	basename /a/b/c   # 从全路径中保留最后一层文件名或目录
	dirname           # 取路径
	$RANDOM           # 随机数
	$$                # 进程号
	source FileName   # 在当前bash环境下读取并执行FileName中的命令  # 等同 . FileName
	sleep 5           # 间隔睡眠5秒
	trap              # 在接收到信号后将要采取的行动
	trap "" 2 3       # 禁止ctrl+c
	$PWD              # 当前目录
	$HOME             # 家目录
	$OLDPWD           # 之前一个目录的路径
	cd -              # 返回上一个目录路径
	local ret         # 局部变量
	yes               # 重复打印
	yes |rm -i *      # 自动回答y或者其他
	ls -p /home       # 查看目录所有文件夹
	ls -d /home/      # 查看匹配完整路径
	echo `ls`							  #执行 ls
	echo -n aa;echo bb                    # 不换行执行下一句话 将字符串原样输出
	echo -e "s\tss\n\n\n"                 # 使转义生效
	echo $a | cut -c2-6                   # 取字符串中字元
	echo {a,b,c}{a,b,c}{a,b,c}            # 排列组合(括号内一个元素分别和其他括号内元素组合)
	echo $((2#11010))                     # 二进制转10进制
	echo aaa | tee file                   # 打印同时写入文件 默认覆盖 -a追加
	echo {1..10}                          # 打印10个字符
	printf '%10s\n'|tr " " a              # 打印10个字符
	pwd | awk -F/ '{ print $2 }'          # 返回目录名
	tac file |sed 1,3d|tac                # 倒置读取文件  # 删除最后3行
	tail -3 file                          # 取最后3行
	outtmp=/tmp/$$`date +%s%N`.outtmp     # 临时文件定义
	:(){ :|:& };:                         # 著名的 fork炸弹,系统执行海量的进程,直到系统僵死
	echo -e "\e[32m....\e[0m"             # 打印颜色
	echo -e "\033[0;31mL\033[0;32mO\033[0;33mV\033[0;34mE\t\033[0;35mY\033[0;36mO\033[0;32mU\e[m"    # 打印颜色
}
	
	流程控制{
			break N     #  跳出几层循环
			continue N  #  跳出几层循环，循环次数不变
			continue    #  重新循环次数不变
		}
	
	变量{
		A="a b c def"           # 将字符串复制给变量
		A=`cmd`                 # 将命令结果赋给变量
		A=$(cmd)                # 将命令结果赋给变量
		eval a=\$$a             # 间接调用
		i=2&&echo $((i+3))      # 计算后打印新变量结果
		i=2&&echo $[i+3]        # 计算后打印新变量结果
		a=$((2>6?5:8))          # 判断两个值满足条件的赋值给变量
		A=(a b c def)           # 将变量定义为組数
		$1  $2  $*              # 位置参数 *代表所有
		env                     # 查看环境变量
		env | grep "name"       # 查看定义的环境变量
		set                     # 查看环境变量和本地变量
		read name               # 输入变量
		readonly name           # 把name这个变量设置为只读变量,不允许再次设置
		readonly                # 查看系统存在的只读文件
		export name             # 变量name由本地升为环境
		export name="RedHat"    # 直接定义name为环境变量
		export Stat$nu=2222     # 变量引用变量赋值
		unset name              # 变量清除
		export -n name          # 去掉只读变量
		shift                   # 用于移动位置变量,调整位置变量,使$3的值赋给$2.$2的值赋予$1
		name + 0                # 将字符串转换为数字
		number " "              # 将数字转换成字符串
		a=`ps -auxh|grep node|awk '{print $2}'`
		for x in seq $a; do kill $x; done #删除node的所有进程
	}	
}
#=======常用命令========
#每次执行循环，getopts 就检查下一个命令行参数，并判断它是否合法，即检查参数是否以“-”开头，后面跟一个包含在“options”中的字母。
#!/bin/bash

while{while getopts a:b: option
do
	case "${option}" in
		a) echo "option a, OPTARG is ${OPTARG}, OPTIND is ${OPTIND}!"
			;;
		b) echo "option b, OPTARG is ${OPTARG}, OPTIND is ${OPTIND}!"
			;;
		\?) echo "The option can only be '-a' or '-b', OPTIND is ${OPTIND}."
			exit 1
			;;
	esac	
done
}	
#Shell函数定义的变量默认是global的，其作用域从“函数被调用时执行变量定义的地方”开始，到shell结束或被显示删除处为止。
#Shell函数定义的变量默认是global的，其作用域从“函数被调用时执行变量定义的地方”开始，到shell结束或被显示删除处为止。函数定义的变量可以被显示定义成local的，其作用域局限于函数内。但请注意，函数的参数是local的。如果同名，Shell函数定义的local变量会覆盖脚本定义的同名的global变量。
declare -F #显示当前可见的所有函数
declare -f #查看详细函数代码

ifconfig网卡{
#网卡的常用命令
ifconfig -a #查看所有网卡
ifconfig eth85
ifconfig eth85 down
ifconfig eth85 up
#在eth85网口上，配置IP地址为156.41.50.11、子网掩码为255.255.255.0的IP
ifconfig eth85 156.41.50.11 netmask 255.255.255.0
#删除eth85网口上，IP地址为156.41.50.12、子网掩码为255.255.255.0的IP
ip addr del 156.41.50.12/24 dev eth85
ifconfig eth1:0 10.175.102.123 netmask 255.255.252.0 up 配置浮动ip
#防止重启失效
在/etc/sysconfig/network目录下，vi ifcfg-【网卡名称】【Mac地址】
例：ifcfg-eth1 ifcfg-E0:24:7F:B6:FD:1B
在文件中加入IP信息，并保存文件
BOOTPROTO='static'
STARTMODE='auto'
IPADDR='182.3.1.180'
NETMASK='255.255.0.0'
重启网卡让IP生效 rcnetwork restart eth5
#样例
BOOTPROTO='static'
BROADCAST=''
IPADDR='192.121.1.71'
NETMASK='255.255.255.0'
STARTMODE='auto'
USERCONTROL='no'
FIREWALL='no'
DEVICE=eth1
}
变量{
#赋值时等号两边不能有空格
#在使用变量时，要在变量前面加上符号$，但定义的时候不需要
变量的范围
1、未经特殊处理的变量均为全局变量
脚本中定义了的变量可以在该脚本中任何其他地方使用。
注意：函数内部定义的变量也可以在该函数以外使用。
2、可以用export把普通变量变成环境变量
环境变量可以被其子进程使用，而普通变量不可以。
export $var
3、可以用local来定义一个局部变量
local关键字只能在函数内部使用。
用local定义的变量只能在本函数。
#特殊变量
有些变量是一开始执行Script时就会设定，拥有特定含义，并且不能加以修改的。这些是系统特殊变量：
$0 当前脚本的名称
$n 脚本或函数的第n个参数值，n=1..9
$* 脚本或函数的所有参数
$# 脚本或函数的参数个数
$$ 当前shell进程的pid
$! 上一个shell后台进程的pid
$? 上一条命令返回值
其他参数：
$CDPATH 包含一系列目录名,cd命令对他们诸葛进行搜索来查找作为参数传递给它的目录;如果该变量未设置,cd命令搜索当前目录
$EDITOR  程序(如e-mail程序)里使用的默认编辑器
$ENV         UNIX查找配置文件的路径
$HOME  用户初次登录时的起始目录名
$MAIL  用户的系统邮箱文件的名称
$MAILCHECK  shell检查用户邮箱是否有新邮件并将结果通知用户的间隔时间(以秒为单位)
$PATH  包含用户的搜索路径的变量—shell用来搜索外部命令或程序的目录
$PPID  父进程的进程ID
$PS1   系统第一个提示符，一般为$
$PS2   系统第二个提示符，一般为>
$PWD   当前工作目录的名称
$TERM  用户的控制终端的类型.
$LINENO    所在的代码行，一般用来输出错误行号
shift [n]     将命令行参数往左移n位，但$0不变
export  变量名表 将变量名表所列变量传递给子进程
read    变量名表 从标准输入读字符串，传给指定变量
echo    变量名表 将变量名表指定的变量显示到标准输出
set     显示设置变量
env     显示目前所有变量
 
set命令可以重新设定参数表.如set hello  wold命令会设定$*为字符串hello world，$n和$#也同时受影响。
shift命令可以将所有参数左移一个单位，$*、$n、$#均受影响
}
从标准输入中读取一个字符串到一个变量中
read [variable]
read –n num [variable]    #从标准输入中读取num个字符到variable中(长度为num)
函数{
#传给函数的参数
调用函数时，参数跟在函数名后以空格分开。
函数中把传入的参数分别赋值给：$1 $2 $3 ……
#返回值
函数最后没有return，则返回最后一条命令的返回值。
把函数放在赋值语句右边，则函数的输出为其返回值。
}
数组{

root@api:/home/lgj/testfile# a=(1 2 35 23 43 42 65 423 75 12 )     <必须以空格分割
root@api:/home/lgj/testfile# echo ${a[0]}
1
root@api:/home/lgj/testfile# echo ${a[23]}

1.初始化
#!/bin/bash 
#指定索引值 
array1[0]=one 
array1[1]=1 
echo ${array1[0]} 
echo ${array1[1]} 
#全数组初始化 
array2=( one two three ) 
echo ${array2[0]} 
echo ${array2[2]} 
#间隔索引 
array3=( [9]=nine [11]=11 ) 
echo ${array3[9]} 
echo ${array3[11]} 
#读取键盘输入，空格隔开，换行结束 
read -a array4 
exit 0
2.操作
!/bin/bash 
array=( apple bat cat dog elephant frog ) 
#打印第一个元素 
echo ${array[0]} 
echo ${array:0} 
#打印所有元素 
echo ${array[@]}
echo ${array[*]} 
echo ${array[@]:0} 
#除了第一个元素，打印所有元素 
echo ${array[@]:1} 
#从第二个元素开始，打印四个元素 
echo ${array[@]:1:4} 
#第一个元素的长度
echo ${#array[0]} 
echo ${#array} 
#总元素数
echo ${#array[*]} 
echo ${#array[@]} 
#将元素的a替换为A 
echo ${array[@]//a/A} 
exit 0
3.遍历
for i in “${array[@]}”
do
	#access each element as $i. . .
done 
for x in ${b[@]};do echo $x; done
4.删除
直接通过：unset 数组[下标] 可以清除相应的元素。
echo ${varlist[*]}
1 100 3 4 5 8
unset varlist[7]
echo ${varlist[*]}
1 100 3 4 5
不带下标，清除整个数据
unset varlist
}
载入文件{
source libFile
. libFile     #载入文件libFile
关键字为“. ”（点＋空格），相当于Ｃ语言中的include。
}  
标准输出与输入{
1 标准输出，一般为显示器
2 错误输出，一般为显示器
> 先清空文件内容，再把输出重定向到文件。
>> 把输出的内容一追加的方式重定向到文件。
}
awk的好处：自动分割字符串，即我们在调用awk时，awk就已经把字符串分割成若干小段并按顺序存储在变量$1、$2、$3……中了。
awk支持正则表达式，可支持非常复杂的用法，但我们通常只用到了它的一个很基本的语法：#取某列的值
cat
{
主要有三大功能：
1.一次显示整个文件。$ cat filename
2.从键盘创建一个文件。$ cat > filename  <<qq
qq
创建fiename文件，追加内容，遇到qq时结束输入
只能创建新文件,不能编辑已有文件.
3.将几个文件合并为一个文件： $cat file1 file2 > file

cat -n config.ini 显示行编号
}
cut
{
cut  [-bn] [file] 或 cut [-c] [file]  或  cut [-df] [file]
使用说明
cut 命令从文件的每一行剪切字节、字符和字段并将这些字节、字符和字段写至标准输出。
如果不指定 File 参数，cut 命令将读取标准输入。必须指定 -b、-c 或 -f 标志之一。

主要参数
-b ：以字节为单位进行分割。这些字节位置将忽略多字节字符边界，除非也指定了 -n 标志。
-c ：以字符为单位进行分割。
-d ：自定义分隔符，默认为制表符。
-f  ：与-d一起使用，指定显示哪个区域。
-n ：取消分割多字节字符。仅和 -b 标志一起使用。如果字符的最后一个字节落在由 -b 标志的 List 参数指示的<br />范围之内，该字符将被写出；否则，该字符将被排除
#实例
$ cat /etc/passwd | tail -n 5 | cut -d : -f 1
postfix
apache
icecream
mysql
news
}
du
{
查看目录的大小
-s 只显示最终结果
-m 以M为单位显示
-k 以K为单位显示
-h 以合适的单位显示
 常用：
du –hs ./*
}
sed
{
sed -i 's/cpu/lgj/' sys_info.txt #将修改生效到原文件
常用sed的语法：
1. p：打印
sed 'num1,num2p' fileName    #打印fileName中的num1到num2行
2. s：替换字符串
sed 's/str1/str2/' fileName      #把fileName中str1替换成str2（只替换每一行中的第一个str1）
3. g：全局
sed 's/str1/str2/g' fileName      #把fileName中str1替换成str2（替换所有的）
4. y：替换字符
sed 'y/abc/ABC/g' fileName      #把fileName中所有的a替换成Ａ，b替换成Ｂ，
 参数-e：执行一条命令。可以用-e参数给一行一次执行多条命令以提高效率
sed –e 'command1' –e 'command2' …… fileName    #文件中的每一行执行命令：command1 #command2 ......
 ^：行的开头
$：行的结尾
sed 's/^str1/str2/' fileName     #把fileName中每行开头的str1替换成str2
sed –e 's/^str1/str2/' –e 's/str1$/str2/' fileName
 
一些常用场景介绍：
1．行的匹配
 sed -n '2p' /etc/passwd 打印出第2行
 sed -n '1,3p' /etc/passwd 打印出第1到第3行
 sed -n '$p' /etc/passwd   打印出最后一行
 sed -n '/user/'p /etc/passwd 打印出含有user的行
 sed -n '/\$/'p /etc/passwd 打印出含有$元字符的行，$意为最后一行
2．插入文本和附加文本(插入新行)
 sed -n '/FTP/p' /etc/passwd 打印出有FTP的行
 ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
 sed '/FTP/ a\ 456' /etc/passwd 在含有FTP的行后面新插入一行，内容为456
 sed '/FTP/ i\ 123' /etc/passwd在含有FTP的行前面新插入一行，内容为123
 sed '/FTP/ i\ "123"' /etc/passwd在含有FTP的行前面新插入一行，内容为"123"
 sed '5 a\ 123' /etc/passwd         在第5行后插入一新行，内容为123
 sed '5 i\ “12345”' /etc/passwd   在第5行前插入一新行，内容为“12345”
3．删除文本
 sed '1d' /etc/passwd 删除第1行
 sed '1,3d' /etc/passwd 删除第1至3行
 sed '/user/d' /etc/passwd 删除带有user的行
 sed -i '/^$/d' ver_info.txt #删除空行
 sed 's/remote_gateway_hostname.*/remote_gateway_hostname=/' config.ini  #很有用
4． 替换文本,替换命令用替换模式替换指定模式，格式为：
[ a d d r e s s [，address]] s/ pattern-to-find /replacement-pattern/[g p w n]
 sed 's/user/USER/' /etc/passwd     将第1个user替换成USER,g表明全局替换
 sed 's/user/USER/g' /etc/passwd    将所有user替换成USER
 sed 's/user/#user/' /etc/passwd    将第1个user替换成#user,如用于屏蔽作用
 sed 's/user//' /etc/passwd         将第1个user替换成空
 sed 's/user/&11111111111111/' /etc/passwd 如果要附加或修改一个很长的字符串，可以使用（ &）命令，&命令保存发现模式以便重新调用它，然后把它放在替换字符串里面，这里是把&放前面
 sed 's/user/11111111111111&/' /etc/passwd 这里是将&放后面
5. 快速一行命令
 下面是一些一行命令集。（[ ]表示空格，[ ]表示t a b键）
's / \ . $ / / g' 删除以句点结尾行
'-e /abcd/d' 删除包含a b c d的行
's / [ ] [ ] [ ] * / [ ] / g' 删除一个以上空格，用一个空格代替
's / ^ [ ] [ ] * / / g' 删除行首空格
's / \ . [ ] [ ] * / [ ] / g' 删除句点后跟两个或更多空格，代之以一个空格
'/ ^ $ / d' 删除空行
's / ^ . / / g' 删除第一个字符
's /COL \ ( . . . \ ) / / g' 删除紧跟C O L的后三个字母
's / ^ \ / / / g' 从路径中删除第一个\
's / [ ] / [ ] / / g' 删除所有空格并用t a b键替代
'S / ^ [ ] / / g' 删除行首所有t a b键
's / [ ] * / / g' 删除所有t a b键
 如果使用sed对文件进行过滤，最好将问题分成几步，分步执行，且边执行边测试结果。
}
sed
{
			引用外部变量{
			sed -n ''$a',10p'
			sed -n ""$a",10p"
		}
		sed 10q                                       # 显示文件中的前10行 (模拟"head")											实例
		sed -n '$='                                   # 计算行数(模拟 "wc -l")
		sed -n '5,/^no/p'                             # 打印从第5行到以no开头行之间的所有行
		sed -i "/^$f/d" a     　　                  　# 删除匹配行
		sed -i '/aaa/,$d'                             # 删除匹配行到末尾
		sed -i "s/=/:/" c                             # 直接对文本替换
		sed -i "/^pearls/s/$/j/"                      # 找到pearls开头在行尾加j
		sed '/1/,/3/p' file                           # 打印1和3之间的行
		sed -n '1p' 文件                              # 取出指定行
		sed '5i\aaa' file                             # 在第5行之前插入行
		sed '5a\aaa' file                             # 在第5行之后抽入行
		echo a|sed -e '/a/i\b'                        # 在匹配行前插入一行
		echo a|sed -e '/a/a\b'                        # 在匹配行后插入一行
		echo a|sed 's/a/&\nb/g'                       # 在匹配行后插入一行
		seq 10| sed -e{1,3}'s/./a/'                   # 匹配1和3行替换
		sed -n '/regexp/!p'                           # 只显示不匹配正则表达式的行
		sed '/regexp/d'                               # 只显示不匹配正则表达式的行
		sed '$!N;s/\n//'                              # 将每两行连接成一行
		sed '/baz/s/foo/bar/g'                        # 只在行中出现字串"baz"的情况下将"foo"替换成"bar"                       	sed -i '/remote_gateway_hostname/s/iom/lgj/' config.ini
		sed '/baz/!s/foo/bar/g'                       # 将"foo"替换成"bar"，并且只在行中未出现字串"baz"的情况下替换
		echo a|sed -e 's/a/#&/g'                      # 在a前面加#号															sed -e 's/remote_gateway_hostname=/&11111/g' config.ini 后面加1111
		sed 's/foo/bar/4'                             # 只替换每一行中的第四个字串
		sed 's/\(.*\)foo/\1bar/'                      # 替换每行最后一个字符串
		sed 's/\(.*\)foo\(.*foo\)/\1bar\2/'           # 替换倒数第二个字符串
		sed 's/[0-9][0-9]$/&5'                        # 在以[0-9][0-9]结尾的行后加5
		sed -n ' /^eth\|em[01][^:]/{n;p;}'            # 匹配多个关键字
		sed -n -r ' /eth|em[01][^:]/{n;p;}'           # 匹配多个关键字
		echo -e "1\n2"|xargs -i -t sed 's/^/1/' {}    # 同时处理多个文件
		sed '/west/,/east/s/$/*VACA*/'                # 修改west和east之间的所有行，在结尾处加*VACA*
		sed  's/[^1-9]*\([0-9]\+\).*/\1/'             # 取出第一组数字，并且忽略掉开头的0
		sed -n '/regexp/{g;1!p;};h'                   # 查找字符串并将匹配行的上一行显示出来，但并不显示匹配行
		sed -n ' /regexp/{n;p;}'                      # 查找字符串并将匹配行的下一行显示出来，但并不显示匹配行
		sed -n 's/\(mar\)got/\1ianne/p'               # 保存\(mar\)作为标签1
		sed -n 's/\([0-9]\+\).*\(t\)/\2\1/p'          # 保存多个标签
		sed -i -e '1,3d' -e 's/1/2/'                  # 多重编辑(先删除1-3行，在将1替换成2)
		sed -e 's/@.*//g' -e '/^$/d'                  # 删除掉@后面所有字符，和空行												sed 's/remote_gateway_hostname.*/remote_gateway_hostname=/' config.ini
		sed -n -e "{s/文本(正则)/替换的内容/p}"       # 替换并打印出替换行
		sed -n -e "{s/^ *[0-9]*//p}"                  # 打印并删除正则表达式的那部分内容
		echo abcd|sed 'y/bd/BE/'                      # 匹配字符替换
		sed '/^#/b;y/y/P/' 2                          # 非#号开头的行替换字符
		sed '/suan/r 读入文件'                        # 找到含suan的行，在后面加上读入的文件内容
		sed -n '/no/w 写入文件'                       # 找到含no的行，写入到指定文件中
		sed '/regex/G'                                # 在匹配式样行之后插入一空行
		sed '/regex/{x;p;x;G;}'                       # 在匹配式样行之前和之后各插入一空行
		sed 'n;d'                                     # 删除所有偶数行
		sed 'G;G'                                     # 在每一行后面增加两空行
		sed '/^$/d;G'                                 # 在输出的文本中每一行后面将有且只有一空行
		sed 'n;n;n;n;G;'                              # 在每5行后增加一空白行
		sed -n '5~5p'                                 # 只打印行号为5的倍数
		seq 1 30|sed  '5~5s/.*/a/'                    # 倍数行执行替换
		sed -n '3,${p;n;n;n;n;n;n;}'                  # 从第3行开始，每7行显示一次
		sed -n 'h;n;G;p'                              # 奇偶调换
		seq 1 10|sed '1!G;h;$!d'                      # 倒叙排列
		ls -l|sed -n '/^.rwx.*/p'                     # 查找属主权限为7的文件
		sed = filename | sed 'N;s/\n/\t/'             # 为文件中的每一行进行编号(简单的左对齐方式)	
		sed 's/^[ \t]*//'                             # 将每一行前导的"空白字符"(空格，制表符)删除,使之左对齐 					sed 's/^[ \t]*//' config.ini
		sed 's/^[ \t]*//;s/[ \t]*$//'                 # 将每一行中的前导和拖尾的空白字符删除
		echo abcd\\nabcde |sed 's/\\n/@/g' |tr '@' '\n'        # 将换行符转换为换行
		cat tmp|awk '{print $1}'|sort -n|sed -n '$p'           # 取一列最大值
		sed -n '{s/^[^\/]*//;s/\:.*//;p}' /etc/passwd          # 取用户家目录(匹配不为/的字符和匹配:到结尾的字符全部删除)
		sed = filename | sed 'N;s/^/      /; s/ *\(.\{6,\}\)\n/\1   /'   # 对文件中的所有行编号(行号在左，文字右端对齐)
		/sbin/ifconfig |sed 's/.*inet addr:\(.*\) Bca.*/\1/g' |sed -n '/eth/{n;p}'   # 取所有IP
	}
	
awk
{
cat $config |grep database_ip | awk -F= '{print $1}' #以=为分隔符
cat $config |grep database_ip | awk -F'=' '{print $2}' #同上
cat $config |grep database_ip | awk -F = '{print $1}' #同上
}
trap信号处理{
trap [COMMANDS] [SIGNALS]
trap会捕获在[SIGNALS]的信号，在捕获到信号后，会执行COMMANDS命令。
给进程的某个（或多个）信号设置一段代码:
trap 'code' signa1l signal2 signal3 ……
我们可以给一个进程的某些信号设置一些代码，然后在其他进程中用kill来发送该信号给这个进程。
最常用的场景是shell脚本的异常处理，可以在脚本退出时自动做一些清理动作。
示例：
#!/bin/bash
 trap1()
 {
     echo "I get exit signal! Remove temp file"
     rm -f tempfile
 }
 echo "Create a tempfile"
 touch tempfile
 trap 'echo I will not stop!' 1 2 3 15;
 trap 'trap1' 2 EXIT;
 sleep 20
 exit 0
 捕捉信号，然后执行echo显示提示调用程序处理信号
 trap commands signal-list
 trap -l #查看所有信号
 常见信号
 HUP(1)        挂起，通常因终端掉线或用户退出而引发
 INT(2)        中断，通常因按下Ctrl+C组合键而引发
 QUIT(3)       退出，通常因按下Ctrl+\组合键而引发
 ABRT(6)       中止，通常因某些严重的执行错误而引发
 ALRM(14)      报警，通常用来处理超时
 TERM(15)      终止，通常在系统关机时发送就是中断信号(linux 中是ctrl-C，SCO unix 中是"del"键)
}
find{
find 命令格式
1、find命令的一般形式为；
find pathname -options [-print -exec -ok ...]
2、find命令的参数；
pathname: find命令所查找的目录路径。例如用.来表示当前目录，用/来表示系统根目录。
-print： find命令将匹配的文件输出到标准输出。
-exec： find命令对匹配的文件执行该参数所给出的shell命令。相应命令的形式为'command' {} \;，注意{}和\；之间的空格。{}表示find 找到的内容
-ok： 和-exec的作用相同，只不过以一种更为安全的模式来执行该参数所给出的shell命令，在执行每一个命令之前，都会给出提示，让用户来确定是否执行。
3、find命令选项
-name 
按照文件名查找文件。
让当前目录中文件属主具有读、写权限，并且文件所属组的用户和其他用户具有读权限的文件；
$ find . -type f -perm 644 -exec ls -l {  } \;
为了查找系统中所有文件长度为0的普通文件，并列出它们的完整路径；
$ find / -type f -size 0 -exec ls -l {  } \;
查找/var/logs目录中更改时间在7日以前的普通文件，并在删除之前询问它们；
$ find /var/logs -type f -mtime +7 -ok rm {  } \;
find命令配合使用exec和xargs可以使用户对所匹配到的文件执行几乎所有的命令
find . -type f -print | xargs file
-0 当sdtin含有特殊字元时候，将其当成一般字符，
例如：root@localhost:~/test#echo "//"|xargs  echo 
      root@localhost:~/test#echo "//"|xargs -0 echo 
-a file 从文件中读入作为sdtin，（看例一）
-e flag ，注意有的时候可能会是-E，flag必须是一个以空格分隔的标志，当xargs分析到含有flag这个标志的时候就停止。（例二）
-p 当每次执行一个argument的时候询问一次用户。（例三）
-n num 后面加次数，表示命令在执行的时候一次用的argument的个数，默认是用所有的。（例四）
-t 表示先打印命令，然后再执行。（例五）
-i 或者是-I，这得看linux支持了，将xargs的每项名称，一般是一行一行赋值给{}，可以用{}代替。（例六）
-r no-run-if-empty 当xargs的输入为空的时候则停止xargs，不用再去执行了。（例七）
-s num 命令行的最好字符数，指的是xargs后面那个命令的最大命令行字符数。（例八）
-L  num Use at most max-lines nonblank input lines per command line.-s是含有空格的。
-l  同-L
-d delim 分隔符，默认的xargs分隔符是回车，argument的分隔符是空格，这里修改的是xargs的分隔符（例九）
-x exit的意思，主要是配合-s使用。
-P 修改最大的进程数，默认是1，为0时候为as many as it can ，这个例子我没有想到，应该平时都用不到的吧。
#替换当前目录下面所有符合html后缀文件里面的"NAN.html"成"NAN.htm"
find . -type f -name "*.html" -exec sed -i 's/\bNAN.html\b/NAN.htm/i' {} +
#copy找到的文件到指定目录
find /path/to/search/ -type f -name "regular-expression-to-find-files" | xargs cp -t /target/path/
#查到当前目录下文件里的lgj字段
find . -name "*" | xargs grep -i "lgj"
例子{
查找文件：find . -type f -name "*.sh*" 
查找文件中的内容：find . -type f -name "*.xml*" | xargs grep -r "172.21.4.95"
查询并替换：find . -name "*.properties" | xargs sed -i 's/cpsadt8/cpsadt/g';
统计文件中的记录数：find ./ -name "*sms20120301*.unl" | awk '{if ($7< "17:01") print $8}' |wc -l
文件批量转移：find ./ -type f -name '*201205*' -exec mv {} ../bak \; 
文件批量删除:find ./ -type f -name '*201205*.unl' -exec rm {} \;
文件的修改:find ./ -name 'clr20111213*'|xargs awk -F "|" ' { if ( substr($4,1,2) == "09" ) print $0 } '
find ./ -name 'clr20111214*'|xargs awk -F"|" ' { if ( substr($4,1,2) == "09" ) print FILENAME "|" $0 }'
执行压缩： find . -name "*20111127*.unl" | xargs tar czvf 20111123.tar.gz
find . -name "*20111121*"| wc -l
find . -name "*20120212*"| xargs tar czvf 2012-02-12.tar.gz
执行删除确认：find . -name "*20111225*.unl" | awk '{print "rm "$1}' | head
find . -name "*20111209*" | awk '{print "rm "$1}'
执行删除：find . -name "*20111124*"| awk '{print "rm" $1}' | ksh
find . -name "*vou*.unl" | awk '{print $1}' | wc -l
查找端口号：find -name "*" | xargs grep -i 端口号
忽略某个目录：$ find /apps -name "/apps/bin" -prune -o -print
在系统根目录下查找更改时间在5日以内的文件：$ find/ mtime 5 print
在/var/adm目录下查找更改时间在3日以前的文件：$ find /var/adm mtime +3 print
在当前目录下查找文件长度大于1M字节的文件：$find . -size +1000000c -print
用ls-l命令列出所匹配到的文件，可以把ls-l命令放在find命令的-exec选项中：$ find . -type f -exec ls-l {} \;
命令在当前目录中查找所有文件名以.LOG结尾、更改时间在5日以上的文件，并
删除它们，只不过在删除之前先给出提示。
$ find . -name “*.LOG” -mtime +5 -ok rm {} \; -- <rm … ./nets.LOG> ?y
}
}

grep{
		-c    # 显示匹配到得行的数目，不显示内容
		-h    # 不显示文件名
		-i    # 忽略大小写
		-l    # 只列出匹配行所在文件的文件名
		-n    # 在每一行中加上相对行号
		-s    # 无声操作只显示报错，检查退出状态
		-v    # 反向查找
		-e    # 使用正则表达式
		-A3   # 打印匹配行和下三行
		-w    # 精确匹配
		-wc   # 精确匹配次数
		-o    # 查询所有匹配字段
		-P    # 使用perl正则表达式
		grep -v "a" txt                              # 过滤关键字符行
		grep -w 'a\>' txt                            # 精确匹配字符串
		grep -i "a" txt                              # 大小写敏感
	}
grep{
使用：grep  [选项] 模式  [文件...]

  .   匹配任意一个字符
  * 匹配0个或多个*前的字符
  ^ 匹配行开头
  $ 匹配行结尾
  [] 匹配[ ]中的任意一个字符，[]中可用 - 表示范围，
   例如[a-z]表示字母a 至z 中的任意一个
  \ 转意字符 
  
-? 
同时显示匹配行上下的？行，如：grep -2 pattern filename同时显示匹配行的上下2行。
-b，--byte-offset 
打印匹配行前面打印该行所在的块号码。
-c,--count 
只打印匹配的行数，不显示匹配的内容。
-f File，--file=File 
从文件中提取模板。空文件中包含0个模板，所以什么都不匹配。
-h，--no-filename 
当搜索多个文件时，不显示匹配文件名前缀。
-i，--ignore-case 
忽略大小写差别。
-q，--quiet 
取消显示，只返回退出状态。0则表示找到了匹配的行。
-l，--files-with-matches 
打印匹配模板的文件清单。
-L，--files-without-match 
打印不匹配模板的文件清单。
-n，--line-number 
在匹配的行前面打印行号。
-s，--silent 
不显示关于不存在或者无法读取文件的错误信息。
-v，--revert-match 
反检索，只显示不匹配的行。
-w，--word-regexp 
如果被\<和\>引用，就把表达式做为一个单词搜索。
-V，--version 
显示软件版本信息。

}
日常杂货{
nohup命令：如果你正在运行一个进程，而且你觉得在退出帐户时该进程还不会结束，那么可以使用nohup命令。该命令可以在你退出帐户/关闭终端之后继续运行相应的进程。nohup就是不挂断的意思( no hang up)。
该命令的一般形式为：nohup command &
使用nohup命令提交作业
如果使用nohup命令提交作业，那么在缺省情况下该作业的所有输出都被重定向到一个名为nohup.out的文件中，除非另外指定了输出文件：
nohup command > myout.file 2>&1 &
在上面的例子中，0 – stdin (standard input)，1 – stdout (standard output)，2 – stderr (standard error) ；
2>&1是将标准错误（2）重定向到标准输出（&1），标准输出（&1）再被重定向输入到myout.file文件中。
使用 jobs 查看任务。
使用 fg %n　关闭。
cal 2007 显示2007年的日历表
ifconfig eth1:0 10.175.102.123 netmask 255.255.252.0 up 配置浮动ip
tee命令。它把输出的一个副本输送到标准输出，另一个副本拷贝到相应的文件中。如果希望在看到输出的同时，也将其存入一个文件，
它的一般形式为：
tee -a files
其中，- a表示追加到文件末尾。
pwd |tee -a hello.txt
grep hello *  在当前目录下所有的文件里查找 hello字段
grep -E 'hello|123' * 在当前目录下所有的文件里查找 hello字段或123字段
grep '\.' * 查询有特殊含义的字符，$ .  * [] ^ | \ + ? ,必须在特定字符前加\。假设要查询包含“.”的所有行
'command << limiter' 把从标准输入中读入，直至遇到分界符limiter
cat >>hello.txt <<123
写入到hello.txt，当遇到123时，停止输入
grep 'qwer' hello.t >>hello.err 2>&1  把标准输出和标准错误一起重定向到hello.err文件中 (追加){
iom18:/home/lgjtest # grep 'qwer' hello.t >>hello.err
grep: hello.t: No such file or directory
iom18:/home/lgjtest # grep 'qwer' hello.t >>hello.err 2>&1
iom18:/home/lgjtest #
}
0、1、2是标准输入、输出和错误。
#查看执行时间
iom18:/home/lgjtest # time read -t 5
real	0m5.000s
user	0m0.000s
sys	0m0.000s
#输入时限  read -t 5  5秒内可输入
READ_TIMEOUT=5
read -t "$READ_TIMEOUT" input
# if you do not want quotes, then escape it 
input=$(sed "s/[;\`\"\$\' ]//g" <<< $input)
# For reading number, then you can escape other characters 
input=$(sed 's/[^0-9]*//g' <<< $input)
}
sftp与scp{
下载远程文件或目录到本地,如果想上传或想下载目录，最佳的办法是采用tar压缩一下，是最明智的选择.
scp user@host:/path/file /localpath       下载文件到本地                                                            
scp -r user@host:/dirpath /localpath      拷贝目录到本地
上传本地目录或文件到远程
scp localfile user@host:/dirpath
scp -r localdir user@host:/dirpath
如果使用SFTP不是默认端口号22： sftp -oPort=<port> <user>@<host>
例：sftp -oPort=29 hpcrf@10.64.208.58
}
if (判断){
if [ -d ./srvTestResult ];then
        rm -rf ./srvTestResult 
fi	
if [ ! -d ./TestResult ];then
        mkdir ./TestResult       
fi
if [ 1 -le 1 ]; then echo 1; fi
#注意空格
-n str   # 字符串str是否不为空
-z str   # 字符串str是否为空

if [ -z $1 ]; then
  echo "none"  
else
  echo "$1"
fi


-eq 数值相等。
-ne 数值不相等。
-gt 第一个数大于第二个数。
-lt 第一个数小于第二个数。
-le 第一个数小于等于第二个数。
-ge 第一个数大于等于第二个数。
-a 逻辑与，操作符两边均为真，结果为真，否则为假。
-o 逻辑或，操作符两边一边为真，结果为真，否则为假。
! 逻辑否，条件为假，结果为真。
test -f new1.sh -a -f new2.sh  等同 [ -f new1.sh -a -f new2.sh ]
echo $?   查看结果
%%%%%%%%%%%%%%%%%%%%%
0表示真 ，1 表示假%%%
%%%%%%%%%%%%%%%%%%%%%
		
shell中条件判断if中的-z到-d的意思
[ -a FILE ] 如果 FILE 存在则为真。 
[ -b FILE ] 如果 FILE 存在且是一个块特殊文件则为真。 
[ -c FILE ] 如果 FILE 存在且是一个字特殊文件则为真。 
[ -d FILE ] 如果 FILE 存在且是一个目录则为真。 
[ -e FILE ] 如果 FILE 存在则为真。 
[ -f FILE ] 如果 FILE 存在且是一个普通文件则为真。 
[ -g FILE ] 如果 FILE 存在且已经设置了SGID则为真。
[ -h FILE ] 如果 FILE 存在且是一个符号连接则为真。 
[ -k FILE ] 如果 FILE 存在且已经设置了粘制位则为真。 
[ -p FILE ] 如果 FILE 存在且是一个名字管道(F如果O)则为真。
[ -r FILE ] 如果 FILE 存在且是可读的则为真。 
[ -s FILE ] 如果 FILE 存在且大小不为0则为真。 
[ -t FD ] 如果文件描述符 FD 打开且指向一个终端则为真。 
[ -u FILE ] 如果 FILE 存在且设置了SUID (set user ID)则为真。
[ -w FILE ] 如果 FILE 如果 FILE 存在且是可写的则为真。 
[ -x FILE ] 如果 FILE 存在且是可执行的则为真。 
[ -O FILE ] 如果 FILE 存在且属有效用户ID则为真。 
[ -G FILE ] 如果 FILE 存在且属有效用户组则为真。 
[ -L FILE ] 如果 FILE 存在且是一个符号连接则为真。 
[ -N FILE ] 如果 FILE 存在 and has been mod如果ied since it was last read则为真。 
[ -S FILE ] 如果 FILE 存在且是一个套接字则为真。 
[ FILE1 -nt FILE2 ] 如果 FILE1 has been changed more recently than FILE2, or 如果 FILE1 exists and FILE2 does not则为真。 
[ FILE1 -ot FILE2 ] 如果 FILE1 比 FILE2 要老, 或者 FILE2 存在且 FILE1 不存在则为真。 
[ FILE1 -ef FILE2 ] 如果 FILE1 和 FILE2 指向相同的设备和节点号则为真。 
[ -o OPTIONNAME ] 如果 shell选项 “OPTIONNAME” 开启则为真。
[ -z STRING ] “STRING” 的长度为零则为真。 
[ -n STRING ] or [ STRING ] “STRING” 的长度为非零 non-zero则为真。 [ STRING1 == STRING2 ] 如果2个字符串相同。 “=” may be used instead of “==” for strict POSIX compliance则为真。 
[ STRING1 != STRING2 ] 如果字符串不相等则为真。 
[ STRING1 < STRING2 ] 如果 “STRING1” sorts before “STRING2” lexicographically in the current locale则为真。 
[ STRING1 > STRING2 ] 如果 “STRING1” sorts after “STRING2” lexicographically in the current locale则为真。 
[ ARG1 OP ARG2 ] “OP” is one of -eq, -ne, -lt, -le, -gt or -ge. These arithmetic binary operators return true if “ARG1” is equal to, not equal to, less than, less than or equal to, greater than, or greater than or equal to “ARG2”, respectively. “ARG1” and “ARG2” are integers. 
}
创建用户{
     useradd -d 绝对路径 -s 指定shell类型 -g 指定用户组 -m 指定创建home下的目录 用户名。
     例子：useradd -d /export/home/lgj -s /bin/bash -g users -m lgj
     创建后，创建此account的密码：
     passwd lgj 回车，提示中输入密码信息。
}
date{
 date +%Y%m%d -d "2 day ago" 
 date +%Y%m%d -d "2 week ago" 
 date +%Y%m%d -d "2 month ago" 
 date +%Y%m%d -d "2 year ago" 
 date -d "yesterday"
 
 昨天的命令是： 
yesterdayformat=`date --date='yesterday' "+%Y-%m-%d_%H:%M:%S"` 
 echo $yesterdayformat 
输出格式是： 
2006-03-30_08:39:54 
明天的命令是： 
tomorrowformat=`date --date='tomorrow' "+%Y-%m-%d_%H:%M:%S"` 
 echo $tomorrowformat 
输出格式是： 
2006-04-01_08:41:29 
在Linux下，得到N天以前或以后的日期格式： 
#date –I –d '-n day'   (可以得到N天前的日期，格式为YYYY-MM-DD) 
 #date –d '-n day' “＋％Y%m%d”       (可以得到你天前的日期，格式为YYYYMMDD) 
 #date –I –d '+n day'   (可以得到N天后的日期，格式为YYYY-MM-DD) 
 #date –d '+n day' “＋％Y%m%d”       (可以得到你天后的日期，格式为YYYYMMDD) 
 
}
split分割文件{
1、Linux里切割大文件的命令如下：
split [OPTION] [INPUT [PREFIX]] 
选项如下：
-a : 指定后缀长度
-b : 每个文件多少字节
-d : 使用数字后缀而不是字母
-l : 指定每个文件的行数
2、比如我想让后缀长度为 2，即 -a 2。用数字后缀 -d。每个文件 1M，即 -b 1m。命令可以设计如下：
split -a 2 -d -b 1m /var/lib/mysql/general.log 前缀名
}
diff|patch 文件对比补丁{
	diff suzu.c suzu2.c  > sz.patch         # 制作补丁
	patch suzu.c < sz.patch                 # 安装补丁
}
vi{
	:set nu            # 打开行号
	:set nonu          # 取消行号
	%s/字符1/字符2/g   # 全部替换	
	vim -O2 file1 file2    # 垂直分屏
}
tar{ 
		tar xvf 1.tar -C 目录        # 解包tar
		tar -cvf 1.tar *             # 打包tar
		tar tvf 1.tar                # 查看tar
		tar -rvf 1.tar 文件名        # 给tar追加文件
}
seq{
		# 不指定起始数值，则默认为 1
		-s   # 选项主要改变输出的分格符, 预设是 \n
		-w   # 等位补全，就是宽度相等，不足的前面补 0
		-f   # 格式化输出，就是指定打印的格式
		seq 10 100               # 列出10-100
		seq 1 10 |tac            # 倒叙列出
		seq -s '+' 90 100 |bc    # 从90加到100
		seq -f 'dir%g' 1 10 | xargs mkdir     # 创建dir1-10
		seq -f 'dir%03g' 1 10 | xargs mkdir   # 创建dir001-010
	}
chmod {
chgrp ：改变档案所属群组 
chown ：改变档案拥有者 
chmod ：改变档案的权限, SUID, SGID, SBIT 等等
groupadd ：创建用户组
[-][rwx][r-x][r--] 
 1  234  567  890 
1 为：代表这个文件名为目彔戒档案，本例中为档案(-)； 
234为：拥有者的权限，本例中为可读、可写、可执行(rwx)； 
567为：同群组用户权力，本例中为可读可执行(rx)； 
890为：其他用户权力，本例中为可读(r) 

r:4 
w:2 
x:1 

语法：chmod [who] [+ | - | =] [mode] 文件名
-c, --changes 
只有在文件的权限确实改变时才进行详细的说明 
-f, --silent, --quiet 
不输出权限不能改变的文件的错误信息 
-v, --verbose 
详细说明权限的变化 
-R, --recursive 
改变目录及其所有子目录的文件的权限 

命令中各选项的含义为：
操作对象who可是下述字母中的任一个或者它们的组合：
　　u 表示“用户（user）”，即文件或目录的所有者。
　　g 表示“同组（group）用户”，即与文件属主有相同组ID的所有用户。
　　o 表示“其他（others）用户”。
　　a 表示“所有（all）用户”。它是系统默认值。
操作符号可以是：
　　+ 添加某个权限。
　　- 取消某个权限。
　　= 赋予给定权限并取消其他所有权限（如果有的话）。
设置 mode 所表示的权限可用下述字母的任意组合：
　　r 可读。
　　w 可写。
  　x 可执行。
　　X 只有目标文件对某些用户是可执行的或该目标文件是目录时才追加x 属性。
　　s 在文件执行时把进程的属主或组ID置为该文件的文件属主。
      方式“u＋s”设置文件的用户ID位，“g＋s”设置组ID位。
　　t 保存程序的文本到交换设备上。
　　u 与文件属主拥有一样的权限。
　　g 与和文件属主同组的用户拥有一样的权限。
　　o 与其他用户拥有一样的权限。文件名：以空格分开的要改变权限的文件列表，支持通配符。
　　 
在一个命令行中可给出多个权限方式，其间用逗号隔开。例如：
chmod g+r，o+r example  % 使同组和其他用户对文件example 有读权限。
chmod g+x topus_version.txt
chmod -R g+x datebase/

#查看常用命令：
ls /usr/bin/
info
#创建深目录，存在就不创建不影响文件内容
mkdir -p test/test1/test2/test3/test4
ls -R test/

[root@www ~]# cp [-adfilprsu] 杢源文件(source) 目标文件(destination) 
[root@www ~]# cp [options] source1 source2 source3 .... directory 
选项不参数： 
-a  ：相弼亍 -pdr 癿意忠，至亍 pdr 请参考下列说明；(常用) 
-d  ：若杢源文件为链接文件癿属性(link file)，则复制链接文件属性而非档案本
身； 
-f  ：为强制(force)癿意忠，若目标档案已经存在丏无法开启，则移除后再尝试一
次； 
-i  ：若目标文件(destination)已经存在时，在覆盖时会先询问劢作癿迚行(常用)
-l  ：迚行硬式连结(hard link)癿连结档建立，而非复制档案本身； 
-p  ：连同档案癿属性一起复制过去，而非使用默讣属性(备份常用)； 
-r  ：递弻持续复制，用亍目弽癿复制行为；(常用) 
-s  ：复制成为符号链接文件 (symbolic link)，亦卲『忚捷方式』档案； 
-u  ：若 destination 比 source 旧才更新 destination ！ 


groupadd test 创建test用户组
useradd user1 创建user1用户
passwd user1 设置user1的密码
useradd user2 创建user2用户
passwd user2 设置user2的密码
gpasswd -a user1 test 把user1用户添加到test用户组
gpasswd -a user2 test 同上 

#用户管理相关命令
useradd        添加用户
adduser        添加用户
userdel         删除用户
passwd         为用户设置密码
usermod       修改用户命令，可以通过usermod 来修改登录名、用户的家目录等等

 

#用户组管理相关命令
groupadd     添加用户组
groupdel      删除用户组
groupmod    修改用户组信息
groups         显示用户所属的用户组
newgrp        切换到相应用用户组

}


可用于管道操作的命令{
command1 | command2 | command3
注：管道命令必须能够接受来自前一个命令的数据成为standard input继续处理。
 
cut 将一段信息的某一段切出来，处理的信息是以行为单位。
cut -d '分割字符' -f fields
cut -c 字符范围
参数：
-d : 后面接分隔符，与-f一起使用；
-f : 依据-d的分隔符将一段信息切割成为数段，用-f取出第几段的意思；
-c : 以字符(characters)的单位取出固定字符区间；
echo $PATH | cut -d ':' -f 3-5
//将path的值按照':'进行分割，后取出第3到5个值
export | cut -c 12-
//对export的输出进行切分，每行输出从第12个字符往后的内容
 
grep 分析一行信息，如果有匹配的，就将该行拿出来。
grep [-acinv] [--color=auto] '查找字符串' filename
参数：
-a : 将binary文件以text文件的方式查找数据；
-c : 计算找到'查找字符串'的次数；
-i : 忽略大小写的不同；
-n : 带行号；
-v : 反向选择，显示没有'查找字符串'的行；
--color=auto : 可以将找到查找的关键字部分加上颜色显示
export | grep -in --color=auto 'bin'
//列出export输出中带有bin的行，并给bin加上颜色，不区分大小写，带有行号。
 
sort 可以依据不同的数据类型进行排序。
sort [-fbMnrtuk] [file or stdin]
参数：
-f : 忽略大小写
-b : 忽略最前面的空格符
-M : 以月份的名字来排序，如 JAN, DEC等
-n : 使用“数字”进行排序（默认是以文字类型来排序的）
-r : 反向排序
-u : uniq，相同的数据，仅出现一行代表
-t : 分隔符，默认是［Tab]来分割
-k : 用哪个filed来进行排序，与-t相关
cat /etc/passwd | sort -t ':' -k 3 -n
//根据 passwd中每行，按':'分隔符进行分隔后，按照第3个字段使用纯数字的方式进行排序。
 
uniq 重复的行只显示一个
uniq [-ic]
参数：
-i : 忽略大小写
-c : 进行计数
last | cut -d ' ' -f1 | sort | uniq -c
//列出登录者名字，并进行排序，进行统一处理，并计数。
 
wc 输出信息的整体数据
wc [-lwm]
参数：
-l : 仅列出行
-w : 仅列出多少字(英文单字)
-m : 多少字符
cat /etc/man.config | wc
//输出三个数字，分表代表行，字数，字符数
 
tee 双重定向，存到文件／设备的同时，输出到屏幕以便继续处理。
tee [-a] file
参数：
[-a] : 以累加(append)的方式，输出到file中。
ls -l / | tee -a file.list | more
//把文件目录输出到file.list中，同时用more将其输出到屏幕。
 
tr 删除一段信息中的文字，或者进行文字信息的转换。
tr [-ds] XXX ...
参数：
-d : 删除信息中XXX这个字符串
-s : 替换掉重复的字符
last | tr '[a-z]' '[A-Z]'
//将last输出的信息中所有的小写字母变成大写字母
 
col 对特殊字符进行处理
col [-xb]
参数：
-x : 将tab键转换成对等的空格键
-b : 在文字内有反斜杠(/)时，仅保留反斜杠最后接的那个字符
cat /etc/man.config | col -x | cat -A | more
//将/etc/man.config内容中的[tab]转成空白，并输出。
 
join 将两个文件当中有相同数据的那一行加在一起。
join [-ti12] file1 file2
参数：
-t : join默认以空格符分隔数据，并且对比“第一个字段”的数据；如果两个文件相同，则将两条数据连成一行，且第一个字段放在第一个。
-i : 忽略大小写
-1 : (数字1)，代表第一个文件要用哪个字段进行比较
-2 : 代表第二个文件要用哪个字段进行比较
join -t ':' -1 4 /etc/passwd -2 3 /etc/group
//用分隔符':'进行分隔，第一个文件用第4个字段，第二个文件用第3个字段，进行分析。
 
paste 将两个文件贴在一起，中间以[tab]键隔开。
paste [-d] file1 file2
参数：
-d : 后面可以接分隔符，默认是以[tab]进行分隔
- : 如果file部分写成-, 表示来自standard input的数据的意思
cat /etc/group|paste /etc/passwd /etc/shadow - |head -n 3
//先将/etc/group读出，然后与/etc/passwd和/etc/shadow合并的内容粘贴在一起，且仅取出前三行。

expand 将[tab]按键转成空格键
expand [-t] file
参数：
-t : 后面可以接数字，代表一个tab用几个空格表示
 
xargs 读入stdin的数据，并且以空格符或断行符进行分辨，将stdin的数据分隔为arguments。
xargs [-0epn] command
参数：
-0 : 如果输入的stdin含有特殊字符，如,\,空格键等，这个参数可以将它还原成一般字符。
-e : 是EOF(end of file)的意思，后面可以接一个字符串，当xargs分析到这个字符串时，就停止继续工作。
-p : 在执行每个命令的参数时，都会询问用户的意见
-n : 后面接次数
cut -d ':' -f1 /etc/passwd | xargs -p -e'lp' finger
//分析到lp这个字符串时，后面的其它stdin的内容就被xargs舍弃掉了。
举个例子
如果你想统计一个文件夹下java代码的文件数量
find [folderPath] -name "*.java" | wc -l
那如果我想查询所有java代码的行数呢？
可以用xargs，因为wc -l filename可以查询单个文件的行数
find [folerPath] -name "*.java" | xargs wc -l
如果要去掉空行
find [folderPath] -name "*.java" |xargs cat| grep -v ^$|wc -l
}

suse双机建立互信{

cd /root/.ssh/
ssh-keygen -b 1024 -t rsa
cat id_rsa.pub >>authorized_keys
scp /root/.ssh/id_rsa.pub 10.175.102.221:/root/.ssh/authorized_keys
}

#求平均
echo `cat result_iot.info |grep 'Requests per second'|awk -F':' '{print $2}'|awk -F' ' '{print $1}'|awk '{sum+=$1} END {print "Average = ", sum/NR}'`

查看Linux有多少个用户
vim /etc/passwd
文件里每行的格式为 用户名：密码占位符x：用户ID：组ID
首先root是根用户
用户ID >=500 为普通用户，500以上的,就是后面建的用户了.其它则为系统的用户.
或者用cat /etc/passwd |cut -f 1 -d :

ps -ef|grep "sshd"|grep -v "`who|grep "10.177.218.150"|awk '{print $2}'`"|grep pts|awk '{print $2}'|xargs kill -9
spawn|expect{
exp_continue可以继续执行下面的匹配
send：用于向进程发送字符串
expect：从进程接收字符串
spawn：启动新的进程
interact：允许用户交互

设置超时时间为 60 秒
set timeout 60 

send_user  "Now you can do some operation on this terminal\n"

#!/usr/bin/expect

set ip [lindex $argv 0]
set user [lindex $argv 1]
set pass [lindex $argv 2]
set cmd [lindex $argv 3]
set timeout 60
spawn ssh "$user@$ip"	#启动进程
expect {				#匹配开始
    "(yes/no)?" {
            send "yes\r"
            expect "Password:"
            send "$pass\r"
            exp_continue #匹配继续
        }
    "Password" {
            send "$pass\r"
            exp_continue
        }
}
send "cd /opt/topus\n"  #自动发送命令
send "touch 11.log\n"	#发送命令
#send "exit\n"			#发送退出


send "su - topus\n"
send "cd /opt/topus/haproxy_southlb/sbin/\n"
send "a=`ps -ef |grep haproxy_southlb |grep -v 'grep haproxy_southlb'|awk -F' '  '{print $2}'`"
send "./haproxy -f /opt/topus/haproxy_southlb/conf/south_lb.cfg -p /opt/topus/haproxy_southlb/haproxy_southlb.pid -st $a"

interact  				#用户在登陆后可以交互
}

crontab格式说明{

格式为：分 时 日 月 周 命令

第1列表示分钟0～59 每分钟用*或者 */1表示
第2列表示小时0～23（0表示0点）
第3列表示日期1～31
第4列表示月份1～12
第5列标识号星期0～6（0表示星期天）

第6列表示要执行的命令

每一列配置支持通配，包括:

"*" 表示每一

"/数字" 表示每几 如"*/3"表示每3（分钟、小时、日期、月份、星期等）

"-"表示从什么时候到什么时候

","表示取值列表如1,3,4 表示指定的第1、3、4（分钟、小时、日期、月份、星期）

除了这些，还有如下关键字的特殊表示：

@yearly 等同 0 0 1 1 * 
@monthly 等同 0 0 1 * *
@daily 等同 0 0 * * * 
@hourly 等同 0 * * * * 
@reboot 等同 Run at startup.
}

export{

export PATH=$PATH:/home/zhaodw
胜于修改环境变量，但只在本次登录中有效
 注意：（与shell变量相结合）
1 =前PATH变量不加$符号
2 再增加的路径用：追加

功能说明：设置或显示环境变量。

语　　法：export [-fnp][变量名称]=[变量设置值]

补充说明：在shell中执行程序时，shell会提供一组环境变量。export可新增，修改或删除环境变量，供后续执行的程序使用。export的效力仅及于该此登陆操作。

参　　数：
 　-f 　代表[变量名称]中为函数名称。
 　-n 　删除指定的变量。变量实际上并未删除，只是不会输出到后续指令的执行环境中。
 　-p 　列出所有的shell赋予程序的环境变量

}

#段落注释
:<<!

!

#样例收集
{
1.#文件的读写替换
while read line
do
    cname=`echo $line | awk -F '=' '{print $1}'`
    
    if [ "$cname" == "install_dir" ];then
        cvalue=`echo $line | awk -F '=' '{print $2}'` >> $LOG_FILE 2>&1
        if [ -z "$cvalue" ];then
            echo -e [`date +%Y-%m-%d' '%T`] " [`whoami`] [SYSTEM] [UPGRADE] [ERROR] install_dir not set"   >> $LOG_FILE 2>&1
            echo -e "$FTAG"
            exit $RESULT_FAILURE
        fi
        if [ "$TOPUS_DIR" == "$cvalue" ];then
            echo -e [`date +%Y-%m-%d' '%T`] " [`whoami`] [SYSTEM] [UPGRADE] [ERROR] new release can not install to dir $TOPUS_DIR,old release version already installed"   >> $LOG_FILE 2>&1
            echo -e "$FTAG"
            exit $RESULT_FAILURE
        fi  
    fi
    if [ -n "$cname" -a "$cname" != "install_dir" ];then
        newLine=`echo $line|sed "s#=.*#=${!cname}#g"` >> $LOG_FILE 2>&1
        sed -i "s#$line#$newLine#g" $ROOTPATH/configure/config.ini >> $LOG_FILE 2>&1
    fi
done < $ROOTPATH/configure/config.ini
echo -e "$STAG"
}



#数学计算
{
#expr
{

通常用expr来做运算，比如expr 2 + 3,注意，跟在expr 命令后面的每个操作符和数字均要有空格，如果是乘号*，则前面要加转义符。
例：$ expr 2 + 3
$ expr 2 \* 3           #乘号要带转义符
$ expr \( 6 + 3 \) / 2     #运算优先级要加()引起，同时要加转义符
但expr通常对整数进行操作，如果是其它浮点数或者字符操作则会报错误。
同样，expr的计算结果也为整数，因此
$ expr 7 / 2 结果为3 ， 此方法用于取整操作
$ expr 9 % 2 结果为1 ，此方法用于取余操作，常用于判断奇偶数
实际应用场景中最常见的莫过于用expr做计算器了，例：
#!/bin/bash
num=1
while [ $num -lt 10 ]
do
    echo "do some thing with "$num
    num=`expr $num + 1`
done
}

#使用let 
{var=1 
let "var+=1" 
echo $var 
输出结果为2，这次没有悲剧 
注意： 
a)经我测试let几乎支持所有的运算符，在网上看到一篇文章说“let不支持++、--和逗号、(、)”,但经我测试自加、自减、以及括号的优先级都得到了很好的支持 
b)方幂运算应使用“**” 
c)参数在表达式中直接访问，不必加$ 
d)一般情况下算数表达式可以不加双引号，但是若表达式中有bash中的关键字则需加上 
e)let后的表达式只能进行整数运算 
}

2)使用(()) 
var=1 
((var+=1)) 
echo $var 
输出结果为2 
注意： 
(())的使用方法与let完全相同 

3)使用$[] 
var=1 
var=$[$var+1] 
echo $var 
输出结果位2 
注意： 
a)$[]将中括号内的表达式作为数学运算先计算结果再输出 
b)对$[]中的变量进行访问时前面需要加$ 
c)$[]支持的运算符与let相同，但也只支持整数运算 

4)使用expr 
var=1 
var=`expr $var + 1` 
echo $var 
输出结果为2 
注意： 
a)expr后的表达式个符号间需用空格隔开 
b)expr支持的操作符有： |、&、<、<=、=、!=、>=、>、+、-、*、/、% 
c)expr支持的操作符中所在使用时需用\进行转义的有：|、&、<、<=、>=、>、* 
e)expr同样只支持整数运算 

5)使用bc(可以进行浮点数计算) 
var=1 
var=`echo "$var+1"|bc` 
echo $var 
输出结果为2 
介绍： 
bc是linux下的一个简单计算器，支持浮点数计算，在命令行下输入bc即进入计算器程序，而我们想在程序中直接进行浮点数计算时，利用一个简单的管道即可解决问题。 
注意： 
1)经我测试bc支持除位操作运算符之外的所有运算符。 
2)bc中要使用scale进行精度设置 
3)浮点数计算实例 
var=3.14 
var=`echo "scale=2;$var*3"|bc` 
echo $var 
输出结果为9.42 

6)使用awk(可已进行浮点数计算) 
var=1 
var=`echo "$var 1"|awk '{printf("%g",$1*$2)}'` 
echo $var 
输出结果为2 
介绍： 
awk是一种文本处理工具，同时也是一种程序设计语言，作为一种程序设计语言，awk支持多种运算，而我们可以利用awk来进行浮点数计算，和上面bc一样，通过一个简单的管道，我们便可在程序中直接调用awk进行浮点数计算。 
注意： 
1)awk支持除微操作运算符之外的所有运算符 
2)awk内置有log、sqr、cos、sin等等函数 
3)浮点数计算实例 
var=3.14 
var=`echo "$var 2"|awk '{printf("%g",sin($1/$2))}'` 
echo $var 
输出结果为1 






 

}

快速排序{

#!/bin/bash

quicksort()
{
A=$1
B=$2
Ls=($3)
echo "${Ls[*]}" >./lgj.log
a=$A
b=$B
k=${Ls[$a]}
if [ $A -lt $B ];then

	while [ $a -lt $b ]
	do
		 t1=${Ls[$a]}
		 while [ $a -lt $B ] && [ $t1 -lt $k ]
		 do
			a=$((a+1))
		 done
		 t2=${Ls[$b]}
		 while [ $A -lt $b ] && [ $t2 -gt $k ]
		 do
			b=$((b-1))
		 done
		 
		 echo $a
		 echo $b
		 
		 if [ $a -le $b ]
		 then
		 t=${Ls[$a]}
		 Ls[$a]=${Ls[$b]}
		 Ls[$b]=$t
		 a=`expr $a + 1`
		 b=`expr $b - 1`
		 fi
		 echo "${Ls[*]}" >./lgj.log
	
	done
	echo ${Ls[*]}
	if [ $a -lt $B ];then
		read -a Ls < ./lgj.log
		quicksort $a $B "${Ls[*]}"
	fi
	if [ $b -gt $A ];then
		read -a Ls < ./lgj.log
		quicksort $A $b "${Ls[*]}"
	fi  
fi
}

aa=(1 2 35 23 43 42 65 423 75 12)
quicksort 0 9 "${aa[*]}"
echo ${aa[*]}




}

change()
{
m=($1)   #数组的传入方式
m[0]=1
echo ${m[*]}   #数组的打印全部元素的方式
}

a=(2 2 2 2)
change "${a[*]}"  #数组的传入方式
m[0]=1
echo ${a[*]}


linux-HKADVg:/opt # sh ww.sh 
1 2 2 2
2 2 2 2

##可以看出 shell里不是传引用的。


#改变方法 >>>
 
change()
{
m=($1)
m[0]=1
echo ${m[*]} 
echo "${m[*]}" >./lgj.log  #打印到文件中去模拟指针
}

a=(2 2 3 6)
#export "${a[*]}"
change "${a[*]}"
#a=cat ./lgj.log 
read -a a < ./lgj.log   #从文件中读取数组
echo ${a[*]}
echo ${a[2]}




