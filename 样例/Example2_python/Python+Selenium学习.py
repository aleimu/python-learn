#几个不错的学习资源
Python+Selenium定位不到元素常见原因及解决办法（报：NoSuchElementException）：http://www.cnblogs.com/yufeihlf/p/5689042.html
Python+Selenium 环境配置之Firefox，IE，Chrome几种浏览器运行 http://www.cnblogs.com/yufeihlf/p/5776529.html
webdriver_learning https://github.com/Ralph-Wang/webdriver_learning
selenium + webdriver + python 实现 http://www.cnblogs.com/fnng/p/3157639.html  ---->很6哦！


Python+Selenium WebDriver API：浏览器及元素的常用函数及变量整理总结
由于网页自动化要操作浏览器以及浏览器页面元素，这里笔者就将浏览器及页面元素常用的函数及变量整理总结一下，以供读者在编写网页自动化测试时查阅。
from selenium import webdriver
driver=webdriver.Firefox()
driver.get(r'http://www.baidu.com/')
print 'driver attributes:'
print dir(driver)
elem=driver.find_element_by_id('kw')
print 'WebElement attributes:'
print dir(elem)

其中：红色加粗为数据（变量）。黑色加粗为方法（函数），函数的调用需要加括号哦。
什么是属性？属性就是属于一个对象的数据或者函数的元素（内建函数dir可查看对象属性），可以通过属性据点标识符来访问。

浏览器属性：
driver attributes:
['NATIVE_EVENTS_ALLOWED', '__class__', '__delattr__', '__dict__', '__doc__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_file_detector', '_is_remote', '_mobile', '_switch_to', '_unwrap_value', '_wrap_value', 'add_cookie', 'application_cache', 'back', 'binary', 'capabilities', 'close', 'command_executor', 'create_web_element', 'current_url', 'current_window_handle', 'delete_all_cookies', 'delete_cookie', 'desired_capabilities', 'error_handler', 'execute', 'execute_async_script', 'execute_script', 'file_detector', 'find_element', 'find_element_by_class_name', 'find_element_by_css_selector', 'find_element_by_id', 'find_element_by_link_text', 'find_element_by_name', 'find_element_by_partial_link_text', 'find_element_by_tag_name', 'find_element_by_xpath', 'find_elements', 'find_elements_by_class_name', 'find_elements_by_css_selector', 'find_elements_by_id', 'find_elements_by_link_text', 'find_elements_by_name', 'find_elements_by_partial_link_text', 'find_elements_by_tag_name', 'find_elements_by_xpath', 'firefox_profile', 'forward', 'get', 'get_cookie', 'get_cookies', 'get_log', 'get_screenshot_as_base64', 'get_screenshot_as_file', 'get_screenshot_as_png', 'get_window_position', 'get_window_size', 'implicitly_wait', 'log_types', 'maximize_window', 'mobile', 'name', 'orientation', 'page_source', 'profile', 'quit', 'refresh', 'save_screenshot', 'session_id', 'set_page_load_timeout', 'set_script_timeout', 'set_window_position', 'set_window_size', 'start_client', 'start_session', 'stop_client', 'switch_to', 'switch_to_active_element', 'switch_to_alert', 'switch_to_default_content', 'switch_to_frame', 'switch_to_window', 'title', 'w3c', 'window_handles']

调用说明：
driver.属性值

变量说明：
1.driver.current_url：用于获得当前页面的URL
2.driver.title：用于获取当前页面的标题
3.driver.page_source:用于获取页面html源代码
4.driver.current_window_handle:用于获取当前窗口句柄
5.driver.window_handles:用于获取所有窗口句柄

函数说明：
1.driver.find_element*():定位元素，详看另外一篇博文：http://www.cnblogs.com/yufeihlf/p/5717291.html
2.driver.get(url):浏览器加载url。
实例：driver.get("http//:www.baidu.com")
3.driver.forward()：浏览器向前（点击向前按钮）。
4.driver.back()：浏览器向后（点击向后按钮）。
5.driver.refresh()：浏览器刷新（点击刷新按钮）。
6.driver.close()：关闭当前窗口，或最后打开的窗口。
7.driver.quit():关闭所有关联窗口，并且安全关闭session。
8.driver.maximize_window():最大化浏览器窗口。
9.driver.set_window_size(宽，高)：设置浏览器窗口大小。
10.driver.get_window_size()：获取当前窗口的长和宽。
11.driver.get_window_position()：获取当前窗口坐标。
12.driver.get_screenshot_as_file(filename):截取当前窗口。
实例：driver.get_screenshot_as_file('D:/selenium/image/baidu.jpg')
13.driver.implicitly_wait(秒)：隐式等待，通过一定的时长等待页面上某一元素加载完成。
若提前定位到元素，则继续执行。若超过时间未加载出，则抛出NoSuchElementException异常。
实例：driver.implicitly_wait(10) #等待10秒
14.driver.switch_to_frame(id或name属性值)：切换到新表单(同一窗口)。若无id或属性值，可先通过xpath定位到iframe，再将值传给switch_to_frame()
15.driver.switch_to.parent_content():跳出当前一级表单。该方法默认对应于离它最近的switch_to.frame()方法。
16.driver.switch_to.default_content():跳回最外层的页面。
17.driver.switch_to_window(窗口句柄)：切换到新窗口。
18.driver.switch_to.window(窗口句柄):切换到新窗口。
19.driver.switch_to_alert():警告框处理。处理JavaScript所生成的alert,confirm,prompt.
20.driver.switch_to.alert():警告框处理。
21.driver.execute_script(js):调用js。
22.driver.get_cookies():获取当前会话所有cookie信息。
23.driver.get_cookie(cookie_name)：返回字典的key为“cookie_name”的cookie信息。
实例：driver.get_cookie("NET_SessionId")
24.driver.add_cookie(cookie_dict):添加cookie。“cookie_dict”指字典对象，必须有name和value值。
25.driver.delete_cookie(name,optionsString):删除cookie信息。
26.driver.delete_all_cookies():删除所有cookie信息。

页面元素属性：
WebElement attributes:
['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_execute', '_id', '_parent', '_upload', '_w3c', 'clear', 'click', 'find_element', 'find_element_by_class_name', 'find_element_by_css_selector', 'find_element_by_id', 'find_element_by_link_text', 'find_element_by_name', 'find_element_by_partial_link_text', 'find_element_by_tag_name', 'find_element_by_xpath', 'find_elements', 'find_elements_by_class_name', 'find_elements_by_css_selector', 'find_elements_by_id', 'find_elements_by_link_text', 'find_elements_by_name', 'find_elements_by_partial_link_text', 'find_elements_by_tag_name', 'find_elements_by_xpath', 'get_attribute', 'id', 'is_displayed', 'is_enabled', 'is_selected', 'location', 'location_once_scrolled_into_view', 'parent', 'rect', 'screenshot', 'screenshot_as_base64', 'screenshot_as_png', 'send_keys', 'size', 'submit', 'tag_name', 'text', 'value_of_css_property']

调用说明：
driver.find_element*.属性值
或
element=driver.find_element*
element.属性值

变量说明：
1.element.size:获取元素的尺寸。
2.element.text：获取元素的文本。
3.element.tag_name:获取标签名称。

函数说明：
1.element.clear():清除文本。
2.element.send_keys(value):输入文字或键盘按键（需导入Keys模块）。
3.element.click()：单击元素。
4.element.get_attribute(name):获得属性值
5.element.is_displayed():返回元素结果是否可见（True 或 False）
6.element.is_selected():返回元素结果是否被选中（True 或 False）
7.element.find_element*():定位元素，用于二次定位。


