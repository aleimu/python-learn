#-*- coding: UTF-8 -*-

from tkinter import *
root = Tk() # 初始化Tk()
root.title("列表和滚动控件")    # 设置窗口标题
root.geometry('220x300')    # 设置窗口大小 注意：是x 不是*
def print_item(event):
    print (lb.get(lb.curselection()))#获得所选中的选项 lb.get(lb.curselection())
var = StringVar() #绑定变量 var = StringVar() lb=ListBox(根对象,listvariable=var)
lb = Listbox(root, height=5, selectmode=BROWSE, listvariable = var)
lb.bind('<ButtonRelease-1>',print_item)
list_item = range(0,100)
for item in list_item:
    lb.insert(END,item) #添加：lb.insert(item)
    
scrl = Scrollbar(root)
scrl.pack(side=RIGHT,fill=Y)
lb.configure(yscrollcommand=scrl.set)   # 指定Listbox的yscrollbar的回调函数为Scrollbar的set，表示滚动条在窗口变化时实时更新
lb.pack(side=LEFT,fill=BOTH)
scrl['command'] = lb.yview  # 指定Scrollbar的command的回调函数是Listbar的yview
root.mainloop()
