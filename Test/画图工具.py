from tkinter import*
import random
import time
tk = Tk()
tk.geometry ('500x500')
canvas = Canvas(tk,width=400,height=400)
canvas.pack()
def random_rectangle(width,height):
    x1 = random.randrange(width)  ##建立变量x1，设定它的值是从0到参数width之间的一个随机数
    y1 = random.randrange(height)
    x2 = x1 + random.randrange(width)  ##建立变量x2，它是由前面计算得到的x1加上一个随机数
    y2 = y1 + random.randrange(height)
    canvas.create_rectangle(x1,y1,x2,y2)  ##用变量x1,y1,x2,y2来调用canvas.create_rectangle在画布上画出矩形
for x in range(0,10):  ##用for循环画100个随机长方形
    random_rectangle(400,400)  
#主要参考本博客
#http://www.cnblogs.com/OctoptusLian/tag/%E7%94%BB%E5%9B%BE/
#http://www.cnblogs.com/cloudtj/articles/6240201.html


canvas.create_polygon(10,10,10,60,50,35)  ##创建三角形
canvas.create_line(100,300,500,400,fill='red') #fill可以加颜色
canvas.create_text(150,100,text='Happy birthday to you!',fill='green',font=('Times',15))

for x in range(0,20):
    canvas.move(1,5,5)  ##把任意画好的对象移动到把x和y坐标增加给定值的位置
    tk.update()         ##强制tkinter更新屏幕（重画）     
    time.sleep(0.02)
for x in range(0,30):
    canvas.move(1,-5,-5) 
    tk.update()             
    time.sleep(0.05)
#在画布上显示图片，首先要装入图片
my_image = PhotoImage(file='C:\\Users\\lWX307086\\Desktop\\图片\\容器类库.gif')
canvas.create_image(0,0,anchor = NW,image = my_image)
canvas.create_image(20,20,anchor = NW,image = my_image)
#画布上面以create_开头的函数，它总会返回一个ID。这个函数可以在其他的函数中使用
mytriangle=canvas.create_polygon(10,10,10,60,50,35)
print(mytriangle)
canvas.move(mytriangle,5,0)
canvas.itemconfig(mytriangle,fill='blue')  ##把ID为变量mytriangle中的值的对象的填充颜色改为蓝色
