《python 3.4 内置库功能分类与总结》
#文章来自于网络  为方便个人而收藏。

Python3.4内置类型{
1. 真值测试 True False
2. bool操作符 and  or  not
3. 比较符 &lt;,&lt;= ,&gt;,&gt;=,==,!-,is,is not
4. 数值类型  int  float  complex
5. 迭代器类型
6. list类型 list  tuple range
7. 文本序列类型 str
8. 二进制类型 bytes  bytearray  memoryview
9. Set类型 set  frozenset
10. Map类型 dict
11. 上下文管理类型  enter  exit
12. 其他的内置类型  modules  class  class Instaces  functions  methods  Code Objects  Type Objects  The Null Object  The Ellipsis Object  The NotImplemented Object  Boolean Values  Internal Objects  Special Attributes  
}

Python3.4内置异常{
1. BaseException  Exception  ArithmeticError  BufferError  LookupError
AssertionError  AttributeError  EOFError  FloatingPointError  GeneratorExit  ImportError  IndexError  KeyError  KeyboardInterrupt  MemoryError  NameError  NotImplementedError  OSError  OverflowError  ReferenceError  RuntimeError  StopIteration  SyntaxError  IndentationError  TabError  SystemError  SystemExit  TypeError  UnboundLocalError  UnicodeError  UnicodeEncodeError  UnicodeDecodeError  UnicodeTranslateError  ValueError  ZeroDivisionError  EnvironmentError  IOError  VMSError  WindowsError  

2. 系统异常：
BlockingIOError  ChildProcessError  ConnectionError  BrokenPipeError  ConnectionAbortedError  ConnectionRefusedError  ConnectionResetError  FileExistsError  FileNotFoundError  InterruptedError  IsADirectoryError  NotADirectoryError  PermissionError  ProcessLookupError  TimeoutError

3. 系统警告
Warning, UserWarning, DeprecationWarning, PendingDeprecationWarning, SyntaxWarning, RuntimeWarning, FutureWarning, ImportWarning, UnicodeWarning, BytesWarning, ResourceWarning
}

异常继承结构图{
BaseException
+-- SystemExit
+-- KeyboardInterrupt
+-- GeneratorExit
+-- Exception
      +-- StopIteration
      +-- ArithmeticError
      |    +-- FloatingPointError
      |    +-- OverflowError
      |    +-- ZeroDivisionError
      +-- AssertionError
      +-- AttributeError
      +-- BufferError
      +-- EOFError
      +-- ImportError
      +-- LookupError
      |    +-- IndexError
      |    +-- KeyError
      +-- MemoryError
      +-- NameError
      |    +-- UnboundLocalError
      +-- OSError
      |    +-- BlockingIOError
      |    +-- ChildProcessError
      |    +-- ConnectionError
      |    |    +-- BrokenPipeError
      |    |    +-- ConnectionAbortedError
      |    |    +-- ConnectionRefusedError
      |    |    +-- ConnectionResetError
      |    +-- FileExistsError
      |    +-- FileNotFoundError
      |    +-- InterruptedError
      |    +-- IsADirectoryError
      |    +-- NotADirectoryError
      |    +-- PermissionError
      |    +-- ProcessLookupError
      |    +-- TimeoutError
      +-- ReferenceError
      +-- RuntimeError
      |    +-- NotImplementedError
      +-- SyntaxError
      |    +-- IndentationError
      |         +-- TabError
      +-- SystemError
      +-- TypeError
      +-- ValueError
      |    +-- UnicodeError
      |         +-- UnicodeDecodeError
      |         +-- UnicodeEncodeError
      |         +-- UnicodeTranslateError
      +-- Warning
           +-- DeprecationWarning
           +-- PendingDeprecationWarning
           +-- RuntimeWarning
           +-- SyntaxWarning
           +-- UserWarning
           +-- FutureWarning
           +-- ImportWarning
           +-- UnicodeWarning
           +-- BytesWarning
           +-- ResourceWarning
}

Python3.4字符串处理接口{
1. string通用字符串处理模块
2. re正则表达式模块
3. difflib这个模块提供的类和方法用来进行差异化比较  它能够生成文本或者html格式的差异化比较结果
4. textwrap模块会根据屏幕的宽度而适当地去调整文本段落
5. unicodedata编码数据
6. stringprep提供用于IP协议的Unicode字符串
7. readline读取文件行的接口
8. rlcompleter编辑模块或函数
}

Python3.4二进制数据类型{
1. struct  解析二进制以及打包二进制的工具类
2. codes  编码处理的有关类
}

Python3.4数据类型{
1. datetime处理日期的类
2. calendar通用的日历函数
3. collections容器类型
4. collections.abc容器的抽象基类
5. heapq 模块实现了一个适用于Python列表的最小堆排序算法。
6. bisect 二分查找实现和快速插入有序序列的工具
7. array 集合数组
8. weakref 弱引用
9. types 检索对象类型
10. copy 浅深拷贝
11. pprint 更美观的输出
12. reprlib 模块提供了一个面向内容很多或者深度很广的嵌套容器的自定义版本
13. enmu 枚举类型
}

