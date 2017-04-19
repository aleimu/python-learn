package main

import (
	"encoding/json"
	"fmt"
	"strconv"
	//"strings"
)

//很好的解析json的方法，直接返回key对应的value，无论多深的json，但在key存在重复时，请注意可能出现异常
func EasyJson(key string, str string) string {
	b := []byte(str)
	var f interface{}
	var ret string
	err := json.Unmarshal(b, &f)
	if err != nil {
		fmt.Println("解析json失败:", err)
		return ""
	}
	switch f.(type) {
	//处理第一层就是map的情况
	case map[string]interface{}:
		fmt.Println("遍历:", f)
		m := f.(map[string]interface{})
		fmt.Println("遍历m:", m)
		//优先遍历key是k的情况，即key在第一层中
		for k, v := range m {
			if k == key {
				switch vv := v.(type) {
				case bool:
					ret = strconv.FormatBool(vv)
					fmt.Println(k, "is bool", ret)
					goto end
				case string:
					ret = vv
					fmt.Println(k, "is string", ret)
					goto end
				case float64:
					ret = strconv.FormatFloat(vv, 'f', -1, 64)
					fmt.Println(k, "is float64", ret)
					goto end
				case []interface{}:
					by, _ := json.Marshal(vv)
					fmt.Println(k, "is array1", string(by))
					ret = string(by)
					goto end
				case map[string]interface{}:
					by, _ := json.Marshal(vv)
					fmt.Println(k, "is map1", string(by))
					ret = string(by)
					goto end
				default:
					fmt.Println(k, "is of a err1 type")
				}
				goto end
			}
			break
		}
		//key不在第一层，需要再解析后面的层
		for k, v := range m {
			if k != key {
				switch vv2 := v.(type) {
				case []interface{}:
					by, _ := json.Marshal(vv2)
					fmt.Println(k, "is array1", string(by))
					if len(ret) == 0 {
						ret = EasyJson(key, string(by)) //递归1
					}
				case map[string]interface{}:
					by, _ := json.Marshal(vv2)
					fmt.Println(k, "is map1", string(by))
					if len(ret) == 0 {
						ret = EasyJson(key, string(by)) //递归2
					}
				default:
					fmt.Println(k, "is of a err2 type")
				}
			}

		}
	//处理第一层就是数组的情况
	case []interface{}:
		ff := f.([]interface{})
		for _, v := range ff {
			switch v.(type) {
			case map[string]interface{}:
				by, _ := json.Marshal(v)
				fmt.Println("is array1", string(by))
				ret = EasyJson(key, string(by)) //递归3
			}
		}
	}
end:
	return ret
}

func main() {
	/*
				a := `{
					    "Title": "Go语言编程",
					    "Authors": ["XuShiwei", "HughLv", "Pandaman", "GuaguaSong", "HanTuo", "BertYuan","XuDaoli",{"cmap":{"a":1,"b":"b","c":0.11}}],
					    "Publisher": "ituring.com.cn",
					    "IsPublished": true,
					    "Price": 9.99,
					    "Sales": 1000000,
						"amap":{"a":1,"b":2,"c":3},
						"bmap":{"a":1,"b":"b","c":0.11}
					}`

		    atype := EasyJson("bmap", a)
			fmt.Println("1解析结果是:", atype)
	*/
	b := `{"total":1,"data":["date2","date3",{"id":2,"name":"apiname78c388","group":"2","owner":"admin","description":"description78c388","createTime":"2017-04-19 03:29:22.0" ,"Authors": ["XuShiwei", "HughLv", "Pandaman", "BertYuan","XuDaoli"]}]}`
	//b := `{"northboundProtocol":"http","northboundMethod":"PUT","northboundPath":"www_baidu_comda210f","southboundType":"HTTP","southboundProtocol":"http","southboundAddress":"http://localhost:8000","southboundPath":"/TEST/","southboundMethod":"PUT","version":1,"description":"descriptionda210f","createTime":"2017-04-19 06:38:36.0","stages":[],"apiId":9,"apiName":"apinameda210f","groupId":14,"owner":"admin"}`

	btype := EasyJson("id", b)
	fmt.Println("2解析结果是:", btype)
}
