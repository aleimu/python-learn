#https://github.com/requests/requests/tree/master/docs
#HTTP请求类型
#get类型
r = requests.get('https://github.com/timeline.json')
#post类型
r = requests.post("http://m.ctrip.com/post")
#put类型
r = requests.put("http://m.ctrip.com/put")
#delete类型
r = requests.delete("http://m.ctrip.com/delete")
#head类型
r = requests.head("http://m.ctrip.com/head")
#options类型
r = requests.options("http://m.ctrip.com/get")

#获取响应内容
print( r.content) #以字节的方式去显示，中文显示为字符
print( r.text) #以文本的方式去显示

#URL传递参数
payload = {'keyword': '日本', 'salecityid': '2'}
r = requests.get("http://m.ctrip.com/webapp/tourvisa/visa_list", params=payload)
print( r.url) #示例为http://m.ctrip.com/webapp/tourvisa/visa_list?salecityid=2&keyword=日本

#获取/修改网页编码
r = requests.get('https://github.com/timeline.json')
print( r.encoding)
r.encoding = 'utf-8'

#json处理
r = requests.get('https://github.com/timeline.json')
print( r.json()) #需要先import json

#定制请求头
url = 'http://m.ctrip.com'
headers = {'User-Agent' : 'Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 4 Build/JOP40D) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Mobile Safari/535.19'}
r = requests.post(url, headers=headers)
print( r.request.headers)

#复杂post请求
url = 'http://m.ctrip.com'
payload = {'some': 'data'}
r = requests.post(url, data=json.dumps(payload)) #如果传递的payload是string而不是dict，需要先调用dumps方法格式化一下

#post多部分编码文件
url = 'http://m.ctrip.com'
files = {'file': open('report.xls', 'rb')}
r = requests.post(url, files=files)

#响应状态码
r = requests.get('http://m.ctrip.com')
print( r.status_code)

#响应头
r = requests.get('http://m.ctrip.com')
print( r.headers)
print( r.headers['Content-Type'])
print( r.headers.get('content-type')) #访问响应头部分内容的两种方式

#Cookies
url = 'http://example.com/some/cookie/setting/url'
r = requests.get(url)
r.cookies['example_cookie_name']    #读取cookies

url = 'http://m.ctrip.com/cookies'
cookies = dict(cookies_are='working')
r = requests.get(url, cookies=cookies) #发送cookies

#设置超时时间
r = requests.get('http://m.ctrip.com', timeout=0.001)

#设置访问代理
proxies = {
           "http": "http://10.10.10.10:8888",
           "https": "http://10.10.10.100:4444",
          }
r = requests.get('http://m.ctrip.com', proxies=proxies)

#传递文件
url = 'http://httpbin.org/post'
files = {'file': open('report.xls', 'rb')}
r = requests.post(url, files=files)
#配置files，filename, content_type and headers
files = {'file': ('report.xls', open('report.xls', 'rb'), 'application/vnd.ms-excel', {'Expires': '0'})}
files = {'file': ('report.csv', 'some,data,to,send\nanother,row,to,send\n')}


#SSL证书验证
Requests可以为HTTPS请求验证SSL证书，就像web浏览器一样。要想检查某个主机的SSL证书，你可以使用 verify 参数:

>>> requests.get('https://kennethreitz.com', verify=True)
requests.exceptions.SSLError: hostname 'kennethreitz.com' doesn't match either of '*.herokuapp.com', 'herokuapp.com''
在该域名上我没有设置SSL，所以失败了。但Github设置了SSL:
>>> requests.get('https://github.com', verify=True)
<Response [200]>
对于私有证书，你也可以传递一个CA_BUNDLE文件的路径给 verify 。你也可以设置REQUEST_CA_BUNDLE 环境变量。
>>> requests.get('https://github.com', verify='/path/to/certfile')
如果你将 verify 设置为False，Requests也能忽略对SSL证书的验证。
>>> requests.get('https://kennethreitz.com', verify=False)
<Response [200]>
默认情况下， verify 是设置为True的。选项 verify 仅应用于主机证书。
你也可以指定一个本地证书用作客户端证书，可以是单个文件（包含密钥和证书）或一个包含两个文件路径的元组:
>>> requests.get('https://kennethreitz.com', cert=('/path/server.crt', '/path/key'))
<Response [200]>

