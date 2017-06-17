
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



在学习flask框架过程中遇到很多坑
BUG1
ExtDeprecationWarning: Importing flask.ext.sqlalchemy is deprecated, use flask_sqlalchemy instead.
.format(x=modname), ExtDeprecationWarning
解决办法:
此错误信息出现在对 flask 进行拓展时导入包的方式上
错误:from flask.ext.script import Manager
正确:from flask_script import Manager

BUG2
TypeError: 'bool' object is not callable
解决办法：
flask_login 0.3之后将authenticated从函数更改为属性
把g.user.is_authenticated() 修改为g.user.is_authenticated

BUG3
第三方模块登录(OPenid)登录出错
Login requested for OpenID="https://me.yahoo.com", remember_me=False
解决办法暂时没找到 改用本地登录
原因:获得用户时出错

BUG4
**IndentationError: unexpected indent **
原因：可能是tab和空格没对齐的问题，需要检查下tab和空格

BUG5
TypeError: Unicode-objects must be encoded before hashing
原因：未进行编码

BUG6
jinja2.exceptions.UndefinedError: 'dict object' has no attribute 'author'
原因：user中post传参错误

BUG7
sqlalchemy.exc.IntegrityError
原因：数据库中的用户名不唯一
思考：为防止数据重复出现，在两个或者多线程/进程进行并行存取数据库时，怎么解决？

BUG8
sqlalchemy.exc.OperationalError: (sqlite3.OperationalError) no such table
原因：没有创建相应的数据库
