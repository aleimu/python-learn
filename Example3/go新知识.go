===============golang pipe==============
package main

import (
    "fmt"
    "io"
)

func main() {
    reader, writer := io.Pipe()
    inputData := []byte("1234567890ABCD")
    go writer.Write(inputData)
    outputData := make([]byte, 11)
    n, _ := reader.Read(outputData)
    fmt.Println(string(outputData))
    fmt.Println("read number", n)
    fmt.Println(string(outputData))

}

/*
1234567890A
read number 11
1234567890A
*/




var r = rand.New(rand.NewSource(time.Now().UnixNano()))

func generate(writer *PipeWriter) {
    arr := make([]byte, 32)
    for {
        for i := 0; i < 32; i++ {
            arr[i] = byte(r.Uint32() >> 24)
        }
        n, err := writer.Write(arr)
        if nil != err {
            log.Fatal(err)
        }
        time.Sleep(200 * time.Millisecond)
    }
}

func main() {
    rp, wp := Pipe()
    for i := 0; i < 20; i++ {
        go generate(wp)
    }
    time.Sleep(1 * time.Second)
    data := make([]byte, 64)
    for {
        n, err := rp.Read(data)
        if nil != err {
            log.Fatal(err)
        }
        if 0 != n {
            log.Println("main loop", n, string(data))
        }
        time.Sleep(1 * time.Second)
    }
}



package main

import (
  "encoding/json"
  "io"
  "io/ioutil"
  "log"
  "net/http"
)

type msg struct {
  Text string
}

func handleErr(err error) {
  if err != nil {
    log.Fatalf("%s\n", err)
  }
}

// use a io.Pipe to connect a JSON encoder to an HTTP POST: this way you do
// not need a temporary buffer to store the JSON bytes
func main() {
  r, w := io.Pipe()

  // writing without a reader will deadlock so write in a goroutine
  go func() {
    // it is important to close the writer or reading from the other end of the
    // pipe will never finish
    defer w.Close()

    m := msg{Text: "brought to you by io.Pipe()"}
    err := json.NewEncoder(w).Encode(&m)
    handleErr(err)
  }()

  resp, err := http.Post("https://httpbin.org/post", "application/json", r)
  handleErr(err)
  defer resp.Body.Close()

  b, err := ioutil.ReadAll(resp.Body)
  handleErr(err)

  log.Printf("%s\n", b)
}







