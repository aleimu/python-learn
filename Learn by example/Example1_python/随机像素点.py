import pygame
from pygame.locals import *
from sys import exit
from random import randint
pygame.init()
screen=pygame.display.set_mode((640,480),0,32)
while True:
    for event in pygame.event.get():
        if event.type==QUIT:
            exit()
        rand_col=(randint(0,255), randint(0,255), randint(0,255))
    #screen.lock() # 当 Pygame 往 surface 上画东西的时候，首先会把 surface 锁住，以保证不会有其它的进程来干扰
    for _ in range(100):
        rand_pos=(randint(0,639), randint(0,479))
        screen.set_at(rand_pos, rand_col)
        #screen.unlock()
    pygame.display.update()

#随机在屏幕上打印随机颜色

"""
pygame.draw 中函数的第一个参数总是一个 surface ，然后是颜色，再后会是一系列的坐标等。稍有些计算机
绘图经验的人就会知道 ， 计算机里的坐标 ， (0 ， 0) 代表左上角 。 而返回值是一个 Rect 对象 ， 包含了绘制的领域 ，
这样你就可以很方便的更新那个部分了。

rect 绘制矩形
polygon 绘制多边形（三个及三个以上的边）
circle 绘制圆
ellipse 绘制椭圆
arc 绘制圆弧
line 绘制线
lines 绘制一系列的线
aaline 绘制一根平滑的线
aalines 绘制一系列平滑的线

pygame.draw.rect(Surface, color, Rect, width=0)
pygame.draw.polygon(Surface, color, pointlist, width=0)
pygame.draw.circle(Surface, color, pos, radius, width=0)
pygame.draw.ellipse(Surface, color, Rect, width=0)
pygame.draw.arc(Surface, color, Rect, start_angle, stop_angle, width=1)
pygame.draw.line(Surface, color, start_pos, end_pos, width=1)
pygame.draw.lines(Surface, color, closed, pointlist, width=1)
"""
