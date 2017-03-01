import math
import random
import time
def yun():
      #n=input("请输入循环次数:")
      #n=int(n)
      n=10000000
      m=0
      for x in range(n):
            a=random.random()
            b=random.random()
            c=math.sqrt(a**2+b**2)
            if c<1.0:
                  m+=1
      p=4.0*m/n            
      print("模拟的pi=",p)
      print('数学pi：',math.pi)
      print('误差是：',abs(math.pi-p)/math.pi)   #计算误差

def yun2():
      #n=input("请输入循环次数:")
      #n=int(n)
      n=10000000
      m=0
      for x in range(n):
            #a=random.random()
            #b=random.random()
            #c=math.sqrt(random.random()**2+random.random()**2)
            if math.sqrt(random.random()**2+random.random()**2)<1.0:
                  m+=1
      p=4.0*m/n            
      print("模拟的pi=",p)
      print('数学pi：',math.pi)
      print('误差是：',abs(math.pi-p)/math.pi)   #计算误差
                  
t1=time.time()
yun()
t2=time.time()
print("yun花费时间:",t2-t1)
#对比两种写法，感觉差不多啊，好像yun2跟快一点
t1=time.time()
yun2()
t2=time.time()
print("yun2花费时间:",t2-t1)
