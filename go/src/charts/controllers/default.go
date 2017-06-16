package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
	"math/rand"
	"time"
)

type MainController struct {
	beego.Controller
}

type ApiController struct {
	beego.Controller
}

type GraphItem struct {
	Name   string     `json:"name"`
	Itemid int64      `json:"itemid"`
	Unit   string     `json:"unit"`
	Data   []ItemData `json:"data"`
}

type ItemData struct {
	UnixTime int64       `json:"unix_time"`
	Value    interface{} `json:"value"`
}

type Graph struct {
	Name    string      `json:"name"`
	Graphid int64       `json:"graphid"`
	Items   []GraphItem `json:"items"`
}

func (c *MainController) Get() {

	c.TplName = "index.tpl"
}

func (this *ApiController) Get() {
	this.EnableRender = false

	graphid, err := this.GetInt64("graphid")
	if err != nil {
		this.Data["json"] = err.Error()
		this.ServeJSON()
		return
	}

	graphData := Graph{}
	items := make([]GraphItem, 0)

	itemLen := int64(rand.Intn(4) + 1)
	dataLen := int64(100)
	for i := int64(0); i < itemLen; i++ {
		itemDatas := make([]ItemData, 0)
		nowTime := time.Now().Unix()
		for j := dataLen; j > 0; j-- {
			itemDatas = append(itemDatas, ItemData{
				UnixTime: nowTime - j,
				Value:    rand.Float64() * 500,
			})
		}

		items = append(items, GraphItem{
			Name:   fmt.Sprintf("item_%d", i),
			Itemid: 11000 + i,
			Unit:   "B",
			Data:   itemDatas,
		})
	}

	graphData.Name = fmt.Sprintf("Graph_test_%d", graphid)
	graphData.Items = items
	graphData.Graphid = graphid

	this.Data["json"] = graphData
	this.ServeJSON()
}
