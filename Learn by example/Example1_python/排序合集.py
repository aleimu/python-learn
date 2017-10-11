#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: Liu Jiang
# Python 3.5
# 冒泡排序算法


class SQList:
    def __init__(self, lis=None):
        self.r = lis

    def swap(self, i, j):
        """定义一个交换元素的方法，方便后面调用。"""
        temp = self.r[i]
        self.r[i] = self.r[j]
        self.r[j] = temp

    def bubble_sort_simple(self):
        """
        最简单的交换排序，时间复杂度O(n^2)
        """
        lis = self.r
        length = len(self.r)
        for i in range(length):
            for j in range(i+1, length):
                if lis[i] > lis[j]:
                    self.swap(i, j)

    def bubble_sort(self):
        """
        冒泡排序，时间复杂度O(n^2)
        """
        lis = self.r
        length = len(self.r)
        for i in range(length):
            j = length-2
            while j >= i:
                if lis[j] > lis[j+1]:
                    self.swap(j, j+1)
                j -= 1

    def bubble_sort_advance(self):
        """
        冒泡排序改进算法，时间复杂度O(n^2)
        设置flag，当一轮比较中未发生交换动作，则说明后面的元素其实已经有序排列了。
        对于比较规整的元素集合，可提高一定的排序效率。
        """
        lis = self.r
        length = len(self.r)
        flag = True
        i = 0
        while i < length and flag:
            flag = False
            j = length - 2
            while j >= i:
                if lis[j] > lis[j + 1]:
                    self.swap(j, j + 1)
                    flag = True
                j -= 1
            i += 1

    def __str__(self):
        ret = ""
        for i in self.r:
            ret += " %s" % i
        return ret

if __name__ == '__main__':
    sqlist = SQList([4,1,7,3,8,5,9,2,6])
    # sqlist.bubble_sort_simple()
    # sqlist.bubble_sort()
    sqlist.bubble_sort_advance()
    print(sqlist)
	

#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: Liu Jiang
# Python 3.5
# 直接插入排序


class SQList:
    def __init__(self, lis=None):
        self.r = lis

    def insert_sort(self):
        lis = self.r
        length = len(self.r)
        # 下标从1开始
        for i in range(1, length):
            if lis[i] < lis[i-1]:
                temp = lis[i]
                j = i-1
                while lis[j] > temp and j >= 0:
                    lis[j+1] = lis[j]
                    j -= 1
                lis[j+1] = temp

    def __str__(self):
        ret = ""
        for i in self.r:
            ret += " %s" % i
        return ret

if __name__ == '__main__':
    sqlist = SQList([4, 1, 7, 3, 8, 5, 9, 2, 6, 0])
    sqlist.insert_sort()
    print(sqlist)


#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: Liu Jiang
# Python 3.5
# 希尔排序


class SQList:
    def __init__(self, lis=None):
        self.r = lis

    def shell_sort(self):
        """希尔排序"""
        lis = self.r
        length = len(lis)
        increment = len(lis)
        while increment > 1:
            increment = int(increment/3)+1
            for i in range(increment+1, length):
                if lis[i] < lis[i - increment]:
                    temp = lis[i]
                    j = i - increment
                    while j >= 0 and temp < lis[j]:
                        lis[j+increment] = lis[j]
                        j -= increment
                    lis[j+increment] = temp

    def __str__(self):
        ret = ""
        for i in self.r:
            ret += " %s" % i
        return ret

if __name__ == '__main__':
    sqlist = SQList([4, 1, 7, 3, 8, 5, 9, 2, 6, 0,123,22])
    sqlist.shell_sort()
    print(sqlist)





#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: Liu Jiang
# Python 3.5
# 堆排序


