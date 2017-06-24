<!-- ============================================盒子嵌套============================================== -->

<!doctype html>
<title>Flaskr</title>
<html>
<head>
<style type="text/css">
body     { font-family: sans-serif; background: #eee; }
h1       { color: yellow; }
h2       { color: rgba(120,20,85,0.7); }
h3       { color: rgba(0,20,85,0.7); }
a        { color: rgba(120,100,100,0.7); }

.page           { margin: 0cm ; width: 600px; border: 1px solid #ccc;
                  padding: 0.8em; background: white; }
.flash          { background: #CEE5F5; padding: 0.5em;
                  border: 1px solid #AACBE2; }
.flash1          { background: rgba(120,100,100,0.7); padding: 0.5em;
                  border: 1px solid #AACBE2; }
</style>
</head>

<body>
<div class="page">

  <h1>这里是一个大盒子</h1>

  <div class="metanav">
    <a href="{{ url_for('flaskr.login') }}">链接log in</a>
    <a href="{{ url_for('flaskr.logout') }}">链接log out</a>
  </div>

  <div class="flash">
    <h2>这里是一个中盒子</h2>
    这里是flash
    <div class="flash1">
    <h3>这里是一个小盒子</h3>
    这里是flash
    </div>
  </div>


</div>


</body>

}}}#由于用notepad++打开格式混乱，此处加括号方便查看
<!-- ============================================html基础============================================== -->
<!-- 摘自 http://www.cnblogs.com/suoning/p/5614372.html -->

1. <head>标签

    <title>
    <base/>
    <link/>（rel、href、type）
    <meta/>（http-equiv、name、content）

2. <body>标签

    块级标签 & 内联标签
    基本标签（<h1>~<h6>、<p>、<b> <strong>、<strike>、<u>、<em> <i>、<sup>、<sub>、<br>、<hr>、<div>、<span>）
    特殊符号（&gt;、&lt;、&nbsp;、&quot;、&copy;...）
    <a> 超链接标签(锚标签)（href、target、name）
    <img> 图形标签（src、title、alt、width、height、align）
    列表标签（<ul>、<ol>、<li>、<dl>、<dt>、<dd>）
    <table> 表格标签（<table> 、<caption> 、<tr>、<th>、<td>、<thead>、<tbody>、rowspan、colspan）
    <from> 表单标签（action、method、enctype、<input>、<textarea>、<select>、<label>、<fieldset>）

标签分为两部分: 开始标签<a> 和 结束标签</a>. 两个标签之间的部分 我们叫做标签体.
    有些标签功能比较简单.使用一个标签即可.这种标签叫做自闭和标签.例如: <br/><hr/><input/><img/>
    标签可以嵌套.但是不能交叉嵌套. <a><b></a></b>

标签的属性:

    通常是以键值对形式出现的. 例如 name="nick"
    属性只能出现在开始标签 或 自闭和标签中.
    属性名字全部小写. *属性值必须使用双引号或单引号包裹 例如 name="nick"
    如果属性值和属性名完全一样.直接写属性名即可. 例如 readonly

    如 <meta http-equiv="Content-Type" content="text/html ;charset=UTF-8"/>，meta的开始标签中定义了各个属性，记得最后的 /> 闭合

3. 块级标签 和 内联标签

    块级标签：<p><h1><table><ol><ul><form><div>
    内联标签：<a><input><img><sub><sup><textarea><span>

    block（块）元素的特点
    ① 总是在新行上开始；
    ② 高度，行高以及外边距和内边距都可控制；
    ③ 宽度缺省是它的容器的100%，除非设定一个宽度。
    ④ 它可以容纳内联元素和其他块元素

    inline（内联）元素的特点
    ① 和其他元素都在一行上；
    ② 高，行高及外边距和内边距不可改变；
    ③ 宽度就是它的文字或图片的宽度，不可改变
    ④ 内联元素只能容纳文本或者其他内联元素

    对行内元素，需要注意如下
    设置宽度width 无效。
    设置高度height 无效，可以通过line-height来设置。
    设置margin 只有左右margin有效，上下无效。
    设置padding 只有左右padding有效，上下则无效。注意元素范围是增大了，但是对元素周围的内容是没影响的。


