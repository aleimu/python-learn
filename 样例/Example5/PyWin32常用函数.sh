win32{

>>> from win32 import *
>>> dir(win32)
['__doc__', '__loader__', '__name__', '__package__', '__path__', '__spec__']
>>> help(win32)
Help on package win32:

NAME
    win32

PACKAGE CONTENTS
    _win32sysloader
    _winxptheme
    mmapfile
    odbc
    perfmon
    servicemanager
    timer
    win2kras
    win32api
    win32clipboard
    win32console
    win32cred
    win32crypt
    win32event
    win32evtlog
    win32file
    win32gui
    win32help
    win32inet
    win32job
    win32lz
    win32net
    win32pdh
    win32pipe
    win32print
    win32process
    win32profile
    win32ras
    win32security
    win32service
    win32trace
    win32transaction
    win32ts
    win32wnet
    winxpgui

FILE
    (built-in)
}

# Win32gui: Windows图形界面接口模块。主要负责操作窗口切换以及窗口中元素id标签的获取
# Win32api: Windows开发接口模块。主要负责模拟键盘和鼠标操作,对win32gui获取的标签进行点击/获取值/修改值等操作
# Win32con:全面的库函数，提供Win32gui和Win32api需要的操作参数
# http://www.cnblogs.com/jiyirain/p/6742671.html

Win32gui 函数{

1. FindWindow
hld=win32gui.FindWindow(ClassName,Title)
ClassName:窗口的类名
Title:窗口的标题名称,即左上角的文字描述信息
hld:返回结果为当前窗口的句柄信息,

以下是使用AutoItv3抓取的Windows【另存为】窗口信息：
hld=win32gui.FindWindow("#32770",u"另存为")
Title:     另存为  #这里就是上面的Title
Class:   #32770 #这里就是上面的ClassName
Position:      0, 0
Size:     680, 480
Style:   0x96CC02C4
ExStyle:      0x00010101
Handle: 0x001E03A0 #这里就是上面函数返回值

2. SetForegroundWindow
win32gui.SetForegroundWindow(hld)
hld：为上面获取到的窗口句柄信息
主要用于激活该窗口,此时窗口会是最前面一层
在找到窗口句柄后，需要先将窗口设置为最前面一层才能模拟鼠标键盘操作当前窗口上的元素。

3. FindWindowEx
win32gui. FindWindowEx(hld,Child, ClassName, Title)
hld：目标窗口的父窗口，也是上面获取到的窗口句柄信息。通过父向下找子
Child：目标窗口的子窗口。通过子向上找父，从而找到目标窗口
ClassName：目标窗口的类名
Title：目标窗口的标题名称,即文字描述信息

以下是使用AutoItv3抓取的Windows【另存为】窗口的【保存】按钮信息：
button=win32gui.FindWindowEx(hld,None, "Button",None)
Class:   Button #这里就是上面的ClassName
Instance:    1
ClassnameNN:   Button1
Name:
Advanced (Class):    [CLASS:Button; INSTANCE:1]
ID: 1
Text:    保存(&S)  #这里就是上面的Title
Position:      459, 400
Size:     88, 30
ControlClick Coords: 45, 26
Style:   0x50030000
ExStyle:      0x00000004
Handle: 0x000C12A2 #这里就是上面函数返回值

4. GetDlgItem
button=win32gui.GetDlgItem(hld,ID)
hld：目标窗口的父窗口，也是上面获取到的窗口句柄信息。通过父向下找子
ID: 目标窗口ID
上面的例子，使用ID来抓取Windows【另存为】窗口的【保存】按钮信息为:
button=win32gui. GetDlgItem (hld,1)
注：需要确保，多次打开窗口时目标窗口ID是不变的，才能准确获取目标窗口句柄

5. SendMessage
SendMessage(hWnd, Msg, wParam, lParam)
hWnd：接收消息的窗体句柄
Msg：要发送的消息，这些消息都是windows预先定义好的，可以参见系统定义消息（System-Defined Messages）
wParam：消息的wParam参数
lParam：消息的lParam参数
注：系统定义消息中不同消息分别有相应的参数：wParam和lParam，可查询官网参数详情:
https://msdn.microsoft.com/en-us/library/windows/desktop/ms646280(v=vs.85).aspx
以 WM_KEYDOWN消息 为例：
wParam：虚拟键参数
lParam：重复次数
win32gui.SendMessage(hld,win32con.WM_KEYDOWN, win32con.VK_RETURN, 0)
                                                                        Enter键            重复0次
【另存为】窗口点击【保存】按钮的方法：
1）方法1：发送消息目标à【保存】按钮；动作à点击
win32gui.SendMessage(button,win32con.BM_CLICK) # win32con后面会解释
2）方法2：发送消息目标à整个窗口；动作à按键按下；动作参数àEnter键；前提à窗口聚焦默认在【保存】按钮时
win32gui.SendMessage(hld,win32con.WM_KEYDOWN, win32con.VK_RETURN, 0)
win32gui.PostMessage(hld,win32con.WM_KEYDOWN, win32con.VK_RETURN, 0)
为什么PostMessage成功了SendMessage失败了？

6. PostMessage
PostMessage(hWnd, Msg, wParam, lParam)
参数和使用方法同SendMessage。
不同的是，PostMessage只将消息放入待执行消息队列，不等待处理和返回，只要放入队列即算执行完毕。而SendMessage需要等待执行处理完后，才继续，返回的是其他程序处理后的返回值。

7. GetWindowRect
left,top,right,bottom=win32gui.GetWindowRect(hld)
获取某元素hld位置。left,top分别指与屏幕左上角距离，right,bottom 指长和高。

8. MoveWindow
win32gui.MoveWindow(hld,  int X, int Y, int nWidth, int nHeight, BOOL bRepaint )
移动某窗口hld到指定位置。
x,y指与屏幕左上角距离，nWidth, nHeight 指长和高
bRepaint ：是否重绘

9. GetCursorPos
POS =win32gui. GetCursorPos()
获取当前鼠标点击的窗口元素的坐标

10. WindowFromPoint
edit=win32gui.WindowFromPoint(POS)
获取包含指定点的窗口句柄，即根据坐标获取元素句柄
以上坐标和鼠标操作应用场景：【另存为】页面修改文件名
edit=win32gui.FindWindEx(hld,None,"Edit",None)
edit=win32gui. GetDlgItem (hld,1001)
以上均定位失败，使用鼠标和坐标位移方法获取文件名输入框的句柄
hld=win32gui.FindWindow(u'#32770',u"另存为")
win32gui.SetForegroundWindow(hld)
#为保证每次打开时目标框所在屏幕坐标不变，在这里将另存为窗口坐标和大小写死
win32gui.MoveWindow(hld,0,0,798,537,False)
win32api.SetCursorPos((200,355))
edit=win32gui.WindowFromPoint(200,355)
win32api.SendMessage(edit,win32con.WM_SETTEXT,None,"abc")
}

