# 使用ctypes和pywin32访问原生API
# pywin32库里面最重要的两个模块：win32api和win32con。win32api顾名思义，就是用python对win32的本地api进行了封装；win32con个人理解为win32constant，即win32的常量定义
# 比自带的ctypes库好使用


#pip install pygame 后好像会下载pywin32 其中有不错的API文档 C:\Python36-32\Lib\site-packages\PyWin32.chm
#pywin32的文档不太全，好在C:\Python36-32\Lib\site-packages\pythonwin\pywin\Demos中有很多示例代码

# import webbrowser
# import win32api
# import win32gui
# import win32con
# import time

# #Define the url address
# url_baidu_home = "http://www.baidu.com/"
# url_baiduNews_tags = "http://news.baidu.com/"
# odw_baiduMusic_tags = "http://play.baidu.com/"
# odw_baiduXueshu_tags = "http://xueshu.baidu.com/"

# def maxWindow():
#     win32api.keybd_event(122,0,0,0) #F11
#     win32api.keybd_event(122,0,win32con.KEYEVENT_KEYUP,0) #Realize the F11 button

# def switchTab():
#     win32api.keybd_event(17,0,0,0) #Ctrl
#     win32api.keybd_event(9,0,0,0) #Tab
#     win32api.keybd_event(17,0,KEYEVENT_KEYUP,0) #Realize the Ctrl button
#     win32api.keybd_event(19,0,KEYEVENT_KEYUP,0) #Realize the Tab button

# hwnd = win32gui.GetForegroundWindow() #Get the 句柄
# win32gui.MoveWindow(hwnd,1980,0,1980,1080,False) #Move Window to the second screen
# maxWindow()
# count = 0
# while (count<1000):
#     switchTab()
#     time.sleep(3)
#     count=count+1

import win32api
import win32con

#我想用键盘输入 ve
win32api.keybd_event(0x56,0,0,0)     #v    0x56就是v的16进制数,可以是ASCII
win32api.keybd_event(0x45,0,0,0)     #e

#提示窗口
win32api.MessageBox(win32con.NULL, u'Python 你好！', u'你好', win32con.MB_OK)

#模拟按键有两个基本动作，即按下键和放开按键，所以我们每模拟一次按键就要调用两次该API函数，其方法是：
#按单个键
win32api.keybd_event(115,0,0,0)#F4键位码
win32api.keybd_event(115,0,win32con.KEYEVENTF_KEYUP,0)#释放按键

#组合键  'ALT+F4'键 关闭当前窗口
win32api.keybd_event(18,0,0,0) #alt键位码
win32api.keybd_event(115,0,0,0)#F4键位码
win32api.keybd_event(115,0,win32con.KEYEVENTF_KEYUP,0)
win32api.keybd_event(18,0,win32con.KEYEVENTF_KEYUP,0)



"""
#获取窗口的变化

import win32con,win32gui
class MyWindow():
    def __init__(self):
        #注册一个窗口类
        wc = win32gui.WNDCLASS()
        wc.lpszClassName = 'MyWindow'
        wc.hbrBackground = win32con.COLOR_BTNFACE+1 #这里颜色用法有点特殊，必须+1才能得到正确的颜色
        wc.lpfnWndProc = self.wndProc #可以用一个函数，也可以用一个字典
        class_atom=win32gui.RegisterClass(wc)
        #创建窗口
        self.hwnd = win32gui.CreateWindow(
            class_atom, u'窗口标题', win32con.WS_OVERLAPPEDWINDOW,
            win32con.CW_USEDEFAULT, win32con.CW_USEDEFAULT,
            win32con.CW_USEDEFAULT, win32con.CW_USEDEFAULT,
            0,0, 0, None)
        #显示窗口
        win32gui.ShowWindow(self.hwnd, win32con.SW_SHOWNORMAL)
    #消息处理
    def wndProc(self, hwnd, msg, wParam, lParam):
        if msg == win32con.WM_SIZE: print ('message: WM_SIZE')
        if msg == win32con.WM_PAINT: print ('message: WM_PAINT')
        if msg == win32con.WM_CLOSE: print ('message: WM_CLOSE')
        if msg == win32con.WM_DESTROY:
            print ('message: WM_DESTROY')
            win32gui.PostQuitMessage(0)
        return win32gui.DefWindowProc(hwnd, msg, wParam, lParam)
mw = MyWindow()
win32gui.PumpMessages()
"""


