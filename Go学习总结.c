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
	// ()转换 
	// {}元素
	e1 := []byte("a string")
	e2 := []byte{'a', 'c', 24, 45, 75}
	
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
//可以参考 22.值语义与引用语义	
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
	+ string 	string(xb)  string(xi)  string(xr) 
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
	(func())(x) // x 转换成func()
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
	//复合型map
	f := map[string]interface{}{"a": 1, "b": 2, "c": "c", "d": []string{"aa", "bb", "cc"}}
	fmt.Println(f["d"])
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
	
	//例子
	
	import "fmt"
	import "reflect"

	func main() {
		a := [...]int{1, 2, 3, 4, 5}
		//fmt.Println("a的type:", reflect.TypeOf(a))
		for i, v := range a { // index、value 都是从复制品中取出。
			if i == 0 { // 在修改前，我们先修改原数组。
				a[1], a[2] = 999, 999
				fmt.Println(a) // 确认修改有效，输出 [0, 999, 999]。
			}
			a[i] = v + 100 // 使用复制品中取出的 value 修改原数组。
			fmt.Println("range中:", a)
		}
		fmt.Println("range外:", a) // 输出 [100, 101, 102]。

		////对比可以看出，range内修改数组也是生效的，会影响原数组

		s := []int{1, 2, 3, 4, 5}
		fmt.Println("s的type:", reflect.TypeOf(s))
		for i, v := range s { // 复制 struct slice { pointer, len, cap }。
			if i == 0 {
				s = s[:3]  // 对 slice 的修改，不会影响 range。
				s[2] = 100 // 对底层数据的修改。
			}
			fmt.Println(i, v)
		}
		fmt.Println("range外的s:", s)
		////对比可以看出，range内修改切片也是生效的，会影响原切片
	}
	//总结就是 range 会复制 struct array slice { pointer, len, cap }，在range中可以改变这些变量的值，但改变后并不会影响本次遍历

 
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

//按值传递（call by value） 按引用传递（call by reference）

Go 默认使用按值传递来传递参数，也就是传递参数的副本。函数接收参数副本之后，在使用变量的过程中可能对副本的值进行更改，但不会影响到原来的变量，比如 Function(arg1)。

如果你希望函数可以直接修改参数的值，而不是对参数的副本进行操作，你需要将参数的地址（变量名前面添加&符号，比如 &variable）传递给函数，这就是按引用传递，比如 Function(&arg1)，此时传递给函数的是一个指针。如果传递给函数的是一个指针，指针的值（一个地址）会被复制，但指针的值所指向的地址上的值不会被复制；我们可以通过这个指针的值来修改这个值所指向的地址上的值。（译者注：指针也是变量类型，有自己的地址和值，通常指针的值指向一个变量的地址。所以，按引用传递也是按值传递。）

几乎在任何情况下，传递指针（一个32位或者64位的值）的消耗都比传递副本来得少。

