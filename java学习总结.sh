#原来点击新建文件就可以了，呵呵

环境搭建{
#配置java环境 可运行javac
JAVA_HOME	E:\soft\java\jdk
CLASSPATH	.%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;
Path	%JAVA_HOME%\bin

{
"cmd": ["javac", "-d", ".", "$file"],
"file_regex": "^(...?):([0-9]):?([0-9]*)",
"selector": "source.java",
"encoding": "GBK",
//执行完上面的命令就结束
// 下面的命令需要按Ctrl+Shift+b来运行
"variants": [{
"name": "Run",
"shell": true,
"cmd": ["start", "cmd", "/c", "java ${file_base_name} &echo. & pause"],
// /c是执行完命令后关闭cmd窗口,
// /k是执行完命令后不关闭cmd窗口。
// echo. 相当于输入一个回车
// pause命令使cmd窗口按任意键后才关闭
"working_dir": "${file_path}",
"encoding": "GBK"
}]
}

遇到 错误: 找不到或无法加载主类 时先 ctrl+b 后再 ctrl+shift+b
///http://www.cnblogs.com/final/p/5348350.html
//http://www.cnblogs.com/wuqiyunxi/p/6057039.html
	
}


基础{
http://www.cnblogs.com/skywang12345/p/java_threads_category.html   Java多线程系列目录(共43篇)
http://www.cnblogs.com/dahe007/p/6265554.html  时间复杂度的计算
http://www.cnblogs.com/java-my-life/archive/2012/04/20/2455726.html java设计模式
基础知识{
	
1.元素类型[] 数组名 = new 元素类型[元素个数或数组长度];
2.元素类型[] 数组名 = new 元素类型[]{元素，元素，……};

for(数据类型  变量名 : 被遍历的集合(Collection或者数组)

{

}
3.Windows系统中换行为\r\n两个转义字符，Linux只有一个\n。

4.可变参数
public static void show(String str,int...arr){//...三个点，多写少写都会报错
         System.out.pintln(Arrays.toString(arr));
     }

	 
	 
当容量小的数据类型与容量大的数据类型运算时，容量小的数据类型会自动转换至容量大的数据类型：
char,byte,short ==>int ===>long ==>float ==double
char,byte,short之间不会相互转换，他们三者在计算时首先转换至int类型
当把任何基本数据类型的值和字符串进行连接运算时（+），基本类型的值将自动回转换至字符串类型

char qq;
int ww;
long ee;

qq='c';
ww=22;
ee=22;
/*
ww=qq;
ee=qq;
ee=ww;
*/
qq=(char)ww;
qq=(char)ee;

如何将字串 String 转换成整数 int? 

A. 有两个方法: 
1). int i = Integer.parseInt([String]); 或 
i = Integer.parseInt([String],[int radix]);
2). int i = Integer.valueOf(my_str).intValue();
注: 字串转成 Double, Float, Long 的方法大同小异.
2 如何将整数 int 转换成字串 String ? 

A. 有叁种方法: 
1.) String s = String.valueOf(i); 
2.) String s = Integer.toString(i); 
3.) String s = "" + i;
注: Double, Float, Long 转成字串的方法大同小异.


装箱：将一个基本数据类型变为包装类称为装箱操作，装箱的方法由各个子类完成
拆箱：将一个包装类变回基本数据类型，称为拆箱操作，转换的方法由Number类提供。
int x1 = 10 ;        // 基本数据类型
Integer temp = new Integer(x1) ;    // 装箱
int x2 = temp.intValue() ;      // 拆箱

System.in属于字节流	
}
	

#建立文件，文件名需要和public 类的名字一样
vi Test.java

public class Test
{
    public static void main(String[] args)
    {
        Human aPerson = new Human(); // 类名 对象名 = new 类的构造函数
        aPerson.repeatBreath(10);
    }

}

class Human
{
    void breath() //方法
    {
        System.out.println("hu...hu...");
    }


   /**
    * call breath()
    */
    void repeatBreath(int rep)
    {
        int i;
        for(i = 0; i < rep; i++) {
            this.breath();
        }
    }
    int height; //数据  定义的在方法的前后都没有关系
}

#编译类
javac Test.java
#运行
java Test


#java程序有一个主方法main方法，是这样的		public static void main(String [] args)
args[0]就是用命令行javac编译后java运行java程序时，传入的第一个参数，比如你运行一个程序，代码如下：
public class Demo{
　　public static void main(String [] args){
　　　　for(int i=0;i<args.length;i++)
　　　　System.out.println(args[i]);
　　}
}
编译:
　　javac Demo.java
运行:
　　java Demo haha kaka
得到的结果是
　　haha
　　kaka
总结:args[0]是你传入的第一个参数args[1]是传入的第二个参数...


#函数的格式 
修饰符 返回值类型 函数名(参数类型 形式参数1，参数类型 形式参数2)
{
  执行语句;
  return 返回值;
}
  返回值类型：函数运行后的结果的数据类型。
  参数类型：是形式参数的数据类型。
  形式参数：是一个变量，用于存储调用函数时传递给函数的实际参数。
  实际参数：传递给形式参数的具体数值。
  return：用于结束函数。
  返回值：该值会返回给调用者。
#函数的特点
1.定义函数可以将功能代码进行封装
2.便于对该功能进行复用
3.函数只有被调用才会被执行
4.函数的出现提高了代码的复用性
//5.对于函数没有具体返回值的情况，返回值类型用关键字void表示，那么该函数中的return语句如果在最后一行可以省略不写。
注意：
函数中只能调用函数，不可以在函数内部定义函数。
定义函数时，函数的结果应该返回给调用者，交由调用者处理。

#构建方法 > 显式初始值 > 默认初始值

//在java中，方法参数的传递永远都是传值，而这个值，对于基本数据类型，值就是你赋给变量的那个值。
//而对于引用数据类型，这个值是对象的引用，而不是这个对象本身
[值传递]
	基本数据类型赋值都属于值传递,值传递传递的是实实在在的变量值,是传递原参数的拷贝,值传递后，实参传递给形参的值，形参发生改变而不影响实参。
[引用传递]
	引用类型之间赋值属于引用传递。引用传递传递的是对象的引用地址,也就是它的本身(自己最通俗的理解)。引用传递：传的是地址，就是将实参的地址传递给形参，形参改变了，实参当然被改变了，因为他们指向相同的地址。
#	http://www.cnblogs.com/bluestorm/archive/2012/07/30/2615034.html  引用类型和基本数据类型的区分
#   http://www.cnblogs.com/huxdiy/p/6120100.html

//第一个例子：基本类型
void foo(int value) {
    value = 100;
}
foo(num); // num 没有被改变

//第二个例子：没有提供改变自身方法的引用类型  >>>>>>>>>  String 虽然是引用类型,但没有提供修改的方法,为不可变数据！
void foo(String text) {
    text = "windows";
}
foo(str); // str 也没有被改变

//第三个例子：提供了改变自身方法的引用类型
StringBuilder sb = new StringBuilder("iphone");
void foo(StringBuilder builder) {
    builder.append("4");
}
foo(sb); // sb 被改变了，变成了"iphone4"。

//第四个例子：提供了改变自身方法的引用类型，但是不使用，而是使用赋值运算符。
StringBuilder sb = new StringBuilder("iphone");
void foo(StringBuilder builder) {
    builder = new StringBuilder("ipad");
}
foo(sb); // sb 没有被改变，还是 "iphone"。



Java基本类型和引用类型区分{
[值类型]:也就是基本数据类型
    基本数据类型常被称为四类八种
四类：   1，整型 2，浮点型 3，字符型 4，逻辑型
八种：   1，整型3种 byte，short，int，long
         2，浮点型2种 float，double
         3，字符型1种 char
         4，逻辑型1种 boolean
[引用类型]
除了四类八种基本类型外，所有的类型都称为引用类型



 
               |-->byte(1个字节,1字节=8个bit)  范围：-128 ~ 127
               |            |-->shoar(2个字节)              范围：-32768 ~ 32767
               |-->4个整数：|-->int(4个字节)                 范围：-2147483648 ~ 2147483647
               |            |-->long(8个字节)    范围：-9223372036854775808 ~ 9223372036854775807
               |                
8种基本数据类型|                |-->float(4个字节)  
               |-->2个浮点类型：|-->double(8个字节)
               |                |--->注意：浮点类型中默认为double类型,如果前面是0.的话可以写成.512
               |                
               |-->1个字节类型：|-->char(2个字节)  一支持65536个字符。
               |
               |-->1个特殊类型：|-->boolean(1个字节)    值只有true 和 false。
               |
}

}
#Java 常用包的简单介绍如下：
/*
（一）java.lang包 
　　Java最常用的包都属于该包，程序不需要注入此包，就可以使用该包中的类，利用这些类可以设计最基本的Java程序。
　　String类，提供了字符串连接、比较、字符定位、字符串打印等处理方法。
　　StringBuffer类，提供字符串进一步的处理方法，包括子字符串处理、字符添加插入、字符替换等。
　　System类，提供对标准输入、输出设备io的读写方法，包括键盘、屏幕的in/out控制。常用的System.out.print()、System.out.println()都是该类的静态变量输出流out所提供的方法。
　　Thread类，提供Java多线程处理方法，包括线程的悬挂、睡眠、终止和运行等。
　　Math类，提供大量的数学计算方法。
　　Object类，这是Java类的祖先类，该类为所有Java类提供了调用Java垃圾回收对象方法以及基于对象线程安全的等待、唤醒方法等。
　　Throwable类，该类是Java错误、异常类的祖先类，为Java处理错误、异常提供了方法。

（二）java.awt包
　　该包中的类提供了图形界面的创建方法，包括按钮、文本框、列表框、容器、字体、颜色和图形等元素的建立和设置。

（三）javax.swing包
　　该包提供100%Java编写的图形界面创建类，利用该包的类建立的界面元素可调整为各种操作系统的界面风格，支持各种操作平台的界面的开发。此外，swing包还提供了树形控件、标签页控件、表格控件的类。Java.swing包中的很多类都是从java.awt包的类继承而来，Java保留使用java.awt包是为了保持技术的兼容性，但应尽量地使用javax.swing包来开发程序界面。

（四）java.io包
　　该包的类提供数据流方式的系统输入输出控制、文件和对象的读写串行化处理，比较常用的类包括：BufferInputStream、BufferOutputStream、BufferedReader、BufferedWriter、DataInputStream、DataOutputStream、File、FileReader、FileWriter、FileInputStream和FileOutputStream等。

（五）java.util包
　　该包提供时间日期、随机数以及列表、集合、哈希表和堆栈等创建复杂数据结构的类，比较常见的类有：Date、Timer、Random和LinkedList等。

（六）java.net包
　　该包提供网络开发的支持，包括封装了Socket套接字功能的服务器Serversocket类、客户端Socket类以及访问互联网上的各种资源的URL类。

（七）java.applet包
　　此包只有一个Applet类，用于开发或嵌入到网页上的Applet小应用程序，使网页具有更强的交互能力以及多媒体、网络功能
*/

[访问修饰符]  class  类名  {

      [访问修饰符]  [静态修饰符]  类型  成员变量名;                                 //定义成员变量（字段）

      [访问修饰符]  [静态修饰符]  返回值类型  成员函数名（参数列表）{       //定义成员函数（方法）

             //方法体

      }

}

向上转型：子类引用的对象转换为父类类型称为向上转型。通俗地说就是是将子类对象转为父类对象。此处父类对象可以是接口
向下转型：父类引用的对象转换为子类类型称为向下转型。

#java的向上转型与向下转型 
向下转型和向上转型{
#将一个衍生类引用转换为其基类引用，这叫做向上转换(upcast)或者宽松转换
 
向上转型：
首先要有一个父类，一个子类，
Person p=new Person();
p=new Student();
OK，这就是向上转型，可以简化成：Person p=new Student();
 
　　1）   p是Person的引用，指向Student的对象，p不是对象;
　　2）   p只能调用父类中有的成员变量与成员函数，子类中新有的方法与变量p不能使用，而执行的主体是子类的主体。
例如　class Person{　
　　　　　　void eat(){system .out.println("eating...")}
　　　　　　void sleep(){system.out.println("sleep...")}
}
　　　class Student extends Person{
　　　　　　void eat(){system.out.println("I am a student")}
　　　　　　void read(){system.out.println("I am reading...")}
}
 
　　p可以调用eat方法，执行的是Student里的函数主体；也可以调用sleep方法，子类里没有sleep方法，所以执行父类里函数主体；
　　但不能调用read方法，因为Person没有read方法；
 
向下转型：
　　向下转型是在向上转型的基础上加一行
　　Student s=(Student)p;
　　同样s也不是对象，是引用
　　s可以调用父类与子类里的所有方法，都执行子类中的函数主体，子类中没有的，则执行父类中的函数主体
 
总结：
1、父类引用可以指向子类对象，子类引用不能指向父类对象。
2、把子类对象直接赋给父类引用叫upcasting向上转型，向上转型不用强制转型。
　　 如Father father = new Son();
3、把指向子类对象的父类引用赋给子类引用叫向下转型（downcasting），要强制转型。
　　 如father就是一个指向子类对象的父类引用，把father赋给子类引用son 即Son son =（Son）father；
　　 其中father前面的（Son）必须添加，进行强制转换。
4、upcasting 会丢失子类特有的方法,但是子类overriding 父类的方法，子类方法有效


//多态的经典例子
//向上转型后，父类只能调用子类和父类的共同方法和的重写方法(方法名相同，参数也相同)，不能调用重载方法(方法名相同，但参数不同)
class A {
    public String show(D obj) {
        return ("A and D");
    }
    public String show(A obj) {
        return ("A and A");
    } 
}
class B extends A{
    public String show(B obj){//重载
        return ("B and B");
    }    
    public String show(A obj){//重写
        return ("B and A");
    } 
}
class C extends B{

}
class D extends B{
}
public class Test {
    public static void main(String[] args) {
        A a1 = new A();
        A a2 = new B();//向上转型
        B b = new B();
        C c = new C();
        D d = new D();
        
        System.out.println("1--" + a1.show(b));//A and A	this.show((super)O)
        System.out.println("2--" + a1.show(c));//A and A 	this.show((super)(super)O)
        System.out.println("3--" + a1.show(d));//A and D	this.show(O)
        System.out.println("4--" + a2.show(a1));//B and A	super.show(O)
        System.out.println("4--" + a2.show(b));//B and A	super.show((super)O)
        System.out.println("5--" + a2.show(c));//B and A	super.show((super)O)
        System.out.println("6--" + a2.show(d));//A and D	super.show((super)O)
        System.out.println("7--" + b.show(b));//B and B
        System.out.println("8--" + b.show(c));//B and B
        System.out.println("9--" + b.show(d));//A and D 
        
    }
}
/*
多态机制遵循的原则概括为：
当超类对象引用变量引用子类对象时，被引用对象的类型而不是引用变量的类型决定了调用谁的成员方法，但是这个被调用的方法必须是在超类中定义过的，
也就是说被子类覆盖的方法，但是它仍然要根据继承链中方法调用的优先级来确认方法，
该优先级为：this.show(O)、super.show(O)、this.show((super)O)、super.show((super)O)。
*/
}

