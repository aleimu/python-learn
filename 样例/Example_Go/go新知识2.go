https://github.com/VividCortex/godaemon
https://github.com/9466/daemon/blob/master/daemon.go
golang daemon守护进程{
package main
 
import (
    "fmt"
    "log"
    "os"
    "runtime"
    "syscall"
    "time"
)
 
func daemon(nochdir, noclose int) int {
    var ret, ret2 uintptr
    var err syscall.Errno
 
    darwin := runtime.GOOS == "darwin"
 
    // already a daemon
    if syscall.Getppid() == 1 {
        return 0
    }
 
    // fork off the parent process
    ret, ret2, err = syscall.RawSyscall(syscall.SYS_FORK, 0, 0, 0)
    if err != 0 {
        return -1
    }
 
    // failure
    if ret2 < 0 {
        os.Exit(-1)
    }
 
    // handle exception for darwin
    if darwin && ret2 == 1 {
        ret = 0
    }
 
    // if we got a good PID, then we call exit the parent process.
    if ret > 0 {
        os.Exit(0)
    }
 
    /* Change the file mode mask */
    _ = syscall.Umask(0)
 
    // create a new SID for the child process
    s_ret, s_errno := syscall.Setsid()
    if s_errno != nil {
        log.Printf("Error: syscall.Setsid errno: %d", s_errno)
    }
    if s_ret < 0 {
        return -1
    }
 
    if nochdir == 0 {
        os.Chdir("/")
    }
 
    if noclose == 0 {
        f, e := os.OpenFile("/dev/null", os.O_RDWR, 0)
        if e == nil {
            fd := f.Fd()
            syscall.Dup2(int(fd), int(os.Stdin.Fd()))
            syscall.Dup2(int(fd), int(os.Stdout.Fd()))
            syscall.Dup2(int(fd), int(os.Stderr.Fd()))
        }
    }
 
    return 0
}
 
func main() {
    daemon(0, 1)
    for {
        fmt.Println("hello")
        time.Sleep(1 * time.Second)
    }
 
}

}


重定向{
import (
	"code.google.com/p/log4go"
	"os"
	"syscall"
)

var (
	kernel32         = syscall.MustLoadDLL("kernel32.dll")
	procSetStdHandle = kernel32.MustFindProc("SetStdHandle")
)

func SetStdHandle(stdhandle int32, handle syscall.Handle) error {
	r0, _, e1 := syscall.Syscall(procSetStdHandle.Addr(), 2, uintptr(stdhandle), uintptr(handle), 0)
	if r0 == 0 {
		if e1 != 0 {
			return error(e1)
		}
		return syscall.EINVAL
	}
	return nil
}

var f *os.File

func redirect_err() {
	var err error
	f, err = os.Create(`panic.txt`)
	if err != nil {
		log4go.Error("os.Create failed: %v", err)
	}
	err = SetStdHandle(syscall.STD_ERROR_HANDLE, syscall.Handle(f.Fd()))
	if err != nil {
		log4go.Error("SetStdHandle failed: %v", err)
	}
}	
}

golang使用pipe读取子进程的标准输出{
	
cmd := exec.Command("cmd", "args")
stdout, err := cmd.StdoutPipe()
cmd.Start()
r := bufio.NewReader(stdout)
line, _, err := r.ReadLine()


generator := exec.Command("cmd1")
consumer := exec.Command("cmd2")

pipe, err := consumer.StdinPipe()
generator.Stdout = pipe
}

