import os
import sys
import base64
import hashlib
import tkinter as tk

def main():
    root = tk.Tk() # 这里
    #fix the root window size
    root.minsize(380, 530)
    root.maxsize(380, 530) #这里主要是控制窗口的大小，让窗口大小不能改变
    #root.geometry("1366x250")
    root.title('Bin_LmmH_C Decoder') #设置主窗口的标题
    #display the quit button
    text = edit(root)        #
    l = tk.Label(root, text='My name is Bin_LmmH_C', fg='white', bg='black', width=30)
    l.grid(sticky=tk.E+tk.W+tk.S+tk.N)
    button(root, text)
    #quitbutton(root)
    root.mainloop()   # 这里进入顶层窗口的循环
	

#build the edit and result Text，建立两个edit控件
def edit(root):
    edit = tk.Text(root, fg='white', bg='green', font='微软雅黑', width=30, height=10,)
    edit.grid(sticky=tk.N+tk.E+tk.W)

    #button 传递参数使用lambda函数
    #delete all the value in the text editor
    clear1 = tk.Button(root, text='Clear', width=27, bg='yellow', font='微软雅黑', command=lambda :edit.delete(1.0, tk.END))
    clear1.grid()

    result = tk.Text(root, fg='white', bg='green', font='微软雅黑', width=30, height=10,)
    result.grid(sticky=tk.N+tk.E+tk.W)

    #button 传递参数使用lambda函数
    #delete all the value in the text editor
    clear2 = tk.Button(root, text='Clear', width=27, bg='yellow', font='微软雅黑', command=lambda :result.delete(1.0, tk.END))
    clear2.grid()
    text = [edit, result]
    return text

#这里定义窗口中所有的按钮控件，并且显示出来，并且设置好每个按钮的响应函数，使用button的command选项来控制
def button(root, text):
    clu = 0
    b64en = tk.Button(root, text='Base64 Encode', fg='white', bg='green', command=lambda :b64encode(text))
    b64de = tk.Button(root, text='Base64 Decode', fg='white', bg='green', command=lambda :b64decode(text))
    b32en = tk.Button(root, text='Base32 Encode', fg='white', bg='green', command=lambda :b32encode(text))
    b32de = tk.Button(root, text='Base32 Decode', fg='white', bg='green', command=lambda :b32encode(text))
    md5do = tk.Button(root, text='-Md5  Creator-', fg='white', bg='green', command=lambda :md5create(text))
    but = [b64en, b64de, b32en, b32de, md5do]
    for i in but:
        i.grid(row=clu, column=1, sticky=tk.N+tk.S+tk.E+tk.W)
        clu += 1
    return but

def b64encode(text):
    #print(len(text), text)
    edit, result = text[0], text[1]
    enc = edit.get(1.0,tk.END)
    try:
        res = base64.b64encode(enc[0:-1].encode('ascii'))
        #print("res = ", res)
    except:
        return False
    result.insert(1.0, res.decode('ascii'))
    return True

def b64decode(text):
    #print(len(text), text)
    edit, result = text[0], text[1]
    dec = edit.get(1.0,tk.END)
    try:
        res = base64.b64decode(dec[0:-1].encode('ascii'))
    except:
        return False
    result.insert(1.0, res.decode('ascii'))
    return True

def b32encode(text):
    #print(len(text), text)
    edit, result = text[0], text[1]
    enc = edit.get(1.0,tk.END)
    try:
        res = base64.b32encode(enc[0:-1].encode('ascii'))
        result.insert(1.0, res.decode('ascii'))
    except:
        return False
        #showmessage(None, 'Something Error')
    return True

#这里定义md5生成函数
def md5create(text):
    #print(len(text), text)
    edit, result = text[0], text[1]
    dec = edit.get(1.0,tk.END)         #获取edit控件中的内容
    #print("len dec = ", len(dec[0:-1]))
    #print("dec = ", dec)
    res = hashlib.md5()
    try:
        #it will add a new line character
        res.update(dec[0:-1].encode('ascii'))
    except:
        return False
    result.insert(1.0, res.hexdigest()) #将md5后的数据插入到输出edit控件中
    return True

if __name__ == '__main__':
    main()
