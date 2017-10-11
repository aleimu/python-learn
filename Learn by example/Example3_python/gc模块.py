gc 模块{
gc（garbage collector）是Python标准库,该module提供了“垃圾回收”内容相对应的接口。通过这个module,可以开关gc、调整垃圾回收的频率、输出调试信息。
gc模块是很多其他模块（比如objgraph）封装的基础

#gc的核心API:
gc.enable(); gc.disable(); gc.isenabled()	开启gc（默认情况下是开启的）；关闭gc；判断gc是否开启
gc.collection()		执行一次垃圾回收,不管gc是否处于开启状态都能使用
gc.set_threshold(t0, t1, t2); gc.get_threshold()	设置垃圾回收阈值； 获得当前的垃圾回收阈值	注意：gc.set_threshold(0)也有禁用gc的效果
gc.get_objects()	返回所有被垃圾回收器（collector）管理的对象,只要python解释器运行起来,就有大量的对象被collector管理,因此,该函数的调用比较耗时！
gc.get_referents(*obj)	返回obj对象直接指向的对象
gc.get_referrers(*obj)	返回所有直接指向obj的对象
gc.set_debug(flags)	设置调试选项,非常有用,常用的flag组合包含以下:
gc.DEBUG_COLLETABLE： 打印可以被垃圾回收器回收的对象
gc.DEBUG_UNCOLLETABLE： 打印无法被垃圾回收器回收的对象,即定义了__del__的对象
gc.DEBUG_SAVEALL：当设置了这个选项,可以被拉起回收的对象不会被真正销毁（free）,而是放到gc.garbage这个列表里面,利于在线上查找问题


>>> import gc
>>> len(gc.get_objects())
3749

下面的实例展示了get_referents与get_referrers两个函数
>>> class OBJ(object):
... pass
...
>>> a, b = OBJ(), OBJ()
>>> hex(id(a)), hex(id(b))
('0x250e730', '0x250e7f0')
>>> gc.get_referents(a)
[<class '__main__.OBJ'>]
>>> a.attr = b
>>> gc.get_referents(a)
[{'attr': <__main__.OBJ object at 0x0250E7F0>}, <class '__main__.OBJ'>]
>>> gc.get_referrers(b)
[{'attr': <__main__.OBJ object at 0x0250E7F0>}, {'a': <__main__.OBJ object at 0x0250E730>, 'b': <__main__.OBJ object at 0x0250E7F0>, 'OBJ': <class '__main__.OBJ'>, '__builtins__': <modu
le '__builtin__' (built-in)>, '__package__': None, 'gc': <module 'gc' (built-in)>, '__name__': '__main__', '__doc__': None}]
>>>
a, b都是类OBJ的实例,执行"a.attr = b"之后,a就通过‘’attr“这个属性指向了b。
}
