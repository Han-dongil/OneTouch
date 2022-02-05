<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통계</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />


<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/grid-common.js"></script>
</head>
<body>
<br>
<h3>통계</h3>
<hr>
<div id="tabs">
	<ul>
	  <li><a href="#mtrIn">자재입고량</a></li>
	  <li><a href="#mtrOut">자재출고량</a></li>
	  <li><a href="#pdtCnt">제품생산량</a></li>
	  <li><a href="#fltCnt">제품불량량</a></li>
	</ul>
	<br>
	&nbsp;
	<select id=selectSts>
		<option value="일별">일별</option>
		<option value="월별">월별</option>
		<option value="연도별">연도별</option>
		<option value="자재별,일별">자재별,일별</option>
		<option value="자재별,월별">자재별,월별</option>
		<option value="자재별,연도별">자재별,연도별</option>
	</select>
	<br><br>
	<form id="stsFrm">
	<div>&nbsp;
		<label>해당일자</label>
		<input type="Date" id="startDate" name="startDate">&nbsp;
		<label> ~ </label>&nbsp;
		<input type="Date" id="endDate" name="endDate">&nbsp;
		<button type="button" id="btnFind">조회</button>
	</div>
	<br>
</form>
	<div id="mtrInTab"></div>
	<div id="mtrOutTab"></div>
	<div id="pdtCntTab"></div>
	<div id="fltCntTab"></div>
</div>
<script type="text/javascript">

function getDateStr(dt){
	let year = dt.getFullYear();
	let month = (dt.getMonth() + 1);
	let day = dt.getDate();
	
	month = (month < 10) ? "0" + String(month) : month;
	day = (day < 10) ? "0" + String(day) : day;
	
	return  year + '-' + month + '-' + day;
}
function today() {
	let dt = new Date();
	return getDateStr(dt);
}
function lastWeek() {
	let dt = new Date();
	let day = dt.getDate();
	dt.setDate(day -7);
	return getDateStr(dt);
}
document.getElementById('startDate').value = lastWeek();
document.getElementById('endDate').value = today();

//---------Jquery tabs---------
$( function() {
    $( "#tabs" ).tabs({
    	activate: function( event, ui ) {
    		if(ui.newTab[0].innerText == '자재입고량'){
    			mtrInGrid.refreshLayout();
    		} /* else if(ui.newTab[1].innerText == '자재출고량'){
    			mtrOutGrid.refreshLayout();
    		} else if(ui.newTab[1].innerText == '제품생산량'){
    			pdtCntGrid.refreshLayout();
    		} else {
    			fltCntGrid.refreshLayout();
    		} */
    	}
    });
});
//---------Jquery tabs 끝---------

//---------mtrInGrid---------
//컬럼
let mtrInColumns = [{
		header:'입고일',
		name:'inDate',
		align: 'center'
	},
	{
		header:'자재코드',
		name:'mtrCd',
		align: 'center'
	},
	{
		header:'입고량',
		name:'cnt',
		align: 'center'
	}];
	
//데이터소스	
const mtrInDataSource = {
		api: {
			readData: { 
				url: './mtrInDate', 
				method: 'GET',
				initParams: $("#stsFrm").serializeObject()
			}
		},
		contentType: 'application/json'	
	};

//그리드
let grid1;
function gridDraw(mtrInColumns) {
	if(grid1 != undefined) {
		grid1.destroy();		
	}
	grid1 = new Grid({
		el: document.getElementById('mtrInTab'),
		columns: mtrInColumns,
		data: mtrInDataSource,
		bodyHeight: 400,
		scrollY : true
	})
}
gridDraw(mtrInColumns);
//---------mtrInGrid 끝---------

//---------조회 버튼---------
let btnFind = document.getElementById('btnFind');
btnFind.addEventListener("click", function(){
   let a= $("#stsFrm").serializeObject();
   grid1.readData(1,a,true);
   //mtrGrid.readData(1,a,true);
});
//---------조회 버튼 끝---------

//---------셀렉트 바뀔때 이벤트--------
let selectSts = document.getElementById('selectSts');
selectSts.addEventListener("change", function(){
	let dtClm = {
			header:'입고일',
			name:'inDate',
			align: 'center'
		};
	let cdClm = {
			header:'자재코드',
			name:'mtrCd',
			align: 'center'
		};
	let cntClm = {
			header:'입고량',
			name:'cnt',
			align: 'center'
		};
	if(selectSts.value == "일별") {
		dtClm.header = '입고일';
		mtrInColumns = [dtClm,cdClm,cntClm];
		mtrInDataSource.api.readData.url = './mtrInDate';
	} else if(selectSts.value == "월별") {
		dtClm.header = '입고월';
		mtrInColumns = [dtClm,cdClm,cntClm];
		mtrInDataSource.api.readData.url = './mtrInMonth';
	} else if(selectSts.value == "연도별") {
		dtClm.header = '입고연도';
		mtrInColumns = [dtClm,cdClm,cntClm];
		mtrInDataSource.api.readData.url = './mtrInYear';
	} else if(selectSts.value == "자재별,일별") {
		dtClm.header = '입고일';
		mtrInColumns = [cdClm,dtClm,cntClm];
		mtrInDataSource.api.readData.url = './mtrInMtrD';	
	} else if(selectSts.value == "자재별,월별") {
		dtClm.header = '입고월';
		mtrInColumns = [cdClm,dtClm,cntClm];
		mtrInDataSource.api.readData.url = './mtrInMtrM';	
	} else if(selectSts.value == "자재별,연도별") {
		dtClm.header = '입고연도';
		mtrInColumns = [cdClm,dtClm,cntClm];
		mtrInDataSource.api.readData.url = './mtrInMtrY';	
	}
	gridDraw(mtrInColumns);
	let a= $("#stsFrm").serializeObject();
	grid1.readData(1,a,true);
})
//---------셀렉트 바뀔때 이벤트 끝--------


//---------mtrInGrid 끝---------
//---------mtrOutGrid---------
//---------mtrOutGrid 끝---------
//---------pdtCntGrid---------
//---------pdtCntGrid 끝---------
//---------fltCntGrid---------
//---------fltCntGrid 끝---------




//---------Grid 깨지는거 refresh---------
/* window.setTimeout(function(){mtrOutGrid.refreshLayout()}, 300);
window.setTimeout(function(){pdtCntGrid.refreshLayout()}, 300);
window.setTimeout(function(){fltCntGrid.refreshLayout()}, 300); */
//---------Grid 깨지는거 refresh끝---------

</script>
</body>
</html>