select * from am_api order by api_id;
select * from am_api order by api_id DESC; #逆序
SELECT Company, OrderNumber FROM Orders ORDER BY Company DESC, OrderNumber ASC #以逆字母顺序显示公司名称，并以数字顺序显示顺序号
select count(*) from am_api;

查看表结构信息
 desc 表名;
 show columns from 表名;
 describe 表名;

显示如何创建一个表,方便学习创建表。
 show create table 表名;




SELECT 列名称 FROM 表名称 WHERE 列 运算符 值
INSERT INTO 表名称 VALUES (值1, 值2,....)
INSERT INTO table_name (列1, 列2,...) VALUES (值1, 值2,....)
UPDATE 表名称 SET 列名称 = 新值 WHERE 列名称 = 某值
DELETE FROM 表名称 WHERE 列名称 = 值
select name from am_env limit 2;
select * from am_env limit 2;
SELECT column_name(s) FROM table_name WHERE column_name LIKE pattern
select NAME from am_env where name like "lgj%";
select * from am_env where name like "lgj%";
select NAME from am_env where name not like "lgj%";

在 SQL 中，可使用以下通配符：
通配符     描述
%       替代一个或多个字符
_       仅替代一个字符
[charlist]      字符列中的任何单一字符

[^charlist]
或者          不在字符列中的任何单一字符
[!charlist]

ALTER TABLE table_name ADD column_name datatype
ALTER TABLE table_name DROP COLUMN column_name
alter table persons change city city varchar(200) not null;
alter table persons modify address varchar(150);


alter add命令用来增加表的字段。

alter add命令格式：alter table 表名 add字段 类型 其他;

例如，在表MyClass中添加了一个字段passtest，类型为int(4)，默认值为0：
   mysql> alter table MyClass add passtest int(4) default '0';

1) 加索引
   mysql> alter table 表名 add index 索引名 (字段名1[，字段名2 …]);

例子： mysql> alter table employee add index emp_name (name);

2) 加主关键字的索引
    mysql> alter table 表名 add primary key (字段名);

例子： mysql> alter table employee add primary key(id);

3) 加唯一限制条件的索引
   mysql> alter table 表名 add unique 索引名 (字段名);

例子： mysql> alter table employee add unique emp_name2(cardnumber);

4) 删除某个索引
   mysql> alter table 表名 drop index 索引名;

例子： mysql>alter table employee drop index emp_name;

5) 增加字段
    mysql> ALTER TABLE table_name ADD field_name field_type;

6) 修改原字段名称及类型
    mysql> ALTER TABLE table_name CHANGE old_field_name new_field_name field_type;

7) 删除字段
    MySQL> ALTER TABLE table_name DROP field_name;