os包{
package main

import (
    "fmt"
    "io/ioutil"
    "os"
    "reflect"
    "time"
)

func main() {
    dir, _ := os.Getwd()
    fmt.Println("dir:", dir)
    err := os.Chdir("d:/project/test2")
    dir, _ = os.Getwd()
    fmt.Println("dir:", dir)

    //参数不区分大小写
    //不存在环境变量就返回空字符串 len(path) = 0
    path := os.Getenv("gopath")
    fmt.Println(path)

    //返回有效group id
    egid := os.Getegid()
    fmt.Println("egid:", egid)

    //返回有效UID
    euid := os.Geteuid()
    fmt.Println("euid:", euid)

    gid := os.Getgid()
    fmt.Println("gid:", gid)

    uid := os.Getuid()
    fmt.Println("uid:", uid)

    //err:getgroups: not supported by windows
    g, err := os.Getgroups()
    fmt.Println(g, "error", err)

    pagesize := os.Getpagesize()
    fmt.Println("pagesize:", pagesize)

    ppid := os.Getppid()
    fmt.Println("ppid", ppid)

    //filemode, err := os.Stat("main.go")
    //不存在文件返回GetFileAttributesEx test2: The system cannot find the file specified.
    filemode, err := os.Stat("main.go")
    if err == nil {
        fmt.Println("Filename:", filemode.Name())
        fmt.Println("Filesize:", filemode.Size())
        fmt.Println("Filemode:", filemode.Mode())
        fmt.Println("Modtime:", filemode.ModTime())
        fmt.Println("IS_DIR", filemode.IsDir())
        fmt.Println("SYS", filemode.Sys())
    } else {
        fmt.Println("os.Stat error", err)
    }

    //Chmod is not supported under windows.
    //在windows变化是这样子的 -rw-rw-rw- => -r--r--r--
    err = os.Chmod("main.go", 7777)
    fmt.Println("chmod:", err)
    filemode, err = os.Stat("main.go")
    fmt.Println("Filemode:", filemode.Mode())

    //access time modification time
    err = os.Chtimes("main.go", time.Now(), time.Now())
    fmt.Println("Chtime error:", err)

    //获取全部的环境变量
    data := os.Environ()
    for _, val := range data {
        fmt.Println(val)
    }
    fmt.Println("---------end---environ----------------------")

    mapping := func(s string) string {
        m := map[string]string{"xx": "sssssssssssss",
            "yy": "ttttttttttttttt"}
        return m[s]
    }
    datas := "hello $xx blog address $yy"
    //这个函数感觉还蛮有用处
    expandStr := os.Expand(datas, mapping)
    fmt.Println(expandStr)
    datas = "GOBIN PATH $gopaTh" //不区分大小写
    fmt.Println(os.ExpandEnv(datas))

    hostname, err := os.Hostname()
    fmt.Println("hostname:", hostname)

    _, err = os.Open("WWWW.XX")
    if err != nil {
        fmt.Println(os.IsNotExist(err))
        fmt.Println(err)
    }

    f, err := os.Open("WWWW.XX")
    if err != nil && !os.IsExist(err) {
        fmt.Println(f, "not exist")
    }

    //windows 下两个都是true
    fmt.Println(os.IsPathSeparator('/'))
    fmt.Println(os.IsPathSeparator('\\'))
    fmt.Println(os.IsPathSeparator('.'))

    //判断返回的error 是否是因为权限的问题
    //func IsPermission(err error) bool

    // not supported by windows
    err = os.Link("main.go", "newmain.go")
    if err != nil {
        fmt.Println(err)
    }

    var pathSep string
    if os.IsPathSeparator('\\') {
        pathSep = "\\"
    } else {
        pathSep = "/"
    }
    fmt.Println("PathSeparator:", pathSep)
    //MkdirAll 创建的是所有下级目录，如果没有就创建他
    //Mkdir 创建目录，如果是多级目录遇到还未创建的就会报错
    err = os.Mkdir(dir+pathSep+"md"+pathSep+"md"+pathSep+"md"+pathSep+"md"+pathSep+"md", os.ModePerm)
    if err != nil {
        fmt.Println(os.IsExist(err), err)
    }

    err = os.RemoveAll(dir + "md\\md\\md\\md\\md")
    fmt.Println("removall", err)

    //rename 实际上通过movefile来实现的
    err = os.Rename("main.go", "main1.go")

    f1, _ := os.Stat("main.go")
    f2, _ := os.Stat("main1.go")
    if os.SameFile(f1, f2) {
        fmt.Println("the sanme")
    } else {
        fmt.Println("not same")
    }

    //os.Setenv 这个函数是设置环境变量的很简单
    evn := os.Getenv("WD_PATH")
    fmt.Println("WD_PATH:", evn)
    err = os.Setenv("WD_PATH", "D:/project")
    if err != nil {
        fmt.Println(err)
    }

    tmp, _ := ioutil.TempDir(dir, "tmp")
    fmt.Println(tmp)
    tmp = os.TempDir()
    fmt.Println(tmp)

    cf, err := os.Create("golang.go")
    defer cf.Close()
    fmt.Println(err)
    fmt.Println(reflect.ValueOf(f).Type())

    of, err := os.OpenFile("golang.goss", os.O_RDWR|os.O_CREATE|os.O_TRUNC, 0777)
    defer of.Close()
    fmt.Println("os.OpenFile:", err)

    oof, err := os.Open("golang.goss")
    defer oof.Close()
    fmt.Println("os.Open file:", oof.Fd())
    fmt.Println("os.Open err:", err)
    oof.Close()

    r, w, err := os.Pipe()
    w.Write([]byte("1111"))
    var buf = make([]byte, 4)
    r.Read(buf)
    fmt.Println(buf)
    w.Write([]byte("2222"))
    r.Read(buf) // 如果没有调用w.Write(),r.Read()就会阻塞
    fmt.Println("ssss--", buf)

    b := make([]byte, 100)
    ff, _ := os.Open("main.go")
    n, _ := ff.Read(b)
    fmt.Println(n)
    fmt.Println(string(b[:n]))

    //第二个参数，是指，从第几位开始读取
    n, _ = ff.ReadAt(b, 20)
    fmt.Println(n)
    fmt.Println(string(b[:n]))

    //获取文件夹下文件的列表
    dirs, err := os.Open("md")
    if err != nil {
        fmt.Println(err)
    }
    defer dirs.Close()
    //参数小于或等去0，表示读取所有的文件
    //另外一个只读取文件名的函数
    //fs, err := dirs.Readdirname(0)
    fs, err := dirs.Readdir(-1)
    if err == nil {
        for _, file := range fs {
            fmt.Println(file.Name())
        }
    } else {
        fmt.Println("Readdir:", err)
    }

    //func (f *File) WriteString(s string) (ret int, err error)
    //写入字符串函数原型，哪个个函数比较快呢？？

    //p, _ := os.FindProcess(628)
    //fmt.Println(p)
    //p.Kill()
    attr := &os.ProcAttr{
        Files: []*os.File{os.Stdin, os.Stdout, os.Stderr},
    }
    //参数也可以这么写 `c:\windows\system32\notepad.EXE`  用的是反单引号
    p, err := os.StartProcess("c:\\windows\\system32\\notepad.EXE", []string{"c:\\windows\\system32\\notepad.EXE", "d:/1.txt"}, attr)
    p.Release()
    time.Sleep(1000000000)
    p.Signal(os.Kill)
    os.Exit(10)

}

func OpenFile(name string, flag int, perm FileMode) (file *File, err error)　//指定文件权限和打开方式打开name文件或者create文件，其中flag标志如下:

打开标记：

O_RDONLY：只读模式(read-only)
O_WRONLY：只写模式(write-only)
O_RDWR：读写模式(read-write)
O_APPEND：追加模式(append)
O_CREATE：文件不存在就创建(create a new file if none exists.)
O_EXCL：与 O_CREATE 一起用，构成一个新建文件的功能，它要求文件必须不存在(used with O_CREATE, file must not exist)
O_SYNC：同步方式打开，即不使用缓存，直接写入硬盘
O_TRUNC：打开并清空文件
至于操作权限perm，除非创建文件时才需要指定，不需要创建新文件时可以将其设定为０.虽然go语言给perm权限设定了很多的常量，但是习惯上也可以直接使用数字，如0666(具体含义和Unix系统的一致).
func Pipe() (r *File, w *File, err error)        //返回一对连接的文件，从r中读取写入w中的数据，即首先向w中写入数据，此时从r中变能够读取到写入w中的数据，Pipe()函数返回文件和该过程中产生的错误．

func main() {
	r, w, _ := os.Pipe()
	w.WriteString("hello,world!")
	var s = make([]byte, 20)
	n, _ := r.Read(s)
	fmt.Println(string(s[:n])) //  hello,world!
}

}



