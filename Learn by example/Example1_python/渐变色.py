#渐变色
#!/usr/bin/env python
import pygame
from pygame.locals import *
from sys import exit
pygame.init()
screen=pygame.display.set_mode((640,480),RESIZABLE,32)
def create_scales(height):
    red_scale_surface=pygame.surface.Surface((640, height))
    for x in range(640):
        c=int((x/640.)*255.)
        red=(c,0,0)
        #打印640个单独色阶 Rect(left, top, width, height) -> Rect
        line_rect=Rect(x,0,1, height)
        #print(line_rect) --><rect(471, 0, 1, 80)>
        #pygame.draw.rect(screen, color, pos, width),下面的方式怎么解释？
        #渐变色的处理方式？
        pygame.draw.rect(red_scale_surface, red, line_rect)
    return red_scale_surface
red_scale=create_scales(240)
color=[127,127,127]
while True:
    for event in pygame.event.get():
        if event.type==QUIT:
            exit()
    screen.fill((0,0,0))
    #打印三个色阶卡
    screen.blit(red_scale, (0,00))
    x, y=pygame.mouse.get_pos()
    #获取在x轴上的移动
    if pygame.mouse.get_pressed()[0]:
        if y > 0 and y < (1)*240:
            color[0]=int((x/639.)*255.) #255色阶分在639单位上，加.是因为当成float，其实python3不用加
    pygame.display.set_caption("PyGame 颜色卡 -"+str(tuple(color)))
    pygame.draw.rect(screen,tuple(color), (0,240,640,240))
    pygame.display.update()

"""
在游戏中我们往往使用 RGBA 图像 ， 这个 A 是 alpha ，
也就是表示透明度的部分 ， 值也是 0~255 ， 0 代表完全透明 ， 255 是完全不透明 ， 而像 100 这样的数字 ， 代表部
分透明。你可以使用多种软件创建含有 Alpha 通道的图片


"""