#证书的两种处理方式
import requests
#response = requests.get('https://www.12306.cn')
#print(response.status_code)
#以上会显示错误，因为需要证书验证

#解决证书问题，我们有两种方法

#方法一，我们可以通过设置verify=False来忽略证书验证
response = requests.get('https://www.12306.cn',verify=False)
print(response.status_code)
#以上解决了证书验证问题，但是仍然是有警告抛出：InsecureRequestWarning: Unverified HTTPS request is being made. Adding certificate verification is strongly advised.
#为了忽略警告，可以引入以下
#from requests.packages import urllib3
#urllib3.disable_warning()

#方法二，手动传入证书，如果有的话
response = requests.get('https://www.12306.cn',cert=('/path/server.vrt','/path/key'))



#http://www.cnblogs.com/shizhengwen/p/6837442.html

requests.request(method, url, **kwargs)
method：request的访问方式
url：服务器的地址
**kwargs:控制访问的参数，均为可选项　　　　　　　　　　
　　　　
　　 params: 字典或字节序列，作为参数增加到url中
 　　data：字典或者字节序列、文件对象，作为request的内容
　　 json：作为request的内容
　　 headers：字典，HTTP定制头
　　 cookies:字典或Cookie.Jar,  Request的cookies
　　 auth:元祖，支持HTTP的认证功能
　　 files：字典类型，传输文件
　　 timeout：设定超时时间，秒为单位
　　 proxies：字典类型，设定访问代理服务器，可以增加登录认证
　　 allow_redirects:    True/False，默认为True，重定向开关
　　 stream:    True/False，默认为True，获取立即下载
　　 verify:    True/False，默认为True，认证SSL证书开关
　　 cert: 本地SSL证书路径

#参数列表
def request(method, url, **kwargs):
    """Constructs and sends a :class:`Request <Request>`.

    :param method: method for the new :class:`Request` object.
    :param url: URL for the new :class:`Request` object.
    :param params: (optional) Dictionary or bytes to be sent in the query string for the :class:`Request`.
    :param data: (optional) Dictionary, bytes, or file-like object to send in the body of the :class:`Request`.
    :param json: (optional) json data to send in the body of the :class:`Request`.
    :param headers: (optional) Dictionary of HTTP Headers to send with the :class:`Request`.
    :param cookies: (optional) Dict or CookieJar object to send with the :class:`Request`.
    :param files: (optional) Dictionary of ``'name': file-like-objects`` (or ``{'name': file-tuple}``) for multipart encoding upload.
        ``file-tuple`` can be a 2-tuple ``('filename', fileobj)``, 3-tuple ``('filename', fileobj, 'content_type')``
        or a 4-tuple ``('filename', fileobj, 'content_type', custom_headers)``, where ``'content-type'`` is a string
        defining the content type of the given file and ``custom_headers`` a dict-like object containing additional headers
        to add for the file.
    :param auth: (optional) Auth tuple to enable Basic/Digest/Custom HTTP Auth.
    :param timeout: (optional) How long to wait for the server to send data
        before giving up, as a float, or a :ref:`(connect timeout, read
        timeout) <timeouts>` tuple.
    :type timeout: float or tuple
    :param allow_redirects: (optional) Boolean. Set to True if POST/PUT/DELETE redirect following is allowed.
    :type allow_redirects: bool
    :param proxies: (optional) Dictionary mapping protocol to the URL of the proxy.
    :param verify: (optional) whether the SSL cert will be verified. A CA_BUNDLE path can also be provided. Defaults to ``True``.
    :param stream: (optional) if ``False``, the response content will be immediately downloaded.
    :param cert: (optional) if String, path to ssl client cert file (.pem). If Tuple, ('cert', 'key') pair.
    :return: :class:`Response <Response>` object
    :rtype: requests.Response

    Usage::

      >>> import requests
      >>> req = requests.request('GET', 'http://httpbin.org/get')
      <Response [200]>
    """

