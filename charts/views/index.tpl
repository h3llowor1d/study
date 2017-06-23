<!DOCTYPE HTML>
<html>

<head>
  <title>canvas chart</title>
  <script type="text/javascript" src="/static/js/jquery.js"></script>
  <script type="text/javascript" src="/static/js/canvasjs.min.js"></script>
  <style type="text/css">
    .mychart {
      float: left;
      height: 300px;
      width: 100%;
    }
  </style>

  <script type="text/javascript">

      $(function(){
          var $body = $('body')
          var graphLen = 10
          for (var i=0;i<graphLen;i++){
              var id = "chart" + i
              var $div = $('<div id="'+id+'" class="mychart"></div>')
              $body.append($div)
          }

          for (var i=0;i<graphLen;i++){
              $.ajax({
                  url:"/getData",
                  type:"GET",
                  dataType:"json",
                  data:{
                      "graphid":10000+i
                  },
                  success:function(res){
                      makeGraph(res)
                  },
                  error:function(){
                      console.log("error.......")
                  }
              })
          }

      })

      var chartCount = 0
      var makeGraph = function(graphData){

          var chartConfig = {
              animationEnabled: true,
              zoomEnabled: true,
              title:{
                  text: ""
              },
              toolTip:{
                  shared: true,
                  content:"{name}: {y}",
                  // 格式化 toolTip 的内容
                  contentFormatter: function (e) {
                      var localTime = CanvasJS.formatDate( e.value, "MM-DD HH:mm:ss")
                      var content = localTime+ "<br>";
                      for (var i = 0; i < e.entries.length; i++) {
                          var formatString = ""
                          if (e.entries[i].dataPoint.y > 1000 && e.entries[i].dataPoint.y < 1000*1000){
                              formatString = "#,###,.##K"
                          }else if (e.entries[i].dataPoint.y > 1000*1000 && e.entries[i].dataPoint.y < 1000*1000*1000){
                              formatString = "#,###,.##G"
                          }

                          var value = CanvasJS.formatNumber(e.entries[i].dataPoint.y,formatString)
                          content += e.entries[i].dataSeries.name + " " + "<strong>" + value + "</strong>";
                          content += "<br/>";
                      }
                      return content;
                  }
              },
              axisX:{
                  labelFormatter: function (e) {
                      return CanvasJS.formatDate( e.value, "MM-DD HH:mm:ss");
                  },
                  labelAngle: -20,
                  //interval: 30,
                  //intervalType: "second"
                  //valueFormatString: "#,##0.##",
                  gridColor: "Silver"
                  //valueFormatString: "MM-DD HH:mm:ss"
              },
              axisY:{
                  //valueFormatString: "#,##0.##",
                  //valueFormatString: "#,##0.##",
                  //suffix:"B"

              },
              legend: {
                  cursor: "pointer",
                  itemclick: function (e) {
                      //console.log("legend click: " + e.dataPointIndex);
                      //console.log(e);
                      if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
                          e.dataSeries.visible = false
                      } else {
                          e.dataSeries.visible = true
                      }
                      e.chart.render()
                  }
              },
          }
          chartConfig.title.text = graphData.name
          var dataProvider = []
          $.each(graphData.items,function (idx,ctx) {
              var itemData = {
                  name:ctx.name,
                  showInLegend: true,
                  type: "spline",
                  dataPoints:[]
              }

              $.each(ctx.data,function(idx1,ctx1){
                  itemData.dataPoints.push({
                      x:new Date(ctx1.unix_time * 1000),
                      y: ctx1.value
                  })
              })

              dataProvider.push(itemData)
          })

          chartConfig.data = dataProvider
          var chart = new CanvasJS.Chart("chart"+chartCount,chartConfig)
          chartCount++
          chart.render()
      }

  </script>
</head>
<body>
</body>

</html>