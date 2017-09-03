#python tkinter
#python version 3.3.2

from tkinter import *

'''
    判断
    两个小球
    {
        圆心：A(x1,y1)  半径：r  X轴速度：Vax  Y轴速度：Vay
        圆心：B(x2,y2)  半径：R  X轴速度：Vbx  Y轴速度：Vby
    }
    碰撞的条件是：
    1.两个小球的圆心距离不大于两小球半径之和(r+R)，即：
    {
        (x2 - x1)^2 + (y2 - y1)^2 <= (r + R)^2
    }
    2.小球碰撞后，两小球的数度交换，即：
    {
        tempVax = Vax
        tempVay = Vay
        Vax = Vbx
        Vay = Vby
        Vbx = tempVax
        Vby = tempVay
        或：
        Vax = Vax + Vbx
        Vbx = Vax - Vbx
        Vax = Vax - Vbx
        Vay = Vay + Vby
        Vby = Vay - Vby
        Vay = Vay - Vby
    }

    游戏规则：
    五小球在画布中移动，他们之间会产生碰撞，当然小球和上下左右都会产生碰撞
    碰撞后，小球会改变方向返回
    而最下面的游标则用于调节小球的移动速度，游标的范围是[-100, 100]
    
    缺陷或BUG：
    1.在修改游标数据从而改变小球移动速度的时候，小球移动的距离得不到及时的更新
    导致小球可能会逃离画布
    2.小球在运动的过程中，有时候也有可能逃离画布

    总结：
    完成这个游戏，花了一个星期的下班时间。在这个过程中不仅回去学习了高中的数学知识，
    物理知识，很多东西都忘得差不多了，不过很快又学返回来了。
    游戏其实很多就是数学问题。
    
    游戏中还存在缺陷或BUG，希望志同道合者可以共同完善。

    修改记录：
    1.调整画布大小
    2.调整了小球的半径,以及小球的速度初始值，小球初始圆心坐标
    3.游标的范围修改为：[-200, 200]
    这些修改主要是针对上面的缺陷而进行的。

    优点：
    1.小球移动的过程更直观
    2.小球的移动速度变小，但是可以根据游标来修改小球移动速度
    3.界面比之前更加友好
'''

__author__ = {'author' : 'Hongten',
              'Email' : 'hongtenzone@foxmail.com',
              'Blog' : 'http://www.cnblogs.com/hongten/',
              'Created' : '2013-09-28',
              'Version' : '1.1'}

