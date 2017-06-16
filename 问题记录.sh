
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