在函数调用时，像切片（slice）、字典（map）、接口（interface）、通道（channel）这样的引用类型都是默认使用引用传递（即使没有显式的指出指针）。
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
	
	//这里只能定义类型，不能带默认值！！
	type my struct{
		A string 
		B string 
		C string 
	}

	func main(){
		fmt.Println("Hello World")
		a:=my{"a","bb","ccc"}
		fmt.Println(a.A)
		b:=new(my)
		*b=my{"c","d","e"}
		fmt.Println(b.A)
		
	}
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
接口断言{
	
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
简单的go并发{
	package main

	import "fmt"
	import "time"

	func f(n *int) {
		a := "hello, world"
		(*n)++
		fmt.Println(*n)
		fmt.Println(a + string(*n))

	}

	func main() {
		n := 64
		go f(&n)
		go f(&n)
		go f(&n)
		time.Sleep(1) //不加的话，不会打印f函数中的提示
		fmt.Println("n:", n)
	}

	/*为什么打印不会混乱？
	65
	hello, worldA
	66
	hello, worldB
	67
	hello, worldC
	n: 67
	*/

	
}

加锁后的go并发{
	//一般是不应这样的，都是用chan
	package main

	import "fmt"
	import "sync"
	import "runtime"

	//import "time"

	var counter int = 0
	var counter1 int = 0

	//加锁
	func Count(lock *sync.Mutex) {
		lock.Lock()
		counter++
		fmt.Println("counter:", counter)
		lock.Unlock()
	}

	//不加锁
	func Count1(i int) {
		counter1++
		fmt.Println("i:", i)
		fmt.Println("counter1:", counter1)
	}

	func main() {
		lock := &sync.Mutex{}

		for i := 0; i < 10; i++ {
			go Count(lock)
		}

		for {
			lock.Lock()

			c := counter

			lock.Unlock()

			runtime.Gosched()
			if c >= 10 {
				break
			}
		}
		fmt.Println("=====不加锁======1")
		for i := 0; i < 20; i++ {
			go Count1(i)
		}

		//time.Sleep(10)
		for {
			d := counter1
			fmt.Println("d:", d)
			if d >= 10 {
				fmt.Println("break")
				break
			}
		}
		fmt.Println("=====不加锁======2")
		//不加锁也没有混乱，是因为并发的原因的吗？
	}

	/*

		go func() {
			for {
				d := counter1
				fmt.Println("d:", d)
				if d >= 10 {
					fmt.Println("break")
					break
				}
			}
		}()

	*/

	
}

select与并发{
	
	package main

	import "fmt"
	import "os"

	func main() {
		fmt.Println("-----")
		a, b := make(chan int, 3), make(chan int)
		go func() {
			v, ok, s := 0, false, ""
			for {
				select { // 随机选择可用 channel，接收数据。
				case v, ok = <-a:
					s = "a"
				case v, ok = <-b:
					s = "b"
				}
				if ok {
					fmt.Println(s, v)
				} else {
					os.Exit(0)
				}
			}
		}()

		for i := 0; i < 5; i++ {
			select {
			case a <- i:
			case b <- i:
			}
		}
		close(a)
		select {} // 没有可用 channel，阻塞 main goroutine。

	}

	/*
	os.Args 返回命令⾏参数，os.Exit 终止进程。
	要获取正确的可执行文件路径，可用  ﬁlepath.Abs(exec.LookPath(os.Args[0]))。
	*/

	
}

再学json解析{
	
	package main

import (
	"encoding/json"
	"fmt"
	"reflect"
	"strconv"
	"strings"
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
				switch v2 := v.(type) { //固定句式
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
	//递归方式变量未知结构
	a := `{
			    "Title": "Go语言编程",
			    "Authors": ["XuShiwei", "HughLv", "Pandaman", "BertYuan","XuDaoli",{"cmap":{"a4":1,"b4":"b4","c4":0.11}}],
			    "Publisher": "ituring.com.cn",
			    "IsPublished": true,
			    "Price": 9.99,
			    "Sales": 1000000,
				"amap":{"a":1,"b":2,"c":3},
				"bmap":{"a1":1,"b1":"b","c1":0.11,"dmap":{"a2":1,"b2":"b","c2":0.11,"emap":{"a3":1,"b3":"b3","c3":0.11}}}
			}`

	atype := myjson(a, "Authors", 5)
	fmt.Println("函数返回值是:", atype)
	fmt.Println("函数返回值的类型是:", reflect.TypeOf(atype)) //[]interface {} 不支持索引

	//可以将多种类型赋给interface{}
	var b interface{}
	c := "abcdefg"
	d := []string{"1", "2", "a"}
	b = c
	fmt.Println(b)
	b = d
	fmt.Println(b)
	fmt.Println([]byte("aaaaaaaa"))

	println(strings.Contains(a, "cmap"))
	//()转换 {}元素
	//e := []byte(`{"a1": 1, "b1": "b", "c1": 0.11, "dmap": {"a2": 1, "b2": "b", "c2": 0.11, "emap": {"a3": 1, "b3": "b3", "c3": 0.11}}}`)
	//fmt.Println(e)

	//复合型map
	f := map[string]interface{}{"a": 1, "b": 2, "c": "c", "d": []string{"aa", "bb", "cc"}}
	fmt.Println(f["d"])
	fmt.Println(strconv.FormatFloat(12.164, 'g', 8, 32))
	//map ->string ->map
	fbyte, _ := json.Marshal(f)
	fmt.Println(string(fbyte))
	var fjson map[string]interface{}
	err := json.Unmarshal(fbyte, &fjson)
	fmt.Println(err, fjson)

}

/*
	atype := myjson(a, "Authors", 7)
	函数返回值是: map[cmap:map[c:0.11 a:1 b:b]]
	函数返回值的类型是: map[string]interface {}  >>>>>>atype["a"],atype["cmap"] >>>都不支持索引,只能在switch的case中for..range。如下:

	//错误的map
	//e := map[string]interface{}{"a1": 1, "b1": "b", "c1": 0.11, "dmap": {"a2": 1, "b2": "b", "c2": 0.11, "emap": {"a3": 1, "b3": "b3", "c3": 0.11}}}
	//fmt.Println(f["dmap"])
	//复合型map
	f := map[string]interface{}{"a": 1, "b": 2, "c": "c", "d": []string{"aa", "bb", "cc"}}
	fmt.Println(f["d"])


		func MaptoStr(amap map[string]interface{}) string {
		var astr string
		var v2 string
		for k, v := range amap {
			fmt.Println("k:v", k, v)
			fmt.Println("v类型是:", reflect.TypeOf(v))
			switch v.(type) {
			case string:
				v2 = v.(string)
				//fmt.Println("v2", v2)
			case int:
				v2 = strconv.Itoa(v.(int))
				//fmt.Println("v2", v2)
			case float64:
				v2 = strconv.FormatFloat(v.(float64), 'g', 8, 32)
				//fmt.Println("v2", v2)

			case []interface{}:
				fmt.Println(k, "is an array", ",index is", v)
				v2 = ArrtoStr(v.([]interface{}))
			case map[string]interface{}:
				//fmt.Println(k, "is an map", ",key is", key)
				v2 = MaptoStr(v.(map[string]interface{}))
			}
			astr = k + ":" + v2 + "," + astr
		}
		return astr
	}

	func ArrtoStr(arry []interface{}) string {
		var astr string
		var v2 string
		for k, v := range arry {
			fmt.Println("array", k, v)
			switch v.(type) {
			case string:
				v2 = v.(string)
				fmt.Println("v2", v2)
			case int:
				v2 = strconv.Itoa(v.(int))
				//fmt.Println("v2", v2)
			case float64:
				v2 = strconv.FormatFloat(v.(float64), 'g', 8, 32)
				//fmt.Println("v2", v2)
			case []interface{}:
				fmt.Println(k, "is an array", ",index is", v)
				v2 = ArrtoStr(v.([]interface{}))
			case map[string]interface{}:
				//fmt.Println(k, "is an map", ",key is", key)
				v2 = MaptoStr(v.(map[string]interface{}))
			}
			astr = astr + "," + v2
		}
		return astr
	}


*/

//////// 限制struct 的格式 ----> ServerName 为空时，解析后的b中不会有ServerName缺省后的默认值
/*
针对JSON的输出，我们在定义struct tag的时候需要注意几点：
字段的tag是“-”，那么这个字段不会输出到JSON
tag中带有自定义名称，那么这个自定义名称会出现在JSON的字段名中，例如上面例子中的serverName
tag中如果带有“omitempty”选项，那么如果该字段值为空，就不会输出到JSON串中
如果字段类型是bool,string,int,int64等，而tag中带有“,string”选项，那么这个字段在输出到JSON的时候会把该字段对应的值转换成JSON字符串
*/
package main
 
import (
    "encoding/json"
    "os"
)
 
type Server struct {
    //ID不会导出到JSON
    ID int `json:"-"`
 
    //ServerName的值会进行二次JSON编码
    ServerName  bool `json:"serverName,omitempty"`
    ServerName2 string `json:"serverName2, string"`
 
    //如果ServerIP为空，则不输出到JSON中
    ServerIP    string `json:"serverIP,omitempty"`
    Description string `json:"description,string"`
}
 
func main() {
 
    s := Server{
        ID:          3,
        ServerName2: `Go "1.0"`,
        ServerIP:    ``,
        Description: "描述信息",
    }
 
    b, _ := json.Marshal(s)
    os.Stdout.Write(b)
 
}
	
//{"serverName2":"Go \"1.0\"","description":"\"描述信息\""} 
}

//解固定格式的json
//解析查询app已订阅api的返回
func Sub_json(SubscribeApisInfo  []byte, n int )(return_str [12]string){
    	type apiList_struct struct {
				Id 		string   `json:"id"`
				Name 	string      `json:"name"`
				Context string `json:"context"` 
				Version string   `json:"version"`
				Status  string `json:"status"` 
				Quota 	string `json:"quota"` 
				Catalog string      `json:"catalog"`								
				}		
		type Res_struct struct {
				ResultCode   int   `json:"resultCode"`
				ResultMsg    string      `json:"resultMsg"`
				TotalSize    int   `json:"totalSize"`
				PageSize 	 int      `json:"pageSize"`
				PageIndex    int   `json:"pageIndex"`
				ApiList 	 []apiList_struct
				}

		//json str 转struct
		var get Res_struct
		if err := json.Unmarshal(SubscribeApisInfo, &get); err == nil {
		//common.PrintlnCyan("================json str to struct==")
return_str=[12]string{strconv.Itoa(get.ResultCode),get.ResultMsg,strconv.Itoa(get.TotalSize),strconv.Itoa(get.PageSize),strconv.Itoa(get.PageIndex),get.ApiList[n].Id,get.ApiList[n].Name,get.ApiList[n].Context,get.ApiList[n].Version,get.ApiList[n].Status,get.ApiList[n].Quota,get.ApiList[n].Catalog}
				//common.PrintlnCyan(return_str)
			}					
	return
}

}

管道原来可以这样用{
//首先限定基本的数据结构： 
	type PipeData struct { 
		value int 
		handler func(int) int 
		next chan int 
	} 
	
	//流式处理数据： 
	func handle(queue chan *PipeData) { 
	 for data := range queue { 
			data.next <- data.handler(data.value) 
		} 
	} 
	
}

/////golang小知识点记录
golang小知识点记录{

1.获取url中的参数及输出到页面的几种方式
func SayHello(w http.ResponseWriter, req *http.Request) {
    req.Method                              //获取url的方法 GET or POST
    request := req.URL.Query()              //获取url中的所有参数（get或post）
    io.WriteString(w, req.FormValue("id"))  //获取url的id参数（常用）
    w.Write([]byte(request["wang"][0]))     //发送到HTTP客户端
    io.WriteString(w, "hello, world!\n")    //发送到HTTP客户端
    fmt.Fprintf(w, "%s", "hello, world!\n") //发送到HTTP客户端

}

2.获取当前路径  

 os.Getwd() //执行用户当前所在路径
 file, _ := exec.LookPath(os.Args[0])//执行程序所在的绝对路径
 
3.变量类型转换

floatTOint
      int(float)
      
intTOfloat
      var a int = 2
      var b float64 = float64(a)
stringTOfloat(32 / 64)
      f, err := strconv.ParseFloat(s, 32)
      f, err := strconv.ParseFloat(s, 64)
intTOstring
      var i int = 10  
      str1 := strconv.Itoa(i)   // 通过Itoa方法转换  
      str2 := fmt.Sprintf("%v", i) // 通过Sprintf方法转换  万能
stringTOint     
      var s string = "1"  
      var i int  
      i, err = strconv.Atoi(s) 
stringToint
      strconv.ParseInt()
strToBool
      i, err =strconv.ParseBool("1")
intToint32
      var a int
      b = int32(a)
interface TO string
        var a interface{}
        var b string
        a = "asdasdasdasd"
        b = a.(string)
interface TO float32 
        var a interface{}
        var b float32
        a = 126.982577
        b = a.(float32)
 interface TO int32
        var a interface{}
        var b int32
        a = 126
        b = a.(int32)
//强制类型转换 1
            type MyInt32 int32
            func main() {
                var uid int32 = 12345
                var gid MyInt32 = MyInt32(uid)
                fmt.Printf("uid=%d, gid=%d\n", uid, gid)
            }
//强制类型转换 2 
        unsafe.Pointer  

//string  byte互转
      aa:="hello world" 
      bb:=[]byte(aa)
      cc:=string(bb)


 


4.当前时间戳
    fmt.Println(time.Now().Unix())
    # 1389058332
     
5.时间戳到具体显示的转化
        fmt.Println(time.Unix(t, 0).String())
     
6.带纳秒的时间戳
     t = time.Now().UnixNano()
7.基本格式化的时间表示
         fmt.Println(time.Now().String())
8.格式化时间
        fmt.Println(time.Now().Format("2006-01-02 15:04:05")) # 记忆方法:6-1-2-3-4-5
        # 2014-01-07 09:42:20
   
9.时间戳转str格式化时间
        str_time := time.Unix(1389058332, 0).Format("2006-01-02 15:04:05")
        fmt.Println(str_time) # 2014-01-07 09:32:12
        
10.str格式化时间转时间戳
       the_time := time.Date(2014, 1, 7, 5, 50, 4, 0, time.Local)
       unix_time := the_time.Unix()
       fmt.Println(unix_time) # 389045004
                
//还有一种方法,使用time.Parse
              the_time, err := time.Parse("2006-01-02 15:04:05", "2014-01-08 09:04:41")
                if err == nil {
                        unix_time := the_time.Unix()
                    fmt.Println(unix_time)      
                }
                # 1389171881
11.sleep

   time.Sleep(time.Millisecond * 1000)  #sleep 1000毫秒
   time.Sleep(time.Second * 1) #sleep 1秒
12.fmt
    万能格式:%v  
    字符串： %s 
    十进制： %d
    浮点数： %f  保留2位小数 %0.2f
    二进制： %b
    Boolen:  %t
    
        fmt.Fprintf(os.Stdout, "%08b\n", 32) // 00100000
        fmt.Printf("%v", "hello world")              // hello world  直接格式化打印
        fmt.Print(fmt.Sprintf("%v", "hello world"))  // hello world  Sprintf 返回格式化后的变量
        fmt.Print(fmt.Errorf("%08b\n", 32))  // 00100000
        fmt.Fprint(os.Stdout, "A")
        fmt.Fprintln(os.Stdout, "A") // A
        fmt.Println("B")             // B
        fmt.Print(fmt.Sprintln("C")) // C  

13.函数不定参数 
func sum (nums ...int) {
    fmt.Print(nums, " ")  //输出如 [1, 2, 3] 之类的数组
    total := 0
    for _, num := range nums { //要的是值而不是下标
        total += num
    }
    fmt.Println (total)
}
a:=[]int{1,2,3,4,5} //可传slice …
sum(a…)

14.执行命令行
import "os/exec"
         func main () {
            //cmd := exec.Command("ps", "-aux")
                cmd := exec.Command ("ls", "/root")
                out, err := cmd.Output ()
                if err!=nil {
                    println ("Command Error!", err.Error ())
                    return
                }
                fmt.Println (string (out))
            }
            或者（正规一点）
            func main () {
                cmd := exec.Command ("tr", "a-z", "A-Z")
                cmd.Stdin = strings.NewReader ("some input")
                var out bytes.Buffer
                cmd.Stdout = &out
                err := cmd.Run ()
                if err != nil {
                    log.Fatal (err)
                }
                fmt.Printf("in all caps: %q\n", out.String ())
            }
            
            输出:in all caps: "SOME INPUT"

//命令行参数 （可用flag包）
func main () {
            args := os.Args
            fmt.Println (args) //带执行文件的
 }    
$go run args.go aaa bbb ccc ddd

15.生成随机数
r := rand.New(rand.NewSource(time.Now().UnixNano())) //使用时间作为种子
 
16.结构体的初始化方法
        rect1 := new(Rect)
        rect2 := &Rect{}
        rect3 := &Rect{0, 0, 100, 200}
        rect4 := &Rect{width:100, height:200}
        var rect5 *Rect=new(Rect)
        注意这几个变量全部为指向Rect结构的指针(指针变量)，因为使用了new()函数和&操作符
        a := Rect{}
        则表示这个是一个Rect{}类型
17.md5

import (
    "crypto/md5"
    "encoding/hex"
)

func GetMd5String(s string) string {
    h := md5.New()
    h.Write([]byte(s))
    return hex.EncodeToString(h.Sum(nil))
}

18.urlencode
import "net/url"
url.QueryEscape("strings")

19.log 记日志
logfile, _ := os.OpenFile("./pro.log", os.O_RDWR|os.O_CREATE|os.O_APPEND, 0777)
defer logfile.Close()

logger := log.New(logfile, "", 0)
logger.Printf("%v%v", err, ret)
20.判断文件是否存在
func main() {
    f, err := os.Open("dotcoo.com.txt")
    defer f.Close()
    if err != nil && os.IsNotExist(err) {
        fmt.Printf("file not exist!\n")
        return
    }
    fmt.Printf("file exist!\n")
   }

21.string如果里面有"或换行，可以使用`来进行包含

jsonString := ` 
     { 
    "development":{ 
        "connector":[ 
             {"id":"connector-server-1", "host":"127.0.0.1", "port":4050, "wsPort":3050}
                     ], 
        "gate":[ 
          {"id": "gate-server-1", "host": "127.0.0.1", "wsPort": 3014} 
     ] 
    } 
    }`

22.path.Clean
path.Clean用于对路径 ../../等进行过滤，在创建修改文件的时候需要使用到，否则会有漏洞
 

23.import包命名

import的包可以给它命名import l4g "code.google.com/p/log4go"

24.判断当前用户是否是root用户
os.Geteuid() != 0

25.break 
//退出指定的循环体  如果在某个条件下，你需要从 for-select 中退出，就需要使用标签
sum := 0
MyForLable:
    for {
        for i := 0; i < 10; i++ {
            if sum > 200 {
                break MyForLable //将退出循环体for{}
            }
            sum += i
        }
    }
    fmt.Println(sum)

26.golang中的类型判断


var a interface{}
   a=12
   newA,ok:=a.(string)
   如果ok 是 true 则说明 变量a 是字符串类型,而newA就是string类型的变量，a的实际值   
    a.(type) 返回的是 a的 类型, 注意他返回的不是一个 字符串表示 string int 这样表示a的类型
        a.(type)是和switch 搭配使用的
        switch vtype:=v.(type){
            case string:          
            case int:         
            case  []interface{}:            
            default:
        }

27.json简单的encode,decode 


import  "encoding/json"
 
   type MyData struct {
    Name   string    `json:"item"`
    Other  float32   `json:"amount"`
   }
    detail:=&MyData{"Name":"hello","Other":2}
    userinfo, _ := json.Marshal(detail)
    fmt.Println(string(userinfo))
   //`json:"item"` 就是Name字段在从结构体实例编码到JSON数据格式的时候，使用item作为名字。算是一种重命名的方式。
   //输出：{"item":"hello","amount":2}
   userinfo,_:=json.Marshal(detail)
   ObjUser := make(map[string]interface{})
   json.Unmarshal([]byte(userinfo), &ObjUser)

28.panic和恢复recover用法 

defer func() {
    if re := recover(); re != nil {
        fmt.Printf("%v", re)
    }
}()
 

29.从文件中json解析 

尽量使用os.OpenFile直接获取reader，然后再从reader中使用Decoder来解析json
package main
 
import (
    "fmt"
    "encoding/json"
    "os")

func main() {
    pathToFile := "jsondata.txt"
 
    file, err := os.OpenFile(pathToFile, os.O_RDONLY, 0644)
    if err != nil {
        fmt.Println(err)
        os.Exit(1)
    }
 
    configs := make(map[string]map[string][]Service, 0)
    err = json.NewDecoder(file).Decode(&configs)
    if err != nil {
        fmt.Println(err)
        os.Exit(1)
    }}

30.lock 并发小例
import (
    "fmt"
    "sync"
    "time"
)

var l sync.Mutex

func main() {
    l.Lock()
    defer l.Unlock()
    m := []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
    ch := make(chan int)
    defer close(ch)
    for i := 0; i < 30; i++ {
        time.Sleep(time.Second)
        go func(x int) {
            for {
                if len(m) == 0 {
                    break
                } else {
                    l.Unlock()
                    fmt.Println(x, m[0:1])
                    m = m[1:len(m)]
                    l.Lock()
                }
                time.Sleep(time.Second)

            }
            ch <- x

        }(i)
    }
    for i := 0; i < 30; i++ {
        fmt.Println(<-ch)
    }

}

31.future小例
package main

import (
    "fmt"
)

//一个查询结构体
type query struct {
    //参数Channel
    sql chan string
    //结果Channel
    result chan string
}

//执行Query
func execQuery(q query) {
    //启动协程
    go func() {
        //获取输入
        sql := <-q.sql
        //访问数据库，输出结果通道
        q.result <- "get " + sql
    }()

}

func main() {
    //初始化Query
    q :=
        query{make(chan string, 1), make(chan string, 1)}
    //执行Query，注意执行的时候无需准备参数
    execQuery(q)

    //准备参数
    q.sql <- "select * from table"
    //获取结果
    fmt.Println(<-q.result)
}

32.反射小例

package main
import (
    "errors"
    "fmt"
    "reflect"
)

func foo() {
    fmt.Println("hello")

}
func bar(a, b, c int) {
    fmt.Println(a, b, c)
}

func Call(m map[string]interface{}, name string, params ...interface{}) (result []reflect.Value, err error) {
    f := reflect.ValueOf(m[name])
    if len(params) != f.Type().NumIn() {
        err = errors.New("The number of params is not adapted.")
        return
    }
    in := make([]reflect.Value, len(params))
    for k, param := range params {
        in[k] = reflect.ValueOf(param)
    }
    result = f.Call(in)
    return
}

func main() {
    funcs := map[string]interface{}{"foo": foo, "bar": bar}
    Call(funcs, "foo")
    Call(funcs, "bar", 1, 2, 3)
}

33.快速搭建服务器
func main(){
    http.HandleFunc( "/",Handler)
    http.HandleFunc( "/valueget",valueget)
    s := &http.Server{
        Addr:           ":80",
        ReadTimeout:    30 * time.Second,
        WriteTimeout:   30 * time.Second,
        MaxHeaderBytes: 1 << 20,
    }
    log.Fatal(s.ListenAndServe())
}

func valueget(w http.ResponseWriter, r *http.Request) {
    params := r.URL.Query()
    user := params.Get("user")
    fmt.Fprintf(w, "you are get user %s", user)
}
 
go “静态目录服务” http.FileServer


//对目录提供静态映射服务
http.Handle("/", http.FileServer(http.Dir("/tmp")))

http.HandleFunc("/static/", func(w http.ResponseWriter, r *http.Request) {
        http.ServeFile(w, r, r.URL.Path[1:])

})

 

34.go语言中导入另外一个库结果调用时出错：cannot refer to unexported name
解决方法 :go，模块中要导出的函数，必须首字母大写。
 

34.goto
func main() {
    defer fmt.Println("cc")
    goto L
    defer fmt.Println("dd")
    fmt.Println("aa")
L:
    fmt.Println("bb")
}

输出
bb
cc


35.hook
package main

import (
    "fmt"
)

var hooks []hookfunc //hook function slice to store the hookfunc

type hookfunc func() error //hook function to run

func initOne() error {
    fmt.Println("hello world 1")
    return nil
}
func initTwo() error {
    fmt.Println("hello world 2")
    return nil
}
func AddHook(hf hookfunc) {
    hooks = append(hooks, hf)
}

func main() {
    AddHook(initOne)
    AddHook(initTwo)

    // do hooks function
    for _, hk := range hooks {
        err := hk()
        if err != nil {
            panic(err)
        }
    }
}


36.signalpackage main
import (
    "fmt"
    "os"
    "os/signal"
    "syscall"
    "time"
)

func main() {
    go signalHandle()
    time.Sleep(time.Second * 50)
}

func signalHandle() {
    for {
        ch := make(chan os.Signal)
        signal.Notify(ch, syscall.SIGINT, syscall.SIGUSR1, syscall.SIGUSR2, syscall.SIGHUP)
        sig := <-ch
        switch sig {
        default:
            fmt.Println("default")
        case syscall.SIGHUP:
            fmt.Println("SIGHUP")
        case syscall.SIGINT:
            fmt.Println("SIGINT")
        case syscall.SIGUSR1:
            fmt.Println("SIGUSR1")
        case syscall.SIGUSR2:
            fmt.Println("SIGUSR2")

        }
    }
}

37.闭包
package main
import "fmt"

func adder() func(int) int {
     sum := 0
     return func(x int) int {
          sum += x
          return sum
     }
}

func main() {
     pos, neg := adder(), adder()
     for i := 0; i < 10; i++ {
          fmt.Println(
               pos(i),
               neg(-2*i),
          )
     }
	 
}
	
}
HTTP请求{
package main
1.最简单的请求
	import (
		"fmt"
		"io/ioutil"
		"net/http"
	)

	func main() {
		response, _ := http.Get("http://3ms.huawei.com/")
		defer response.Body.Close()
		body, _ := ioutil.ReadAll(response.Body)
		fmt.Println(string(body))
	}

2.定制化请求
//最简单的带头域的get、post请求
	package main

	import (
		"fmt"
		"io/ioutil"
		"net/http"
		"strings"
	)

	func main() {
		fmt.Println(getstat())
		fmt.Println(putconf())
	}

	//curl -k -v -X GET -H "Authorization:Basic cHJvdmlkZXI6UHYmODlJam4="  -H "beginDate:2015-09-01 12:00:00" -H "endDate:2017-09-08 12:00:00"
	// 'http://10.175.102.220:9580/rest/invoke/statistics?pageSize=200&pageIndex=1'
	func getstat() string {
		client := &http.Client{}
		reqest, _ := http.NewRequest("GET", "http://10.175.102.220:9580/rest/invoke/statistics?pageSize=1&pageIndex=1", nil) //新建请求样式
		//set部分可不要
		reqest.Header.Set("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
		reqest.Header.Set("Accept-Charset", "GBK,utf-8;q=0.7,*;q=0.3")
		reqest.Header.Set("Accept-Encoding", "gzip,deflate,sdch")
		reqest.Header.Set("Accept-Language", "zh-CN,zh;q=0.8")
		reqest.Header.Set("Cache-Control", "max-age=0")
		reqest.Header.Set("Connection", "keep-alive")
		//add部分必须参数
		reqest.Header.Add("Authorization", "Basic cHJvdmlkZXI6UHYmODlJam4=")
		reqest.Header.Add("beginDate", "2015-09-01 12:00:00")
		reqest.Header.Add("endDate", "2017-09-08 12:00:00")

		response, err := client.Do(reqest) //发送定制化后的请求
		if response.StatusCode == 200 {
			body, _ := ioutil.ReadAll(response.Body)
			bodystr := string(body)
			return bodystr
		}
		return err.Error()
	}

	//curl -v -k -X PUT http://127.0.0.1:9763/rest/configuration -H "Authorization:Basic cHJvdmlkZXI6UHYmODlJam4=" -H "Content-Type:application/json;CHARSET=UTF-8"
	//-d '{"params": [{"name": "trace.message", "value": "on"}]}'
	func putconf() string {
		//postbody := strings.NewReader("{'params': [{'name':'trace.message','value':'on'}]}")
		postbody := strings.NewReader(`{"params": [{"name": "trace.message", "value": "on"}]}`)
		client := &http.Client{}
		reqest, _ := http.NewRequest("PUT", "http://10.175.102.220:9580/rest/configuration", postbody) //新建请求样式
		fmt.Println(reqest)
		//add部分必须参数
		reqest.Header.Add("Authorization", "Basic cHJvdmlkZXI6UHYmODlJam4=")
		reqest.Header.Add("Content-Type", "application/json;CHARSET=UTF-8")
		fmt.Println(reqest.Header)
		fmt.Println("======2")
		//fmt.Println(reqest.Body.Read([]byte(`{"params": [{"name": "trace.message", "value": "on"}]}`)))
		response, err := client.Do(reqest) //发送定制化后的请求
		fmt.Println(err)
		fmt.Println(response.StatusCode)
		if response.StatusCode == 200 {
			body, _ := ioutil.ReadAll(response.Body)
			bodystr := string(body)
			return bodystr
		}
		return err.Error()
	}

}
HTTP代理{
1.带密码的代理
	package main

	import (
		"fmt"
		"io/ioutil"
		"net/http"
		"net/url"
		"os"
	)

	///这种方式在window上跑不过：An attempt was made to access a socket in a way forbidden by its access permissions.是因为isafe的限制
	//但在linux上 url.Parse("http://name:passwd@172.18.32.134:8080") 是可以的 go run go例子7_代理.go
	func main() {

		proxy := func(ht *http.Request) (*url.URL, error) {
			/*
				auserinfo := url.UserPassword("name", "passwd")
				fmt.Println("auserinfo:", auserinfo)
				fmt.Print("QueryUnescape:")
				fmt.Println(url.QueryUnescape(auserinfo.String()))
				name, _ := url.QueryUnescape("name")
				pass, _ := url.QueryUnescape("passwd")
				auserinfo1 := url.UserPassword(name, pass)
				fmt.Println("auserinfo1:", auserinfo1)

				aurl := &url.URL{
					Scheme: "http",
					Host:   "172.18.32.134:8080",
					Opaque: "name:passwd",
					//User :auserinfo,

				}
				//RawQuery:
				//User :auserinfo,
				//Host :url.QueryEscape("http://name:passwd@172.18.32.134:8080"),
				//Host :"172.18.32.134:8080",
				//Scheme:"http",//格式
				//Opaque:"http://name:passwd@172.18.32.134:8080",//不透明

				fmt.Println("====:", aurl.String())
			*/
			return url.Parse("http://name:passwd@172.18.32.134:8080") //根据定义Proxy func(*Request) (*url.URL, error)这里要返回url.URL
			//return url.Parse(aurl.String())
		}
		//proxies = {"http": "http://name:qwer!4321@172.18.32.134:8080","https": "https://name:qwer!4321@172.18.32.134:8080"}
		transport := &http.Transport{
			Proxy: proxy,
		}
		client := &http.Client{Transport: transport}
		resp, err := client.Get("http://www.cnblogs.com/") //请求并获取到对象,使用代理
		//resp, err := client.Get("http://3ms.huawei.com/") //请求并获取到对象,使用代理

		if err != nil {
			fmt.Println(err)
		}
		dataproxy, err := ioutil.ReadAll(resp.Body) //取出主体的内容
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(string(dataproxy))
		}
		defer resp.Body.Close()
		fmt.Println("使用代理:%s", proxy) //打印
	}

	func Env_proxy() {
		//go theproxy()
		fmt.Println("Hello World")
		goPath := os.Getenv("GOPATH")
		fmt.Printf("The goPath is: %s\n", goPath)
		//proxies = {"http": "http://name:passwd@172.18.32.134:8080","https": "https://name:passwd@172.18.32.134:8080"}
		os.Setenv("HTTP_PROXY", "http://name:passwd@172.18.32.134:8080")
		os.Setenv("HTTP_PROXYS", "https://name:passwd@172.18.32.134:8080")
		//fmt.Println(os.Environ())
		fmt.Println("==================1")
		transport := &http.Transport{
			Proxy: http.ProxyFromEnvironment,
		}
		client1 := &http.Client{Transport: transport}
		resp, err := client1.Get("http://www.cnblogs.com/") //请求并获取到对象,使用代理
		fmt.Println("==================2")
		if err != nil {
			fmt.Println(err)
		}
		dataproxy, err := ioutil.ReadAll(resp.Body) //取出主体的内容
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(string(dataproxy))
		}
		fmt.Println("==================3")
		defer resp.Body.Close()
	}

	
}

