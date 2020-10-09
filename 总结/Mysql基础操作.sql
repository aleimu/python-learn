Mysql基础操作

1、数据库操作
　　进入命令行: mysql -uroot -p123456
　　查看数据库: show databases;
　　查看数据库创建语句: show create database test;
　　创建数据库: create database test charset utf8mb4;
　　选择数据库: use test;
　　删除数据库: drop database test;
　　备份指定数据库: mysqldump -uroot -p  test >test.sql   注: 由于mysql5.6版本不支持在命令行界面输入密码，所以暂不输入密码，回车后输入密码即可。
　　备份所有数据库: mysqldump -uroot -p  -A >test.sql 
　　恢复指定数据库: mysql -uroot -p test<test.sql
　　恢复所有数据库: mysql -uroot -p  -A <test.sql

2、表操作: 
　　表约束: 
　　　　自增: auto_increment
　　　　主键: primary key
　　　　非空: not null
　　　　默认值: default 'xx'
　　　　唯一: unique
　　　　指定字符集: charset utf8mb4
　　查看表: 
　　　　查看表: show tables;
　　　　查看创建表语句: show create table user;
　　　　查看表结构: desc user;
　　创建表: 
        create table user(
            id int auto_increment primary key,  #ID自增并设置为主键
            name varchar(10) not null,          #姓名不允许为空
            sex varchar(5) default 1,           #性别默认1
            phone bigint not null unique,       #电话不允许为空并且唯一
            create_time datetime default now(), #创建时间默认当前时间
            addr varchar(50)
        )ENGINE=InnoDB DEFAULT CHARSET=utf8;

　　删除表: 
　　　　删除表: drop table user;
　　修改表: 
　　　　修改表名称: alter table user rename user1;
　　　　修改字段类型并重命名: alter table user change name names varchar(15);
　　　　修改字段类型: alter table user modify names varchar(15);
　　　　在指定位置新增字段: alter table user add password varchar(20) not null after names;

3、数据操作
　　增加数据: 
　　　　表中新增数据: insert into user values('','张三','男','1234567890',NOW(),'北京市海淀区');
　　　　表中指定字段添加数据: insert into user(name,phone,create_time) values('张三','12348567890',NOW());  注: 如果字段设置非空，则必须添加
　　删除数据: 
　　　　删除表中数据: delete from user;  注: 自增长ID不会清空，还会从原有的ID开始继续增长
　　　　清空表: truncate user; 
　　　　删除表中指定的数据: delete from user where id=1;
　　更改数据: 
　　　　更改表中所有数据: update user set sex='男';
　　　　更改表中指定数据: update user set sex='男' where  name='张三';
　　　　更改表中多个字段: update user set sex='男',addr='北京市朝阳区' where  name='张三';
　　　　在原有数据基础上更改: update user set phone=phone+1 where  name='张三';
　　查询数据: 
　　　　查询前5条数据: select * from user limit 5;
　　　　查询第3至6条数据: select * from user limit 2,4;  注: 从第几条开始查询(下标从0开始)，查询多少条
　　　　查询指定字段: select  name,sex,phone from user;
　　　　单表查询: select * from user where name='张三' and sex='男';  注: and表示多个条件必须同时满足
　　　　　　　　　select * from user where name='张三'  or  sex='男';  注: or表示有其中一个条件满足即可
　　　　　　　　　select * from user where  sex !='男';  #查询不等于男生的信息,也可以用<>
　　　　　　　　　select * from user where name like '张%';     #查询姓张的用户
　　　　　　　　　select * from user where name like '张_'; 　　#查询姓张并且姓名为2个字的用户
　　　　　　　　  select * from user where name in ('张三','李四','王五');　　#查询姓名为张三、李四、王五的信息
　　　　　　　 　 select * from user where  phone between 13700000000 and 13712345678;　　#查询手机号在13700000000和13712345678之间的用户
　　　　　　　 　 select * from user order by create_time desc;　　#查询按照用户创建时间倒序显示，默认升序asc
　　　　　　　　  select * from user where  addr='' or addr is null;　　#查询地址为空或为null的用户
　　　　　　　　　select distinct name from user;　　#不显示重复的姓名
　　　　　　　　　select count(*) from user where sex='女';　　#统计女生有多少人
　　　　　　　　　select max(age),min(age),avg(age),sum(age) from user where sex='男';　　#查找男生年龄最大、最小、平均、总和
　　　　　　　　　select *,COUNT(sex) from user GROUP BY sex having sex='女';　　#按照性别分组，并显示女生有多少人
　　　　多表查询: 
　　　　　　　　select * from user u,user_group g where u.id=g.id　　　　#查询两张表共有的数据
　　　　　　　　select * from user u inner join user_group g on u.id=g.id;　　#查询两张表共有的数据
　　　　　　　　select * from user u left join user_group g on u.id=g.id;　　#左边所有的数据都查出来，右边如果有匹配的则查出来
　　　　　　　　select * from user u right join user_group g on u.id=g.id;　　#右边所有的数据都查出来，左边如果有匹配的则查出来
　　　　　　　　select * from user u left join user_group g on u.id=g.id
　　　　　　　　union
　　　　　　　　select * from user u right join user_group g on u.id=g.id;　　#左边和右边匹配的数据全部查出来并去重(union all不会去重)，相当于oracle的全连接
　　　　　　　　select * from (select id,name,sex from user where sex='女') user;　　#把查询结果作为一张表查询
　　　　　　　　select * from user where id in(select id from user_group where g_name='计算机');　　#子查询，查询学计算机的用户信息

