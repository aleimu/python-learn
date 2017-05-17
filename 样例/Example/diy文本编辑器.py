from tkinter import *  #引用Tk模块
from tkinter.messagebox import *  #这是弹出窗口
from tkinter.filedialog import *  #弹窗式加载新文件>filedialog很重要！
import os
#from email.policy import default
#from setuptools.sandbox import save_argv
#from asyncio.protocols import Protocol  #事件驱动

filename=''	#作为全局变量，后面进程用到


#开始写编辑器的函数
#创建下拉菜单File，然后将其加入到顶级的菜单栏中
###########################################函数部分##########################	
class DIY():
	def newfile():
		global filename
		root.title('未命名文件')
		filename=None
		textPad.delete(1.0,END)
		
	def openfile():#打开文件函数           文件名应该是全局变量，因为还可能需要保存
		global filename#使用全局变量
		filename=askopenfilename(defaultextension='.txt')#提供一个打开的方式   默认的扩展名.txt
		if filename=='': #如果打开的文件是空的，设置为空
			filename=None
		else:#如果不为空，就加载到title上
			root.title('FileName:'+os.path.basename(filename))#找到实际路径
			#如果打开的手编辑器里面有正在编写的内容，就要清空原来的内容
			if textPad.get(1.0, END) != "":
				showinfo('提示', '先保存吧!')
			textPad.delete(1.0, END)#删除从头到尾   第一行的第0列
			f=open(filename,'r')#打开文件
			textPad.insert(1.0,f.read())#插入内容，从1.0处插入
			f.close()#关闭文件   
	#保存和另存为
	#保存时保存在到一个默认的地址
	#另存是需要弹出一个对话框去存储你要存取的地址
	def save():#封装保存
		global filename
		#如果文件存在的话就是直接保存在默认的路径
		#如果不存在的话就是另存为一个新的文件
		try:
			f=open(filename,'w')
			msg=textPad.get(1.0,END)
			f.write(msg)
			f.close()
		except:
			DIY.saves()
	def saves():#文件的另存为保存
		f=asksaveasfilename(initialfile='未命名.txt',defaultextension='.txt')#初始化文件名和后缀名
		global filename
		filename =f
		fh=open(f,'w')#打开文件写文件
		msg=textPad.get(1.0,END)#写入的内容得到
		fh.write(msg)#写入内容到文件
		fh.close()
		root.title('Filename:'+os.path.basename(f))#存储文件
	def exit():
		  print("退出")
		  
	#创建另一个下拉菜单Edit
	#复制粘贴撤销重做
	def cut():
		textPad.event_generate('<<Cut>>')
		
	def copy():
		textPad.event_generate('<<Copy>>')
		
	def paste():
		textPad.event_generate('<<Paste>>')
		
	def redo():
		textPad.event_generate('<<Redo>>')
		
	def undo():
		textPad.event_generate('<<Undo>>')
	#这里要用到自定义窗体，弹出窗体toplevel,查看前面代码
	def search():
		#创建弹出窗口进行查找
		topsearch=Toplevel(root)
		topsearch.geometry('200x100+100+150')
		label1=Label(topsearch,text='Find')
		label1.grid(row=0,column=0,padx=5)  #显示
		entry1=Entry(topsearch,width=20)
		entry1.grid(row=0,column=1,padx=5)
		button1=Button(topsearch,text='查找')
		button1.grid(row=0,column=2)
	#全选
	def selectAll():
		textPad.tag_add('sel', '1.0',END)
	def replace():
		  print("替换")
	def replaceall():
		  print("替换全部")
		  
	#创建下拉菜单Help
	def help():
		  print("帮助")
		#about实现
	def author():#将函数与about进行了绑定
		showinfo('作者信息', 'LGJ——python')
	def about(): 
		showinfo('版权信息。copyright', 'LGJ')	

	

class strdiy():
      pass
#搜索的弹框
class PopupEntry:
	def __init__(self, parent=None,default_value='', callback=None):
		self.callback = callback
		self.top = Toplevel(parent)
		Label(self.top, text="请输入:").grid(row=0)
		self.e = Entry(self.top)
		self.e.grid(row=0,column=1)
		Button(self.top, text="确定", command=self.ok).grid(row=1)
		Button(self.top, text="取消", command=self.top.destroy).grid(row=1,column=1)
		self.__set(default_value)
		self.e.bind('<Double-1>', lambda *args:self.e.delete(0,END))
		self.e.bind('<Return>', self.on_return)
		self.top.maxsize(200,60)
		self.top.resizable(False,False)
		self.top.title('搜索')

	def on_return(self,event):
		self.ok()
 
	def ok(self):
		#print "value is", self.e.get()
		if self.callback and callable(self.callback):
			self.callback(self.e.get())
		self.top.destroy()

	def find_char(self):
		target = simpledialog.askstring("简易文本编辑器","寻找字符串")
		if target:
			end = self.st.index(tk.END)
			endindex = end.split(".")
			end_line = int(endindex[0])
			end_column = int(endindex[1])
			pos_line =1
			pos_column=0
			length =len(target)
			while pos_line <= end_line :
				if pos_line == end_line and pos_column +length > end_column:
					break
				elif pos_line < end_line and pos_column + length >100:
					pos_line = pos_line + 1
					pos_column = 100 - (pos_column + length)
					if pos_column > end_column:
						break
				else:
					pos = str(pos_line)+"."+str(pos_column)
					where = self.st.search(target,pos,tk.END)
					if  where:
						print(where)
						where1 =where.split(".")
						sele_end_col = str(int(where1[1])+length)
						sele = where1[0] + "."+ sele_end_col
						self.st.tag_add(tk.SEL,where,sele)
						self.st.mark_set(tk.INSERT,sele)
						self.st.see(tk.INSERT)
						#self.st.focus()
				 
						again = messagebox.askokcancel(title = "继续查询么")
						if again:
							pos_line = int(where1[0])
							pos_column = int(sele_end_col)
						else:
							aa=messagebox.showinfo(title = "你终于还是放弃了我",message = "你放弃了我--!")
							if aa:
								sys.exit()