bee学习{
//GOPATH环境变量添加时：
添加D:\gosms路径之后，GOPATH字符串后面多了一个;，去掉;，并cmd重启，可解决。
GOPATH ：E:\\GoWork
GOROOT ：C:\Go\
Path ：C:\Go\bin;E:\GoWork\bin

#上面都配好后
>bee new hello
>bee run hello

//在浏览器中打开 http://localhost:8080/ 进行访问

//LiteIDE 在 Windows 下为 Go 语言添加智能提示代码补全
http://www.cnblogs.com/liuning8023/p/4512524.html

我的实践：
E:\soft\gocode-master\gocode-master\
下执行 go build	
生成gocode-master.exe改名成gocode.exe 替换到C:\liteide\bin下
重启IDE就行了
估计是 LiteIDE 自带的 gocode.exe 比较旧的原因

}

关于switch{
	func main(){
    list := []string{"a", "b", "c", "d", "e", "f"}
    for _,y:=range list{
        switch y {
            case "a":
                fmt.Println("a")
                goto end
            case "b":
                fmt.Println("b")
            case "c":
                fmt.Println("c")
            case "d":
                fmt.Println("d")
            case "e":
                fmt.Println("e")
            
        }
     
        
    }
    end:
}

func main(){
    list := []string{"a", "b", "c", "d", "e", "f"}
    var bb =false
    for _,y:=range list{
        if bb==true{
            break
        }
        switch y {
            case "a":
                fmt.Println("a")
                bb=true
            case "b":
                fmt.Println("b")
            case "c":
                fmt.Println("c")
            case "d":
                fmt.Println("d")
            case "e":
                fmt.Println("e")
      
        }
     
        
    }
}


func main(){
    
    b:=aa()
    fmt.Println("aaaa",b)
}

func aa()string{
    list := []string{"a", "b", "c", "d", "e", "f"}
    for _,y:=range list{
        switch y {
            case "a":
                fmt.Println("a")
                           
            case "b":
                fmt.Println("b")
                return "a"         
                break
            case "c":
                fmt.Println("c")
            case "d":
                fmt.Println("d")
            case "e":
                fmt.Println("e")
            
        }
        
   
        
    }
    return ""
}

package main

import (
	"encoding/json"
	"fmt"
	"strconv"
	//"strings"
)

//很好的解析json的方法，直接返回key对应的value，无论多深的json，但在key存在重复时，请注意可能出现异常
func EasyJson(key string, str string) string {
	b := []byte(str)
	var f interface{}
	var ret string
	err := json.Unmarshal(b, &f)
	if err != nil {
		fmt.Println("解析json失败:", err)
		return ""
	}
	switch f.(type) {
	case map[string]interface{}:
		m := f.(map[string]interface{})
		for k, v := range m {
			if k == key {
				switch vv := v.(type) {
				case bool:
					ret = strconv.FormatBool(vv)
					goto end
				case string:
					ret = vv
					goto end
				case float64:
					ret = strconv.FormatFloat(vv, 'f', -1, 64)
					goto end
				case []interface{}:
					by, _ := json.Marshal(vv)
					fmt.Println(k, "is array1", string(by))
					ret = string(by)
					goto end
				case map[string]interface{}:
					by, _ := json.Marshal(vv)
					fmt.Println(k, "is map1", string(by))
					ret = string(by)
					goto end
				default:
					fmt.Println(k, "is of a err1 type")
				}
			}
			switch vv2 := v.(type) {
			case []interface{}:
				by, _ := json.Marshal(vv2)
				fmt.Println(k, "is array1", string(by))
				ret = EasyJson(key, string(by))
			case map[string]interface{}:
				by, _ := json.Marshal(vv2)
				fmt.Println(k, "is map1", string(by))
				ret = EasyJson(key, string(by))
			default:
				fmt.Println(k, "is of a err2 type")
			}
		}
	case []interface{}:
		by, _ := json.Marshal(f)
		fmt.Println(by, "is array1", string(by))
		ret = EasyJson(key, string(by))
	}
end:
	return ret
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

	atype := EasyJson("amap", a)
	fmt.Println("解析结果是:", atype)
}


	
}

