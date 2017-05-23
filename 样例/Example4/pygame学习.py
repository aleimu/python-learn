#!/usr/bin/env python
background_image_filename='./img/background.jpg'
mouse_image_filename='./img/emo_im_surprised.png'
# 指定图像文件名称
import pygame
# 导入 pygame 库
from pygame.locals import *
# 导入一些常用的函数和常量
from sys import exit
# 向 sys 模块借一个 exit 函数用来退出程序
pygame.init()
# 初始化 pygame, 为使用硬件做准备
screen=pygame.display.set_mode((522,926),DOUBLEBUF|HWSURFACE,32)
# 创建了一个窗口
pygame.display.set_caption("注意你的手!")
# 设置窗口标题
# 在pygame中可以使用pygame.image.load（）函数来加载位图。（支持jpg,png,gif,bmp,pcx,tif,tga等多种图片格式）。
background=pygame.image.load(background_image_filename).convert()
#获取位图的宽和高
width,height = background.get_size()
print("位图的尺寸:",width,height)
mouse_cursor=pygame.image.load(mouse_image_filename).convert_alpha()
#convert_alpha()方法会使用透明的方法绘制前景对象
# 加载并转换图像
while True:
# 游戏主循环
	for event in pygame.event.get():
		if event.type==QUIT:
			# 接收到退出事件后退出程序
			exit()
	screen.blit(background, (0,0))
	# 将背景图画上去
	x, y=pygame.mouse.get_pos()
	# 获得鼠标位置
	x-=mouse_cursor.get_width()/2
	y-=mouse_cursor.get_height()/2
	# 计算光标的左上角位置
	screen.blit(mouse_cursor, (x, y))
	# 把光标画上去
	pygame.display.flip()
  #pygame.display.update()
	# 刷新一下画面

"""
1.set_mode 会返回一个 Surface 对象 ， 代表了在桌面上出现的那个窗口 ， 三个参数第一个为元祖 ， 代表分 辨率
   （必须 ） ；第二个是一个标志位，具体意思见下表，如果不用什么特性，就指定 0 ；第三个为色深。
   标志位 功能
   FULLSCREEN 创建一个全屏窗口
   DOUBLEBUF 创建一个 “ 双缓冲 ” 窗口，建议在 HWSURFACE 或者 OPENGL 时使用
   HWSURFACE 创建一个硬件加速的窗口，必须和 FULLSCREEN 同时使用
   OPENGL 创建一个 OPENGL 渲染的窗口
   RESIZABLE 创建一个可以改变大小的窗口
   NOFRAME 创建一个没有边框的窗口

2.写字
   这个文本绘制进程是一个重量级的进程，比较耗费时间，常用的做法是先在内存中创建文本图像，然后将文本当作一个图像来渲染。
   myfont = pygame.font.Font(None,60)
   white = 255,255,255
   blue = 0,0,200
   textImage = myfont.render("Hello Pygame", True, white)
   textImage 对象可以使用screen.blit()来绘制。上面代码中的render函数第一个参数是文本，第二个参数是抗锯齿字体，第三个参数是一个颜色值（RGB值）。
   要绘制本文，通常的过程是清屏，绘制，然后刷新。
   screen.fill(blue)
   screen.blit(textImage, (100,100))
   pygame.display.update()

3.画圆
   color = 255,255,0
   position = 300,250
   radius = 100
   width = 10
   pygame.draw.circle(screen, color, position, radius, width)

4.画矩形
    color = 255,255,0
    width = 0 #solid fill
    pos = pos_x, pos_y, 100, 100
    pygame.draw.rect(screen, color, pos, width)

5.画线条
  color = 255,255,0
  width = 8
  pygame.draw.line(screen, color, (100,100), (500,400), width)

6.画弧线
   参考test2.py

7.图片处理
  pygame.transform 这个模块可以满足我们的需求，这个模块包含了比如缩放，翻转等一些非常有用的函数。
  pygame.transform.scale()这是一个快速的缩放函数，可以快速缩放一个图像
  superman = pygame.transform.smoothscale(superman,(width//2,height//2))

pygame.cdrom 访问光驱
pygame.cursors 加载光标
pygame.display 访问显示设备
pygame.draw 绘制形状、线和点
pygame.event 管理事件
pygame.font 使用字体
pygame.image 加载和存储图片
pygame.joystick 使用游戏手柄或者 类似的东西
pygame.key 读取键盘按键
pygame.mixer 声音
pygame.mouse 鼠标
pygame.movie 播放视频
pygame.music 播放音频
pygame.overlay 访问高级视频叠加
pygame.rect 管理矩形区域
pygame.sndarray 操作声音数据
pygame.sprite 操作移动图像
pygame.surface 管理图像和屏幕
pygame.surfarray 管理点阵图像数据
pygame.time 管理时间和帧信息
pygame.transform 缩放和移动图像
"""

