import pytesseract
from PIL import Image
#pytesseract.pytesseract.tesseract_cmd = 'C:\\Python36-32\\Scripts\\pytesseract.exe'    #这个是假的！
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files (x86)\Tesseract-OCR\tesseract.exe'

image = Image.open('./test.png')
#image = Image.open('./fHtT.bmp')   #对识别斜体的效果比较差
#image = Image.open('./fHtT.png')

#image = Image.open(r'C:\Users\lWX307086\Desktop\python_learn-master\未上传文件\验证码识别\fHtT.png')
vcode = pytesseract.image_to_string(image)
print(vcode)


"""
必须先安装tesseract软件，tesseract-ocr-setup-3.01-1.rar解压安装即可。
再安装pytesseract
pip install pytesseract

遇到的问题:

1.FileNotFoundError: [WinError 2] 系统找不到指定的文件

解决方法:

方法1[推荐]: 将tesseract.exe添加到环境变量PATH中，
例如: D:\Tesseract-OCR,默认路径为C:\Program Files (x86)\Tesseract-OCR
注意: 为了使环境变量生效，需要关闭cmd窗口或是关闭pycharm等ide重新启动

方法2: 修改pytesseract.py文件，指定tesseract.exe安装路径
# CHANGE THIS IF TESSERACT IS NOT IN YOUR PATH, OR IS NAMED DIFFERENTLY
tesseract_cmd = 'C:\\Program Files (x86)\\Tesseract-OCR\\tesseract.exe‘

方法3:  在实际运行代码中指定
pytesseract.pytesseract.tesseract_cmd = 'D:\\Tesseract-OCR\\tesseract.exe'

2.pytesseract.pytesseract.TesseractError: (1, 'Error opening data file \\Tesseract-OCR\\tessdata/eng.traineddata')

解决方法:

方法1[推荐]:
将tessdata目录的上级目录所在路径(默认为tesseract-ocr安装目录)添加至TESSDATA_PREFIX环境变量中
例如: C:\Program Files (x86)\Tesseract-OCR
Please make sure the TESSDATA_PREFIX environment variable is set to the parent directory of your "tessdata" directory.


方法2:  在.py文件配置中指定tessdata-dir
tessdata_dir_config = '--tessdata-dir "D:\\Tesseract-OCR\\tessdata"'
# tessdata_dir_config = '--tessdata-dir "'C:\\Program Files (x86)\\Tesseract-OCR\\tessdata"'
pytesseract.image_to_string(image, config=tessdata_dir_config)
附: trainedata下载地址: the latest from github.com


try:
    import Image
except ImportError:
    from PIL import Image
import pytesseract

pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files (x86)\Tesseract-OCR\tesseract.exe'
# print(pytesseract.image_to_string(Image.open('./test.png')))
print(pytesseract.image_to_string(Image.open('./chi.bmp'), lang='eng+chi_sim'))
#print(pytesseract.image_to_string(Image.open('fHtT.png'), lang='eng'))
#print(pytesseract.image_to_string(Image.open('test-european.jpg'), lang='fra'))


tesseract的本身用法：
在终端或者命令行中输入
tesseract imagename outputbase [-l lang] [-psmpagesegmode] [configfile...]

例子：
识别myscan.png 到out.txt:
tesseract myscan.png out
指定识别数据包(英文加中文简体）
tesseract myscan.png out -l eng+chi_sim
使用工具生成pdf(Hocr2PDF)
tesseract myscan.png out hocr
直接生成pdf
tesseract myscan.png out pdf
"""
