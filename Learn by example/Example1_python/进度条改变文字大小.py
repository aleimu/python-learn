from tkinter import *  #引入模块
#resize函数是用来改变文字大小的，当进度条改变时调用
def resize(ev=None):   
      label.config(font='Helvetica -%d bold' % scale.get())
#config函数就是通过设置组件的参数来改变组件的，这里改变的是font字体大小
top=Tk()   #主窗口
top.geometry('600x400')  #设置了主窗口的初始大小600x400
label=Label(top,text='Hello world!',font='Helvetica -12 bold')  #设置标签字体的初始大小
label.pack(fill=Y,expand=1)
#scale创建进度条，设置
scale=Scale(top,from_=10,to=40,orient=HORIZONTAL,command=resize)
scale.set(12)  #设置起始位置
scale.pack(fill=X,expand=1)
Quit=Button(top,text='QUIT',command=top.quit,activeforeground='white',activebackground='red')
Quit.pack()
mainloop()