import pygame
from pygame.locals import *
#继承pygame.sprite.Sprite然后重写
class MySprite(pygame.sprite.Sprite):
    def __init__(self, target):
        pygame.sprite.Sprite.__init__(self)
        self.target_surface = target
        self.image = None
        self.master_image = None
        self.rect = None
        self.topleft = 0,0
        self.frame = 0
        self.old_frame = -1
        self.frame_width = 1
        self.frame_height = 1
        self.first_frame = 0
        self.last_frame = 0
        self.columns = 1
        self.last_time = 0
#在加载一个精灵图序列的时候，我们需要告知程序一帧的大小，（传入帧的宽度和高度，文件名，有多少列）
    def load(self, filename, width, height, columns):
        self.master_image = pygame.image.load(filename).convert_alpha()
        self.frame_width = width
        self.frame_height = height
        self.rect = 0,0,width,height
        self.columns = columns
        rect = self.master_image.get_rect()
        self.last_frame = (rect.width // width) * (rect.height // height) - 1
#从第一帧不断的加载直到最后一帧，然后在折返回第一帧
    def update(self, current_time, rate=60):
        if current_time > self.last_time + rate:
            self.frame += 1
            if self.frame > self.last_frame:
                self.frame = self.first_frame
            self.last_time = current_time

        if self.frame != self.old_frame:
            frame_x = (self.frame % self.columns) * self.frame_width
            frame_y = (self.frame // self.columns) * self.frame_height
            rect = ( frame_x, frame_y, self.frame_width, self.frame_height )
            self.image = self.master_image.subsurface(rect)
            self.old_frame = self.frame

pygame.init()
screen = pygame.display.set_mode((800,600),0,32)
pygame.display.set_caption("精灵类测试")
font = pygame.font.Font(None, 18)
framerate = pygame.time.Clock()


cat = MySprite(screen)
cat.load("./img/sprite2.png", 100, 100, 4)
#pygame使用精灵组来管理精灵的绘制和更新
group = pygame.sprite.Group()
group.add(cat)

while True:
    framerate.tick(30)
    #根据时间间隔一张一张的播放
    ticks = pygame.time.get_ticks()
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            exit()
    key = pygame.key.get_pressed()
    if key[pygame.K_ESCAPE]:
        exit()

    screen.fill((0,0,100))

    group.update(ticks)
    group.draw(screen)
    pygame.display.update()

"""
#小五义 http://www.cnblogs.com/xiaowuyi
import pygame,sys
pygame.init()
class Car(pygame.sprite.Sprite):
    def __init__(self,filename,initial_position):
        pygame.sprite.Sprite.__init__(self)
        self.image=pygame.image.load(filename)
        self.rect=self.image.get_rect()
        self.rect.bottomright=initial_position
screen=pygame.display.set_mode([640,480])
screen.fill([255,255,255])
fi='./img/shoot.png'
locationgroup=([150,200],[350,360],[250,280])
Cargroup=pygame.sprite.Group()
for lo in locationgroup:
    Cargroup.add(Car(fi,lo))

for carlist in Cargroup.sprites():
    screen.blit(carlist.image,carlist.rect)
pygame.display.update()
while True:
    for event in pygame.event.get():
        if event.type==pygame.QUIT:
            sys.exit()

"""

"""
pygame还提供了精灵组，它很适合处理精灵列表，有添加，移除，绘制，更新等方法。具体如下：http://www.pygame.org/docs/ref/sprite.html#pygame.sprite.Sprite
Group.sprites 精灵组
Group.copy 复制
Group.add 添加
Group.remove 移除
Group.has 判断精灵组成员
Group.update 更新
Group.draw 位块显示
Group.clear - 绘制背景
Group.empty 清空
"""


import math,sys
import pygame
from pygame.locals import *
pygame.init()
screen = pygame.display.set_mode((600,500))
pygame.display.set_caption("画曲线")

while True:
    for event in pygame.event.get():
        if event.type in (QUIT, KEYDOWN):
            pygame.quit()
            sys.exit()

    screen.fill((0,0,200))

    #绘制弧形的代码
    color = 255,0,255
    position = 200,150,200,200
    start_angle = math.radians(0)
    end_angle = math.radians(180)
    width = 8
    pygame.draw.arc(screen, color, position, start_angle, end_angle, width)

    pygame.display.update()

'''
键盘事件包括最典型的keyup 和 keydown 当按键按下的时候响应KEYDOWN事件，按键弹起的时候响应KEYUP事件。
默认的话pygame不会重复地去响应一个被一直按住的键，只是在按键第一次被按下的时候响应一次，如果需要重复响应一个按键的话下面的操作：
pygame.key.set_repeat(10)
    事件                         产生途径                            参数
    QUIT                       用户按下关闭按钮                    none
    ATIVEEVENT                 Pygame被激活或者隐藏                    gain, state
    KEYDOWN                    键盘被按下                            unicode, key, mod
    KEYUP                      键盘被放开                            key, mod
    MOUSEMOTION                鼠标移动                            pos, rel, buttons
    MOUSEBUTTONDOWN            鼠标按下                            pos, button
    MOUSEBUTTONUP              鼠标放开                            pos, button
    JOYAXISMOTION              游戏手柄(Joystick or pad)移动           joy, axis, value
    JOYBALLMOTION              游戏球(Joy ball)?移动            joy, axis, value
    JOYHATMOTION               游戏手柄(Joystick)?移动            joy, axis, value
    JOYBUTTONDOWN              游戏手柄按下                            joy, button
    JOYBUTTONUP                游戏手柄放开                            joy, button
    VIDEORESIZE                Pygame窗口缩放                    size, w, h
    VIDEOEXPOSE                Pygame窗口部分公开(expose)            none
    USEREVENT                  触发了一个用户事件                    code

使用模板
while True:
    for event in pygame.event.get():
        if event.type == QUIT:
            sys.exit()
        elif event.type == KEYDOWN:
            key_flag = True
        elif event.type == KEYUP:
            key_flag = False

2.轮询鼠标
这里有3个相关的函数：
（1）pygame.mouse.get_pos()，这个函数会返回鼠标当前的坐标x,y；
（2）pygame.mouse.get_rel()，rel_x ,rel_y = pygame.mouse.get_rel().利用这个函数可以读取鼠标的相对移动。
（3）btn_one,btn_two,btn_three = pygame.mouse.get_pressed()，利用这个函数，可以获取鼠标按钮的状态。比如当左键按下的时候btn_one 的值会被赋值为1，鼠标按键弹起是会被赋值为0。

'''


import pygame
pygame.init()
screen=pygame.display.set_mode((640,480))
all_colors=pygame.Surface((4096,4096), depth=24)
for r in range(256):
    print (r+1,"out of 256")
    x=(r&15)*256
    y=(r>>4)*256
    for g in range(256):
        for b in range(256):
            all_colors.set_at((x+g, y+b), (r, g, b))
pygame.image.save(all_colors,"allcolors.bmp")


#图像缩放
#!/usr/bin/env python
background_image_filename='./img/background.jpg'
#background_image_filename='./img/gif3.gif' 使用gif时并不能动态
mouse_image_filename='./img/emo_im_surprised.png'
# 指定图像文件名称
import pygame
# 导入 pygame 库
from pygame.locals import *
# 导入一些常用的函数和常量
from sys import exit
# 向 sys 模块借一个 exit 函数用来退出程序
pygame.init()
# 初始化 pygame, 为使用硬件做准备
screen=pygame.display.set_mode((800,600),DOUBLEBUF,32)
# 创建了一个窗口
pygame.display.set_caption("注意你的手!")
# 设置窗口标题
# 在pygame中可以使用pygame.image.load（）函数来加载位图。（支持jpg,png,gif,bmp,pcx,tif,tga等多种图片格式）。
background=pygame.image.load(background_image_filename).convert()
#获取位图的宽和高
width,height = background.get_size()
print("位图的尺寸:",width,height)
mouse_cursor=pygame.image.load(mouse_image_filename).convert_alpha()
#convert_alpha()方法会使用透明的方法绘制前景对象
#缩放图片
background2 = pygame.transform.smoothscale(background,(width//2,height//2))
mouse_cursor2 = pygame.transform.smoothscale(mouse_cursor,(width//2,height//2))
while True:
# 游戏主循环
    for event in pygame.event.get():
        if event.type==QUIT:
            # 接收到退出事件后退出程序
            exit()
    screen.blit(background2, (0,0))
    # 将背景图画上去
    x, y=pygame.mouse.get_pos()
    # 获得鼠标位置
    x-=mouse_cursor.get_width()/2
    y-=mouse_cursor.get_height()/2
    # 计算光标的左上角位置
    screen.blit(mouse_cursor2, (x, y))
    # 把光标画上去
    pygame.display.update()
    # 刷新一下画面

"""
    pygame.transform 这个模块可以满足我们的需求，这个模块包含了比如缩放，翻转等一些非常有用的函数。
    pygame.transform.scale()这是一个快速的缩放函数，可以快速缩放一个图像
    superman = pygame.transform.smoothscale(superman,(width//2,height//2))

    #旋转超人
    def wrap_angle(angle):
        return angle % 360
    delta_x = ( pos.x - old_pos.x )
    delta_y = ( pos.y - old_pos.y )
    rangle = math.atan2(delta_y, delta_x)
    rangled = wrap_angle( -math.degrees(rangle) )
    superman_rotate = pygame.transform.rotate(superman, rangled)
"""



#小五义 http://www.cnblogs.com/xiaowuyi
import pygame,sys
#在一个640*480大小的白色窗体[50,100]的位置绘制一个30*30大小的红色距形
#在只有两个精灵的时候我们可以使用pygame.sprite.collide_rect()函数来进行一对一的冲突检测。
#这个函数需要传递2个参数，并且每个参数都是需要继承自pygame.sprite.Sprite。
pygame.init()
class Temp(pygame.sprite.Sprite):
    def __init__(self,color,initial_position):
        pygame.sprite.Sprite.__init__(self)
        self.image = pygame.Surface([30,30])
        self.image.fill(color)
        self.rect=self.image.get_rect()
        self.rect.topleft=initial_position
screen=pygame.display.set_mode([640,480])
screen.fill([255,255,255])
b=Temp([255,0,0],[50,100])
c=Temp([240,230,0],[50,100])
screen.blit(b.image,b.rect)
screen.blit(c.image,c.rect)
pygame.display.update()
#冲突检测，没有覆盖返回0，有冲突就返回1
result = pygame.sprite.collide_rect(b,c)
print(result)
while True:
    for event in pygame.event.get():
        if event.type==pygame.QUIT:
            sys.exit()

"""
精灵和组之间的矩形冲突检测
pygame.sprite.spritecollide(sprite,sprite_group,bool)。调用这个函数的时候，一个组中的所有精灵都会逐个地对另外一个单个精灵进行冲突检测，发生冲突的精灵会作为一个列表返回。
这个函数的第一个参数就是单个精灵，第二个参数是精灵组，第三个参数是一个bool值，最后这个参数起了很大的作用。当为True的时候，会删除组中所有冲突的精灵，False的时候不会删除冲突的精灵
list_collide = pygame.sprite.spritecollide(sprite,sprite_group,False);
另外这个函数也有一个变体：pygame.sprite.spritecollideany()。这个函数在判断精灵组和单个精灵冲突的时候，会返回一个bool值。

精灵组之间的矩形冲突检测
pygame.sprite.groupcollide()。利用这个函数可以检测两个组之间的冲突，他返回一个字典。（键-值对）
"""


#获取键盘和鼠标的事件
import pygame
from pygame.locals import*
from sys import exit
pygame.init()
SCREEN_SIZE=(640,480)
screen=pygame.display.set_mode(SCREEN_SIZE,0,32)
font=pygame.font.SysFont("arial",16);
font_height=font.get_linesize()
event_text=[]
#默认的话pygame不会重复地去响应一个被一直按住的键，只是在按键第一次被按下的时候响应一次，如果需要重复响应一个按键的话下面的操作
pygame.key.set_repeat(10) #以毫秒为单位
while True:
	event=pygame.event.wait()
	event_text.append(str(event))
	# 获得时间的名称
	event_text=event_text[- int(SCREEN_SIZE[1] / font_height) : ]
	# 这个切片操作保证了 event_text 里面只保留一个屏幕的文字
	# 这里的quit是值鼠标点击 X 关闭窗口
	print(event.type)
	if event.type==QUIT:
		exit()
	screen.fill((255,255,255))
	y=SCREEN_SIZE[1]-font_height
	# 找一个合适的起笔位置，最下面开始但是要留一行的空
	for text in reversed(event_text):
		screen.blit( font.render(text,True, (0,0,0)), (0, y) )
		# 以后会讲
		y-=font_height
		# 把笔提一行
		pygame.display.update()