"""
# coding:utf8
# python实现全屏截图(win32)

import time
import os, win32gui, win32ui, win32con, win32api

def window_capture():
    hwnd = 0
    hwndDC = win32gui.GetWindowDC(hwnd)
    mfcDC=win32ui.CreateDCFromHandle(hwndDC)
    saveDC=mfcDC.CreateCompatibleDC()
    saveBitMap = win32ui.CreateBitmap()
    MoniterDev=win32api.EnumDisplayMonitors(None,None)
    w = MoniterDev[0][2][2]
    h = MoniterDev[0][2][3]
    print (w,h)
    saveBitMap.CreateCompatibleBitmap(mfcDC, w, h)
    saveDC.SelectObject(saveBitMap)
    saveDC.BitBlt((0,0),(w, h) , mfcDC, (0,0), win32con.SRCCOPY)
    bmpname=win32api.GetTempFileName(".","")[0]+'.bmp'
    saveBitMap.SaveBitmapFile(saveDC, bmpname)
    return bmpname

os.system(window_capture())

"""



"""
常用模拟键的键值对照表。

　　　　　　　　　　　　　　　　　　　　　　键盘键与虚拟键码对照表

　　　 　　字母和数字键　　　　 数字小键盘的键　　　　 　　功能键 　　　　　　　　其它键
　　　　　　键　　 键码　　　　　键　　 键码　　　　　　 键　　 键码 　　　　键　　　　　　键码
　　　　　　A　　　65　　　　　　 0 　　96 　　　　　　　F1 　　112 　　　　Backspace 　　　8
　　　　　　B　　　66　　　　　　 1　　 97 　　　　　　　F2 　　113　　　　 Tab 　　　　　　9
　　　　　　C　　　67 　　　　　　2 　　98 　　　　　　　F3 　　114　　　 　Clear 　　　　　12
　　　　　　D　　　68　　　　　　 3　　 99 　　　　　　　F4 　　115　　　 　Enter 　　　　　13
　　　　　　E　　　69 　　　　　　4 　　100　　　　　　　F5 　　116　　　 　Shift　　　　　 16
　　　　　　F　　　70 　　　　　　5 　　101　　　　　　　F6 　　117　　　 　Control 　　　　17
　　　　　　G　　　71 　　　　　　6　　 102　　　　　　　F7 　　118 　　 　 Alt 　　　　　　18
　　　　　　H　　　72 　　　　　　7 　　103　　　　　　　F8 　　119　　　 　Caps Lock 　　　20
　　　　　　I　　　73 　　　　　　8 　　104　　　　　　　F9 　　120　　　 　Esc 　　　　　　27
　　　　　　J　　　74 　　　　　　9　　 105　　　　　　　F10　　121　　　 　Spacebar　　　　32
　　　　　　K　　　75 　　　　　　* 　　106　　　　　　　F11　　122　　　 　Page Up　　　　 33
　　　　　　L　　　76 　　　　　　+ 　　107　　　　　　　F12　　123　　　 　Page Down 　　　34
　　　　　　M　　　77 　　　　　　Enter 108　　　　　　　-- 　　--　　　　　End 　　　　　　35
　　　　　　N　　　78 　　　　　　-　　 109　　　　　　　-- 　　-- 　　　 　Home　　　　　　36
　　　　　　O　　　79 　　　　　　. 　　110　　　　　　　--　　 -- 　　 　　Left Arrow　　　37
　　　　　　P　　　80 　　　　　　/ 　　111　　　　　　　--　　 -- 　　 　　Up Arrow　　　　38
　　　　　　Q　　　81 　　　　　　-- 　　--　　　　　　　--　　 -- 　　 　　Right Arrow 　　39
　　　　　　R　　　82 　　　　　　-- 　　--　　　　　　　--　　 -- 　　 　　Down Arrow 　　 40
　　　　　　S　　　83 　　　　　　-- 　　--　　　　　　　-- 　　-- 　　 　　Insert 　　　　 45
　　　　　　T　　　84 　　　　　　-- 　　--　　　　　　　--　　 -- 　　 　　Delete 　　　　 46
　　　　　　U　　　85 　　　　　　-- 　　--　　　　　　　-- 　　-- 　　 　　Help 　　　　　 47
　　　　　　V　　　86 　　　　　　--　　 --　　　　　　　-- 　　-- 　　 　　Num Lock 　　　 144
　　　　　　W　　　87 　　　　　　　　　
　　　　　　X　　　88 　　　　　
　　　　　　Y　　　89 　　　　　
　　　　　　Z　　　90 　　　　　
　　　　　　0　　　48 　　　　　
　　　　　　1　　　49 　　　　　
　　　　　　2　　　50 　　　　　　
　　　　　　3　　　51 　　　　　　
　　　　　　4　　　52 　　　　　　
　　　　　　5　　　53 　　　　　　
　　　　　　6　　　54 　　　　　　
　　　　　　7　　　55 　　　　　　
　　　　　　8　　　56 　　　　　　
　　　　　　9　　　57 　

ps:我没经过测试，待确认！
与键盘上各键对应的键值
在软件开发的过程中我们经常与键盘打交道，以下是我查MSDN 所得希望对各位有帮助。
可在代码中的任何地方用下列值代替键盘上的键：
值 描述
`
0x1 鼠标左键
0x2 鼠标右键
0x3 CANCEL 键
0x4 鼠标中键
0x8 BACKSPACE 键
0x9 TAB 键
0xC CLEAR 键
0xD ENTER 键
0x10 SHIFT 键
0x11 CTRL 键
0x12 MENU 键
0x13 PAUSE 键
0x14 CAPS LOCK 键
0x1B ESC 键
0x20 SPACEBAR 键
0x21 PAGE UP 键
0x22 PAGE DOWN 键
0x23 END 键
0x24 HOME 键
0x25 LEFT ARROW 键
0x26 UP ARROW 键
0x27 RIGHT ARROW 键
0x28 DOWN ARROW 键
0x29 SELECT 键
0x2A PRINT SCREEN 键
0x2B EXECUTE 键
0x2C SNAPSHOT 键
0x2D INSERT 键
0x2E DELETE 键
0x2F HELP 键
0x90 NUM LOCK 键
`
A 至 Z 键与 A - Z 字母的 ASCII 码相同：
值 描述
65 A 键
66 B 键
67 C 键
68 D 键
69 E 键
70 F 键
71 G 键
72 H 键
73 I 键
74 J 键
75 K 键
76 L 键
77 M 键
78 N 键
79 O 键
80 P 键
81 Q 键
82 R 键
83 S 键
84 T 键
85 U 键
86 V 键
87 W 键
88 X 键
89 Y 键
90 Z 键

0 至 9 键与数字 0 - 9 的 ASCII 码相同：
值 描述
48 0 键
49 1 键
50 2 键
51 3 键
52 4 键
53 5 键
54 6 键
55 7 键
56 8 键
57 9 键

下列常数代表数字键盘上的键：
值 描述
0x60 0 键
0x61 1 键
0x62 2 键
0x63 3 键
0x64 4 键
0x65 5 键
0x66 6 键
0x67 7 键
0x68 8 键
0x69 9 键
0x6A MULTIPLICATION SIGN (*) 键
0x6B PLUS SIGN (+) 键
0x6C ENTER 键
0x6D MINUS SIGN (-) 键
0x6E DECIMAL POINT (.) 键
0x6F DIVISION SIGN (/) 键

下列常数代表功能键：
值 描述
0x70 F1 键
0x71 F2 键
0x72 F3 键
0x73 F4 键
0x74 F5 键
0x75 F6 键
0x76 F7 键
0x77 F8 键
0x78 F9 键
0x79 F10 键
0x7A F11 键
0x7B F12 键
0x7C F13 键
0x7D F14 键
0x7E F15 键
0x7F F16 键

 键位查询

16进制：
    ‘backspace‘:0x08,
    ‘tab‘:0x09,
    ‘clear‘:0x0C,
    ‘enter‘:0x0D,
    ‘shift‘:0x10,
    ‘ctrl‘:0x11,
    ‘alt‘:0x12,
    ‘pause‘:0x13,
    ‘caps_lock‘:0x14,
    ‘esc‘:0x1B,
    ‘spacebar‘:0x20,
    ‘page_up‘:0x21,
    ‘page_down‘:0x22,
    ‘end‘:0x23,
    ‘home‘:0x24,
    ‘left_arrow‘:0x25,
    ‘up_arrow‘:0x26,
    ‘right_arrow‘:0x27,
    ‘down_arrow‘:0x28,
    ‘select‘:0x29,
    ‘print‘:0x2A,
    ‘execute‘:0x2B,
    ‘print_screen‘:0x2C,
    ‘ins‘:0x2D,
    ‘del‘:0x2E,
    ‘help‘:0x2F,
    ‘0‘:0x30,
    ‘1‘:0x31,
    ‘2‘:0x32,
    ‘3‘:0x33,
    ‘4‘:0x34,
    ‘5‘:0x35,
    ‘6‘:0x36,
    ‘7‘:0x37,
    ‘8‘:0x38,
    ‘9‘:0x39,
    ‘a‘:0x41,
    ‘b‘:0x42,
    ‘c‘:0x43,
    ‘d‘:0x44,
    ‘e‘:0x45,
    ‘f‘:0x46,
    ‘g‘:0x47,
    ‘h‘:0x48,
    ‘i‘:0x49,
    ‘j‘:0x4A,
    ‘k‘:0x4B,
    ‘l‘:0x4C,
    ‘m‘:0x4D,
    ‘n‘:0x4E,
    ‘o‘:0x4F,
    ‘p‘:0x50,
    ‘q‘:0x51,
    ‘r‘:0x52,
    ‘s‘:0x53,
    ‘t‘:0x54,
    ‘u‘:0x55,
    ‘v‘:0x56,
    ‘w‘:0x57,
    ‘x‘:0x58,
    ‘y‘:0x59,
    ‘z‘:0x5A,
    ‘numpversion.infoad_0‘:0x60,
    ‘numpad_1‘:0x61,
    ‘numpad_2‘:0x62,
    ‘numpad_3‘:0x63,
    ‘numpad_4‘:0x64,
    ‘numpad_5‘:0x65,
    ‘numpad_6‘:0x66,
    ‘numpad_7‘:0x67,
    ‘numpad_8‘:0x68,
    ‘numpad_9‘:0x69,
    ‘multiply_key‘:0x6A,
    ‘add_key‘:0x6B,
    ‘separator_key‘:0x6C,
    ‘subtract_key‘:0x6D,
    ‘decimal_key‘:0x6E,
    ‘pide_key‘:0x6F,
    ‘F1‘:0x70,
    ‘F2‘:0x71,
    ‘F3‘:0x72,
    ‘F4‘:0x73,
    ‘F5‘:0x74,
    ‘F6‘:0x75,
    ‘F7‘:0x76,
    ‘F8‘:0x77,
    ‘F9‘:0x78,
    ‘F10‘:0x79,
    ‘F11‘:0x7A,
    ‘F12‘:0x7B,
    ‘F13‘:0x7C,
    ‘F14‘:0x7D,
    ‘F15‘:0x7E,
    ‘F16‘:0x7F,
    ‘F17‘:0x80,
    ‘F18‘:0x81,
    ‘F19‘:0x82,
    ‘F20‘:0x83,
    ‘F21‘:0x84,
    ‘F22‘:0x85,
    ‘F23‘:0x86,
    ‘F24‘:0x87,
    ‘num_lock‘:0x90,
    ‘scroll_lock‘:0x91,
    ‘left_shift‘:0xA0,
    ‘right_shift ‘:0xA1,
    ‘left_control‘:0xA2,
    ‘right_control‘:0xA3,
    ‘left_menu‘:0xA4,
    ‘right_menu‘:0xA5,
    ‘browser_back‘:0xA6,
    ‘browser_forward‘:0xA7,
    ‘browser_refresh‘:0xA8,
    ‘browser_stop‘:0xA9,
    ‘browser_search‘:0xAA,
    ‘browser_favorites‘:0xAB,
    ‘browser_start_and_home‘:0xAC,
    ‘volume_mute‘:0xAD,
    ‘volume_Down‘:0xAE,
    ‘volume_up‘:0xAF,
    ‘next_track‘:0xB0,
    ‘previous_track‘:0xB1,
    ‘stop_media‘:0xB2,
    ‘play/pause_media‘:0xB3,
    ‘start_mail‘:0xB4,
    ‘select_media‘:0xB5,
    ‘start_application_1‘:0xB6,
    ‘start_application_2‘:0xB7,
    ‘attn_key‘:0xF6,
    ‘crsel_key‘:0xF7,
    ‘exsel_key‘:0xF8,
    ‘play_key‘:0xFA,
    ‘zoom_key‘:0xFB,
    ‘clear_key‘:0xFE,
    ‘+‘:0xBB,
    ‘,‘:0xBC,
    ‘-‘:0xBD,
    ‘.‘:0xBE,
    ‘/‘:0xBF,
    ‘`‘:0xC0,
    ‘;‘:0xBA,
    ‘[‘:0xDB,
    ‘//‘:0xDC,
    ‘]‘:0xDD,
    "‘":0xDE,
    ‘`‘:0xC0}
""
