# coding:utf-8
from __future__ import unicode_literals  # 中文字符传解决
from flask import Flask, render_template, url_for, redirect, session, make_response
import pdir

# 使用模板，遍历整个序列
# 在模板中可以直接调用列表和字典。{{变量}}，{% 控制语句 %}
app = Flask(__name__)
from flask import request

import os
app.secret_key = os.urandom(24)
print(app.secret_key)
# 设置一个密钥用于加密session


@app.route('/')
def index():
    user_agent = request.headers.get('User-Agent')
    print(pdir(request.cookies))
    print(dir(make_response))
    all_headers = str(request.headers.to_list())
    tips = "1.我就是想看看requset中有啥玩意！ 2.%s,%s 后面入参时要用(元祖)"
    return '<a href=/image style="color:red"> 此处是连接 </a> <p>你的浏览器类型是 %s, %s</p><h4>request.headers的全部属性: %s</h4>' % (user_agent, request.host, all_headers)


@app.route('/hello/<name>')
def hello(name):
    nav_list = ['首页', '头条', '娱乐', '新闻']
    return render_template('test.html', name=name, nav=nav_list)


@app.route('/image')
def image():
    nav_list = ['首页', '头条', '娱乐', '新闻']
    img = url_for('static', filename='1.png')
    username = request.cookies.get('username')
    if username != None:
        return render_template('test.html', img=img, nav=nav_list, name=username)
    return render_template('test.html', img=img, nav=nav_list)

# http://10.177.241.210:5000/regist/ 和http://10.177.241.210:5000/regist 都能访问 @app.route('/regist/', methods=['GET', 'POST'])
# http://10.177.241.210:5000/image 能访问@app.route('/image')
# http://10.177.241.210:5000/image/  不能访问@app.route('/image')


@app.route('/regist/', methods=['GET', 'POST'])
def regist():
    if request.method == 'POST':
        # 关于cookie的设置与使用
        resp = make_response(
            '<p>"user %s regist ok!"</p><p><a href="/image" style="color:red"> 返回首页 </a></p>' % request.form['username'])
        resp.set_cookie('username', request.form['username'])
        return resp
    else:
        return render_template('reg.html')


@app.route('/logout')
def logout():
    resp = make_response(
        '<p>"user logout"</p><p><a href="/image" style="color:red"> 返回首页 </a></p>')
    resp.set_cookie('username', "")
    return resp

from werkzeug import secure_filename


@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        f = request.files['the_file']
        f.save('E:\\下载\\LearnFlask\\flask_sample\\static\\' +
               secure_filename(f.filename))  # 保持原名
        # f.save('E:\\下载\\LearnFlask\\flask_sample\\templates\\uploaded_file.txt')
        # 改变原名
        return "上传成功"
    else:
        return render_template('upload_file.html')

# url_for() 函数就是用于构建指定函数的 URL 的。它把函数名称作为 第一个参数，其余参数对应 URL 中的变量。
if __name__ == '__main__':
    with app.test_request_context():
        print(url_for('index'))
        print(url_for('image'))
        print(url_for('hello', name='/'))
        print(url_for('hello', name='John Doe'))
        print(url_for('static', filename='style.css'))
    app.run(debug=True, host='0.0.0.0', port=5000)

# 在模板内部你也可以访问 request 、session 和 g [1] 对象，以及 get_flashed_messages() 函数。