Win32api函数{

#SendMessage  PostMessage  GetCursorPos等win32api与win32gui均包含的函数，用法也相同。

1. keybd_event
keybd_event(bVk, bScan, dwFlags , dwExtraInfo)
 bVk:为按键的虚拟键值，如回车键为vk_return, tab键为vk_tab其他键值具体参考如下：
（注意转换16进制）
https://msdn.microsoft.com/en-us/library/dd375731(v=vs.85).aspx
bScan：为扫描码，一般不用设置，用0代替就行
dwFlags：为选项标志，如果为keydown则置0即可，如果为keyup则设成"KEYEVENTF_KEYUP"
dwExtraInfo：点击键关联的附加数据，一般置0即可
win32api.keybd_event(18,0,0,0) #按下ALT键，按下后不会弹起
win32api.keybd_event(18,0, win32con.KEYEVENTF_KEYUP,0) #手动点上键结束点击

2. mouse_event
mouse_event( dwFlags, dx, dy, cButtons, dwExtraInfo)
dwFlags：控制鼠标移动和点击按钮的各个方面。可以是下列值的某些组合：MOUSEEVENTF_ABSOLUTE,MOUSEEVENTF_LEFTDOWN,MOUSEEVENTF_MIDDLEUP等
dx:鼠标的位置沿x轴的位移
dy：鼠标的位置沿y轴的位移
cButtons: 与鼠标事件关联的附加值，在这里不关注
dwExtraInfo: 与鼠标事件关联的附加值，在这里不关注
win32api.mouse_event(win32con.MOUSEEVENTF_LEFTDOWN,0,0) #鼠标左键按下
win32api.mouse_event(win32con.MOUSEEVENTF_LEFTUP,0,0) #鼠标左键拾起

3. SetCursorPos
win32api.SetCursorPos(x,y)
将光标移到屏幕坐标（x,y）处

4. RegOpenKey
win32api.RegOpenKey(hKey,ipSubKey,phkResult)
打开给定键，一般是打开一个现有的注册表项
hKey ：要打开键的句柄，即注册表最外层名称
lpSubKey：要打开的项名，即项具体路径名称
phkResult：指定一个变量，用于装载（保存）打开注册表项的一个句柄
打开endpoint注册表：
endpoint_key=win32api.RegOpenKey(win32con.HKEY_LOCAL_MACHINE,'SOFTWARE\Ixia Communications\Endpoint',0, win32con.KEY_READ) #最后一个参数指权限为读

5. RegQueryValueEx
win32api.RegQueryValueEx(hKey, lpValueName, lpReserved, lpType, lpData, lpcbData)
检索一个已打开的注册表句柄中，指定的注册表键的类型和设置值。
HKEY hKey:一个已打开项的句柄，即RegOpenKey打开的注册表项的句柄
LPCTSTR lpValueName：要查询注册表键值的名字字符串，注册表键的名字，以空字符结束。
LPDWORD lpReserved：未用，设为零
LPDWORD lpType：用于装载取回数据类型的一个变量
LPBYTE lpData：用于装载指定值的一个缓冲区
LPDWORD lpcbData：用于装载lpData缓冲区长度的一个变量。 //一旦返回，它会设为实际装载到缓冲区的字节数
install_path = win32api.RegQueryValueEx(endpoint_key,'Installation Directory')
如图最终根据键值名字' Installation Directory'得到返回值 'C:\Program Files\Ixia\Endpoint\'RegCloseKeyRegCloseKey(hKey)
不使用时，关闭注册表。
win32api.RegCloseKey(endpoint_key)
}

