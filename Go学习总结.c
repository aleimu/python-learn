//Go学习总结--2017/3/20	
//基础语法
1.变量的定义{

var v1 int 
var v2 string 
var v3 [10]int    // 数组 ---数组有固定长度
var v31 [...]int{1,2,3,4}// 数组 --- "..."会推断数组的长度
var v4 []int      // 数组切片 ，只定义
v41 := []int{} // 数组切片，定义并赋值 
var v5 struct { 
    f int 
} 
var v6 *int     // 指针 
var v7 map[string]int  // map，key为string类型，value为int类型 
var v8 func(a int) int 

}
2.变量的初始化{
var v1 int = 10 // 正确的使用方式1  
var v2 = 10 // 正确的使用方式2，编译器可以自动推导出v2的类型 
v3 := 10 // 正确的使用方式3，编译器可以自动推导出v3的类型 
#三种方式完全一样
}
3.支持交换{
交换i和j变量的语句： 
i, j = j, i
}
4.常量{
const Pi float64 = 3.14159265358979323846  
const zero = 0.0             // 无类型浮点常量 
const ( 
    size int64 = 1024 
    eof = -1                // 无类型整型常量 
)  
const u, v float32 = 0, 3    // u = 0.0, v = 3.0，常量的多重赋值 
const a, b, c = 3, 4, "foo" 
// a = 3, b = 4, c = "foo", 无类型整型和字符串常量 

}
5.预定义常量{
Go语言预定义了这些常量：true、false和iota。 
iota比较特殊，可以被认为是一个可被编译器修改的常量，在每一个const关键字出现时被
重置为0，然后在下一个const出现之前，每出现一次iota，其所代表的数字会自动增1。 
从以下的例子可以基本理解iota的用法： 
const (            // iota被重设为0 
    c0 = iota   // c0 == 0 
    c1 = iota     // c1 == 1 
    c2 = iota     // c2 == 2  
)   
#这里写的并不完全，如果用到更深的操作，可以查看文档
}
6.类型 {

Go语言内置以下这些基础类型：  
 布尔类型：bool。 
 整型：int8、byte、int16、int、uint、uintptr等。 
 浮点类型：float32、float64。
 复数类型：complex64、complex128。 
 字符串：string。 
 字符类型：rune。 
 错误类型：error。 
此外，Go语言也支持以下这些复合类型： 
 指针（pointer） 
 数组（array） 
 切片（slice） 
 字典（map） 
 通道（chan） 
 结构体（struct） 
 接口（interface） 
}
7.位运算{
x << y  左移  124 << 2    // 结果为496 
x >> y  右移  124 >> 2    // 结果为31 
x ^ y  异或  124 ^ 2     // 结果为126 
x & y  与  124 & 2     // 结果为0 
x | y  或  124 | 2     // 结果为126 
^x  取反  ^2          // 结果为3
}
8.字符串{
var str string   // 声明一个字符串变量 
str = "Hello world" // 字符串赋值 
ch := str[0]   // 取字符串的第一个字符 
#但字符串的内容不能在初始化后被修改
x + y  字符串连接  "Hello" + "123"   // 结果为Hello123 
len(s)  字符串长度  len("Hello")      // 结果为5 
s[i]  取字符  "Hello" [1]       // 结果为'e' 

#更多的字符串操作，请参考标准库strings包。 

8.1字符串遍历 
	Go语言支持两种方式遍历字符串。
	#一种是以字节数组的方式遍历： 
	str := "Hello,世界" 
	n := len(str) 
	for i := 0; i < n; i++ { 
		ch := str[i] // 依据下标取字符串中的字符，类型为byte 
		fmt.Println(i, ch) 
	} 
	#另一种是以Unicode字符遍历：
	str := "Hello,世界" 
	for i, ch := range str { 
		fmt.Println(i, ch)//ch的类型为rune 
	} 
	#每个中文字符在UTF-8中占3个字节，而不是1个字节。
}
9.字符类型{
在Go语言中支持两个字符类型，一个是byte（实际上是uint8的别名），代表UTF-8字符串的单个字节的值；另一个是rune，代表单个Unicode字符。 
Go标准库的unicode包。另外unicode/utf8包也提供了UTF8和Unicode之间的转换。 
}
10.数组{
10.1.数组就是指一系列同一类型数据的集合，数组长度在定义后就不可更改
	#以下为一些常规的数组声明方法： 
	[32]byte       // 长度为32的数组，每个元素为一个字节 
	[2*N] struct { x, y int32 } // 复杂类型数组 
	[1000]*float64    // 指针数组 
	*[1000]float64    // 数组的指针 
	[3][5]int     // 二维数组 
	[2][2][2]float64    // 等同于[2]([2]([2]float64))  

10.2.遍历：
	for i := 0; i < len(array); i++ { 
		fmt.Println("Element", i, "of array is", array[i]) 
	} 
	for i, v := range array { 
		fmt.Println("Array element[", i, "]=", v)  
	}  

10.3.值类型
在Go语言中数组是一个值类型（value type）。所有的值类型变量在赋值和作为参数传递时都将产生一次复制动作。如果将数组作为函数的参数类型，则在函数调用时该
参数将发生数据复制。因此，在函数体中无法修改传入的数组的内容，因为函数内操作的只是所传入数组的一个副本。
	
}
11.数组切片{
11.1.数组切片的数据结构可以抽象为以下3个变量： 
 
	struct Slice
	{                        
		byte*    array;      // 一个指向原生数组的指针； 
		uintgo   len;        // 数组切片中的元素个数； 
		uintgo   cap;        // 数组切片已分配的存储空间。
	};
	//引用类型。但自身本质是结构体，值拷贝传递。 	
11.2.基于数组、直接创建、切片创建切片
    // 先定义一个数组 
    var myArray [10]int = [10]int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10} 
    // 基于数组创建一个数组切片 
    var mySlice []int = myArray[:5] 
	
	//创建一个初始元素个数为5的数组切片，元素初始值为0： 
	mySlice1 := make([]int, 5)  
	//创建一个初始元素个数为5的数组切片，元素初始值为0，并预留10个元素的存储空间： 
	mySlice2 := make([]int, 5, 10)  
	//直接创建并初始化包含5个元素的数组切片： 
	mySlice3 := []int{1, 2, 3, 4, 5}  
	//创建一个初始元素个数为0的数组切片，元素初始值为[]： 
	var mySlice4 []int	
	mySlice5 :=[]int{}
	//无论是基于数组还是切片，新产生的切片都会影响原数组或切片。原因如下:
	slice总是指向底层的一个array。slice是一个指向array的指针，这是其与array不同的地方；
	slice是引用类型，这意味着当赋值某个slice到另外一个变量，两个引用会指向
	同一个array。例如，如果一个函数需要一个slice参数，在其内对slice元素的
	修改也会体现在函数调用者中，这和传递底层的array指针类似。