4、用户管理
　　添加用户: 
　　　　insert into user (user,host,password) values('xiaoxitest','%',PASSWORD('123456')); #添加xiaoxitest用户并允许远程计算机登录，密码为: 123456
　　更改用户: 
　　　　update user set password=password("654321") where user='xiaoxitest'; #更改用户密码
　　　　update user set user='xiaoxi' where user='xiaoxitest';　　#更改用户名xiaoxitest为xiaoxi
　　删除用户: 
　　　　delete from user where user='xiaoxi';　　#删除xiaoxi用户

5、权限管理
	查看用户权限: show grants for 'username'@'localhost';
　　用户授权: 
　　授权格式: grant 权限 on 数据库.* to 用户名@登录主机 identified by "密码" with grant option;
　　　　grant all on  *.* to 'xiaoxi'@'%' IDENTIFIED BY '123456' with grant option;  #表示为xiaoxi用户添加所有数据库所有权限，并可以给其他人授权。
　　　　grant all on  test.* to 'xiaoxi'@'%' IDENTIFIED BY '123456' ;　　#表示为xiaoxi用户添加test数据库所有权限
　　　　grant select on  *.* to 'xiaoxi'@'%' IDENTIFIED BY '123456' ;　　#表示为xiaoxi用户添加所有数据库查询权限
　　取消授权: 
　　　　Revoke select on *.* from 'xiaoxi'@'%';　　#表示为xiaoxi用户取消所有数据库查询权限
　　　　Revoke all on *.* from 'xiaoxi'@'%';　　#表示为xiaoxi用户取消所有数据库所有权限
　　刷新权限: 
　　　　flush privileges;




#mysql --增删改查