class SQList:
    def __init__(self, lis=None):
        self.r = lis

    def swap(self, i, j):
        """定义一个交换元素的方法，方便后面调用。"""
        temp = self.r[i]
        self.r[i] = self.r[j]
        self.r[j] = temp

    def heap_sort(self):
        length = len(self.r)
        i = int(length/2)
        # 将原始序列构造成一个大顶堆
        # 遍历从中间开始，到0结束，其实这些是堆的分支节点。
        while i >= 0:
            self.heap_adjust(i, length-1)
            i -= 1
        # 逆序遍历整个序列，不断取出根节点的值，完成实际的排序。
        j = length-1
        while j > 0:
            # 将当前根节点，也就是列表最开头，下标为0的值，交换到最后面j处
            self.swap(0, j)
            # 将发生变化的序列重新构造成大顶堆
            self.heap_adjust(0, j-1)
            j -= 1

    def heap_adjust(self, s, m):
        """核心的大顶堆构造方法，维持序列的堆结构。"""
        lis = self.r
        temp = lis[s]
        i = 2*s
        while i <= m:
            if i < m and lis[i] < lis[i+1]:
                i += 1
            if temp >= lis[i]:
                break
            lis[s] = lis[i]
            s = i
            i *= 2
        lis[s] = temp

    def __str__(self):
        ret = ""
        for i in self.r:
            ret += " %s" % i
        return ret

if __name__ == '__main__':
    sqlist = SQList([4, 1, 7, 3, 8, 5, 9, 2, 6, 0, 123, 22])
    sqlist.heap_sort()
    print(sqlist)
	
	

#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: Liu Jiang
# Python 3.5
# 归并排序


class SQList:
    def __init__(self, lis=None):
        self.r = lis

    def swap(self, i, j):
        """定义一个交换元素的方法，方便后面调用。"""
        temp = self.r[i]
        self.r[i] = self.r[j]
        self.r[j] = temp

    def merge_sort(self):
        self.msort(self.r, self.r, 0, len(self.r)-1)

    def msort(self, list_sr, list_tr, s, t):
        temp = [None for i in range(0, len(list_sr))]
        if s == t:
            list_tr[s] = list_sr[s]
        else:
            m = int((s+t)/2)
            self.msort(list_sr, temp, s,  m)
            self.msort(list_sr, temp, m+1, t)
            self.merge(temp, list_tr, s, m, t)

    def merge(self, list_sr, list_tr, i, m,  n):
        j = m+1
        k = i
        while i <= m and j <= n:
            if list_sr[i] < list_sr[j]:
                list_tr[k] = list_sr[i]
                i += 1
            else:
                list_tr[k] = list_sr[j]
                j += 1

            k += 1
        if i <= m:
            for l in range(0, m-i+1):
                list_tr[k+l] = list_sr[i+l]
        if j <= n:
            for l in range(0, n-j+1):
                list_tr[k+l] = list_sr[j+l]

    def __str__(self):
        ret = ""
        for i in self.r:
            ret += " %s" % i
        return ret

if __name__ == '__main__':
    sqlist = SQList([4, 1, 7, 3, 8, 5, 9, 2, 6, 0, 12, 77, 34, 23])
    sqlist.merge_sort()
    print(sqlist)



#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: Liu Jiang
# Python 3.5
# 快速排序


class SQList:
    def __init__(self, lis=None):
        self.r = lis

    def swap(self, i, j):
        """定义一个交换元素的方法，方便后面调用。"""
        temp = self.r[i]
        self.r[i] = self.r[j]
        self.r[j] = temp

    def quick_sort(self):
        """调用入口"""
        self.qsort(0, len(self.r)-1)

    def qsort(self, low, high):
        """递归调用"""
        if low < high:
            pivot = self.partition(low, high)
            self.qsort(low, pivot-1)
            self.qsort(pivot+1, high)

    def partition(self, low, high):
        """
        快速排序的核心代码。
        其实就是将选取的pivot_key不断交换，将比它小的换到左边，将比它大的换到右边。
        它自己也在交换中不断变换自己的位置，直到完成所有的交换为止。
        但在函数调用的过程中，pivot_key的值始终不变。
        :param low:左边界下标
        :param high:右边界下标
        :return:分完左右区后pivot_key所在位置的下标
        """
        lis = self.r
        pivot_key = lis[low]
        while low < high:
            while low < high and lis[high] >= pivot_key:
                high -= 1
            self.swap(low, high)
            while low < high and lis[low] <= pivot_key:
                low += 1
            self.swap(low, high)
        return low

    def __str__(self):
        ret = ""
        for i in self.r:
            ret += " %s" % i
        return ret

if __name__ == '__main__':
    sqlist = SQList([4, 1, 7, 3, 8, 5, 9, 2, 6, 0, 123, 22])
    sqlist.quick_sort()
    print(sqlist)

	
	
	

	
