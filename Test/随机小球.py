from tkinter import *
import threading
import random
import time

class boll():
      c=1
      global draw
      def __init__(self,master=None):
            self.ax=10
            self.ay=30
            self.bx=30
            self.by=50
            self.boll=draw.create_oval(self.ax, self.ay, self.bx, self.by,fill=master)
      def move(self):
            draw.move(self.boll,random.gauss(1,10),random.gauss(1,10))
            draw.after(100,self.move)

           
width=1200
height=600
top=Tk()
#创建画布
draw = Canvas(top, width=1200,height=600,bg='white')
draw.pack()
#建立线程组
qq=[]
for x in range(10):
      color=random.choice(['red','blue'])
      q=boll(color)
      qq.append(q)

#遍历线程组并启动
for x in qq:
      t=threading.Thread(target=x.move(), args=(draw,))
      t.start()

      
