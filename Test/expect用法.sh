#!/usr/bin/expect -f
if {$argc < 2} {
	#打印
　　puts stdout "$argv0 err params\n" 
　　exit 1
}
#行后面不可以加注释
#定义函数
proc do_console_login {login pass} {
puts $login;
puts $pass;
}
#打印参数长度
puts [llength $argv]
#设置变量
#set timeout -1 设置expect永不超时
set timeout 5 	
#设置超时时间
set user [lindex $argv 0] 
#获取脚本运行时带的第一个参数值
set password [lindex $argv 1]
#调用函数
do_console_login $user $password

spawn ssh $user@10.175.102.219
#判断上次输出结果里是否包含“password:”的字符串，如果有则立即返回，否则就等待一段时间后返回，等待时长就是前面设置的10秒。
#开始匹配后，里面不可以在行后面加注释
expect {				
    "(yes/no)?" {
            send "yes\r"
            expect "password:"
            send "$password\r"
            exp_continue 
        }
    "*assword" {
            send "$password\r"
            exp_continue 
        }
}

##########  puts  会把所有的打印都放在一起############
#遍历的几种方法：
	foreach  i { 1 3 5 7 9 } {
		puts "$i"
	}
#i默认增量是1，即等价incr i 1
    puts "---1---"
    for {set i 0} {$i < 3} {incr i} {
        puts "I inside first loop: $i"
    }

    puts "---2---"
    for {set i 3} {$i < 2} {incr i} {
        puts "I inside second loop: $i"
    }

    puts "---3---"
    set i 0
    while {$i < 4} {
        puts "I inside third loop: $i"
        incr i
        puts "I after incr: $i"
    }

    set i 0
    incr i
    puts "---4---"
    puts "$i"
    #expect里的加减法
    set i [expr {$i + 1}]    
    puts "---5---"
    puts "$i"
	
#替代手工输入，执行命令,每条命令以空格隔开！
if { 1 eq 1 } {
	puts "SYNC complete!"
} else {
	puts "SYNC error!"
}
#if 的用法
set File "/usr/lgj"
if {[file isfile $File]!=1} { 
send_user "$argv0: file $File not found. "
send_user "mkdir $File\n"
send "cd /usr/\r mkdir $File\n"
send "cd lgj\n touch 11.log\r"
}
send_user "for use\n"
	
send_user "read file as print\n"	
#################打开原主机中的文件在登陆机上打印################
set fd [open "./test.sh" "r"]
set number 0
# read each line
while { [gets $fd line] >= 0} {
incr number   
#puts "Number of lines: $number"
puts $line
}
send_user "read file as cmd\n"
close $fd
#################打开原主机中的文件作为shell命令行在登陆机上执行#####
set fd [open "./lgj.sh" "r"]
set number 0
while { [gets $fd line] >= 0} {
incr number   
send "$line\n"
}
close $fd

puts "you do next!";
#把控制权交给控制台，这个时候就可以手工操作
interact

