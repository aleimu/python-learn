go syscall

http://www.cnblogs.com/keanuyaoo/p/3357816.html
https://github.com/golang/go/wiki/WindowsDLLs
http://www.cnblogs.com/zl1991/p/6543634.html

#go语言的os.exec包介绍
http://www.cnblogs.com/zhangym/p/6257415.html 
http://3ms.huawei.com/hi/blog/1067341_2454203.html?for_statistic_from=interfix_blog_rec_interested
#exec包执行外部命令，它将os.StartProcess进行包装使得它更容易映射到stdin和stdout，并且利用pipe连接i/o．

封装的顺序:
os.StartProcess

syscall.StartProcess

CreateProcess

syscall.Syscall12

文件系统和golang api索引很好用，结合起来可以定位到实现。


python _winapi、ctypes
