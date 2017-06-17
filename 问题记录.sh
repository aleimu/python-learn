
Python 3.6.0 (v3.6.0:41df79263a11, Dec 23 2016, 07:18:10) [MSC v.1900 32 bit (Intel)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>>
>>> import socketserver
>>> from werkzeug.serving import run_simple
Traceback (most recent call last):
  File "C:\Python36-32\lib\site-packages\werkzeug\serving.py", line 65, in <module>
    from SocketServer import ThreadingMixIn, ForkingMixIn
ModuleNotFoundError: No module named 'SocketServer'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "C:\Python36-32\lib\site-packages\werkzeug\serving.py", line 68, in <module>
    from socketserver import ThreadingMixIn, ForkingMixIn
ImportError: cannot import name 'ForkingMixIn'
>>>
#http://blog.csdn.net/blueheart20/article/details/60954379
解决方法
定位Python的安装目录，查找socketserver.py, 在python_home\Lib下找到了对应的socketserver.py文件，故这个包其实应该是按照好了，所以应该转换方向重新分析问题，于是把焦点重新定位于flask本身，也许是缺少其他类似包吧：
故经过一番查找，找到类似的问题解决方案：
>>pip install -U werkzeug
>> pip install gunicorn




sublime text3中文文件名显示为框框，怎么解决?

点击Preferences选项——settings
{
    "font_size": 20,
    "ignored_packages":
    [
        "Vintage"
    ]
}

修改为：

{
    "font_size": 22,
    "dpi_scale":1.0    //这里是关键中的关键。
}




https_proxy=CHINA\name:lgj@1234@openproxy.qq.com:8080
git config --global http.proxy http://name:lgj@1234@openproxy.qq.com:8080
git config --global http.proxy http://name:lgj@1234@openproxy.qq.com:8080
git config --global https.proxy https://name:lgj@1234@openproxy.qq.com:8080
git config --global http.proxy http://name:lgj@1234@openproxy.qq.com:8080

git clone https://github.com/lgjabc/python_learn.git

在Git命令行中输入以下命令：
http代理
git config --global http.proxy http://china\\name:lgj\@1234@openproxy.qq.com:8080
https代理
git config --global https.proxy https://china\\name:lgj\@1234@openproxy.qq.com:8080

然后就可以执行git 了（下面举例用的是https.proxy的代理）

git clone https://github.com/dotcloud/docker.git

若报这个错
可以先执行如下命令
git config --global  http.sslVerify false
再执行clone 命令就可以了

查看代理
git config --get --global http.proxy

如果某一天你不喜欢她了，需要删除代理设置，那么可以使用：
git config --system (或 --global 或 --local) --unset http.proxy

使用 git config --global -e 打开命令行，出现vi界面，使用vi方式直接修改保存。



用万能的互联网，找到密码中特殊字符的Unicode，例如"@"的Unicode是40。那么设置时应该输入：
export http_proxy=http://username:p%40ssword@proxy.url:8080

git config --global http.proxy http://china\\name:lgj%401234@openproxy.qq.com:8080
git config --global https.proxy http://china\\name:lgj%401234@openproxy.qq.com:8080

set http_proxy=http://openproxy.qq.com:8080
set http_proxy_user=name
set http_proxy_pass= lgj@1234
set https_proxy=https://openproxy.qq.com:8080
set https_proxy_user=name
set https_proxy_pass= lgj@1234

还是没解决问题啊