{

#修改表名

#创建用户表
CREATE TABLE IF NOT EXISTS user7(
id  SMALLINT UNSIGNED KEY AUTO_INCREMENT,
username VARCHAR(50) NOT NULL UNIQUE,
password CHAR(20) NOT NULL,
email VARCHAR(20) NOT NULL DEFAULT '592681026@qq.com',
age TINYINT UNSIGNED DEFAULT 18,
sex ENUM('男','女','保密') NOT NULL DEFAULT '男',
addr VARCHAR(50) NOT NULL DEFAULT '上海',
salary FLOAT(6,2),#这个是浮点型    6位数，保留两位小数
regTime INT UNSIGNED,
face CHAR(100) NOT NULL DEFAULT 'default.jpg'
);

INSERT user6(id,username,password,regTime) VALUES(1,'付志强','dazhi',1994);


#重命名表名: user7变为user8
ALTER TABLE user7 RENAME TO user8;
ALTER TABLE user8 RENAME AS user7;#TO  和     AS   都可以省略
ALTER TABLE user8 RENAME user7;

RENAME TABLE 原表名 TO 新表名;#这个TO不能省略

添加和删除字段

#添加字段，删除字段
#添加: ALTER TABLE tbl_name ADD 字段名称  字段类型[完整性约束条件][FIRST|AFTER 字段名称]（加在首部或者某个字段之后）   和写字段差不多  最后可以字段的位置
#添加card字段 CHAR(18)
ALTER TABLE user7 ADD card CHAR(18);
ALTER TABLE user7 ADD test1 VARCHAR(100) NOT NULL UNIQUE;
ALTER TABLE user7 ADD test2 VARCHAR(100) NOT NULL UNIQUE FIRST;


#一次添加多个字段     选中一个表，完成多个操作
ALTER TABLE user7

ADD test5 VARCHAR(100) NOT NULL UNIQUE AFTER sex,
ADD test6 SET('A','B','C');


#删除指定字段   ALTER TABLE tab_name DROP 字段名称
 ALTER TABLE user7 DROP test6;
 
 #一次性的删除test1，test2，test3，test4，test5
 ALTER TABLE user7
 DROP test1, 
 DROP test2,
 DROP test3,
 DROP test4;

 #添加test字段 删除addr字段
 ALTER TABLE user7
 
 ADD test INT UNSIGNED NOT NULL DEFAULT 10 AFTER sex,
 DROP addr;

修改字段

#修改字段      ALTER TABLE tab_name MODIFY  字段名称  字段类型[完整性约束条件][FIRST|AFTER 字段名称]
 #MODIFY   修改字段类型  将email 修改位VARCHAR(200)
 ALTER TABLE user7 MODIFY email VARCHAR(200);#这个修改的时候最好是带上全部的完整性约束条件
 ALTER TABLE user7 MODIFY email VARCHAR(50) NOT NULL DEFAULT '592681026@qq.com';#带上完整的约束性
 
 #将card字段移动到test字段之后
 ALTER TABLE user7 MODIFY card CHAR(18) AFTER test;#这里要带上card的完整的约束性条件
 
 #将test字段修改位CHAR(32) NOT NULL DEFAULT '123' 移动到第一个位置
 ALTER TABLE user7 MODIFY test CHAR(32) NOT NULL DEFAULT '1234' FIRST;
 
 #修改字段的名称（也能完成MODIFY的功能）      ALTER TABLE tab_name   原字段名称   新字段名称   字段类型  
 #将test字段改为test1
 ALTER TABLE user7 CHANGE test test1 CHAR(32) NOT NULL ;

添加删除默认值
#添加删除默认值
 ALTER TABLE 表名 ALTER 字段名称 SET DEFAULT 默认值
 ALTER TABLE 表名 ALTER 字段名称 DROP DEFAULT
添加删除主键

#添加和删除主键
 ALTER TABLE 表名 ADD [CONSTRAINT] PRIMARY KEY (字段名称,...)#...表示括号里面可以是多个字段，那就是复合主键了，如果是一个，那就是单一主键了
 ALTER TABLE 表名 DROP PRIMARY KEY
 
CREATE TABLE test12(
    id INT
 );
ALTER TABLE test12 ADD PRIMARY KEY (id);

CREATE TABLE test13(
    id INT,
    card VARCHAR(50) NOT NULL
);
ALTER TABLE test13 ADD PRIMARY KEY (id,card);

ALTER TABLE test13 DROP PRIMARY KEY;#删除
ALTER TABLE test12 DROP PRIMARY KEY;#删除

#注意: 这里如果建表的时候自增长和主键同时存在的时候，你不能直接删除主键，而是应该先是删除AOTU_INCREMENT，然后再删除主键
ALTER TABLE 表名 MODIFY id UNSIGNED NOT NULL;#这样自增长就没有了 

添加删除唯一

#添加测试索引
ALTER TABLE 表名 ADD UNIQUE(username);
ALTER TABLE 表名 ADD  CONSTRAINT symbol UNIQUE  uni_id(username);#这里的uni_id 是一个索引的名称，如果不写这个系统会让字段名称变成默认的索引名称
ALTER TABLE 表名 ADD  CONSTRAINT symbol UNIQUE  aa(card，username);#复合索引唯一

#删除索引唯一
ALTER TABLE 表名 DROP {INDEX|KEY} 唯一名称;

# 删除外键
alter table project_line drop foreign key project_line_ibfk_1;


#修改表的引擎
ALTER TABLE 表名 ENGINE=MyISAM;

#修改自增长值
ALTER TABLE 表名 AUTO_INCREMENT=100;

删除数据表

#删除数据表     
DROP TABLE [IF  EXISTS]表名;#可以一次删除多个  也可以删除一个    类似于添加。
当然手动删除也是可以的。必须先关闭mysql，在关闭mysql服务，最后在文件中手动删除数据表，

#当我们进入mysql想登录的同时直接打开某个数据库的时候: 
mysql -uroot -p -D 数据库名称。

更新删除   应用order by 和limit
　　

#更新用户名为4位的用户，让其已有的年龄-3
UPDATE cms_user SET age=age-3 WHERE username LIKE '____';

#更新前三条记录 ，让已有年龄+10
UPDATE cms_user SET age=age+10 LIMIT 3;
UPDATE cms_user SET age=age+10 LIMIT 0,3;

#按照id降序排列 更新前三条
UPDATE cms_user SET age=age+10 ORDER BY id DESC LIMIT 3;

#删除用户性别为男的用户，按照年龄降序排序，删除前一条记录
DELETE  FROM cms_user WHERE sex='男' ORDER BY age DESC LIMIT 1; 
}


