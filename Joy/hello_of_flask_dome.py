from flask import request
from flask import Flask
app = Flask(__name__)

# @app.route('/')
# def index():
#     return '<h1>Hello World!</h1>'
@app.route('/')
def index():
    user_agent = request.headers.get('User-Agent')
    return '<p>Your browser is %s</p>' % user_agent

#return 的第二个参数定义返回码,'/user/<int:name>' 可以限制name的类型，去掉int就不再限制,methods定义方法
@app.route('/user/<int:name>',methods=["GET"])
def user(name):
    return '<h1>Hello, %s!</h1>' % name,400

#使用request进行参数的传值, http://127.0.0.1:5000/query_page?pageid=1&num=2
@app.route("/query_page")
def query_page():
    pageid = request.args.get("pageid")
    num  = request.args.get("num")
    return "query page: {0} and {1}".format(pageid,num)

#返回 Response 对象
from flask import make_response
@app.route('/a')
def diy_response():
    response = make_response('<h1>This document carries a cookie!</h1>')
    response.set_cookie('answer', '42')
    return response

#重定向
from flask import redirect
@app.route('/b')
def diy_redirect():
    return redirect('http://www.example.com')

#反向生成url,接受函数名作为第一参数，以及一些关键字参数
from flask import   url_for
@app.route('/')
def indexPage():
    return 'Index Page'

@app.route("/query_user")
def query_user():
    id = request.args.get("id")
    return "query user: {0}".format(id)

with app.test_request_context():
    print (url_for('indexPage'))
    print (url_for('query_user',id=100))

# 　· 反向构建通常比硬编码更具备描述性。更重要的是，它允许你一次性修改 URL， 而不是到处找 URL 修改。
# 　· 构建 URL 能够显式地处理特殊字符和 Unicode 转义，因此你不必去处理这些。
# 　· 如果你的应用不在 URL 根目录下(比如，在 /myapplication 而不在 /)， url_for() 将会适当地替你处理好。

if __name__ == '__main__':
    app.run(debug=True, host='127.0.0.1', port=5000)   #指定了debug模式，外部可访问的服务器，端口
