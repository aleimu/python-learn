#-*- coding:utf-8 -*-
import jieba
'''
cut方法有两个参数
1)第一个参数是我们想分词的字符串
2)第二个参数cut_all是用来控制是否采用全模式
'''

# 全模式
word_list = jieba.cut("一命二运三风水,四积功德五读书。六名七相八敬神,九交贵人十养生！", cut_all=True)
print("word_list:", list(word_list))
print("全模式：", "|".join(word_list))
#精确模式 , 默认就是精确模式
word_list = jieba.cut("今天天气真好。亲爱的，我们去远足吧！", cut_all=False)
print("精确模式：", "|".join(word_list))
# 搜索引擎模式
word_list = jieba.cut_for_search("今天天气真好。亲爱的，我们去远足吧！")
print("搜索引擎：", "|".join(word_list))
