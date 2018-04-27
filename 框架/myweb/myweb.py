# coding:utf-8
import sqlite3
from flask import Flask, request, session, g, redirect, url_for, \
    abort, render_template, flash,make_response
from contextlib import closing
from passlib.apps import custom_app_context as pwd_context
# 设置数据库存储路径
DATABASE = r'C:\\Users\\lWX307086\\Desktop\\python_learn-master\\未上传文件\\myweb\\flaskr.db'
# 永远不要在生产环境中打开调试模式
# 变量名均为大写字母的变量
SECRET_KEY = "zheshiyigemima"

app = Flask(__name__)
app.config.from_object(__name__)
# app.secret_key = os.urandom(24)    #在这里设置和上面的SECRET_KEY = os.urandom(24)是一样的
# print("app.secret_key:", app.secret_key)


##########################################数据库部分##########################
def connect_db():
    return sqlite3.connect(app.config['DATABASE'])

def init_db():
    with closing(connect_db()) as db:
        with app.open_resource('./schema.sql', mode='r')as f:
            db.cursor().executescript(f.read())
        db.commit()

# 有必要在请求之前初始化连接，并在请求后关闭连接
@app.before_request
def before_request():
    g.db = connect_db()


# @app.after_request
# def after_request(exception):
#     db = getattr(g, 'db', None)  # Getattr用于返回一个对象属性，或者方法
#     if db is not None:
#         db.close()
#     g.db.close()

@app.teardown_request
def teardown_request(exception):
    db = getattr(g, 'db', None)  # Getattr用于返回一个对象属性，或者方法
    if db is not None:
        db.close()
    g.db.close()

##########################################文章管理##########################
@app.route('/')
def show_web():
    # execute是执行sql语句
    cur = g.db.execute('select title, text,id from entries order by id desc')
    # 字典初始化，key为title，value为text。cur.fetchall()是接收全部的返回结果行
    entries = [dict(title=row[0], text=row[1],id=row[2]) for row in cur.fetchall()]
    print("entries:",entries)
    # 1.cucursor()获取操作游标
    # 2.execute执行SQL,括号里的是sql语句
    # 3.fetchall()返回查询到的所有记录
    return render_template('show_entries.html', entries=entries)

@app.route('/<string:username>/<int:id>')
def show(username,id):
    # execute是执行sql语句
    cur = g.db.execute('select title, text,id from entries where id=(?)',[id])
    entries = [dict(title=row[0], text=row[1],id=row[2]) for row in cur.fetchall()]
    print(username)
    print(entries)
    return render_template('show_web.html', entries=entries)

@app.route('/<int:id>')
def redirect_to_login(id):
    flash('请先登录！')
    return redirect(url_for('login'))

# 写博客
@app.route('/add', methods=['POST'])
def addweb():
    if not session.get('username'):
        abort(401)
    # 确保在构建 SQL 语句时使用问号。否则当你使用字符串构建 SQL 时
    # 容易遭到 SQL 注入攻击。
    g.db.execute('insert into entries (title, text) values (?, ?)',
                 [request.form['title'], request.form['text']])
    g.db.commit()
    flash('文章已提交成功！')
    return redirect(url_for('show_web'))

# 删博客
@app.route('/del/<int:id>', methods=['POST'])
def delweb(id):
    if not session.get('username'):
        abort(401)
    g.db.execute('delete from entries  where id=?',[id])
    g.db.commit()
    flash('文章已删除！')
    return redirect(url_for('show',username=session.get('username'),id=id))


# 更新博客
@app.route('/up/<int:id>', methods=['POST'])
def upweb(id):
    if not session.get('username'):
        abort(401)
    g.db.execute('update entries set title=?,text=? where id=?',[request.form['title'], request.form['text'],id])
    g.db.commit()
    flash('文章已更新成功！')
    return redirect(url_for('show',username=session.get('username'),id=id))

