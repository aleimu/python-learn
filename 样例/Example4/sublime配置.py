创建项目和初始化{
#http://www.cnblogs.com/levelksk/p/6152893.html
pip3.4 install Django==1.8.6  #pip3.4 install Django==1.8.6 -i http://10.93.135.120/pypi/simple --trusted-host 10.93.135.120

django-admin startproject mysite	#创建一个初始化的项目文件结构，目录如下：

manage.py:一个实用的命令行，用来与你的项目进行交互。它是一个对django-admin.py工具的简单封装。你不需要编辑这个文件。
	mysite/:你的项目目录，由以下的文件组成：
	init.py:一个空文件用来告诉Python这个mysite目录是一个Python模块。
	settings.py:你的项目的设置和配置。里面包含一些初始化的设置。
	urls.py:你的URL模式存放的地方。这里定义的每一个URL都映射一个视图（view）。
	wsgi.py:配置你的项目运行如同一个WSGI应用。

python3.4 manage.py migrate 	#初始应用表将会在数据库中创建

python3.4 manage.py runserver 	#开启开发服务器

python3.4 manage.py runserver 10.175.102.179:8001 --settings=mysite.settings 	#定制的host和端口上运行开发服务

}


广泛涉猎时得到的兴趣点，可以带动学习，但边际效益表明这样的学习方式的收货会随着时间递减，自己的核心竞争力是需要对技术的再深入和磨练。一般通过大量的刷题+记录+快速迭代，可以不断的熟悉自己原先不熟的知识点，但真正的能力不是表面经验，而是对内部逻辑的反复理解而形成的习惯。

下周计划 学习pygame库

	"env": {"PATH":"C:\\go\\bin",
            //"GOPATH":"D:\\godemo\\centralGame",
            "GOROOT":"C:\\go"},

#my Go编译			
{
    "windows":
    {
        "cmd": "go run ${file}",
        "shell":true
    }


}

/*
#实例学习配置新编译系统
{
    "path": "D:\\CodeBlocks\\MinGW\\bin",
    "cmd": "g++ $file -o $file_base_name.exe",
    "file_regex": "^(..[^:]*):([0-9]+):?([0-9]+)?:? (.*)$",
    "working_dir": "$file_path",
    "selector": "source.c, source.c++",
    "shell": true,
    "variants":
    [
        {
           "name": "RUN",
           "cmd": "g++ $file -o $file_base_name.exe && start $file_base_name.exe"
        }
    ]
}
解释：

文件名：CPP.sublime-build意味着在sublime中按ctrl+shift+b的时候弹出来的编译选项的名字是CPP，理论上可以随便改啦
path:由于cmd执行程序(如g++)的时候默认会去环境变量中找，这个属性是直接来后面的路径去找，所以直接放进去g++.exe的所在目录就好
cmd:选择CPP后执行的命令（由系统执行，可以看成是在cmd中执行的效果），这里$后面被当做变量名解析
file_regex:正则式筛选cmd的debug信息回显
working_dir:这个挺舒服的，工作路径，如果填了F:\test就相当于cd F:\test这个意思，所以我们后面的文件名都相对路径就好了
selector:主要看后缀名，符合这些后缀名的文件将激活这个编译文档，这里把.c .cpp一块丢给g++就好
shell:是否弹出cmd窗口来运行程序，true的好处是可以输入参数
variants:这里面是CPP编译文档的副本，相当于备选编译选项，可以由多个备选，每个都用{}并列起来
name:编译选项的小名，如果写了RUN,按ctrl+shift+b的时候就会多出来一个CPP:RUN这样的编译选项；name只能在variants中写
cmd:此处的cmd可以覆盖外面的cmd；这里为了方便我把编译和运行写在同一句话了，如此按一下就和codeblocks里的F5(F9?不记得了...)一样爽，中间用&&连接

 */

 
 #Anaconda不显示框框
{"anaconda_linting": false} 


sublime用户配置{
#http://3ms.huawei.com/hi/blog/8909_1571239.html
{
	"color_scheme": "Packages/Color Scheme - Default/IDLE.tmTheme",
	"font_size": 11.0,
	"ignored_packages":
	[
		"Vintage"
	],
	"theme": "Soda Dark 3.sublime-theme",
	"update_check": false,
	"word_wrap": "auto",
	// 设置tab的大小为4
	"tab_size": 4,
	// 使用空格代替tab
	"translate_tabs_to_spaces": true,
	// 添加行宽标尺
	"rulers": [80, 100],
	// 显示空白字符
	"draw_white_space": "all",
	// 保存时自动去除行末空白
	"trim_trailing_white_space_on_save": true,
	// 保存时自动增加文件末尾换行
	"ensure_newline_at_eof_on_save": true,
}

}