class Pong(Frame):
    def createWidgets(self):
         #放缩率
        self.scaling = 100.0
        #画布比例
        self.canvas_width = 10
        self.canvas_height = 5.6
        ## 画布
        self.draw = Canvas(self, width=(self.canvas_width * self.scaling),
                           height=(self.canvas_height * self.scaling),
                           bg='white')

        ## 游标(控制小球移动速度，范围：[-100, 100])
        self.speed = Scale(self, orient=HORIZONTAL, label="ball speed",
                           from_=-200, to=200)
        
        self.speed.pack(side=BOTTOM, fill=X)

        #小球直径
        self.ball_d = 1.0
        #小球碰撞墙壁的范围
        self.scaling_left = round(self.ball_d / 2, 1)
        self.scaling_right = self.canvas_width - self.scaling_left
        self.scaling_bottom = self.canvas_height - self.scaling_left
        self.scaling_top = self.scaling_left
       
        #游标度数
        self.scale_value = self.speed.get() * 0.1
       
        #存放小球数组
        self.balls = []
        #存放小球x坐标数组
        self.ball_x = []
        #存放小球y坐标数组
        self.ball_y = []
        #存放小球x轴方向速度数组
        self.ball_v_x = []
        #存放小球y轴方向速度数组
        self.ball_v_y = []

        # 五个小球
        self.ball = self.draw.create_oval("0.60i", "0.60i", "1.60i", "1.60i",
                                          fill="red")
        self.second_ball = self.draw.create_oval("2.0i", "2.0i", "3.0i", "3.0i",
                                                 fill='black')
        self.three_ball = self.draw.create_oval("4.0i", "4.0i", "5.0i", "5.0i",
                                                 fill='brown')
        self.four_ball = self.draw.create_oval("6.0i", "2.0i", "7.0i", "3.0i",
                                                 fill='green')
        self.five_ball = self.draw.create_oval("8.0i", "3.0i", "9.0i", "4.0i",
                                                 fill='gray')

        #把五个小球放入数组
        self.balls.append(self.ball)
        self.balls.append(self.second_ball)
        self.balls.append(self.three_ball)
        self.balls.append(self.four_ball)
        self.balls.append(self.five_ball)

        #第一个小球，即self.ball的圆心坐标(self.x, self.y),这里进行了放缩,目的是为了
        #在小球移动的过程中更加流畅
        self.x = 1.1        
        self.y = 1.1
        #第一个小球的速度方向
        self.velocity_x = -0.2
        self.velocity_y = 0.1

        self.second_ball_x = 2.5
        self.second_ball_y = 2.5
        self.second_ball_v_x = 0.1
        self.second_ball_v_y = -0.2

        self.three_ball_x = 4.5
        self.three_ball_y = 4.5
        self.three_ball_v_x = -0.1
        self.three_ball_v_y = -0.2

        self.four_ball_x = 6.5
        self.four_ball_y = 2.5
        self.four_ball_v_x = 0.1
        self.four_ball_v_y = -0.2

        self.five_ball_x = 8.5
        self.five_ball_y = 3.5
        self.five_ball_v_x = 0.1
        self.five_ball_v_y = 0.2

        
        #更新小球的坐标
        self.update_ball_x_y()
        self.draw.pack(side=LEFT)

    def update_ball_x_y(self, *args):
        '''更新小球的坐标，即把各个小球的圆心坐标信息以及速度信息存放到数组中，
           便于在后面循环遍历的时候使用。'''
        #第一个小球信息
        self.ball_x.append(self.x)
        self.ball_y.append(self.y)
        self.ball_v_x.append(self.velocity_x)
        self.ball_v_y.append(self.velocity_y)

        self.ball_x.append(self.second_ball_x)
        self.ball_y.append(self.second_ball_y)
        self.ball_v_x.append(self.second_ball_v_x)
        self.ball_v_y.append(self.second_ball_v_y)

        self.ball_x.append(self.three_ball_x)
        self.ball_y.append(self.three_ball_y)
        self.ball_v_x.append(self.three_ball_v_x)
        self.ball_v_y.append(self.three_ball_v_y)

        self.ball_x.append(self.four_ball_x)
        self.ball_y.append(self.four_ball_y)
        self.ball_v_x.append(self.four_ball_v_x)
        self.ball_v_y.append(self.four_ball_v_y)

        self.ball_x.append(self.five_ball_x)
        self.ball_y.append(self.five_ball_y)
        self.ball_v_x.append(self.five_ball_v_x)
        self.ball_v_y.append(self.five_ball_v_y)
    
    def update_ball_velocity(self, index, *args):
        '''更新各个小球速度信息，即小球碰撞到四周和另外的小球索要更新的速度信息'''
        #游标值
        self.scale_value = self.speed.get() * 0.1
        #碰撞墙壁
        if (self.ball_x[index] > self.scaling_right) or (self.ball_x[index] < self.scaling_left):
            self.ball_v_x[index] = -1.0 * self.ball_v_x[index]
        if (self.ball_y[index] > self.scaling_bottom) or (self.ball_y[index] < self.scaling_top):
            self.ball_v_y[index] = -1.0 *  self.ball_v_y[index]

        '''
        #TEST:
        for n in range(len(self.balls)):
            #print((self.ball_x[index] - self.ball_x[n])**2)
            #print(round((self.ball_x[index] - self.ball_x[n])**2 + (self.ball_y[index] - self.ball_y[n])**2, 2))
            print(round((self.ball_x[index] - self.ball_x[n])**2 + (self.ball_y[index] - self.ball_y[n])**2, 2) <= round(self.ball_d**2, 2))
        '''
        for n in range(len(self.balls)):
            #小球碰撞条件，即：(x2 - x1)^2 + (y2 - y1)^2 <= (r + R)^2
            if (round((self.ball_x[index] - self.ball_x[n])**2 + (self.ball_y[index] - self.ball_y[n])**2, 2) <= round(self.ball_d**2, 2)):
                #两小球速度交换
                temp_vx = self.ball_v_x[index]
                temp_vy = self.ball_v_y[index]
                self.ball_v_x[index] = self.ball_v_x[n]
                self.ball_v_y[index] = self.ball_v_y[n]
                self.ball_v_x[n] = temp_vx
                self.ball_v_y[n] = temp_vy
        #print(self.ball_v_x, self.ball_v_y)
               
        '''
        #WRONG:
        for n in range(len(self.balls)):            
            if (((self.ball_x[index] - self.ball_x[n])**2 + (self.ball_y[index] - self.ball_y[n])**2) <= self.ball_d**2):
                #两小球速度交换
                self.ball_v_x[index] = self.ball_v_x[index] + self.ball_v_x[n]
                self.ball_v_x[n] = self.ball_v_x[0] - self.ball_v_x[n]
                self.ball_v_x[index] = self.ball_v_x[index] - self.ball_v_x[n]
                self.ball_v_y[index] = self.ball_v_y[index] + self.ball_v_y[n]
                self.ball_v_y[n] = self.ball_v_y[index] - self.ball_v_y[n]
                self.ball_v_y[index] = self.ball_v_y[index] - self.ball_v_y[n]
        print(self.ball_v_x, self.ball_v_y)
        '''
        
    def get_ball_deltax(self, index, *args):
        '''获取小球X轴坐标移动距离并且更新小球的圆心X坐标，返回X轴所需移动距离'''
        deltax = (self.ball_v_x[index] * self.scale_value / self.scaling)
        self.ball_x[index] = self.ball_x[index] + deltax
        return deltax

    def get_ball_deltay(self, index, *args):
        '''获取小球Y轴坐标移动距离并且更新小球的圆心Y坐标，返回Y轴所需移动距离'''
        deltay = (self.ball_v_y[index] * self.scale_value / self.scaling)
        self.ball_y[index] = self.ball_y[index] + deltay
        return deltay
    
    def moveBall(self, *args):
        '''移动第一个小球，编号为：0,这是根据数组：self.balls确定的。'''
        self.update_ball_velocity(0)       
        deltax = self.get_ball_deltax(0)
        deltay = self.get_ball_deltay(0)
        #小球移动
        self.draw.move(self.ball,  "%ri" % deltax, "%ri" % deltay)
        self.after(10, self.moveBall)

    def move_second_ball(self, *args):
        self.update_ball_velocity(1)       
        deltax = self.get_ball_deltax(1)
        deltay = self.get_ball_deltay(1)        
        self.draw.move(self.second_ball,  "%ri" % deltax, "%ri" % deltay)
        self.after(10, self.move_second_ball)


    def move_three_ball(self, *args):
        self.update_ball_velocity(2)       
        deltax = self.get_ball_deltax(2)
        deltay = self.get_ball_deltay(2)
        self.draw.move(self.three_ball,  "%ri" % deltax, "%ri" % deltay)
        self.after(10, self.move_three_ball)

    def move_four_ball(self, *args):
        self.update_ball_velocity(3)       
        deltax = self.get_ball_deltax(3)
        deltay = self.get_ball_deltay(3)
        self.draw.move(self.four_ball,  "%ri" % deltax, "%ri" % deltay)
        self.after(10, self.move_four_ball)

    def move_five_ball(self, *args):
        self.update_ball_velocity(4)       
        deltax = self.get_ball_deltax(4)
        deltay = self.get_ball_deltay(4)
        self.draw.move(self.five_ball,  "%ri" % deltax, "%ri" % deltay)
        self.after(10, self.move_five_ball)

            
    def __init__(self, master=None):
        '''初始化函数'''
        Frame.__init__(self, master)
        Pack.config(self)
        self.createWidgets()
        self.after(10, self.moveBall)
        self.after(10, self.move_three_ball)
        self.after(10, self.move_four_ball)
        self.after(10, self.move_five_ball)
        self.after(10, self.move_second_ball)
        
        
game = Pong()

game.mainloop()
