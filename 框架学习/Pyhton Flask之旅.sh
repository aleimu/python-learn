《Pyhton Flask之旅》

配置
{
#http://blog.csdn.net/nunchakushuang/article/details/74645094

#开启DEBUG模式有三种方式：
1.直接在应用对象上设置：
app.debug = True
    app.run()
2.在执行run方法的时候，传递参数进去：
app.run(debug=True)

3.在config属性中设置：
app.config.update(DEBUG=True)

#项目配置：
Flask项目的配置，都是通过app.config对象来进行配置的。比如要配置一个项目处于DEBUG模式下，那么可以使用app.config['DEBUG'] = True来进行设置，
那么Flask项目将以DEBUG模式运行。在Flask项目中，有四种方式进行项目的配置：

1.直接硬编码：
app = Flask(__name__)
app.config['DEBUG'] = True

因为app.config是flask.config.Config的实例，而Config类是继承自dict，因此可以通过update方法：
app.config.update(
    DEBUG=True,
    SECRET_KEY='...'
)

如果你的配置项特别多，你可以把所有的配置项都放在一个模块中，然后通过加载模块的方式进行配置，假设有一个settings.py模块，专门用来存储配置项的，此时你可以通过app.config.from_object()方法进行加载，并且该方法既可以接收模块的的字符串名称，也可以模块对象：
2.通过模块字符串
app.config.from_object('settings')
3.通过模块对象
import settings
app.config.from_object(settings)
也可以通过另外一个方法加载，该方法就是app.config.from_pyfile()，该方法传入一个文件名，通常是以.py结尾的文件，但也不限于只使用.py后缀的文件：
app.config.from_pyfile('settings.py',silent=True)
#silent=True表示如果配置文件不存在的时候不抛出异常，默认是为False，会抛出异常。

}

URL和view
{
#类型有以下几种：
string: 默认的数据类型，接受没有任何斜杠“\/”的文本。
int: 接受整形。
float: 接受浮点类型。
path： 和string的类似，但是接受斜杠。
uuid： 只接受uuid字符串。
any：可以指定多种路径。
#item这个函数可以接受两个URL,一个是/article/，另一个是/blog/。并且，一定要传url_path参数，url_path的名称可以随便。
@app.route('/<any(article,blog):url_path>/')
def item(url_path):
    return url_path

#url中参数的获取
通过传统的?=的形式来传递参数，例如：/article?id=xxx，这种情况下，可以通过request.args.get('id')来获取id的值。如果是post方法，则可以通过request.form.get('id')来进行获取。


#响应（Response）：

视图函数的返回值会被自动转换为一个响应对象，Flask的转换逻辑如下：

如果返回的是一个合法的响应对象，则直接返回。
如果返回的是一个字符串，那么Flask会重新创建一个werkzeug.wrappers.Response对象，Response将该字符串作为主体，状态码为200，MIME类型为text/html，然后返回该Response对象。
如果返回的是一个元组，元祖中的数据类型是(response,status,headers)，只能包含一个元素。status值会覆盖默认的200状态码，headers可以是一个列表或者字典，作为额外的消息头。
如果以上条件都不满足，Flask会假设返回值是一个合法的WSGIt应用程序，并通过Response.force_type(rv,request.environ)转换为一个请求对象。

1.直接使用Response创建：
from werkzeug.wrappers import Response
@app.route('/about/')
def about():
    resp = Response(response='about page',status=200,content_type='text/html;charset=utf-8')
    return resp

2.可以使用make_response函数来创建Response对象，这个方法可以设置额外的数据，比如设置cookie，header信息等：
from flask import make_response
@app.route('/about/')
def about():
    return make_response('about page')

3.通过返回元组的形式：
@app.errorhandler(404)
def not_found():
    return 'not found',404
	
4.自定义响应。自定义响应必须满足三个条件：
必须继承自Response类。
必须实现类方法force_type(cls,rv,environ=None)。
必须指定app.response_class为你自定义的Response
#http://blog.csdn.net/nunchakushuang/article/details/74645094


	
}