##########################################用户管理##########################
# 登录
@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        u=request.form['username']
        p=request.form['password']
        try:
            pp = g.db.execute('select password from users where name=(?)',[u]).fetchone()[0]
            #print(pp)
        except Exception as e:
            error ='Invalid password or username!'
        else:
            user=checkpwd()
            user.password_hash=pp
            user.password=p
            if user.verify_password()==False:
                error = 'Invalid password or username!'
            else:
                session['username'] = u
                flash('You were logged in')
                return redirect(url_for('show_web'))
    return render_template('login.html', error=error)


# 注销
@app.route('/logout')
def logout():
    session.pop('username', None)
    flash('You were logged out')
    return redirect(url_for('show_web'))


# 注册
@app.route('/regist/', methods=['GET', 'POST'])
def regist():
    if request.method == 'POST':
        user=checkpwd()
        n=request.form['username']
        user.password=request.form['password']
        pp=user.hash_password()
        try:
            g.db.execute('insert into users (name, password) values (?, ?)',[n, pp])
            g.db.commit()
        except Exception as e:
            flash('用户名重复!')
        else:
            flash('注册成功')
        return redirect(url_for('show_web'))
    else:
        return render_template('reg.html')

# 修改密码
@app.route('/uppwd/', methods=['GET', 'POST'])
def uppwd():
    pass


# 校验用户名和密码
#当一个新的用户注册，或者更改密码时，就会调用hash_password()函数，将原始密码作为参数传入hash_password()函数。
#当验证用户密码时就会调用verify_password()函数,如果密码正确，就返回True，如果不正确就返回False。
class checkpwd():
    def __init__(self,):
        self.password=None
        self.password_hash=None
        self.tmp=None
    # 加密密码
    def hash_password(self):
        self.tmp = pwd_context.encrypt(self.password)
        return self.tmp
    # 验证密码
    def verify_password(self):
        return pwd_context.verify(self.password, self.password_hash)

##########################################其他功能##########################
# 上传文件
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


##########################################运行管理##########################
from flask_script import Manager,Command,prompt_bool
manager = Manager(app)

@manager.command
def initdb():
    if prompt_bool("Are you sure you want to lose all your data?"):
        init_db()
        print("初始化数据库成功!")


if __name__ == '__main__':
    app.debug=True
    manager.run()



"""
1.登录才能查看博客
2.用户名密码需要校验、加密
3.尽量美观大方
4.包含数据库，shell等插件


"""







""" set_cookie的方式

@main.route('/followed')
@login_required
def show_followed():
    resp = make_response(redirect(url_for('.index')))
    resp.set_cookie('show_followed', '1', max_age=30 * 24 * 60 * 60)
    return resp

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


username = request.cookies.get('username')
"""








#python myweb.py runserver -h 0.0.0.0 -p 5001

"""manager自带了一些参数
python myweb.py runserver --help
usage: myweb.py runserver [-?] [-h HOST] [-p PORT] [--threaded]
                          [--processes PROCESSES] [--passthrough-errors] [-d]
                          [-D] [-r] [-R]

Runs the Flask development server i.e. app.run()

optional arguments:
  -?, --help            show this help message and exit
  -h HOST, --host HOST
  -p PORT, --port PORT
  --threaded
  --processes PROCESSES
  --passthrough-errors
  -d, --debug           enable the Werkzeug debugger (DO NOT use in production
                        code)
  -D, --no-debug        disable the Werkzeug debugger
  -r, --reload          monitor Python files for changes (not
                        100{'option_strings': ['-r', '--reload'], 'dest':
                        'use_reloader', 'nargs': 0, 'const': True, 'default':
                        None, 'type': None, 'choices': None, 'required':
                        False, 'help': 'monitor Python files for changes (not
                        100% safe for production use)', 'metavar': None,
                        'container': <argparse._ArgumentGroup object at
                        0x03126B10>, 'prog': 'myweb.py runserver'}afe for
                        production use)
  -R, --no-reload       do not monitor Python files for changes
"""