#使用super来引用父类的成分，用this来引用当前对象

#继承
{
#例子1	

1.构造器的名字和类的名字相同
2.构造器没有返回值
3.构建方法 > 显式初始值 > 默认初始值
4.public: 该成员外部可见，即该成员为接口的一部分
5.private: 该成员外部不可见，只能用于内部使用，无法从外部访问。
6.protected:成员可以被衍生层访问，但不能被外部访问

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#构造器
public class Test
{
    public static void main(String[] args)
    {
        Human neZha   = new Human(150, "shit");
        System.out.println(neZha.getHeight()); 
    }

}
class Human
{
	//类名 对象名 = new 类的构造函数
	//自己不重新定义构造函数时，构造函数也是存在的，不过是隐形的无参数的，当手动修改构造函数后，原来的无参数构造函数就会被覆盖消失，调用类创建对象时也就需要使用新的构造函数
	//形式来创建对象。构造函数可以多个，但参数不能相同。
    
	/*构造器是如何被调用的呢？我们在创建类的时候，采用的都是new Human()的方式。实际上，我们就是在调用Human类的构造器。当我们没有定义该方法时，Java会提供一个空白的构造器，以便使用new的时候调用。但当我们定义了构造器时，在创建对象时，Java会调用定义了的构造器。
	*/
	//constructor 1 构建方法 1
    Human(int h)
    {
        this.height = h;
        System.out.println("I'm born");
    }
     //constructor 2 构建方法 2
    Human(int h, String s) 
    {
        this.height = h;
        System.out.println("Ne Zha: I'm born, " + s);
    }
    int getHeight()
    {
        return this.height;
    }
    int height;
}

#Java会同时根据方法名和参数列表来决定所要调用的方法，这叫做方法重载(method overloading)。构建方法可以进行重载，普通方法也可以重载
#方法重载
public class Test
{
    public static void main(String[] args)
    {
        Human aPerson = new Human();
        aPerson.breath(10);
    }

}

class Human
{
    void breath()
    {
        System.out.println("hu...hu...");
    }
    void breath(int rep)
    {
        int i;
        for(i = 0; i < rep; i++) {
            System.out.println("lu...lu...");
        }
    }
    int height;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Human
{   
     //constructor 构造
    public Human(int h)
    {
        this.height = h;
    }
    public int getHeight()
    {
       return this.height;
    }
    public void growHeight(int h)
    {
        this.height = this.height + h;
    }
    public void breath()
    {
        System.out.println("hu...hu...");
    }

    private int height; 
}
//如果只是方法名相同，而参数列表不同，那么两个方法会同时呈现到接口，不会给我们造成困扰。外部调用时，Java会根据提供的参数，来决定使用哪个方法    (方法重载)。

//如果方法名和参数列表都相同呢？ 在衍生层时，我们还可以通过super和this来确定是哪一个方法。而在外部时，我们呈现的只是统一接口，所以无法同时提供两个方法。这种情况下，Java会呈现衍生层的方法，而不是基层的方法。
//这种机制叫做   方法覆盖   (method overriding)。方法覆盖可以被很好的利用，用于修改基类成员的方法.

class Woman extends Human
{
     //constructor
    public Woman(int h)
    {
        super(h); // base class constructor 继承父类的构造方法
        System.out.println("Hello, Pandora!");
    }
    // new method
    public Human giveBirth()
    {
        System.out.println("Give birth");
        return (new Human(20));
    }

     //override Human.breath() 方法覆盖(method overriding)
    public void breath()
    {
        super.breath();
        System.out.println("su...");
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#例子2


class Person {
    public static void prt(String s) {
        System.out.println(s);
    }
    Person() {
        prt("A Person.");
    }
    Person(String name) {
        prt("A person name is:" + name);
    }
}


public class Chinese extends Person {
    Chinese() {
        super(); // 调用父类构造函数（1）
        prt("A chinese.");// (4)
    }
    Chinese(String name) {
        super(name);// 调用父类具有相同形参的构造函数（2）
        prt("his name is:" + name);
    }
    Chinese(String name, int age) {
        this(name);// 调用当前具有相同形参的构造函数（3）
        prt("his age is:" + age);
    }
    public static void main(String[] args) {
        Chinese cn = new Chinese();
        cn = new Chinese("kevin");
        cn = new Chinese("kevin", 22);
    }
}

}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#接口

interface Cup {
    void addWater(int w);
    void drinkWater(int w);
}
//implements关键字来实施interface
class MusicCup implements Cup 
{
    public void addWater(int w) 
    {
        this.water = this.water + w;
    }

    public void drinkWater(int w)
    {
        this.water = this.water - w;
    }

    private int water = 0;
}
//接口的继承
interface MetricCup extends Cup
{
    int WaterContent();
}

interface MusicCup extends Cup, Player 
{
    void display();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

1.final基本类型的数据: 定值 (constant value)，只能赋值一次，不能再被修改。
2.final方法: 该方法不能被覆盖。private的方法默认为final的方法。
3.final类: 该类不能被继承。
4.在类定义中，我们利用  static  关键字，来声明类数据成员，类的所有对象共享数据。这样的数据被称为类数据成员(class field)。
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#将一个衍生类引用转换为其基类引用，这叫做向上转换(upcast)或者宽松转换。下面的BrokenCup类继承自Cup类，并覆盖了Cup类中原有的addWater()和drinkWater()方法
public class Test
{
    public static void main(String[] args)
    { 
        Cup aCup;
        BrokenCup aBrokenCup = new BrokenCup();
        aCup = aBrokenCup; // upcast
        aCup.addWater(10); // method binding
    }
}

class Cup 
{
    public void addWater(int w) 
    {
        this.water = this.water + w;
    }

    public void drinkWater(int w)
    {
        this.water = this.water - w;
    }

    private int water = 0;
}

class BrokenCup extends Cup
{
    public void addWater(int w) 
    {
        System.out.println("shit, broken cup");
    }

    public void drinkWater(int w)
    {
        System.out.println("om...num..., no water inside");
    }
}
程序运行结果:
shit, broken cup

#Java可以根据当前状况，识别对象的真实类型，这叫做多态(polymorphism)。

#String类是唯一一个不需要new关键字来创建对象的类，String类对象是不可变对象(immutable object)，这些编辑功能是通过创建一个新的对象来实现的，而不是对原有对象进行修改。
string类{
可以用+实现字符串的连接(concatenate)，比如:
"abc" + s
字符串的操作大都通过字符串的相应方法实现，比如下面的方法:
方法                               效果
s.length()                        返回s字符串长度
s.charAt(2)                       返回s字符串中下标为2的字符
s.substring(0, 4)                 返回s字符串中下标0到4的子字符串
s.indexOf("Hello")                返回子字符串"Hello"的下标
s.startsWith(" ")                 判断s是否以空格开始
s.endsWith("oo")                  判断s是否以"oo"结束
s.equals("Good World!")           判断s是否等于"Good World!"
                                  ==只能判断字符串是否保存在同一位置。需要使用equals()判断字符串的内容是否相同。

s.compareTo("Hello Nerd!")        比较s字符串与"Hello Nerd!"在词典中的顺序，

                                  返回一个整数，如果<0，说明s在"Hello Nerd!"之前；

                                              如果>0，说明s在"Hello Nerd!"之后；

                                              如果==0，说明s与"Hello Nerd!"相等。

s.trim()                          去掉s前后的空格字符串，并返回新的字符串
s.toUpperCase()                   将s转换为大写字母，并返回新的字符串
s.toLowerCase()                   将s转换为小写，并返回新的字符串
s.replace("World", "Universe")    将"World"替换为"Universe"，并返回新的字符串		
}

异常处理{

#异常处理的部分Java程序。try部分的程序是从一个文件中读取文本行。在读取文件的过程中，可能会有IOException发生	
BufferedReader br = new BufferedReader(new FileReader("file.txt"));
try {
    StringBuilder sb = new StringBuilder();
    String line = br.readLine();

    while (line != null) {
        sb.append(line);
        sb.append("\n");
        line = br.readLine();
    }
    String everything = sb.toString();
} 
catch(IOException e) {
    e.printStackTrace();
    System.out.println("IO problem");
}
finally {
    br.close();
}	
	
}

import java.io.*;

public class Test
{
    public static void main(String[] args)
    {
        try {
            BufferedReader br =
              new BufferedReader(new FileReader("file.txt")); 

            String line = br.readLine();

            while (line != null) {
                System.out.println(line);
                line = br.readLine();
            }
            br.close();
        }
        catch(IOException e) {
            System.out.println("IO Problem");
        }
    }
}

{
程序IO 的关键在于创建BufferedReader对象br:
BufferedReader br = new BufferedReader(new FileReader("file.txt"));
在创建的过程中，我们先建立了一个FileReader对象，这个对象的功能是从文件"file.txt"中读取字节(byte)流，并转换为文本流。在Java中，标准的文本编码方式为unicode。BufferedReader()接收该FileReader对象，并拓展FileReader的功能，新建出一个BufferedReader对象。该对象除了有上述的文件读取和转换的功能外，还提供了缓存读取(buffered)的功能。最后，我们通过对br对象调用readLine()方法，可以逐行的读取文件。
(缓存读取是在内存中开辟一片区域作为缓存，该区域存放FileReader读出的文本流。当该缓存的内容被读走后(比如readLine()命令)，缓存会加载后续的文本流。)
BufferedReader()是一个装饰器(decorator)，它接收一个原始的对象，并返回一个经过装饰的、功能更复杂的对象。修饰器的好处是，它可以用于修饰不同的对象。我们这里被修饰的是从文件中读取的文本流。其他的文本流，比如标准输入，网络传输的流等等，都可以被BufferedReader()修饰，从而实现缓存读取。
}

文件读取的几种方法{

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class read_write
{
        public static void main(String[] args)
        {
                
        }
        /**
         * 使用FileWriter类写文本文件
         */
        public static void writeMethod1()
        {
                String fileName="E:\java\javatest\mytest1\src\readfile\read.txt";
                try
                {
                        //使用这个构造函数时，如果存在kuka.txt文件，
                        //则先把这个文件给删除掉，然后创建新的kuka.txt
                        FileWriter writer=new FileWriter(fileName);
                        writer.write("Hello Kuka:\n");
                        writer.write("  My name is coolszy!\n");
                        writer.write("  I like you and miss you。");
                        writer.close();
                } catch (IOException e)
                {
                        e.printStackTrace();
                }
        }
        /**
         * 使用FileWriter类往文本文件中追加信息
         */
        public static void writeMethod2()
        {
                String fileName="E:\java\javatest\mytest1\src\readfile\read.txt";
                try
                {
                        //使用这个构造函数时，如果存在kuka.txt文件，
                        //则直接往kuka.txt中追加字符串
                        FileWriter writer=new FileWriter(fileName,true);
                        SimpleDateFormat format=new SimpleDateFormat();
                        String time=format.format(new Date());
                        writer.write("\n\t"+time); 
                        writer.close();
                } catch (IOException e)
                {
                        e.printStackTrace();
                }
        }
        //注意：上面的例子由于写入的文本很少，使用FileWrite类就可以了。但如果需要写入的
        //内容很多，就应该使用更为高效的缓冲器流类BufferedWriter。
        /**
         * 使用BufferedWriter类写文本文件
         */
        public static void writeMethod3()
        {
                String fileName="E:\java\javatest\mytest1\src\readfile\read.txt";
                try
                {
                        BufferedWriter out=new BufferedWriter(new FileWriter(fileName));
                        out.write("Hello Kuka:");
                        out.newLine();  //注意\n不一定在各种计算机上都能产生换行的效果
                        out.write("  My name is coolszy!\n");
                        out.write("  I like you and miss you。");
                        out.close();
                } catch (IOException e)
                {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                }
        }
        /**
         * 使用FileReader类读文本文件
         */
        public static void readMethod1()
        {
                String fileName="E:\java\javatest\mytest1\src\readfile\read.txt";
                int c=0;
                try
                {
                        FileReader reader=new FileReader(fileName);
                        c=reader.read();
                        while(c!=-1)
                        {
                                System.out.print((char)c);
                                c=reader.read();
                        }
                        reader.close();
                } catch (Exception e) {
                        e.printStackTrace();
                }
        }
        
        /**
         * 使用BufferedReader类读文本文件
         */
        public static void readMethod2()
        {
                String fileName="E:\java\javatest\mytest1\src\readfile\read.txt";
                String line="";
                try
                {
                        BufferedReader in=new BufferedReader(new FileReader(fileName));
                        line=in.readLine();
                        while (line!=null)
                        {
                                System.out.println(line);
                                line=in.readLine();
                        }
                        in.close();
                } catch (IOException e)
                {
                        e.printStackTrace();
                }
        }
}	
	
	
}

基础知识{
	
1.元素类型[] 数组名 = new 元素类型[元素个数或数组长度];
2.元素类型[] 数组名 = new 元素类型[]{元素，元素，……};

for(数据类型  变量名 : 被遍历的集合(Collection或者数组))

{

}
3.Windows系统中换行为 \r\n 两个转义字符，Linux只有一个 \n 。

4.可变参数
public static void show(String str,int...arr){//...三个点，多写少写都会报错
         System.out.pintln(Arrays.toString(arr));
     }

	 
	 
当容量小的数据类型与容量大的数据类型运算时，容量小的数据类型会自动转换至容量大的数据类型：
char,byte,short ==>int ===>long ==>float ==double
char,byte,short之间不会相互转换，他们三者在计算时首先转换至int类型
当把任何基本数据类型的值和字符串进行连接运算时（+），基本类型的值将自动回转换至字符串类型

char qq;
int ww;
long ee;

qq='c';
ww=22;
ee=22;
/*
ww=qq;
ee=qq;
ee=ww;
*/
qq=(char)ww;
qq=(char)ee;

字串 String 互转 整数 int? 
{
A. 有两个方法: 
1). int i = Integer.parseInt([String]); 或 
i = Integer.parseInt([String],[int radix]);
2). int i = Integer.valueOf(my_str).intValue();
注: 字串转成 Double, Float, Long 的方法大同小异.

B. 有叁种方法: 
1.) String s = String.valueOf(i); 
2.) String s = Integer.toString(i); 
3.) String s = "" + i;
注: Double, Float, Long 转成字串的方法大同小异.
}

