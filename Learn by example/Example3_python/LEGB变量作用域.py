# 这个需要好好理解一下啊！
def scope_test():
    spam = "test spam"
    print("1:", id(spam))
    def do_local():
        spam = "local spam"  # 新变量spam和scope_test中定义的同名但不同地址
        print("2:", id(spam))

    def do_nonlocal():
        nonlocal spam  # 在函数内部改变scope_test中spam的绑定
        print("3:", id(spam))
        spam = "nonlocal spam"

    def do_global():
        global spam  # 定义了全局变量spam，和scope_test中的spam互不影响
        spam = "global spam"
        print("4:", id(spam))

    do_local()
    print("After local assignment:", spam)
    do_nonlocal()
    print("After nonlocal assignment:", spam)  # 使用scope_test中的spam
    do_global()
    print("After global assignment:", spam)  # 使用scope_test中的spam

scope_test()
print("In global scope:", spam)  # 使用全局变量作用域中的spam

"""
After local assignment: test spam
After nonlocal assignment: nonlocal spam
After global assignment: nonlocal spam
In global scope: global spam

local 赋值语句是无法改变 scope_test 的 spam 绑定。
nonlocal 赋值语句改变了scope_test 的spam绑定
global 赋值语句从 块级改变了spam绑定


Python会按LEGB的顺序来搜索变量：

要说明的是，这里的访问规则只对普通变量有效， 对象属性的规则与这无关（简单地说，访问一个对象的属性与此无关）。
L. Local. 局部作用域，即函数中定义的变量（没有用global声明）
E. Enclosing. 嵌套的父级函数的局部作用域，即包含此函数的上级函数的局部作用域，比如上面的示例中的labmda所访问的x就在其父级函数test的局部作用域里。通常也叫non - local作用域。
G. Global(module). 在模块级别定义的全局变量（如果需要在函数内修改它，需要用global声明）
B. Built - in. built - in模块里面的变量，比如int, Exception等等
但此规则有一个重要的限制：
一个不在局部作用域里的变量默认是只读的，如果试图为其绑定一个新的值， Python认为是在当前的局部作用域里创建一个新的变量

global关键字用来在函数或其他局部作用域中使用全局变量。但是如果不修改全局变量也可以不使用global关键字。
nonlocal关键字用来在函数或其他作用域中使用外层(非全局)变量。
"""

#对于int和str类型的变量，改变值就是改变了地址，id(a)可以看出变化


def mydome():
    a = 1
    print("id0:", id(a), "a:", a)
    def do1():
        a = 2
        print("id1:", id(a), "a:", a)
    def do2():
        print("id2:", id(a), "a:", a)
    def do3():
        print("id3:", id(a), "a:", a)
    def do4():
        nonlocal a  # 在函数内部改变mydome中a的绑定
        print("id4:", id(a), "a:", a)
        a = "nonlocal a"
        #a = 3
        print("id5:", id(a), "a:", a)
    def do5():
        global a  # 定义了全局变量a，和mydome中的a互不影响
        a = "global a"
        print("id6:", id(a), "a:", a)

    do1()
    do2()
    do3()
    do4()
    do5()
    print("id7:", id(a), "a:", a)

print("-------------------")
mydome()
print("id8:", id(a), "a:", a)
