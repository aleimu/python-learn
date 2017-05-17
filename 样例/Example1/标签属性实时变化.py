from tkinter import *
import time
root = Tk() # 初始化Tk()
root.title("label-test")    # 设置窗口标题
root.iconbitmap('C:\\xmind\\XMind_Windows\\xmind_xmp.ico') #改变左上方的小图标
#在python中，tkinter模块生成的窗口左上角是一个：Tk字样的图标(Tk为tkinter的缩写)
root.geometry()    # 设置窗口大小 注意：是x 不是*
root.resizable(width=True, height=False) # 设置窗口是否可以变化长/宽，False不可变，True可变，默认为True
l = Label(root, bg="pink", font=("Arial",12), width=8, height=3)


# 这里的side可以赋值为LEFT  RTGHT TOP  BOTTOM
x=0
#设置颜色、字体、长宽等随x变化
bg=["pink","green","purple","yellow","pink","green","purple","yellow","pink","green","purple","yellow"]
font=[("Arial",4),("Arial",6),("Arial",8),("Arial",10),("Arial",4),("Arial",6),("Arial",8),("Arial",10)]
def change():
    t.insert(END,"hello\n")
    global x
    l["text"]=("长宽:",x)
    l["width"]=x+3
    l["height"]=x
    l["bg"]=bg[x]
    l["font"]=font[x]
    x=x+1
    l.pack(side=LEFT)
    
t = Text()
t.pack()   # 这里的side可以赋值为LEFT  RTGHT TOP  BOTTOM
Button(root, text="press", command=change).pack()
root.mainloop() # 进入消息循环
