//字符串和Int互转的方法，主要是java中的源码分析。
public class str_int {
//码表
	final static char [] DigitTens = {
		'0', '0', '0', '0', '0', '0', '0', '0', '0', '0',
		'1', '1', '1', '1', '1', '1', '1', '1', '1', '1',
		'2', '2', '2', '2', '2', '2', '2', '2', '2', '2',
		'3', '3', '3', '3', '3', '3', '3', '3', '3', '3',
		'4', '4', '4', '4', '4', '4', '4', '4', '4', '4',
		'5', '5', '5', '5', '5', '5', '5', '5', '5', '5',
		'6', '6', '6', '6', '6', '6', '6', '6', '6', '6',
		'7', '7', '7', '7', '7', '7', '7', '7', '7', '7',
		'8', '8', '8', '8', '8', '8', '8', '8', '8', '8',
		'9', '9', '9', '9', '9', '9', '9', '9', '9', '9',
		} ; 

	    final static char [] DigitOnes = { 
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		} ;
	    final static char[] digits = {
	    	'0' , '1' , '2' , '3' , '4' , '5' ,
	    	'6' , '7' , '8' , '9' , 'a' , 'b' ,
	    	'c' , 'd' , 'e' , 'f' , 'g' , 'h' ,
	    	'i' , 'j' , 'k' , 'l' , 'm' , 'n' ,
	    	'o' , 'p' , 'q' , 'r' , 's' , 't' ,
	    	'u' , 'v' , 'w' , 'x' , 'y' , 'z'
	        };
	    final static int [] sizeTable = { 9, 99, 999, 9999, 99999, 999999, 9999999,
            99999999, 999999999, Integer.MAX_VALUE };

		// Requires positive x
	static int stringSize(int x) {
		for (int i=0; ; i++)
		if (x <= sizeTable[i])
		return i+1;
		}
		
//将int转化为string
	public static String toString(int i) {
	    if (i == Integer.MIN_VALUE)
	        return "-2147483648";
	    int size = (i < 0) ? stringSize(-i) + 1 : stringSize(i);
	    char[] buf = new char[size];
	    getChars(i, size, buf);
	    //return new String(0, size, buf);
	    return new String(buf);
	}
//将int 以10进制转化为char[]
	static void getChars(int i, int index, char[] buf) {
	    int q, r;
	    int charPos = index;
	    char sign = 0;

	    if (i < 0) { 
	        sign = '-';
	        i = -i;
	    }

	    // Generate two digits per iteration
	    while (i >= 65536) {
	    	
	        q = i / 100;
	        System.out.println(q);
	        // really: r = i - (q * 100);
	        r = i - ((q << 6) + (q << 5) + (q << 2));
	        System.out.println("======");
	        System.out.println((q << 6) + (q << 5) + (q << 2));
	        System.out.println(r);
	        //上面的几步就是为了取余数   r=i%100;
	        //r=i%100;
	        i = q;
	        //System.out.println(22224%1000);
	        buf [--charPos] = DigitOnes[r];
	        buf [--charPos] = DigitTens[r];
	        System.out.println("======");
	        System.out.print(buf[charPos]);
	        System.out.println(buf[charPos+1]);
	        System.out.println("======");
	    }

	    // Fall thru to fast mode for smaller numbers
	    // assert(i <= 65536, i);
	    for (;;) { 
	        q = (i * 52429) >>> (16+3);
	        r = i - ((q << 3) + (q << 1));  // r = i-(q*10) ...
	        System.out.println("########");
	        System.out.println(r);
	        buf [--charPos] = digits [r];
	        System.out.println("########");
	        i = q;
	        if (i == 0) break;
	    }
	    if (sign != 0) {
	        buf [--charPos] = sign;
	    }
	}
	//通用的将int 按 radix进制 转化为string，思路是int 除以 radix进制 取余数和商，将余数作为digits中的索引得到对应的char
    public static String toString(int i, int radix) {
    	
    if (radix < Character.MIN_RADIX || radix > Character.MAX_RADIX)
    radix = 10;
    //直接使用toString(int i)
	if (radix == 10) {
	    return toString(i);
	}
    
	char buf[] = new char[33];
	boolean negative = (i < 0);
	int charPos = 32;

	if (!negative) {
	    i = -i;
	}

	while (i <= -radix) {
	    buf[charPos--] = digits[-(i % radix)];
	    i = i / radix;
	}
	buf[charPos] = digits[-i];

	if (negative) {
	    buf[--charPos] = '-';
	}

	return new String(buf, charPos, (33 - charPos));
    }
    