select 
line_no,
line_name,
start_org_code,
start_org_name,
end_org_code,
end_org_name,
fre_status,
IFNULL(full_take_time,0),
IFNULL(full_distance,0.000),
line_property,
trans_type,
if(line_status!=3,'启用','禁用') as status,
line_frequency_name,
line_frequency_no,
start_time,
end_time,
day_span,
IFNULL(transfer_center_set,"")
from line 
where line_no like 'MOT%' and line_status in(1,2,4) and exists(select 1 from t_mot_line where t_mot_line.line_no=line.line_no) order by line_no,line_frequency_no,fre_status desc INTO OUTFILE 'D:/both_camel_line.txt';

select distinct(delete_flag) from user; # 去重




# mysqldump -u用戶名 -p密码 -d 数据库名 表名 > 脚本名;

# 导出整个数据库结构和数据
mysqldump -h localhost -uroot -p123456 database > dump.sql

# 导出单个数据表结构和数据
mysqldump -h localhost -uroot -p123456  database table > dump.sql

# 导出整个数据库结构（不包含数据）
mysqldump -h localhost -uroot -p123456  -d database > dump.sql

# 导出单个数据表结构（不包含数据）
mysqldump -h localhost -uroot -p123456  -d database table > dump.sql



mysqldump -h localhost -uroot -proot  camel conformation > conformation.sql

mysql -h localhost -uroot -proot  camel < conformation.sql


ALTER TABLE 表名 ADD 索引类型 (index,unique,primary key,fulltext)[索引名]（字段名）
alter table camel_truck add index index_org_id(org_id); # 增加普通索引


# create只能添加这两种索引;
CREATE INDEX index_name ON table_name (column_list)
CREATE UNIQUE INDEX index_name ON table_name (column_list)

SELECT `sname` FROM `stu` WHERE `age`+10=30;-- 不会使用索引,因为所有索引列参与了计算

SELECT `sname` FROM `stu` WHERE LEFT(`date`,4) <1990; -- 不会使用索引,因为使用了函数运算,原理与上面相同

SELECT * FROM `houdunwang` WHERE `uname` LIKE'后盾%' -- 走索引

SELECT * FROM `houdunwang` WHERE `uname` LIKE "%后盾%" -- 不走索引

#正则表达式不使用索引,这应该很好理解,所以为什么在SQL中很难看到regexp关键字的原因

#字符串与数字比较不使用索引;
CREATE TABLE `a` (`a` char(10));
EXPLAIN SELECT * FROM `a` WHERE `a`="1" -- 走索引
EXPLAIN SELECT * FROM `a` WHERE `a`=1 -- 不走索引

select * from dept where dname='xxx' or loc='xx' or deptno=45 #如果条件中有or,即使其中有条件带索引也不会使用。换言之,就是要求使用的所有字段,都必须建立索引, 我们建议大家尽量避免使用or 关键字