syscall调用winapi{

syscall.Syscall系列方法
当前共5个方法

syscall.Syscall
syscall.Syscall6
syscall.Syscall9
syscall.Syscall12
syscall.Syscall15
分别对应 3个/6个/9个/12个/15个参数或以下的调用

参数都形如

syscall.Syscall(trap, nargs, a1, a2, a3)
第二个参数, nargs 即参数的个数,一旦传错, 轻则调用失败,重者直接APPCARSH

多余的参数, 用0代替

调用示例
获取磁盘空间

//首先,准备输入参数, GetDiskFreeSpaceEx需要4个参数, 可查MSDN
dir := "C:"
lpFreeBytesAvailable := int64(0) //注意类型需要跟API的类型相符
lpTotalNumberOfBytes := int64(0)
lpTotalNumberOfFreeBytes := int64(0)

//获取方法的引用
kernel32, err := syscall.LoadLibrary("Kernel32.dll") // 严格来说需要加上 defer syscall.FreeLibrary(kernel32)
GetDiskFreeSpaceEx, err := syscall.GetProcAddress(syscall.Handle(kernel32), "GetDiskFreeSpaceExW")

//执行之. 因为有4个参数,故取Syscall6才能放得下. 最后2个参数,自然就是0了
r, _, errno := syscall.Syscall6(uintptr(GetDiskFreeSpaceEx), 4,
            uintptr(unsafe.Pointer(syscall.StringToUTF16Ptr("C:"))),
            uintptr(unsafe.Pointer(&lpFreeBytesAvailable)),
            uintptr(unsafe.Pointer(&lpTotalNumberOfBytes)),
            uintptr(unsafe.Pointer(&lpTotalNumberOfFreeBytes)), 0, 0)

// 注意, errno并非error接口的, 不可能是nil
// 而且,根据MSDN的说明,返回值为0就fail, 不为0就是成功
if r != 0 {
    log.Printf("Free %dmb", lpTotalNumberOfFreeBytes/1024/1024)
}
简单点的方式? 用syscall.Call
跟Syscall系列一样, Call方法最多15个参数. 这里用来Must开头的方法, 如不存在,会panic.

h := syscall.MustLoadDLL("kernel32.dll")
c := h.MustFindProc("GetDiskFreeSpaceExW")
lpFreeBytesAvailable := int64(0)
lpTotalNumberOfBytes := int64(0)
lpTotalNumberOfFreeBytes := int64(0)
r2, _, err := c.Call(uintptr(unsafe.Pointer(syscall.StringToUTF16Ptr("F:"))),
    uintptr(unsafe.Pointer(&lpFreeBytesAvailable)),
    uintptr(unsafe.Pointer(&lpTotalNumberOfBytes)),
    uintptr(unsafe.Pointer(&lpTotalNumberOfFreeBytes)))
if r2 != 0 {
    log.Println(r2, err, lpFreeBytesAvailable/1024/1024)
}
}







