# 将py2转成py3 的自带库 2to3.py
#http://www.cnblogs.com/Blaxon/articles/4483023.html  ---->py2与py3的语法不同点
#http://www.cnblogs.com/todayisafineday/p/5656429.html -----> 2to3 库的使用方法 基本如下:
windows系统下的使用方法：
　　（1）将python安装包下的Tools / Scripts下面的2to3.py拷贝到需要转换文件目录中。
　　（2）dos切换到需要转换的文件目录下，运行命令2to3.py test.py
　　　　可打印test.py，在python2与python3的差异。
　　（3）dos切换到需要转换的文件目录下，运行命令2to3.py - w test.py
　　　　将test.py备份为test.py.bak文件
　　　　test.py将相应的格式及相应包改写为python3
恭喜你，python2到python3的格式修改成功。
同时，迎接你的可能还是不少异常。例如下面的描述：
现象1：
TypeError: cannot use a string pattern on a bytes - like object
原因：
　　正则表达式是Unicode字符串，但是urlopen()的 read()是ASCII / bytes 字符串。
　　The fix here is to compile a bytes object instead of a text string.
　　即改为
　　　　REGIX = compile(b'#([\d,]+)')
