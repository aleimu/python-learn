from PIL import Image, ImageFilter

class MyGaussianBlur(ImageFilter.Filter):
    name = "GaussianBlur"

    def __init__(self, radius=0.2, bounds=None):
        self.radius = radius
        self.bounds = bounds

    def filter(self, image):
        if self.bounds:
            clips = image.crop(self.bounds).gaussian_blur(self.radius)
            image.paste(clips, self.bounds)
            return image
        else:
            return image.gaussian_blur(self.radius)
simg = 'e:\\demo.jpg'
dimg = 'e:\\demo_blur.jpg'
image = Image.open(simg)
image = image.filter(MyGaussianBlur(radius=50,bounds=(100,1,300,300)))
image.save(dimg)
print (dimg, 'success')
