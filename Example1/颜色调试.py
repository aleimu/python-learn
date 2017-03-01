from tkinter import *
import colorsys
#操作后的响应函数
def update(* args):
    'color'
    r,g,b = colorsys.hls_to_rgb(h.get() / 255.0, l.get() / 255.0, s.get() / 255.0)
    r,g,b = r * 255, g * 255, b * 255
    rgb.configure(text = 'RGB:(%d, %d, %d)' % (r, g, b))
    c.configure(bg = '#%02X%02X%02X' %(r, g, b))

root = Tk()
root.title("从hls转换到rgb")
hue = Label(root, text = 'Hue')
hue.grid(row = 0, column = 0)

light = Label(root, text = 'Lightness')
light.grid(row = 0, column = 1)

sat = Label(root, text = 'Saturation')
sat.grid(row = 0, column = 2)
#初始化颜色为rgb的000，也就是纯黑色
rgb = Label(root, text = 'RGB(0, 0, 0)')
rgb.grid(row = 0, column = 3)


h = Scale(root, from_ = 255, to = 0, command = update)
h.grid(row = 1, column = 0)

l = Scale(root, from_ = 255, to = 0, command = update)
l.grid(row = 1, column = 1)

s = Scale(root, from_ = 255, to = 0, command = update)
s.grid(row = 1, column = 2)

c = Canvas(root, width = 100, height = 100, bg = 'Black')
c.grid(row = 1, column = 3)

root.mainloop()