4. 基本标签

    <h1>~<h6> 标题标签.
    <p>: 段落标签. 包裹的内容被换行.并且也上下内容之间有一行空白.
    　　　　style="text-indent: 2em"可以设置样式为首行缩进两个字符。
    　　　　<blockquote></blockquote>可以用来设置整个段落的缩进。
    <b> <strong>: 加粗标签.
    <strike>: 为文字加上一条中线.
    <u>: 文字下方加下划线.
    <em> <i>: 文字变成斜体.
    <sup>和<sub>: 上角标 和 下角标.
    <br>:换行.
    <hr>:水平线.
    <div>
            块级标签。块级标签常用于布局，行级标签常用语显示内容。
    　　    div的显示通常使用id或class来标识。id为唯一的标签标识，class为标签的类标识。
    　　    div的大小是由内容来决定的，默认情况下，高度由内容的高度决定，宽度适应屏幕。
    　　    可以容纳其他元素，是一个容器。
    <span>

5. <img> 图形标签

    行级标签，用来显示图片。
    重要属性有：src、title、alt、width、height、align。
        src  图片地址。
        title  鼠标悬浮在图片上的文字。
        alt  图片找不到时要替换的文字。如果图片资源使用的是外网资源，则不会显示要替换的文字。如果使用的是本网站的资源（相对路径给出），则找不到图片时会显示替换的文字，并保留图片设置的宽高结构。
        align  图片周围文字的垂直对齐情况。常用的属性值有：top（与图片的顶部对齐）、middle（与图片的中部对齐）、bottom（默认，与图片的底部对齐）。
        width  图片的宽
        height  图片的高 (宽高两个属性只用一个会自动等比缩放.)
    <img src="http://images.cnblogs.com/cnblogs_com/suoning/845162/o_ns.png" alt="图片加载失败。。。" title="The knife girl, kiss"/>


6. 列表标签　

    <ul> :无序列表标签
            <li>:列表中的每一项.
    <ol> :有序列表标签
            <li>:列表中的每一项.
        <li>主要的属性有：type、value两个:
    type指明项目的类型，属性值有：A，a，I，i，1，disc（实心圆），square（实心正方形），circle（空心圆）。
    value表示序号值从几开始。

    <dl> 定义列表
             <dt> 列表标题
             <dd> 列表项

    <ur>
        <li type="circle">A</li>
        <li type="1">B</li>
        <li type="1">C</li>
    </ur>
    <ol>
        <li value="3">3</li>
        <li>4</li>
    </ol>
    <dl>
        <dt><i>标题</i></dt>
        <dd>第一项</dd>
        <dd>第二项</dd>
        <dd>第三项</dd>
    </dl>


7. <table> 表格标签

    <table border="1" bgcolor=red cellspacing=5pex>
        <thead>
            <tr>
                <th>序号</th>
                <th>姓名</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>1.</th>
                <td>nick</td>
            </tr>
            <tr>
                <th>2.</th>
                <td>jenny</td>
            </tr>
        </tbody>
    </table>

    border:（表格边框）
    align（水平对齐方式）
    bgcolor（背景颜色）
    cellpadding（内边距，单元格与内容之间的距离）
    cellspacing（外边距，单元格的间距，设置为0时，表格变为实线表格）
    width（表格的宽度，可以用%或者像素，最好通过css来设置长宽）
    <caption>  表格的标题
    <tr>  表格的数据行，table row
             <th>  表格的表头名称，与<td>不同在于文字采用加粗居中的形式显示，table head cell
             <td>  单元格，用来显示表格内容，table data cell
    <thead>  表格头部，使结构更加分明
    <tbody>  表格主体部分，使结构更加分明
    rowspan  单元格竖跨多少行，作用在th或者td上
    colspan  单元格横跨多少列（即合并单元格），作用在th或者td上


