#支持类型提示 typing
{
def greeting(name: str) -> str:
	return 'Hello ' + name

#在函数greeting中，参数名称的类型为str，返回类型为str。 接受子类型作为参数。
#例子
>>> def gg(name:str)->str:
	return 'hello'+name

>>> gg('a')
'helloa'
>>> gg('bbb')
'hellobbb'
>>> gg(1)
Traceback (most recent call last):
  File "<pyshell#19>", line 1, in <module>
	gg(1)
  File "<pyshell#16>", line 2, in gg
	return 'hello'+name
TypeError: must be str, not int
>>> 


}

import base64
>>> base64.decodebytes(b'c3Vic2NyaWJlcjpTc01pbmkxQA==').decode('utf8')
'subscriber:SsMini1@'
>>> base64.encodebytes(b'subscriber:SsMini1@')
b'c3Vic2NyaWJlcjpTc01pbmkxQA==\n'

#给[1,2,3]加权重
random .choices([1,2,3],[1,1,10])

asyncio
{
#http://www.cnblogs.com/styier/p/6415850.html  例子



#程序总共等待10s
import asyncio
async def print5s():
       print("开始运行！")
       await asyncio.sleep(5.0) #挂起后台运行
       print("结束运行！")
       
async def print10s():
       print("开始运行！")
       await asyncio.sleep(10.0) #挂起后台运行
       print("结束运行！")

loop = asyncio.get_event_loop()

loop.create_task(print5s())
loop.create_task(print10s())
loop.run_forever()

#程序总共等待5s
import asyncio
 
async def compute(x, y):
    print("Compute %s + %s ..." % (x, y))
    await asyncio.sleep(5.0)
    return x + y
 
async def print_sum(x, y):
    result = await compute(x, y)
    print("%s + %s = %s" % (x, y, result))
 
loop = asyncio.get_event_loop()
tasks = [print_sum(1,2),print_sum(3,4)]
loop.run_until_complete(asyncio.wait(tasks))
loop.close()

#程序总共等待2s
import asyncio

async def my_task(seconds):
    print("This task is take {} seconds to cpmplete".format(seconds))
    await asyncio.sleep(seconds)
    return "task finished"

if __name__ == "__main__":
    my_event_loop = asyncio.get_event_loop()
    tasks = []
    try:
        print("task creation started")
        task_obj1 = my_event_loop.create_task(my_task(seconds = 2))
        task_obj2 = my_event_loop.create_task(my_task(seconds = 2))
        task_obj3 = my_event_loop.create_task(my_task(seconds = 2))
        tasks = [task_obj1,task_obj2,task_obj3]		#创建事件循环的列表
        #my_event_loop.run_until_complete(tasks)
        my_event_loop.run_until_complete(asyncio.wait(tasks)) #创建事件循环的列表
    finally:
        my_event_loop.close()

#可以看出 是在同一个线程中执行的
import threading
import asyncio


async def hello():
    print('Hello world! (%s)' % threading.currentThread())
    asyncio.sleep(1)
    print('Hello again! (%s)' % threading.currentThread())

loop = asyncio.get_event_loop()
tasks = [hello(), hello()]
loop.run_until_complete(asyncio.wait(tasks))
loop.close()



}
queue 队列
{


import queue
#测试定义类传入队列
class Foo(object):
    def __init__(self,n):
        self.n = n
new = queue.Queue(maxsize=3)
print('先进先出')
new.put(1)
new.put(Foo(1),timeout=2) # 超时时间后，抛出队列full异常
new.put([1, 2, 3],timeout=2)
print(new.full()) #判断队列是否满 True
#new.put("abc",timeout=1) #队列已满，再放报错
print(new.qsize()) # 查看当前队列长度
print(new.get())
print(new.get())
print(new.get())
print(new.empty()) #判断队列是否为空 True
#print(new.get_nowait()) #队列已空，取不到数据报异常
print('后进先出')
q = queue.LifoQueue() #指定使用LifoQueue
q.put(3)
q.put(2)
print(q.get_nowait())
print(q.get_nowait())

print('存入一个元组，第一个为优先级，第二个为数据，第三个默认超时时间')
new = queue.PriorityQueue(maxsize=3)
new.put((10,[1,2,3]))
new.put((5,"strings"))
new.put((20,"strings"))
print(new.get_nowait())
print(new.get_nowait())
print(new.get_nowait())


import threading, queue, time
#生产者消费者模型为了程序松耦合，多对多
def consumer(n):
    while True:
        print(" consumer [%s]  get task: %s" % (n, q.get()))
        time.sleep(1)  # 每秒吃一个
        q.task_done()  # get()1次通知队列减少1

def producter(n):
    count = 1
    while True:
        print("producter [%s] produced a new task : %s" % (n, count))
        q.put(count)
        count += 1
        q.join()  #消息阻塞 队列为空重新触发
        print("all task has been cosumed by consumers ...")

q = queue.Queue()
c1 = threading.Thread(target=consumer, args=[1, ])
c2 = threading.Thread(target=consumer, args=[2, ])
c3 = threading.Thread(target=consumer, args=[3, ])
p1 = threading.Thread(target=producter, args=["p1", ])
p2 = threading.Thread(target=producter, args=["p2", ])
c1.start()
c2.start()
c3.start()
p1.start()
p2.start()

}

