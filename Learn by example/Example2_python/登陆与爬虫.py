#!/usr/bin/python
# coding=utf-8
import sys
import time
import re

import requests
from bs4 import element
from bs4 import BeautifulSoup

s = requests.session()
s.trust_env = False     # faster

cookie = None

TIME_FORMAT = '%Y-%m-%d %H:%M'

#登陆 3ms
def login():
    name = 'yourname'
    pwd = 'passwd'
    params = {'actionFlag': 'loginAuthenticate',
              'lang': 'en',
              'loginMethod': 'login',
              'loginPageType': 'mix',
              'redirect': 'http://3ms.huawei.com/hi/home/index.html',
              'redirect_local': '',
              'redirect_modify': '',
              'scanedFinPrint': '',
              'uid': name,
              'password': pwd,
              'verifyCode': '2345',
              }

    login_url = 'https://login.huawei.com/login/login.do'
    print ('login...')

    res = s.post(login_url, params=params)  # 核心代码
    global cookie
    cookie = res.cookies          # 记下cookie，后面会用

    if res.status_code == 200:       # 返回200代表连接成功
        print ('successful connected!')

        if cookie is None or cookie['login_failLoginCount'] is None or cookie['login_failLoginCount'] != '0':
            print ('WRONG w3id/password!')
            sys.exit(0)
        else:
            print ('successful login')
#actionFlag=loginAuthenticate&lang=en&loginMethod=login&loginPageType=mix&redirect=http%253A%252F%252Fw3.huawei.com%252Fnext%252Findexa.html&
#redirect_local=&redirect_modify=&scanedFinPrint=&uid=yourname&password=passwd&verifyCode=2345

#login_codehuawei() 登陆code.huawei.com
def login2():
    name = 'yourname'
    pwd = 'passwd'
    params = { "authenticity_token":"kV5GZHDa/iY3Ye/7ndfbfYtqtAKmqRKCHud7pDzUC7fdkmp89Wes+GeH6Wu94TnoOVf3DNVdWl11YC/4QFHQQQ==",
                "username":"yourname",
                "password":"passwd",
                "remember_me":1,
              }
    login_url = 'http://code.huawei.com/users/auth/ldapmain/callback' #这样处理需要配合 res =requests.get(login_url),params=params)
    #下面这样处理是将 params 参数都放进url中
    login_url = 'http://code.huawei.com/users/auth/ldapmain/callback?&utf8=%E2%9C%93&authenticity_token=nxbUcWOseyq5i7M%2FwvBSIi8rXaLb%2BsESgR61kot6AoR7r8exExWZ7sg6wbVcYdoJpE%2FaQe8r1o9Q4JatmqPSmQ%3D%3D&username=yourname&password=lgj%401234'
    print ('login...')

    res =requests.get(login_url)#,params=params)
   # res=requests.request("post",login_url,auth=HTTPBasicAuth('yourname',"passwd"))
    #res = s.post(login_url, params=params)  # 核心代码
    global cookie
    cookie = res.cookies          # 记下cookie，后面会用
    print(cookie)
    print(res.status_code)
    if res.status_code == 200:       # 返回200代表连接成功
        print ('successful connected!')

        # if cookie is None or cookie['_mkra_ctxt'] is None or cookie['_gitlab_session'] != '0':
        #     print ('WRONG w3 id/password!')
        #     sys.exit(0)
        # else:
        #     print ('successful login')
        print(res.text)



def get_page_num(uid):
    base_url = 'http://3ms.huawei.com/hi/blog/list_%s.html'

    page_num = 1
    blog_list_url = base_url % (uid,)

    r = s.get(blog_list_url, cookies=cookie)

    if r.status_code == 200:
        blog_page_soup = BeautifulSoup(r.content.decode('utf-8', 'ignore'), "html.parser")

        if blog_page_soup:
            find_page = blog_page_soup.find('div', class_='page mb20 alR mt5')
            if find_page:
                regex = re.compile(r'&amp;p=(\d+)')
                for child in find_page.children:
                    page_index = regex.search(str(child))
                    if page_index is not None and int(page_index.group(1)) > page_num:
                        page_num = int(page_index.group(1))

    return page_num