###########################################窗体部分##########################		
root = Tk()	#初始化Tk()
root.title("刘国进的编辑器") #框框的标题
root.geometry('800x500+100+100') #构建一个矩形窗体    初始化的显示位置 (100 , 100)  大小  800x500		
#创建顶级的菜单
menubar=Menu(root)
#创建下拉菜单 File，然后将其加入到顶级的菜单栏中
filemenu = Menu(menubar,tearoff=0)
filemenu.add_command(label='新建',accelerator='Ctrl + N',command=DIY.newfile)#accelerator 快捷键，  new  点击事件函数
filemenu.add_command(label='打开',accelerator='Ctrl + O',command=DIY.openfile)
filemenu.add_command(label='保存',accelerator='Ctrl + S',command=DIY.save)
filemenu.add_command(label='另存为',accelerator='Ctrl + Shift + S',command=DIY.saves)
filemenu.add_separator()#添加一条线分割
filemenu.add_command(label="退出", command=root.quit)
menubar.add_cascade(label="文件", menu=filemenu)# 创建的功能点filemenu归类在File中
#创建另一个下拉菜单Edit
editmenu=Menu(menubar)
editmenu.add_command(label='撤销',accelerator='Ctrl + Z',command=DIY.undo)
editmenu.add_command(label='恢复',accelerator='Ctrl + Y',command=DIY.redo)
editmenu.add_separator()#分隔符
editmenu.add_command(label='剪切',accelerator='Ctrl + X',command=DIY.cut)
editmenu.add_command(label='复制',accelerator='Ctrl + C',command=DIY.copy)
editmenu.add_command(label='粘贴',accelerator='Ctrl + V',command=DIY.paste)
editmenu.add_separator()#分隔符
editmenu.add_command(label='查找',accelerator='Ctrl + F',command=DIY.search)
editmenu.add_command(label='全选',accelerator='Ctrl + A',command=DIY.selectAll)
editmenu.add_separator()#分隔符
editmenu.add_command(label='替换',accelerator='Ctrl + H',command=DIY.replace)
editmenu.add_command(label='替换全部',accelerator='Ctrl + H',command=DIY.replaceall)
menubar.add_cascade(label='编辑',menu=editmenu)
#创建下拉菜单Help
aboutmenu=Menu(menubar)
aboutmenu.add_command(label='作者',command=DIY.author)#command  对应的函数定义在前面
aboutmenu.add_command(label='版权',command=DIY.about)
menubar.add_cascade(label='关于',menu=aboutmenu)
#显示菜单
root.config(menu=menubar)

#将菜单可以使用右键调出 
def printItem(): 
    print ('popup menu') 
filemenu = Menu(menubar,tearoff = 0) 
for k in ['Python','PHP','CPP','C','Java','JavaScript','VBScript']: 
    filemenu.add_command(label = k,command = printItem) 
menubar.add_cascade(label = 'Language',menu = filemenu)
#此时就不要将 root 的 menu 设置为 menubar了 
#root['menu'] = menubar 
def popup(event): 
    #显示菜单 
    menubar.post(event.x_root,event.y_root) 
#在这里相应鼠标的右键事件，右击时调用 popup,此时与菜单绑定的是 root，可以设置为其
#它的控件，在绑定的控件上右击就可以弹出菜单 
root.bind('<Button-3>',popup) 
"""
事件Events 和 Bindings
事件的分类
enentformats：<Button-1>点击左键<Button-2>点击右键<B1-Motion>左键移动<ButtonRelease-1>左键释放<Double-Button-1>双击左键<Enter>进入<Leave>离开<FocusIn><FocusOut><Return><Key>
enent attributes：widget,x,y,x_root,y_root,keycode(),num(),width,height,type
protocol
实现事件方式
command    按钮级别
bind（绑定）  按钮级别
protacl（协议监听）系统级别
"""

#放个背景图
"""
bm = PhotoImage(file = "e://11.PNG") 
la = Label(root, text="show", bg="green", font=("Arial", 12), width=500, height=200,image = bm,compound = 'center')
la.pack(side=LEFT)  #这里的side可以赋值为 LEFT  RTGHT  TOP  BOTTOM
"""

textPad=Text(root,undo=True)
textPad.pack(expand=YES, fill=BOTH)#允许进行扩展 ,填充X，Y轴

scroll=Scrollbar(textPad)#右侧的移动下滑栏
textPad.config(yscrollcommand=scroll.set)#在Y轴显示   yscrollcommand
scroll.config(command=textPad.yview)#这是为了让编辑内容和下拉栏同时移动
scroll.pack(side=RIGHT,fill=Y)#显示



mainloop()