模板
{
#关于模板的几个博客
#http://blog.csdn.net/nunchakushuang/article/details/74645592
#http://blog.csdn.net/kikaylee/article/details/53540352?locationNum=6&fps=1
#http://www.cnblogs.com/Erick-L/p/6873129.html

if __name__ == '__main__':
    app.run(debug=True)
__name__=='__main__' 是 Python 的惯常用法，在这里确保直接执行这个脚本时才启动开发Web 服务器。
如果这个脚本由其他脚本引入，程序假定父级脚本会启动不同的服务器，因此不会执行app.run()。


#如果想更改模板和静态文件地址，应该在创建app的时候，给Flask传递关键字参数template_folder、static_folder
from flask import Flask,render_template
app = Flask(__name__,template_folder=r'C:\templates',static_folder='/tmp')

@app.route('/about/')
def about():
    return render_template('about.html')

#Jinja数据类型：
Jinja支持许多数据类型，包括：字符串、整型、浮点型、列表、元组、字典、true/false

#运行Jinja2的语句；				{%...%}     
#在页面中打印Jinja2运行的结果:	{{…}}       
#注释:		 					{#...#}     

#if控制
{% if user %}
    Hello, {{ user }}
{% else %}
    Hello, Stranger!
{% endif %}

#for循环
<ul>
    {% for comment in comments %}
        <li>{{ comment }}</li>
    {% endfor %}
</ul>

#宏类似 python 中的函数
{% macro render_comment(comment) %}
    <li>{{ comment }}</li>
{% endmacro %}

<ul>
    {% for comment in comments %}
        {{ render_comment(comment) }}
    {% endfor %}
</ul>


#遍历字典：
<dl>
{% for key, value in my_dict.iteritems() %}
<dt>{{ key|e }}</dt>
<dd>{{ value|e }}</dd>
{% endfor %}
</dl>

#如果序列中没有值的时候，进入else：
<ul>
{% for user in users %}
<li>{{ user.username|e }}</li>
{% else %}
<li><em>no users found</em></li>
{% endfor %}
</ul>


#jinja2 能识别所有类型的变量，比如列表，字典，对象
<p>{{ mylist[3]}}</p>
<p>{{ mydict['key']}}</p>
<p>{{ mylist['key']}}</p>
<p>{{ myobj.somemethod() }}</p>


#include语句：
include语句可以把一个模板引入到另外一个模板中，类似于把一个模板的代码copy到另外一个模板的指定位置，看以下例子：
{% include 'header.html' %}
Body
{% include 'footer.html' %}
#赋值（set）语句：
有时候我们想在在模板中添加变量，这时候赋值语句（set）就派上用场了，先看以下例子：
{% set name='xiaotuo' %}
那么以后就可以使用name来代替xiaotuo这个值了，同时，也可以给他赋值为列表和元组：
{% set navigation = [('index.html', 'Index'), ('about.html', 'About')] %}
赋值语句创建的变量在其之后都是有效的，如果不想让一个变量污染全局环境，可以使用with语句来创建一个内部的作用域，将set语句放在其中，这样创建的变量只在with代码块中才有效，看以下示例：
{% with %}
{% set foo = 42 %}
{{ foo }} foo is 42 here
{% endwith %}
也可以在with的后面直接添加变量，比如以上的写法可以修改成这样：
{% with foo = 42 %}
{{ foo }}
{% endwith %}
这两种方式都是等价的，一旦超出with代码块，就不能再使用foo这个变量了。

#过滤器
过滤器是通过管道符号（|）进行使用的，例如：{{ name|length }}，将返回name的长度。
safe    渲染值时不转义
capitalize 把值的首字母转换成大写，其他字母小写
lower      把值转换成小写形式
upper     把值转换成大写形式
title       把值中每个单词的首字母变成大写
trim      把值的首尾空格去掉
striptags  渲染之前把所有的HTML标签都删除

#常用的过滤器进行讲解：
abs(value)：返回一个数值的绝对值。示例：-1|abs
default(value,default_value,boolean=false)：如果当前变量没有值，则会使用参数中的值来代替。示例：name|default('xiaotuo')——如果name不存在，则会使用xiaotuo来替代。boolean=False默认是在只有这个变量为undefined的时候才会使用default中的值，如果想使用python的形式判断是否为false，则可以传递boolean=true。也可以使用or来替换。
escape(value)或e：转义字符，会将<、>等符号转义成HTML中的符号。示例：content|escape或content|e。
first(value)：返回一个序列的第一个元素。示例：names|first
format(value,*arags,**kwargs)：格式化字符串。比如：
{{ "%s" - "%s"|format('Hello?',"Foo!") }}
将输出：Helloo? - Foo!
last(value)：返回一个序列的最后一个元素。示例：names|last。
length(value)：返回一个序列或者字典的长度。示例：names|length。
join(value,d=u'')：将一个序列用d这个参数的值拼接成字符串。
safe(value)：如果开启了全局转义，那么safe过滤器会将变量关掉转义。示例：content_html|safe。
int(value)：将值转换为int类型。
float(value)：将值转换为float类型。
lower(value)：将字符串转换为小写。
upper(value)：将字符串转换为小写。
replace(value,old,new)： 替换将old替换为new的字符串。
truncate(value,length=255,killwords=False)：截取length长度的字符串。
striptags(value)：删除字符串中所有的HTML标签，如果出现多个空格，将替换成一个空格。
trim：截取字符串前面和后面的空白字符。
string(value)：将变量转换成字符串。
wordcount(s)：计算一个长字符串中单词的个数。


#测试器：
测试器主要用来判断一个值是否满足某种类型，并且这种类型一般通过普通的if判断是有很大的挑战的。语法是：if...is...，先来简单的看个例子：

{% if variable is escaped%}
value of variable: {{ escaped }}
{% else %}
variable is not escaped
{% endif %}
以上判断variable这个变量是否已经被转义了，Jinja中内置了许多的测试器，看以下列表：

callable(object)：是否可调用。
defined(object)：是否已经被定义了。
escaped(object)：是否已经被转义了。
upper(object)：是否全是大写。
lower(object)：是否全是小写。
string(object)：是否是一个字符串。
sequence(object)：是否是一个序列。
number(object)：是否是一个数字。
odd(object)：是否是奇数。
even(object)：是否是偶数。


#宏：
模板中的宏跟Python中的函数类似，可以传递参数，但是不能有返回值，可以将一些经常用到的代码片段放到宏中，然后把一些不固定的值抽取出来当成一个变量，以下将用一个例子来进行解释：

{% macro input(name, value='', type='text') %}
<input type="{{ type }}" name="{{ name }}" value="{{value|e }}">
{% endmacro %}
以上例子可以抽取出了一个input标签，指定了一些默认参数。那么我们以后创建input标签的时候，可以通过他快速的创建：
<p>{{ input('username') }}</p>
<p>{{ input('password', type='password') }}</p>


#转义：
转义的概念是，在模板渲染字符串的时候，字符串有可能包括一些非常危险的字符比如<、>等，这些字符会破坏掉原来HTML标签的结构，更严重的可能会发生XSS跨域脚本攻击，
因此如果碰到<、>这些字符的时候，应该转义成HTML能正确表示这些字符的写法，比如>在HTML中应该用&lt;来表示等。
但是Flask中默认没有开启全局自动转义，针对那些以.html、.htm、.xml和.xhtml结尾的文件，如果采用render_template函数进行渲染的，则会开启自动转义。
并且当用render_template_string函数的时候，会将所有的字符串进行转义后再渲染。
#Jinja2默认没有开启全局自动转义。

#静态文件配置
<link href="{{ url_for('static',filename='about.css') }}">

}