11.3.append
	mySlice = append(mySlice, 1, 2, 3)  
	函数append()的第二个参数其实是一个不定参数，我们可以按自己需求添加若干个元素，
	甚至直接将一个数组切片追加到另一个数组切片的末尾： 
	mySlice2 := []int{8, 9, 10} 
	// 给mySlice后面添加另一个数组切片 
	mySlice = append(mySlice, mySlice2...) 
	append分配一个足够大的、新的slice来存放原有slice的元素和追加
	的值。因此，返回的slice可能指向不同的底层array。
11.4.copy
	slice1 := []int{1, 2, 3, 4, 5}   
	slice2 := []int{5, 4, 3}  
	 
	copy(slice2, slice1) // 只会复制slice1的前3个元素到slice2中 
	copy(slice1, slice2) // 只会复制slice2的3个元素到slice1的前3个位置 
	
	
}
12.函数参数传值、闭包传引用{
	
12.1例子1{
	package main

	import (
		//"io"
		//"os"
		//"reflect"
		"fmt"
		//"sync"
	)

	//函数参数传值, 闭包传引用!
	//slice 含 values/count/capacity 等信息, 是按值传递
	//按值传递的 slice 只能修改values指向的数据, 其他都不能修改
	//slice 是结构体和指针的混合体
	func main() {

		a := [3]int{0, 1, 2} //数组，长度必须是定值
		b := a[:]            //引用a，成为切片，共享内存地址
		c := a               //复制a，地址不同,同为数组
		fmt.Println("a在被使用前：", a)
		fmt.Printf("a:%p\nb:%p\nc:%p\n", &a, &b, &c)
		change1(a)
		fmt.Println("a值传递使用后:", a)
		change2(&a)
		fmt.Println("a引用使用后:", a)
		fmt.Printf("a:%p\nb:%p\nc:%p\n", &a, &b, &c)
		//循环的次数已经在传入时确定，改变a，也不会影响循环
		//闭包传引用
		for i, _ := range c {
			c[i] = 10
		}
		fmt.Println("range是引用类型,c引用使用后:", c)
		fmt.Printf("a:%p\nb:%p\nc:%p\n", &a, &b, &c)
	}
	//函数传值
	func change1(a [3]int) [3]int {
		a[0] = 10
		return a
	}
	func change2(a *[3]int) [3]int {
		a[0] = 10
		return *a
	}

//值类型和引用类型的区别,就在于当函数参数传递的时候.
//值类型是把自己的值复制一份传递给别的函数操作.无论复制的值怎么被改变.其自身的值是不会改变的
//而引用类型是把自己的内存地址传递给别的函数操作.操作的就是引用类型值的本身.所以值被函数改变了.

/*
a在被使用前： [0 1 2]
a:0x122c60e0
b:0x122c6100
c:0x122c6110
a值传递使用后: [0 1 2]
a引用使用后: [10 1 2]
a:0x122c60e0
b:0x122c6100
c:0x122c6110
range是引用类型,c引用使用后: [10 10 10]
a:0x122c60e0
b:0x122c6100
c:0x122c6110
*/
	}
12.2例子2{
	package main
	import "fmt"
	import "reflect"
	func main() {
		alist := []int{1, 2, 3, 4}//切片->直接传入
		blist := [4]int{1, 2, 3, 4}//数组1->直接传入
		blist2 := [4]int{1, 2, 3, 4}//数组2->指针传入
		c := 100//变量1->直接传入
		d := 200//变量2->指针传入
		fmt.Println("原始值:", alist, blist, blist2, c, d)
		demo(alist, blist, &blist2, c, &d)
		//1.想要改变非引用型变量的值，需要传入 &d(变量的地址)，2.想要改变值类型变量的值也需要传入&blist2 3.slice是一个指向array的指针，所以切片传入时不需要加 &，引用型变量都不用加
		fmt.Println("使用后:", alist, blist, blist2, c, d)
	}

	//内建变量与引用型变量传入函数的区别
	func demo(la []int, lb [4]int, lc *[4]int, c int, d *int) {
		la[0] = 10
		lb[0] = 10
		lc[0] = 10 //在函数中使用不用加*
		c = 1000
		*d = 1000 //非引用型变量在函数中使用需要加 * 才能被使用
	}

	/*重点！！
	 &  取一个变量的地址
	 *  取指针变量所指向的地址中的值

	引用类型包括 slice、map 和 channel
	数组算是值类型
	*/
	
	/*结果
	原始值: [1 2 3 4] [1 2 3 4] [1 2 3 4] 100 200
	使用后: [10 2 3 4] [1 2 3 4] [10 2 3 4] 100 1000
*/
}
	
}
13.类型转换{
//<目标类型的值>，<布尔参数> := <表达式>.( 目标类型 ) // 安全类型断言
//<目标类型的值> := <表达式>.( 目标类型 )　　//非安全类型断言
func test6() {
	var i interface{} = "TT"
	j, b := i.(int)
	if b {
		fmt.Printf("%T->%d\n", j, j)
	} else {
		fmt.Println("类型不匹配")
	}
} //断言式   安全类型转换

func echoArray(a interface{}){
    b,c:=a.([]int)//通过断言实现类型转换
	if c {
		for _,v:=range b{
　　　　fmt.Print(v," ")
	　　}
	　　fmt.Println()
	　　return
	}　
}　

//合法转换
{
	+ From 		xb[]byte 	xi[]int		xr[]rune 	s string 	f float32   	i int
	+ To
	+ []byte  										[]byte(s)
	+ []int  										[]int(s)
	+ []rune 							 			[]rune(s)
	+ string 	string(xb) string(xi) string(xr) 
	+ float32  																float32(i)
	+ int 														int(f) 
	//例子
	b := []byte{'h','e','l','l','o'}   复合声明
	s := string(b)
	i := []rune{257,1024,65}
	r := string(i)
	
}

//进阶 Go语言要求不同的类型之间必须做显示的转换。转化分为 类型转换和接口转化。
{
	#X类型需要转换为Y类型，语法是y(x),如果对于某些地方的优先级拿不准可以自己加()约束，变成(T)(X)。如：
	*Point(p) // 和 *(Point(p))一样
	(*Point)(p) // p 转换成 *Point
	(func())(x) // x 转换成unc()
	(func() int)(x) // x 转换 func() int
	 
	//接口转换
	比如有以下2个接口类型:
	type IA interface {}
	type IB interface {Foo()}
	 
	IA要向IB转换：
	var a A
	var b = a.(B)
	IB像IA转换：
	var b B
	var a = A(b)
	 
	上面两个转换的区别：
	1、首先要意识到IB比IA多了个方法Foo()，它是IA的子集。
	2、IA转成IB，是由一般向特殊的转换，不一定能成功，所以要用断言a.(B) ,从“断言”这个字面意思也可以理解要“判断”一下，不一定能成功。
	3、IB转化成IA，是由特殊向一般的转化，直接A(b)强制转化就可以了。
} 
//go中基础类型比如string,int,bool之间的转化需要用strconv包。

	
}
14.map{
	
// PersonInfo是一个包含个人详细信息的类型 
type PersonInfo struct { 
    ID string 
    Name string 
    Address string 
} 
14.1.变量声明  
var myMap map[string] PersonInfo 
//myMap是声明的map变量名，string是键的类型，PersonInfo则是其中所存放的值类型。  
14.2.创建 
//可以使用Go语言内置的函数make()来创建一个新map。下面的这个例子创建了一个键类型为string、值类型为PersonInfo的map: 
myMap = make(map[string] PersonInfo) 
//也可以选择是否在创建时指定该map的初始存储能力，下面的例子创建了一个初始存储能力为100的map: 
myMap = make(map[string] PersonInfo, 100)  
14.3.元素赋值 
myMap["1234"] = PersonInfo{"1", "Jack", "Room 101,..."} 
14.4.元素删除 
//Go语言提供了内置函数delete()，用于删除容器内的元素
delete(myMap, "1234") 	
14.5.查找
要从map中查找一个特定的键，可以通过下面的代码来实现： 
value, ok := myMap["1234"]  
if ok { // 找到了 
    // 处理找到的value  
}

}
15.流程控制{
//Go语言支持如下的几种流程控制语句： 
 条件语句，对应的关键字为if、else和else if； 
 选择语句，对应的关键字为switch、case和select（将在介绍channel的时候细说）；
 循环语句，对应的关键字为for和range； range迭代器操作，返回 (索引, 值) 或 (键, 值)。
 跳转语句，对应的关键字为goto。 
Go语言还添加了如下关键字：break、continue和fallthrough。
//在有返回值的函数中，不允许将“最终的”return语句包含在if...else...结构中否则会编译失败：

//例子
{
	switch i { 
    case 0: 
        fmt.Printf("0") 
    case 1: 
        fmt.Printf("1") 
    case 2: 
        fallthrough 
    case 3: 
        fmt.Printf("3") 
    case 4, 5, 6: 
        fmt.Printf("4, 5, 6") 
    default: 
        fmt.Printf("Default") 
} 
运行上面的案例，将会得到如下结果： 
 i = 0时，输出0； 
 i = 1时，输出1； 
 i = 2时，输出3；
 i = 3时，输出3； 
 i = 4时，输出4, 5, 6； 
 i = 5时，输出4, 5, 6； 
 i = 6时，输出4, 5, 6； 
 i = 其他任意值时，输出Default。
//只有在case中明确添加fallthrough关键字，才会继续执行紧跟的下一个case；
//它不会匹配失败后自动向下尝试，但是可以使用 fallthrough 使其这样做。没有fallthrough：
	switch i {
	case 0: // 空的 case 体
	case 1:
	f() // 当 i == 0 时，f 不会被调用！
	}
	//而这样：
	switch i {
	case 0: fallthrough
	case 1:
	f() // 当 i == 0 时，f 会被调用！
	} 


//循环嵌套循环时，可以在break后指定标签。用标签决定哪个循环被终止：

J:
	for j := 0; j < 5; j++ {
		for i := 0; i < 10; i++ {
			if i > 5 {
				break J //现在终止的是 j 循环，而不是 i 的那个
			}
			println(i)
		}
	}
//利用continue让循环进入下一个迭代，而略过剩下的所有代码。下面循环打印了0到5。
	for i := 0; i < 10; i++ {
		if i > 5 {
			continue //跳过循环中所有的代码
			println(i)

		}

	}
//保留字range可用于循环。它可以在slice、array、string、map和channel。range是个迭代器，当被调用的时候，从它循环的内容中返回一个键值对。
//基于不同的内容，range返回不同的东西。当对slice或者array做循环时，range返回序号作为键，这个序号对应的内容作为值。考虑这个代码：
list := []string{"a", "b", "c", "d", "e", "f"}

for k, v := range list {
// 对 k 和 v 做想做的事情 
}
//例子
func main() {
L1:
    for x := 0; x < 3; x++ {
L2:
        for y := 0; y < 5; y++ {
            if y > 2 { continue L2 }
            if x > 1 { break L1 }
            print(x, ":", y, " ")
        }
        println()
    }
}
//输出：
0:0  0:1  0:2
1:0  1:1  1:2
//附：break 可用于 for、switch、select， continue 仅能用于 for 循环。

 
}
}
16.预定义函数{
//Table 2.3. Go中的预定义函数与保留字:
close new panic complex delete make recover real len append print imag cap copy println
/*用处
close 用于channel通讯。使用它来关闭channel
delete 用于在map中删除实例
len和cap 可用于不同的类型， len用于返回字符串、slice和数组的长度
copy 用于复制slice。
append 用于追加slice
panic和recover 用于异常处理机制。
print和println 是底层打印函数，可以在不引入 fmt包的情况下使用。它们主要用于调试。
*/
//Table 2.2. Go中的保留字
break default func interface select
case defer go map struct
chan else goto package switch
const fallthrough if range type
continue for import return var

#new分配；make初始化
{
• new(T)返回*T指向一个零值T
• make(T)返回初始化后的T
//当然make仅适用于slice，map和channel。
	var p *[]int = new([]int)    //分配 slice 结构内存；*p == nil已经可用
	var v []int = make([]int, 0) //v 指向一个新分配的有 0 个整数的数组。
	fmt.Println(p)	//&[]
	fmt.Println(v)	//[]
}	
}
17.指针{
p = &i   //获取 i 的地址
*p = 8   //修改 i 的值

func zhizheng() {
	var p *int      //在p是一个指向整数值的指针,所有新定义的变量都被赋值为其类型的零值
	fmt.Println(p)  // 打印 nil
	var i int       //定义一个整形变量 i
	p = &i          //使得 p 指向 i,获取 i 的地址
	fmt.Println(p)  //打印出来的内容类似 0x7ff96b81c000a
	*p = 8          //修改 i 的值
	fmt.Println(*p) //打印 8
	fmt.Println(i)  // 同上
}	
}
18.函数{

type mytype int   //新的类型
func (p mytype) funcname(q int) (r,s int) { //函数的结构
	//do something
	return 0,0 
	}

保留字func用于定义一个函数；
1 函数可以定义用于特定的类型，这类函数更加通俗的称呼是method。这部分称作receiver而它是可选的。
2 funcname是你函数的名字
3 int类型的变量q作为输入参数。参数用pass-by-value方式传递，意味着它们会被复制；
4 变量r和s是这个函数的命名返回值。在Go的函数中可以返回多个值。如果不想对返回的参数命名，只需要提供类型：(int,int)。如果只有一个返回值，可以省略圆括号。如果函数是一个子过程，并且没有任何返回值，也可以省略这些内容.
5 这是函数体，注意return是一个语句，所以包裹参数的括号是可选的。

//因此需要先牢记这样的规则：小写字母开头的函数只在本包内可见，大写字母开头的函数才能被其他包使用。 
//这个规则也适用于类型和变量的可见性。 

//任意类型的不定参数 
之前的例子中将不定参数类型约束为int，如果你希望传任意类型，可以指定类型为interface{}。下面是Go语言标准库中fmt.Printf()的函数原型： 
	func Printf(format string, args ...interface{}) { 
	 // ...  
	}  
//匿名函数与调用
	f := func(x, y int) int { 
		return x + y  
	} 
	 
	func(ch chan int) { 
		ch <- ACK  
	} (reply_chan) // 花括号后直接跟参数列表表示函数调用 

}
19.作用域{
在Go中，定义在函数外的变量是全局的，那些定义在函数内部的变量，对于
函数来说是局部的。如果命名覆盖——一个局部变量与一个全局变量有相同的
名字——在函数执行的时候，局部变量将覆盖全局变量。
}
20.defer{
//Go有了defer语句。在defer后指定的函数会在函数退出前调用。
	func ReadWrite() bool {
		file.Open("file")
		defer file.Close()   //file.Close() 被添加到了 defer 列表
	}

	//可以将多个函数放入“延迟列表”中
	for i := 0; i < 5; i++ {
		defer fmt.Printf("%d ", i)
	}
	//延迟的函数是按照后进先出（LIFO）的顺序执行，所以上面的代码打印：4 3 2 1 0

	//利用defer甚至可以修改返回值，假设正在使用命名结果参数和闭包函数
	defer func() {//匿名函数的定义方式
		/* ... */
	}()   //() 在这里是必须的

	defer func(x int) {
	/* ... */
	}(5)   //为输入参数 x 赋值 5

	//在defer中修改返回值
	func f() (ret int) {   //ret 初始化为零
	defer func() {
		ret++   //ret 增加为 1
	}()
	return 0   //返回的是 1 而不是 0
	}
	
}
21.Go的面向对象{
//在Go语言中，面向对象的神秘面纱被剥得一干二净。对比下面的两段代码：
func (a Integer) Less(b Integer) bool {   // 面向对象 
    return a < b 
} 
func Integer_Less(a Integer, b Integer) bool {  // 面向过程 
    return a < b 
} 
 
a.Less(2)       // 面向对象的用法 
Integer_Less(a, 2)     // 面向过程的用法 

//Go语言和C语言一样，类型传入函数时都是基于值传递的。要想修改变量的值，只能传递指针。
}
22.值语义和引用语义 {
//值语义和引用语义的差别在于赋值，比如下面的例子： 
b = a 
b.Modify() 
//如果b的修改不会影响a的值，那么此类型属于值类型。如果会影响a的值，那么此类型是引用类型。
 
//Go语言中的大多数类型都基于值语义，包括： 
 基本类型，如byte、int、bool、float32、float64和string等； 
 复合类型，如数组（array）、结构体（struct）和指针（pointer）等。

//Go语言中有4个类型比较特别，看起来像引用类型，如下所示。 
 数组切片：数组切片内部是指向数组的指针，所以可以改变所指向的数组元素并不奇怪。数组切片类型本身的赋值仍然是值语义。
 map：map本质上是一个字典指针
 channel：执行体（goroutine）间的通信设施。 
 接口（interface）：对一组满足某个契约的类型的抽象。 
}
23.结构体与方法{
	//定义一个矩形类型：
	type Rect struct { 
    x, y float64 
    width, height float64 //小写的对外不可见
	} 
	//定义成员方法Area()来计算矩形的面积： 
	func (r *Rect) Area() float64 { 
		return r.width * r.height 
	} 
	//初始化结构体
	rect1 := new(Rect) 
	rect2 := &Rect{} 
	rect3 := &Rect{0, 0, 100, 200} 
	rect4 := &Rect{width: 100, height: 200} 
//在Go语言中，未进行显式初始化的变量都会被初始化为该类型的零值，例如bool类型的零值为false，int类型的零值为0，string类型的零值为空字符串。 
//注意首字母大写的字段可以被导出，也就是说，在其他包中可以进行读写。字段名以小写字母开头是当前包的私有的
	
	#方法
	可以对新定义的类型创建函数以便操作，可以通过两种途径：
	1. 创建一个函数接受这个类型的参数。
	
	func doSomething(in1 *NameAge, in2 int) { /* ... */ }

	2. 创建一个工作在这个类型上的函数：
	
	func (in1 *NameAge) doSomething(in2 int) { /* ... */ }
	
	//可以类似这样使用：
	var n *NameAge
	n.doSomething(2)
	3. 每个类型都有与之关联的方法集，这会影响到接口实现规则。
	•类型 T 方法集包含全部 receiver T 方法。
	•类型 *T 方法集包含全部 receiver T + *T 方法。
	•如类型 S 包含匿名字段 T，则 S 方法集包含 T 方法。
	•如类型 S 包含匿名字段 *T，则 S 方法集包含 T + *T 方法。
	•不管嵌套 T 或 *T，*S 方法集总是包含 T + *T 方法。
	
	//定义类型，结构体
	type S struct{ i int }
	//定义 结构体的 方法
	func (p S) Get() int { return p.i }
	func (p S) Put() int {
		p.i = 5
		return p.i
	}
	//接口声明
	type ABC interface {
		Get() int
		Put() int
	}
	//结构体是类型的合集，接口是结构体方法的合集
	//接口的使用
	func f(a ABC) {
		fmt.Println(a.Get())
		fmt.Println(a.Put())
	}
	//空接口的使用，需要先判断b的类型
	func kongjiekou(b interface{}) {
		switch b.(type) {
		case string:
			fmt.Println(b)
		case int:
			fmt.Println(2)
		default:
			fmt.Println("......")
		}
	}
}

