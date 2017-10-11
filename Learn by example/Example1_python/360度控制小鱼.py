#360方向 控制小鱼
background_image_filename='./img/background.png'
sprite_image_filename='./img/skier_right1.png'
import pygame
from pygame.locals import *
from sys import exit
from vector2 import *
from math import *

pygame.init()
screen=pygame.display.set_mode((640,480),0,32)
background=pygame.image.load(background_image_filename).convert()
sprite=pygame.image.load(sprite_image_filename).convert_alpha()
clock=pygame.time.Clock()

# 让 pygame 完全控制鼠标
pygame.mouse.set_visible(True) #鼠标可见
pygame.event.set_grab(True)

sprite_pos=Vector2(200,150) # 初始位置
sprite_speed=300. # 每秒前进的像素数（速度）
sprite_rotation=-180. # 初始角度
sprite_rotation_speed=360.# 每秒转动的角度数（转速）

while True:
    for event in pygame.event.get():
        if event.type==QUIT:
            exit()
        # 按 Esc 则退出游戏
        if event.type==KEYDOWN and event.key==K_ESCAPE:
            exit()
    pressed_keys=pygame.key.get_pressed()
    # 这里获取鼠标的按键情况
    pressed_mouse=pygame.mouse.get_pressed()
    # 通过移动偏移量计算转动
    rotation_direction=pygame.mouse.get_rel()[0]/5.0
    #运动方向
    rotation_direction=0.
    #旋转方向
    movement_direction=0.
    # 更改角度
    if pressed_keys[K_LEFT]:
        rotation_direction=+1.
    if pressed_keys[K_RIGHT]:
        rotation_direction=-1.
    # 前进、后退
    # 多了一个鼠标左键按下的判断
    if pressed_keys[K_UP]or pressed_mouse[0]:
        movement_direction=+1.
    # 多了一个鼠标右键按下的判断
    if pressed_keys[K_DOWN]or pressed_mouse[2]:
        movement_direction=-1.
    screen.blit(background, (0,0))
    # 获得一条转向后的鱼
    rotated_sprite=pygame.transform.rotate(sprite, sprite_rotation)
    # 转向后，图片的长宽会变化，因为图片永远是矩形，为了放得下一个转向后的矩形，外接的矩形势必会比较大
    w, h=rotated_sprite.get_size()
    # 获得绘制图片的左上角
    sprite_draw_pos=Vector2(sprite_pos.x-w/2, sprite_pos.y-h/2)
    screen.blit(rotated_sprite, sprite_draw_pos)
    time_passed=clock.tick()
    time_passed_seconds=time_passed/1000.0
    # 图片的转向速度也需要和行进速度一样，通过时间来控制
    sprite_rotation+=rotation_direction*sprite_rotation_speed*time_passed_seconds
    # 获得前进（ x 方向和 y 方向 ） ，这两个需要一点点三角的知识
    heading_x=sin(sprite_rotation*pi/180.)
    heading_y=cos(sprite_rotation*pi/180.)
    # 转换为单位速度向量
    heading=Vector2(heading_x, heading_y)
    # 转换为速度
    heading*=movement_direction
    sprite_pos+=heading*sprite_speed*time_passed_seconds
    pygame.display.update()



"""
总结一下 pygame.mouse 的函数：
• pygame.mouse.get_pressed —— 返回按键按下情况 ， 返回的是一元组 ， 分别为 ( 左键 , 中键 , 右键 ) ，
如按下则为 True
• pygame.mouse.get_rel —— 返回相对偏移量， (x 方向 , y 方向 ) 的一元组
• pygame.mouse.get_pos —— 返回当前鼠标位置 (x, y)
• pygame.mouse.set_pos —— 显而易见，设置鼠标位置
• pygame.mouse.set_visible —— 设置鼠标光标是否可见
• pygame.mouse.get_focused —— 如果鼠标在 pygame 窗口内有效，返回 True
• pygame.mouse.set_cursor —— 设置鼠标的默认光标式样 ， 是不是感觉我们以前做的事情白费了？哦
不会，我们使用的方法有着更好的效果。
• pyGame.mouse.get_cursor —— 不再解释。
"""