数据库
{
#http://blog.csdn.net/nunchakushuang/article/details/74647673
在Flask中可以自由的使用MySQL、PostgreSQL、SQLite、Redis、MongoDB来写原生的语句实现功能，也可以使用更高级别的数据库抽象方式，如SQLAlchemy或MongoEngine这样的OR(D)M。

使用sqlite数据库的两种姿势
{

import sqlite3
from contextlib import closing

app.config.update(
    DATABASE = 'my.db',      #相对于文件所在目录
    DEBUG=True,
)

def connect_db():
    return sqlite3.connect(app.config['DATABASE'])

def init_db():
    with closing(connect_db()) as db:
        with app.open_resource('schema.sql', 'r') as f:
            db.cursor().executescript(f.read())
        db.commit()

def get_db():
    db = connect_db()
    cur = db.cursor()
    return db, cur

db, cur = get_db()
x = cur.execute('SELECT * FROM users WHERE username = ?', [username])
x.fetchall()

cur.execute("INSERT INTO users (username, password, email) VALUES(?,?,?)", [username, password, email])
db.commit()
cur.close()
db.close()
####################################################################

import sqlite3
from flask import Flask, request, session, g, redirect, url_for, abort, render_template, flash,make_response
# 设置数据库存储路径
DATABASE = r'C:\\Users\\lWX307086\\Desktop\\python_learn-master\\未上传文件\\myweb\\flaskr.db'
SECRET_KEY = "zheshiyigemima"

app = Flask(__name__)
app.config.from_object(__name__)
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


@app.after_request
def after_request(exception):
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

}

使用引擎连接mysql数据库
{
from sqlalchemy import create_engine

# 将要连接的数据库的配置
HOSTNAME = '10.120.189.164'
PORT = '15432'
DATABASE = 'golang'
USERNAME = 'root'
PASSWORD = 'root'
DB_URI = 'mysql+pymysql://{}:{}@{}:{}/{}'.format(USERNAME,PASSWORD,HOSTNAME,PORT,DATABASE)
#dialect+driver://username:password@host:port/database
#dialect是数据库的实现，比如MySQL、PostgreSQL、SQLite，并且转换成小写。driver是Python对应的驱动，如果不指定，会选择默认的驱动，比如MySQL的默认驱动是MySQLdb。
#username是连接数据库的用户名，password是连接数据库的密码，host是连接数据库的域名，port是数据库监听的端口号，database是连接哪个数据库的名字。
#connect()，创建连接
#close()，关闭数据库连接
#commit()，提交
#rollback()，回滚/取消当前

# 创建数据库引擎
engine = create_engine(DB_URI)

#创建连接
with engine.connect() as con:
    rs = con.execute('SELECT 1')
    print (rs.fetchone())

with engine.connect() as con:
    # 先删除users表
    con.execute('drop table if exists users')
    # 创建一个users表，有自增长的id和name
    con.execute('create table users(id int primary key auto_increment,'
    'name varchar(25))')
    # 插入两条数据到表中
    con.execute('insert into users(name) values("xiaoming")')
    con.execute('insert into users(name) values("xiaotuo")')
    # 执行查询操作
    rs = con.execute('select * from users')
    # 从查找的结果中遍历
    for row in rs:
        print ("row:",row)
}

ORM(数据库映射式)
{
###################### ORM #######################
from flask_migrate import Migrate, MigrateCommand
from flask_script import Manager
from flask import Flask
from flask_bootstrap import Bootstrap
from flask_sqlalchemy import SQLAlchemy
import os

basedir = os.path.abspath(os.path.dirname(__file__))

SQLALCHEMY_DATABASE_URI = "sqlite:///" + os.path.join(basedir, "ORM.db")
SQLALCHEMY_MIGRATE_REPO = os.path.join(basedir, 'db')
SQLALCHEMY_TRACK_MODIFICATIONS = True
CSRF_ENABLED = True
SECRET_KEY = "wito_python_api"
UPLOAD_FOLDER = "app\\static\\upload"

app = Flask(__name__)
app.config.from_object(__name__)
app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER

###################### ORM #######################
db = SQLAlchemy(app)

#db.Column 中其余的参数指定属性的配置选项。
"""
primary_key	如果设为 True,这列就是表的主键
unique	如果设为 True,这列不允许出现重复的值
index	如果设为 True,为这列创建索引,提升查询效率
nullable	如果设为 True,这列允许使用空值;如果设为 False,这列不允许使用空值
default	为这列定义默认值
"""
class User(db.Model):
    # 定义表名为users
    __tablename__ = 'users'
    user_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    user_name = db.Column(db.String(64),unique=True)
    password = db.Column(db.String(64))
    status = db.Column(db.Integer)
    level = db.Column(db.Integer)
    # 让打印出来的数据更好看，可选的
    def __repr__(self):
        return "<User(user_id='%s',user_name='%s',password='%s',status='%s',level='%s')>" % (self.user_id,self.user_name,self.password,self.status,self.level)

class Parameter(db.Model):
    parameter_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    interface_id = db.Column(db.Integer, db.ForeignKey("user.user_id"))
    parameter_type = db.Column(db.String(64))

db.create_all()


add = User(user_name="lgj",password="123",status=1,level=2)
add2 = User(user_name="lgj2",password="12233",status=2,level=4)
#会话由 db.session 表示
db.session.add(add)#增
db.session.add(add2)
add.user_name = 'LGJ'#改
db.session.delete(add2)#删
db.session.commit()
user_all = User.query.filter_by(user_id=1).all()#查
print(user_all)
print(user_all[0].user_id,user_all[0].user_name,user_all[0].password,user_all[0].level)


#添加数据库管理
manage = Manager(app)
migrate = Migrate(app, db)
manage.add_command('db', MigrateCommand)

if __name__ == '__main__':
    manage.run()

"""
为了导出数据库迁移命令,Flask-Migrate 提供了一个 MigrateCommand 类,可附加到 Flask- Script 的 manager 对象上。
在这个例子中,MigrateCommand 类使用 db 命令附加。
在维护数据库迁移之前,要使用 init 子命令创建迁移仓库:
python hello.py db init    # 将向应用添加一个`migrations`文件夹。文件夹中的文件需要和其他源文件一起进行版本控制。
这个命令会创建 migrations 文件夹,所有迁移脚本都存放其中。


可在 query 对象上调用的常用过滤器。
过滤器	说明
filter()	把过滤器添加到原查询上,返回一个新查询
filter_by()	把等值过滤器添加到原查询上,返回一个新查询
limit()	使用指定的值限制原查询返回的结果数量,返回一个新查询
offset()	偏移原查询返回的结果,返回一个新查询
order_by()	根据指定条件对原查询结果进行排序,返回一个新查询
group_by()	根据指定条件对原查询结果进行分组,返回一个新查询
在查询上应用指定的过滤器后,通过调用 all() 执行查询,以列表的形式返回结果。除了 all() 之外,还有其他方法能触发查询执行。

常用查询执行函数
方法	说明
all()	以列表形式返回查询的所有结果
first()	返回查询的第一个结果,如果没有结果,则返回 None
first_or_404()	返回查询的第一个结果,如果没有结果,则终止请求,返回 404 错误响应
get()	返回指定主键对应的行,如果没有对应的行,则返回 None
get_or_404()	返回指定主键对应的行,如果没找到指定的主键,则终止请求,返回 404 错误响应
count()	返回查询结果的数量
paginate()	返回一个 Paginate 对象,它包含指定范围内的结果

"""

###################### ORM #######################
}

sqlalchemy常用数据类型：{

Integer：整形。
Boolean：传递True/False进去。
Date：传递datetime.date()进去。
DateTime：传递datetime.datetime()进去。
Float：浮点类型。
String：字符类型，使用时需要指定长度，区别于Text类型。
Text：文本类型。
Time：传递datetime.time()进去。
}

过滤条件：{
过滤是数据提取的一个很重要的功能，以下对一些常用的过滤条件进行解释，并且这些过滤条件都是只能通过filter方法实现的：
1.equals：
query.filter(User.name == 'ed')

2.not equals:
query.filter(User.name != 'ed')

3.like：
query.filter(User.name.like('%ed%'))

4.in：
query.filter(User.name.in_(['ed','wendy','jack']))
# 同时，in也可以作用于一个Query
query.filter(User.name.in_(session.query(User.name).filter(User.name.like('%ed%'))))

5.not in：
query.filter(~User.name.in_(['ed','wendy','jack']))

6.is null：
query.filter(User.name==None)
# 或者是
query.filter(User.name.is_(None))

7.is not null:
query.filter(User.name != None)
# 或者是
query.filter(User.name.isnot(None))

8.and：
from sqlalchemy import and_
query.filter(and_(User.name=='ed',User.fullname=='Ed Jones'))
# 或者是传递多个参数
query.filter(User.name=='ed',User.fullname=='Ed Jones')
# 或者是通过多次filter操作
query.filter(User.name=='ed').filter(User.fullname=='Ed Jones')

9.or：
from sqlalchemy import or_ query.filter(or_(User.name=='ed',User.name=='wendy'))
}

文本SQL{
SQLAlchemy还提供了使用文本SQL的方式来进行查询,而文本SQL要装在一个text()方法中，看以下例子：

from sqlalchemy import text
for user in session.query(User).filter(text("id<244")).order_by(text("id")).all():
print user.name
如果过滤条件比如上例中的244存储在变量中，这时候就可以通过传递参数的形式进行构造：
session.query(User).filter(text("id<:value and name=:name")).params(value=224,name='ed').order_by(User.id)
在文本SQL中的变量前面使用了:来区分，然后使用params方法，指定需要传入进去的参数。另外，使用from_statement方法可以把过滤的函数和条件函数都给去掉，使用纯文本的SQL:
sesseion.query(User).from_statement(text("select * from users where name=:name")).params(name='ed').all()
使用from_statement方法一定要注意，from_statement返回的是一个text里面的查询语句，一定要记得调用all()方法来获取所有的值。
}

计数（Count）{
Query对象有一个非常方便的方法来计算里面装了多少数据：

session.query(User).filter(User.name.like('%ed%')).count()
当然，有时候你想明确的计数，比如要统计users表中有多少个不同的姓名，那么简单粗暴的采用以上count是不行的，因为姓名有可能会重复，但是处于两条不同的数据上，如果在原生数据库中，可以使用distinct关键字，那么在SQLAlchemy中，可以通过func.count()方法来实现：
from sqlalchemy import func
session.query(func.count(User.name),User.name).group_by(User.name).all()
# 输出的结果
> [(1, u'ed'), (1, u'fred'), (1, u'mary'), (1, u'wendy')]
另外，如果想实现select count(*) from users，可以通过以下方式来实现：
session.query(func.count(*)).select_from(User).scalar()
当然，如果指定了要查找的表的字段，可以省略select_from()方法：
session.query(func.count(User.id)).scalar()
}

分页导航{
Flask-SQLALchemy的Pagination对象可以方便的进行分页,
对一个查询对象调用pagenate(page, per_page=20, error_out=True)函数可以得到pagination对象,第一个参数表示当前页,第二个参数代表每页显示的数量,error_out=True的情况下如果指定页没有内容将出现404错误,否则返回空的列表

#从get方法中取得页码
page = request.args.get('page', 1, type = int)
#获取pagination对象
    pagination = Post.query.order_by(Post.timestamp.desc()).paginate(page, per_page=10, error_out = False)
#pagination对象的items方法返回当前页的内容列表
    posts = pagination.items

pagination对象常用方法:
has_next :是否还有下一页
has_prev :是否还有上一页
items : 返回当前页的所有内容
next(error_out=False) : 返回下一页的Pagination对象
prev(error_out=False) : 返回上一页的Pagination对象
page : 当前页的页码(从1开始)
pages : 总页数
per_page : 每页显示的数量
prev_num : 上一页页码数
next_num :下一页页码数
query :返回 创建这个Pagination对象的查询对象
total :查询返回的记录总数
iter_pages(left_edge=2, left_current=2, right_current=5, right_edge=2)

#在模版中使用
{% macro render_pagination(pagination, endpoint) %}
  <div class=pagination>
  {%- for page in pagination.iter_pages() %}
    {% if page %}
      {% if page != pagination.page %}
        <a href="{{ url_for(endpoint, page=page) }}">{{ page }}</a>
      {% else %}
        <strong>{{ page }}</strong>
      {% endif %}
    {% else %}
      <span class=ellipsis>…</span>
    {% endif %}
  {%- endfor %}
  </div>
{% endmacro %}

}
}

