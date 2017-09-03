#第一种方式
def quicksort(ls,A,B):
      if A<B:
            a=A
            b=B
            k=ls[A]
            while a<b:
                  while a<B and ls[a] <k:
                        a=a+1
                  while b>A and ls[b] >k:
                        b=b-1
                  if a<=b:
                        t=ls[a]
                        ls[a]=ls[b]
                        ls[b]=t
                        a=a+1
                        b=b-1
                  print(a,b,ls)
            if A<b:
                  quicksort(ls,A,b)
            if B>a:
                  quicksort(ls,a,B)

#第二种方式
def quicksort(ls,A,B):
      print("A,B=",A,B)
      if(A<B):                  
            a=A
            b=B
            key=ls[a]
            print("排序前:",ls)
            print("key=",key)
            while a<b:
                  while a<b and ls[b] > key:                      
                        b=b-1
                  if a<b:
                        ls[a]=ls[b]
                        a=a+1
                  while a<b and ls[a] < key:                       
                        a=a+1
                  if a<b:
                        ls[b]=ls[a]
                        b=b-1
            ls[a]=key            
            print("排序后:",ls)
            print("a,b=",a,b)
            if A<a-1:                  
                  print("下面开始排","ls[",A,"]","到ls[",a-1,"]内的数据")            
                  quicksort(ls,A,a-1)
            if B>a+1:
                  print("下面开始排","ls[",a+1,"]","到ls[",B,"]内的数据")
                  quicksort(ls,a+1,B)
                  
lss=[1,13,123,2344,4,23,65,2,756,42,86543,567,86,9,0,563,42,213]
quicksort(lss,0,len(lss)-1)