8. <form>表单标签

    属性：action、method、enctype
    　　　　action  表单要提交的地址，用于处理表单的内容（一般是提交字典到后台的一个接口，这个接口是java写成的，提交到这个接口后后台就知道如何处理这些数据了）。
    　　　　method  提交的方法，默认是get方式提交。
                  get: 1.提交的键值对.放在地址栏中url后面. 2.安全性相对较差. 3.对提交内容的长度有限制.
                  post:1.提交的键值对不在地址栏. 2.安全性相对较高. 3.对提交内容的长度理论上无限制.
    　　　　enctype  对表单数据进行编码，默认都是要编码的。格式为：application/x-www-form-urlencoded（表单默认的编码格式，表单发送前对所有字符进行编码。编码规则：空格转换为“+”号，特殊符号转换为ASC HEX值）。提交普通的文本内容到服务器就可以采用这种默认的编码方式。当你需要提交的是一个文件时，编码就需要采用另一种格式：multipart/form-data（不对字符编码，文件上传时使用）。text/plain（是一种纯文本编码，空格转换为“+”号，但是不对特殊字符进行编码）

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
    </head>
    <body>
            <form action="https://www.baidu.com/s">
                <input type="text" name="wd">
                <input type="submit" value="百度一下">
            </form>
    </body>
    </html>


9. 表单元素
	9.1 <input> type 属性：
			text  文本框输入（默认text文本框类型）。
				autocomplete（自动完成输入的内容，要求表单元素要有name属性才有自动完成的效果，off表示自动完成不可用，on表示自动完成可用）
				disabled（设置或者获取控件的状态，默认是false即可用，等于true时不可用，不能输入内容）
	　　　　password  密码框。（以下属性text和password共有）
				size（指定表单元素的初始宽度。当type为text或password时，表单元素的大小以字符为单位，对于其他元素，宽度以像素为单位）
				maxlength（type为text或password时，表示输入的最大字符数），有利于防止sql的注入攻击
				readonly 只读.　
	　　　　　　placeholder 框内预置内容(灰色)，写上内容时才消失

			radio  单选按钮。属性：
				 name（将name的值设置为相同值，才表示一组数据，才能实现单选功能）
				 value（必须要写，提交到服务器的key值，实际开发过程中value一般是编号）
				 checked（是否被选中的状态）
			checkbox  复选框。
				 name（名字一定要一样一样的，才表示是一组数据，添加到同一value值列表提交到服务器）
				 value（必须要写，提交到服务器的key值，实际开发过程中value一般是编号）
				 checked（是否被选中的状态）
			file  文件域，上传文件（不同的浏览器表现形式不同）
	　　　　submit  提交按钮。用于提交表单。
	　　　　reset  重置按钮。清空表单的输入，恢复到表单默认的状态。
			button  普通按钮。一般结合javascript使用。
	　　　　image  图片按钮，用来提交表单，与submit是一样的效果。
				 src（图片路径）
	　　　　hidden  隐藏字段。
				 value（隐藏的内容）

	　　　　color  颜色标签。value指定颜色值（采用#十六进制数表示）。
	　　　　date  日期。value值指定默认的日期，格式为****-**-**（年月日）。
	　　　　datetime-local  显示本地时间，value值指定默认的时间，格式为2016-05-20T11:10:10（年月日T时分秒）。
	　　　　number  数字向上或者向下滑动。可以填数字然后向上或者向下选择不同的值。
	　　　　range  滑动标签。min（指定最小值）、max（指定最大值）、value（指定当前默认值）。
	　　　　week  每年的周数。value指定哪一年第几周，格式为2016-W25（2016年第25周）。

	9.2 <textarea> 文本域标签。默认表现形式是可以输入很多行文本的文本框。
			name （表单提交项的key）
	　　　　cols（设置文本域宽度）
			rows（设置文本域高度，即行数）

	9.3 <select> 下拉框标签。使用时要结合<option>子标签一起使用。
			name:表单提交项的key
			size：选项个数
			multiple：多选
			<option> 下拉选中的每一项
			value（表单提交项的值）
			selected（selected下拉选默认被选中）
				<optgroup>为每一项加上分组

	9.4 <label> 把元素与文本结合起来
			友好设计：不只是选中复选框才能选中并打钩，要求点击对应的文字也能选中该复选框。
			这种情况下要用到<label>标签的for属性（设置或获取给定标签对象指定到的对象，值=另一个元素的id号即可）

			<label for="name">姓名</label>
			<input id="name" type="text">

	9.5 value: 表单提交项的值

		对于不同的输入类型，value 属性的用法也不同：

		type="button", "reset", "submit" - 定义按钮上的显示的文本
		type="text", "password", "hidden" - 定义输入字段的初始值
		type="checkbox", "radio", "image" - 定义与输入相关联的值

