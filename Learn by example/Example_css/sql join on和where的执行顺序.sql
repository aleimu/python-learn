#http://www.cnblogs.com/Jessy/p/3525419.html
#sql(join on 和where的执行顺序）

left join :左连接，返回左表中所有的记录(即使右表中没有匹配，也从左表返回所有的行)以及右表中连接字段相等的记录。
right join :右连接，返回右表中所有的记录(即使左表中没有匹配，也从右表返回所有的行)以及左表中连接字段相等的记录。
inner join: 内连接，又叫等值连接，只返回两个表中连接字段相等的行。
full join:外连接，返回两个表中的行：left join + right join。
cross join:结果是笛卡尔积，就是第一个表的行数乘以第二个表的行数。
关键字: on
数据库在通过连接两张或多张表来返回记录时，都会生成一张中间的临时表，然后再将这张临时表返回给用户。
在使用left jion时，on和where条件的区别如下：
1、 on条件是在生成临时表时使用的条件，它不管on中的条件是否为真，都会返回左边表中的记录。
2、where条件是在临时表生成好后，再对临时表进行过滤的条件。这时已经没有left join的含义（必须返回左边表的记录）了，条件不为真的就全部过滤掉。


mysql> select * from table1;
+----+-------+
| id | name  |
+----+-------+
|  1 | lee   |
|  2 | zhang |
|  4 | wang  |
+----+-------+

mysql> select * from table2;
+----+-------+
| id | score |
+----+-------+
|  1 |    90 |
|  2 |   100 |
|  3 |    70 |

mysql> select * from table1 left join table2 on table1.id=table2.id;
+----+-------+------+-------+
| id | name  | id   | score |
+----+-------+------+-------+
|  1 | lee   |    1 |    90 |
|  2 | zhang |    2 |   100 |
|  4 | wang  | NULL | NULL  |
+----+-------+------+-------+
3 rows in set

mysql> select * from table1 right join table2 on table1.id=table2.id;
+------+-------+----+-------+
| id   | name  | id | score |
+------+-------+----+-------+
|    1 | lee   |  1 |    90 |
|    2 | zhang |  2 |   100 |
| NULL | NULL  |  3 |    70 |
+------+-------+----+-------+
3 rows in set

mysql> select * from table1 inner join table2 on table1.id=table2.id;
+----+-------+----+-------+
| id | name  | id | score |
+----+-------+----+-------+
|  1 | lee   |  1 |    90 |
|  2 | zhang |  2 |   100 |
+----+-------+----+-------+
2 rows in set



mysql> select * from table1 join table2 on table1.id=table2.id;
+----+-------+----+-------+
| id | name  | id | score |
+----+-------+----+-------+
|  1 | lee   |  1 |    90 |
|  2 | zhang |  2 |   100 |
+----+-------+----+-------+
2 rows in set


mysql> select * from table1 left join table2 on (table1.id=table2.id) where table1.id=2;
+----+-------+----+-------+
| id | name  | id | score |
+----+-------+----+-------+
|  2 | zhang |  2 |   100 |
+----+-------+----+-------+
1 row in set

mysql> select * from table1 left join table2 on (table1.id=table2.id and table1.id=2);
+----+-------+------+-------+
| id | name  | id   | score |
+----+-------+------+-------+
|  2 | zhang |    2 |   100 |
|  1 | lee   | NULL | NULL  |
|  4 | wang  | NULL | NULL  |
+----+-------+------+-------+
3 rows in set

#SQL UNION 操作符合并两个或多个 SELECT 语句的结果。
mysql> select * from table1 union select * from table2;
+----+-------+
| id | name  |
+----+-------+
|  1 | lee   |
|  2 | zhang |
|  4 | wang  |
|  5 | 555   |
|  1 | 90    |
|  2 | 100   |
|  3 | 70    |
|  4 | 0     |
+----+-------+
8 rows in set
#允许重复的值，请使用 UNION ALL。
mysql> select * from table1 union all select * from table2;
+----+-------+
| id | name  |
+----+-------+
|  1 | lee   |
|  2 | zhang |
|  4 | wang  |
|  5 | 555   |
|  1 | 90    |
|  2 | 100   |
|  3 | 70    |
|  5 | 555   |
|  4 | 0     |
+----+-------+
9 rows in set

create table table1(id int,name varchar(10));
create table table2(id int,score int);
insert into table1 select 1,'lee';
insert into table1 select 2,'zhang';
insert into table1 select 4,'wang';
insert into table2 select 1,90;
insert into table2 select 2,100;
insert into table2 select 3,70;
insert into table2 values (4,"wang");
CREATE TABLE `table3` (`id` int(11) DEFAULT NULL,`name` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL);


mysql> insert into table3 select * from table1;
Query OK, 4 rows affected
Records: 4  Duplicates: 0  Warnings: 0

mysql> select * from table3;
+----+-------+
| id | name  |
+----+-------+
|  1 | lee   |
|  2 | zhang |
|  4 | wang  |
|  5 | 555   |
+----+-------+
4 rows in set

mysql> select * from table2 limit 2;
+----+-------+
| id | score |
+----+-------+
|  1 |    90 |
|  2 |   100 |
+----+-------+

mysql> select * from table2 limit 1,2;
+----+-------+
| id | score |
+----+-------+
|  2 |   100 |
|  3 |    70 |
+----+-------+
2 rows in set



2 rows in set