//进阶部分
接口{
	
	//还可用 switch 做批量类型判断，不支持 fallthrough。
	func main() {
		var o interface{} = &User{1, "Tom"}
		switch v := o.(type) {
		case nil:                                     // o == nil
			fmt.Println("nil")
		case fmt.Stringer:                            // interface
			fmt.Println(v)
		case func() string:                           // func
			fmt.Println(v())
		case *User:                                   // *struct
			fmt.Printf("%d, %s\n", v.id, v.name)
		default:
			fmt.Println("unknown")
		}
}
	//接口断言
	var w io.Writer
	w = os.Stdout
	f := w.(*os.File)		 //成功
	//c := w.(*bytes.Buffer) //异常

}
常用包{
	buffio ：实现带缓存的IO操作
	bytes：实现了针对byte slice的各种操作，和strings包具有类似的功能
	json：实现了json数据的编解码
	binary：实现了二进制数字的编解码
	flag：实现了命令行的flag解析
	database：实现了数据库操作接口
	ioutil：实现一些IO操作函数
	log：定义简单的日志接口
	fmt：实现格式IO，类似C中的printf和scanf
	io：定义和实现了基本的IO操作
	filepath：实现了类似path的操作，但与系统相关
	reflect：实现了runtime的反射，可以在运行时操作对象
	os：实现了平台无关的系统操作
	path：实现了基于分隔符的路径操作
	strconv：实现了string和其他类型之间的转换
	strings：实现了操作UTF8字符串的各种操作
	regexp：实现了正则匹配搜索，RE2语法
	runtime：实现了和Go运行系统的交互操作
	sync：实现了同步操作的原语，例如锁
	time：实现了针对时间的各种够计算和显示
}
读写文件{
#readfile
	{
	// readfile
	package main
	import (
		"fmt"
		//	"io"
		"io/ioutil"
		"os"
	)
	func main() {
		//读取文件测试
		fmt.Println("读取文件测试test1 of readfile:")
		file1name := "c:\\lgj\\read2\\readfile.go"
		file1, _ := os.Open(file1name)
		file1date, _ := ioutil.ReadAll(file1)
		fmt.Println(string(file1date))
		////
		var filename string
		fmt.Println("input path+filename,when write enter exit to exit:")
		fmt.Scanln(&filename)
		file, err := os.Create(filename)
		if err != nil {
			panic(err)
		}
		defer file.Close()
		//开始追加写入测试1
		fmt.Println("开始追加写入测试1test1 of writefile:")
		for {
			var input string
			fmt.Scanln(&input)
			if input == "exit" {
				fmt.Println("write is over")
				break
			}
			file.WriteString(input)
			file.Write([]byte("\n"))
		}
		//开始写入测试2
		fmt.Println("开始写入测试2test2 of writefile:")
		var input2 string
		fmt.Scanln(&input2)
		inputdate := make([]byte, len(input2))
		inputdate = []byte(input2)
		//ioutil.WriteFile(filename....)能创建不存在的文件test1.txt
		ioutil.WriteFile("c:\\lgj\\read2\\test1.txt", inputdate, 0664)
	}
	}
	
}
go的并发机制{
//常用的定义chan的方式	
var chanName chan ElementType 
var ch chan int 
var m map[string] chan bool 
ch := make(chan int) 


//go 关键字放在方法调用前新建一个 goroutine 并执行方法体
go GetThingDone(param1, param2);
 
//新建一个匿名方法并执行
go func(param1, param2) {
}(val1, val2)
 
//直接新建一个 goroutine 并在 goroutine 中执行代码块
go {
    //do someting...
}


通过channel传递的元素类型、容器（或缓冲区）和传递的方向由“<-”操作符指定。
可以使用内置函数 make分配一个channel:
	i := make(chan int)       // by default the capacity is 0
	s := make(chan string, 3) // non-zero capacity

	r := make(<-chan bool)          // can only read from
	w := make(chan<- []os.FileInfo) // can only write to
//单向channel变量的声明非常简单，如下： 
	var ch1 chan int   		// ch1是一个正常的channel，不是单向的 
	var ch2 chan<- float64  // ch2是单向channel，只用于写float64数据 
	var ch3 <-chan int  	// ch3是单向channel，只用于读取int数据 
//可以将 channel 隐式转换为单向队列，只收或只发。
	c := make(chan int, 3)
	var send chan<- int = c   // send-only
	var recv <-chan int = c   // receive-only
	/*
	send <- 1
	// <-send                 // Error: receive from send-only type chan<- int
	<-recv
	// recv <- 2              // Error: send to receive-only type <-chan int
	*/
并发：一个时间段内有很多的线程或进程在执行，但何时间点上都只有一个在执行，多个线程或进程争抢时间片轮流执行
并行：一个时间段和时间点上都有多个线程或进程在执行

goroutine机制实现了 M : N的线程模型，goroutine机制是协程（coroutine）的一种实现，golang内置的调度器，可以让多核CPU中每个CPU执行一个协程。
///虽然goroutine是并发执行的，但是它们并不是并行运行的。如果不告诉Go额外的东西，同一时刻只会有一个goroutine执行。利用runtime.GOMAXPROCS(n)可以设置goroutine并行执行的数量。	

ci := make(chan int)
cs := make(chan string)
cf := make(chan interface{})

ci <- 1   //发送整数 1 到 channel ci
<-ci   	  //从 channel ci 接收整数
i := <-ci //从 channel ci 接收整数，并保存到 i 中

//关闭channel
#当channel被关闭后，读取端需要知道这个事情。下面的代码演示了如何检查channel是否被关系。

x, ok = <-ch

当ok被赋值为true意味着channel尚未被关闭，同时可以读取数据。否则ok被赋值为false。在这个情况下表示channel被关闭。

//内置函数 len 返回未被读取的缓冲元素数量，cap 返回缓冲区大小。
d1 := make(chan int)
d2 := make(chan int, 3)
d2 <- 1
fmt.Println(len(d1), cap(d1))    // 0  0
fmt.Println(len(d2), cap(d2))    // 1  3

///通过select（和其他东西）可以监听channel上输入的数据。
//有多少 发送就应该有多少 接收
	var c chan int
	func ready(w string, sec int) {
		time.Sleep(time.Duration(sec) * time.Second)
		fmt.Println(w, "is ready!")
		c <- 1
	}
	func main() {
		c = make(chan int)
		go ready("Tea", 2)
		go ready("Coffee", 1)
		fmt.Println("I'm waiting, but not too long")
		L:
		for {
			select {
			case <-c:
				i++
				if i > 1 {
					break L
				}
			}
		}
	}
	

	select { 
	 case <-chan1: 
	 // 如果chan1成功读到数据，则进行该case处理语句 
	 case chan2 <- 1: 
	 // 如果成功向chan2写入数据，则进行该case处理语句 
	  default: 
	 // 如果上面都没有成功，则进入default处理流程 
	} 
	
// 首先，我们实现并执行一个匿名的超时等待函数 
	timeout := make(chan bool, 1) 
	go func() { 
		time.Sleep(1e9) // 等待1秒钟 
		timeout <- true 
	}() 
	 
	// 然后我们把timeout这个channel利用起来 
	select { 
	 case <-ch: 
	  // 从ch中读取到数据 
	 case <-timeout: 
	  // 一直没有从ch中读取到数据，但从timeout中读取到了数据 
	} 

}
同步锁{
Go语言包中的sync包提供了两种锁类型：sync.Mutex 和 sync.RWMutex。Mutex是最简单的一种锁类型，同时也比较暴力，当一个goroutine获得了Mutex后，其他goroutine就只能乖乖等到这个goroutine释放该Mutex。
RWMutex相对友好些，是经典的单写多读模型。在读锁占用的情况下，会阻止写，但不阻止读，也就是多个goroutine可同时获取读锁
//典型使用模式
	var l sync.Mutex  
	func foo() { 
		l.Lock()  
		defer l.Unlock()  
		//... 
	}   

}
json解析到interface/map{
/*
JSON中的布尔值将会转换为Go中的bool类型；
数值会被转换为Go中的float64类型；
字符串转换后还是string类型；
JSON数组会转换为[]interface{}类型；
JSON对象会转换为map[string]interface{}类型；
null值会转换为nil。
*/
	package main

	import (
		"encoding/json"
		"fmt"
		"reflect"
	)

	//input输入字符串型,最好原样输入,get是索引(第一个索引值),若get是数组或map，那key就会有作用
	//(get对应的是map，key应该是map的key，get对应的是数组时，key应该是数组的index)
	func myjson(input string, get string, key interface{}) interface{} {

		var gojson map[string]interface{}
		var areturn interface{}
		b := []byte(input)
		err := json.Unmarshal(b, &gojson)
		if err != nil {
			return err
		}
		fmt.Println("解析后:", gojson)
		if true {
			for k, v := range gojson { //k是索引，v是值
				if k == get {
					switch v2 := v.(type) { //固定句式，只能在这里用
					case string:
						//fmt.Println(k, "is string", v2)
						areturn = v2
					case int:
						//fmt.Println(k, "is int", v2)
						areturn = v2
					case float64:
						//fmt.Println(k, "is float64", v2)
						areturn = v2
					case bool:
						//fmt.Println(k, "is bool", v2)
						areturn = v2
					}
					switch v3 := v.(type) {
					case []interface{}:
						//fmt.Println(k, "is an array", ",index is", key)
						for i, iv := range v3 {
							if key == i {
								areturn = iv
							}
							//fmt.Println("areturn:", areturn)
						}
					case map[string]interface{}:
						//fmt.Println(k, "is an map", ",key is", key)
						//fmt.Println("v3:", v3)
						for i, iv := range v3 {
							if key == i {
								areturn = iv
								//fmt.Println("areturn:", areturn)
							}
						}
					}
				}
			}

		}
		return areturn
	}

	func main() {
		a := `{
				"Title": "Go语言编程",
				"Authors": ["XuShiwei", "HughLv", "Pandaman", "GuaguaSong", "HanTuo", "BertYuan","XuDaoli",{"cmap":{"a":1,"b":"b","c":0.11}}],
				"Publisher": "ituring.com.cn",
				"IsPublished": true,
				"Price": 9.99,
				"Sales": 1000000,
				"amap":{"a":1,"b":2,"c":3},
				"bmap":{"a":1,"b":"b","c":0.11}
			}`

		atype := myjson(a, "Authors", 7)
		fmt.Println("函数返回值是:", atype)
		fmt.Println("函数返回值的类型是:", reflect.TypeOf(atype)) //[]interface {} 不支持索引
		/*
			atype := myjson(a, "Authors", 7)
			函数返回值是: map[cmap:map[c:0.11 a:1 b:b]]
			函数返回值的类型是: map[string]interface {}  >>>>>>atype["a"],atype["cmap"] >>>都不支持索引,只能在switch的case中for..range。如下:
		*/

		switch v3 := atype.(type) {
		case []interface{}:
			fmt.Println("v31:", v3)
			for i, iv := range v3 {
				fmt.Println(i, iv)
			}
		case map[string]interface{}:
			fmt.Println("v32:", v3)
			for i, iv := range v3 {
				fmt.Println("key:", i, "value:", iv)
				switch v4 := iv.(type) {
				case map[string]interface{}:
					fmt.Println("v33:", v4)
					for i, iv := range v4 {
						fmt.Println("key1:", i, "value1:", iv)
					}
				}
			}
		}

	}


}