Win32con 函数{
#Win32con函数一般作为win32gui win32api的参数调用。其参数命名可以这样理解：Obj_Opt

1. WM_COMMAND
win32api.SendMessage(hld, win32con.WM_COMMAND, (9<<16)+ctrl_id, vHandle)
发送命令(9<<16)+ctrl_id 给窗口hld，命令要操作的窗口对象是vHandle
WM_XXXXXX：Window Message即窗口消息对应的操作

2. CB_GETCOUNT
count=win32api.SendMessage(vHandle, win32con.CB_GETCOUNT,0,0)
# vHandle是一个ComboBox, 通过发送CB_GETCOUNT消息获取的此下拉列表框可选值个数
CB_XXXXXX：ComboBox对象对应的操作

3. HKEY_LOCAL_MACHINE
endpoint_key=win32api.RegOpenKey(win32con.HKEY_LOCAL_MACHINE,'SOFTWARE\Ixia Communications\Endpoint',0, win32con.KEY_READ)
HKEY_CLASSES_ROOT
HKEY_CURRENT_CONFIG
HKEY_CURRENT_USER
HKEY_LOCAL_MACHINE
HKEY_USERS
HKEY_XXXXXX:注册表对应的操作

4. KEY_ALL_ACCESS
xml_key = win32api.RegOpenKey(win32con.HKEY_LOCAL_MACHINE,'SOFTWARE\\Microsoft\\Office\\MSXML60',0, win32con.KEY_ALL_ACCESS)
KEY_XXXXXX:理解为附加参数。在这里指打开注册表权限为全部

5. KEYEVENTF_KEYUP
win32api.keybd_event(69,0,win32con.KEYEVENTF_KEYUP,0)
按键松开

6. BM_CLICK
win32gui.SendMessage(btn1,win32con.BM_CLICK,None,None)
BM_XXXXXX:Button按键对应的操作

7. MOUSEEVENTF_LEFTDOWN
win32api.mouse_event(win32con.MOUSEEVENTF_LEFTDOWN,0,0)
MOUSEEVENTF_XXXXXX：鼠标对应的操作

8. VK_RETURN
win32gui.PostMessage(nuSerWindowHandle,win32con.WM_KEYDOWN, win32con.VK_RETURN, 0)
VK_XXXXXX:键盘按键操作，后跟键名称,return指回车键
}

常用键值对照表{
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
}

