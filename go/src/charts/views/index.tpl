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

      var charts = {}
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
                  content: "{name}: {y}"
              }
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
                      //label:"line"+(j+1),
                      //name:"name"+(j+1),
                      x:new Date(ctx1.unix_time),
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

      /*
      $(function(){
          var $body = $('body')
          for (var j=0;j<11;j++){

              var $div = $('<div id="chart'+j+'" class="mychart"></div>')
              $body.append($div)


              var dataPoints = [];
              var dataPoints1 = [];
              var y = 0;

              for ( var i = 0; i < 1000; i++ ) {

                  y += Math.round(5 + Math.random() * (-5 - 5));
                  dataPoints.push({
                      label:"line"+(j+1),
                      //name:"name"+(j+1),
                      x:i,
                      y: y
                  });

                  dataPoints1.push({
                      label:"line"+(j+1),
                      x:i,
                      y: y+100
                  });
              }

              var chart = new CanvasJS.Chart("chart"+j,
                  {
                      animationEnabled: true,
                      zoomEnabled: true,

                      title:{
                          text: "Performance Demo with 10,00 DataPoints"
                      },
                      toolTip:{
                          shared: true,
                          content: "{name}: {y}"
                      },
                      // axisX:{
                      //   gridColor: "Silver",
                      //   valueFormatString: "DD/MMM"
                      // },
                      data: [
                          { //name:"name"+j,
                              showInLegend: true,
                              type: "spline",
                              dataPoints: dataPoints
                          },
                          {
                              name:"linename2",
                              showInLegend: true,
                              type: "spline",
                              dataPoints: dataPoints1
                          }
                      ]
                  });
              chart.render();

          }


      })

       */


  </script>
</head>
<body>
<!-- <div id="chart0" style="height: 300px;width: 100%;background: green";></div>
<div id="chart1" style="height: 300px;width: 100%;background: green";></div>
<div id="chart2" style="height: 300px;width: 100%;background: green";></div> -->
</body>

</html>