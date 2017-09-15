httpie的使用
{
#很好的类似curl的测试工具
安装
pip install httpie

1.模拟提交表单
http -f POST http://127.0.0.1:8080/login username=nate

2.显示详细的请求
http -v http://127.0.0.1:8080/login

3.只显示Header
http -h http://127.0.0.1:8080/login

4.只显示Body
http -b http://127.0.0.1:8080/login

5.下载文件
http -d http://127.0.0.1:8080/login

6.请求删除的方法
http DELETE http://127.0.0.1:8080/login

7.传递JSON数据请求(默认就是JSON数据请求)
http PUT http://127.0.0.1:8080/login name=nate password=nate_password
如果JSON数据存在不是字符串则用:=分隔，例如
http PUT http://127.0.0.1:8080/login name=nate password=nate_password age:=28 a:=true streets:='["a", "b"]'

8.模拟Form的Post请求, Content-Type: application/x-www-form-urlencoded; charset=utf-8
http --form POST http://127.0.0.1:8080/login name='nate'
模拟Form的上传, Content-Type: multipart/form-data
http -f POST example.com/jobs name='John Smith' file@~/test.pdf

9.修改请求头, 使用:分隔
http http://127.0.0.1:8080/login User-Agent:Yhz/1.0 'Cookie:a=b;b=c' Referer:http://http://127.0.0.1:8080/login/

10.认证
http -a username:password http://127.0.0.1:8080/login
http --auth-type=digest -a username:password http://127.0.0.1:8080/login

11.使用http代理
http --proxy=http:http://192.168.1.100:8060 http://127.0.0.1:8080/login
http --proxy=http:http://user:pass@192.168.1.100:8060 http://127.0.0.1:8080/login
}
