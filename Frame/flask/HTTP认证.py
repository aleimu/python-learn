#!/usr/bin/env python
import os
from flask import Flask, abort, request, jsonify, g, url_for
from flask_sqlalchemy import SQLAlchemy
from flask_httpauth import HTTPBasicAuth
from passlib.apps import custom_app_context as pwd_context
from itsdangerous import (TimedJSONWebSignatureSerializer
                          as Serializer, BadSignature, SignatureExpired)

# 初始化配置
app = Flask(__name__)
app.config['SECRET_KEY'] = 'the quick brown fox jumps over the lazy dog'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.sqlite'
app.config['SQLALCHEMY_COMMIT_ON_TEARDOWN'] = True

# extensions
db = SQLAlchemy(app)
auth = HTTPBasicAuth()

# 数据库映射


class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(32), index=True)
    password_hash = db.Column(db.String(64))
    # 加密密码

    def hash_password(self, password):
        self.password_hash = pwd_context.encrypt(password)
    # 验证密码

    def verify_password(self, password):
        return pwd_context.verify(password, self.password_hash)

    def generate_auth_token(self, expiration=600):
        s = Serializer(app.config['SECRET_KEY'], expires_in=expiration)
        return s.dumps({'id': self.id})

    @staticmethod
    def verify_auth_token(token):
        s = Serializer(app.config['SECRET_KEY'])
        try:
            data = s.loads(token)
        except SignatureExpired:
            return None    # valid token, but expired
        except BadSignature:
            return None    # invalid token
        user = User.query.get(data['id'])
        return user


@auth.verify_password
def verify_password(username_or_token, password):
    # first try to authenticate by token
    user = User.verify_auth_token(username_or_token)
    if not user:
        # try to authenticate with username/password
        user = User.query.filter_by(username=username_or_token).first()
        if not user or not user.verify_password(password):
            return False
    g.user = user
    return True


@app.route('/api/users', methods=['POST'])
def new_user():
    print(type(request.json))
    print(request.json)
    username = request.json.get('username')
    password = request.json.get('password')
    if username is None or password is None:
        abort(400)    # missing arguments
    if User.query.filter_by(username=username).first() is not None:
        abort(400)    # existing user
    user = User(username=username)
    user.hash_password(password)
    db.session.add(user)
    db.session.commit()
    return (jsonify({'username': user.username, 'id': user.id}), 201,
            {'Location': url_for('get_user', id=user.id, _external=True), 'Server': 'apimgt', 'Content-Length': 40})

""" 这些都是可以自定义的
< HTTP/1.0 201 CREATED
< Content-Type: application/json
< Location: http://10.177.241.210:5000/api/users/6
< Server: apimgt
< Content-Length: 40
< Date: Fri, 01 Sep 2017 08:59:09 GMT
<
{
  "id": 6,
  "username": "lgj6"
}
"""


@app.route('/api/users/<int:id>')
def get_user(id):
    user = User.query.get(id)
    if not user:
        return jsonify({"error": "user`s id not exists!"}), 400
    return jsonify({'username': user.username})


@app.route('/api/token')
@auth.login_required
def get_auth_token():
    token = g.user.generate_auth_token(600)
    return jsonify({'token': token.decode('ascii'), 'duration': 600})


@app.route('/api/resource')
@auth.login_required
def get_resource():
    return jsonify({'data': 'Hello, %s!' % g.user.username})


if __name__ == '__main__':
    if not os.path.exists('db.sqlite'):
        db.create_all()
    app.run(debug=True, host='0.0.0.0', port=5000)


"""
优秀博客可以参考
http://www.cnblogs.com/Erick-L/category/1017281.html
http://www.cnblogs.com/Erick-L/p/7060806.html

curl -k -v -X POST -H "Content-Type:application/json" http://10.177.241.210:5000/api/users -d '{"username":"lgj","password":"lgj123"}'
{
  "username": "lgj","id":1
}

curl -u lgj:lgj123 -i -X GET http://10.177.241.210:5000/api/token
{
  "duration": 600,
  "token": "eyJhbGciOiJIUzI1NiIsImlhdCI6MTUwNDI1NTEyMCwiZXhwIjoxNTA0MjU1NzIwfQ.eyJpZCI6MX0.Z0W7YPI1aPDLONTxt-nQ0rHbzs7pSjaPYhXavJJaI7s"
}
curl -u lgj:lgj123 -i -X GET http://10.177.241.210:5000/api/resource

#也可以使用base64加密后
lgj:lgj123
bGdqOmxnajEyMw==

curl -k -v -X GET http://10.177.241.210:5000/api/users/1
curl -k -v -X GET -H "Authorization:Basic bGdqOmxnajEyMw==" http://10.177.241.210:5000/api/token
curl -k -v -X GET -H "Authorization:Basic bGdqOmxnajEyMw==" http://10.177.241.210:5000/api/resource

#使用获取的token访问，第一个不需要密码、第二个需要密码
curl -u "eyJhbGciOiJIUzI1NiIsImlhdCI6MTUwNDI1NTEyMCwiZXhwIjoxNTA0MjU1NzIwfQ.eyJpZCI6MX0.Z0W7YPI1aPDLONTxt-nQ0rHbzs7pSjaPYhXavJJaI7s:x" -i -X GET http://10.177.241.210:5000/api/resource
curl -u "eyJhbGciOiJIUzI1NiIsImlhdCI6MTUwNDI1NTEyMCwiZXhwIjoxNTA0MjU1NzIwfQ.eyJpZCI6MX0.Z0W7YPI1aPDLONTxt-nQ0rHbzs7pSjaPYhXavJJaI7s" -i -X GET http://10.177.241.210:5000/api/resource


使用HTTPie测试web服务

pip install httpie

http --json --auth 834424581@qq.com:abc GET http://127.0.0.1:5000/api/v1.0/posts
匿名用户，空邮箱，空密码

http --json --auth :  GET http://127.0.0.1:5000/api/v1.0/posts
POST 添加文章

http --auth 834424581@qq.com:abc --json POST http://127.0.0.1:5000/api/v1.0/posts/ “body=xxxxxxxxxxxxxxxx”
使用认证令牌，可以向api/v1.0/token发送请求

http --auth 834424581@qq.com:abc --json GET http://127.0.0.1:5000/api/v1.0/token
接下来的1小时，可以用令牌空密码访问

http --auth eyJpYXQ......: --json GET http://127.0.0.1:5000/api/v1.0/posts
令牌过期，请求会返回401错误，需要重新获取令牌


if __name__ == '__main__':
    app.run(debug=True)
__name__=='__main__' 是 Python 的惯常用法，在这里确保直接执行这个脚本时才启动开发
Web 服务器。如果这个脚本由其他脚本引入，程序假定父级脚本会启动不同的服务器，因
此不会执行app.run()。

"""