黑客常用WinAPI函数整理{
黑客常用WinAPI函数整理
 
之前的博客写了很多关于Windows编程的内容，在Windows环境下的黑客必须熟练掌握底层API编程。为了使读者对黑客常用的Windows API有个更全面的了解以及方便日后使用API方法的查询，特将这些常用的API按照7大分类进行整理如下，希望对大家的学习有所帮助。
一、进程
创建进程：
CreateProcess("C:\\windows\\notepad.exe",0,0,0,0,0,0,0,&si,&pi);
WinExec("notepad",SW_SHOW);
ShellExecute(0,"open","notepad","c:\\a.txt","",SW_SHOW);
ShellExecuteEx(&sei);
遍历进程：
CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
Process32First(hsnap,&pe32);
Process32Next(hsnap,&pe32);
终止进程：
ExitProcess(0);
TerminateProcess(hProc,0);
打开进程：
OpenProcess(PROCESS_ALL_ACCESS,0,pid);\
获取进程ID：
GetCurrentProcesssId();
获取进程可执行文件路径：
GetModuleFileName(NULL,buf,len);
GetProcessImageFileName(hproc,buf,len);
遍历进程模块信息：
CreateToolhelp32Snapshot(TH32CS_SNAPMODILE,pid);
Module32First(hsnap,&mdl32);
Module32Next(hsnap,&mdl2);
获取指定模块句柄：
GetModuleHandle(“kernel32.dll”);
获取模块内函数地址：
GetProcessAddr(hmdl,”MessageBox”);
动态加载DLL：
LoadLibrary(“user32.dll”);
卸载DLL：
FreeLibrary(hDll);
获取进程命令行参数：
GetCommandLine();
任何进程GetCommandLine函数地址后偏移一个字节后的4字节地址为命令行地址。
读写远程进程数据：
ReadProcessMemory(hproc,baseAddr,buf,len,&size);
WriteProcessMemory(hproc,baseAddr,buf,len,&size);
申请内存：
VirtualAlloc(0,size,MEM_COMMIT, PAGE_EXECUTE_READWRITE);
VirtualAllocEx(hproc,0,size,MEM_COMMIT, PAGE_EXECUTE_READWRITE);
修改内存属性：
VirtualProtect(addr,size,PAGE_EXECUTE_READWRITE,&oldAddr);
VirtualProtectEx(hproc,addr,size,PAGE_EXECUTE_READWRITE,&oldAddr);
释放内存：
VirtualFree( addr, size, MEM_RELEASE);
VirtualFreeEx(hproc, addr, size, MEM_RELEASE);
获取系统版本(Win NT/2K/XP<0x80000000)：
getVersion();
读写进程优先级：
SetPriorityClass(hproc,Normal);
GetPriority(hproc);
SetProcessPriorityBoost(hproc,true);
GetProcessPriorityBoost(hproc,pBool);

二、线程
创建线程(CreateThread的线程函数调用了strtok、rand等需使用_endthread()释放内存)：
CreateThread(0,0,startAddr,&para,0,&tid);
_beginthread(startAddr,0,0);
_beginthreadex(0,0,startAddr,0,0,&tid);
CreateRemoteThread(hproc,0,0,func,&para,0,&tid);
获取线程ID：
GetCurrentThreadId();
关闭线程句柄（减少内核对象使用次数，防止内存泄漏）：
CloseHandle(hthread);
挂起与激活线程(维护暂停次数)：
SuspendThread(hthread);
ResumeThread(hthread);
获取线程退出代码：
GetExitCode(hthread,&code);
等待线程退出(线程受信状态或超时)：
WaitForSignleObject(htread,1000);
WaitForMultipleObjects(num,handles,true,INFINITE);
遍历线程：
CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD,0);
Thread32First(hsnap,&mdl32);
Thread32Next(hsnap,&mdl2);
获取线程函数入口：
ZwQueryInfomationThread(hthread,ThreadQuerySetWin32StartAddress,&buf,4,NULL);
打开线程：
OpenThread(THREAD_ALL_ACCESS,false,&tid);
获取线程函数地址所属模块：
GetMappedFileName(hproc,addr,buf,256);
读写线程优先级：
SetThreadPriority(hthread,Normal);
GetThreadPriority(hthread);
SetThreadPriorityBoost(hproc,true);
GetThreadPriorityBoost(hproc,pBool);
终止线程：
ExitThread(5);
TerminateThread(hthread,5);
线程同步临界区对象：
InitializeCriticalSection(&cs);
EnterCriticalSection(&cs);
LeaveCriticalSection(&cs);
DeleteCriticalSection(&cs);
线程同步事件内核对象：
OpenEvent(EVENT_ALL_ACCESS,false,name);
CreateEvent(NULL,false,true,NULL);
WaitForSingleObject(hevnt,INFINITE);
SetEvent(hevnt);
ResetEvent(hevnt);
线程同步互斥内核对象：
CreateMutex(NULL,false,NULL);
WaitForSingleObject(hmutex,INFINITE);
ReleaseMutex(hmutex);
OpenMutex(MUTEX_ALL_ACCESS,false,name);