#如果mysql估计使用全表扫描要比使用索引快,则不使用索引


# TypeError: expected string or Unicode object, long found 一般都是数据库返回的数据格式和model不服


Mysql 根据一个表数据更新另外一个表:
方法1:
    update 更新表 set 字段 = (select 参考数据 from 参考表 where  参考表.id = 更新表.id);
    update table_2 m  set m.column = (select column from table_1 mp where mp.id= m.id);
方法2:
    update table_1 t1,table_2 t2 set t1.column = t2.column where t1.id = t2.pid;

在开发过程中，使用到了MySQL数据库，但是想知道每次对数据库进行了哪些操作，方便对自己的代码进行优化，这时候就需要用到查询日志genral_log。


# 动态修改配置
mysql > show variables like "%general_log%";
+------------------+------------------------------+
| Variable_name | Value |
+------------------+------------------------------+
| general_log | ON |
| general_log_file | /tmp/mariadb_general_log.log |
+------------------+------------------------------+
可以看到设置到两个变量，一个是开关，一个是general_log的文件保存路径。
# 开启文件记录
mysql > set global general_log_file='/tmp/mariadb_general_log.log';
mysql > set global general_log=on;
配置文件里面修改
在mysqld的节点加上以下配置
general_log_file=/tmp/mariadb_general_log.log
general_log=on
# 将日志记录到表
如果不方便查看文件，也可以将日志直接存放到表里面（适合mysql数据库在远程）
mysql > set global log_output='table';
mysql > set global general_log=on;
# 总结
这个使用本地的开发环境，生产上勿用。


select distinct(delete_flag) from user; # 去重
select id,org_id,code from Transport_Location group by id order by org_id;
select distinct code from Transport_Location;
select count(distinct code) from Transport_Location;

一般而言，DISTINCT子句是GROUP BY子句的特殊情况,GROUP BY子句可对结果集分组并进行排序，而DISTINCT去重并不进行排序
效果差不多,DISTINCT还可以使用聚合函数:SUM，AVG和COUNT

-- 比较两个表
SELECT id, title
FROM
 (
   SELECT t1.id, t1.title
   FROM t1
   UNION ALL
   SELECT t2.id, t2.title
   FROM t2
)  t
GROUP BY id, title
HAVING COUNT(*) = 1
ORDER BY id;


-- 要使用first_name，last_name和email列中的重复值在contacts表中查找行，请使用以下查询：
SELECT 
    first_name, COUNT(first_name),
    last_name,  COUNT(last_name),
    email,      COUNT(email)
FROM
    contacts
GROUP BY 
    first_name , 
    last_name , 
    email
HAVING  COUNT(first_name) > 1
    AND COUNT(last_name) > 1
    AND COUNT(email) > 1;


-- 在基于一列的表中找到重复值，则使用以下语句：
SELECT 
    col, 
    COUNT(col)
FROM
    table_name
GROUP BY col
HAVING COUNT(col) > 1;


-- 要将数据从表复制到新表，请使用CREATE TABLE和SELECT语句，如下所示：
CREATE TABLE IF NOT EXISTS t3 SELECT id, note FROM t2; 

CREATE TABLE offices_dup LIKE offices;
INSERT office_dup SELECT * FROM offices;

-- 将表复制到其他数据库
CREATE TABLE destination_db.new_table LIKE source_db.existing_table;
INSERT destination_db.new_table SELECT * FROM source_db.existing_table;

-- 比like厉害的正则匹配
^	匹配搜索字符串开头处的位置
$	匹配搜索字符串末尾的位置
.	匹配任何单个字符
[…]	匹配方括号内的任何字符
[^…]	匹配方括号内未指定的任何字符
	匹配p1或p2模式
*	匹配前面的字符零次或多次
+	匹配前一个字符一次或多次
{n}	匹配前几个字符的n个实例
{m,n}	从m到n个前一个字符的实例匹配

select * from t3 where note regexp '^n';


-- row_number - 为每行添加行号要模拟row_number函数，必须在查询中使用会话变量。
SET @row_number = 0;
SELECT 
    (@row_number:=@row_number + 1) AS num, firstName, lastName
FROM
    employees
LIMIT 5;