<!-- ============================================css基础============================================== -->
<!-- 摘自http://www.cnblogs.com/suoning/p/5625582.html -->

#选择器（Selector）

一、基本选择器：

	1.通用元素选择器

		* 表示应用到所有的标签。
		* {color: yellow}
	2.标签选择器

		匹配所有使用 div 标签的元素（可以匹配所有标签）
		div {color: yellow}
	3.类选择器

		匹配所有class属性中包含info的元素。
		语法：.类名{样式}（类名不能以数字开头，类名要区分大小写。）
		.Mycolor {color: yellow}
		<h3 class="Mycolor">nick</h3>
	4.ID选择器

		使用id属性来调用样式，在一个网页中id的值都是唯一的（是W3C规范而不是规则，所以不会报错）。
		语法：#ID名{样式}（ID名不能以数字开头）
		#Mycolor {color: yellow}
		<h3 id="Mycolor">Nick.</h3>

二、组合选择器：

	1.多元素选择器

		同时匹配h3,h4标签，之间用逗号分隔。
		h3,h4 {color: yellow;}
		<h3>Nick</h3>
		<h4>Jenny</h4>

	2.后代元素选择器

		匹配所有div标签里嵌套的P标签，之间用空格分隔。

		div p {color: yellow;}
		<div>
			<p>Nick</p>
			<div>
				<p>Nick</p>
			</div>
		</div>

	3.子元素选择器

		匹配所有div标签里嵌套的子P标签，之间用>分隔。

		div > p {color: yellow;}
		<div>
			<p>Nick</p>
			<p>Nick</p>
		</div>

	4.毗邻元素选择器
		匹配所有紧随div标签之后的同级标签P，之间用+分隔（只能匹配一个）。

		div + p {color: yellow;}
		<div>Nick</div>
		<p>Nick</p>

	<!-- Dome样式 -->
	<!doctype html>
	<title>Dome样式</title>
	<style>
	div > p {color: yellow;}
	</style>

		<div>
			<p>Nick</p>
			<p>Nick</p>
		</div>


三、属性选择器：

	1.[title] & P[title]
		设置所有具有title属性的标签元素；
		设置所有具有title属性的P标签元素。
		[title]
		{
			color: yellow;
		}
		p[title]
		{
			color: yellow;
		}

		<div title>Nick</div>
		<p title>Nick</p>

	2.[title=Nick]
		设置所有title属性等于“Nick”的标签元素。
		[title="Nick"]
		{
			color: yellow;
		}

		<p title="Nick">Nick</p>

	3.[title~=Nick]
		设置所有title属性具有多个空格分隔的值、其中一个值等于“Nick”的标签元素。
		[title~="Nick"]
		{
			color: yellow;
		}

		<p title="Nick Jenny">Nick</p>
		<p title="Jenny Nick">Nick</p>

	4.[title|=Nick]
		设置所有title属性具有多个连字号分隔（hyphen-separated）的值、其中一个值以"Nick"开头的标签元素。
		例：lang属性："en"、"en-us"、"en-gb"等等
		[title|="Nick"]
		{
			color: yellow;
		}

		<p title="Nick-Jenny">Nick</p>

	5.[title^=Nick]
		设置属性值以指定值开头的每个标签元素。
		[title^="Nick"]
		{
			color: yellow;
		}

		<p title="NickJenny">Nick</p>

	6.[title$=Nick]
		设置属性值以指定值结尾的每个标签元素。
		[title$="Nick"]
		{
			color: yellow;
		}

		<p title="JennyNick">Nick</p>

	7.[title*=Nick]
		设置属性值中包含指定值的每个元素
		[title*="Nick"]
		{
			color: yellow;
		}

		<p title="SNickJenny">Nick</p>
　　
