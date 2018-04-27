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


#关于主题的几个博客
http://www.cnblogs.com/gotodsp/p/5769342.html
http://www.cnblogs.com/woodk/p/5120074.html
http://www.cnblogs.com/mengxiaotian/p/5327826.html
http://www.cnblogs.com/damens/p/6459912.html

#常用命令
Ctrl+P 打开搜索框。举个栗子：1、输入当前项目中的文件名，快速搜索文件，2、输入@和关键字，查找文件中函数名，3、输入：和数字，跳转到文件中该行代码，4、输入#和关键字，查找变量名。
Ctrl+Shift+P 打开命令框。场景栗子：打开命名框，输入关键字，调用sublime text或插件的功能，例如使用package安装插件。
Ctrl+Shift+/ 注释多行。

#常用主题控制插件
安装Package​Resource​Viewer插件后可以在控制台使用命令
PackageResourceViewer: Open Resource
从这个Package​Resource​Viewer插件打开你的主题文件，直接搜索sidebar【侧边栏】修改配置


#gosublime配置编译
	"env": {
		"PATH":"C:\\go\\bin",
            //"GOPATH":"D:\\godemo\\centralGame",
            "GOROOT":"C:\\go"
        	},

#my Go自定义编译
{
    "windows":
    {
        "cmd": "go run ${file}",
        "shell":true
    }

}


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

#解释：
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




 #Anaconda不显示框框
{"anaconda_linting": false}

#DocBlockr
通过DocBlockr插件可以快速地在代码中添加各种不同风格的注释。尝试在代码中输入"/*"或者"/**"，然后回车，DocBlockr会自动生成注释行。如果在函数体前面输入"/**" 类型的注释，DocBlockr还会自动生成函数的说明。