-- 使用ORDER BY RAND()选择随机记录
select * from t3 order by rand() limit 1;


-- MySQL使用TRUNCATE TABLE语句重置自动增量值TRUNCATE TABLE语句删除表的所有数据，并将auto_increment值重置为0。
TRUNCATE TABLE table_name;

-- 删除删除表并重新创建它，因此，自动增量的值将重置为0。
DROP TABLE table_name;
CREATE TABLE table_name(...);


-- 今天的日期
mysql> SELECT DATE(NOW());
+-------------+
| DATE(NOW()) |
+-------------+
| 2019-01-10  |
+-------------+
mysql> SELECT CURDATE();
+------------+
| CURDATE()  |
+------------+
| 2019-01-10 |
+------------+
-- 明天
SELECT DATE_ADD('2017-12-31 00:00:01',INTERVAL 1 DAY) result;

mysql> SELECT CURDATE() + interval 1 day tomorrow;
+------------+
| tomorrow   |
+------------+
| 2019-01-11 |
+------------+
mysql> SELECT CURDATE() - interval 1 day yesterday;
+------------+
| yesterday   |
+------------+
| 2019-01-09 |
+------------+

-- 字符串中的子字符串SQL的位置,不区分大小写
SELECT INSTR('MySQL INSTR', 'SQL');

-- 字符串拼接
mysql> SELECT 'MySQL ' 'String ' 'Concatenation';
+----------------------------+
| MySQL                      |
+----------------------------+
| MySQL String Concatenation |
+----------------------------+
mysql>  SELECT CONCAT('MySQL','CONCAT','Concatenation');
+------------------------------------------+
| CONCAT('MySQL','CONCAT','Concatenation') |
+------------------------------------------+
| MySQLCONCATConcatenation                 |
+------------------------------------------+
--使用分隔符连接字符串 
mysql> SELECT CONCAT_WS('aaaa','Max','Su');
+------------------------------+
| CONCAT_WS('aaaa','Max','Su') |
+------------------------------+
| MaxaaaaSu                    |
+------------------------------+
-- 返回具有指定长度的字符串的左边部分
SELECT LEFT('MySQL LEFT', 5);

-- 字符串替换
UPDATE tbl_name 
SET 
    field_name = REPLACE(field_name,
        string_to_find,
        string_to_replace)
WHERE
    conditions;



SELECT
    [ALL | DISTINCT | DISTINCTROW ]
      [HIGH_PRIORITY]
      [STRAIGHT_JOIN]
      [SQL_SMALL_RESULT] [SQL_BIG_RESULT] [SQL_BUFFER_RESULT]
      [SQL_CACHE | SQL_NO_CACHE] [SQL_CALC_FOUND_ROWS]
    select_expr [, select_expr ...]
    [FROM table_references
      [PARTITION partition_list]
    [WHERE where_condition]
    [GROUP BY {col_name | expr | position}
      [ASC | DESC], ... [WITH ROLLUP]]
    [HAVING where_condition]
    [ORDER BY {col_name | expr | position}
      [ASC | DESC], ...]
    [LIMIT {[offset,] row_count | row_count OFFSET offset}]
    [PROCEDURE procedure_name(argument_list)]
    [INTO OUTFILE 'file_name'
        [CHARACTER SET charset_name]
        export_options
      | INTO DUMPFILE 'file_name'
      | INTO var_name [, var_name]]
    [FOR UPDATE | LOCK IN SHARE MODE]]



修改数据库字符集为 utf8
alter database `awesome_app` default character set utf8
修改表字符集为 utf8
alter table `users` convert to character set utf8
修改表字段字符集为 utf8
alter table `users` modify `name` char(10) character set utf8
修改字段类型
alter table `users` modify `regtime` datetime not null
修改字段注释
alter table `users` modify `id` int not null auto_increment comment '用户ID';
alter table `users` modify `name` char(10) comment '用户名';
alter table `users` modify `avatar` varchar(300) comment '用户头像';
alter table `users` modify `regtime` datetime not null default current_timestamp comment '注册时间';
删除表
drop table if exists `users`
清空表中所有数据
这个操作相当于先 drop table 再 create table ，因此需要有 drop 权限。
truncate table `users`;


    