装箱：将一个基本数据类型变为包装类称为装箱操作，装箱的方法由各个子类完成
拆箱：将一个包装类变回基本数据类型，称为拆箱操作，转换的方法由Number类提供。
int x1 = 10 ;        // 基本数据类型
Integer temp = new Integer(x1) ;    // 装箱
int x2 = temp.intValue() ;      // 拆箱

System.in属于字节流	
}

字节的写与读
{
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;

public class Intwrite {
	
	public static int BytetoInt(byte[] bRefArr) {
	    int iOutcome = 0;
	    byte bLoop;

	    for (int i = 0; i < bRefArr.length; i++) {
	        bLoop = bRefArr[i];
	        iOutcome += (bLoop & 0xFF) << (8 * i);
	    }
	    return iOutcome;
	}
	
	//byteToInt1 与byteToInt2的区别是byte数组的前后顺序不一样，高地位相反
	public static int byteToInt1(byte b[], int offset) {
		   return b[offset + 3] & 0xff | (b[offset + 2] & 0xff) << 8
		     | (b[offset + 1] & 0xff) << 16 | (b[offset] & 0xff) << 24;
		}
	public static int byteToInt2(byte[] b){ 
        int s =0; 
        int s0 = b[0]&0xff;// 最低位 
        int s1 = b[1]&0xff; 
        int s2 = b[2]&0xff; 
        int s3 = b[3]&0xff; 
		//右移8位、16位、24位
        s3 <<=24; 
        s2 <<=16; 
        s1 <<=8; 
        s = s0 | s1 | s2 | s3; 
        return s; 
    }
	//int这里都由1个byte表示，所以范围只能是  0-255
    public static void WhatIsReturnInt() throws IOException {
    	FileOutputStream fis1 = new FileOutputStream("E:/abc4.txt");
    	 for (int x = 1; x < 512; x++ ) {
    		 fis1.write(x);
	        }   	 
    	 fis1.close();
    	//public int read() //返回的int是啥？
    	FileInputStream fis2 = new FileInputStream("E:/abc4.txt");
    	for (int x = 1; x < 512; x++ ) {
    		System.out.println(fis2.read());//返回的int是啥？
	        }   	 
    	fis2.close();
    	//public int read(byte[] b) //返回的int是啥？
    	 
        FileInputStream fis3 = new FileInputStream("E:/abc4.txt");
        int num2;
        byte[] b = new byte[1024];
        num2 = fis3.read(b);
        System.out.println("读取的字节数:"+num2); //返回的int是啥？
        System.out.println("这是一个有用的分割线！");
        System.out.write(b, 0, num2);
        fis3.close();
        //结论：public int read() 返回的是1个byte转换后的int，public int read(byte[] b)返回的是读取了多少个字节！
    }

	public static void main(String[] args) {
		
	try{
		FileOutputStream fos1 = new FileOutputStream("E:/abc1.txt");
	    for (int x = 1; x < 512; x += 1) {

	    	fos1.write(x);
	    	//接口文档中描述 : write(int c) 写入单个字符  意思是写入 c的byte   ANSI码
	        System.out.println(Integer.toBinaryString(x));  //512对应的二进制是 111111111    127 对应的是 11111111 int  -128 ···· 127
	        
	    	//JAVA里给int类型分配4个字节的存储空间，相当于32位二进制数，8个低位就是b的右边8位，24个高位也就是左边24位。你看十进制，从右到左是个十百千万，越右边的位权值越小，所以叫低位。二进制也是同理。
	    }
    	fos1.write(65); //A
    	fos1.write(97); //a   	
    	fos1.write(65+127); //A
    	fos1.write((byte)65); //A
    	fos1.write((byte)97); //a 	
        fos1.write("B".getBytes()); //66
        fos1.write("b".getBytes()); //98
        fos1.write("我".getBytes()); //206  210两个字节
	    fos1.close();
	    System.out.println("11111111111111111111111111111");
	    FileInputStream fos2 = new FileInputStream("E:/abc1.txt");
	    for (int x =1 ;x <512+10 ;x+=1){
	    	System.out.println(fos2.read());  //最后是 :65 97 192 65 97 66 98 206  210 -1
	    }
	    fos2.close();
	    System.out.println("11111111111111111111111111111");	
	    FileOutputStream fos3 = new FileOutputStream("E:/abc2.txt");
	    fos3.write("我是一个字符串".getBytes());
	    fos3.close();
	    System.out.println("11111111111111111111111111111");	
	    FileInputStream fos4 = new FileInputStream("E:/abc2.txt");
	    while (fos4.read() != -1) {
	    	System.out.println(fos4.read());  //最后是 :210 199 187 246 214 251 174
	    	System.out.println(((char)fos4.read()));  // char 和 byte 之间发生转换的时候,就涉及编码问题 ,这里无法正常打印中文
	    	//一切“字符”都必定用数字+编码表表示	    	   	    	
	    }
	    fos4.close();
	    
	    System.out.println("00000000000000000000000000000");
	    FileInputStream fos5 = new FileInputStream("E:/abc2.txt");
	    String encoding = "gbk"; 
	    	//System.out.println(fos5.read());
	    	byte[] a = new byte[14]; //7个中文字符 需要 14个byte 表示
	    	fos5.read(a);
	    	String str=new String(a,encoding);  	
	    	System.out.println(str);
	    System.out.println("00000000000000000000000000000");
	    
	    encoding = "gb2312"; 	
    	byte[] b={(byte)'\u00c4',(byte)'\u00e3'}; //两个byte > 你
    	str=new String(b,encoding);  	
    	System.out.println(str);
    		    
    	System.out.println("11111111111111111111111111111");	     
	    RandomAccessFile demo=new RandomAccessFile("E:/abc3.txt","rw");
        demo.writeBytes("asdsad");
        demo.writeInt(11);
        demo.writeInt(5120);
        demo.writeBoolean(true);
        demo.writeBoolean(false);
        demo.writeChar('A');
        demo.writeChar('a');
        demo.writeFloat(1.11f);
        demo.writeFloat(1.21f);
        demo.writeDouble(12.123);
        demo.close();   
        System.out.println("11111111111111111111111111111");	
        RandomAccessFile rdemo=new RandomAccessFile("E:/abc3.txt","rw");     
        System.out.println(rdemo.readLine());//无法直接显示，乱码
        System.out.println("11111111111111111111111111111");	
        encoding = "utf8"; 
        rdemo.seek(0);
        byte[] b1 = new byte[6];
        rdemo.read(b1);
        System.out.println(new String(b1,encoding));
        
        
      
        int b3=rdemo.readInt();     
        System.out.println(b3);
        System.out.println("11111111111111111111111111111");        
        byte[] b2 = new byte[4];
        rdemo.read(b2);      
        System.out.println(byteToInt1(b2,0));  //System.out.println(rdemo.readInt());  writeInt写入的数据可以由readInt读出，相应的其他数据也是这样，具体参考API文档。
        System.out.println("11111111111111111111111111111"); 
        //上下俩个转int的源不一样，读文件时byte[3]为最高位,而一般的byte数组byte[0]是最高位！
        System.out.println(byteToInt2(b2));
        //System.out.println(new String(b2,encoding));
        
       
        rdemo.close();
        System.out.println("3333333333333333333333333"); 
        WhatIsReturnInt();//结论：public int read() 返回的是1个byte转换后的int，public int read(byte[] b)返回的是读取了多少个字节！参考 InputStream API文档 >>>>看文档真的很重要！
        System.out.println("3333333333333333333333333"); 

	}catch (Exception e) {       	
		// TODO: handle exception
	}
	

	
}
}

/*
byte[] returnInt = new byte[4];
returnInt[0] = (byte)((x >>> 24) & 0xFF);
returnInt[1] = (byte)((x >>> 16) & 0xFF);
returnInt[2] = (byte)((x >>>  8) & 0xFF);
returnInt[3] = (byte)((x >>>  0) & 0xFF);

 
  byte 8 bits -128 - + 127
  1 bit = 1 二进制数据
  1 byte = 8 bit   >> 1 字节 = 8 比特
  1 字母 = 1 byte = 8 bit(位)
  1 汉字 = 2 byte = 16 bit
  
write(int b)  将指定的字节写入此输出流。


数据类型            大小       范围                                             默认值 

byte(字节) 	    	8         -128 - 127                                           0
shot(短整型)        16      -32768 - 32768                                         0
int(整型)           32   -2147483648-2147483648                                    0
long(长整型)        64   -9233372036854477808-9233372036854477808                  0        
float(浮点型)       32  -3.40292347E+38-3.40292347E+38                            0.0f
double(双精度)	    64  -1.79769313486231570E+308-1.79769313486231570E+308        0.0d
char(字符型)        16         ‘ \u0000 - u\ffff ’                             ‘\u0000 ’
boolean(布尔型)     1         true/false                                         false

http://www.cnblogs.com/fuzhaoyang56/archive/2013/05/24/3096471.html  讲编码的理论


将数据转换成二进制，然后进行运算，如：
int a = 1; //a的二进制表示为0x00000001
a << 1;  //a左移1位，变为0x00000010，就是2
a >> 1;  //a右移1位，变为0x00000000，就是0
a | 1;  //a按位或1，0x00000001 | 0x00000001，结果还是0x00000001
a & 1;  //a按位与1，0x00000001 & 0x00000001,结果还是0x00000001
a ^ 1;  //a按位异或1，0x00000001 ^ 00x00000001,结果为0x00000000
~a;  //a按位取反，结果为0x11111110

*/
	
}

