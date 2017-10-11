# coding:utf-8

# all the imports
import sqlite3
from flask import Flask, request, session, g, redirect, url_for, \
    abort, render_template, flash
from contextlib import closing
import os

# 设置数据库存储路径
DATABASE = 'E:\\下载\\LearnFlask\\flaskr\\flaskr.db'
# 永远不要在生产环境中打开调试模式
DEBUG = True


SECRET_KEY = os.urandom(24)
print("SECRET_KEY:", SECRET_KEY)
USERNAME = 'admin'
PASSWORD = 'default'

# create our little application
app = Flask(__name__)
# 查看给定的对象，搜索对象中所有变量名均为大写字母的变量
app.config.from_object(__name__)
# app.secret_key = os.urandom(24)    #在这里设置和上面的SECRET_KEY = os.urandom(24)是一样的
print("app.secret_key:", app.secret_key)
# 链接数据库


def connect_db():
    return sqlite3.connect(app.config['DATABASE'])

# 初始化数据库，导入schema.sql
# 注意！需要导入flaskr的init_db方法，之后init_db()


def init_db():
    with closing(connect_db()) as db:
        with app.open_resource('./schema.sql', mode='r')as f:
            db.cursor().executescript(f.read())
        db.commit()

# 有必要在请求之前初始化连接，并在请求后关闭连接


@app.before_request
def before_request():
    g.db = connect_db()


@app.teardown_request
def teardown_request(exception):
    db = getattr(g, 'db', None)  # Getattr用于返回一个对象属性，或者方法
    if db is not None:
        db.close()
    g.db.close()

# 这个视图会把条目做为字典传递给show_enteries.html模板


@app.route('/')
def show_entries():
    # execute是执行sql语句
    cur = g.db.execute('select title, text from entries order by id desc')
    # 字典初始化，key为title，value为text。cur.fetchall()是接收全部的返回结果行
    entries = [dict(title=row[0], text=row[1]) for row in cur.fetchall()]
    # 1.cucursor()方法的作用？获取操作游标
    # 2.execute方法的作用？执行SQL,括号里的是sql语句
    # 3.fetchall()方法滴作用？返回查询到的所有记录
    return render_template('show_entries.html', entries=entries)

# 这个视图可以让一个登录后的用户添加一个条目


@app.route('/add', methods=['POST'])
def add_entry():
    if not session.get('logged_in'):
        abort(401)
    # 确保在构建 SQL 语句时使用问号。否则当你使用字符串构建 SQL 时
    # 容易遭到 SQL 注入攻击。
    g.db.execute('insert into entries (title, text) values (?, ?)',
                 [request.form['title'], request.form['text']])
    g.db.commit()
    flash('New entry was successfully posted')
    return redirect(url_for('show_entries'))

# 这些函数用于登录和注销


@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        if request.form['username'] != app.config['USERNAME']:
            error = 'Invalid username'
        elif request.form['password'] != app.config['PASSWORD']:
            error = 'Invalid password'
        else:
            session['logged_in'] = True
            flash('You were logged in')
            return redirect(url_for('show_entries'))
    return render_template('login.html', error=error)

# 注销


@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    flash('You were logged out')
    return redirect(url_for('show_entries'))


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
