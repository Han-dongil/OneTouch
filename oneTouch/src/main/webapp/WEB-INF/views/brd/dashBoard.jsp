<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://www.gstatic.com/charts/loader.js"></script>

<title>Insert title here</title>
</head>
<style>
	tbody>tr>td{
		padding-top:7px !important;
		padding-bottom:7px !important;
		line-height:0.1 !important;
	}
	.badge-danger {
    color: #fff;
    background-color: crimson;
	}
	.badge-info{
    color: #fff;
    background-color: green;
	}
</style>
<body>
	<div class="row">
		<div class="col-6">
		<div class="col-lg-12 stretch-card"  style="display:inline-block">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">일일 생산계획</h4>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>라인</th>
									<th>제품명</th>
									<th>생산수량</th>
									<th>불량량</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>GLASS01</td>
									<td>PRD001</td>
									<td>1000</td>
									<td class="text-danger">28.76% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-danger">생산대기</label></td>
								</tr>
								<tr>
									<td>Dave</td>
									<td>53275535</td>
									<td>Photoshop</td>
									<td class="text-success">98.05% <i class="ti-arrow-up"></i></td>
									<td><label class="badge badge-warning">생산중</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td>Photoshop</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">생산완료</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td>Photoshop</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">생산완료</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td>Photoshop</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">생산완료</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td>Photoshop</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">생산완료</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td>Photoshop</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">생산완료</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td>Photoshop</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">생산완료</label></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-lg-12 stretch-card"  style="display:inline-block">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">자재 재고현황</h4>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>자재코드</th>
									<th>자재명</th>
									<th>안전재고</th>
									<th>가용재고</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="warning" items="${listWarning }">
										<tr>
											<td>${warning.mtrCd }</td>
											<td>${warning.mtrNm }</td>
											<td>${warning.safeStck }</td>
											<td class="text-danger">${warning.stckUse }</td>
											<td><label class="badge badge-danger">발주시급</label></td>
										</tr>
								</c:forEach>
								<c:forEach var="caution" items="${listCaution }">
										<tr>
											<td>${caution.mtrCd }</td>
											<td>${caution.mtrNm }</td>
											<td>${caution.safeStck }</td>
											<td class="text-warning">${caution.stckUse }</td>
											<td><label class="badge badge-warning">수량체크</label></td>
										</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			</div>
			<div class="col-lg-12 stretch-card" style="display:inline-block">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">설비 정기점검</h4>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>설비코드</th>
									<th>설비명</th>
									<th>점검일</th>
									<th>D-day</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Jacob</td>
									<td>유리접합용가압오븐</td>
									<td class="text-danger">28.76% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-danger">D-Day</label></td>
								</tr>
								<tr>
									<td>Messsy</td>
									<td>Flash</td>
									<td class="text-danger">21.06% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-warning">D-7</label></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<div class="col-6">
		 <div id="piechart" style="width: 900px; height: 500px;"></div>
    	<div id="piechart2" style="width: 900px; height: 500px;"></div>
    	<div id="realPiechart" style="width: 900px; height: 500px;"></div>
	</div>
</div>



    <script type="text/javascript">
    let i=0;

    function prcView(){

      }
    prcView()
      
      google.charts.load('current', {'packages':['corechart']});
    function abc(){
       setTimeout(function(){
          google.charts.setOnLoadCallback(drawChart);
          
       },1000)
    }
   abc();
      function drawChart() {
         console.log(i)
          let data ; 
          let arr=[];
        var aa =[
             ['Task', 'Hours per Day'],

              ]; 
        var bb =[
             ['Task', 'Hours per Day'],

              ]; 
        var cc =[
             ['Task', 'Hours per Day'],

              ]; 
        
         fetch('dashBoardData')
         .then(response=>response.json())
         .then(result=>{
            arr.push(['Task', 'Hours per Day'])
            let fltSum=0;
            let pdtSum=0;
            for(obj of result[i]){
               fltSum+=obj.fltCnt*1;
               cc.push([obj.prcCd,obj.pdtCnt*1+obj.fltCnt*1])
               pdtSum+=obj.goalCnt-(obj.pdtCnt*1+obj.fltCnt*1)
               //console.log(pdtSum)
            }
            console.log(cc)
            cc.push(['잔여진행률',pdtSum])
            //console.log(fltSum)
            let pdtCnt=result[i][result[i].length-1].pdtCnt
            let fltCnt=result[i][result[i].length-1].fltCnt
            let goalCnt=result[i][result[i].length-1].goalCnt
            aa.push(['생산량',pdtCnt*1])
            aa.push(['남은수량',goalCnt*1-(pdtCnt*1+fltSum)])
            bb.push(['불량률',fltSum])
            bb.push(['생산량',pdtCnt*1])
            /* for(obj of result[i]){
               let a=[obj.prcCd, obj.pdtCnt*1];
               aa.push(a)   
               
            } */
            return result;
         })
         .then(x=>{
            pdtData = google.visualization.arrayToDataTable(aa);
              var pdtOptions = {
                title:x[i][x[i].length-1].lineNo +' 라인 생산현황',
                pieHole:0.5,
               // pieSliceText : 'label',
                pieSliceTextStyle: {
                    color: 'black',
                  },
                 legend: 'none',
                 pieStartAngle: 100,
              };
            fltData = google.visualization.arrayToDataTable(bb);
              var fltOptions = {
                title:x[i][x[i].length-1].lineNo + ' 라인 불량현황',
                pieHole:0.5,
               // pieSliceText : 'label',
                pieSliceTextStyle: {
                    color: 'black',
                  },
                 legend: 'none',
                 pieStartAngle: 100,
              };
            realPdtData = google.visualization.arrayToDataTable(cc);
              var realPdtOptions = {
                title:x[i][x[i].length-1].lineNo + ' 라인 진행률',
                pieHole:0.5,
                pieSliceText : 'label',
                pieSliceTextStyle: {
                    color: 'black',
                  },
                 legend: 'none',
                 pieStartAngle: 100,
              };

              var pdtChart = new google.visualization.PieChart(document.getElementById('piechart'));

              pdtChart.draw(pdtData, pdtOptions);

              var fltChart = new google.visualization.PieChart(document.getElementById('piechart2'));

              fltChart.draw(fltData, fltOptions);
              
              var realPdtChart = new google.visualization.PieChart(document.getElementById('realPiechart'));

              realPdtChart.draw(realPdtData, realPdtOptions);
              i++;
              aa.length=0;
              bb.length=0;
              if (i==x.length){
                 i=0;
              }
              abc();
         })
      /* var a = 
             ['Sleeps',    7];
      aa.push(a); */

      }
    </script>

</body>
</html>