Flask-Script
{

from flask_script import Shell
from flask_script import Manager
app=create_app()
manager = Manager(app)

# from flask_migrate import Migrate, MigrateCommand
# manager.add_command('db', MigrateCommand)
# #manaer 是Flask-Script的实例,这条语句在flask-script 中添加一个db命令

#增加命令行方式一
from flask_script import Command,prompt_bool
class Hello1(Command):
    "prints hello world"

    def run(self):
        print ("增加命令行方式一 : hello world 1")
manager.add_command('hello1', Hello1())
#manager.run({'hello1' : Hello1()}) #效果同上


#增加命令行方式二
@manager.option('-n', '--name', dest='name', default='joe')
@manager.option('-u', '--url', dest='url', default=None)
def hello2(name, url):
    if url is None:
        print ("hello2", name)
    else:
        print ("hello2", name, "from", url)
#python factory.py hello2 -u lgj

#增加命令行方式三 不带参数
#初始化数据库
@manager.command
def initdb():
    init_db()
    print('Initialized the database.')
#python factory.py initdb

#增加命令行方式三 带参数
@manager.command
def hello3(name="lgj"):
    print ("hello3", name)
#python factory.py hello3 --name=llllll
#python factory.py hello3 -n 1111111

#增加命令行方式三 带交互
@manager.command
def dropdb():
    if prompt_bool("Are you sure you want to lose all your data"):
        drop_db()
        print("删除数据库成功!")
#python factory.py dropdb

if __name__ == '__main__':
    app.debug = True
    manager.run()

# if __name__ == '__main__':
#     app=create_app()
#     app.run(debug=True, host='127.0.0.1', port=5000)

"""
1.使用@command装饰器

@manager.option('-n','--name',dest='name')
def hello(name):
    print ('hello ',name)

2.使用类继承自Command类：

2.1 必须继承自Command基类。
2.2 必须实现run方法。
2.3 必须通过add_command方法添加命令。
from flask_script import Command,Manager
from your_app import app

manager = Manager(app)

class Hello(Command):
    def run(self):
        print ("hello world")

manager.add_command('hello',Hello())

from flask_Flask import Comman,Manager,Option
class Hello(Command):
    def __init__(self,default_name='Joe'):
        self.default_name = default_name

    def get_options(self):
        return [
        Option('-n','--name',dest='name',default=self.default_name),
        ]

    def run(self,name):
        print ('hello',name)

"""


}

