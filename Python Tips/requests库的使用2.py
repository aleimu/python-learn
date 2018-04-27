#http://www.cnblogs.com/linxiyue/p/3980003.html
#主要摘自上文
Python Requests库：HTTP for Humans
Python标准库中用来处理HTTP的模块是urllib2，不过其中的API太零碎了，requests是更简单更人性化的第三方库。
用pip下载：
pip install requests
或者git：
git clone git://github.com/kennethreitz/requests.git
发送请求：
#GET方法
>>> import requests
>>> r = requests.get('https://api.github.com/events')
#POST方法：
>>> r = requests.post("http://httpbin.org/post")
也可以使用其它方法：
>>> r = requests.put("http://httpbin.org/put")
>>> r = requests.delete("http://httpbin.org/delete")
>>> r = requests.head("http://httpbin.org/get")
>>> r = requests.options("http://httpbin.org/get")
也可以将请求方法放在参数中：
>>> import requests
>>> req = requests.request('GET', 'http://httpbin.org/get')
传递参数或上传文件：
1.如果要将参数放在url中传递，使用params参数，可以是字典或者字符串：
>>> payload = {'key1': 'value1', 'key2': 'value2'}
>>> r = requests.get("http://httpbin.org/get", params=payload)
>>> r.url
u'http://httpbin.org/get?key2=value2&key1=value1'
2.如果要将参数放在request body中传递，使用data参数，可以是字典，字符串或者是类文件对象。
使用字典时将发送form-encoded data：
>>> payload = {'key1': 'value1', 'key2': 'value2'}
>>> r = requests.post("http://httpbin.org/post", data=payload)
>>> print(r.text)
{
  ...
  "form": {
    "key2": "value2",
    "key1": "value1"
  },
  ...
}
使用字符串时将直接发送数据：
>>> import json
>>> url = 'https://api.github.com/some/endpoint'
>>> payload = {'some': 'data'}
>>> r = requests.post(url, data=json.dumps(payload))
流上传：
with open('massive-body', 'rb') as f:
    requests.post('http://some.url/streamed', data=f)
Chunk-Encoded上传：

def gen():
    yield 'hi'
    yield 'there'
 
requests.post('http://some.url/chunked', data=gen())
3.如果要上传文件，可以使用file参数发送Multipart-encoded数据，file参数是{ 'name': file-like-objects}格式的字典 (or {'name':('filename', fileobj)}) ：
>>> url = 'http://httpbin.org/post'
>>> files = {'file': open('report.xls', 'rb')}
>>> r = requests.post(url, files=files)
>>> r.text
{
  ...
  "files": {
    "file": "<censored...binary...data>"
  },
  ...
}
也可以明确设置filename, content_type and headers：
>>> url = 'http://httpbin.org/post'
>>> files = {'file': ('report.xls', open('report.xls', 'rb'), 'application/vnd.ms-excel', {'Expires': '0'})}
>>> r = requests.post(url, files=files)
>>> print r.text
{
  "args": {},
  "data": "",
  "files": {
    "file": "1\t2\r\n"
  },
  "form": {},
  "headers": {
    "Content-Type": "multipart/form-data; boundary=e0f9ff1303b841498ae53a903f27e565",
    "Host": "httpbin.org",
    "User-Agent": "python-requests/2.2.1 CPython/2.7.3 Windows/7",
  },
  "url": "http://httpbin.org/post"
}
一次性上传多个文件：

>>> url = 'http://httpbin.org/post'
>>> multiple_files = [('images', ('foo.png', open('foo.png', 'rb'), 'image/png')),
                      ('images', ('bar.png', open('bar.png', 'rb'), 'image/png'))]
>>> r = requests.post(url, files=multiple_files)
>>> r.text
{
  ...
  'files': {'images': 'data:image/png;base64,iVBORw ....'}
  'Content-Type': 'multipart/form-data; boundary=3131623adb2043caaeb5538cc7aa0b3a',
  ...
}
设置Headers
>>> import json
>>> url = 'https://api.github.com/some/endpoint'
>>> payload = {'some': 'data'}
>>> headers = {'content-type': 'application/json'}
>>> r = requests.post(url, data=json.dumps(payload), headers=headers)
Response对象：

 获取unicode字符串，会自动根据响应头部的字符编码(r.encoding)进行解码，当然也可以自己设定r.encoding：

>>> r = requests.get('https://github.com/timeline.json')
>>> r.text
u'{"message":"Hello there, wayfaring stranger...
获取bytes字符串，会自动解码gzip和deflate数据：

>>> r.content
'{"message":"Hello there, wayfaring stranger. ..
要存储web图片，可以：