#参数实例
def param_method_url():
    # requests.request(method='get', url='http://127.0.0.1:8000/test/')
    # requests.request(method='post', url='http://127.0.0.1:8000/test/')
    pass


def param_param():    #get请求传的参数，请求头里的参数
    # - 可以是字典
    # - 可以是字符串
    # - 可以是字节（ascii编码以内）

    # requests.request(method='get',
    # url='http://127.0.0.1:8000/test/',
    # params={'k1': 'v1', 'k2': '水电费'})

    # requests.request(method='get',
    # url='http://127.0.0.1:8000/test/',
    # params="k1=v1&k2=水电费&k3=v3&k3=vv3")

    # requests.request(method='get',
    # url='http://127.0.0.1:8000/test/',
    # params=bytes("k1=v1&k2=k2&k3=v3&k3=vv3", encoding='utf8'))

    # 错误
    # requests.request(method='get',
    # url='http://127.0.0.1:8000/test/',
    # params=bytes("k1=v1&k2=水电费&k3=v3&k3=vv3", encoding='utf8'))
    pass


def param_data():    #post请求传的参数,请求体里的参数
    # 可以是字典
    # 可以是字符串
    # 可以是字节
    # 可以是文件对象

    # requests.request(method='POST',
    # url='http://127.0.0.1:8000/test/',
    # data={'k1': 'v1', 'k2': '水电费'})

    # requests.request(method='POST',
    # url='http://127.0.0.1:8000/test/',
    # data="k1=v1; k2=v2; k3=v3; k3=v4"
    # )

    # requests.request(method='POST',
    # url='http://127.0.0.1:8000/test/',
    # data="k1=v1;k2=v2;k3=v3;k3=v4",
    # headers={'Content-Type': 'application/x-www-form-urlencoded'}
    # )

    # requests.request(method='POST',
    # url='http://127.0.0.1:8000/test/',
    # data=open('data_file.py', mode='r', encoding='utf-8'), # 文件内容是：k1=v1;k2=v2;k3=v3;k3=v4
    # headers={'Content-Type': 'application/x-www-form-urlencoded'}
    # )
    pass


#字典中嵌套字典时使用
def param_json():    #在请求体里传递的数据
    # 将json中对应的数据进行序列化成一个字符串，json.dumps(...)
    # 然后发送到服务器端的body中，并且Content-Type是 {'Content-Type': 'application/json'}
    requests.request(method='POST',
                     url='http://127.0.0.1:8000/test/',
                     json={'k1': 'v1', 'k2': '水电费'})


def param_headers():
    # 发送请求头到服务器端
    requests.request(method='POST',
                     url='http://127.0.0.1:8000/test/',
                     json={'k1': 'v1', 'k2': '水电费'},
                     headers={'Content-Type': 'application/x-www-form-urlencoded'，
                                    'User-Agent': "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36"
                                }
                     )


def param_cookies():    #用cookies做登陆
    # 发送Cookie到服务器端
    requests.request(method='POST',
                     url='http://127.0.0.1:8000/test/',
                     data={'k1': 'v1', 'k2': 'v2'},
                     cookies={'cook1': 'value1'},
                     )
    # 也可以使用CookieJar（字典形式就是在此基础上封装）
    from http.cookiejar import CookieJar
    from http.cookiejar import Cookie

    obj = CookieJar()
    obj.set_cookie(Cookie(version=0, name='c1', value='v1', port=None, domain='', path='/', secure=False, expires=None,
                          discard=True, comment=None, comment_url=None, rest={'HttpOnly': None}, rfc2109=False,
                          port_specified=False, domain_specified=False, domain_initial_dot=False, path_specified=False)
                   )
    requests.request(method='POST',
                     url='http://127.0.0.1:8000/test/',
                     data={'k1': 'v1', 'k2': 'v2'},
                     cookies=obj)