Flask 常用点
{
1.判断method方式
request.method  'POST', 'GET'
 
2.获取form内容
request.form['form_name']
 
3.获取url参数(?key=value) 
request.args.get('key', '')
request.args["url"]
 
4.获取上传的文件
确保在html表单中设置 enctype="multipart/form-data"属性，f = request.files['the_file'],   from werkzeug import secure_filename,  file_name = secure_filename(f.filename) 
 
5.获取cookies内容
request.cookies.get('cook_name')
request.cookies['cook_name']
 
6.设置 cookies 内容
resp = make_response(render_template(...)) 
rep.set_cookie('key', 'value')
---------------------------------------------------
res = app.make_response('hello lg')
res.set_cookie('username', value='lgphp', max_age=20000)
----------------------------------------------------------------------
7.删除cooikes
res = app.make_response(render_template(...))
res.delete_cookie('username')   
#也可以
res.set_cookie('username', value='lgphp', expires=0)
 
8.判断cookie存在?
if (request.cookies):
}

Flask 六种常用响应方式
{
1. 直接返回字符串，可以返回状态码
@app.route('/testresponse', methods=['GET', 'POST'])
def testresponse():
    return "xxxxxxxx", 400
	
2. 响应Response对象，利用make_reponse()函数接受字符串和错误码，返回一个Response对象，利用这种方法，不但可以成功处理请求，还可以进一步设置响应，如设置cookie等等
from flask import make_response 
@app.route('/testresponse', methods=['GET', 'POST'])
def testresponse():
    print type( request.cookies )
    if request.cookies and request.cookies.get('hyman'):
        response=make_response('cookies has been set!')
    else:
        response=make_response('set cookies!')
        response.set_cookie('hyman','123')
    return response
	
3. 返回重定向类型redirect
@app.route('/testresponse', methods=['GET', 'POST'])
def testresponse():
    return redirect('http://www.baidu.com')
	
4. 返回处理错误码 
from flask import abort
@app.route('/testresponse', methods=['GET', 'POST'])
def testresponse():
	 abort(404)

5.渲染模板可以带参数
@app.route('/image')
def image():
    nav_list = ['首页', '头条', '娱乐', '新闻']
    img = url_for('static', filename='1.png')
    username = request.cookies.get('username')
    if username != None:
        return render_template('test.html', img=img, nav=nav_list, name=username)
    return render_template('test.html', img=img, nav=nav_list)	

6.返回json数据
@app.route("/api/v1.0/test/simple", methods=('POST','GET'))
def test_simple_view():
    return jsonify({'request.method': request.method, 'echo_msg': 'successful' } ), 201   	
}

