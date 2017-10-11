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
	m := f.(map[string]interface{})
	for k, v := range m {
		switch vv := v.(type) {
		case bool:
			if k == key {
				ret = strconv.FormatBool(vv)
				goto end
			}
		case string:
			//fmt.Println(k, "is string1", vv)
			if k == key {
				ret = vv
				goto end
			}
		case float64:
			///fmt.Println(k, "is int1", vv)
			if k == key {
				ret = strconv.FormatFloat(vv, 'f', -1, 64)
				fmt.Println(vv, "to", ret)
				fmt.Println("the key:", key)
				goto end
			}
		case []interface{}:
			by, _ := json.Marshal(vv)
			fmt.Println(k, "is array1", string(by))
			if k == key {
				ret = string(by)
			}
			if len(ret) == 0 {
				ret = LoopArray(key, vv)
			}
		case map[string]interface{}:
			by, _ := json.Marshal(vv)
			fmt.Println(k, "is map1", string(by))
			if k == key {
				ret = string(by)
				goto end
			}
			EasyJson(key, string(by))
		default:
			fmt.Println(k, "is of a err1 type")
		}
	}
end:
	return ret
}

func LoopArray(key string, m []interface{}) string {
	//fmt.Println("遍历此数组:", m)
	var ret string
	for k, v := range m {
		switch vv := v.(type) {
		case []interface{}:
			fmt.Println(k, "is array2", vv)
			LoopArray(key, vv)
		case map[string]interface{}:
			by, _ := json.Marshal(vv)
			fmt.Println(k, "is map2", string(by))
			ret = EasyJson(key, string(by))
		default:
			fmt.Println(k, "is of a err2 type")
		}
	}
	return ret
}

func main() {
	//递归方式变量未知结构
	/*
				a := `{
						    "Title": "Go语言编程",
						    "Authors": ["XuShiwei", "HughLv", "Pandaman", "BertYuan","XuDaoli",{"cmap":{"a4":1,"b4":"b4","c4":0.11}}],
						    "Publisher": "ituring.com.cn",
						    "IsPublished": true,
						    "Price": 9.99,
						    "Sales": 1000000,
							"amap":{"a":1,"b":2,"c":3},
							"bmap":{"a1":1,"b1":"b","c1":0.11,"dmap":{"a2":1,"b2":"b","c2":0.11,"emap":{"a3":1,"b3":"b3","c3":0.11}}}
						}`
		    atype := EasyJson("cmap", a)
			//fmt.Println("atype:", atype)
	*/
	b := `{"total":1,"data":["date2","date3",{"id":2,"name":"apiname78c388","group":"2","owner":"admin","description":"description78c388","createTime":"2017-04-19 03:29:22.0" ,"Authors": ["XuShiwei", "HughLv", "Pandaman", "BertYuan","XuDaoli"]}]}`
	//b := `{"northboundProtocol":"http","northboundMethod":"PUT","northboundPath":"www_baidu_comda210f","southboundType":"HTTP","southboundProtocol":"http","southboundAddress":"http://localhost:8000","southboundPath":"/TEST/","southboundMethod":"PUT","version":1,"description":"descriptionda210f","createTime":"2017-04-19 06:38:36.0","stages":[],"apiId":9,"apiName":"apinameda210f","groupId":14,"owner":"admin"}`

	btype := EasyJson("data", b)
	fmt.Println("btype:", btype)
}

/*
JSON中的布尔值将会转换为Go中的bool类型；
数值会被转换为Go中的float64类型；
字符串转换后还是string类型；
JSON数组会转换为[]interface{}类型；
JSON对象会转换为map[string]interface{}类型；
null值会转换为nil。
*/
