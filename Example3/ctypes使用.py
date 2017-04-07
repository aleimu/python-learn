刚学python，前几天在java中调用了win32api，给eclipse窗口来了个抖动，也想拿python实现下。
在网上找python调用win32api的资料，清一色的是win32api模块，我晕。
作为一个新手，我也知道python调用c还是很方便的，我也不想去sourceforge上下载模块安装，于是翻遍了google，
加上自己的“冷静思考，理性分析” 哈哈！！终于通过两种方法实现
摘录在此，以备本人以及其他python新人查阅
（我的环境是 python2.7）
这里我们实现的是：枚举所有窗口，输出窗口的titile

第一种，通过ctypes的windll,user32实现。
#coding=utf-8
from ctypes import *
from ctypes.wintypes import BOOL, HWND, LPARAM
#定义回调函数
@WINFUNCTYPE(BOOL, HWND, LPARAM)
def print_title(hwnd,extra):
    title = create_string_buffer(1024)
	#根据句柄获得窗口标题
    windll.user32.GetWindowTextA(hwnd,title,255)
    title = title.value
    if title!="":
        print title
    return 1
#枚举窗口
windll.user32.EnumWindows(print_title,0)
第二种方法，直接载入 user.dll
#coding=utf-8
from ctypes import *
from ctypes.wintypes import BOOL, HWND, LPARAM
#加载user32.dll
user32 = windll.LoadLibrary("user32")
#定义回调函数
@WINFUNCTYPE(BOOL, HWND, LPARAM)
def print_title(hwnd,extra):
    title = create_string_buffer(1024)
	#根据句柄获得窗口标题
    user32.GetWindowTextA(hwnd,title,255)
    title = title.value
    if title!="":
        print title
    return 1
	
#枚举窗口
user32.EnumWindows(print_title,0)