三、注册表
创建键：
RegCreateKeyEx(HKEY_CURRENT_USER,”TestNewKey”,0,0,REG_OPTION_VOLATILE,KEY_ALL_ACCESS,0,&subkey,&state);
打开键：
RegCreateKeyEx(HKEY_CURRENT_USER,”Control Panel”,0,KEY_ALL_ACCESS,&subkey);
关闭键：
RegCloseKey(hkey);
遍历键：
RegEnumKeyEx(hsubkey,index,keyname,&nameSize,0,0,0,&time);
FileTimeToSystemTime(&time,&systime);
RegQueryInfo(hsubkey,0,0,0,&count,0,0,0,0,0,0,0);
删除键：
RegDeleteKeyEx(hmainkey,subkeyName);
创建值：
RegSetValueEx(hsubkey,”test”,0,REG_WORD,(BYTE*)&value,4);
遍历值：
RegEnumValue(hsubkey,index,name,&nameSize,0,&type,valuebuf,valueLen);
RegQueryValueEx(hsubkey,name,0,type,buf,&size);
删除值：
RegDeleteValue(hsubkey,valuename);

四、文件
创建/打开文件：
CreateFile(“a.txt”,GENERIC_READ|GENERIC_WRITE,FILE_SHARE_READ,0,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
设置文件指针：
SetFilePointer(hFile,0,NULL,FILE_END);
读写文件：
ReadFile(hFile,buf,len,&size,0);
WriteFile(hFile,buf,len,&size,0);
强制文件写入磁盘，清空文件高速缓冲区：
FlushFileuffers(hFile);
[解]锁文件区域：
LockFile(hFile,0,0,100,0);
UnlockFile(hFile,0,0,100,0);
复制文件：
CopyFile(src,des,true);
CopyFileEx(src,des,func,&para,false, COPY_FILE_FAIL_IF_EXISTS);
移动文件：
MoveFile(src,des);
MoveFileEx(src,des,false);
MoveFileWithProgress(src,des,fun,&para, MOVEFILE_COPY_ALLOWED);
删除文件：
DeleteFile(filename);
获取文件类型(FILE_TYPE_PIPE)：
GetFileType(hFile);
获取文件大小：
GetFileSize(hFile,&high);
获取文件属性(例如FILE_ATTRIBUTE_DIRECTORY进行&运算)：
GetFileAttributes(hFile);
遍历文件：
FindFirstFile(nameMode,&wfd);
FindNextFile(hFile,&wfd);
创建管道：
CreatePipe(&hRead,&hWrite,&sa,0);
创建内存映射文件：
CreateFile(“d:\\a.txt”,GENERIC_READ|GENERIC_WRITE,FILE_SHARE_READ,0,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,”myMap”);
加载内存映射文件：
MapViewOfFile(hmap,FILE_MAP_ALL_ACCESS,0,0,0);
打开内存映射文件：
OpenFileMapping(FILE_AMP_ALL_ACCESS,false,”myMap”);
卸载内存映射文件：
UnmapViewOfFile(baseAddr);
强制写入内存映射文件到磁盘：
FlushViewOfFile(baseAddr,len);
创建文件夹(只能创建一层)：
CreateDirectory(“D:\\a”,NULL);
CreateDirectory(“C:\\a”,”D:\\b”,NULL);
删除文件夹(只能删除空文件夹)：
RemoveDirectory(“C:\\a”);
检测逻辑驱动器：
GetLogicalDrives();
GetLogicalDriveStrings(len,buf);
获取驱动器类型(DRIVE_CDROM)：
GetDriveType(“D:\\”);

五、网络
打开网络资源枚举过程（winnetwk.h、Mpr.lib）：
WNetOpenEnum(RESOURCE_GLOBAL,RESOURCETYPE_ANY,0,NULL,hnet);
枚举网络资源：
WNetEnumResource(hnet,&count,pNetRsc,&size);
关闭网络资源枚举过程：
WNetCloseEnum(hnet);
打开关闭WinSocket库：
WSAStartup(version,&wsa);
WSACleanup();
创建套接字：
socket(AF_INET,SOCK_STREAM,IPPROTO_TCP);
绑定套接字IP和端口：
bind(sock,&addr,len);
监听TCP连接：
listen(sock,10);
接收TCP连接请求：
accept(sock,&addr,&len);
客户端连接：
connect(sock,&addr,len);
发送TCP数据：
send(sock,buf,len,0);
接收TCP数据：
recv(sock,buf,len,0);
发送UDP数据：
sendto(sock,buf,len,0,&addr,len);
接收UDP数据：
recvfrom(sock,buf,len,0,&addr,&len);

六、服务
打开SCM服务控制管理器：
OpenSCManager(NULL,NULL,SC_MANAGER_ALL_ACCESS);
创建服务：
CreateService(mgr,"MyService"," MyService",SERVICE_ALL_ACCESS,       SERVICE_WIN32_OWN_PROCESS,SERVICE_AUTO_START,SERVICE_ERROR_IGNORE,path,NULL,NULL,NULL,NULL,NULL);
打开服务对象：
OpenService(mgr," MyService ",SERVICE_START);
启动服务：
StartService(serv,0,NULL);
查询服务状态：
QueryServiceStatus(serv,&state);
关闭服务句柄：
CloseServiceHandle(hdl);
连接到SCM：
StartServiceCtrlDispatcher(DispatchTable);
注册服务控制函数：
RegisterServiceCtrlHandler("MyServicer",ServiceCtrl);
设置服务状态：
SetServiceStatus(hss,&ServiceStatus);
控制服务：
ControlService(serv,SERVICE_CONTROL_STOP,&state);
删除服务：
DeleteService(serv);
遍历服务：
EnumServicesStatus(hscm,SERVICE_WIN32|SERVICE_DRIVER,SERVICE_STATE_ALL,&srvSts,len,&size,&count,NULL);
查询服务配置：
QueryServiceConfig(hserv,&srvcfg,size,&size);

七、消息
发送消息：
SendMessage(HWND_BROADCAST,WM_LBUTTONDOWN,0,0);
接收消息：
GetMessage(&msg,NULL,0,0);
投递消息：
PostMessage(HWND_BROADCAST,WM_LBUTTONDOWN,0,0);
获取消息：
PeekMessage(&msg,NULL,0,0);
转换消息：
TranslateMessage (&msg);
分发消息：
DispatchMessage (&msg);
等待消息：
WaitMessage();
发送退出消息：
PostQuitMessage(0);
安装消息钩子：
SetWindowsHookEx(WH_KEYBOARD,keyBoardProc,0,tid);
卸载消息钩子：
UnhookWindowsHookEx(hhk);

以上是作者目前就相关技术所接触的最常用的一批API函数，这肯定不是最完整的，但是都是博主从一份份资料中挖掘出来的，也希望读者能多多补充，相互进步！
}

