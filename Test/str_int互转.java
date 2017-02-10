import javax.security.auth.x500.X500Principal;

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
/*	    
    class T {
        T data;
        public T (T data) {
            this.data = data;
        }
    }
	public  static void print(T ... args){
		for (int i = 0; i < args.length; i++) {
			System.out.println(args[i]);
		}
	}
*/
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
	
/////////////////////////////////////////////////	
    private static int getPlane(int ch) {
        return (ch >>> 16);
    }
    public static final int MIN_CODE_POINT = 0x000000;
    public static final int MAX_CODE_POINT = 0x10ffff;
    private static final int FAST_PATH_MAX = 255;
    
	public static int digit(int codePoint, int radix) {//53 ,2
        int digit = -1;

        if (codePoint >= 0 && codePoint <= 255) {
             //digit = CharacterDataLatin1.digit(codePoint, radix);
        	 digit = digit2(codePoint, radix);
        	 System.out.println("*****判定int是否在基数能表示的范围内，-1为不能表示*******");
        	 System.out.println("codePoint:"+codePoint+","+"radix:"+radix);
        	 System.out.println("digit:"+digit);
        } else {
            int plane = getPlane(codePoint);
            System.out.println("plane:");
            System.out.print(plane);
            /*
            switch(plane) {
            case(0):
                digit = CharacterData00.digit(codePoint, radix);
                break;
            case(1):
                digit = CharacterData01.digit(codePoint, radix);
                break;
            case(2):
                digit = CharacterData02.digit(codePoint, radix);
                break;
            case(3): // Undefined
            case(4): // Undefined
            case(5): // Undefined
            case(6): // Undefined
            case(7): // Undefined
            case(8): // Undefined
            case(9): // Undefined
            case(10): // Undefined
            case(11): // Undefined
            case(12): // Undefined
            case(13): // Undefined
                digit = CharacterDataUndefined.digit(codePoint, radix);
                break;
            case(14): 
                digit = CharacterData0E.digit(codePoint, radix);
                break;
            case(15): // Private Use
            case(16): // Private Use
                digit = CharacterDataPrivateUse.digit(codePoint, radix);
                break;
            default:
                // the argument's plane is invalid, and thus is an invalid codepoint
                // digit remains -1;
                break;
            }
            */
        }
        return digit;
    }
	
	
    public static final int MIN_RADIX = 2;
    public static final int MAX_RADIX = 36;
    public static final char   MIN_VALUE = '\u0000';
    
    static int digit2(int ch, int radix) {//53 ,2
        int value = -1;
        if (radix >= 2 && radix <= 36) {
            int val = getProperties(ch);
            System.out.println("val:"+val);
            int kind = val & 0x1F;
            System.out.println("kind:"+kind);
            if (kind == 9) {
                value = ch + ((val & 0x3E0) >> 5) & 0x1F;
                System.out.println("value:"+value);
            }
            else if ((val & 0xC00) == 0x00000C00) {
                // Java supradecimal digit
                value = (ch + ((val & 0x3E0) >> 5) & 0x1F) + 10;
            }
        }
        return (value < radix) ? value : -1;
    }
    static final int A[] = new int[256];

    static final String A_DATA =
      "\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800"+
      "\u100F\u4800\u100F\u4800\u100F\u5800\u400F\u5000\u400F\u5800\u400F\u6000\u400F"+
      "\u5000\u400F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800"+
      "\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F"+
      "\u4800\u100F\u4800\u100F\u5000\u400F\u5000\u400F\u5000\u400F\u5800\u400F\u6000"+
      "\u400C\u6800\030\u6800\030\u2800\030\u2800\u601A\u2800\030\u6800\030\u6800"+
      "\030\uE800\025\uE800\026\u6800\030\u2800\031\u3800\030\u2800\024\u3800\030"+
      "\u2000\030\u1800\u3609\u1800\u3609\u1800\u3609\u1800\u3609\u1800\u3609\u1800"+
      "\u3609\u1800\u3609\u1800\u3609\u1800\u3609\u1800\u3609\u3800\030\u6800\030"+
      "\uE800\031\u6800\031\uE800\031\u6800\030\u6800\030\202\u7FE1\202\u7FE1\202"+
      "\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1"+
      "\202\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1\202"+
      "\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1\202\u7FE1"+
      "\202\u7FE1\uE800\025\u6800\030\uE800\026\u6800\033\u6800\u5017\u6800\033\201"+
      "\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2"+
      "\201\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2\201"+
      "\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2\201\u7FE2"+
      "\201\u7FE2\201\u7FE2\201\u7FE2\uE800\025\u6800\031\uE800\026\u6800\031\u4800"+
      "\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u5000\u100F"+
      "\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800"+
      "\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F"+
      "\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800"+
      "\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F\u4800\u100F"+
      "\u3800\014\u6800\030\u2800\u601A\u2800\u601A\u2800\u601A\u2800\u601A\u6800"+
      "\034\u6800\034\u6800\033\u6800\034\000\u7002\uE800\035\u6800\031\u6800\u1010"+
      "\u6800\034\u6800\033\u2800\034\u2800\031\u1800\u060B\u1800\u060B\u6800\033"+
      "\u07FD\u7002\u6800\034\u6800\030\u6800\033\u1800\u050B\000\u7002\uE800\036"+
      "\u6800\u080B\u6800\u080B\u6800\u080B\u6800\030\202\u7001\202\u7001\202\u7001"+
      "\202\u7001\202\u7001\202\u7001\202\u7001\202\u7001\202\u7001\202\u7001\202"+
      "\u7001\202\u7001\202\u7001\202\u7001\202\u7001\202\u7001\202\u7001\202\u7001"+
      "\202\u7001\202\u7001\202\u7001\202\u7001\202\u7001\u6800\031\202\u7001\202"+
      "\u7001\202\u7001\202\u7001\202\u7001\202\u7001\202\u7001\u07FD\u7002\201\u7002"+
      "\201\u7002\201\u7002\201\u7002\201\u7002\201\u7002\201\u7002\201\u7002\201"+
      "\u7002\201\u7002\201\u7002\201\u7002\201\u7002\201\u7002\201\u7002\201\u7002"+
      "\201\u7002\201\u7002\201\u7002\201\u7002\201\u7002\201\u7002\201\u7002\u6800"+
      "\031\201\u7002\201\u7002\201\u7002\201\u7002\201\u7002\201\u7002\201\u7002"+
      "\u061D\u7002";

    // In all, the character property tables require 1024 bytes.

      static {
                  { // THIS CODE WAS AUTOMATICALLY CREATED BY GenerateCharacter:
              char[] data = A_DATA.toCharArray();
              for (int i = 0; i < data.length; i++) {
				System.out.println(data[i]);
			}
              assert (data.length == (256 * 2));
              int i = 0, j = 0;
              while (i < (256 * 2)) {
                  int entry = data[i++] << 16;
                  A[j++] = entry | data[i++];
              }
          }
                System.out.println("00000000000000000000");
                for (int i = 0; i < A.length; i++) {
                	System.out.println(A[i]);
					
				}  
                System.out.println("00000000000000000000");
      }
    static int getProperties(int ch) {
		char offset = (char)ch;
		System.out.println("offset:"+offset);
        int props = A[offset];
        System.out.println("从A中索引得到的值:");
        System.out.println("props:"+props);
        System.out.println("(char)props:"+(char)props);
        return props;
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
        System.out.println("----------------1");
        System.out.println((int)'5');
        System.out.println("----------------2");
        digit((char)'5',10);
        System.out.println("----------------3");
        
        
        for (int i = 0; i < str_int.A.length; i++) {
        	System.out.print((char)str_int.A[i] );	
		}
        System.out.println("----------------4");
        System.out.println("\u4800");
        
	}	
}

//Character 这个类水太深，暂时放着，搞不机敏