Python3.4数值和数学计算模块{
1. numbers抽象的一个算术基类
2. math一个数字计算的工具类
3. cmatch一个为复数类型提供计算的工具类
4. decimal十进制点和浮点计算
5. fractions有理数计算
6. random一个生成伪随机数的类
7. statistics 一个数学统计函数
}
Python3.4函数设计模块{
1. itertools 迭代器(Iterator)是一个可以对集合进行迭代访问的对象。通过这种方式不需要将集合全部载入内存中  也正因如此  这种集合元素几乎可以是无限的
2. functools  用于高阶函数：指那些作用于函数或者返回其他函数的函数。通常情况下  只要是可以被当做函数调用的对象就是这个模块的目标
3. operator  标准的运算符操作类
}

Python3.4文件和目录访问模块{
1. pathlib面向对象的文件系统路径库
2. os.path标准的路径名称操作
3. fileinput从多个输入流里面遍历行
4. stat返回文件的信息
5. filecmp比较文件序列
6. tempfile生成临时文件和目录
7. glob一个Unix风格的文件名匹配
8. fnmatch一个Unix风格的文件名匹配
9. linecache 随机访问文本行
10. shutil 高级文件操作
11. macpath 基于Mac系统的路径操作
}
Python3.4数据持久{
1. pickle一个基于python对象序列化
2. copyreg注册pickle支持函数
3. shelve一个Python的对象持久
4. marshal一个Python内部对象的持久
5. dbm 一个Unix持久支持的接口
6. sqlite3 一个支持SQLite数据库的接口
}
Python3.4数据压缩和归档{
1. zlib支持gzip兼容的压缩
2. gzip支持gzip文件
3. bz2支持bzip2压缩
4. lzma支持lzma运算
5. zipfile处理zip归档
6. tarfile读写tar归档文件
}
Python3.4文件格式{
1. csv支持CSV文件的读写
2. configparse配置文件解析器
3. netrc文件校验信息
4. xdrlib编码和解码xdr数据
5. plistlib生成和解析Mac下的plist文件
}

Python3.4加密服务{
1. hashlib安全的加密服务
2. hmac基于散列的信息验证
}

Python3.4操作系统接口{
1. os通用的操作系统接口
2. io核心的操作IO的接口
3. time时间访问和转换接口
4. argparse解析命令行参数和选项
5. optparse解析命令行选择
6. getopt类C风格的解析行选项
7. logging日志记录
8. logging.config日志配置
9. loggin.handlers日志处理
10. getpass轻巧的密码输入
11. curses处理终端单位字符显示
12. curse.textpad处理文本输入
13. curses处理ascii字符
14. curses.panel一个增强的curses
15. platform访问底层平台的数据
16. errno标准的系统错误码符号
17. ctypes外置的python库函数
}

Python3.4并行模块{
1. threading线程并行基础类
2. multiprocessing多线程基础类
3. concurrent packge线程操作工具包
4. concurrent.futures启动线程任务类
5. subprocess管理子进程
6. sched时间调度
7. queue同步队列
8. dummy_threading线程的另一个替代模块
9. _thread操作线程的API
10. _dummy_thread线程替换模块
}

Python3.4进程通信和网络{
1. socket底层的网络通信接口
2. ssl TLS/SSL包装过的socket接口
3. select阻塞IO
4. selectors高性能的多路复用IO
5. asyncio异步IO  时间循环  协同通信
6. asyncore异步socket的处理器
7. asynchat异步的socket命令和回复
8. singal异步事件处理程序
9. mmap内存映射文件
}

