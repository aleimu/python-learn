#map 在遍历中改变
d = {'a':1, 'b':0, 'c':1, 'd':0}
# for k in d:
#     if d[k] == 0:
#         del(d[k])
# print(d)
#RuntimeError: dictionary changed size during iteration

print(list(d.keys()))

for k in d.keys():
    if d[k] == 0:
        del(d[k])
print(d)


"""

问题 RuntimeError: dictionary changed size during iteration 字典在遍历中被改变大小

解决方法:

获取原待遍历的数据结构的副本，在副本上遍历
    for entity in self.entities.values():
        entity.process(time_passed_seconds)
改为
    for entity in [x for x in self.entities.values()]:
        entity.process(time_passed_seconds)

例子

for k in d.keys():
    if d[k] == 0:
        del(d[k])
print(d)
改:
for k in [x for x in d.keys()]:
    if d[k] == 0:
        del(d[k])
print(d)

for k in list(d.keys()):
    if d[k] == 0:
        del(d[k])
print(d)

# brief method
 for l in my_list[:]:
    print(l)

# another method
for l in [x for x in my_list]:
    print(l)

# d = {d[k]=5 for k,v in zip(d.keys(),d.values()) if v ==0 }
# print(d)

# d = {k:v for k,v in zip(d.keys(),d.values()) if v !=0 }
# print(d)

# for key, value in zip(d.keys(), d.values()):
#     print("%s: %s" % (key, value))

"""
