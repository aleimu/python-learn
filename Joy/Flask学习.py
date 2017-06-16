from flask import Flask, render_template
app  = Flask(__name__)

@app.route("/")
def template1():
    return render_template("index.html")


# controller目录：MVC中的C,主要存放视图函数
# model目录：MVC中的M,主要存放实体类文件，映射数据库中表
# templates：MVC中的V，存放html文件
# static：静态文件，主要存放css，js等文件
# __init__.py:模块初始化文件，Flask 程序对象的创建必须在 __init__.py 文件里完成， 然后我们就可以安全的导入引用每个包。
# setting.py:配置文件，数据库用户名密码等等

# Flask 项目有4个顶级文件夹：

# app ——(本例中是 jbox）Flask 程序保存在此文件夹中
# migrations ——包含数据库迁移脚本（安装了 flask-migrate 后自动生成）
# tests ——单元测试放在此文件夹下
# venv ——Python 虚拟环境
# 同时还有一些文件：

# requirements.txt —— 列出了所有的依赖包，以便于在其他电脑中重新生成相同的环境
# config.py 存储配置
# manage.py 启动程序或者其他任务
# gun.conf Gunicorn 配置文件

# pip install flask-script
# pip install flask-sqlalchemy
# pip install flask-migrate

# flask-script 可以自定义命令行命令，用来启动程序或其它任务；
# flask-sqlalchemy 用来管理数据库的工具，支持多种数据库后台；
# flask-migrate 是数据库迁移工具，该工具命令集成到 flask-script 中，方便在命令行中进行操作。


#虚拟环境env http://www.cnblogs.com/chaosimple/p/4475958.html
# E:\下载\Flask_dome\myblog

# virtualenv env #创建

# env\Scripts\activate #激活

#deactivate 离开
