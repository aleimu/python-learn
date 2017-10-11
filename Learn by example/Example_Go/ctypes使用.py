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
