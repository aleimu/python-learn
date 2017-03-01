import random
 
score = 0
# 纪录游戏的分数
matix = [[0 for i in range(4)] for i in range(4)]
# 初始化生成一个4*4的列表
 
def notzero(s):
    return s if s != 0 else ""
#在window中适合3s，linux上4s
def display():
    print("\r\
          ┌──-┬-──┬─-─┬─-─┐\n\
          │%3s│%3s│%3s│%3s│\n\
          ├─-─┬─-─┬──-┬──-┤\n\
          │%3s│%3s│%3s│%3s│\n\
          ├──-┬──-┬─-─┬──-┤\n\
          │%3s│%3s│%3s│%3s│\n\
          ├──-┬──-┬──-┬─-─┤\n\
          │%3s│%3s│%3s│%3s│\n\
          └──-┴──-┴─-─┴──-┘" \
          % (notzero(matix[0][0]), notzero(matix[0][1]), notzero(matix[0][2]), notzero(matix[0][3]), \
             notzero(matix[1][0]), notzero(matix[1][1]), notzero(matix[1][2]), notzero(matix[1][3]), \
             notzero(matix[2][0]), notzero(matix[2][1]), notzero(matix[2][2]), notzero(matix[2][3]), \
             notzero(matix[3][0]), notzero(matix[3][1]), notzero(matix[3][2]), notzero(matix[3][3]),)
          )
 
 
def init():
# 初始化矩阵
    initNumFlag = 0
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
    display()
 
 
def addRandomNum():
#处理完移动后在空白处添加一个新的随机数
    while 1:
        k = 2 if random.randrange(0, 10) > 1 else 4
        s = divmod(random.randrange(0, 16), 4)
        if matix[s[0]][s[1]] == 0:
            matix[s[0]][s[1]] = k
            break
    display()
 
 
def check():
#检查游戏是否GG，游戏结束的标志是矩阵中所有的数都不为0，而且所有相邻的数都不能合并
    for i in range(4):
        for j in range(3):
            if matix[i][j] == 0 or matix[i][j] == matix[i][j + 1] or matix[j][i] == matix[j + 1][i]:
                return True
    else:
        return False
 
 
def moveRight():
# 向右移动处理函数
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
 
 
def main():
    print("Welcome to the Game of 2048!")
    flag = True
    init()
    while flag:
#循环的标志
        print('You Score:%s'%(score))
        d = input('(↑:w) (↓:s) (←:a) (→:d),(q)quit:')
#不断处理用户输入
        if d == 'a':
            moveLeft()
            if not check():
#检查游戏是否GG
                print('GG')
                flag = False
#GG的话直接退出
        elif d == 's':
            moveDown()
            if not check():
                print('GG')
                flag = False
        elif d == 'w':
            moveUp()
            if not check():
                print('GG')
                flag = False
        elif d == 'd':
            moveRight()
            if not check():
                print('GG')
                flag = False
        elif d == 'q':
# 退出
            break
        else:
# 对用户的其他输入不做处理
            pass
 
if __name__ == '__main__':
    main()