例子{

1.通过类名和标题查找窗口句柄，并获得窗口位置和大小

import win32gui
import win32api
classname = "MozillaWindowClass"
titlename = "百度一下，你就知道 - Mozilla Firefox"
#获取句柄
hwnd = win32gui.FindWindow(classname, titlename)
#获取窗口左上角和右下角坐标
left, top, right, bottom = win32gui.GetWindowRect(hwnd)

2.通过父句柄获取子句柄

def get_child_windows(parent):        
    '''     
    获得parent的所有子窗口句柄
     返回子窗口句柄列表
     '''     
    if not parent:         
        return      
    hwndChildList = []     
    win32gui.EnumChildWindows(parent, lambda hwnd, param: param.append(hwnd),  hwndChildList)          
    return hwndChildList 

#获取某个句柄的类名和标题
title = win32gui.GetWindowText(hwnd)     
clsname = win32gui.GetClassName(hwnd)     

#获取父句柄hwnd类名为clsname的子句柄
hwnd1= win32gui.FindWindowEx(hwnd, None, clsname, None)

3.鼠标定位与点击

#鼠标定位到(30,50)
win32api.SetCursorPos([30,150])
#执行左单键击，若需要双击则延时几毫秒再点击一次即可
win32api.mouse_event(win32con.MOUSEEVENTF_LEFTUP | win32con.MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
#右键单击
win32api.mouse_event(win32con.MOUSEEVENTF_RIGHTUP | win32con.MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0)

4.发送回车键

win32api.keybd_event(13,0,0,0)
win32api.keybd_event(13,0,win32con.KEYEVENTF_KEYUP,0)
5.关闭窗口

win32gui.PostMessage(win32lib.findWindow(classname, titlename), win32con.WM_CLOSE, 0, 0)
}
