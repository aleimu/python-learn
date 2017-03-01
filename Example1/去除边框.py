from tkinter import *
class Application(Frame):
     def __init__(self,master=None, *args, **kwargs):
         Frame.__init__(self,master, *args, **kwargs)
         self.grid()
         self.createWidgets()
         self.flag=True
         self.transparent=False
         self.top = self.winfo_toplevel()
     def overturn(self):
         self.top.update_idletasks()
         self.top.overrideredirect(self.flag)
         self.flag=not self.flag #switch

     def createWidgets(self):
         self.canvas = Canvas(self, bg='green')
         self.canvas.pack()
         self.flagButton = Button(self, text='try this', bg='green', command=self.overturn)
         self.flagButton.pack()
app = Application()
app.master.title("sample application")
app.mainloop()
'''
我唯一想到的办法就是你试试不用frame，而是用button作为父窗口。
另外relief 设置成FLAT,  bd设置为0， 不显示标题的办法我也没有。

不过可以从win32的API上想办法。
获取窗口句柄可以用FindWindow来做到。获取windows的handle后。设置windows的style。
在dwStyle里将WS_CAPTION属性去掉。SetWindowLong这个函数应该有这个功能。
'''