关于贝叶斯算法与机器学习{
	
http://www.cnblogs.com/LeftNotEasy/archive/2010/08/29/1812101.html
http://www.cnblogs.com/kesalin/p/bayes_rule.html
http://www.cnblogs.com/elaron/archive/2012/10/26/2741511.html
http://www.cnblogs.com/Finley/p/5334987.html
http://www.cnblogs.com/netuml/p/5725650.html
http://www.cnblogs.com/marc01in/p/4775440.html

//摘要:
通常，事件 A 在事件 B 发生的条件下的概率，与事件 B 在事件 A 发生的条件下的概率是不一样的；然而，这两者是有确定关系的，贝叶斯定理就是这种关系的陈述。
贝叶斯公式的用途在于通过己知三个概率来推测第四个概率。它的内容是：在 B 出现的前提下，A 出现的概率等于 A 出现的前提下 B 出现的概率乘以 A 出现的概率再除以 B 出现的概率。通过联系 A 与 B，计算从一个事件发生的情况下另一事件发生的概率，即从结果上溯到源头（也即逆向概率）。

通俗地讲就是当你不能确定某一个事件发生的概率时，你可以依靠与该事件本质属性相关的事件发生的概率去推测该事件发生的概率。用数学语言表达就是：支持某项属性的事件发生得愈多，则该事件发生的的可能性就愈大。这个推理过程有时候也叫贝叶斯推理。

P(B|A) = P(A|B) * P(B) / [P(A|B) * P(B) + P(A|~B) * P(~B) ]

收缩起来就是：

P(B|A) = P(AB) / P(A)

其实这个就等于：

P(A∩B) = P(A)*P(B|A)=P(B)*P(A|B)

难怪拉普拉斯说概率论只是把常识用数学公式表达了出来。

然而，后面我们会逐渐发现，看似这么平凡的贝叶斯公式，背后却隐含着非常深刻的原理。
}

