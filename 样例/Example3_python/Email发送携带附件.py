#encoding=utf-8
import smtplib
from email.mime.text import MIMEText
from email.header import Header
from email.mime.image import MIMEImage
from email.mime.multipart import MIMEMultipart

#发送人
sender = "XXXXX@qq.com"
#接受人
receivers = ["XXXXXX@qq.com"]
#ping smtpscn.huawei.com 查看时否能ping通，如果不通，在/etc/hosts中追加 “10.3.17.46   smtpscn.huawei.com”
mail_host = "smtpscn.huawei.com"
#工号
mail_user = "__name__"
#密码
mail_pwd = "mail_pwd"
#邮箱端口
mail_port = 25

#发送HTML邮件
#貌似只支持内联样式,js好像也不能用
def sendHtml():
    mess = '''
    <h1 style="color:red">Hello world!</h1>
    <a href="http://www.huawei.com" onclick="alert(123);">HUAWEI</a>
    '''
    message = MIMEText(mess,'html','utf-8')
    message['From'] = Header(mail_user,'utf-8')
    message['To'] = Header(", ".join(receivers),'utf-8')
    message['Subject'] = Header("python email demo",'utf-8')
    try:
        smtpObj = smtplib.SMTP()
        smtpObj.connect(mail_host,mail_port)
        print ("connected to smtp server,success.")
        smtpObj.login(mail_user,mail_pwd)
        smtpObj.sendmail(sender,receivers,message.as_string())
        print ("send email success")
    except e:
        print (str(e))
    finally:
        if smtpObj:
            smtpObj.close()

#发送带图片的HTML邮件
def sendImage():
    mess = '''
    <h1 style="color:red">Hello world!</h1>
    <a href="http://www.huawei.com">HUAWEI</a>
    <p>
        <img src="cid:imgID" />
    </p>
    '''
    msgRoot = MIMEMultipart("related")
    msgRoot['From'] = Header(mail_user,'utf-8')
    msgRoot['To'] = Header(", ".join(receivers),'utf-8')
    msgRoot['Subject'] = Header("python email demo",'utf-8')
    msgRoot.attach(MIMEText(mess,'html',"utf-8"))
    with open('C:\\Python36-32\\mygame\\pygame_dome\\img\\background.png',"br") as img:
        msgImage = MIMEImage(img.read())
    msgImage.add_header('Content-ID',"<imgID>")
    msgRoot.attach(msgImage)
    try:
        smtpObj = smtplib.SMTP()
        smtpObj.connect(mail_host,mail_port)
        print ("connected to smtp server,success.")
        smtpObj.login(mail_user,mail_pwd)
        smtpObj.sendmail(sender,receivers,msgRoot.as_string())
        print ("send email success")
    except e:
        print (str(e))
    finally:
        if smtpObj:
            smtpObj.close()

#发送附件
def sendFile():
    mess = '''
    <h1 style="color:red">Hello world!</h1>
    <a href="http://www.huawei.com">HUAWEI</a>
    <p>
        <img src="cid:imgID" />
    </p>
    '''
    msgRoot = MIMEMultipart("related")
    msgRoot['From'] = Header(mail_user,'utf-8')
    msgRoot['To'] = Header(", ".join(receivers),'utf-8')
    msgRoot['Subject'] = Header("python email demo",'utf-8')
    msgRoot.attach(MIMEText(mess,'html',"utf-8"))
    #文本附件
    with open("C:\Python36-32\mygame\ctypes库\emailDemo.py","r",encoding="utf-8") as f:
        txt = MIMEText(f.read())
    txt["Content-Type"] = "application/octet-stream"
    txt["Content-Disposition"] = "attachment; filename=emailDemo.py"
    msgRoot.attach(txt)

    #图片附件
    with open('C:\\Python36-32\\mygame\\pygame_dome\\img\\background.png',"br") as img:
        msgImage = MIMEImage(img.read())
    msgImage["Content-Type"] = "application/octet-stream"
    msgImage["Content-Disposition"] = "attachment; filename=email.PNG"
    msgRoot.attach(msgImage)
    #html中插入图片
    with open("C:\\Python36-32\\mygame\\pygame_dome\\img\\background.jpg","br") as img:
        msgImage = MIMEImage(img.read())
    msgImage.add_header('Content-ID',"<imgID>")
    msgRoot.attach(msgImage)
    try:
        smtpObj = smtplib.SMTP()
        smtpObj.connect(mail_host,mail_port)
        print ("connected to smtp server,success.")
        smtpObj.login(mail_user,mail_pwd)
        smtpObj.sendmail(sender,receivers,msgRoot.as_string())
        print ("send email success")
    except  e:
        print (str(e))
    finally:
        if smtpObj:
            smtpObj.close()

if __name__ == '__main__':
    sendHtml()
    sendImage()
    sendFile()
