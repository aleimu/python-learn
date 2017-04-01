蒙提霍尔问题

"""蒙提霍尔问题:
有一个游戏 节目，参赛者会看见三扇关闭了的门，其中一扇的后面有一辆汽车，
选中后面有车的那扇门就可以赢得该汽车，而另外两扇门后面则各藏有一只山羊。
当参赛者选定了一扇门，但未去开启它的时候，节目主持人开启剩下两扇门的其中一扇，
露出其中一只山羊。主持人其后会问参赛者要不要换另一扇仍然关上的门。
问题是：换另一扇门会否增加参赛者赢得汽车的机会率？换与不换赢得汽车的概率分别是多少？
"""
import random
def guess(ischange):
       wintimes=0
       for a in range(1,1000): #游戏进行1000次
              carid=random.randint (0,2)
              yourguessid=random.randint (0,2)
              
              if carid==yourguessid: #第一次选择就是汽车，主持人随机开一个空门
                     openid=[x for x in range(0,3) if x !=carid][random.randint (0,1)]
              if carid !=yourguessid: #第一次选择不是汽车，主持人开另一个空门
                     for b in range(0,3):
                            if b!=yourguessid and b!=carid:
                                   openid=b
              #print("主持人开启一门后,carid,yourguessid,openid:",carid,yourguessid,openid)
              if ischange:
                     for c in range(0,3):
                            if c != openid and c != yourguessid:
                                   yourguessid=c
                                   #print(yourguessid)
                                   break
              #print("交换后,carid,yourguessid,openid:",carid,yourguessid,openid)
              if carid==yourguessid:
                     wintimes+=1
       print("wintimes:",wintimes)

print("不换赢的次数:")
guess(False)
print("换后赢的次数:")
guess(True)

"""
被主持人打开一个有羊的门之后，剩下的两个的概率不是各50%，因为已不是随机概率了(已被知情的主持人处理过)。
换另一个赢的概率是2/3，要换。
也许有人对此答案提出质疑，认为在剩下未开启的两扇门后有汽车的概率都是1/2，因此不需要改猜。为消除这一质疑，
不妨假定有10扇门的情形，其中一扇门后面有一辆汽车，另外9扇门后面各有一只山羊。
当竞猜者猜了一扇门但尚未开启时，主持人去开启剩下9扇门中的8扇，露出的全是山羊。
显然：原先猜的那扇门后面有一辆汽车的概率只是1/10，这时改猜另一扇未开启的门赢得汽车的概率是9/10。
若主持人不知情，则概率无变化。剩余两门：1/2,1/2，无放回抽样类似。
若主持人知情，概率就会发生变化。剩余两门：未开门的概率为2/3，1/3，非概率事件。
其实这个问题根本就不复杂，大家无论说50%还是66.6%都没有错，因为驳论的关键就在整个事件的条件设置上！
只是多数人不在意提问的所基于的整个条件设置，或者提出这个问题的人没有强调或者交代清楚整个设置，所以才很容易出现不一样的理解和答案。
关键还是在于条件混淆了大家思考的逻辑的起始点还有时间点
 """
#参考博客
http://www.cnblogs.com/antineutrino/p/4821580.html