//在java中要想实现多线程，有两种手段，一种是继续Thread类，另外一种是实现Runable接口。
//如果一个类继承Thread，则不适合资源共享。但是如果实现了Runable接口的话，则很容易的实现资源共享。
多线程{
	
1.对于直接继承Thread的类来说，代码大致框架是：

1. 定义一个类继承Thread类。
2. 覆盖Thread类中的run方法。
3. 直接创建Thread的子类对象创建线程。
4. 调用start方法开启线程并调用线程的任务run方法执行

class 类名 extends Thread{
方法1;
方法2；
…
public void run(){
// other code…
}
属性1；
属性2；
…
} 
//例子1
//继承Thread类，复写run方法
class Demo extends Thread
{
    public void run(){//run方法内不能抛异常，只能try catch。因为该方法是复写Thread类中的run方法。Thread类中的run方法没有抛异常
        for (int x=0;x<70 ;x++ )
        {
            System.out.println(Thread.currentThread().getName()+"....."+x);
        }
    }
}
class ThreadDemo 
{
    public static void main(String[] args) //开启了两个线程：Demo和main。两个线程交替运行
    {
        new Demo().start();//创建子类对象，并开启线程，调用run方法
        for (int x=0;x<70 ;x++ )
        {
            System.out.println(Thread.currentThread().getName()+":::"+x);//mian函数的线程名称就是：main
        }
    }
}

/*
子进程 中run了打印线程名，main中也开发打印线程名，两个线程名字交织在一起输出。
*/

2.实现Runnable，复写run方法

1. 定义类实现Runnable接口
2. 覆盖接口中的run方法（用于封装线程要运行的代码）
3. 通过Thread类创建线程对象
4. 将实现了Runnable接口的子类对象作为实际参数传递给Thread类中的构造函数。


class 类名 implements Runnable{
方法1;
方法2；
…
public void run(){
// other code…
}
属性1；
属性2；
…
}
//样例
class MyThread implements Runnable{
 
    private int ticket = 5;  //5张票
 
    public void run() {
        for (int i=0; i<=20; i++) {
            if (this.ticket > 0) {
                System.out.println(Thread.currentThread().getName()+ "正在卖票"+this.ticket--);
            }
        }
    }
}
public class lzwCode {
     
    public static void main(String [] args) {
        MyThread my = new MyThread();
        new Thread(my, "1号窗口").start();
        new Thread(my, "2号窗口").start();
        new Thread(my, "3号窗口").start();
    }
}


//实现Runnable接口比继承Thread类所具有的优势：
1）：适合多个相同的程序代码的线程去处理同一个资源
2）：可以避免java中的单继承的限制
3）：增加程序的健壮性，代码可以被多个线程共享，代码和数据独立。


#同步代码块的格式：
    synchronized(对象){// 任意对象都可以。这个对象就是锁。
           需要被同步的代码;
    } 
同步的好处：解决了线程的安全问题。
同步的弊端：当线程相当多时，因为每个线程都会去判断同步上的锁，这是很耗费资源的，无形中会降低程序的运行效率。
同步的前提：必须有多个线程并使用同一个锁。

//加上同步代码块后
class Ticket implements Runnable
{
    private int ticket=100;
    private Object obj=new Object();
    public void run(){
        while (true)
        {
            synchronized(obj){//加上同步代码块后，obj对象相当于一把锁，一个线程进去后,其他线程无法进去，只有当这个线程执行完，跳出同步后，另一个才能进去
                if (ticket>0)//一个线程进同步有两个隐式操作，刚进同步后：上锁，跳出同步后：释放锁
                {
                    try{Thread.sleep(20);}catch(Exception e){}//让线程停止20毫秒，这时候出现了线程等于0、-1、-2的情况
                    System.out.println(Thread.currentThread().getName()+"..."+ticket--);//出现问题的原因是：线程停止了20毫秒后，继续运行的时候没有判断if的条件。
                }
            }
        }
        
    }    
}
class TicketDemo 
{
    public static void main(String[] args) 
    {
        Ticket t=new Ticket();
        new Thread(t).start();
        new Thread(t).start();
        new Thread(t).start();
        new Thread(t).start();
    }
}


//多生产--多消费问题

class Resource
{
    private String name;
    private int count=1;
    private boolean flag=false;
    public synchronized void set(String name){
        while(flag)//循环判断标记来防止线程等待被唤醒后往下执行，直接生产覆盖上一个数据。
            try{this.wait();}catch(Exception e){}
        this.name=name+"....."+count++;
        System.out.println(Thread.currentThread().getName()+"..生产者.."+this.name);
        flag=true;
        this.notifyAll();//唤醒线程池中的全部线程
    }
    public synchronized void out(){
        while(!flag)
            try{this.wait();}catch(Exception e){}
        System.out.println(Thread.currentThread().getName()+"----消费者-------"+this.name);
        flag=false;
        this.notifyAll();//唤醒线程池中的全部线程
    }
}
class Producer implements Runnable
{
    private Resource r;
    Producer(Resource r){
        this.r=r;
    }
    public void run(){
        while (true)
        {
            r.set("商品");
        }
    }
}
class Consumer implements Runnable
{
    private Resource r;
    Consumer(Resource r){
        this.r=r;
    }
    public void run(){
        while (true)
        {
            r.out();
        }
    }
}
class  ProducerConsumerDemo
{
    public static void main(String[] args) 
    {
        Resource r=new Resource();
        new Thread(new Producer(r)).start();
        new Thread(new Producer(r)).start();
        new Thread(new Consumer(r)).start();
        new Thread(new Consumer(r)).start();

    }
}

// JDK1.5多生产--多消费问题代码
import java.util.concurrent.locks .*;
class Resource
{
    private boolean flag;
    private Lock lock=new ReentrantLock();//创建Lock对象
    private Condition procondition=lock.newCondition();//创建Condition对象
    private Condition concondition=lock.newCondition();
    private int count=1;
    private String name;
    public void set(String name){
        lock.lock();//显示的加锁
        try
        {
            while(flag)
                procondition.await();//await替换了wait；
            this.name=name+"..."+count++;
            System.out.println(Thread.currentThread().getName()+"..生产者.."+this.name);
            flag=true;
            concondition.signal();//signal替换了notify
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
        finally{
            lock.unlock();//释放锁，释放资源的动作一定要放在finally块中
        }
        
    }
    public void out(){
        lock.lock();
        try
        {
            while(!flag)
                concondition.await();
            System.out.println(Thread.currentThread().getName()+"------消费者-----"+this.name);
            flag=false;
            procondition.signal();
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
        finally{
            lock.unlock();
        }
    }
}
class Producer implements Runnable
{
    private Resource r;
    Producer(Resource r){
        this.r=r;
    }
    public void run(){        
        while (true)
        {            
            r.set("商品");
        }
    }
}
class Consumer implements Runnable
{
    private Resource r;
    Consumer(Resource r){
        this.r=r;
    }
    public void run(){
        while (true)
        {
            r.out();
        }
    }
}
class ProducerConsumerDemo2 
{
    public static void main(String[] args) 
    {
        Resource r=new Resource();
        new Thread(new Producer(r)).start();
        new Thread(new Producer(r)).start();
        new Thread(new Consumer(r)).start();
        new Thread(new Consumer(r)).start();
    }
}




	
}

嵌套static类{
public class Test
{
    public static void main(String[] args)
    {
        Human.Mongolian him = new Human.Mongolian();
        him.Shout();
    }
}

class Human
{
    /**
     * nested class
     */
    static class Mongolian
    {
        public void Shout()
        {
            System.out.println("Oh...Ho...");
        }
    }
}
}

/*
在对子类对象进行初始化时，父类的构造函数也会运行，那是因为子类的所有构造函数默认第一行有一条隐式的语句 super();
super():会访问父类中空参数的构造函数。而且子类中所有的构造函数默认第一行都是super()。

以Person p = new Person();为例：
 　　1. JVM会读取指定的路径下的Person.class文件，并加载进内存，并会先加载Person的父类（如果有直接的父类的情况下）。
 　　2. 在内存中开辟空间，并分配地址。
 　　3. 并在对象空间中，对对象的属性进行默认初始化。
 　　4. 调用对应的构造函数进行初始化。
 　　5. 在构造函数中，第一行会先到调用父类中构造函数进行初始化。
 　　6. 父类初始化完毕后，再对子类的属性进行显示初始化。
 　　7. 再进行子类构造函数的特定初始化。
 　　8. 初始化完毕后，将地址值赋值给引用变量。

#类的初始化过程
1、父类静态成员初始化

2、父类静态代码块执行

3、子类静态成员初始化

4、子类静态代码块执行

5、父类构造代码块执行

6、父类构造函数执行

7、子类构造代码块执行

8、子类构造函数执行

 
 覆盖：
1.子类覆盖父类，必须保证子类权限大于等于父类权限，才可以覆盖，否则编译失败。
2.静态只能覆盖静态。
3.父类中的私有方法不可以被覆盖。父类为static的方法无法覆盖。
4.重载：只看同名函数的参数列表。重写：子父类方法要一模一样。
*/

理论学习{
1.面向对象编程有三大特性：封装、继承、多态。
	
多态:就是指程序中定义的引用变量所指向的具体类型和通过该引用变量发出的方法调用在编程时并不确定，而是在程序运行期间才确定，即一个引用变量倒底会指向哪个类的实例对象，该引用变量发出的方法调用到底是哪个类中实现的方法，必须在由程序运行期间才能决定。因为在程序运行时才确定具体的类，这样，不用修改源程序代码，就可以让引用变量绑定到各种不同的类实现上，从而导致该引用调用的具体方法随之改变，即不修改程序代码就可以改变程序运行时所绑定的具体代码，让程序可以选择多个运行状态，这就是多态性。

在使用抽象类时需要注意几点：
         1、抽象类不能被实例化，实例化的工作应该交由它的子类来完成，它只需要有一个引用即可。
         2、抽象方法必须由子类来进行重写。
         3、只要包含一个抽象方法的抽象类，该方法必须要定义成抽象类，不管是否还包含有其他方法。
         4、抽象类中可以包含具体的方法，当然也可以不包含抽象方法。
         5、子类中的抽象方法不能与父类的抽象方法同名。
         6、abstract不能与final并列修饰同一个类。
         7、abstract 不能与private、static、final或native并列修饰同一个方法。
在使用接口过程中需要注意如下几个问题：
         1、个Interface的方所有法访问权限自动被声明为public。确切的说只能为public，当然你可以显示的声明为protected、private，但是编译会出错！
         2、接口中可以定义“成员变量”，或者说是不可变的常量，因为接口中的“成员变量”会自动变为为public static final。可以通过类命名直接访问：ImplementClass.name。
         3、接口中不存在实现的方法。
         4、实现接口的非抽象类必须要实现该接口的所有方法。抽象类可以不用实现。
         5、不能使用new操作符实例化一个接口，但可以声明一个接口变量，该变量必须引用（refer to)一个实现该接口的类的对象。可以使用 instanceof 检查一个对象是否实现了某个特定的接口。例如：if(anObject instanceof Comparable){}。
         6、在实现多接口的时候一定要避免方法名的重复。	
}

######  定制自己的排序   >>>>>>使用类Name作为复合型数据结构！！！！
{
class Name{
     public int index = 0;
     public String Name_str = "";
     Name(int i, String str){
         index = i;
         Name_str = str;
     }
}
class NAME_ORDER implements Comparator<Name>{  
     public int compare( Name n1, Name n2 ){
         return n1.Name_str.compareTo(n2.Name_str);
     }
}

        Name[] Name_array = {
                 new Name(1,"ddd"),
                 new Name(1,"ccc"),
                 new Name(4,"bbb"),
                 new Name(5,"aaa")
         };
         
         System.out.println("NAME_ORDER");
         Arrays.sort(Name_array,new NAME_ORDER());  
         for(int i=0;i<Name_array.length;i++){
            System.out.println(Name_array[i].Name_str);  
         }
}		 
//////反射与自省
/*
Java反射机制主要提供了以下功能：
在运行时判断任意一个对象所属的类。
在运行时构造任意一个类的对象。
在运行时判断任意一个类所具有的成员变量和方法。
在运行时调用任意一个对象的方法。


在JDK中，主要由以下类来实现Java反射机制，这些类都位于java.lang.reflect包中：

Class类：代表一个类。
Field 类：代表类的成员变量（成员变量也称为类的属性）。
Method类：代表类的方法。
Constructor 类：代表类的构造方法。
Array类：提供了动态创建数组，以及访问数组的元素的静态方法。

在java.lang.Object 类中定义了getClass()方法，因此对于任意一个Java对象，都可以通过此方法获得对象的类型。Class类是Reflection API 中的核心类，它有以下方法
getName()：获得类的完整名字。
getFields()：获得类的public类型的属性。
getDeclaredFields()：获得类的所有属性。
getMethods()：获得类的public类型的方法。
getDeclaredMethods()：获得类的所有方法。
getMethod(String name, Class[] parameterTypes)：获得类的特定方法，name参数指定方法的名字，parameterTypes 参数指定方法的参数类型。
getConstructors()：获得类的public类型的构造方法。
getConstructor(Class[] parameterTypes)：获得类的特定构造方法，parameterTypes 参数指定构造方法的参数类型。
newInstance()：通过类的不带参数的构造方法创建这个类的一个对象。

Class<? super T> getSuperclass()：返回本类的父类
Type getGenericSuperclass()：返回本类的父类，包含泛型参数信息
Type[] getGenericInterfaces()：以Type的形式返回本类直接实现的接口，这样就包含了泛型参数信息
Class[] getInterfaces()：返回本类直接实现的接口.不包含泛型参数信息

*/
例子{
	

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Type;

public class RefConstructor {

    public static void main(String[] args) throws Exception {
    	System.out.println("\n88888888888888888888888888888888888888888888\n");
    	test();
    	System.out.println("\n88888888888888888888888888888888888888888888\n");
        RefConstructor ref =new RefConstructor();
        ref.getConstructor();
        
    }
    
    public static void test() throws Exception {

    	Class cl2 = int.class;
    	System.out.println(cl2.getName());
    	
    	Class c2=Class.forName("RefConstructor");
    	System.out.println(c2.getName());
    	

    	
    }
    public void getConstructor() throws Exception {
        Class c =null;
        c = Class.forName("java.lang.Long");
        Class cs[] = { java.lang.String.class };

        System.out.println("\n--------------构造器的使用-----------------\n");
        Constructor cst1 = c.getConstructor(cs);
        System.out.println("1、通过参数获取指定Class对象的构造方法：");
        System.out.println(cst1.toString());
        
        Constructor cst2 = c.getDeclaredConstructor(cs);
        System.out.println("2、通过参数获取指定Class对象所表示的类或接口的构造方法：");
        System.out.println(cst2.toString());
        
        Constructor cst3 = c.getEnclosingConstructor();
        System.out.println("3、获取本地或匿名类Constructor对象，它表示基础类的立即封闭构造方法。");
        if (cst3 !=null) System.out.println(cst3.toString());
        else System.out.println("没有获取到任何构造方法！");
        
        //Constructor[] csts = c.getDeclaredConstructors(); //获取所有的构造器
        Constructor[] csts = c.getConstructors(); //获取public类型的构造器
        System.out.println("4、获取指定Class对象的所有构造方法：");
        for (int i =0; i < csts.length; i++) {
            System.out.println(csts[i].toString());
        }
        
        System.out.println("\n--------------类型的使用-----------------\n");
        Type types1[] = c.getGenericInterfaces(); //获取实现的接口
        System.out.println("1、返回直接实现的接口：");
        for (int i =0; i < types1.length; i++) {
            System.out.println(types1[i].toString());
        }
        
        Type type1 = c.getGenericSuperclass(); ////获取父类
        System.out.println("2、返回直接超类：");
        System.out.println(type1.toString());
        
        Class[] cis = c.getClasses();
        System.out.println("3、返回超类和所有实现的接口：");
        System.out.println("length="+cis.length);
        for (int i =0; i < cis.length; i++) {
            System.out.println(cis[i].toString());
        }
        
        Class cs1[] = c.getInterfaces();
        System.out.println("4、实现的接口");
        for (int i =0; i < cs1.length; i++) {
            System.out.println(cs1[i].toString());
        }
        
        System.out.println("5、父类");
        System.out.println(c.getSuperclass());
        
        System.out.println("\n--------------成员变量的使用-----------------\n");
        Field fs1[] = c.getFields(); //获取PUBLIC类型的属性
        System.out.println("1、类或接口的所有可访问公共字段：");
        for (int i =0; i < fs1.length; i++) {
            System.out.println(fs1[i].toString());
        }
        
        Field f1 = c.getField("MIN_VALUE"); //获取指定的属性
        System.out.println("2、类或接口的指定已声明指定公共成员字段：");
        System.out.println(f1.toString());
        
        Field fs2[] = c.getDeclaredFields(); //获取所有的属性
        System.out.println("3、类或接口所声明的所有字段：");
        for (int i =0; i < fs2.length; i++) {
            System.out.println(fs2[i].toString());
        }
        
        Field f2 = c.getDeclaredField("serialVersionUID");
        System.out.println("4、类或接口的指定已声明指定字段：");
        System.out.println(f2.toString());
        
        System.out.println("\n--------------成员方法的使用-----------------\n");
        //Method m1[] = c.getDeclaredMethods();
        Method m1[] = c.getMethods();
        System.out.println("1、返回类所有的公共成员方法：");
        for (int i =0; i < m1.length; i++) {
            System.out.println(m1[i].toString());
        }
        
        //Method m2 = c.getDeclaredMethod("longValue", new Class[]{});
        Method m2 = c.getMethod("longValue", new Class[]{});
        System.out.println("2、返回指定公共成员方法：");
        System.out.println(m2.toString());
    }
}

}
/*
--------------构造器的使用-----------------

1、通过参数获取指定Class对象的构造方法：
public java.lang.Long(java.lang.String) throws java.lang.NumberFormatException
2、通过参数获取指定Class对象所表示的类或接口的构造方法：
public java.lang.Long(java.lang.String) throws java.lang.NumberFormatException
3、获取本地或匿名类Constructor对象，它表示基础类的立即封闭构造方法。
没有获取到任何构造方法！
4、获取指定Class对象的所有构造方法：
public java.lang.Long(long)
public java.lang.Long(java.lang.String) throws java.lang.NumberFormatException

--------------类型的使用-----------------

1、返回直接实现的接口：
java.lang.Comparable<java.lang.Long>
2、返回直接超类：
class java.lang.Number
3、返回超类和所有实现的接口：
length=0
4、实现的接口
interface java.lang.Comparable
5、父类
class java.lang.Number

--------------成员变量的使用-----------------

1、类或接口的所有可访问公共字段：
public static final long java.lang.Long.MIN_VALUE
public static final long java.lang.Long.MAX_VALUE
public static final java.lang.Class java.lang.Long.TYPE
public static final int java.lang.Long.SIZE
2、类或接口的指定已声明指定公共成员字段：
public static final long java.lang.Long.MIN_VALUE
3、类或接口所声明的所有字段：
public static final long java.lang.Long.MIN_VALUE
public static final long java.lang.Long.MAX_VALUE
public static final java.lang.Class java.lang.Long.TYPE
private final long java.lang.Long.value
public static final int java.lang.Long.SIZE
private static final long java.lang.Long.serialVersionUID
4、类或接口的指定已声明指定字段：
private static final long java.lang.Long.serialVersionUID

--------------成员方法的使用-----------------

1、返回类所有的公共成员方法：
public int java.lang.Long.hashCode()
public boolean java.lang.Long.equals(java.lang.Object)
public static java.lang.String java.lang.Long.toString(long)
public static java.lang.String java.lang.Long.toString(long,int)
public java.lang.String java.lang.Long.toString()
public static java.lang.String java.lang.Long.toHexString(long)
public static int java.lang.Long.compare(long,long)
public int java.lang.Long.compareTo(java.lang.Object)
public int java.lang.Long.compareTo(java.lang.Long)
public static java.lang.Long java.lang.Long.decode(java.lang.String) throws java.lang.NumberFormatException
public static java.lang.Long java.lang.Long.valueOf(java.lang.String,int) throws java.lang.NumberFormatException
public static java.lang.Long java.lang.Long.valueOf(long)
public static java.lang.Long java.lang.Long.valueOf(java.lang.String) throws java.lang.NumberFormatException
public static java.lang.Long java.lang.Long.getLong(java.lang.String,long)
public static java.lang.Long java.lang.Long.getLong(java.lang.String,java.lang.Long)
public static java.lang.Long java.lang.Long.getLong(java.lang.String)
public long java.lang.Long.longValue()
public int java.lang.Long.intValue()
public static long java.lang.Long.reverse(long)
public static long java.lang.Long.reverseBytes(long)
public byte java.lang.Long.byteValue()
public double java.lang.Long.doubleValue()
public float java.lang.Long.floatValue()
public short java.lang.Long.shortValue()
public static int java.lang.Long.bitCount(long)
public static long java.lang.Long.highestOneBit(long)
public static long java.lang.Long.lowestOneBit(long)
public static int java.lang.Long.numberOfLeadingZeros(long)
public static int java.lang.Long.numberOfTrailingZeros(long)
public static long java.lang.Long.rotateLeft(long,int)
public static long java.lang.Long.rotateRight(long,int)
public static int java.lang.Long.signum(long)
public static java.lang.String java.lang.Long.toBinaryString(long)
public static java.lang.String java.lang.Long.toOctalString(long)
public static long java.lang.Long.parseLong(java.lang.String) throws java.lang.NumberFormatException
public static long java.lang.Long.parseLong(java.lang.String,int) throws java.lang.NumberFormatException
public final native java.lang.Class java.lang.Object.getClass()
public final native void java.lang.Object.notify()
public final native void java.lang.Object.notifyAll()
public final void java.lang.Object.wait(long,int) throws java.lang.InterruptedException
public final void java.lang.Object.wait() throws java.lang.InterruptedException
public final native void java.lang.Object.wait(long) throws java.lang.InterruptedException
2、返回指定公共成员方法：
public long java.lang.Long.longValue()

*/		 


#随机存取，就是可以同时读写，有读的方法也有写的方法  >>>我喜欢！
RandomAccessFile(File file, String mode) 
RandomAccessFile(String name, String mode) 		 

public native void write(int b) throws IOException;
native 是java调用其他语言的接口，一般是c语言，表示本函数是c语言实现的，有相应的具体实现！

泛型{
//泛型就是类型参数化，处理的数据类型不是固定的，而是可以作为参数传入。	
public class Pair<U, V> {

    U first;
    V second;
    
    public Pair(U first, V second){
        this.first = first;
        this.second = second;
    }
    
    public U getFirst() {
        return first;
    }

    public V getSecond() {
        return second;
    }
}
Pair<String,Integer> pair = new Pair<String,Integer>("老马",100);
Pair<String,Integer> pair = new Pair<>("老马",100);
/*
Java有Java编译器和Java虚拟机，编译器将Java源代码转换为.class文件，虚拟机加载并运行.class文件。对于泛型类，Java编译器会将泛型代码转换为普通的非泛型代码，就像普通Pair类代码及其使用代码一样，将类型参数T擦除，替换为Object，插入必要的强制类型转换。Java虚拟机实际执行的时候，它是不知道泛型这回事的，它只知道普通的类及代码。

再强调一下，Java泛型是通过擦除实现的，类定义中的类型参数如T会被替换为Object，在程序运行过程中，不知道泛型的实际类型参数，比如Pair<Integer>，运行中只知道Pair，而不知道Integer，认识到这一点是非常重要的，它有助于我们理解Java泛型的很多限制。
*/	
//动态数组的实现
import java.io.IOException;
import java.util.Arrays;
import java.util.Random;

public class DynamicArray<E> {
    private static final int DEFAULT_CAPACITY = 10;

    private int size;
    private Object[] elementData;

    public DynamicArray() {
        this.elementData = new Object[DEFAULT_CAPACITY];
    }

    private void ensureCapacity(int minCapacity) {
        int oldCapacity = elementData.length;
        System.out.println("==============="+oldCapacity);
        if(oldCapacity>=minCapacity){
            return;
        }       
        int newCapacity = oldCapacity * 2;
        System.out.println("==============="+newCapacity);
        if (newCapacity < minCapacity)
            newCapacity = minCapacity;
        elementData = Arrays.copyOf(elementData, newCapacity);
    }

    public void add(E e) {
        ensureCapacity(size + 1);
        elementData[size++] = e;
    }

    public E get(int index) {
        return (E)elementData[index];
    }
	
    public int size() {
        return size;
    }

    public E set(int index, E element) {
        E oldValue = get(index);
        elementData[index] = element;
        return oldValue;
    }

public static void main(String[] args){
	//测试
	DynamicArray<Double> arr = new DynamicArray<Double>();
	Random rnd = new Random();
	int size1 = 1+rnd.nextInt(100);
	System.out.println(size1);
	for(int i=0; i<size1; i++){
	    arr.add(Math.random());	  		
		System.out.println(arr.size);
	}
	
	 Double d = arr.get(rnd.nextInt(size1));
	 System.out.println(d);
	
}
}

//方法也可以是泛型的
public static <T> int indexOf(T[] arr, T elm){
    for(int i=0; i<arr.length; i++){
        if(arr[i].equals(elm)){
            return i;
        }
    }
    return -1;
}

//接口也可以是泛型的

//extends在泛型里不是继承，而是定义上界的意思，如T extends UpperBound，UpperBound为泛型T的上界，也就是说T必须为UpperBound或者它的子类；
//super关键字用于定义泛型的下界。如T super LowerBound，则LowerBound为泛型T的下界，也就是说T必须为LowerBound或者它的父类；
1、多个泛型参数定义由逗号隔开，就像<T,K>这样。
2、同一个泛型参数如果有多个上界，则各个上界之间用&符号连接。
3、多个上界类型里最多只能有一个类，其他必须为接口，如果上界里有类，则必须放置在第一位。
class A {
}
class B extends A {
}
class C extends B {
}
/**
 * 这是一个泛型类
 */
class ComplexGeneric<T extends A, K extends B & Serializable & Cloneable>  {...}

//通过上面代码可以看出，ComplextGeneric 类具备两个泛型参数<T,K>，其中T具备上界A，换言之，T一定是A或者其子类；K具备三个上界，分别为类B，接口 Serializable和Cloneable，换言之，K一定是B或者其子类，并且实现了Serializable和Cloneable。

}

java中常用的英文单词{
	
第一章：
JDK(Java Development Kit) java开发工具包
JVM(Java Virtual Machine) java虚拟机
Javac  编译命令         
java  解释命令     
Javadoc  生成java文档命令  
classpath 类路径        
Version  版本      
author  作者      
public  公共的      
class  类       
static  静态的       
void  没有返回值      
String  字符串类       
System  系统类       
out  输出       
print  同行打印      
println  换行打印
JIT(just-in-time)  及时处理
第二章：
byte 字节      
char 字符      
boolean 布尔      
short 短整型     
int 整形      
long 长整形    
float 浮点类型      
double 双精度      
if 如果      
else 否则      
switch 多路分支      
case 与常值匹配
break 终止      
default 默认       
while 当到循环      
do 直到循环      
for 已知次数循环    
continue结束本次循环进行下次跌代         
length 获取数组元素个数
第三章：
OOP  object oriented programming 面向对象编程
Object 对象
Class 类
Class member 类成员
Class method  类方法
Class variable 类变量
Constructor 构造方法
Package 包
Import package 导入包

第四章：
Extends 继承 
Base class 基类
Super class 超类
Overloaded method 重载方法
Overridden method   重写方法
Public   公有
Private 私有
Protected 保护
Static 静态
Abstract  抽象
Interface 接口
Implements interface   实现接口

第五章：
Exception 意外，异常
RuntimeExcepiton 运行时异常
ArithmeticException 算术异常
IllegalArgumentException 非法数据异常
ArrayIndexOutOfBoundsException 数组索引越界异常
NullPointerException 空指针异常
ClassNotFoundException 类无法加载异常（类不能找到）
NumberFormatException 字符串到float类型转换异常（数字格式异常）
IOException 输入输出异常
FileNotFoundException 找不到文件异常
EOFException 文件结束异常
InterruptedException （线程）中断异常
try 尝试
catch 捕捉
finally 最后
throw 投、掷、抛
throws 投、掷、抛
print Stack Trace() 打印堆栈信息
get Message（） 获得错误消息
get Cause（） 获得异常原因
method 方法
able 能够
instance 实例
check 检查
第六章：
byte（字节）
char（字符）
int（整型）
long（长整型）
float（浮点型）
double（双精度）
boolean（布尔）
short（短整型）
Byte （字节类）
Character （字符类）
Integer（整型类）
Long （长整型类）
Float（浮点型类）
Double （双精度类）
Boolean（布尔类）
Short （短整型类）
Digit （数字）
Letter （字母）
Lower (小写)
Upper (大写)
Space (空格)
Identifier (标识符)
Start (开始)
String (字符串)
length （值）
equals (等于) 
Ignore （忽略）
compare （比较）
sub （提取）
concat （连接）
replace （替换）
trim （整理）
Buffer (缓冲器)
reverse (颠倒)
delete （删除）
append （添加）
Interrupted （中断的）
第七章：
Date    日期，日子
After   后来，后面 
Before   在前，以前
Equals   相等，均等
toString   转换为字符串
SetTime   设置时间
Display   显示，展示 
Calendar   日历
Add    添加，增加
GetInstance  获得实例
getTime   获得时间
Clear   扫除，清除
Clone   克隆，复制 
Util    工具，龙套 
Components  成分，组成 
Month   月份
Year    年，年岁 
Hour   小时，钟头
Minute   分钟
Second   秒
Random   随意，任意
Next Int   下一个整数
Gaussian   高斯  
ArrayList   对列
LinkedList  链表
Hash   无用信息，杂乱信号
Map    地图
Vector   向量，矢量
Size    大小
Collection  收集
Shuffle   混乱，洗牌
RemoveFirst  移动至开头
RemoveLast   移动至最后
lastElement  最后的元素
Capacity   容量，生产量
Contains   包含，容纳
Copy   副本，拷贝
Search   搜索，查询
InsertElementAt 插入元素在某一位置
第八章：
io->in out 输入/输出
File  文件
import  导入
exists  存在
isFile  是文件
isDirectory 是目录
getName  获取名字
getPath  获取路径
getAbsolutePath 获取绝对路径
lastModified 最后修改日期
length  长度
InputStream 输入流
OutputStream 输出流
Unicode  统一的字符编码标准, 采用双字节对字符进行编码
Information 信息
FileInputStream 文件输入流
FileOutputStream 文件输出流
IOException 输入输出异常
fileobject 文件对象
available 可获取的
read  读取
write  写
BufferedReader 缓冲区读取
FileReader 文本文件读取
BufferedWriter 缓冲区输出
FileWriter 文本文件写出
flush  清空
close  关闭
DataInputStream 二进制文件读取
DataOutputStream 二进制文件写出
EOF  最后
encoding  编码
Remote  远程
release  释放
第九章：
JBuider  Java 集成开发环境（IDE）
Enterprise 企业版
Developer 开发版
Foundation 基础版
Messages 消息格
Structure 结构窗格
Project  工程
Files  文件
Source  源代码
Design  设计
History  历史
Doc  文档
File  文件
Edit  编辑
Search  查找
Refactor 要素
View  视图
Run  运行
Tools  工具
Window  窗口
Help  帮助
Vector  矢量
addElement 添加内容
Project Winzard 工程向导
Step  步骤
Title  标题
Description 描述
Copyright 版权
Company  公司
Aptech Limited Aptech有限公司
author   作者
Back  后退
Finish  完成
version  版本
Debug  调试
New  新建
ErrorInsight 调试
第十章：
JFrame  窗口框架
JPanel   面板
JScrollPane 滚动面板
title    标题
Dimension 尺寸
Component  组件
Swing  JAVA轻量级组件
getContentPane 得到内容面板
LayoutManager  布局管理器
setVerticalScrollBarPolicy  设置垂直滚动条策略
AWT（Abstract Window Toolkit） 抽象窗口工具包
GUI （Graphical User Interface） 图形用户界面
VERTICAL_SCROLLEARAS_NEEDED  当内容大大面板出现滚动条
VERTICAL_SOROLLEARAS_ALWAYS  显示滚动条
VERTICAL_SOROLLEARAS_NEVER  不显示滚动条
JLabel  标签
Icon   图标
image  图象
LEFT   左对齐
RIGHT  右对齐
JTextField  单行文本
getColumns  得到列数
setLayout  设置布局
BorderLayout 边框布局
CENTER  居中对齐
JTextArea  多行文本
setFont  设置字体
setHorizontalAlignment  设置文本水平对齐方式
setDefaultCloseOperation  设置默认的关闭操作
add  增加
JButton 按钮
JCheckBox 复选框
JRadioButton单选按钮
addItem 增加列表项
getItemAt 得到位置的列表项
getItemCount 得到列表项个数
setRolloverIcon 当鼠标经过的图标
setSelectedIcon 当选择按钮的图标
getSelectedItem 得到选择的列表项
getSelectedIndex 得到选择的索引
ActionListener  按钮监听
ActionEvent   按钮事件
actionPerformed  按钮单击方法 
	
	
}

600单词 {
application 应用程式 应用、应用程序 
application framework 应用程式框架、应用框架 应用程序框架 
architecture 架构、系统架构 体系结构 
argument 引数（传给函式的值）。叁见 parameter 叁数、实质叁数、实叁、自变量 
array 阵列 数组 
arrow operator arrow（箭头）运算子 箭头操作符 
assembly 装配件 
assembly language 组合语言 汇编语言 
assert(ion) 断言 
assign 指派、指定、设值、赋值 赋值 
assignment 指派、指定 赋值、分配 
assignment operator 指派（赋值）运算子 = 赋值操作符 
associated 相应的、相关的 相关的、关联、相应的 
associative container 关联式容器（对应 sequential container） 关联式容器 
atomic 不可分割的 原子的 
attribute 属性 属性、特性 
audio 音讯 音频 
A.I. 人工智慧 人工智能 
background 背景 背景（用於图形着色） 
后台（用於行程） 
backward compatible 回溯相容 向下兼容 
bandwidth 频宽 带宽 
base class 基础类别 基类 
base type 基础型别 (等同於 base class) 
batch 批次（意思是整批作业） 批处理 
benefit 利益 收益 
best viable function 最佳可行函式 最佳可行函式 
（从 viable functions 中挑出的最佳吻合者） 
binary search 二分搜寻法 二分查找 
binary tree 二元树 二叉树 
binary function 二元函式 双叁函数 
binary operator 二元运算子 二元操作符 
binding 系结 绑定 
bit 位元 位 
bit field 位元栏 位域 
bitmap 位元图 位图 
bitwise 以 bit 为单元逐一┅ 
bitwise copy 以 bit 为单元进行复制；位元逐一复制 位拷贝 
block 区块,区段 块、区块、语句块 
boolean 布林值（真假值，true 或 false） 布尔值 
border 边框、框线 边框 
brace(curly brace) 大括弧、大括号 花括弧、花括号 
bracket(square brakcet) 中括弧、中括号 方括弧、方括号 
breakpoint 中断点 断点 
build 建造、构筑、建置（MS 用语） 
build－in 内建 内置 
bus 汇流排 总线 
business 商务,业务 业务 
buttons 按钮 按钮 
byte 位元组（由 8 bits 组成） 字节 
cache 快取 高速缓存 
call 呼叫、叫用 调用 
callback 回呼 回调 
call operator call（函式呼叫）运算子调用操作符 
（同 function call operator） 
candidate function 候选函式 候选函数 
（在函式多载决议程序中出现的候选函式） 
chain 串链（例 chain of function calls） 链 
character 字元 字符 
check box 核取方块 (i.e. check button) 复选框 
checked exception 可控式异常(Java) 
check button 方钮 (i.e. check box) 复选按钮 
child class 子类别（或称为derived class, subtype） 子类 
class 类别 类 
class body 类别本体 类体 
class declaration 类别宣告、类别宣告式 类声明 
class definition 类别定义、类别定义式 类定义 
class derivation list 类别衍化列 类继承列表 
class head 类别表头 类头 
class hierarchy 类别继承体系, 类别阶层 类层次体系 
class library 类别程式库、类别库 类库 
class template 类别模板、类别范本 类模板 
class template partial specializations 
类别模板偏特化 类模板部分特化 
class template specializations 
类别模板特化 类模板特化 
cleanup 清理、善后 清理、清除 
client 客端、客户端、客户 客户 
client－server 主从架构 客户/服务器 
clipboard 剪贴簿 剪贴板 
clone 复制 克隆 
collection 群集 集合 
combo box 复合方块、复合框 组合框 
command line 命令列 命令行 
(系统文字模式下的整行执行命令) 
communication 通讯 通讯 
compatible 相容 兼容 
compile time 编译期 编译期、编译时 
compiler 编译器 编译器 
component 组件 组件 
composition 复合、合成、组合 组合 
computer 电脑、计算机 计算机、电脑 
concept 概念 概念 
concrete 具象的 实在的 
concurrent 并行 并发 
configuration 组态 配置 
connection 连接，连线（网络,资料库） 连接 
constraint 约束（条件） 
construct 构件 构件 
container 容器 容器 
（存放资料的某种结构如 list, vector...） 
containment 内含 包容 
context 背景关系、周遭环境、上下脉络 环境、上下文 
control 控制元件、控件 控件 
console 主控台 控制台 
const 常数（constant 的缩写，C++ 关键字） 
constant 常数（相对於 variable） 常量 
constructor（ctor） 建构式 构造函数 
（与class 同名的一种 member functions） 
copy (v) 复制、拷贝 拷贝 
copy (n) 复件, 副本 
cover 涵盖 覆盖 
create 创建、建立、产生、生成 创建 
creation 产生、生成 创建 
cursor 游标 光标 
custom 订制、自定 定制 
data 资料 数据 
database 资料库 数据库 
database schema 数据库结构纲目 
data member 资料成员、成员变数 数据成员、成员变量 
data structure 资料结构 数据结构 
datagram 资料元 数据报文 
dead lock 死结 死锁 
debug 除错 调试 
debugger 除错器 调试器 
declaration 宣告、宣告式 声明 
deduction 推导（例：template argument deduction） 推导、推断 
default 预设 缺省、默认 
defer 延缓 推迟 
define 定义 预定义
definition 定义、定义区、定义式 定义 
delegate 委派、委托、委任 委托 
delegation （同上） 
demarshal 反编列 散集 
dereference 提领（取出指标所指物体的内容） 解叁考 
dereference operator dereference（提领）运算子 * 解叁考操作符 
derived class 衍生类别 派生类 
design by contract 契约式设计 
design pattern 设计范式、设计样式 设计模式 
※ 最近我比较喜欢「设计范式」一词 
destroy 摧毁、销毁 
destructor 解构式 析构函数 
device 装置、设备 设备 
dialog 对话窗、对话盒 对话框 
directive 指令（例：using directive） (编译)指示符 
directory 目录 目录 
disk 碟 盘 
dispatch 分派 分派 
distributed computing 分布式计算 (分布式电算) 分布式计算 
分散式计算 (分散式电算) 
document 文件 文档 
dot operator dot（句点）运算子 . (圆)点操作符 
driver 驱动程式 驱动（程序） 
dynamic binding 动态系结 动态绑定 
efficiency 效率 效率 
efficient 高效 高效 
end user 终端用户 
entity 物体 实体、物体 
encapsulation 封装 封装 
enclosing class 外围类别（与巢状类别 nested class 有关）外围类 
enum (enumeration) 列举（一种 C++ 资料型别） 枚举 
enumerators 列举元（enum 型别中的成员） 枚举成员、枚举器 
equal 相等 相等 
equality 相等性 相等性 
equality operator equality（等号）运算子 == 等号操作符 
equivalence 等价性、等同性、对等性 等价性 
equivalent 等价、等同、对等 等价 
escape code 转义码 转义码 
evaluate 评估、求值、核定 评估 
event 事件 事件 
event driven 事件驱动的 事件驱动的 
exception 异常情况 异常 
exception declaration 异常宣告（ref. C++ Primer 3/e, 11.3） 异常声明 
exception handling 异常处理、异常处理机制 异常处理、异常处理机制 
exception specification 异常规格（ref. C++ Primer 3/e, 11.4） 异常规范 
exit 退离（指离开函式时的那一个执行点） 退出 
explicit 明白的、明显的、显式 显式 
export 汇出 引出、导出 
expression 运算式、算式 表达式 
facility 设施、设备 设施、设备 
feature 特性 
field 栏位,资料栏（Java） 字段, 值域（Java） 
file 档案 文件 
firmware 韧体 固件 
flag 旗标 标记 
flash memory 快闪记忆体 闪存 
flexibility 弹性 灵活性 
flush 清理、扫清 刷新 
font 字型 字体 
form 表单（programming 用语） 窗体 
formal parameter 形式叁数 形式叁数 
forward declaration 前置宣告 前置声明 
forwarding 转呼叫,转发 转发 
forwarding function 转呼叫函式,转发函式 转发函数 
fractal 碎形 分形 
framework 框架 框架 
full specialization 全特化（ref. partial specialization） 
function 函式、函数 函数 
function call operator 同 call operator 
function object 函式物件（ref. C++ Primer 3/e, 12.3） 函数对象 
function overloaded resolution 
函式多载决议程序 函数重载解决（方案） 
functionality 功能、机能 功能 
function template 函式模板、函式范本 函数模板 
functor 仿函式 仿函式、函子 
game 游戏 游戏 
generate 生成 
generic 泛型、一般化的 一般化的、通用的、泛化 
generic algorithm 泛型演算法 通用算法 
getter (相对於 setter) 取值函式 
global 全域的（对应於 local） 全局的 
global object 全域物件 全局对象 
global scope resolution operator 
全域生存空间（范围决议）运算子 :: 全局范围解析操作符 
group 群组 
group box 群组方块 分组框 
guard clause 卫述句 (Refactoring, p250) 卫语句 
GUI 图形介面 图形界面 
hand shaking 握手协商 
handle 识别码、识别号、号码牌、权柄 句柄 
handler 处理常式 处理函数 
hard－coded 编死的 硬编码的 
hard－copy 硬拷图 屏幕截图 
hard disk 硬碟 硬盘 
hardware 硬体 硬件 
hash table 杂凑表 哈希表、散列表 
header file 表头档、标头档 头文件 
heap 堆积 堆 
hierarchy 阶层体系 层次结构（体系） 
hook 挂钩 钩子 
hyperlink 超链结 超链接 
icon 图示、图标 图标 
IDE 整合开发环境 集成开发环境 
identifier 识别字、识别符号 标识符 
if and only if 若且唯若 当且仅当 
Illinois 伊利诺 伊利诺斯 
image 影像 图象 
immediate base 直接的（紧临的）上层 base class。 直接上层基类 
immediate derived 直接的（紧临的）下层 derived class。 直接下层派生类 
immutability 不变性 
immutable 不可变（的） 
implement 实作、实现 实现 
implementation 实作品、实作体、实作码、实件 实现 
implicit 隐喻的、暗自的、隐式 隐式 
import 汇入 导入 
increment operator 累加运算子 ++ 增加操作符 
infinite loop 无穷回圈 无限循环 
infinite recursive 无穷递回 无限递归 
information 资讯 信息 
infrastructure 公共基础建设 
inheritance 继承、继承机制 继承、继承机制 
inline 行内 内联 
inline expansion 行内展开 内联展开 
initialization 初始化（动作） 初始化 
initialization list 初值列 初始值列表 
initialize 初始化 初始化 
inner class 内隐类别 内嵌类 
instance 实体 实例 
（根据某种表述而实际产生的「东西」） 
instantiated 具现化、实体化（常应用於 template） 实例化 
instantiation 具现体、具现化实体（常应用於 template） 实例 
integer (integral) 整数（的） 整型（的） 
integrate 整合 集成 
interacts 交谈、互动 交互 
interface 介面 接口 
for GUI 介面 界面 
interpreter 直译器 解释器 
invariants 恒常性,约束条件 约束条件 
invoke 唤起 调用 
iterate 迭代（回圈一个轮回一个轮回地进行） 迭代 
exception 异常情况 异常 
exception declaration 异常宣告（ref. C++ Primer 3/e, 11.3） 异常声明 
exception handling 异常处理、异常处理机制 异常处理、异常处理机制 
exception specification 异常规格（ref. C++ Primer 3/e, 11.4） 异常规范 
exit 退离（指离开函式时的那一个执行点） 退出 
explicit 明白的、明显的、显式 显式 
export 汇出 引出、导出 
expression 运算式、算式 表达式 
facility 设施、设备 设施、设备 
feature 特性 
field 栏位,资料栏（Java） 字段, 值域（Java） 
file 档案 文件 
firmware 韧体 固件 
flag 旗标 标记 
flash memory 快闪记忆体 闪存 
flexibility 弹性 灵活性 
flush 清理、扫清 刷新 
font 字型 字体 
form 表单（programming 用语） 窗体 
formal parameter 形式叁数 形式叁数 
forward declaration 前置宣告 前置声明 
forwarding 转呼叫,转发 转发 
forwarding function 转呼叫函式,转发函式 转发函数 
fractal 碎形 分形 
framework 框架 框架 
full specialization 全特化（ref. partial specialization） 
function 函式、函数 函数 
function call operator 同 call operator 
function object 函式物件（ref. C++ Primer 3/e, 12.3） 函数对象 
function overloaded resolution 
函式多载决议程序 函数重载解决（方案） 
functionality 功能、机能 功能 
function template 函式模板、函式范本 函数模板 
functor 仿函式 仿函式、函子 
game 游戏 游戏 
generate 生成 
generic 泛型、一般化的 一般化的、通用的、泛化 
generic algorithm 泛型演算法 通用算法 
getter (相对於 setter) 取值函式 
global 全域的（对应於 local） 全局的 
global object 全域物件 全局对象 
global scope resolution operator 
全域生存空间（范围决议）运算子 :: 全局范围解析操作符 
group 群组 
group box 群组方块 分组框 
guard clause 卫述句 (Refactoring, p250) 卫语句 
GUI 图形介面 图形界面 
hand shaking 握手协商 
handle 识别码、识别号、号码牌、权柄 句柄 
handler 处理常式 处理函数 
hard－coded 编死的 硬编码的 
hard－copy 硬拷图 屏幕截图 
hard disk 硬碟 硬盘 
hardware 硬体 硬件 
hash table 杂凑表 哈希表、散列表 
header file 表头档、标头档 头文件 
heap 堆积 堆 
hierarchy 阶层体系 层次结构（体系） 
hook 挂钩 钩子 
hyperlink 超链结 超链接 
icon 图示、图标 图标 
IDE 整合开发环境 集成开发环境 
identifier 识别字、识别符号 标识符 
if and only if 若且唯若 当且仅当 
Illinois 伊利诺 伊利诺斯 
image 影像 图象 
immediate base 直接的（紧临的）上层 base class。 直接上层基类 
immediate derived 直接的（紧临的）下层 derived class。 直接下层派生类 
immutability 不变性 
immutable 不可变（的） 
implement 实作、实现 实现 
implementation 实作品、实作体、实作码、实件 实现 
implicit 隐喻的、暗自的、隐式 隐式 
import 汇入 导入 
increment operator 累加运算子 ++ 增加操作符 
infinite loop 无穷回圈 无限循环 
infinite recursive 无穷递回 无限递归 
information 资讯 信息 
infrastructure 公共基础建设 
inheritance 继承、继承机制 继承、继承机制 
inline 行内 内联 
inline expansion 行内展开 内联展开 
initialization 初始化（动作） 初始化 
initialization list 初值列 初始值列表 
initialize 初始化 初始化 
inner class 内隐类别 内嵌类 
instance 实体 实例 
（根据某种表述而实际产生的「东西」） 
instantiated 具现化、实体化（常应用於 template） 实例化 
instantiation 具现体、具现化实体（常应用於 template） 实例 
integer (integral) 整数（的） 整型（的） 
integrate 整合 集成 
interacts 交谈、互动 交互 
interface 介面 接口 
for GUI 介面 界面 
interpreter 直译器 解释器 
invariants 恒常性,约束条件 约束条件 
invoke 唤起 调用 
iterate 迭代（回圈一个轮回一个轮回地进行） 迭代 
iterative 反覆的，迭代的 
iterator 迭代器（一种泛型指标） 迭代器 
iteration 迭代（回圈每次轮回称为一个 iteration） 迭代 
item 项目、条款 项、条款、项目 
laser 雷射 激光 
level 阶 层 (级) 
例 high level 高阶 高层 
library 程式库、函式库 库、函数库 
lifetime 生命期、寿命 生命期、寿命 
link 联结、连结 连接,链接 
linker 联结器、连结器 连接器 
literal constant 字面常数（例 3.14 或 "hi" 这等常数值） 字面常数 
list 串列（linked－list） 列表、表、链表 
list box 列表方块、列表框 列表框 
load 载入 装载 
loader 载入器 装载器、载入器 
local 区域的（对应於 global） 局部的 
local object 区域物件 局部对象 
lock 机锁 
loop 回圈 循环 
lvalue 左值 左值 
macro 巨集 宏 
magic number 魔术数字 魔法数 
maintain 维护 维护 
manipulator 操纵器（iostream 预先定义的一种东西） 操纵器 
marshal 编列 列集 
叁考 demarshal 
mechanism 机制 机制 
member 成员 成员 
member access operator 成员取用运算子（有 dot 和 arrow 两种） 成员存取操作符 
member function 成员函式 成员函数 
member initialization list 
成员初值列 成员初始值列表 
memberwise 以 member 为单元┅、members 逐一┅ 以成员为单位 
memberwise copy 以 members 为单元逐一复制 
memory 记忆体 内存 
menu 表单、选单 菜单 
message 讯息 消息 
message based 以讯息为基础的 基於消息的 
message loop 讯息回圈 消息环 
method (java) 方法、行为、函式 方法 
meta－ 超－ 元－ 
例 meta－programming 超编程 元编程 
micro 微 微 
middleware 中介层 中间件 
modeling 模塑 
modeling language 塑模语言，建模语言 
modem 数据机 调制解调器 
module 模组 模块 
modifier 饰词 修饰符 
most derived class 最末层衍生类别 最底层的派生类 
mouse 滑鼠 鼠标 
mutable 可变的 可变的 
multi－tasking 多工 多任务 
namespace 命名空间 名字空间、命名空间 
native 原生的 本地的、固有的 
nested class 巢状类别 嵌套类 
network 网路 网络 
network card 网路卡 网卡 
object 物件 对象 
object based 以物件为基础的 基於对象的 
object file 目的档 目标文件 
object model 物件模型 对象模型 
object oriented 物件导向的 面向对象的 
online 线上 在线 
opaque 不透明的 
operand 运算元 操作数 
operating system (OS) 作业系统 操作系统 
operation 操作、操作行为 操作 
operator 运算子 操作符、运算符 
option 选项，可选方案 选项 
ordinary 常规的 常规的 
overflow 上限溢位（相对於 underflow） 溢出（underflow:下溢） 
overhead 额外负担、额外开销 额外开销 
overload 多载化、多载化、重载 重载 
overloaded function 多载化函式 重载的函数 
overloaded operator 多载化运算子 被重载的操作符 
overloaded set 多载集合 重载集合 
override 改写、覆写 重载、改写、重新定义 
（在 derived class 中重新定义虚拟函式 
package 套件 包 
pair 对组 
palette 调色盘、组件盘、工具箱 
pane 窗格 窗格 
（有时为嵌板之意，例 Java Content Pane） 
parallel 平行 并行 
parameter 叁数（函式叁数列上的变数） 叁数、形式叁数、形叁 
parameter list 叁数列 叁数列表 
parent class 父类别（或称 base class） 父类 
parentheses 小括弧、小括号 圆括弧、圆括号 
parse 解析 解析 
part 零件 部件 
partial specialization 偏特化（ref. C++ Primer 3/e, 16.10） 局部特化 
（ref. full specialization） 
pass by address 传址（函式引数的传递方式）（非正式用语）传地址 
pass by reference 传址（函式引数的一种传递方式） 传地址, 按引用传递 
pass by value 传值（函式引数的一种传递方式） 按值传递 
pattern 范式、样式 模式 
performance 效率、性能兼而有之 性能 
persistence 永续性 持久性 
pixel 图素、像素 像素 
placement delete ref. C++ Primer 3/e, 15.8.2 
placement new ref. C++ Primer 3/e, 15.8.2 
platform 平台 平台 
pointer 指标 指针 
址位器（和址叁器 reference 形成对映，满好） 
poll 轮询 轮询 
polymorphism 多型 多态 
pop up 冒起式、弹出式 弹出式 
port 埠 端口 
postfix 后置式、后序式 后置式 
precedence 优先序（通常用於运算子的优先执行次序） 
prefix 前置式、前序式 前置式 
preprocessor 前处理器 预处理器 
prime 质数 素数 
primitive type 基本型别 (不同於 base class,基础类别) 
print 列印 打印 
printer 印表机 打印机 
priority 优先权 (通常用於执行绪获得 CPU 时间的优先次序） 
procedure 程序 过程 
procedural 程序性的、程序式的 过程式的、过程化的 
process 行程 进程 
profile 评测 评测 
profiler 效能（效率）评测器 效能（性能）评测器 
programmer 程式员 程序员 
programming 编程、程式设计、程式化 编程 
progress bar 进度指示器 进度指示器 
project 专案 项目、工程 
property 属性 
protocol 协定 协议 
pseudo code 假码、虚拟码、伪码 伪码 
qualified 经过资格修饰（例如加上 scope 运算子） 限定 
qualifier 资格修饰词、饰词 限定修饰词 
quality 品质 质量 
queue 伫列 队列 
radian 径度 弧度 
radio button 圆钮 单选按钮 
raise 引发（常用来表示发出一个 exception） 引起、引发 
random number 随机数、乱数 随机数 
range 范围、区间（用於 STL 时） 范围、区间 
rank 等级、分等（ref. C++Primer 3/e 9,15章） 等级 
raw 生鲜的、未经处理的 未经处理的 
record 记录 记录 
recordset 记录集 记录集 
recursive 递回 递归 
re－direction 重导向 重定向 
refactoring 重构、重整 重构 
refer 取用 叁考 
refer to 指向、指涉、指代 
reference （C++ 中类似指标的东西，相当於 "化身"） 引用、叁考 
址叁器, see pointer 
register 暂存器 寄存器 
reflection 反射 反射、映像 
relational database 关联式资料库 关系数据库 
represent 表述，表现 表述，表现 
resolve 决议（为算式中的符号名称寻找 解析 
对应之宣告式的过程） 
resolution 决议程序、决议过程 解析过程 
resolution 解析度 分辨率 
restriction 局限 
return 传回、回返 返回 
return type 回返型别 返回类型 
return value 回返值 返回值 
robust 强固、稳健 健壮 
robustness 强固性、稳健性 健壮性 
routine 常式 例程 
runtime 执行期 运行期、运行时 
common language runtime (CLR) 译为「通用语言执行层」 
rvalue 右值 右值 
save 储存 存储 
schedule 排程 调度 
scheduler 排程器 调度程序 
scheme 结构纲目、组织纲目 
scroll bar 卷轴 滚动条 
scope 生存空间、生存范围、范畴、作用域 生存空间 
scope operator 生存空间（范围决议）运算子 :: 生存空间操作符 
scope resolution operator 
生存空间决议运算子 生存空间解析操作符 
（与scope operator同） 
screen 萤幕 屏幕 
search 搜寻 查找 
semantics 语意 语义 
sequential container 序列式容器 顺序式容器 
（对应於 associative container） 
server 伺服器、伺服端 服务器、服务端 
serial 串行 
serialization 次第读写,序列化 序列化 
(serialize) 
setter (相对於 getter) 设值函式 
signal 信号 
signature 标记式、签名式、署名式 签名 
slider 滚轴 滑块 
slot 条孔、槽 槽 
smart pointer 灵巧指标、精灵指标 智能指针 
snapshot 萤幕快照（图） 屏幕截图 
specialization 特殊化、特殊化定义、特殊化宣告 特化 
specification 规格 规格、规范 
splitter 分裂视窗 切分窗口 
software 软体 软件 
solution 解法,解决方案 方案 
source 原始码 源码、源代码 
stack 堆叠 栈 
stack unwinding 堆叠辗转开解（此词用於 exception 主题） 栈辗转开解 * 
standard library 标准程式库 
standard template library 标准模板程式库 
statement 述句 语句、声明 
status bar 状态列、状态栏 状态条 
STL 见 standard template library 
stream 资料流、串流 流 
string 字串 字符串 
subroutine 
subscript operator 下标运算子 [ ] 下标操作符 
subtype 子型别 子类型 
support 支援 支持 
suspend 虚悬 挂起 
symbol 符号 记号 
syntax 语法 语法 
tag 标签 标记 
索引标签,页签 
target 标的（例 target pointer：标的指标） 目标 
task switch 工作切换 任务切换 
template 模板、范本 模板 
template argument deduction 
模板引数推导 模板叁数推导 
template explicit specialization 
模板显式特化（版本） 模板显式特化 
template parameter 模板叁数 模板叁数 
temporary object 暂时物件 临时对象 
text 文字 文本
}

write(int c) 方法demo
可以查看DataOutput /DataInput 的接口文档
{
	
	
	FileOutputStream fos1 = new FileOutputStream("E:/abc1.txt");
for (int x = 1; x < 512; x += 1) {

	fos1.write(x);
	//接口文档中描述 : write(int c) 写入单个字符  意思是写入 c的byte   ANSI码  >>文件以ANSI 编码打开可以看到部分是 特殊字符、a-z、A-Z、0-9、一些超过ANSI的乱码， 循环上面的规律
	//System.out.println(x);
	//JAVA里给int类型分配4个字节的存储空间，相当于32位二进制数，8个低位就是b的右边8位，24个高位也就是左边24位。你看十进制，从右到左是个十百千万，越右边的位权值越小，所以叫低位。二进制也是同理。
}
fos1.write(65); //A
fos1.write(97); //a   	
fos1.write(65+127); //A
fos1.write((byte)65); //A
fos1.write((byte)97); //a

fos1.write("B".getBytes()); //66
fos1.write("b".getBytes()); //98
fos1.close();

FileInputStream fos2 = new FileInputStream("E:/abc1.txt");
for (int x =1 ;x <512+10 ;x+=1){
	System.out.println(fos2.read());  //最后是 :65 97 192 65 97 66 98 -1 -1
}
fos2.close();


}

//java中String,int,Integer,char 类型转换  string是桥梁 exchange
{
	//如何将字串 String 转换成整数 int? 
	int i = Integer.valueOf("555555555").intValue();
	int i1=Integer.parseInt("666666666");
	System.out.println("转换后:"+i+i1);
	
	//如何将整数 int 转换成字串 String ? 
	String s = String.valueOf(i);
	String s1 = Integer.toString(i); 
	String s2 = "" + i;
	System.out.println("转换后:"+s+s1+s2);
	
	//如何将 String 转换成 char[] ?
	char[] ca="123".toCharArray();
	System.out.println(ca);

	//如何将char[]转换成String?
	Arrays.toString(ca);
	System.out.println(Arrays.toString(ca));

	//将char转换为String？
	char a = 's';
	String str = String.valueOf(a);
	System.out.println(str);
	
	//如何将整数 int 转换成 Integer ? 
	Integer integer=new Integer(6666);

	//如何将Integer 转换成 int ? 
	int num=integer.intValue();
	System.out.println("转换后:"+num);

	//如何将字串 String 转换成Integer ?
	Integer integer1=Integer.valueOf("22");//"9999999"不行，需要后学习
			
	//如何将Integer 转换成字串 String ? 
	Integer integer2=new Integer(integer1);
	String s3 = integer2.toString();
	System.out.println(s3);

}

char 读写和编码的实例
{
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.Arrays;


public class Char_read_write {

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		filewriter_text();
		System.out.println("========这是一个分隔符！=========1");
		filereader_test();
		System.out.println("========这是一个分隔符！=========2");
		exchange();
		System.out.println("========这是一个分隔符！=========3");
		write1();
		System.out.println("========这是一个分隔符！=========4");
		read1();
		System.out.println("========这是一个分隔符！=========5");
		read_wirte_charsetName();
		System.out.println("========这是一个分隔符！=========6");
	}

	
	public static void filewriter_text() throws IOException {
		
		FileWriter write1=new FileWriter("E:\\read1.txt");
		//write1.write(new char[]{1,2,3});
		//System.out.println(new char[]{1,2,3}); 输出乱码、其实是先把int转成了char再写入的  System.out.println((char)1);	
		write1.write(65);
		write1.write('a');
		write1.write(new char[]{'1','2','3'});
		write1.write(999999999);
		write1.write(65);
		write1.write("这是一个字符串测试！");
		System.out.println("默认使用的字符编码是:"+write1.getEncoding());
		write1.close();
		
	}	
	public static void filereader_test() throws IOException{
		FileReader read1=new FileReader("E:\\read1.txt");
		System.out.println(read1.read()); //65
		System.out.println(read1.read()); //97
		char[] char_read=new char[20];
		int get=0;
		get=read1.read(char_read);
		System.out.println("读取的字符总数:"+get);
		System.out.println(char_read);  //直接打印 999999999 和 65 打印不出来，65会变成A //读出65然后转换成char
		System.out.println("默认使用的字符编码是:"+read1.getEncoding());		
		read1.close();
		
	}
	
	public static void exchange() throws UnsupportedEncodingException {
		
		//如何将字串 String 转换成整数 int? 
		int i = Integer.valueOf("555555555").intValue();
		int i1=Integer.parseInt("666666666");
		System.out.println("转换后:"+i+i1);
		
		//如何将整数 int 转换成字串 String ? 
		String s = String.valueOf(i);
		String s1 = Integer.toString(i); 
		String s2 = "" + i;
		System.out.println("转换后:"+s+s1+s2);
		
		//如何将 String 转换成 char[] ?
		char[] ca="123".toCharArray();
		System.out.println(ca);

		//如何将char[]转换成String?
		Arrays.toString(ca);
		System.out.println(Arrays.toString(ca));

		//将char转换为String？
		char a = 's';
		String str = String.valueOf(a);
		System.out.println(str);
		
		//如何将整数 int 转换成 Integer ? 
		Integer integer=new Integer(6666);

		//如何将Integer 转换成 int ? 
		int num=integer.intValue();
		System.out.println("转换后:"+num);

		//如何将字串 String 转换成Integer ?
		Integer integer1=Integer.valueOf("22");//"9999999"不行，需要后学习
				
		//如何将Integer 转换成字串 String ? 
		Integer integer2=new Integer(integer1);
		String s3 = integer2.toString();
		System.out.println(s3);
		
		//char 互转  int
		System.out.println((char)65);
		int num1 = 8;
		char ch1 = (char) (num1 + 48);//利用char的unicode编码
		System.out.println("ch1 = " + ch1);  // 将char类型数字8转换为int类型数字8
		
		Character ch2 = '8'; // char是基本数据类型，Character是其包装类型。
		int num2 = Integer.parseInt(ch2.toString());
		System.out.println("num2 = " + num2);
		char b='9';
		//char c='99'; //'99'算啥？不算单个字符！？
		int bint=Integer.parseInt(b+"");
		System.out.println(bint);
		//char q[]="abc";
		
		//java中各种类型的数据都可以相互转换，作为一个String类型的数据串，常常需要char型转到int型。
		//java内部使用Unicode编码大概和ASCAII 差不多，所以可以做以下操作：
		String str1 = "123456";		
		for (int j=0;j<str1.length();j++){
			int i11 = str1.charAt(j) - '0';  //即减去0的编码即为相对应int值，和汇编输入值后计算其数值相似。
			System.out.print(i11);
		}
		
		for (int j=0;j<str1.length();j++){
			int i22 = str1.charAt(j)  - 48; //原理同上
			System.out.print(i22);
		}
		
		for (int j=0;j<str1.length();j++){
			int i33 = Character.getNumericValue(str1.charAt(j)); //原理同上
			System.out.print(i33);
		}
					
		String chnStr = "华";  
	    System.out.println("length of one Chinese character in gbk: " + chnStr.getBytes("GBK").length );  
	    System.out.println("length of one Chinese character in UTF-8: " + chnStr.getBytes("UTF-8").length );  
	    System.out.println("length of one Chinese character in Unicode: " + chnStr.getBytes("UNICODE").length ); 
	    
	    // int[] arr = new int[3]{1,2,3}; 这样定义是不允许的，不能在给定初始值的同时还给定长度
	    //http://www.cnblogs.com/swiftma/p/5434387.html 讲char的
	    //char本质上是一个固定占用两个字节的无符号正整数，这个正整数对应于Unicode编号，用于表示那个Unicode编号对应的字符。
	    //由于固定占用两个字节，char只能表示Unicode编号在65536以内的字符，而不能表示超出范围的字符。
	    

	}
	
	//将键盘录入转成大写后输出到一个文件中的例子  
	//字符方式的读写文件，支持中文、特殊字符、英文
    public static void write1() throws IOException {
        BufferedReader bufr = new BufferedReader(new InputStreamReader(
                System.in));
        BufferedWriter bufw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("E://读写测试文件.txt")));
        String line = null;
        while ((line = bufr.readLine()) != null) {
            if ("over".equals(line))
                break;
            bufw.write(line.toUpperCase());
            bufw.newLine();
        }
        bufr.close();
        bufw.close();
    }

  //字符方式的读写文件，支持中文、特殊字符、英文
	public static void read1() throws IOException{
		//两种查看系统默认编码的方式！
		Charset cs=Charset.defaultCharset();
		System.out.println(cs);
		System.out.println(System.getProperty("file.encoding"));
		
		BufferedReader bufr =new BufferedReader(new FileReader("E://读写测试文件.txt"));
		String line = null;
		while ((line=bufr.readLine())!=null) {
			System.out.println(line);		
		}
		bufr.close();
				
	}
	
	public static void read_wirte_charsetName() throws IOException {
		
		//指定字符集读写文件！
		String filePath="E://读写测试文件2.txt";		
		String charsetName="utf8";
		String line = null;
		
		//从键盘键入内容
		 System.out.println("现在请写入点什么,以over结束！");
		 BufferedReader bufr1 = new BufferedReader(new InputStreamReader(System.in));		
		//写文件:
		 OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream(filePath), charsetName);
		//读上面写好的文件:
		 InputStreamReader isr = new InputStreamReader(new FileInputStream(filePath), charsetName);
		 System.out.println("现在适用的编码是:"+isr.getEncoding());
		 while ((line = bufr1.readLine()) != null) {
	            if ("over".equals(line))
	                break;
	            osw.write(line);
	            osw.write("\r\n");
	        }
		 bufr1.close();
		 osw.close();
		 
		 //char[] readchar=new char[10];	 
		 //while (isr.read(readchar)!= -1) {  //这种读法最后的数组会多出来数据而且数据不会和输入格式一样，不适用
		//	 System.out.println(readchar);
		 //}
		 //必须通过包装
		 BufferedReader  isrbuf=new BufferedReader(isr);
		 String newline;
		 while ((newline=isrbuf.readLine())!=null) {
			 System.out.println(newline);
		}		 
		 isr.close();		
		}

}
}
常用的文件和文件操作
{
一.获得控制台用户输入的信息

     public String getInputMessage() throws IOException...{
         System.out.println("请输入您的命令∶");
         byte buffer[]=new byte[1024];
         int count=System.in.read(buffer);
         char[] ch=new char[count-2];//最后两位为结束符，删去不要
         for(int i=0;i<count-2;i++)
             ch[i]=(char)buffer[i];
         String str=new String(ch);
         return str;
     }
     可以返回用户输入的信息，不足之处在于不支持中文输入，有待进一步改进。

二.复制文件
     1.以文件流的方式复制文件

     public void copyFile(String src,String dest) throws IOException...{
         FileInputStream in=new FileInputStream(src);
         File file=new File(dest);
         if(!file.exists())
             file.createNewFile();
         FileOutputStream out=new FileOutputStream(file);
         int c;
         byte buffer[]=new byte[1024];
         while((c=in.read(buffer))!=-1)...{
             for(int i=0;i<c;i++)
                 out.write(buffer[i]);        
         }
         in.close();
         out.close();
     }
     该方法经过测试，支持中文处理，并且可以复制多种类型，比如txt，xml，jpg，doc等多种格式

三.写文件

     1.利用PrintStream写文件


     public void PrintStreamDemo()...{
         try ...{
             FileOutputStream out=new FileOutputStream("D:/test.txt");
             PrintStream p=new PrintStream(out);
             for(int i=0;i<10;i++)
                 p.println("This is "+i+" line");
         } catch (FileNotFoundException e) ...{
             e.printStackTrace();
         }
     }
     2.利用StringBuffer写文件
public void StringBufferDemo() throws IOException......{
         File file=new File("/root/sms.log");
         if(!file.exists())
             file.createNewFile();
         FileOutputStream out=new FileOutputStream(file,true);        
         for(int i=0;i<10000;i++)......{
             StringBuffer sb=new StringBuffer();
             sb.append("这是第"+i+"行:前面介绍的各种方法都不关用,为什么总是奇怪的问题 ");
             out.write(sb.toString().getBytes("utf-8"));
         }        
         out.close();
     }
     该方法可以设定使用何种编码，有效解决中文问题。
四.文件重命名
    
     public void renameFile(String path,String oldname,String newname)...{
         if(!oldname.equals(newname))...{//新的文件名和以前文件名不同时,才有必要进行重命名
             File oldfile=new File(path+"/"+oldname);
             File newfile=new File(path+"/"+newname);
             if(newfile.exists())//若在该目录下已经有一个文件和新文件名相同，则不允许重命名
                 System.out.println(newname+"已经存在！");
             else...{
                 oldfile.renameTo(newfile);
             }
         }         
     }

 五.转移文件目录
     转移文件目录不等同于复制文件，复制文件是复制后两个目录都存在该文件，而转移文件目录则是转移后，只有新目录中存在该文件。
    
     public void changeDirectory(String filename,String oldpath,String newpath,boolean cover)...{
         if(!oldpath.equals(newpath))...{
             File oldfile=new File(oldpath+"/"+filename);
             File newfile=new File(newpath+"/"+filename);
             if(newfile.exists())...{//若在待转移目录下，已经存在待转移文件
                 if(cover)//覆盖
                     oldfile.renameTo(newfile);
                 else
                     System.out.println("在新目录下已经存在："+filename);
             }
             else...{
                 oldfile.renameTo(newfile);
             }
         }       
     }
	 
六.读文件
     1.利用FileInputStream读取文件
    
     public String FileInputStreamDemo(String path) throws IOException...{
         File file=new File(path);
         if(!file.exists()||file.isDirectory())
             throw new FileNotFoundException();
         FileInputStream fis=new FileInputStream(file);
         byte[] buf = new byte[1024];
         StringBuffer sb=new StringBuffer();
         while((fis.read(buf))!=-1)...{
             sb.append(new String(buf));    
             buf=new byte[1024];//重新生成，避免和上次读取的数据重复
         }
         return sb.toString();
     }
2.利用BufferedReader读取

     在IO操作，利用BufferedReader和BufferedWriter效率会更高一点


    
     public String BufferedReaderDemo(String path) throws IOException...{
         File file=new File(path);
         if(!file.exists()||file.isDirectory())
             throw new FileNotFoundException();
         BufferedReader br=new BufferedReader(new FileReader(file));
         String temp=null;
         StringBuffer sb=new StringBuffer();
         temp=br.readLine();
         while(temp!=null)...{
             sb.append(temp+" ");
             temp=br.readLine();
         }
         return sb.toString();
     }


     3.利用dom4j读取xml文件

    
     public Document readXml(String path) throws DocumentException, IOException...{
         File file=new File(path);
         BufferedReader bufferedreader = new BufferedReader(new FileReader(file));
         SAXReader saxreader = new SAXReader();
         Document document = (Document)saxreader.read(bufferedreader);
         bufferedreader.close();
         return document;
     }
	 
七.创建文件(文件夹)


1.创建文件夹  
     public void createDir(String path)...{
         File dir=new File(path);
         if(!dir.exists())
             dir.mkdir();
     }
2.创建新文件
     public void createFile(String path,String filename) throws IOException...{
         File file=new File(path+"/"+filename);
         if(!file.exists())
             file.createNewFile();
     }
     八.删除文件(目录)
1.删除文件     
     public void delFile(String path,String filename)...{
         File file=new File(path+"/"+filename);
         if(file.exists()&&file.isFile())
             file.delete();
     }
2.删除目录
要利用File类的delete()方法删除目录时，必须保证该目录下没有文件或者子目录，否则删除失败，因此在实际应用中，我们要删除目录，必须利用递归删除该目录下的所有子目录和文件，然后再删除该目录。  
     public void delDir(String path)...{
         File dir=new File(path);
         if(dir.exists())...{
             File[] tmp=dir.listFiles();
             for(int i=0;i<tmp.length;i++)...{
                 if(tmp[i].isDirectory())...{
                     delDir(path+"/"+tmp[i].getName());
                 }
                 else...{
                     tmp[i].delete();
                 }
             }
             dir.delete();
         }
     }	
	
	
}

