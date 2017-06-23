package main

import (
	"fmt"
	"regexp"
)

func main() {
	/*str := "CPU $2 time"
	key := "system.cpu.util[,steal]"
	//正则匹配
	reg, _ := regexp.Compile("\\$[0-9]+")
	v := reg.FindString(str)

	//替换$
	numstr := strings.Replace(v, "$", "", 1)
	keyarry := strings.Split(key, ",")
	numint, _ := strconv.Atoi(numstr)
	num := numint - 1
	//num := (numstr) - 1
	name := keyarry[num]

	//替换[ 或者 ]
	name = strings.Replace(name, "[", "", 1)
	name = strings.Replace(name, "]", "", 1)
	fmt.Println(name)

	realstr := strings.Replace(str, v, name, 1)
	fmt.Println(realstr)*/

	re, _ := regexp.Compile(`\$([0-9]+)`)
	//res := re.FindAllStringSubmatch("CPU $2 $3 time", -1)
	res := re.FindAllStringSubmatch("CPU 1$1 1$2 $4 time", -1)
	fmt.Printf("%#v \n", res)

	re2, _ := regexp.Compile(`\[(.*)\]`)
	res2 := re2.FindAllStringSubmatch("aaa[,steal,zhan]", -1)
	fmt.Printf("%#v \n", res2)

}
