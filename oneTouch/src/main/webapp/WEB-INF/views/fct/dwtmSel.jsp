<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

</head>
<body>
<div id="barchart_values" ></div>

<script type="text/javascript">

let color = ["#b87333","silver","gold","color: #e5e4e2","#42A5F5","#1565C0"
			,"#81C784","#3F51B5","#FB8C00","#FFEA00","#A1887F","#BDBDBD","#CE93D8","#AB47BC","#66BB6A","#80D8FF"]
google.charts.load("current", {packages:["corechart"]});
google.charts.setOnLoadCallback(drawChart);
function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ["Element", "Density", { role: "style" } ],
    ["Copper", 8.94, "#b87333"],
    ["Silver", 10.49, "silver"],
    ["Gold", 19.30, "gold"],
    ["Platinum", 21.45, "color: #e5e4e2"],
    ["Platinum", 21.45, "color: #42A5F5"],
    ["Platinum", 21.45, "color: #1565C0"],
    ["Platinum", 21.45, "color: #81C784"],
    ["Platinum", 21.45, "color: #3F51B5"],
    ["Platinum", 21.45, "color: #FB8C00"],
    ["Platinum", 21.45, "color: #FFEA00"],
    ["Platinum", 21.45, "color: #A1887F"],
    ["Platinum", 21.45, "color: #80D8FF"]
  ]);

  var view = new google.visualization.DataView(data);
  view.setColumns([0, 1,
                   { calc: "stringify",
                     sourceColumn: 1,
                     type: "string",
                     role: "annotation" },
                   2]);

  var options = {
    title: "Density of Precious Metals, in g/cm^3",
    width: 600,
    height: 400,
    bar: {groupWidth: "95%"},
    legend: { position: "none" },
  };
  var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
  chart.draw(view, options);
}
</script>
</body>
</html>