#sublime用户配置
#http://3ms.huawei.com/hi/blog/8909_1571239.html
{
    "color_scheme": "Packages/Color Scheme - Default/IDLE.tmTheme",
    "font_size": 11,
    "ignored_packages":
    [
        "Vintage"
    ],
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


#sublime 配置 Terminal cmder
在 packagecontrol.io 可以找到 Terminal 
在 cmder.net 下载 cmder
复制 Terminal.sublime-settings 文件到 C:\Users\WXG\AppData\Roaming\Sublime Text 3\Packages\User 目录下. 作如下修改:
{
    "terminal": "C:/wxg/tools/cmder_mini/Cmder.exe",
    "parameters": ["/START", "%CWD%"]
}
然后就可以在sublime下调用cmder了.
如果加上 "parameters": ["/START", "%CWD%"] -> 可以定位到当前打开文件所在的目录.



在 Preference  -> Setting-User的配置文件中输入
"theme": "Soda Light.sublime-theme"
"theme": "Soda Light 3.sublime-theme"

如果想要深色的就输入：
"theme": "Soda Dark.sublime-theme"
"theme": "Soda Dark 3.sublime-theme"

[
// QUICK PANEL
    {
        "class": "quick_panel_label",
        "fg": [50, 50, 50, 255],
        "match_fg": [243, 119, 34, 255],
        "selected_fg": [25, 25, 25, 255],
        "selected_match_fg": [243, 119, 34, 255]
    },
    {
        "class": "quick_panel_score_label",
        "fg": [0,170,170, 255],
        "selected_fg": [0,170,170, 255]
    }
]

Settings-User配置:
{
　　"theme": "Soda Light 3.sublime-theme",
　　"color_scheme": "Packages/Color Scheme - Default/IDLE.tmTheme",
　　"font_size": 11,
　　"ignored_packages":
　　[
　　"Vintage"
　　],
　　"show_encoding": true,
　　"soda_classic_tabs": true,
　　"soda_folder_icons": true,

　　"highlight_line": true, 　　   // 高亮显示当前行
　　"fade_fold_buttons": false,   // 代码折叠按钮一直显示
　　"show_encoding": true, 　　 // 显示当前文件的编码
　　"bold_folder_labels": true,   // 加粗文件夹名称
　　"highlight_modified_tabs": true,　　　　　　// 着重标示修改过的文件
　　"trim_trailing_white_space_on_save": true, // 保存时去掉行尾无用空格
　　"show_full_path": true, 　　　　　　　　　　// 显示全路径,默认
　　// "show_line_endings": true, 
　　// "draw_white_space": "all", 　　　　　　　// 显示所有空格，"none"|"selection"|"all"
　　// "sublime_enhanced_keybindings": true, // 转到上一次编辑的地方
　　// "word_wrap": true, 　　　　　　　　　　 // 文字根据屏幕大小自动换行，防止水平滚动 true | false | "auto"
　　// "save_on_focus_lost": true, 　　　　　　 // 焦点丢失后自动保存

}


以下是个人总结不完全的快捷键总汇，祝愿各位顺利解放自己的鼠标。

选择类

Ctrl+D 选中光标所占的文本，继续操作则会选中下一个相同的文本。

Alt+F3 选中文本按下快捷键，即可一次性选择全部的相同文本进行同时编辑。举个栗子：快速选中并更改所有相同的变量名、函数名等。

Ctrl+L 选中整行，继续操作则继续选择下一行，效果和 Shift+↓ 效果一样。

Ctrl+Shift+L 先选中多行，再按下快捷键，会在每行行尾插入光标，即可同时编辑这些行。

Ctrl+Shift+M 选择括号内的内容（继续选择父括号）。举个栗子：快速选中删除函数中的代码，重写函数体代码或重写括号内里的内容。

Ctrl+M 光标移动至括号内结束或开始的位置。

Ctrl+Enter 在下一行插入新行。举个栗子：即使光标不在行尾，也能快速向下插入一行。

Ctrl+Shift+Enter 在上一行插入新行。举个栗子：即使光标不在行首，也能快速向上插入一行。

Ctrl+Shift+[ 选中代码，按下快捷键，折叠代码。

Ctrl+Shift+] 选中代码，按下快捷键，展开代码。

Ctrl+K+0 展开所有折叠代码。

Ctrl+← 向左单位性地移动光标，快速移动光标。

Ctrl+→ 向右单位性地移动光标，快速移动光标。

shift+↑ 向上选中多行。

shift+↓ 向下选中多行。

Shift+← 向左选中文本。

Shift+→ 向右选中文本。

Ctrl+Shift+← 向左单位性地选中文本。

Ctrl+Shift+→ 向右单位性地选中文本。

Ctrl+Shift+↑ 将光标所在行和上一行代码互换（将光标所在行插入到上一行之前）。

Ctrl+Shift+↓ 将光标所在行和下一行代码互换（将光标所在行插入到下一行之后）。

Ctrl+Alt+↑ 向上添加多行光标，可同时编辑多行。

Ctrl+Alt+↓ 向下添加多行光标，可同时编辑多行。

编辑类

Ctrl+J 合并选中的多行代码为一行。举个栗子：将多行格式的CSS属性合并为一行。

Ctrl+Shift+D 复制光标所在整行，插入到下一行。

Tab 向右缩进。

Shift+Tab 向左缩进。

Ctrl+K+K 从光标处开始删除代码至行尾。

Ctrl+Shift+K 删除整行。

Ctrl+/ 注释单行。

Ctrl+Shift+/ 注释多行。

Ctrl+K+U 转换大写。

Ctrl+K+L 转换小写。

Ctrl+Z 撤销。

Ctrl+Y 恢复撤销。

Ctrl+U 软撤销，感觉和 Gtrl+Z 一样。

Ctrl+F2 设置书签

Ctrl+T 左右字母互换。

F6 单词检测拼写

搜索类

Ctrl+F 打开底部搜索框，查找关键字。

Ctrl+shift+F 在文件夹内查找，与普通编辑器不同的地方是sublime允许添加多个文件夹进行查找，略高端，未研究。

Ctrl+P 打开搜索框。举个栗子：1、输入当前项目中的文件名，快速搜索文件，2、输入@和关键字，查找文件中函数名，3、输入：和数字，跳转到文件中该行代码，4、输入#和关键字，查找变量名。

Ctrl+G 打开搜索框，自动带：，输入数字跳转到该行代码。举个栗子：在页面代码比较长的文件中快速定位。

Ctrl+R 打开搜索框，自动带@，输入关键字，查找文件中的函数名。举个栗子：在函数较多的页面快速查找某个函数。

Ctrl+： 打开搜索框，自动带#，输入关键字，查找文件中的变量名、属性名等。

Ctrl+Shift+P 打开命令框。场景栗子：打开命名框，输入关键字，调用sublime text或插件的功能，例如使用package安装插件。

Esc 退出光标多行选择，退出搜索框，命令框等。

显示类

Ctrl+Tab 按文件浏览过的顺序，切换当前窗口的标签页。

Ctrl+PageDown 向左切换当前窗口的标签页。

Ctrl+PageUp 向右切换当前窗口的标签页。

Alt+Shift+1 窗口分屏，恢复默认1屏（非小键盘的数字）

Alt+Shift+2 左右分屏-2列

Alt+Shift+3 左右分屏-3列

Alt+Shift+4 左右分屏-4列

Alt+Shift+5 等分4屏

Alt+Shift+8 垂直分屏-2屏

Alt+Shift+9 垂直分屏-3屏

Ctrl+K+B 开启/关闭侧边栏。

F11 全屏模式

Shift+F11 免打扰模式