beego的dome{
#项目名  mypro2
//////////////main.go	
package main

import (
	"fmt"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"

	_ "mypro2/routers"

	_ "github.com/go-sql-driver/mysql"
)

//数据库的配置
const (
	DRIVER_NAME   = "mysql"
	DATA_SOURCE   = "root:root@tcp(10.120.189.164:15432)/golang?charset=utf8" //使用golang数据库
	MAX_IDLE_CONN = 5
	MAX_OPEN_CONN = 30
)

func init() {
	// 注册驱动
	orm.RegisterDriver("mysql", orm.DRMySQL)
	// 注册默认数据库
	// 备注：此处第一个参数必须设置为“default”（因为我现在只有一个数据库），否则编译报错说：必须有一个注册DB的别名为 default
	orm.RegisterDataBase("default", DRIVER_NAME, DATA_SOURCE, MAX_IDLE_CONN, MAX_OPEN_CONN)
}

func main() {
	fmt.Println("开始运行!")
	// 开启 orm 调试模式：开发过程中建议打开，release时需要关闭,只在本函数中生效，可以显示建表过程
	orm.Debug = true
	// 自动建表
	orm.RunSyncdb("default", false, true)
	beego.Run()
}
//////////////models.go	
package models

import (
	"github.com/astaxie/beego/orm"
)

type User struct {
	Id   int
	Name string
	Age  string
	Sex  string
}

//Profile *Profile `orm:"rel(one)"` // OneToOne relation
/*
type Profile struct {
	Id   int
	Age  int16
	User *User `orm:"reverse(one)"` // 设置反向关系（可选）
}
*/
//数据库中自动建立 user 表和其中的键
func init() {
	// 需要在 init 中注册定义的 model
	//orm.RegisterModel(new(User), new(Profile))
	orm.RegisterModel(new(User))
}

//////////////controllers.go	
package controllers

import (
	"fmt"
	"mypro2/models"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

type MainController struct {
	beego.Controller
}

//默认的
func (c *MainController) Gets() {
	c.Data["Website"] = "beego.me"
	c.Data["Email"] = "astaxie@gmail.com"
	//定义首页模板
	c.TplName = "index.tpl"
}

func (c *MainController) Add() {
	orm.Debug = true //只在本函数中生效，可以显示增加api的过程

	var id int
	var name string
	var age string
	var sex string
	err := c.Ctx.Input.Bind(&id, ":id")
	//c.Ctx.Input.Bind(&name, "name")
	//c.Ctx.Input.Bind(&age, "age")
	//c.Ctx.Input.Bind(&sex, "sex")
	name, age, sex = c.Input().Get("name"), c.Input().Get("age"), c.Input().Get("sex")
	if err != nil {
		fmt.Println("add err:", err)
	}
	user := new(models.User)
	user.Name = name
	user.Sex = sex
	user.Age = age
	fmt.Println("增加API:", user)

	// 创建一个 ormer 对象
	o := orm.NewOrm()
	o.Using("default")
	// insert
	o.Insert(user)
}

func (c *MainController) Get() {
	orm.Debug = true

	var id int
	err := c.Ctx.Input.Bind(&id, ":id")
	if err != nil {
		fmt.Println("add err:", err)
	}
	// 创建一个 ormer 对象
	o := orm.NewOrm()
	o.Using("default")

	user := new(models.User)
	_, err = o.QueryTable("User").Filter("id", id).All(&user)

	if err != nil {
		fmt.Println("GetApi sql error ")
	}
	fmt.Println("查询API:", user)

}

func (c *MainController) Delete() {
	orm.Debug = true

	var id int
	// 创建一个 ormer 对象
	o := orm.NewOrm()
	o.Using("default")

	err := c.Ctx.Input.Bind(&id, ":id")
	if err != nil {
		fmt.Println("add err:", err)
	}
	// delete
	o.Delete(&models.User{Id: id})
	fmt.Println("删除API:", &models.User{Id: id})
}

//////////////routers.go	
package routers

import (
	"mypro2/controllers"

	"github.com/astaxie/beego"
)

func init() {
	beego.Router("/", &controllers.MainController{}, "get:Gets")
}

func init() {

	var MyApis controllers.MainController

	//添加api
	beego.Router("/api/:id:int", &MyApis, "put:Add")
	//删除api
	beego.Router("/api/:id:int", &MyApis, "delete:Delete")
	//api查找
	beego.Router("/api/:id:([0-9]+)", &MyApis, "get:Get")

}

/*
curl -k -v -X PUT "http://10.177.241.210:8080/api/1?name=lgj&age=18&sex=20"
curl -k -v -X GET "http://10.177.241.210:8080/api/1"
curl -k -v -X PUT "http://10.177.241.210:8080/api/1"
*/




}
