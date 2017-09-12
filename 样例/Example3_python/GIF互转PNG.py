# http://www.cnblogs.com/dcb3688/p/4608048.html 参考博客
# 从GIF提取帧的代码
from PIL import Image
import sys


def processImage(infile):
    try:
        im = Image.open(infile)
    except IOError:
        print("Cant load", infile)
        sys.exit(1)
    i = 0
    mypalette = im.getpalette()
    try:
        while 1:
            im.putpalette(mypalette)
            new_im = Image.new("RGBA", im.size)
            new_im.paste(im)
            new_im.save('image\\a' + str(i) + '.png')
            i += 1
            im.seek(im.tell() + 1)

    except EOFError:
        pass  # end of sequence

# processImage('fengche.gif')


# 方法一 : 使用imageio 库生成GIF
import imageio
import os
images = []
filenames = sorted(
    ("image/" + fn for fn in os.listdir('image') if fn.endswith('.png')))
print(filenames)
for filename in filenames:
    images.append(imageio.imread(filename))
imageio.mimsave('gif_by_imageio.gif', images, duration=0, subrectangles=True)
# 查看imageio的使用帮助
print(imageio.help('gif'))
print(dir(imageio))


# 方法二 : PIL自身也有一个save方法，里面有一个‘save_all’
# 参数，意思就是save多个，当format指定为gif时，生成的便是gif的动画
from PIL import Image
import os
im = Image.open("./image/a0.png")  # 读取第一帧，将第一个帧的像素设置为gif像素
images = []
gif_image = []
filenames = sorted(("image/" + fn) for fn in os.listdir("image")
                   if fn.endswith(".png"))
for x in filenames:
    gif_image.append(Image.open(x))
print(filenames)
im.save('gif_by_PIL.gif', save_all=True, append_images=gif_image,
        loop=1, duration=1, comment=b"aaabb")