>>> from PIL import Image
>>> from StringIO import StringIO
>>> i = Image.open(StringIO(r.content))
可以解码json对象：
>>> r.json()
{u'documentation_url': u'https://developer...
返回raw response，需要在requests请求中将stream设为True：
>>> r = requests.get('https://github.com/timeline.json', stream=True)
>>> r.raw
<requests.packages.urllib3.response.HTTPResponse object at 0x101194810>
>>> r.raw.read(10)
'\x1f\x8b\x08\x00\x00\x00\x00\x00\x00\x03'
如果不想一次性处理全部的数据，可以：
tarball_url = 'https://github.com/kennethreitz/requests/tarball/master'
r = requests.get(tarball_url, stream=True)
if int(r.headers['content-length']) < TOO_LONG:
  content = r.content
  ...
也可以迭代的处理数据：
with open(filename, 'wb') as fd:
    for chunk in r.iter_content(chunk_size):
        fd.write(chunk)
或者：

import json
import requests
r = requests.get('http://httpbin.org/stream/20', stream=True)
for line in r.iter_lines():
    # filter out keep-alive new lines
    if line:
        print(json.loads(line))
获取响应代码：

>>> r = requests.get('http://httpbin.org/get')
>>> r.status_code
200
获取响应headers：
>>> r.headers
{
    'content-encoding': 'gzip',
    'transfer-encoding': 'chunked',
    'connection': 'close',
    'server': 'nginx/1.0.4',
    'x-runtime': '148ms',
    'etag': '"e1ca502697e5c9317743dc078f67693f"',
    'content-type': 'application/json'
}
获取发送的headers

>>> r.request.headers
{'Accept-Encoding': 'identity, deflate, compress, gzip',
'Accept': '*/*', 'User-Agent': 'python-requests/1.2.0'}
Cookie

获取cookie，返回CookieJar对象：

>>> url = 'http://www.baidu.com'
>>> r = requests.get(url)
>>> r.cookies
将CookieJar转为字典：

>>> requests.utils.dict_from_cookiejar(r.cookies)
{'BAIDUID': '84722199DF8EDC372D549EC56CA1A0E2:FG=1', 'BD_HOME': '0', 'BDSVRTM': '0'}
将字典转为CookieJar：

requests.utils.cookiejar_from_dict(cookie_dict, cookiejar=None, overwrite=True)
上传自己设置的cookie，使用cookies参数，可以是字典或者CookieJar对象：

>>> url = 'http://httpbin.org/cookies'
>>> cookies = dict(cookies_are='working')
>>> r = requests.get(url, cookies=cookies)
>>> r.text
'{"cookies": {"cookies_are": "working"}}'
如果需要在会话中保留cookie，需要用到后面要说的Session。

Redirection and History

可以用history属性来追踪redirection
>>> r = requests.get('http://github.com')
>>> r.url
'https://github.com/'
>>> r.status_code
200
>>> r.history
[<Response [301]>]
Session

要在会话中保留状态，可以使用request.Session()。

Session可以使用get，post等方法，Session对象在请求时允许你保留一定的参数和自动设置cookie
s = requests.Session()
s.get('http://httpbin.org/cookies/set/sessioncookie/123456789')   #cookie保留在s中
r = s.get("http://httpbin.org/cookies") #再次访问时会保留cookie
print(r.text)
# '{"cookies": {"sessioncookie": "123456789"}}'
也可以自己设置headers，cookies：
s = requests.Session()
s.auth = ('user', 'pass')
s.headers.update({'x-test': 'true'})
s.get('http://httpbin.org/headers', headers={'x-test2': 'true'})    #  'x-test' and 'x-test2' 都会被发送
预设Request

可以在发送request前做些额外的设定

from requests import Request, Session
 
s = Session()
req = Request('GET', url,
    data=data,
    headers=header
)
prepped = req.prepare()
 
# do something with prepped.body
# do something with prepped.headers
 
resp = s.send(prepped,
    stream=stream,
    verify=verify,
    proxies=proxies,
    cert=cert,
    timeout=timeout
)
 
print(resp.status_code)　
验证

#Basic Authentication

>>> from requests.auth import HTTPBasicAuth
>>> requests.get('https://api.github.com/user', auth=HTTPBasicAuth('user', 'pass'))
<Response [200]>
因为HTTP Basic Auth很常用，所以也可以直接验证：

>>> requests.get('https://api.github.com/user', auth=('user', 'pass'))
<Response [200]>
Digest Authentication

>>> from requests.auth import HTTPDigestAuth
>>> url = 'http://httpbin.org/digest-auth/auth/user/pass'
>>> requests.get(url, auth=HTTPDigestAuth('user', 'pass'))
<Response [200]>
OAuth 1 Authentication
>>> import requests
>>> from requests_oauthlib import OAuth1
>>> url = 'https://api.twitter.com/1.1/account/verify_credentials.json'
>>> auth = OAuth1('YOUR_APP_KEY', 'YOUR_APP_SECRET',
                  'USER_OAUTH_TOKEN', 'USER_OAUTH_TOKEN_SECRET')
>>> requests.get(url, auth=auth)
<Response [200]>
也可以使用自己写的验证类。比如某个web服务接受将X-Pizza报头设置成密码的验证，可以这样写验证类：

from requests.auth import AuthBase
class PizzaAuth(AuthBase):
    """Attaches HTTP Pizza Authentication to the given Request object."""
    def __init__(self, username):
        # setup any auth-related data here
        self.username = username
    def __call__(self, r):
        # modify and return the request
        r.headers['X-Pizza'] = self.username
        return r
使用：
>>> requests.get('http://pizzabin.org/admin', auth=PizzaAuth('kenneth'))
<Response [200]>
SSL证书验证

检查主机的ssl证书：
>>> requests.get('https://kennethreitz.com', verify=True)
    raise ConnectionError(e)
ConnectionError: HTTPSConnectionPool(host='kennethreitz.com', port=443): Max retries exceeded with url: / (Caused by <class 'socket.error'>: [Errno 10061] )
github是有的：
>>> requests.get('https://github.com', verify=True)
<Response [200]>
如果你设置验证设置为False，也可以忽略验证SSL证书。

可以读取验证文件：
>>> requests.get('https://kennethreitz.com', cert=('/path/server.crt', '/path/key'))
代理

使用代理：

import requests
proxies = {
  "http": "http://10.10.1.10:3128",
  "https": "http://10.10.1.10:1080",
}
requests.get("http://example.org", proxies=proxies)
可以设置环境变量：
$ export HTTP_PROXY="http://10.10.1.10:3128"
$ export HTTPS_PROXY="http://10.10.1.10:1080"
$ python
>>> import requests
>>> requests.get("http://example.org")
如果代理需要验证：
proxies = {
    "http": "http://user:pass@10.10.1.10:3128/",
}
