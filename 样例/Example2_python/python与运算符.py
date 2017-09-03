# coding=utf-8
#两个数字相加
sumNumber=1+2
print(sumNumber)      #输出结果：3

#两个字符串相加
sumString="Nice work"
print(sumString)      #输出结果：Nice work

#两个数字相减
subNumber=2-1
print(subNumber)      #输出结果：1

#两个数字相乘或者字符串重复
multiplicationNumber=2*3
print(multiplicationNumber)      #输出结果：6
multiplicationString="hello"*2
print(multiplicationString)      #输出结果：hellohello
#/---关于*号重复字符串之前的博客已经介绍过了---/

#两个数相除
divisionNumber=9/2
print(divisionNumber)      #输出结果：4
divisionNumber=9.0/2
print(divisionNumber)      #输出结果：4.5
divisionNumber=9/2.0
print(divisionNumber)      #输出结果：4.5
#/---除数或被除数中有任意一个是小数的话，商也会保留小数，反之取整---/

#求幂运算
powerNumber=2**3 #相当于2的3次幂，就是2*2*2 关于幂运算大家应该在数学里都很熟悉了
print powerNumber       #输出结果：8

#小于符号，返回值是bool值
lessThan=1<2
print(lessThan)        #输出结果：True
lessThan=1<1
print(lessThan)        #输出结果：False

#大于符号，返回值是bool值
moreThan=2>1
print(moreThan)        #输出结果：True
moreThan=2>2
print(moreThan)        #输出结果：False

#不等于符号 返回值是Bool值
notEqual=1!=2
print(notEqual)        #输出结果：True
notEqual=1!=1
print(notEqual)        #输出结果：False

#除法运算// 返回商的整数部分，抛弃余数
divisorNumber=10//3
print(divisorNumber)        #输出结果：3

#除法运算% 返回商的余数部分，抛弃商
divisorNumber=10%3
print(divisorNumber)        #输出结果：1
divisorNumber=10%1
print(divisorNumber)        #输出结果：0 /--没有余数则返回0--/
divisorNumberx=10//3         #divisorNumberx是商的整数部分
divisorNumbery=10%3         #divisorNumbery是余数
divisorNumberz=3*divisorNumberx+divisorNumbery    #divisorNumberz是除数乘以商的整数部分加上余数，得到的divisorNumberz的值就是被除数
print(divisorNumberz)        #输出结果：10

#按位与运算&， 按位与是指一个数字转化为二进制，然后这些二进制的数按位来进行与运算
operationNumber=7&18
print operationNumber        #输出结果：2
'''
这个有点绕，稍微多说下，如果对二进制不是太熟的朋友，可以打开电脑自带的计算器，按住win+q,输入"calculator"。
然后在打开的计算器设置成程序员模式， 就是View(查看)->>programmer(程序员).
然后我们将7转为二进制:111,自动补全8位：00000111，然后将18转为二进制补全8位后得到：00010010
最后将   00000111
跟       00010010 按位进行与运算，
/-
对与运算不熟的朋友可以看看百度百科的介绍，还是很详细的。
http://baike.baidu.com/link?url=lfGJREBvGCY5j7VdF2OO9n2mtIbSyNUD7lZyyY74QIetguL5lXIQUxY38Yr-p4z4WdUvHUKGjw9CDfagiun2Ea
-/
得到结果：00000010
我们都知道10二进制→十进制=2，所以7跟18的按位与的结果是二进制10(十进制2)
'''

#按位或运算|， 按位或是指一个数字转化为二进制，然后这些二进制的数按位来进行或运算
operationNumber=7|18
print operationNumber        #输出结果：23   #结题思路和按位与运算的一样，可以参考按位与运算

#按位异或
operationNumber=7^18
print operationNumber        #输出结果：21   #结题思路和按位与运算的一样，可以参考按位与运算

#按位翻转 ~   按位翻转公式: ~x= - (x+1)
operationNumber=~12  #~12=- (12+1) = -13
print operationNumber        #输出结果：-13   #结题思路和按位与运算的一样，可以参考按位与运算

#左移<<
'''
比如18左移就是将他的二进制形式00100100左移，得到00100100(36)。
左移规律:左移一个单位相当于乘2，左移两个单位相当于乘以4，左移三个单位相当于乘以8，
即:      左移n个单位相当于乘以2的n次幂
'''
operationNumber=12<<1
print operationNumber        #输出结果：24
operationNumber=3<<3
print operationNumber        #输出结果：24

#右移>>
'''
理解左移以后，右移就很好理解了。
右移是左移的逆运算，将对应的二进制数向右移动。
右移规律:右移一个单位相当于除以2，右移两个单位相当于除以4，右移三个单位相当于除以8，
即:      右移n个单位相当于除以2的n次幂
'''
operationNumber=12>>1
print operationNumber        #输出结果：6
operationNumber=12>>2
print operationNumber        #输出结果：3

#小于等于<= 比较运算，小于或等于返回一个bool值
operationNumber=3<=3
print operationNumber        #输出结果：True
operationNumber=3<=2
print operationNumber        #输出结果：False

#大于等于>= 比较运算，大于或等于返回一个bool值
operationNumber=2>=3
print operationNumber        #输出结果：False
operationNumber=3>=2
print operationNumber        #输出结果：True

#比较两个对象是否相等==
operationNumber=3==2
print operationNumber        #输出结果：False
operationString="hi"=="hi"
print operationString        #输出结果：True

#逻辑非 not
operationx=True
operationy=not operationx
print operationy        #输出结果：False
operationz=False
print not operationz        #输出结果：True

#逻辑与 and
'''
True and True = True
True and False = False
False and True = False
False and False = False
'''
print True and True        #输出结果：True

#逻辑或 or
'''
True or True = True
True or False = True
False or True = True
False or False = False
'''
print False or False        #输出结果：False