四、伪类选择器：

	1. link、hover、active、visited
		a:link（未访问的链接状态）,用于定义了常规的链接状态。
		a:hover（鼠标放在链接上的状态）,用于产生视觉效果。
		a:active（在链接上按下鼠标时的状态）。
		a:visited（已访问过的链接状态）,可以看出已经访问过的链接。
			a:link{color: black}
			a:hover{color: yellow}
			a:active{color: blue}
			a:visited{color: red}

		<a href="#">Nick</a>

	2. before、after
		P:before 在每个<p>元素的内容之前插入内容;
		P:after 在每个<p>元素的内容之后插入内容。

		p {
			color: yellow;
		}
		p:before{
			content: "before...";
		}
		p:after{
			content: "after...";
		}
		<!-- Dome样式 -->
		<!doctype html>
		<title>测试dome</title>
		<style>
			p {
				color: blue;
			}
			p:before{
				content: "before... ";
			}
			p:after{
				content: "after... ";
			}
		</style>

			<div>
				<p>Nick </p>
				<p>Nick </p>
			</div>　

css常用属性
 
1. 颜色属性:

color 

	HEX（十六进制色:color: #FFFF00 --> 缩写:#FF0）
	RGB（红绿蓝，使用方式:color:rgb(255,255,0)或者color:rgb(100%,100%,0%)）
	RGBA（红绿蓝透明度，A是透明度在0~1之间取值。使用方式:color:rgba(255,255,0,0.5)）
	HSL（CSS3有效,H表示色调，S表示饱和度，L表示亮度，使用方式:color:hsl(360,100%,50%)）
	HSLA（和HSL相似，A表示Alpha透明度，取值0~1之间。）
transparent

	全透明，使用方式:color: transparent;

opacity

	元素的透明度，语法:opacity: 0.5;
	属性值在0.0到1.0范围内，0表示透明，1表示不透明。
	filter滤镜属性（只适用于早期的IE浏览器，语法:filter:alpha(opacity:20);）。
 

2. 字体属性:

	font-style: 用于规定斜体文本
		normal  文本正常显示
		italic  文本斜体显示
		oblique  文本倾斜显示
	font-weight: 设置文本的粗细
		normal（默认）
		bold（加粗）
		bolder（相当于<strong>和<b>标签）
		lighter （常规）
		100 ~ 900 整百（400=normal，700=bold）
	font-size: 设置字体的大小

		默认值:medium
		<absolute-size>可选参数值:xx-small、 x-small、 small、 medium、 large、 x-large、 xx-large
		<relative-size>相对于父标签中字体的尺寸进行调节。可选参数值:smaller、 larger
		<percentage>百分比指定文字大小。
		<length>用长度值指定文字大小，不允许负值。
	font-family:字体名称

		使用逗号隔开多种字体（优先级从前向后，如果系统中没有找到当前字体，则往后面寻找）
		font:简写属性
		语法:font:字体大小/行高 字体;（字体要在最后）
 

