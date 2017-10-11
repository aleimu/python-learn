#向量小鱼
import pygame
from pygame.locals import*
from sys import exit
from vector2 import *
#http://www.cnblogs.com/duex/p/6703009.html  导入自定义模块的三种方式
# 1. py执行文件和模块同属于同个目录（父级目录）直接import
# 2. 先导入sys模块，然后通过sys.path.append(path) 函数来导入自定义模块所在的目录，导入自定义模块。
#import sys，sys.path.append(r"C:\Users\Pwcong\Desktop\python")，import pwcong
#3. 系统变量，python会扫描path变量的路径来导入模块，可以在系统path里面添加
background_image_filename='./img/background.png'
sprite_image_filename='./img/skier_right1.png'
pygame.init()

screen=pygame.display.set_mode((640,480),0,32)
background=pygame.image.load(background_image_filename).convert()
sprite=pygame.image.load(sprite_image_filename).convert_alpha()
clock=pygame.time.Clock()
position=Vector2(100.0,100.0)
heading=Vector2()
print("position:",position)
print("heading:",heading)

while True:
    for event in pygame.event.get():
        if event.type==QUIT:
            exit()
    screen.blit(background, (0,0))
    screen.blit(sprite, position)
    time_passed=clock.tick()
    time_passed_seconds=time_passed/1000.0
    # 参数前面加 * 意味着把列表或元组展开
    destination=(Vector2(*pygame.mouse.get_pos())-Vector2(*sprite.get_size()))
    destination=((destination.get_x())/2,(destination.get_y())/2)
    # 计算鱼儿当前位置到鼠标位置的向量
    vector_to_mouse=Vector2.from_points(position, destination)
    # 向量规格化
    vector_to_mouse.normalize()
    # 这个 heading 可以看做是鱼的速度，但是由于这样的运算，鱼的速度就不断改变
    # 在没有到达鼠标时，加速运动，超过以后则减速。因而鱼会在鼠标附近晃动。
    heading=heading+(vector_to_mouse*.6)
    position+=heading*time_passed_seconds
    pygame.display.update()