    //string转int
	public static int parseInt(String s, int radix)
		
	{
	    if (s == null) {
	        throw new NumberFormatException("null");
	    }
	
	if (radix < Character.MIN_RADIX) {
	    throw new NumberFormatException("radix " + radix +
					    " less than Character.MIN_RADIX");
	}
	
	if (radix > Character.MAX_RADIX) {
	    throw new NumberFormatException("radix " + radix +
					    " greater than Character.MAX_RADIX");
	}
	///以上为基本的大小判断，防止溢出
	
	int result = 0;
	boolean negative = false;//负数
	int i = 0, max = s.length();
	int limit;
	int multmin;
	int digit;
	
	if (max > 0) {
	    if (s.charAt(0) == '-') {//第一个位置是否为- 判断正负
		negative = true; //是负数
		limit = Integer.MIN_VALUE; //设置数字的下限
		i++;
	    } else {
		limit = -Integer.MAX_VALUE; //将正数转为负数 ？
	    }
	    multmin = limit / radix; //？？？ 最小负数/进制 =
	    System.out.print("multmin:");
	    System.out.println(multmin);
	    
	    if (i < max) {
		digit = Character.digit(s.charAt(i++),radix); //判断i++位置的字符是否可以转为int，返回指定基数中字符ch的数值，如果ch的值不是指定基数中的有效数字，则返回-1
		//统一成负数处理，最后再改符号
		if (digit < 0) {
		    System.out.println("不是指定基数中的有效数字");//防止第一个有效位不是数字
		} else {
		    result = -digit;//为什么要转成负数？
		}
	    }
	    
	    while (i < max) {//遍历字符串，查找每个位置上的元素符不符合进制范围
		// Accumulating negatively avoids surprises near MAX_VALUE
		digit = Character.digit(s.charAt(i++),radix);//如果ch的值不是指定基数中的有效数字，则返回-1
		if (digit < 0) {
			System.out.println("不是指定基数中的有效数字");//防止第  i 个有效位不是数字
		}
		
		System.out.print("result:");
	    System.out.println(result);
	    /*multmin:-214748364
		result:-4
		result:-41
		result:-412
		result:-4123
		result:-41230
	     */
	  //下面这两步做什么的？？
		if (result < multmin) {
			System.out.println("溢出");
		}
		result *= radix;//进一位
		if (result < limit + digit) {
			System.out.println("溢出");
		}
		result -= digit;//将高位和i位置上已经转化好的int 相减
	    }
	} else {
		System.out.println("字符串长度不符合要求！");
	}
	//处理最后的符号
	if (negative) {    
		return result;
	} else {
	    return -result;
	}
	}    
 
    
	public static void main(String[] args) {
		System.out.println(toString(335345));
        System.out.println("======1");
        System.out.println(toString(-335345,10));
        System.out.println(toString(-335345,2));
        System.out.println(toString(-335345,16));
        System.out.println((int)23);
        System.out.println("======2");
        System.out.println(Integer.parseInt("11111", 2));
        System.out.println("======3");
        System.out.println(parseInt("-412300", 10));
        System.out.println("======5");
        //System.out.println(Integer.toString(335345,116));
        System.out.println(Character.digit((int)'a', 10));//如果ch的值不是指定基数中的有效数字，则返回-1
        System.out.println("======4");
        System.out.println(Character.digit('8', 10));//8是10进制中有效的数字，返回8
        System.out.println("======6");
        char[] a=new char[]{'A','a','b','c'};
        System.out.println(Character.codePointAt(a,0));//返回 char 数组的给定索引上的Unicode的数值
        System.out.println(Character.codePointAt(a,1));
	}
}

#用Hashcat每秒计算1.4亿个密码，破解隔壁WIFI密码
http://www.cnblogs.com/diligenceday/p/6359661.html
#详解google Chrome浏览器（理论篇）
http://www.cnblogs.com/wangjiming/archive/2017/01/31/6357306.html
#python paramiko
http://www.cnblogs.com/starof/p/4670433.html
#micropython
http://www.cnblogs.com/xiaowuyi/p/6306181.html
#redis使用
http://www.cnblogs.com/0zcl/p/6368938.html