文件编码识别：
http://www.cnblogs.com/preacher/p/6084802.html

//定时器
{
	
package com.lid;  
  
import java.util.Calendar;  
import java.util.Date;  
import java.util.Timer;  
import java.util.TimerTask;  
  
public class Test {  
    public static void main(String[] args) {  
        //timer1();  
        timer2();  
        //timer3();  
        //timer4();  
    }  
  
    // 第一种方法：设定指定任务task在指定时间time执行 schedule(TimerTask task, Date time)  
    public static void timer1() {  
        Timer timer = new Timer();  
        timer.schedule(new TimerTask() {  
            public void run() {  
                System.out.println("-------设定要指定任务--------");  
            }  
        }, 2000);// 设定指定的时间time,此处为2000毫秒  
    }  
  
    // 第二种方法：设定指定任务task在指定延迟delay后进行固定延迟peroid的执行  
    // schedule(TimerTask task, long delay, long period)  
    public static void timer2() {  
        Timer timer = new Timer();  
        timer.schedule(new TimerTask() {  
            public void run() {  
                System.out.println("-------设定要指定任务--------");  
            }  
        }, 1000, 1000);  
    }  
  
    // 第三种方法：设定指定任务task在指定延迟delay后进行固定频率peroid的执行。  
    // scheduleAtFixedRate(TimerTask task, long delay, long period)  
    public static void timer3() {  
        Timer timer = new Timer();  
        timer.scheduleAtFixedRate(new TimerTask() {  
            public void run() {  
                System.out.println("-------设定要指定任务--------");  
            }  
        }, 1000, 2000);  
    }  
     
    // 第四种方法：安排指定的任务task在指定的时间firstTime开始进行重复的固定速率period执行．  
    // Timer.scheduleAtFixedRate(TimerTask task,Date firstTime,long period)  
    public static void timer4() {  
        Calendar calendar = Calendar.getInstance();  
        calendar.set(Calendar.HOUR_OF_DAY, 12); // 控制时  
        calendar.set(Calendar.MINUTE, 0);       // 控制分  
        calendar.set(Calendar.SECOND, 0);       // 控制秒  
  
        Date time = calendar.getTime();         // 得出执行任务的时间,此处为今天的12：00：00  
  
        Timer timer = new Timer();  
        timer.scheduleAtFixedRate(new TimerTask() {  
            public void run() {  
                System.out.println("-------设定要指定任务--------");  
            }  
        }, time, 1000 * 60 * 60 * 24);// 这里设定将延时每天固定执行  
    }  
}

}


















