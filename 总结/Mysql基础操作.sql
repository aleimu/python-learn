Mysql基础操作

1、数据库操作
　　进入命令行：mysql -uroot -p123456
　　查看数据库：show databases;
　　查看数据库创建语句：show create database test;
　　创建数据库：create database test charset utf8mb4;
　　选择数据库：use test;
　　删除数据库：drop database test;
　　备份指定数据库：mysqldump -uroot -p  test >test.sql   注：由于mysql5.6版本不支持在命令行界面输入密码，所以暂不输入密码，回车后输入密码即可。
　　备份所有数据库：mysqldump -uroot -p  -A >test.sql 
　　恢复指定数据库：mysql -uroot -p test<test.sql
　　恢复所有数据库：mysql -uroot -p  -A <test.sql

2、表操作：
　　表约束：
　　　　自增：aotu_increment
　　　　主键：primary key
　　　　非空：not null
　　　　默认值：default 'xx'
　　　　唯一：unique
　　　　指定字符集：charset utf8mb4
　　查看表：
　　　　查看表：show tables;
　　　　查看创建表语句：show create table user;
　　　　查看表结构：desc user;
　　创建表：
        create table user(
            id int auto_increment primary key,  #ID自增并设置为主键
            name varchar(10) not null,          #姓名不允许为空
            sex varchar(5) default 1,           #性别默认1
            phone bigint not null unique,       #电话不允许为空并且唯一
            create_time datetime default now(), #创建时间默认当前时间
            addr varchar(50)
        )ENGINE=InnoDB DEFAULT CHARSET=utf8;

　　删除表：
　　　　删除表：drop table user;
　　修改表：
　　　　修改表名称：alter table user rename user1;
　　　　修改字段类型并重命名：alter table user change name names varchar(15);
　　　　修改字段类型：alter table user modify names varchar(15);
　　　　在指定位置新增字段：alter table user add password varchar(20) not null after names;

3、数据操作
　　增加数据：
　　　　表中新增数据：insert into user values('','张三','男','1234567890',NOW(),'北京市海淀区');
　　　　表中指定字段添加数据：insert into user(name,phone,create_time) values('张三','12348567890',NOW());  注：如果字段设置非空，则必须添加
　　删除数据：
　　　　删除表中数据：delete from user;  注：自增长ID不会清空，还会从原有的ID开始继续增长
　　　　清空表：truncate user; 
　　　　删除表中指定的数据：delete from user where id=1;
　　更改数据：
　　　　更改表中所有数据：update user set sex='男';
　　　　更改表中指定数据：update user set sex='男' where  name='张三';
　　　　更改表中多个字段：update user set sex='男',addr='北京市朝阳区' where  name='张三';
　　　　在原有数据基础上更改：update user set phone=phone+1 where  name='张三';
　　查询数据：
　　　　查询前5条数据：select * from user limit 5;
　　　　查询第3至6条数据：select * from user limit 2,4;  注：从第几条开始查询(下标从0开始)，查询多少条
　　　　查询指定字段：select  name,sex,phone from user;
　　　　单表查询：select * from user where name='张三' and sex='男';  注：and表示多个条件必须同时满足
　　　　　　　　　select * from user where name='张三'  or  sex='男';  注：or表示有其中一个条件满足即可
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
　　　　多表查询：
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
　　添加用户：
　　　　insert into user (user,host,password) values('xiaoxitest','%',PASSWORD('123456')); #添加xiaoxitest用户并允许远程计算机登录，密码为：123456
　　更改用户：
　　　　update user set password=password("654321") where user='xiaoxitest'; #更改用户密码
　　　　update user set user='xiaoxi' where user='xiaoxitest';　　#更改用户名xiaoxitest为xiaoxi
　　删除用户：
　　　　delete from user where user='xiaoxi';　　#删除xiaoxi用户

5、权限管理
　　用户授权：
　　授权格式：grant 权限 on 数据库.* to 用户名@登录主机 identified by "密码" with grant option;
　　　　grant all on  *.* to 'xiaoxi'@'%' IDENTIFIED BY '123456' with grant option;  #表示为xiaoxi用户添加所有数据库所有权限，并可以给其他人授权。
　　　　grant all on  test.* to 'xiaoxi'@'%' IDENTIFIED BY '123456' ;　　#表示为xiaoxi用户添加test数据库所有权限
　　　　grant select on  *.* to 'xiaoxi'@'%' IDENTIFIED BY '123456' ;　　#表示为xiaoxi用户添加所有数据库查询权限
　　取消授权：
　　　　Revoke select on *.* from 'xiaoxi'@'%';　　#表示为xiaoxi用户取消所有数据库查询权限
　　　　Revoke all on *.* from 'xiaoxi'@'%';　　#表示为xiaoxi用户取消所有数据库所有权限
　　刷新权限：
　　　　flush privileges;


#mysql --增删改查


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


#重命名表名：user7变为user8
ALTER TABLE user7 RENAME TO user8;
ALTER TABLE user8 RENAME AS user7;#TO  和     AS   都可以省略
ALTER TABLE user8 RENAME user7;

RENAME TABLE 原表名 TO 新表名;#这个TO不能省略

添加和删除字段

#添加字段，删除字段
#添加：ALTER TABLE tbl_name ADD 字段名称  字段类型[完整性约束条件][FIRST|AFTER 字段名称]（加在首部或者某个字段之后）   和写字段差不多  最后可以字段的位置
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

#注意：这里如果建表的时候自增长和主键同时存在的时候，你不能直接删除主键，而是应该先是删除AOTU_INCREMENT，然后再删除主键
ALTER TABLE 表名 MODIFY id UNSIGNED NOT NULL;#这样自增长就没有了 

添加删除唯一

#添加测试索引
ALTER TABLE 表名 ADD UNIQUE(username);
ALTER TABLE 表名 ADD  CONSTRAINT symbol UNIQUE  uni_id(username);#这里的uni_id 是一个索引的名称，如果不写这个系统会让字段名称变成默认的索引名称
ALTER TABLE 表名 ADD  CONSTRAINT symbol UNIQUE  aa(card，username);#复合索引唯一

#删除索引唯一
ALTER TABLE 表名 DROP {INDEX|KEY} 唯一名称;

#修改表的引擎
ALTER TABLE 表名 ENGINE=MyISAM;

#修改自增长值
ALTER TABLE 表名 AUTO_INCREMENT=100;

删除数据表

#删除数据表     
DROP TABLE [IF  EXISTS]表名;#可以一次删除多个  也可以删除一个    类似于添加。
当然手动删除也是可以的。必须先关闭mysql，在关闭mysql服务，最后在文件中手动删除数据表，

#当我们进入mysql想登录的同时直接打开某个数据库的时候：
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