def param_files():
    # 发送文件
    # file_dict = {
    # 'f1': open('readme', 'rb')    #文件对象
    # }
    # requests.request(method='POST',
    # url='http://127.0.0.1:8000/test/',
    # files=file_dict)

    # 发送文件，定制文件名
    # file_dict = {
    # 'f1': ('test.txt', open('readme', 'rb'))    #文件名,文件对象
    # }
    # requests.request(method='POST',
    # url='http://127.0.0.1:8000/test/',
    # files=file_dict)

    # 发送文件，定制文件名
    # file_dict = {
    # 'f1': ('test.txt', "hahsfaksfa9kasdjflaksdjf")    #文件名,文件内容
    # }
    # requests.request(method='POST',
    # url='http://127.0.0.1:8000/test/',
    # files=file_dict)

    # 发送文件，定制文件名
    # file_dict = {
    #     'f1': ('test.txt', "hahsfaksfa9kasdjflaksdjf", 'application/text', {'k1': '0'})
    # }
    # requests.request(method='POST',
    #                  url='http://127.0.0.1:8000/test/',
    #                  files=file_dict)

    pass


#基本认知(headers中加入加密的用户名和密码)
def param_auth():    #把用户名密码放到请求头
    from requests.auth import HTTPBasicAuth, HTTPDigestAuth

    ret = requests.get('https://api.github.com/user', auth=HTTPBasicAuth('wupeiqi', 'sdfasdfasdf'))
    print(ret.text)

    # ret = requests.get('http://192.168.1.1',
    # auth=HTTPBasicAuth('admin', 'admin'))
    # ret.encoding = 'gbk'
    # print(ret.text)

    # ret = requests.get('http://httpbin.org/digest-
    # print(ret)
    #
    #def __call__(self, r):
    #    r.headers['Authorization'] = _basic_auth_str(self.username, self.password)
    #    return r


def param_timeout():    #请求和响应的超市时间
    # ret = requests.get('http://google.com/', timeout=1)
    # print(ret)

    # ret = requests.get('http://google.com/', timeout=(5, 1))
    # print(ret)
    pass


def param_allow_redirects():    #是否允许重定向,跳转时跟不跟踪
    ret = requests.get('http://127.0.0.1:8000/test/', allow_redirects=False)
    print(ret.text)


def param_proxies():    #代理ip
    # proxies = {
    # "http": "61.172.249.96:80",
    # "https": "http://61.185.219.126:3128",
    # }

    # proxies = {'http://10.20.1.128': 'http://10.10.1.10:5323'}

    # ret = requests.get("http://www.proxy360.cn/Proxy", proxies=proxies)
    # print(ret.headers)


    # from requests.auth import HTTPProxyAuth
    #
    # proxyDict = {
    # 'http': '77.75.105.165',
    # 'https': '77.75.105.165'
    # }
    # auth = HTTPProxyAuth('username', 'mypassword')
    #
    # r = requests.get("http://www.google.com", proxies=proxyDict, auth=auth)
    # print(r.text)

    pass


def param_stream():    #村长下大片,迭代的形式,看一点下一点
    ret = requests.get('http://127.0.0.1:8000/test/', stream=True)
    print(ret.content)
    ret.close()

    # from contextlib import closing
    # with closing(requests.get('http://httpbin.org/get', stream=True)) as r:
    # # 在此处理响应。
    # for i in r.iter_content():
    # print(i)


def requests_session():    #用于保存客户端历史访问信息
    import requests

    session = requests.Session()

    ### 1、首先登陆任何页面，获取cookie

    i1 = session.get(url="http://dig.chouti.com/help/service")

    ### 2、用户登陆，携带上一次的cookie，后台对cookie中的 gpsd 进行授权
    i2 = session.post(
        url="http://dig.chouti.com/login",
        data={
            'phone': "8615131255089",
            'password': "xxxxxx",
            'oneMonth': ""
        }
    )

    i3 = session.post(
        url="http://dig.chouti.com/link/vote?linksId=8589623",
    )
    print(i3.text)

