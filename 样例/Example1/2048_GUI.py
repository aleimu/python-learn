from tkinter import *
import sys
import random
import os
from tkinter.messagebox import *
#这是弹出窗口
score = 0
# 纪录游戏的分数
matix = [[0 for i in range(4)] for i in range(4)]
# 初始化生成一个4*4的列表
 
def init():
# 初始化矩阵
    initNumFlag = 0
    #引用matix全局变量
    global score
    score=0
    global matix
    matix = [[0 for i in range(4)] for i in range(4)]
    while 1:
        k = 2 if random.randrange(0, 10) > 1 else 4
        # 当生成随机数大于1的时候k=2否则k=4 生成2和4的概率为9：1
        s = divmod(random.randrange(0, 16), 4)
        # 生成矩阵初始化的下标,返回商和余数，也就是行和列
        if matix[s[0]][s[1]] == 0:
        # 只有当其值为0的时候才赋值，避免第二个值重复放在第一個值的位置上
            matix[s[0]][s[1]] = k
            initNumFlag += 1
            #初始化第二個值
            if initNumFlag == 2:
                break
 
#处理完移动后在空白处添加一个新的随机数
def addRandomNum():
    while 1:
        k = 2 if random.randrange(0, 10) > 1 else 4
        s = divmod(random.randrange(0, 16), 4)
        if matix[s[0]][s[1]] == 0:
            matix[s[0]][s[1]] = k
            break
 
 #检查游戏是否GG，游戏结束的标志是矩阵中所有的数都不为0，而且所有相邻的数都不能合并
def check():
    for i in range(4):
        for j in range(3):
            if matix[i][j] == 0 or matix[i][j] == matix[i][j + 1] or matix[j][i] == matix[j + 1][i]:
                return True
    else:
        return False
 
 # 向右移动处理函数
def moveRight():
    global score
    for i in range(4):
        for j in range(3, 0, -1):
            for k in range(j - 1, -1, -1):
                if matix[i][k] > 0:
                    if matix[i][j] == 0:
                        matix[i][j] = matix[i][k]
                        matix[i][k] = 0
                    elif matix[i][j] == matix[i][k]:
                        matix[i][j] *= 2
                        score += matix[i][j]
                        #将当前数作为score加上
                        matix[i][k] = 0
                    break
    addRandomNum()
 
 # 向上移动处理函数
def moveUp():
    global score
    for i in range(4):
        for j in range(3):
            for k in range(j + 1, 4):
                if matix[k][i] > 0:
                    if matix[j][i] == 0:
                        matix[j][i] = matix[k][i]
                        matix[k][i] = 0
                    elif matix[k][i] == matix[j][i]:
                        matix[j][i] *= 2
                        score += matix[j][i]
                        matix[k][i] = 0
                    break
    addRandomNum()
 
#当用户输入向下移动的时候，所有的数字都向下移动，如果碰到相同的数字要和并，有数字的方块向没有数字的方块移动
#向下滑动，则先处理最下面的两个行(不一定要相邻)
def moveDown():
    global score
    for i in range(4):
        for j in range(3, 0, -1):
            for k in range(j-1, -1, -1):
                if matix[k][i] > 0:
                    if matix[j][i] == 0:
                        matix[j][i] = matix[k][i]
                        matix[k][i] = 0
                    elif matix[j][i] == matix[k][i]:
                        matix[j][i] *= 2
                        score += matix[j][i]
                        matix[k][i] = 0
                    break
    addRandomNum()	
 # 向左移动处理函数
def moveLeft():
    global score
    for i in range(4):
        for j in range(3):
            for k in range(1 + j, 4):
                if matix[i][k] > 0:
                    if matix[i][j] == 0:
                        matix[i][j] = matix[i][k]
                        matix[i][k] = 0
                    elif matix[i][j] == matix[i][k]:
                        matix[i][j] *= 2
                        score += matix[i][j]
                        matix[i][k] = 0
                    break
    addRandomNum()
 
 #将matix中的元素刷入到gui的数组中
def refreshGui():
    n = 4
    B["text"]=("得分:",score)
    B.pack()
    for i in range(n):
        for j in range(n):
            if matix[i][j] == 0:
                button_list[i][j]['text'] = ' '
            else:
                button_list[i][j]['text'] = matix[i][j]
 
''' 
#定义的方法 监听键盘事件
def printkey(event):
    flag = True
    print('input: ' + event.char)
    input_chr = event.char
    if input_chr == "z":
        print("重置游戏!")
        init()
        refreshGui()
    elif input_chr == "q":
        sys.exit(0)
        flag = False
    else:
		#不断处理用户输入
        if input_chr == 'a':
            moveLeft()
            if not check():
			#检查游戏是否GG
                print('GG')
                flag = False
                sys.exit(0)
		#GG的话直接退出
        elif input_chr == 's':
            moveDown()
            if not check():
                print('GG')
                flag = False
                sys.exit(0)
        elif input_chr == 'w':
            moveUp()
            if not check():
                print('GG')
                flag = False
                sys.exit(0)
        elif input_chr == 'd':
            moveRight()
            if not check():
                print('GG')
                flag = False
                sys.exit(0)
        else:
			# 对用户的其他输入不做处理
            pass
    refreshGui()
    print('You Score:%s'%(score))
''' 

 #定义的方法 监听键盘事件
flag = True
def printkey(event):
    global flag
    if flag:    
        print('input: ' + event.char)
        input_chr = event.char
        if input_chr == "z":
            print("重置游戏!")
            init()
            refreshGui()
        elif input_chr == "q":
            flag = False
            print("======")
        else:
            #不断处理用户输入
            if input_chr == 'a':
                moveLeft()
                if not check():
                #检查游戏是否GG
                    print('GG')
                    flag = False
            #GG的话直接退出
            elif input_chr == 's':
                moveDown()
                if not check():
                    print('GG')
                    flag = False
            elif input_chr == 'w':
                moveUp()
                if not check():
                    print('GG')
                    flag = False
            elif input_chr == 'd':
                moveRight()
                if not check():
                    print('GG')
                    flag = False
            else:
                # 对用户的其他输入不做处理
                pass
            refreshGui()
    else:
        messagebox.showinfo(title = "游戏分数",message =score)
        sys.exit(0)    
    print('You Score:%s'%(score))

iwindow = Tk()
iwindow.title("2048")
iwindow.geometry('220x300')
button_list = []
num_game_list = 4
A=Label(iwindow)
A.pack(side="top")

#初始化2048矩阵，显示16格
for i in range(num_game_list):
    button_list.append([])
    for j in range(num_game_list):             
         
        button = Button(A)
        button['text'] = ' '            
        button['width'] = 6
        button['height'] = 3             
        button.grid(row = i,column = j)
        button_list[i].append(button)
 
B=Label(iwindow) #在这里定义一个显示分数的控件，但分数会随玩的过程变动，Label的text属性放在了上面随refreshGui()一起变动！！！
iwindow.bind_all('<Key>', printkey)
#显示窗体
iwindow.mainloop()
