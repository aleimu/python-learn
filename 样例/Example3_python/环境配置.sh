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