web表单的几种方式
{
1.前端式，通过request.form获取提交的数据
#login.html
{% extends "layout.html" %}
{% block body %}
  <h2>Login</h2>
  {% if error %}<p class=error><strong>Error:</strong> {{ error }}{% endif %}
  <form action="{{ url_for('login') }}" method=post>
    <dl>
      <dt>Username:
      <dd><input type=text name=username>
      <dt>Password:
      <dd><input type=password name=password>
      <dd><input type=submit value=Login>
    </dl>
  </form>
{% endblock %}

# 登录
@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
		#通过request.form获取提交的数据
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

	
2.FlaskForm式+bootstrap/wtf的quick_form
#index.html
{% extends "base.html" %}
{% import "bootstrap/wtf.html" as wtf %}

{% block title %}Flasky{% endblock %}

{% block page_content %}
<div class="page-header">
    <h1>Hello, {% if name %}{{ name }}{% else %}Stranger{% endif %}!</h1>
    {% if not known %}
    <p>Pleased to meet you!</p>
    {% else %}
    <p>Happy to see you again!</p>
    {% endif %}
</div>
{{ wtf.quick_form(form) }}
{% endblock %}

from flask_wtf import FlaskForm
from wtforms import StringField, BooleanField,SubmitField
from wtforms.validators import DataRequired,Required,Length
#在这里定义form需要提交的数据的数目、类型、过滤规则等。
class NameForm(FlaskForm):
    name = StringField('name:', validators=[Required(),Length(3)])
    password=PasswordField("password:", validators=[Required(),Length(5)])
    submit = SubmitField('Submit')

# StringField 类表示type="text"的<input>元素
# StringField 构造函数的参数validators指定一个由验证函数组成的列表，函数Required()确保提交不为空
# SubmitField 类表示type="submit"的<input>元素


@app.route('/index',methods=['GET', 'POST'])
@app.route('/', methods=['GET', 'POST'])
def index():
    name = None
    form = NameForm()
    if form.validate_on_submit():
        name = form.name.data
        form.name.data = ''
    return render_template('index.html', form=form, name=name)

3.FlaskForm式+前端式，通过form.XXX使用参数
#login.html
<!-- extend base layout -->
{% extends "base.html" %}

{% block content %}
<h1>Sign In</h1>
<form action="" method="post" name="login">
    {{form.hidden_tag()}}
    <p>
        Please enter your OpenID:<br>
        {{form.openid(size=80)}}<br>
        Please enter your password:<br>
        {{form.password(size=80)}}<br>
        {% for error in form.errors.openid %}
        <span style="color: red;">[{{error}}]</span>
        {% endfor %}<br>
    </p>
    <p>{{form.remember_me}} Remember Me</p>
    <p><input type="submit" value="Sign In"></p>
</form>
{% endblock %}

#在这里定义form需要提交的数据的数目、类型、过滤规则。
class LoginForm(FlaskForm):
    openid = StringField('openid', validators = [DataRequired(),Length(3)])
    password = StringField('password', validators = [DataRequired(),Length(3)])
    remember_me = BooleanField('remember_me', default = False)
	
@app.route('/login', methods = ['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        flash('Login requested for OpenID="' + form.openid.data + form.password.data +'", remember_me=' + str(form.remember_me.data))
        return redirect('/index')
    return render_template('login.html',title = 'Sign In',form = form)

	

"""
from flask_wtf import FlaskForm
from wtforms import StringField, BooleanField,SubmitField,PasswordField
from wtforms.validators import DataRequired,Required,Length

WTForms支持的HTML标准字段

StringField                 文本字段
TextAreaField               多行文本字段
PasswordField               密码文本字段
HiddenField                 隐藏文本字段
DateField                   文本字段，值为datetime.date格式
DateTimeField               文本字段，值为datetime.datetime格式
IntegerField                文本字段，值为整数
DecimalField                文本字段，值为decimal.Decimal
FloatField                  文本字段，值为浮点数
BooleanField                复选框
RadioField                  一组单选框
SelectField                 下拉列表
SelectMultipleField         下拉列表，可选择多个值
FileField                   文本上传字段
SubmitField                 表单提交
FormField                   把表单作为字段嵌入另一个表单
FieldList                   一组指定类型的字段

WTForms.validators 验证函数

Email             验证电子邮件地址
EqualTo           比较两字段值，常用于要求输入两次密码确认
IPAddress         验证IPv4网络地址
Length            验证输入字符串长度
NumberRange       验证输入的值在数字范围内
Optional          无输入值时跳过其他验证函数
Required          确保字段中的数据
Regexp            使用正则表达式验证输入值
URL               验证URL
AnyOf             确保输入值在可选值列表中
NoneOf            确保输入值不在可选值列表中
"""
	
	
}

文件的上传下载
{
#http://www.cnblogs.com/Erick-L/p/7015783.html

1 后台程序直接生成文件内容
from flask import make_response
@app.route('/testdownload', methods=['GET'])
def testdownload():
    content = "long text"
    response = make_response(content)
    response.headers["Content-Disposition"] = "attachment; filename=myfilename.txt"
return response
 
2 读取一个服务器上的文件，供用户下载
from flask import make_response , send_file
@app.route('/testdownload', methods=['GET'])
def testdownload():
    response = make_response(send_file("views.py"))
    response.headers["Content-Disposition"] = "attachment; filename=views.py;"
return response

3.secure_filename原文件名存储
# coding:utf-8

from flask import Flask,render_template,request,redirect,url_for
from werkzeug.utils import secure_filename
import os

app = Flask(__name__)

@app.route('/upload', methods=['POST', 'GET'])
def upload():
    if request.method == 'POST':
        f = request.files['file']
        basepath = os.path.dirname(__file__)  # 当前文件所在路径
        upload_path = os.path.join(basepath, 'static\uploads',secure_filename(f.filename))  #注意：没有的文件夹一定要先创建，不然会提示没有该路径
        f.save(upload_path)
        return redirect(url_for('upload'))
    return render_template('upload.html')

if __name__ == '__main__':
    app.run(debug=True)

#upload.html	
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <h1>文件上传示例</h1>
    <form action="" enctype='multipart/form-data' method='POST'>
        <input type="file" name="file">
        <input type="submit" value="上传">
    </form>
</body>
</html>	
	
}
