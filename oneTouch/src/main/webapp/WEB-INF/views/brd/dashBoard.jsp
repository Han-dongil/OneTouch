<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<div class="content-wrapper">
	<div class="row">
		<div class="col-6 grid-margin">
		<div class="col-lg-12 stretch-card"  style="display:inline-block">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">${sysdate } 지시현황</h4>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>라인</th>
									<th>제품명</th>
									<th>생산수량/지시수량</th> 
									<th>불량량</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="bef" items="${before }">
										<tr>
											<td>${bef.lineNo }</td>
											<td>${bef.prdNm }</td>
											<td>${bef.pdtCnt }/${bef.goalCnt }</td>
											<td>${bef.fltCnt }</td>
											<td><label class="badge badge-danger">생산대기</label></td>
										</tr>
								</c:forEach>
								<c:forEach var="pro" items="${progress }">
										<tr>
											<td>${pro.lineNo }</td>
											<td>${pro.prdNm }</td>
											<td>${pro.pdtCnt }</td>
											<td class="text-danger">${pro.fltCnt }</td>
											<c:choose>
												<c:when test="${pro.fltCnt eq null }">
													<td>-</td>
												</c:when>
											</c:choose>
											<td><label class="badge badge-warning">생산중</label></td>
										</tr>
								</c:forEach>
								<c:forEach var="don" items="${done }">
										<tr>
											<td>${don.lineNo }</td>
											<td>${don.prdNm }</td>
											<td>${don.pdtCnt }</td>
											<td class="text-danger">${don.fltCnt }</td>
											<c:choose>
												<c:when test="${don.fltCnt eq null }">
													<td class="text-success">0</td>
												</c:when>
											</c:choose>
											<td><label class="badge badge-info">생산완료</label></td>
										</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			</div>
			<br>
			<br>
			<div class="col-lg-12 stretch-card"  style="display:inline-block">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">자재 재고현황</h4>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>자재명</th>
									<th>단위</th>
									<th>안전재고</th>
									<th>가용재고</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="warning" items="${listWarning }">
										<tr>
											<td>${warning.mtrNm }</td>
											<td>${warning.unitNm }</td>
											<td>${warning.safeStck }</td>
											<td class="text-danger">${warning.stckUse }</td>
											<td><label class="badge badge-danger">발주시급</label></td>
										</tr>
								</c:forEach>
								<c:forEach var="caution" items="${listCaution }">
										<tr>
											<td>${caution.mtrNm }</td>
											<td>${caution.unitNm }</td>
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
			<br>
			<br>
			<div class="col-lg-12 stretch-card" style="display:inline-block">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">설비 정기점검</h4>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>설비명</th>
									<th>점검완료일</th>
									<th>차기점검일</th>
									<th>D-day</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="fct" items="${fctList }">
									<c:choose>
										<c:when test="${fct.dayDiff < 2 }">
											<tr>
												<td>${fct.fctNm }</td>
												<td><fmt:formatDate value="${fct.chkDt }" pattern="yyyy-MM-dd" /></td>
												<td class="text-danger">${fct.chkExpectDt }</td>
												<c:choose>
													<c:when test="${fct.dayDiff == 0 }">
														<td><label class="badge badge-danger">D-day</label></td>
													</c:when>
													<c:otherwise>
														<td><label class="badge badge-danger">D-${fct.dayDiff }</label></td>
													</c:otherwise>
												</c:choose>
											</tr>
										</c:when>
										<c:when test="${fct.dayDiff < 8 }">
											<tr>
												<td>${fct.fctNm }</td>
												<td><fmt:formatDate value="${fct.chkDt }" pattern="yyyy-MM-dd" /></td>
												<td class="text-warning">${fct.chkExpectDt }</td>
												<td><label class="badge badge-warning">D-${fct.dayDiff }</label></td>
											</tr>
										</c:when>
									</c:choose>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-6">
		 <div id="piechart" style="width: 900px; height: 500px;"></div>
    	<div id="realPiechart" style="width: 900px; height: 500px;"></div>
	</div>
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
          
       },3000)
    }
   abc();
      function drawChart() {
         console.log(i)
          let data ; 
          let arr=[];
        var aa =[
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
            aa.push(['불량량',fltSum*1])
            aa.push(['남은수량',goalCnt*1-(pdtCnt*1+fltSum)])
         	console.log(aa)
         	console.log(goalCnt)
         	console.log(pdtCnt)
         	console.log(fltSum)
			console.log("aa")
            console.log("불량률"+fltSum)
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

              
              var realPdtChart = new google.visualization.PieChart(document.getElementById('realPiechart'));

              realPdtChart.draw(realPdtData, realPdtOptions);
              i++;
              aa.length=0;
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