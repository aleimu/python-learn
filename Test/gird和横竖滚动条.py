from tkinter.ttk import *
from tkinter import *
root = Tk()
root.geometry("820x300")
#参考博客 http://www.cnblogs.com/Tommy-Yu/p/4171006.html 
tv = ttk.Treeview(root, height =10,columns=('c1','c2','c3'))
for i in range(100):
    tv.insert('',i,values=('a'+str(i),'b'+str(i),'c'+str(i)))
'''
tv.column('col1', width=100, anchor='center')
tv.column('col2', width=100, anchor='center')
tv.column('col3', width=100, anchor='center')
tv.heading('col1', text='col1')
tv.heading('col2', text='col2')
tv.heading('col3', text='col3')
'''
tv.pack()
''' 
#----vertical scrollbar------------
vbar = ttk.Scrollbar(root,orient=VERTICAL,command=tv.yview)
tv.configure(yscrollcommand=vbar.set)
tv.grid(row=0,column=0,sticky=NSEW)
vbar.grid(row=0,column=1,sticky=NS)
'''
''' 
#----horizontal scrollbar----------
hbar = ttk.Scrollbar(root,orient=HORIZONTAL,command=tv.xview)
tv.configure(xscrollcommand=hbar.set)
hbar.grid(row=1,column=0,sticky=EW)
'''
#添加竖条滚动
vbar = ttk.Scrollbar(root, orient=VERTICAL, command = tv.yview)
tv.configure(yscrollcommand=vbar.set)
tv.grid(row=0)
vbar.grid(row=0, column=1,sticky=NS)

#添加横条滚动 不能用
hbar = ttk.Scrollbar(root,orient=HORIZONTAL,command=tv.xview)
tv.configure(xscrollcommand=hbar.set)
hbar.rowconfigure(1,weight=1)
hbar.columnconfigure(0,weight=1)
hbar.grid(row=1,column=0,sticky=EW)
'''
#如何将ttk treeview中的内容清空
items = tv.get_children()
[tv.delete(item) for item in items]
'''
root.mainloop()


