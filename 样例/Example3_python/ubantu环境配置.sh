查看Linux版本系统信息方法汇总{
1、# uname －a   （Linux查看版本当前操作系统内核信息）
	Linux localhost.localdomain 2.4.20-8 #1 Thu Mar 13 17:54:28 EST 2003 i686 athlon i386 GNU/Linux
2、# cat /proc/version （Linux查看当前操作系统版本信息）
	Linux version 2.4.20-8 (bhcompile@porky.devel.redhat.com)
	(gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Thu Mar 13 17:54:28 EST 2003
3、# cat /etc/issue  或cat /etc/redhat-release（Linux查看版本当前操作系统发行版信息）
　　Red Hat Linux release 9 (Shrike)
4、# cat /proc/cpuinfo （Linux查看cpu相关信息，包括型号、主频、内核信息等）
5、# getconf LONG_BIT  （Linux查看版本说明当前CPU运行在32bit模式下， 但不代表CPU不支持64bit）
6、# lsb_release -a
}

环境配置{
vi /etc/hosts
10.93.135.120 rnd-mirrors.yourmirrors.com
vi  /root/.pip/pip.conf
[global]
trusted-host=rnd-mirrors.yourmirrors.com
index-url=http://rnd-mirrors.yourmirrors.com/pypi/simple


Ubuntu 的软件源配置文件是 /etc/apt/sources.list,下面是14版本的配置
cat /etc/apt/sources.list
deb http://rnd-mirrors.yourmirrors.com/ubuntu/ trusty main multiverse restricted universe
deb http://rnd-mirrors.yourmirrors.com/ubuntu/ trusty-backports main multiverse restricted universe
deb http://rnd-mirrors.yourmirrors.com/ubuntu/ trusty-proposed main multiverse restricted universe
deb http://rnd-mirrors.yourmirrors.com/ubuntu/ trusty-security main multiverse restricted universe
deb http://rnd-mirrors.yourmirrors.com/ubuntu/ trusty-updates main multiverse restricted universe
deb-src http://rnd-mirrors.yourmirrors.com/ubuntu/ trusty main multiverse restricted universe
deb-src http://rnd-mirrors.yourmirrors.com/ubuntu/ trusty-backports main multiverse restricted universe
deb-src http://rnd-mirrors.yourmirrors.com/ubuntu/ trusty-proposed main multiverse restricted universe
deb-src http://rnd-mirrors.yourmirrors.com/ubuntu/ trusty-security main multiverse restricted universe
deb-src http://rnd-mirrors.yourmirrors.com/ubuntu/ trusty-updates main multiverse restricted universe

alias python='python3.4'
apt-get install python3-dev
pip3.4 install line_profiler
pip3.4 install memory_profiler
kernprof -l -v test2.py 
pip install psutil
python -m memory_profiler  test2.py
}
