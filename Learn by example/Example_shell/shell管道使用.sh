可用于管道操作的命令{
command1 | command2 | command3
注：管道命令必须能够接受来自前一个命令的数据成为standard input继续处理。
 
cut 将一段信息的某一段切出来，处理的信息是以行为单位。
cut -d '分割字符' -f fields
cut -c 字符范围
参数：
-d : 后面接分隔符，与-f一起使用；
-f : 依据-d的分隔符将一段信息切割成为数段，用-f取出第几段的意思；
-c : 以字符(characters)的单位取出固定字符区间；
echo $PATH | cut -d ':' -f 3-5
//将path的值按照':'进行分割，后取出第3到5个值
export | cut -c 12-
//对export的输出进行切分，每行输出从第12个字符往后的内容
 
grep 分析一行信息，如果有匹配的，就将该行拿出来。
grep [-acinv] [--color=auto] '查找字符串' filename
参数：
-a : 将binary文件以text文件的方式查找数据；
-c : 计算找到’查找字符串‘的次数；
-i : 忽略大小写的不同；
-n : 带行号；
-v : 反向选择，显示没有‘查找字符串’的行；
--color=auto : 可以将找到查找的关键字部分加上颜色显示
export | grep -in --color=auto 'bin'
//列出export输出中带有bin的行，并给bin加上颜色，不区分大小写，带有行号。
 
sort 可以依据不同的数据类型进行排序。
sort [-fbMnrtuk] [file or stdin]
参数：
-f : 忽略大小写
-b : 忽略最前面的空格符
-M : 以月份的名字来排序，如 JAN, DEC等
-n : 使用“数字”进行排序（默认是以文字类型来排序的）
-r : 反向排序
-u : uniq，相同的数据，仅出现一行代表
-t : 分隔符，默认是［Tab]来分割
-k : 用哪个filed来进行排序，与-t相关
cat /etc/passwd | sort -t ':' -k 3 -n
//根据 passwd中每行，按':'分隔符进行分隔后，按照第3个字段使用纯数字的方式进行排序。
 
uniq 重复的行只显示一个
uniq [-ic]
参数：
-i : 忽略大小写
-c : 进行计数
last | cut -d ' ' -f1 | sort | uniq -c
//列出登录者名字，并进行排序，进行统一处理，并计数。
 
wc 输出信息的整体数据
wc [-lwm]
参数：
-l : 仅列出行
-w : 仅列出多少字(英文单字)
-m : 多少字符
cat /etc/man.config | wc
//输出三个数字，分表代表行，字数，字符数
 
tee 双重定向，存到文件／设备的同时，输出到屏幕以便继续处理。
tee [-a] file
参数：
[-a] : 以累加(append)的方式，输出到file中。
ls -l / | tee -a file.list | more
//把文件目录输出到file.list中，同时用more将其输出到屏幕。
 
tr 删除一段信息中的文字，或者进行文字信息的转换。
tr [-ds] XXX ...
参数：
-d : 删除信息中XXX这个字符串
-s : 替换掉重复的字符
last | tr '[a-z]' '[A-Z]'
//将last输出的信息中所有的小写字母变成大写字母
 
col 对特殊字符进行处理
col [-xb]
参数：
-x : 将tab键转换成对等的空格键
-b : 在文字内有反斜杠(/)时，仅保留反斜杠最后接的那个字符
cat /etc/man.config | col -x | cat -A | more
//将/etc/man.config内容中的[tab]转成空白，并输出。
 
join 将两个文件当中有相同数据的那一行加在一起。
join [-ti12] file1 file2
参数：
-t : join默认以空格符分隔数据，并且对比“第一个字段”的数据；如果两个文件相同，则将两条数据连成一行，且第一个字段放在第一个。
-i : 忽略大小写
-1 : (数字1)，代表第一个文件要用哪个字段进行比较
-2 : 代表第二个文件要用哪个字段进行比较
join -t ':' -1 4 /etc/passwd -2 3 /etc/group
//用分隔符':'进行分隔，第一个文件用第4个字段，第二个文件用第3个字段，进行分析。
 
paste 将两个文件贴在一起，中间以[tab]键隔开。
paste [-d] file1 file2
参数：
-d : 后面可以接分隔符，默认是以[tab]进行分隔
- : 如果file部分写成-, 表示来自standard input的数据的意思
cat /etc/group|paste /etc/passwd /etc/shadow - |head -n 3
//先将/etc/group读出，然后与/etc/passwd和/etc/shadow合并的内容粘贴在一起，且仅取出前三行。

expand 将[tab]按键转成空格键
expand [-t] file
参数：
-t : 后面可以接数字，代表一个tab用几个空格表示
 
xargs 读入stdin的数据，并且以空格符或断行符进行分辨，将stdin的数据分隔为arguments。
xargs [-0epn] command
参数：
-0 : 如果输入的stdin含有特殊字符，如,\,空格键等，这个参数可以将它还原成一般字符。
-e : 是EOF(end of file)的意思，后面可以接一个字符串，当xargs分析到这个字符串时，就停止继续工作。
-p : 在执行每个命令的参数时，都会询问用户的意见
-n : 后面接次数
cut -d ':' -f1 /etc/passwd | xargs -p -e'lp' finger
//分析到lp这个字符串时，后面的其它stdin的内容就被xargs舍弃掉了。
举个例子
如果你想统计一个文件夹下java代码的文件数量
find [folderPath] -name "*.java" | wc -l
那如果我想查询所有java代码的行数呢？
可以用xargs，因为wc -l filename可以查询单个文件的行数
find [folerPath] -name "*.java" | xargs wc -l
如果要去掉空行
find [folderPath] -name "*.java" |xargs cat| grep -v ^$|wc -l
}