3. 文本属性:

	white-space: 设置元素中空白的处理方式
		normal:默认处理方式。
		pre:保留空格，当文字超出边界时不换行
		nowrap:不保留空格，强制在同一行内显示所有文本，直到文本结束或者碰到br标签
		pre-wrap:保留空格，当文字碰到边界时换行
		pre-line:不保留空格，保留文字的换行，当文字碰到边界时换行
	direction: 规定文本的方向 	
		ltr 默认，文本方向从左到右。
		rtl 文本方向从右到左。
	text-align: 文本的水平对齐方式 
		left
		center
		right
	line-height: 文本行高
		normal 默认
	vertical-align: 文本所在行高的垂直对齐方式
		baseline 默认
		sub 垂直对齐文本的下标，和<sub>标签一样的效果
		super 垂直对齐文本的上标，和<sup>标签一样的效果
		top 对象的顶端与所在容器的顶端对齐
		text-top 对象的顶端与所在行文字顶端对齐
		middle 元素对象基于基线垂直对齐
		bottom 对象的底端与所在行的文字底部对齐
		text-bottom 对象的底端与所在行文字的底端对齐
	text-indent: 文本缩进
	letter-spacing: 添加字母之间的空白
	word-spacing: 添加每个单词之间的空白
	
	text-transform: 属性控制文本的大小写
		capitalize 文本中的每个单词以大写字母开头。
		uppercase 定义仅有大写字母。
		lowercase 定义仅有小写字母。
	text-overflow: 文本溢出样式
		clip 修剪文本。
		ellipsis 显示省略符号...来代表被修剪的文本。
		string 使用给定的字符串来代表被修剪的文本。

	text-decoration: 文本的装饰

		none 默认。
		underline 下划线。
		overline 上划线。
		line-through 中线。
	text-shadow:文本阴影

		第一个参数是左右位置
		第二个参数是上下位置
		第三个参数是虚化效果
		第四个参数是颜色
		text-shadow: 5px 5px 5px #888;
	word-wrap:自动换行
		word-wrap: break-word;
		
4. 背景属性 

	background-color: 背景颜色
	background-image 设置图像为背景
		url("http://images.cnblogs.com/cnblogs_com/suoning/845162/o_ns.png");  图片地址
		background-image:linear-gradient(green,blue,yellow,red,black); 颜色渐变效果
	
	background-position 设置背景图像的位置坐标
		background-position: center center; 图片置中，x轴center，y轴center
		1px -195px  截取图片某部分，分别代表坐标x，y轴
	
	background-repeat 设置背景图像不重复平铺

		no-repeat 设置图像不重复，常用
		round 自动缩放直到适应并填充满整个容器
		space 以相同的间距平铺且填充满整个容器
	background-attachment 背景图像是否固定或者随着页面的其余部分滚动

		background 简写
		background: url("o_ns.png") no-repeat 0 -196px;
		background: url("o_ns.png") no-repeat center bottom 15px;
		background: url("o_ns.png") no-repeat left 30px bottom 15px;

 

5. 列表属性

	list-style-type: 列表项标志的类型

		none 去除标志
		decimal-leading-zero;  02.
		square;  方框
		circle;  空心圆
		upper-alph; & disc; 实心圆
	list-style-image:将图象设置为列表项标志
	list-style-position:列表项标志的位置
		inside
		outside
	list-style:缩写

页面布局
1. 边框 

	border-style：边框样式

		solid 默认，实线
		double 双线
		dotted 点状线条
		dashed 虚线
  border-color：边框颜色
  border-width：边框宽度
  border-radius：圆角

		1个参数：四个角都应用
		2个参数：第一个参数应用于 左上、右下；第二个参数应用于 左下、右上
		3个参数：第一个参数应用于 左上；第二个参数应用于 左下、右上；第三个参数应用于右下
		4个参数：左上、右上、右下、左下（顺时针） 例子 border-radius: 20px 35px 50px 60px;
	border: 简写
	border: 2px yellow solid; 
	box-shadow：边框阴影

		第一个参数是左右位置
		第二个参数是上下位置
		第三个参数是虚化效果
		第四个参数是颜色
		box-shadow: 10px 10px 5px #888;

这部分图片比较多，建议去博客上看后面不再补充
