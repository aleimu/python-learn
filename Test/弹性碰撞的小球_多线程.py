#python tkinter
#python version 3.3.2
from tkinter import *
import time
import threading

'''
考虑到质量不一样速度后期的算法会非常复杂，通过已知方程无法解出速度，故简化为速度交换
小球碰撞后，两小球的数度交换，即：
#定义一个球的类，包含了球在运动过程中的所有动作
#实例化4个球
#多进程运行4个球 >>> 全局变量 >>> 需要哪些 锁？>>>通过列表的不同索引来完成同步
'''
class Pong(Frame):
    global width,height,scale_value,boll_speed_xy,draw,flag
    def __init__(self,master=None,n=0):        
        '''初始化函数'''
        Frame.__init__(self, master)
        print('aaaa',n)
        self.n=n
        self.__init2__()
        #Pack.config(self)
        print("-------",master)
        #画圆
        self.ball = draw.create_oval(self.x-self.r/2, self.y-self.r/2, self.x+self.r/2, self.y+self.r/2,fill=self.fill)
        #self.createWidgets()
        #draw.after(100,self.moveBall)
    #画球
    def __init2__(self):
        #print("the boll's xy!")
        print(boll_speed_xy)

        #小球的参数
        self.x=boll_speed_xy[self.n][0]
        self.y=boll_speed_xy[self.n][1]
        self.r=boll_speed_xy[self.n][2]
        self.vx=boll_speed_xy[self.n][3]
        self.vy=boll_speed_xy[self.n][4]
        self.fill=boll_speed_xy[self.n][5]
        #小球碰撞墙壁的范围
        self.width=width
        self.height=height
        self.left = round(self.r / 2, 1)
        self.right = self.width - self.left
        self.bottom = self.height - self.left
        self.top = self.left
        print(self.left,self.right, self.bottom,self.top)
    def moveBall(self):
        #print("the boll is moving!")
        if flag:               
            self.impact()
            self.impact2()      
            move_x = self.get_x()
            move_y = self.get_y()
            #print("move_x:",move_x)
            #print("move_y:",move_y)
            #小球移动
            draw.move(self.ball,move_x,move_y)
            draw.after(50, self.moveBall)
        else:
            exit()
    #和小球碰撞    
    def impact(self):
        #print("impact!")
        for m in range(len(boll_speed_xy)):
            #小球碰撞条件，即：(x2 - x1)^2 + (y2 - y1)^2 <= (r + R)^2
            if (round((boll_speed_xy[self.n][0] - boll_speed_xy[m][0])**2 + (boll_speed_xy[self.n][1] - boll_speed_xy[m][1])**2, 2) < round((self.r+boll_speed_xy[m][2])**2, 2)):
                #两小球速度交换
                #print("两小球速度交换!")
                temp_vx = boll_speed_xy[m][3]
                temp_vy = boll_speed_xy[m][4]
                boll_speed_xy[m][3] = boll_speed_xy[self.n][3]
                boll_speed_xy[m][4] = boll_speed_xy[self.n][4]
                boll_speed_xy[self.n][3] = temp_vx
                boll_speed_xy[self.n][4] = temp_vy
                
    #和墙壁碰撞
    def impact2(self):
        #print("impact2!")
        #print("墙壁距离:",boll_speed_xy[self.n][0],boll_speed_xy[self.n][1])
        if boll_speed_xy[self.n][0]<=self.left or boll_speed_xy[self.n][0]>=self.right:
            #print("vx速度:",boll_speed_xy)
            boll_speed_xy[self.n][3]=-boll_speed_xy[self.n][3]
            #print("vx速度:",boll_speed_xy)
            #print("和x墙壁碰撞!")
        if boll_speed_xy[self.n][1]>=self.bottom or boll_speed_xy[self.n][1]<= self.top:
            #print("vy速度:",boll_speed_xy)
            boll_speed_xy[self.n][4]=-boll_speed_xy[self.n][4]
            #print("vy速度:",boll_speed_xy)
            #print("和y墙壁碰撞!")
    #实时更新在Frame中的位置和参数
    def get_x(self):
        '''获取小球X轴坐标移动距离并且更新小球的圆心X坐标，返回X轴所需移动距离'''
        xx=boll_speed_xy[self.n][3]* scale_value / 5.0
        boll_speed_xy[self.n][0] = boll_speed_xy[self.n][0] + xx
        return xx
    def get_y(self):
        '''获取小球Y轴坐标移动距离并且更新小球的圆心Y坐标，返回Y轴所需移动距离'''
        yy=boll_speed_xy[self.n][4] * scale_value / 5.0
        boll_speed_xy[self.n][1] = boll_speed_xy[self.n][1] + yy 
        return yy

def stop():
    flag=False


#建立窗口和游标
width=1200
height=800
flag=True

top=Tk()
draw = Canvas(top, width=1200,heigh=800,bg='white')
draw.pack()

speed = Scale(top, orient=HORIZONTAL, label="ball speed",from_=-200, to=200)
speed.pack(side=BOTTOM, fill=X)
#游标度数
scale_value =speed.get() * 0.1
scale_value=10
'''
#建立全局变量，球的位置和速度 [x,y,vx,vy]，每一个球只可以改变自己的属性，不需要锁住boll_speed_xy
for x in range(n):
    boll_speed_xy=[[1,1,1,1,1,"red"] for i in range(n)]
    #a=Pong(draw,boll_speed_xy[0],boll_speed_xy[1],boll_speed_xy[2],boll_speed_xy[3],boll_speed_xy[4])
    a=Pong(draw,x)
 '''
boll_speed_xy=[[120,120,40,10,10,"red"],[150,150,30,15,15,"blue"],[500,500,20,14,14,"yellow"]]
#创建线程组
a=Pong(draw,0)
b=Pong(draw,1)
c=Pong(draw,2)
#进入线程循环
for x in (a,b,c):
        t=threading.Thread(target=x.moveBall(), args=(draw,))
        t.start()

Quit=Button(top,text='QUIT',command=top.quit,activeforeground='white',activebackground='red')
Quit.pack()
Quit2=Button(top,text='QUIT2',command=stop,activeforeground='white',activebackground='blue')
Quit2.pack()

mainloop()