Python3.4互联网数据处理{
1. email电子邮件
2. json json编码和解码
3. mailcap mailcap文件处理
4. mailbox操作各种格式的邮箱
5. mimetypes文件映射mimetypes
6. base64 base16. base32. 64. 85数据编码
7. binhex编码和解码binhex文件
8. binascill在二进制和ascii之间转换
9. quopri编码和解码mime数据
10. uu编码和解码一种文件
}
Python3.4结构化数据处理{
1. html支持超文本标记语言
2. html.parse简单的html和xhtml解析
3. html.entities定义的html实体
4. xml  xml处理模块
5. xml.etree.ElementTree xml的节点树的API
6. xml.dom文档对象api
7. xml.dom.minidom最低dom实现
8. xml.dom.pulldom支持建设部分dom书
9. xml.sax支持sax解析
10. xml.sax.handler基本的sax处理器
11. xml.sax.saxutils通用的xml类
12. xml.sax.xmlreaer xml的解析接口
13.xml.parsers.expat最快的xml解析
}
Python3.4互联网通讯协议支持{
1. webbrowser方便的浏览器容器
2. cgi公共网关接口支持
3. cgitb管理cgi脚本
4. wsgiref  WSGI实体和引用实现
5. urllib URL通信模块
6. urllib.request request请求库
7. urllib.response  response响应库
8. urllib.parse  url解析组件
9. urllib.error 异常模块
10. urllib.robotparser 解析robost文件
11. http HTTP模块
12. ftplib FTP协议客户端
13. http.client http协议客户端
14. poplib POP3协议客户端
15. imaplib IMAP4协议客户端
16. nntplib NNTP协议客户端
17. smtplib SMTP协议
18. smtpd SMTP服务端
19. telnetlib  远程登录客户端
20. uuid uuid对象
21. socketserver socket的服务端框架
22. http.server HTTP 服务端
23. http.cookies http的cookie对象管理
24. http.cookiesjar  cookie的http客户端
25. xmlrpc  远程访问xml客户端
26. xmlrpc.client 远程访问客户端
27. xmlrpc.server 远程访问服务端
28. ipaddress IPV4/IPV6操作库
}
Python3.4多媒体服务{
1. audioop 操作音频数据
2. aifc 读写AIFF和AIFC文件
3. sunau 读取AU文件
4. wave 读取wav文件
5. chunk 读取iff文件
6. colorsys 系统颜色转换
7. imghdr 确定图片类型
8. sndhdr 确定声音类型
9. ossaudiodev 访问OSS音频服务
}
Python3.4国际化{
1. gettext多种国际化服务
2. locale国际化本地服务
}

Python3.4程序框架{
1. trutle图形处理
2. cmd支持面向行的命令
3. shlex简单词法解析

}
Python3.4图形用户界面{
1. tkinter TCL/TK的python接口
2. tkinter.ttk tk主题组件
3. tkinter.scrolledtext滚动组件
4. tkinter.tix TK的扩展组件
5. IDLE其他的组件
6. 其他的python组件pygobject  pyqt  pyside  wxpython
}
Python3.4开发工具{
1. pydoc文档生成器
2. doctest测试交互式python的例子
3. unittest单元测试框架
4. unittest.mock模拟对象库
5. 2to3 自动化python2转python3
6. test回归测试包
7. test.support 公用的python测试组件
}

Python3.4调试和性能分析{
1. bdb 调试框架
2. faulthandler python的trace分析
3. pdb python debugger
4. timeit 测试执行代码的时间
5. tarce python的语句跟踪
6. tarcemalloc 跟踪内存分配
}
Python3.4软件打包和分发{
1. distutils 构建和安装python模块
2. ensurepip 引导pip安装程序
3. venv创建虚拟环境
}

Python3.4运行时服务{
1. sys 系统特定的参数和功能
2. sysconfig访问python的配置信息
3. builtins内置对象
4. _main_顶级的脚本环境
5. warnings 警告控制
6. contextlib with语句的上下文
7. abc 抽象的基类
8. atexit 退出句柄
9. traceback打印或跟踪一个堆栈
10. _future_以后的函数定义
11. gc 垃圾回收接口
12. inspect 检查活跃对象
13. site具体的配置钩子
14. fpetl 浮点异常控制
}
Python3.4自定义解析器{
1. code 基本的解释器接口类
2. codeop 编译python代码
}
Python3.4导入模块{
1. imp访问导入内部
2. zipimport 从zip包里导入模块
3. pkgutil扩展包工具
4. modulefinder 通过一个脚本找模块
5. runpy  本地执行python模块
6. importlib import的实现类
}

Python3.4语言服务{
1. parser 访问python解析树
2. ast 抽象的语法树
3. symtable访问编译器的语法块
4. symbol常量使用python的解析树
5. token常量使用python的解析树
6. keyword 测试python的关键字
7. tokenize  python的源代码分词器
8. tabnanny 检测python的缩进
9. pyclbr python的类浏览器支持
10. py_compileall 编译python源文件
11. compileall python的字节库编译
12. dis 反编译python源代码
13. pickletools 开发工具包
}
Python3.4其他服务{
1. formatter 通用的输出格式
}
Python3.4 Windows 特定服务{
1. msilib 读写微软安装文件
2. msvcrt vc++程序操做
3. winreg 访问windows注册表
4. winsound 访问windows音乐播放器接口
}
Python3.4 Unix 特定服务{
1. posix常见的posix系统调用
2. pwd 数据库密码
3. spwd  隐式数据库密码
4. grp 组数据库
5. crypt 检验unix密码的函数
6. termios posix风格控制
7. tty 终端控制函数
8. pty 伪终端模拟工具
9. fcntl 系统调用
10. pipes shell的管道接口
11. resource 资源使用信息
12. nis Sun的nis接口
13. syslog
}

Python3.4 Unix 待发展模块{
1. platform specific module 基于特定平台的模块
}
