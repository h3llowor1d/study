package routers

import (
	"charts/controllers"
	"github.com/astaxie/beego"
)

func init() {
	beego.Router("/", &controllers.MainController{})

	beego.Router("/getData", &controllers.ApiController{})
}
