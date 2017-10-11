import pymysql
conn = pymysql.connect(host='10.120.189.164', port=15432, user='root', passwd='root',db='golang',charset='utf8')
cursor = conn.cursor()
cursor.execute("select * from persons where p_id=1 and lastname=0 or 1=1")
cursor.execute
# row_1 = cursor.fetchone()
# print(row_1)
sqlresult = cursor.fetchall()
print(sqlresult)
print("-----------------1")
#execute() 函数本身有接受sql语句参数位的，可以通过python自身的函数处理sql注入问题。
args1 = (1, 0)
args2 = (1, '0 or 1=1')
cursor.execute('select * from persons where p_id=%s and lastname=%s', args2 )
sqlresult = cursor.fetchall()
print(sqlresult)
print("-----------------2")
#错误用法：
sql = "select * from persons where p_id=%s and lastname=%s" % args2
print("sql:",sql)
cursor.execute(sql)
sqlresult = cursor.fetchall()
print(sqlresult)
print("-----------------3")

# 从数据库角度看SQL注入的本质：SQL程序员利用外部输入拼接了sql语句，将整串sql语句发送给数据库

args2 = (" or 1=1 --'", 'b')
args3 = ('a; --', 'b')
cursor.execute('select * from persons where LastName=%s and FirstName=%s', args2 )
#cursor.execute("select * from persons where LastName= 'or 1=1 --")
# name_str="' or 1=1 --"
# sql_str = "select * from persons where name ='%s'" % name_str
# cursor.execute(sql_str)
#print(sql_str)
sqlresult = cursor.fetchall()
print(sqlresult)
print("-----------------4")


#random.SystemRandom 是安全的随机数
import random

print(random.SystemRandom.random('a'))

import ssl










'''

mysql> select * from persons where p_id=1 and lastname=0 or 1=1;
+------+----------+-----------+---------+------+
| P_Id | LastName | FirstName | address | city |
+------+----------+-----------+---------+------+
|    1 | 0        | NULL      | NULL    |      |
|    2 | 0        | NULL      | NULL    |      |
|    3 | 0        | NULL      | NULL    |      |
|    4 | 0        | NULL      | NULL    |      |
|    5 | a        | b         | c       | d    |
|    6 | a        | b         | c       |      |
|    7 | a        | b         |         |      |
|    8 | a        |           |         |      |
|    9 |          |           |         |      |
|   10 |          |           |         |      |
|   11 | null     | NULL      |         |      |
|   12 | NULL     | NULL      |         |      |
|   13 | ln       | fn        | NULL    |      |
|   14 | ln       | fn        | NULL    |      |
|   15 | ln       | fn        | NULL    |      |
|   16 | Gates    | Bill      | NULL    |      |
+------+----------+-----------+---------+------+
16 rows in set
'''
# copy()与deepcopy()的区别
# copy是浅拷贝，只拷贝可变对象的父级元素。 deepcopy是深拷贝，递归拷贝可变对象的所有元素。
