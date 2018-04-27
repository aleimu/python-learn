aiohttp基本用法{
aiohttp 异步IO库

示例1： 基本asyncio+aiohttp用法，类似urllib库的API接口
import asyncio
import aiohttp

async def print_page(url):
    response = await aiohttp.request("GET", url)　　# 类似于python的urllib库
    body = await response.read() 　　# 也可以response.text()
    print(body)

loop = asyncio.get_event_loop()
loop.run_until_complete(print_page("http://www.baidu.com"))

 
示例2：使用session获取数据，类似requests库的API接口
这里要引入一个类，aiohttp.ClientSession. 首先要建立一个session对象，然后用该session对象去打开网页。session可以进行多项操作，比如post, get, put, head等等，如下面所示:
import asyncio
import aiohttp

async def print_page(url):
    async with aiohttp.ClientSession() as session:　　# async with用法， ClientSession（）需要使用async with上下文管理器来关闭
        async with session.get(url) as resp:　　# post请求session.post(url, data=b'data')
            print(resp.status)
            print(await resp.text())　　# resp.text(), 可以在括号中指定解码方式，编码方式; 或者也可以选择不编码，适合读取图像等，是无法编码的await resp.read()

loop = asyncio.get_event_loop()
loop.run_until_complete(print_page("http://www.baidu.com"))

 

示例3： aiohttp配置超时时间
需要加一个with aiohttp.Timeout(x)
async def print_page(url):
    with aiohttp.Timeout(1):　　# 配置http连接超时时间
        async with aiohttp.ClientSession() as session:
            async with session.get(url) as resp:
                print(resp.status)
                print(await resp.read())


示例4：aiohttp自定义headers
这个比较简单，将headers放于session.get/post的选项中即可。注意headers数据要是dict格式
url = 'https://api.github.com/some/endpoint'
headers = {'content-type': 'application/json'}
await session.get(url, headers=headers)
 
示例5：使用代理
要实现这个功能，需要在生产session对象的过程中做一些修改
conn = aiohttp.ProxyConnector(proxy="http://some.proxy.com")
session = aiohttp.ClientSession(connector=conn)
async with session.get('http://python.org') as resp:
    print(resp.status)
这边没有写成with….. as….形式，但是原理是一样的，也可以很容易的改写成之前的格式 
如果代理需要认证，则需要再加一个proxy_auth选项。
conn = aiohttp.ProxyConnector(
    proxy="http://some.proxy.com",
    proxy_auth=aiohttp.BasicAuth('user', 'pass')
)
session = aiohttp.ClientSession(connector=conn)
async with session.get('http://python.org') as r:
    assert r.status == 200


示例6：自定义cookie
url = 'http://httpbin.org/cookies'
async with ClientSession({'cookies_are': 'working'}) as session:
    async with session.get(url) as resp:
        assert await resp.json() == {"cookies":{"cookies_are": "working"}}


示例7：http服务器
import asyncio
from aiohttp import web

async def index(request):
    await asyncio.sleep(0.5)
    return web.Response(body=b'<h1>Index</h1>')

async def hello(request):
    await asyncio.sleep(0.5)
    text = '<h1>hello, %s!</h1>' % request.match_info['name']
    return web.Response(body=text.encode('utf-8'))

async def init(loop):
    app = web.Application(loop=loop)
    app.router.add_route('GET', '/', index)
    app.router.add_route('GET', '/hello/{name}', hello)
    srv = await loop.create_server(app.make_handler(), '127.0.0.1', 8000)
    print('Server started at http://127.0.0.1:8000...')
    return srv

loop = asyncio.get_event_loop()
loop.run_until_complete(init(loop))
loop.run_forever()
 }