class BlogInfo:
    def __init__(self, uid=None, bid=None, href=None, title=None, time1=None,
                 comment_num=0, review_num=0,
                 content=None,
                 yuan=False, jing=False, ding=False, zhuan=False):
        self.uid = uid
        self.bid = bid      # blog id
        self.href = href
        self.title = title
        self.time = time1
        self.comment_num = comment_num
        self.review_num = review_num
        self.content = content
        self.yuan = yuan
        self.jing = jing
        self.ding = ding
        self.zhuan = zhuan


def get_list_page(uid, page_num):
    list_url = 'http://3ms.huawei.com/hi/blog/list_%s.html' + '?' + '&p=%d'
    return [list_url % (uid, i) for i in range(1, page_num + 1)]


def get_blog_link(uid, page_addr):
    blog_infos = []
    for page in page_addr:
        r = s.get(page, cookies=cookie)
        if r.status_code == 200:
            blog_per_page_soup = BeautifulSoup(r.content.decode('utf-8', 'ignore'), "html.parser")
            if blog_per_page_soup:
                find_blog_all = blog_per_page_soup.find_all('dl', class_='list_dl getBlogId')
                for blog_info in find_blog_all:
                    blog = BlogInfo()
                    blog_time = time.gmtime()

                    blog_link_info = blog_info.contents[1].contents[1]
                    blog_link_post_time = blog_info.contents[5].contents[1]
                    blog_link_comment_num = blog_info.contents[5].contents[3]
                    blog_link_review_num = blog_info.contents[5].contents[5]

                    t1 = blog_link_post_time.text.split()
                    if len(t1) == 3:
                        t2 = t1[-2] + ' ' + t1[-1]
                        blog_time = time.strptime(t2, TIME_FORMAT)

                    blog.uid = uid
                    blog.bid = blog_info['blogid']
                    blog.href = blog_link_info['href']
                    blog.title = blog_link_info['title']
                    blog.time = blog_time
                    # print("blog_link_comment_num:",blog_link_comment_num.text)
                    # print("blog_link_review_num:",blog_link_review_num.text)
                    print("------:",blog_link_comment_num.text.replace(" ","").replace("\n","").split('(')[1].split(')')[0])
                    print("======:",blog_link_review_num.text.replace(" ","").replace("\n","").split('(')[1].split(')')[0])
                    blog.comment_num = int(blog_link_comment_num.text.replace(" ","").replace("\n","").split('(')[1].split(')')[0])
                    blog.review_num = int(blog_link_review_num.text.replace(" ","").replace("\n","").split('(')[1].split(')')[0])
                    # blog.comment_num = int(filter(str("".isdigit, blog_link_comment_num.text)))
                    # blog.review_num = int(filter(str("".isdigit, blog_link_review_num.text)))

                    for tag in blog_info.contents[1].contents:
                        if isinstance(tag, element.Tag) and tag.name == 'img':
                            if tag.attrs['title'] == '原创':
                                blog.yuan = True
                            elif tag.attrs['title'] == '精华':
                                blog.jing = True
                            elif tag.attrs['title'] == '置顶':
                                blog.ding = True
                            elif tag.attrs['title'] == '转载':
                                blog.zhuan = True

                    blog_infos.append(blog)

    return blog_infos


def get_blog_content(blog_soup):
    find_blog_content = blog_soup.find('div', class_='gut_style img_resize')
    content = ''
    if find_blog_content:
        for t in find_blog_content.contents:
            if isinstance(t, element.Comment):
                pass
            elif isinstance(t, element.NavigableString):
                content += str(t)
            elif isinstance(t, element.Tag):
                content += t.text
            else:
                print("Can NOT handle content type(%r)" % (type(t),)),

    while content.find('\n\n\n\n') != -1:
        content = content.replace('\n\n\n\n', '\n\n\n')

    return content


def get_blog_infos(blog_infos):
    for blog_info in blog_infos:
        url = blog_info.href
        if url:
            r = s.get(url, cookies=cookie)
            if r.status_code == 200:
                blog_soup = BeautifulSoup(r.content.decode('utf-8', 'ignore'), "html.parser")
                if blog_soup:
                    blog_info.content = get_blog_content(blog_soup)
                    print( blog_info.content)


def main():
    login()

    uid = '591711'
    page_num = get_page_num(uid)
    print("page_num:",page_num)

    page_addr = get_list_page(uid, page_num)
    print("page_addr:",page_addr)

    blog_infos = get_blog_link(uid, page_addr)
    print("blog_infos:",blog_infos)

    get_blog_infos(blog_infos)


if __name__ == '__main__':
    main()
    login2()
