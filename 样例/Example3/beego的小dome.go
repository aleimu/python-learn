#项目名  mypro2
//////////////main.go	
package main

import (
	"fmt"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"

	_ "mypro2/routers"

	_ "github.com/go-sql-driver/mysql"
)

//数据库的配置
const (
	DRIVER_NAME   = "mysql"
	DATA_SOURCE   = "root:root@tcp(10.120.189.164:15432)/golang?charset=utf8" //使用golang数据库
	MAX_IDLE_CONN = 5
	MAX_OPEN_CONN = 30
)

func init() {
	// 注册驱动
	orm.RegisterDriver("mysql", orm.DRMySQL)
	// 注册默认数据库
	// 备注：此处第一个参数必须设置为“default”（因为我现在只有一个数据库），否则编译报错说：必须有一个注册DB的别名为 default
	orm.RegisterDataBase("default", DRIVER_NAME, DATA_SOURCE, MAX_IDLE_CONN, MAX_OPEN_CONN)
}

func main() {
	fmt.Println("开始运行!")
	// 开启 orm 调试模式：开发过程中建议打开，release时需要关闭,只在本函数中生效，可以显示建表过程
	orm.Debug = true
	// 自动建表
	orm.RunSyncdb("default", false, true)
	beego.Run()
}
//////////////models.go	
package models

import (
	"github.com/astaxie/beego/orm"
)

type User struct {
	Id   int
	Name string
	Age  string
	Sex  string
}

//Profile *Profile `orm:"rel(one)"` // OneToOne relation
/*
type Profile struct {
	Id   int
	Age  int16
	User *User `orm:"reverse(one)"` // 设置反向关系（可选）
}
*/
//数据库中自动建立 user 表和其中的键
func init() {
	// 需要在 init 中注册定义的 model
	//orm.RegisterModel(new(User), new(Profile))
	orm.RegisterModel(new(User))
}

//////////////controllers.go	
package controllers

import (
	"fmt"
	"mypro2/models"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

type MainController struct {
	beego.Controller
}

//默认的
func (c *MainController) Gets() {
	c.Data["Website"] = "beego.me"
	c.Data["Email"] = "astaxie@gmail.com"
	//定义首页模板
	c.TplName = "index.tpl"
}

func (c *MainController) Add() {
	orm.Debug = true //只在本函数中生效，可以显示增加api的过程

	var id int
	var name string
	var age string
	var sex string
	err := c.Ctx.Input.Bind(&id, ":id")
	//c.Ctx.Input.Bind(&name, "name")
	//c.Ctx.Input.Bind(&age, "age")
	//c.Ctx.Input.Bind(&sex, "sex")
	name, age, sex = c.Input().Get("name"), c.Input().Get("age"), c.Input().Get("sex")
	if err != nil {
		fmt.Println("add err:", err)
	}
	user := new(models.User)
	user.Name = name
	user.Sex = sex
	user.Age = age
	fmt.Println("增加API:", user)

	// 创建一个 ormer 对象
	o := orm.NewOrm()
	o.Using("default")
	// insert
	o.Insert(user)
}

func (c *MainController) Get() {
	orm.Debug = true

	var id int
	err := c.Ctx.Input.Bind(&id, ":id")
	if err != nil {
		fmt.Println("add err:", err)
	}
	// 创建一个 ormer 对象
	o := orm.NewOrm()
	o.Using("default")

	user := new(models.User)
	_, err = o.QueryTable("User").Filter("id", id).All(&user)

	if err != nil {
		fmt.Println("GetApi sql error ")
	}
	fmt.Println("查询API:", user)

}

func (c *MainController) Delete() {
	orm.Debug = true

	var id int
	// 创建一个 ormer 对象
	o := orm.NewOrm()
	o.Using("default")

	err := c.Ctx.Input.Bind(&id, ":id")
	if err != nil {
		fmt.Println("add err:", err)
	}
	// delete
	o.Delete(&models.User{Id: id})
	fmt.Println("删除API:", &models.User{Id: id})
}

//////////////routers.go	
package routers

import (
	"mypro2/controllers"

	"github.com/astaxie/beego"
)

func init() {
	beego.Router("/", &controllers.MainController{}, "get:Gets")
}

func init() {

	var MyApis controllers.MainController

	//添加api
	beego.Router("/api/:id:int", &MyApis, "put:Add")
	//删除api
	beego.Router("/api/:id:int", &MyApis, "delete:Delete")
	//api查找
	beego.Router("/api/:id:([0-9]+)", &MyApis, "get:Get")

}

/*
curl -k -v -X PUT "http://10.177.241.210:8080/api/1?name=lgj&age=18&sex=20"
curl -k -v -X GET "http://10.177.241.210:8080/api/1"
curl -k -v -X PUT "http://10.177.241.210:8080/api/1"
*/