{
重定向子进程的stdoutpipeline在golang（解决） 

go 标准输出stdout cli
我写在旅途中的程序，执行程序一样（也去）的服务器。现在，我想有我开始父程序在我的终端窗口中的子计划的标准输出。做到这一点的方法之一是用cmd.Output（）函数，但是这仅打印后的进程已退出标准输出。 （那是一个问题这台服务器一样的程序运行很长，我想读的日志输出） 变量out的类型io.ReadCloser的，我不知道我应该用它做来实现我的任务，我找不到任何帮助在网络上关于这一主题。
package main
import "exec"
//import "fmt"
var prog string = "/path/to/my/child/program"
func main() {
 for {
  cmd := exec.Command(prog)
  out, err := cmd.StdoutPipe()
  if err != nil {
   fmt.Println(err)
  }
  err = cmd.Start()
  if err != nil {
   fmt.Println(err)
  }
  //fmt.Println(out)
  cmd.Wait()
 }
} 
阐释的代码：导入和调用println函数来获得我知道的println（出io.ReadCloser）不是函数的代码。 （它产生的输出＆{3|0}）这两行只是需要获取代码 编辑： 感谢ruakh我得到了正确的代码的答案：
package main
import (
 "os/exec" 
 "os"
 "fmt"
 "io"
)
var prog string = "/path/to/my/child/program"
func main() {
 for {
  cmd := exec.Command(prog)
  stdout, err := cmd.StdoutPipe()
  if err != nil {
   fmt.Println(err)
  }
  stderr, err := cmd.StderrPipe()
  if err != nil {
   fmt.Println(err)
  }
  err = cmd.Start()
  if err != nil {
   fmt.Println(err)
  }
  go io.Copy(os.Stdout, stdout) 
  go io.Copy(os.Stderr, stderr) 
  cmd.Wait()
 }
}
编辑：更新GO1
本文地址 ：CodeGo.net/404456/ 
------------------------------------------------------------------------------------------------------------------------- 
1. 我相信，如果你导入io和os和替换这样的：
//fmt.Println(out)
与此：
go io.Copy(os.Stdout, out)
（见io.Copy和os.Stdout），它会做你想要的。 （未测试）。 顺便说一句，你可能会想捕捉的标准误差为好，该方法作为标准输出，但与cmd.StderrPipe和os.Stderr。 
2. 现在，我想有子计划的标准输出在我的终端 窗口在那里我开始了父程序。 无需与pipeline或Go例程 CodeGo.net，这个人是很容易。
func main() {
 // Replace `ls` (and its arguments) with something more interesting
 cmd := exec.Command("ls", "-l")
 cmd.Stdout = os.Stdout
 cmd.Stderr = os.Stderr
 cmd.Run()
}

3. 对于那些谁也不需要这样的一个循环，但想输出呼应到终端，而无需cmd.Wait（）阻塞其他
package main
import (
 "fmt"
 "io"
 "log"
 "os"
 "os/exec"
)
func checkError(err error) {
 if err != nil {
  log.Fatalf("Error: %s", err)
 }
}
func main() {
 // Replace `ls` (and its arguments) with something more interesting
 cmd := exec.Command("ls", "-l")
 // Create stdout, stderr streams of type io.Reader
 stdout, err := cmd.StdoutPipe()
 checkError(err)
 stderr, err := cmd.StderrPipe()
 checkError(err)
 // Start command
 err = cmd.Start()
 checkError(err)
 // Don't let main() exit before our command has finished running
 defer cmd.Wait() // Doesn't block
 // Non-blockingly echo command output to terminal
 go io.Copy(os.Stdout, stdout)
 go io.Copy(os.Stderr, stderr)
 // I love Go's trivial concurrency :-D
 fmt.Printf("Do other stuff here! No need to wait.\n\n")
}
	
	
}


Golang把所有包括底层类库，输出到stderr的内容， 重新定向到一个日志文件里面？{
https://github.com/golang/go/issues/325
http://www.cnblogs.com/ghj1976/p/4276390.html

exec包执行外部命令，它将os.StartProcess进行包装使得它更容易映射到stdin和stdout，并且利用pipe连接i/o
http://blog.csdn.net/chenbaoke/article/details/42556949

不论应用是如何部署的，我们都期望能扑捉到应用的错误日志，

解决思路：

自己写代码处理异常拦截，甚至直接在main函数中写异常拦截。
stderr重定向到某个文件里
使用 syscall.Dup2
第一种方法比较简单， 我们这里主要看后两种：

使用 stderr替换的代码：

package main

import ( 
    "fmt" 
    "os" 
)

func main() { 
    f, _ := os.OpenFile("C:\\tmp\\11.txt", os.O_WRONLY|os.O_CREATE|os.O_SYNC, 
        0755) 
    os.Stdout = f 
    os.Stderr = f 
    fmt.Println("fmt") 
    fmt.Print(make(map[int]int)[0]) 
}

这里的 Stdout 、Stderr  的含义如下， 同样也适用win：

在通常情况下，UNIX每个程序在开始运行的时刻，都会有3个已经打开的stream. 分别用来输入，输出，打印诊断和错误信息。通常他们会被连接到用户终端. 但也可以改变到其它文件或设备。

Linux内核启动的时候默认打开的这三个I/O设备文件：标准输入文件stdin，标准输出文件stdout，标准错误输出文件stderr，分别得到文件描述符 0, 1, 2。

stdin是标准输入，stdout是标准输出，stderr是标准错误输出。大多数的命令行程序从stdin输入，输出到stdout或stderr。

 

上面方法，可能会拦截不到一些系统级别的崩溃信息，这时候就需要走下面的方案了。

使用 syscall.Dup2  的例子如下， 注意 windows 下会编译直接报错： undefined: syscall.Dup2， 只有 linux 下才可以用。

syscall.Dup2 is a linux/OSX only thing. there's no windows equivalent。

参考： https://github.com/golang/go/issues/325

package main

import ( 
    "fmt" 
    "os" 
    "syscall" 
)

func main() { 
    logFile, _ := os.OpenFile("/tmp/x", os.O_WRONLY|os.O_CREATE|os.O_SYNC, 0755) 
    syscall.Dup2(int(logFile.Fd()), 1) 
    syscall.Dup2(int(logFile.Fd()), 2) 
    fmt.Printf("Hello from fmt\n") 
    panic("Hello from panic\n") 
}

 }

 
 
 