//扩展知识
docker的常用命令{
（1）docker  attach    
Attach to a running container：进入一个正在运行的容器
（2）docker  start
 Start a stopped container：启动一个停止的容器，让它的状态变为running
（3）docker  stop
     Stop a running container：停止一个正在运行的容器
（4）docker  rm
 Remove one or more containers：删除一个停止的容器（如果说这个容器是running状态时，先要执行docker stop命令，再执行docker rm命令，才能删除容器）
（5）docker  kill
  Kill a running container：删除一个正在运行的容器
（6）其他docker命令  
    build     Build an image from a Dockerfile
    commit    Create a new image from a container's changes
    cp        Copy files/folders from a container's filesystem to the host path
    create    Create a new container
    diff      Inspect changes on a container\'s filesystem
    events    Get real time events from the server
    exec      Run a command in an existing container
    export    Stream the contents of a container as a tar archive
    history   Show the history of an image
    images    List images
    import    Create a new filesystem image from the contents of a tarball
    info      Display system-wide information
    inspect   Return low-level information on a container
    load      Load an image from a tar archive
    login     Register or log in to a Docker registry server
    logout    Log out from a Docker registry server
    logs      Fetch the logs of a container
    port      Lookup the public-facing port that is NAT-ed to PRIVATE_PORT
    pause     Pause all processes within a container
    ps        List containers
    pull      Pull an image or a repository from a Docker registry server
    push      Push an image or a repository to a Docker registry server
    restart   Restart a running container
    rmi       Remove one or more images
    run       Run a command in a new container
    save      Save an image to a tar archive
    search    Search for an image on the Docker Hub 
    tag       Tag an image into a repository
    top       Lookup the running processes of a container
    unpause   Unpause a paused container
    version   Show the Docker version information
	wait      Block until a container stops, then print its exit code
}
strconv包中最常用方法{

// Itoa 相当于 FormatInt(i, 10)
func Itoa(i int) string

func main() {
	fmt.Println(strconv.Itoa(-2048)) // -2048
	fmt.Println(strconv.Itoa(2048))  // 2048
}

// Atoi 相当于 ParseInt(s, 10, 0)
// 通常使用这个函数，而不使用 ParseInt
func Atoi(s string) (i int, err error)

func main() {
	fmt.Println(strconv.Atoi("2147483647"))
	// 2147483647 
	fmt.Println(strconv.Atoi("2147483648"))
	// 2147483647 strconv.ParseInt: parsing "2147483648": value out of range
}

// ParseInt 将字符串转换为 int 类型
// s：要转换的字符串
// base：进位制（2 进制到 36 进制）
// bitSize：指定整数类型（0:int、8:int8、16:int16、32:int32、64:int64）
// 返回转换后的结果和转换时遇到的错误
// 如果 base 为 0，则根据字符串的前缀判断进位制（0x:16，0:8，其它:10）
	
}
执行系统命令{
	import "os/exec"
	cmd := exec.Command("/bin/ls", "-l")
	err := cmd.Run()
	上面的例子运行了“ls -l”，但是没有对其返回的数据进行任何处理，通过如下
	方法从命令行的标准输出中获得信息：
	import "exec"
	cmd := exec.Command("/bin/ls", "-l")
	buf, err := cmd.Output()   buf 是一个 []byte
}

//例子部分
