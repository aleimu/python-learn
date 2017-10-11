#http://www.cnblogs.com/kelvinkuo/archive/2013/05/15/3079936.html
#http://www.cnblogs.com/rainfd/p/howto_webservers.html	#如何在Web开发中使用Python
#http://www.cnblogs.com/pied/p/4597740.html
#http://www.cnblogs.com/hzhtracy/p/4365938.html	#网关协议学习:CGI、FastCGI、WSGI、uWSGI
#http://www.cnblogs.com/laozhbook/p/python_pep_333.html	#python wsgi PEP333 中文翻译

#CGI,SWGI区别
cgi通过环境变量，输入输出流完成web server与处理逻辑的http协议的交互，由于是基于流方式，所以各种语言都可以写cgi程序。CGI是比较原始的开发动态网站的方式:Web服务器可以解析这个HTTP请求，然后把这个请求的各种参数写进进程的环境变量，比如REQUEST_METHOD，PATH_INFO之类的(参考:http://www.cnblogs.com/liuzhang/p/3929198.html)。之后呢，服务器会调用相应的程序来处理这个请求，这个程序也就是我们所要写的CGI程序了。它会负责生成动态内容，然后返回给服务器，再由服务器转交给客户端。服务器和CGI程序之间通信，一般是通过进程的环境变量和管道。
CGI是一种通信协议，它把用户传递过来的数据转变成一个k－v的字典。这个字典中不光有用户的数据，还有HTTP协议的参数。它做的就是把数据，组织成一个固定结构形式的数据。方便任何符合CGI协议的程序都可以调用！但是CGI不是负责通信（传输数据）的，通信的话是通过socket，也就是server，例如上面例子中，是通过Apache进行通信。之后调用CGI脚本，把数据转变成符合CGI协议的数据结构，用于后面的数据处理！

wsgi是将web server参数python化，封装为request对象传递给apllication命名的func对象并接受其传出的response参数，由于其处理了参数封装和结果解析，才有python世界web框架的泛滥，在python下，写web框架就像喝水一样简单，当选择Web开发框架的时候，最好选择一个支持WSGI的。WSGI最大的优点就是统一了应用程序的接口。如果你的程序兼容WSGI，这就意味这你外层使用的框架支持WSGI，你的程序可以部署到任意支持WSGI的Web服务器。你不再需要关心用户使用的是mod_python，FastCGI，还是mod_wsgi，因为使用了WSGI的程序可以在任何的网关接口上运行。
以python自带的wsgiref为例，wsgiref是按照wsgi规范实现的一个简单wsgi server。它的代码也不复杂。
1.服务器创建socket，监听端口，等待客户端连接。
2.当有请求来时，服务器解析客户端信息放到环境变量environ中，并调用绑定的handler来处理请求。
3.handler解析这个http请求，将请求信息例如method，path等放到environ中。
4.wsgi handler再将一些服务器端信息也放到environ中，最后服务器信息，客户端信息，本次请求信息全部都保存到了环境变量environ中。
5.wsgi handler 调用注册的wsgi app，并将environ和回调函数传给wsgi app
6.wsgi app 将reponse header/status/body 回传给wsgi handler
7.最终handler还是通过socket将response信息塞回给客户端。

wsgi不负责服务器的实现，也不负责网页应用的实现，它只是一个两边接口方式的约定。所以，它并不是另一个 WEB 应用框架。通常意义上的 WEB 应用框架，也只相当于 WSGI 网页应用端的一种实现。
这样做的好处是？PEP 0333 中的解释是，为了实现一个类似于 Java Servelet 的 API，使得遵循该接口的应用拥有更广泛的适用性。是的，有了该接口，你就不用去考虑，服务器对 Python 的支持到底是如何实现——无论是“ 直接用 Python 实现的服务器”，还是“服务器嵌入 Python”，或者是 “ 通过网关接口(CGI, Fastcgi...)”——应用程序都有很好的适用性。就像是今天故事的开始，我们遇到了云平台，它提供了对 WSGI 接口的支持，那么，只要应用是基于 WSGI 的，那么应用就可以直接跑起来。
WSGI就是Python的CGI包装，相对于Fastcgi是PHP的CGI包装。
WSGI将 web 组件分为三类： web服务器，web中间件,web应用程序， wsgi基本处理模式为 ： WSGI Server -> (WSGI Middleware)* -> WSGI Application 。
一个WSGI真正强大的特性是中间件(Middleware)。中间件是一个可以在软件上添加各种功能的层。现在可以使用的的中间件相当地多。例如，你不再需要为自己的程序单独编写会话管理(HTTP 是一个无状态协议，当一个用户关联数个HTTP请求时，你的应用程序必须使用会话创建和管理状态)。压缩也可以用类似的方式完成，已有中间件利用gzip压缩你的HTML从而节省服务器宽带。通过中间件，验证的问题也可以轻松解决。

总结
从CGI、FastCGI、WSGI、uWSGI，它们的主要功能就是CGI的作用—HTTP服务器与你的或其它机器上的程序进行“交谈”的一种工具，其程序须运行在网络服务器上，是从远到近逐步完善的过程。CGI是基础，FastCGI和SCGI尝试以另一种方式解决CGI的性能问题。取代了在Web服务器中嵌入解释器的做法，它们使用了一个长时间运行的后台进程。这还是一个能让服务器与后台进程“说话”的模块。fastCGI解决了其性能低下、占用系统和内存高的缺点。WSGI相比较于fastCGI，解决了Web应用框架的选择将限制可用的Web服务器的选择这一问题，只要遵照WSGI协议,WSGI应用(Application)都可以在任何服务器(Server)上运行。基于Python的Web项目部署时用wsgi和fastcgi很麻烦，所以像php-cgi一样监听同一端口，进行统一管理和负载平衡的uWSG便应运而生，它相较于fastCGI和WSGI的性能要高，占用的内存要少很多。

CGI
一种标准方法，用来将web server产生网页内容的工作转交给其他可执行程序(CGI scripts)，一般这些可执行程序都是用脚本语言实现的（比如perl）
Browser --http request--> WebServer --cgi call--> CGI script
Browser <--http response-- WebServer <--any content with http response header-- CGI script
CGI典型的使用方式是通过URL请求解析出要调用的CGI程序和参数，示例如下，调用cgi-bin目录下的printenv.pl，参数1是value，参数2是with%20percent%20encoding
http://example.com/cgi-bin/printenv.pl/foo/bar?var1=value1&var2=with%20percent%20encoding

WSGI
#官方文档 PEP 333
WSGI是python web server gateway interface的缩写，设计它的目的是为了消除不同web server和web application/frameworks之间的兼容性问题
简单形式：
browser----server/gateway----application/framework
工作方式：server调用app提供的一个callable object，它可以是“a function,class,or instance with a __call__ method”
callable object 接受2个参数 (environ, start_response)，返回一个response结果
例如

server:
{
import os, sys

def run_with_cgi(application):

    environ = dict(os.environ.items())
    environ['wsgi.input']        = sys.stdin
    environ['wsgi.errors']       = sys.stderr
    environ['wsgi.version']      = (1, 0)
    environ['wsgi.multithread']  = False
    environ['wsgi.multiprocess'] = True
    environ['wsgi.run_once']     = True

    if environ.get('HTTPS', 'off') in ('on', '1'):
        environ['wsgi.url_scheme'] = 'https'
    else:
        environ['wsgi.url_scheme'] = 'http'

    headers_set = []
    headers_sent = []

    def write(data):
        if not headers_set:
             raise AssertionError("write() before start_response()")

        elif not headers_sent:
             # Before the first output, send the stored headers
             status, response_headers = headers_sent[:] = headers_set
             sys.stdout.write('Status: %s\r\n' % status)
             for header in response_headers:
                 sys.stdout.write('%s: %s\r\n' % header)
             sys.stdout.write('\r\n')

        sys.stdout.write(data)
        sys.stdout.flush()

    def start_response(status, response_headers, exc_info=None):
        if exc_info:
            try:
                if headers_sent:
                    # Re-raise original exception if headers sent
                    raise exc_info[0], exc_info[1], exc_info[2]
            finally:
                exc_info = None     # avoid dangling circular ref
        elif headers_set:
            raise AssertionError("Headers already set!")

        headers_set[:] = [status, response_headers]
        return write

    result = application(environ, start_response)
    try:
        for data in result:
            if data:    # don't send headers until body appears
                write(data)
        if not headers_sent:
            write('')   # send headers now if body was empty
    finally:
        if hasattr(result, 'close'):
            result.close()
}
application: 
{
def simple_app(environ, start_response):
　　"""Simplest possible application object"""
　　status = '200 OK'
　　response_headers = [('Content-type', 'text/plain')]
　　start_response(status, response_headers)
　　return ['Hello world!\n']
 }
 
middleware中间件：
{
class Router():
    
    def __init__(self):
        self.path_info = {}

    def route(self, environ, start_response):
        application = self.path_info[environ['PATH_INFO']]
        return application(environ, start_response)

    def __call__(self, path):
        def wrapper(application):
            self.path_info[path] = application
        return wrapper

""" The above is the middleware"""

router = Router()

@router('/world')
def world(environ, start_response):
    status = '200 OK'
    output = 'World!'start_response(status, response_headers)  
    return [output] 

@router('/hello') 
def hello(environ, start_response):
    status = '200 OK'
    output = 'Hello'
    response_headers = [('Content-type', 'text/plain'), ('Content-Length', str(len(output)))]
    start_response(status, response_headers)  
    return [output]
}
注意到单个对象可以作为请求应用程序的服务器存在，也可以作为被服务器调用的应用程序存在。这样的中间件可以执行这样一些功能:
1、重写前面提到的 environ 之后，可以根据目标URL将请求传递到不同的应用程序对象
2、允许多个应用程序和框架在同一个进程中运行
3、通过在网络传递请求和响应，实现负载均衡和远程处理
4、对内容进行后加工，比如附加xsl样式表

带中间层形式：
browser----server----middleware----application

中间层的作用
Routing a request to different application objects based on the target URL, after rewriting the environ accordingly.（url路由）
Allowing multiple applications or frameworks to run side-by-side in the same process(多应用单进程，大概是为了节省进程启动开销)
Load balancing and remote processing, by forwarding requests and responses over a network(负载均衡)
Perform content postprocessing, such as applying XSL stylesheets(后处理，application响应后的数据处理)


