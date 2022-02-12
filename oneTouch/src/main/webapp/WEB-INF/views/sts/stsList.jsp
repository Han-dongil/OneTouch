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
<link rel="stylesheet" href="${path}/resources/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="${path}/resources/jquery-ui/images">
<link rel="stylesheet" href="${path}/resources/jquery-ui/MonthPicker.css">
<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />


<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/grid-common.js"></script>
<script src="${path}/resources/jquery-ui/jquery.ui.monthpicker.js"></script>
<!--   <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> -->
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>

</head>
<style>
 	.cntDtl {color: blue; font-weight : bold;}
	.cntAll {color: red; font-weight : bold;} 
</style>
<body>
<br>
<h3>통계</h3>
<hr>

<div id="tabs">
		<ul>
		  <li><a href="#mtrInTab">자재입고량</a></li>
		  <li><a href="#mtrOutTab">자재출고량</a></li>
		  <li><a href="#pdtCntTab">제품생산량</a></li>
		  <li><a href="#fltCntTab">제품불량량</a></li>
		</ul>
	<div class="flex row">
		<div class="col-6">
		<br>
		&nbsp;&nbsp; 
		<select id=selectSts>
			<option>일별</option>
			<option>월별</option>
			<option>연도별</option>
			<option id="optionD">자재별,일별</option>
			<option id="optionM">자재별,월별</option>
			<option id="optionY">자재별,연도별</option>
		</select>
		<br><br>
		<form id="stsDateFrm">
			<div id="dateOnly">&nbsp;&nbsp;
				<label>해당일자</label>&nbsp;
				<input type="text" id="startDate" name="startDate" class="datepicker jquerydtpicker">&nbsp;
				<label> ~ </label>&nbsp;
				<input type="text" id="endDate" name="endDate" class="datepicker jquerydtpicker">&nbsp;

					<button type="button" id="btnFind" class="btnFind">통계조회</button>			

			</div>
		</form>
		<form id="stsMonthFrm">
			<div id="monthOnly">&nbsp;&nbsp;
				<label>해당일자</label>&nbsp;
				<input type="text" id="startDate2" name="startDate" class="monthpicker" class="datepicker jquerymonpicker"/>&nbsp;
				<label> ~ </label>&nbsp;
				<input type="text" id="endDate2" name="endDate" class="monthpicker" class="datepicker jquerymonpicker"/>&nbsp;

					<button type="button" id="btnFind" class="btnFind">통계조회</button>			

			</div>
		</form>
		<form id="stsYearFrm">
			<div id="yearOnly">&nbsp;&nbsp;
				<label>해당일자</label>&nbsp;
				<select id="startDate3" name="startDate">
					<option>2018</option>
					<option>2019</option>
					<option>2020</option>
					<option>2021</option>
					<option>2022</option>
				</select>
				<label> ~ </label>&nbsp;
				<select id="endDate3" name="endDate">
					<option>2018</option>
					<option>2019</option>
					<option>2020</option>
					<option>2021</option>
					<option>2022</option>
				</select>&nbsp;
					<button type="button" id="btnFind" class="btnFind">통계조회</button>			
			</div>
		<br>
		</form>
		<div id="mtrInTab"></div>
		<div id="mtrOutTab"></div>
		<div id="pdtCntTab"></div>
		<div id="fltCntTab"></div>
	</div>
	<div class= "col-6" align="center" style="border-left: 0.1px solid lightgray;">
		<form id="stsMonthFrm2">
		<br><br><br>
			<label>해당일자</label>&nbsp;
			<input type="text" id="startDate4" name="startDate" class="monthpicker" class="datepicker jquerymonpicker"/>&nbsp;
			<label> ~ </label>&nbsp;
			<input type="text" id="endDate4" name="endDate" class="monthpicker" class="datepicker jquerymonpicker"/>&nbsp;
				<button type="button" id="btnChart">차트조회</button>			
			<input style="display: none;" value='chart' name="chart">
		</form><br><br>
		<div id="barChartMtrIn"></div>
		<div id="barChartMtrOut"></div>
		<div id="barChartPdtCnt"></div>
		<div id="barChartFltCnt"></div>
		</div>
	</div>
</div>
<script type="text/javascript">
let flag = 1;
let flag2 = false;
let mtrInLists = [];
let mtrOutLists = [];
let pdtCntLists = [];
let fltCntLists = [];
let selectSts = document.getElementById('selectSts');

//기본 일별 인풋만 보여주기
$("#monthOnly").hide();
$("#yearOnly").hide();

//새로고침후 자재입고량 그래프부터 보여주기
$('#barChartMtrIn').show();
$('#barChartMtrOut').hide();
$('#barChartPdtCnt').hide();
$('#barChartFltCnt').hide();


//input을 datepicker로 선언
$(".datepicker").datepicker({
    dateFormat: 'yy-mm-dd' //달력 날짜 형태
    ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
    ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
    ,changeYear: true //option값 년 선택 가능
    ,changeMonth: true //option값  월 선택 가능                
    ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
    ,buttonImage: "/oneTouch/resources/template/images/cal_lb_sm.png" //"http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
    ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
    //,buttonText: "선택" //버튼 호버 텍스트              
    ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
    ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
    ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
    ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
});                    

   
$(".monthpicker").monthpicker({
	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	,showOn: "both" 
	,buttonImage: "/oneTouch/resources/template/images/cal_lb_sm.png"
	,buttonImageOnly: true
	,changeYear: true
	,yearRange: 'c-2:c+2'
	,dateFormat: 'yy-mm'

});

//일별 초기값
$('#startDate').datepicker('setDate', 'today-1M');
$('#endDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
	    
//월별 초기값
$('#startDate2').monthpicker('setDate', 'today-1M');
$('#endDate2').monthpicker('setDate', 'today');
$('#startDate4').monthpicker('setDate', 'today-1M');
$('#endDate4').monthpicker('setDate', 'today');
    
//연도별 초기값
document.getElementById('startDate3').value = '2020';
document.getElementById('endDate3').value = '2022';

//---------Jquery tabs---------
$( function() {
    $( "#tabs" ).tabs({
    	activate: function( event, ui ) {
    		if(ui.newTab[0].innerText == '자재입고량'){
    			flag = 1;
    			//셀렉트 값붙이기
    			document.getElementById('optionD').innerText = "자재별,일별";
    			document.getElementById('optionM').innerText = "자재별,월별";
    			document.getElementById('optionY').innerText = "자재별,연도별";
    			//통계 적용
    			selectSts.value = "일별";    			
    			dtClm.header = '입고일';
    			dtClm.name = 'inDate';
    			cntClm.header = '입고량'
    			mtrInColumns = [dtClm,cdClm,cntClm];
    			console.log(mtrInColumns)
    			mtrInDataSource.api.readData.url = './mtrInDate';
    			$("#dateOnly").show();
    			$("#monthOnly").hide();
    			$("#yearOnly").hide();
    			mtrInGridDraw(mtrInColumns);
    			mtrInGrid.refreshLayout();
    			//차트 적용
    			$('#barChartMtrIn').show();
    			$('#barChartMtrOut').hide();
    			$('#barChartPdtCnt').hide();
    			$('#barChartFltCnt').hide();
    			$("#barChartMtrIn").empty();
    			barChartMtrIn();
    			
    		} else if(ui.newTab[0].innerText == '자재출고량'){
    			flag = 2;
    			//셀렉트 값붙이기
	    		document.getElementById('optionD').innerText = "자재별,일별";
	    		document.getElementById('optionM').innerText = "자재별,월별";
	    		document.getElementById('optionY').innerText = "자재별,연도별";
	    		//통계 적용
	    		selectSts.value = "일별";
    			dtClm.header = '출고일';
	    		dtClm.name = 'outDt';
	    		cntClm.header = '출고량';
    			mtrOutColumns = [dtClm,cdClm,cntClm];
    			mtrOutDataSource.api.readData.url = './mtrOutDate';
    			$("#dateOnly").show();
    			$("#monthOnly").hide();
    			$("#yearOnly").hide();
    			mtrOutGridDraw(mtrOutColumns);
    			mtrOutGrid.refreshLayout();
    			//차트 적용
    			$('#barChartMtrIn').hide();
    			$('#barChartMtrOut').show();
    			$('#barChartPdtCnt').hide();
    			$('#barChartFltCnt').hide();
    			$("#barChartMtrOut").empty();
    			barChartMtrOut();
    			
    		} else if(ui.newTab[0].innerText == '제품생산량'){
    			flag = 3;
    			//셀렉트 값붙이기
    			document.getElementById('optionD').innerText = "제품별,일별";
    			document.getElementById('optionM').innerText = "제품별,월별";
    			document.getElementById('optionY').innerText = "제품별,연도별"
    			//통계 적용
    			selectSts.value = "일별";
    			cntClm.header = '생산량'
    			dtClm2.header = '제품생산일';
    			pdtCntColumns = [dtClm2,cdClm2,cntClm];
    			pdtCntDataSource.api.readData.url = './pdtDate';
    			$("#dateOnly").show();
    			$("#monthOnly").hide();
    			$("#yearOnly").hide();
    			pdtCntGridDraw(pdtCntColumns);
    			pdtCntGrid.refreshLayout();
    			//차트 적용
    			$('#barChartMtrIn').hide();
    			$('#barChartMtrOut').hide();
    			$('#barChartPdtCnt').show();
    			$('#barChartFltCnt').hide();
    			$("#barChartPdtCnt").empty();
    			barChartPdtCnt();
    			
    		} else {
    			flag = 4;
    			//셀렉트 값붙이기
	    		document.getElementById('optionD').innerText = "제품별,일별";
	    		document.getElementById('optionM').innerText = "제품별,월별";
	    		document.getElementById('optionY').innerText = "제품별,연도별";
	    		//통계 적용;
	    		selectSts.value = "일별";
	    	    cntClm.header = '불량량'
				dtClm2.header = '제품생산일';
				fltCntColumns = [dtClm2,cdClm2,cntClm];
				fltCntDataSource.api.readData.url = './fltDate';
				$("#dateOnly").show();
				$("#monthOnly").hide();
				$("#yearOnly").hide();
				fltCntGridDraw(fltCntColumns);
				fltCntGrid.refreshLayout();
    			//차트 적용
    			$('#barChartMtrIn').hide();
    			$('#barChartMtrOut').hide();
    			$('#barChartPdtCnt').hide();
    			$('#barChartFltCnt').show();
    			$("#barChartFltCnt").empty();
    			barChartFltCnt();
    			
    		} 
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
				initParams: $("#stsDateFrm").serializeObject()
			}
		},
		contentType: 'application/json',
		initialRequest: false
	};

//그리드
let mtrInGrid;
function mtrInGridDraw(mtrInColumns) {
	if(mtrInGrid != undefined) {
		mtrInGrid.destroy();		
	}
	mtrInGrid = new Grid({
		el: document.getElementById('mtrInTab'),
		columns: mtrInColumns,
		data: mtrInDataSource,
		bodyHeight: 400,
		scrollY : true
	})
}
mtrInGridDraw(mtrInColumns);
//---------mtrInGrid 끝---------

//---------mtrOutGrid---------
//컬럼
let mtrOutColumns = [{
		header:'출고일',
		name:'outDt',
		align: 'center'
	},
	{
		header:'자재코드',
		name:'mtrCd',
		align: 'center'
	},
	{
		header:'출고량',
		name:'cnt',
		align: 'center'
	}];
	
//데이터소스	
const mtrOutDataSource = {
		api: {
			readData: { 
				url: './mtrOutDate', 
				method: 'GET',
				initParams: $("#stsDateFrm").serializeObject()
			}
		},
		contentType: 'application/json',
		initialRequest: false
	};

//그리드
let mtrOutGrid;
function mtrOutGridDraw(mtrOutColumns) {
	if(mtrOutGrid != undefined) {
		mtrOutGrid.destroy();		
	}
	mtrOutGrid = new Grid({
		el: document.getElementById('mtrOutTab'),
		columns: mtrOutColumns,
		data: mtrOutDataSource,
		bodyHeight: 400,
		scrollY : true
	})
}
mtrOutGridDraw(mtrOutColumns);
//---------mtrOutGrid 끝---------

//---------pdtCntGrid---------
//컬럼
let pdtCntColumns = [{
		header:'제품생산일',
		name:'workFinDt',
		align: 'center'
	},
	{
		header:'제품코드',
		name:'prdCd',
		align: 'center'
	},
	{
		header:'생산량',
		name:'cnt',
		align: 'center'
	}];
	
//데이터소스	
const pdtCntDataSource = {
		api: {
			readData: { 
				url: './pdtDate', 
				method: 'GET',
				initParams: $("#stsDateFrm").serializeObject()
			}
		},
		contentType: 'application/json'	,
		initialRequest: false
	};

//그리드
let pdtCntGrid;
function pdtCntGridDraw(pdtCntColumns) {
	if(pdtCntGrid != undefined) {
		pdtCntGrid.destroy();		
	}
	pdtCntGrid = new Grid({
		el: document.getElementById('pdtCntTab'),
		columns: pdtCntColumns,
		data: pdtCntDataSource,
		bodyHeight: 400,
		scrollY : true
	})
}
pdtCntGridDraw(pdtCntColumns);
//---------pdtCntGrid 끝---------

//---------fltCntGrid---------
//컬럼
let fltCntColumns = [{
		header:'제품생산일',
		name:'workFinDt',
		align: 'center'
	},
	{
		header:'제품코드',
		name:'prdCd',
		align: 'center'
	},
	{
		header:'불량량',
		name:'cnt',
		align: 'center'
	}];
	
//데이터소스	
const fltCntDataSource = {
		api: {
			readData: { 
				url: './fltDate', 
				method: 'GET',
				initParams: $("#stsDateFrm").serializeObject()
			}
		},
		contentType: 'application/json'	,
		initialRequest: false
	};

//그리드
let fltCntGrid;
function fltCntGridDraw(fltCntColumns) {
	if(fltCntGrid != undefined) {
		fltCntGrid.destroy();		
	}
	fltCntGrid = new Grid({
		el: document.getElementById('fltCntTab'),
		columns: fltCntColumns,
		data: fltCntDataSource,
		bodyHeight: 400,
		scrollY : true
	})
}
fltCntGridDraw(fltCntColumns);
//---------fltCntGrid 끝---------

//console.log($("#stsDateFrm").serializeObject());
//새로고침후 일별 자재입고량 통계부터 보여주기
mtrInGrid.on('onGridMounted', function() {
	if(flag2 == false) {
		mtrInGridDraw(mtrInColumns);
		mtrInGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
		flag1Color();
		flag2 = true;
	} 
})



//---------조회 버튼---------
let btnFind1 = document.getElementsByClassName('btnFind')[0];
let btnFind2 = document.getElementsByClassName('btnFind')[1];
let btnFind3 = document.getElementsByClassName('btnFind')[2];

//자재입고량 글씨색 바꾸기
function flag1Color() {
	window.setTimeout(
		function() {
			for(mtrInData of mtrInGrid.getData()) {
				if(	mtrInGrid.getValue(mtrInData.rowKey, 'inDate').includes("합계") == true ||
					mtrInGrid.getValue(mtrInData.rowKey, 'mtrCd').includes("합계") == true		) {
						mtrInGrid.addRowClassName(mtrInData.rowKey, 'cntAll');
				} else if(  mtrInGrid.getValue(mtrInData.rowKey, 'inDate').includes("소계") == true ||
							mtrInGrid.getValue(mtrInData.rowKey, 'mtrCd').includes("소계") == true) {
								mtrInGrid.addRowClassName(mtrInData.rowKey, 'cntDtl');
				}
			}				
		}
	,100)
}

//자재출고량 글씨색 바꾸기
function flag2Color() {
	window.setTimeout(
		function() {
			for(mtrOutData of mtrOutGrid.getData()) {
				if(mtrOutGrid.getValue(mtrOutData.rowKey, 'outDt').includes("합계") == true ||
				   mtrOutGrid.getValue(mtrOutData.rowKey, 'mtrCd').includes("합계") == true) {
						mtrOutGrid.addRowClassName(mtrOutData.rowKey, 'cntAll');
				} else if(mtrOutGrid.getValue(mtrOutData.rowKey, 'outDt').includes("소계") == true ||
						  mtrOutGrid.getValue(mtrOutData.rowKey, 'mtrCd').includes("소계") == true) {
								mtrOutGrid.addRowClassName(mtrOutData.rowKey, 'cntDtl');
				}
			}				
		}
	,100)
}

//제품생산량 글씨색바꾸기
function flag3Color() {
	window.setTimeout(
		function() {
			for(pdtCntData of pdtCntGrid.getData()) {
				if(pdtCntGrid.getValue(pdtCntData.rowKey, 'workFinDt').includes("합계") == true ||
				   pdtCntGrid.getValue(pdtCntData.rowKey, 'prdCd').includes("합계") == true) {
						pdtCntGrid.addRowClassName(pdtCntData.rowKey, 'cntAll');
				} else if(pdtCntGrid.getValue(pdtCntData.rowKey, 'workFinDt').includes("소계") == true ||
						  pdtCntGrid.getValue(pdtCntData.rowKey, 'prdCd').includes("소계") == true) {
								pdtCntGrid.addRowClassName(pdtCntData.rowKey, 'cntDtl');
				}
			}				
		}
	,100)
}

//제품불량량 글씨색바꾸기
function flag4Color() {
	window.setTimeout(
		function() {
			for(fltCntData of fltCntGrid.getData()) {
				if(fltCntGrid.getValue(fltCntData.rowKey, 'workFinDt').includes("합계") == true ||
				   fltCntGrid.getValue(fltCntData.rowKey, 'prdCd').includes("합계") == true) {
						fltCntGrid.addRowClassName(fltCntData.rowKey, 'cntAll');
				} else if(fltCntGrid.getValue(fltCntData.rowKey, 'workFinDt').includes("소계") == true ||
						  fltCntGrid.getValue(fltCntData.rowKey, 'prdCd').includes("소계") == true) {
								fltCntGrid.addRowClassName(fltCntData.rowKey, 'cntDtl');
				}
			}				
		}
	,100)
}

//통계조회 버튼클릭이벤트
function btnFindFunc() {
	console.log($("#stsDateFrm").serializeObject())
	let frmD = $("#stsDateFrm").serializeObject()
	let frmM = $("#stsMonthFrm").serializeObject()
	let frmY = $("#stsYearFrm").serializeObject()
	console.log(frmD)
	console.log(frmM)
	console.log(frmY)
	if(	frmD.startDate > frmD.endDate ||
		frmM.startDate > frmM.endDate ||
		frmY.startDate > frmY.endDate	) {
			alert("시작날짜가 종료날짜보다 더 큽니다. 다시 입력해주세요");
			return;
	} 
	else {
		if(flag == 1) { //자재입고량
			if(selectSts.value == "일별") {
				mtrInGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
			} else if(selectSts.value == "월별") {
				console.log($("#stsMonthFrm").serializeObject())
				mtrInGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
			} else if(selectSts.value == "연도별") {
				mtrInGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
			} else if(selectSts.value == "자재별,일별") {
				mtrInGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
			} else if(selectSts.value == "자재별,월별") {
				mtrInGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
			} else if(selectSts.value == "자재별,연도별") {
				mtrInGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
			}
			flag1Color();
		} else if(flag == 2) { //자재출고량
			if(selectSts.value == "일별") {
				mtrOutGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
			} else if(selectSts.value == "월별") {
				console.log($("#stsMonthFrm").serializeObject())
				mtrOutGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
			} else if(selectSts.value == "연도별") {
				console.log($("#stsYearFrm").serializeObject())
				mtrOutGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
			} else if(selectSts.value == "자재별,일별") {
				mtrOutGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
			} else if(selectSts.value == "자재별,월별") {
				mtrOutGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
			} else if(selectSts.value == "자재별,연도별") {
				mtrOutGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
			}
			flag2Color();
		} else if(flag == 3) {//제품생산량
			if(selectSts.value == "일별") {
				pdtCntGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
			} else if(selectSts.value == "월별") {
				pdtCntGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
			} else if(selectSts.value == "연도별") {
				pdtCntGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
			} else if(selectSts.value == "제품별,일별") {
				pdtCntGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
			} else if(selectSts.value == "제품별,월별") {
				pdtCntGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
			} else if(selectSts.value == "제품별,연도별") {
				pdtCntGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
			}
			flag3Color();
		} else if(flag == 4) {//제품불량량
			if(selectSts.value == "일별") {
				fltCntGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
			} else if(selectSts.value == "월별") {
				fltCntGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
			} else if(selectSts.value == "연도별") {
				fltCntGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
			} else if(selectSts.value == "제품별,일별") {
				fltCntGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
			} else if(selectSts.value == "제품별,월별") {
				fltCntGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
			} else if(selectSts.value == "제품별,연도별") {
				fltCntGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
			}
			flag4Color();
		}
	}
}
btnFind1.addEventListener("click", function(){
	btnFindFunc();
});
btnFind2.addEventListener("click", function(){
	btnFindFunc();
});
btnFind3.addEventListener("click", function(){
	btnFindFunc();
});
//---------조회 버튼 끝---------

//---------셀렉트 바뀔때 이벤트--------

//변수
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
let dtClm2 = {
		header:'제품생산일',
		name:'workFinDt',
		align: 'center'
	};
let cdClm2 = {
		header:'제품코드',
		name:'prdCd',
		align: 'center'
	};

selectSts.addEventListener("change", function(){	
	//셀렉트 바꿀때마다 초기값 새로 설정
	//(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	//일별 초기값
	$('#startDate').datepicker('setDate', 'today-1M');
	$('#endDate').datepicker('setDate', 'today');      
		    
	//월별 초기값
	$('#startDate2').monthpicker('setDate', 'today-1M');
	$('#endDate2').monthpicker('setDate', 'today');
	$('#startDate4').monthpicker('setDate', 'today-1M');
	$('#endDate4').monthpicker('setDate', 'today');
	    
	//연도별 초기값
	document.getElementById('startDate3').value = '2020';
	document.getElementById('endDate3').value = '2022';
	
	//자재입고량
	if(flag == 1) {
		cntClm.header = '입고량'
		dtClm.name = 'inDate'
		if(selectSts.value == "일별") {
			dtClm.header = '입고일';
			mtrInColumns = [dtClm,cdClm,cntClm];
			mtrInDataSource.api.readData.url = './mtrInDate';
			$("#dateOnly").show();
			$("#monthOnly").hide();
			$("#yearOnly").hide();
			mtrInGridDraw(mtrInColumns);
		} else if(selectSts.value == "월별") {
			dtClm.header = '입고월';
			mtrInColumns = [dtClm,cdClm,cntClm];
			mtrInDataSource.api.readData.url = './mtrInMonth';
			mtrInDataSource.api.readData.initParams = $("#stsMonthFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").show();
			$("#yearOnly").hide();
			mtrInGridDraw(mtrInColumns);
		} else if(selectSts.value == "연도별") {
			console.log($("stsYearFrm").serializeObject())
			dtClm.header = '입고연도';
			mtrInColumns = [dtClm,cdClm,cntClm];
			mtrInDataSource.api.readData.url = './mtrInYear';
			mtrInDataSource.api.readData.initParams = $("#stsYearFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").hide();
			$("#yearOnly").show();
			mtrInGridDraw(mtrInColumns);
		} else if(selectSts.value == "자재별,일별") {
			console.log("1111")
			dtClm.header = '입고일';
			mtrInColumns = [cdClm,dtClm,cntClm];
			mtrInDataSource.api.readData.url = './mtrInMtrD';	
			$("#dateOnly").show();
			$("#monthOnly").hide();
			$("#yearOnly").hide();
			mtrInGridDraw(mtrInColumns);
		} else if(selectSts.value == "자재별,월별") {
			dtClm.header = '입고월';
			mtrInColumns = [cdClm,dtClm,cntClm];
			mtrInDataSource.api.readData.url = './mtrInMtrM';
			mtrInDataSource.api.readData.initParams = $("#stsMonthFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").show();
			$("#yearOnly").hide();
			mtrInGridDraw(mtrInColumns);
		} else if(selectSts.value == "자재별,연도별") {
			dtClm.header = '입고연도';
			mtrInColumns = [cdClm,dtClm,cntClm];
			mtrInDataSource.api.readData.url = './mtrInMtrY';	
			mtrInDataSource.api.readData.initParams = $("#stsYearFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").hide();
			$("#yearOnly").show();
			mtrInGridDraw(mtrInColumns);
		} 
	} //자재출고량 
	else if(flag == 2) {
		cntClm.header = '출고량';
		dtClm.name = 'outDt'
		if(selectSts.value == "일별") {
			dtClm.header = '출고일';
			mtrOutColumns = [dtClm,cdClm,cntClm];
			mtrOutDataSource.api.readData.url = './mtrOutDate';
			$("#dateOnly").show();
			$("#monthOnly").hide();
			$("#yearOnly").hide();
			mtrOutGridDraw(mtrOutColumns);
		} else if(selectSts.value == "월별") {
			dtClm.header = '출고월';
			mtrOutColumns = [dtClm,cdClm,cntClm];
			mtrOutDataSource.api.readData.url = './mtrOutMonth';
			mtrOutDataSource.api.readData.initParams = $("#stsMonthFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").show();
			$("#yearOnly").hide();
			mtrOutGridDraw(mtrOutColumns);
		} else if(selectSts.value == "연도별") {
			dtClm.header = '출고연도';
			mtrOutColumns = [dtClm,cdClm,cntClm];
			mtrOutDataSource.api.readData.url = './mtrOutYear';
			mtrOutDataSource.api.readData.initParams = $("#stsYearFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").hide();
			$("#yearOnly").show();
			mtrOutGridDraw(mtrOutColumns);
		} else if(selectSts.value == "자재별,일별") {
			dtClm.header = '출고일';
			mtrOutColumns = [cdClm,dtClm,cntClm];
			mtrOutDataSource.api.readData.url = './mtrOutMtrD';	
			$("#dateOnly").show();
			$("#monthOnly").hide();
			$("#yearOnly").hide();
			mtrOutGridDraw(mtrOutColumns);
		} else if(selectSts.value == "자재별,월별") {
			dtClm.header = '출고월';
			mtrOutColumns = [cdClm,dtClm,cntClm];
			mtrOutDataSource.api.readData.url = './mtrOutMtrM';
			mtrOutDataSource.api.readData.initParams = $("#stsMonthFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").show();
			$("#yearOnly").hide();
			mtrOutGridDraw(mtrOutColumns);
		} else if(selectSts.value == "자재별,연도별") {
			dtClm.header = '출고연도';
			mtrOutColumns = [cdClm,dtClm,cntClm];
			mtrOutDataSource.api.readData.url = './mtrOutMtrY';	
			mtrOutDataSource.api.readData.initParams = $("#stsYearFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").hide();
			$("#yearOnly").show();
			mtrOutGridDraw(mtrOutColumns);
		} 
	} 
	//제품생산량
	else if(flag == 3) {
		console.log('flag=3');
		cntClm.header = '생산량'
		if(selectSts.value == "일별") {
			dtClm2.header = '제품생산일';
			pdtCntColumns = [dtClm2,cdClm2,cntClm];
			pdtCntDataSource.api.readData.url = './pdtDate';
			$("#dateOnly").show();
			$("#monthOnly").hide();
			$("#yearOnly").hide();
			pdtCntGridDraw(pdtCntColumns);
			flag3Color();
		} else if(selectSts.value == "월별") {
			dtClm2.header = '제품생산월';
			pdtCntColumns = [dtClm2,cdClm2,cntClm];
			pdtCntDataSource.api.readData.url = './pdtMonth';
			pdtCntDataSource.api.readData.initParams = $("#stsMonthFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").show();
			$("#yearOnly").hide();
			pdtCntGridDraw(pdtCntColumns);
			flag3Color();
		} else if(selectSts.value == "연도별") {
			dtClm2.header = '제품생산연도';
			pdtCntColumns = [dtClm2,cdClm2,cntClm];
			pdtCntDataSource.api.readData.url = './pdtYear';
			pdtCntDataSource.api.readData.initParams = $("#stsYearFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").hide();
			$("#yearOnly").show();
			pdtCntGridDraw(pdtCntColumns);
			flag3Color();
			//pdtCntGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
		} else if(selectSts.value == "제품별,일별") {
			dtClm2.header = '제품생산일';
			pdtCntColumns = [cdClm2,dtClm2,cntClm];
			pdtCntDataSource.api.readData.url = './pdtPrdD';	
			$("#dateOnly").show();
			$("#monthOnly").hide();
			$("#yearOnly").hide();
			pdtCntGridDraw(pdtCntColumns);
			flag3Color();
		} else if(selectSts.value == "제품별,월별") {
			dtClm2.header = '제품생산월';
			pdtCntColumns = [cdClm2,dtClm2,cntClm];
			pdtCntDataSource.api.readData.url = './pdtPrdM';
			pdtCntDataSource.api.readData.initParams = $("#stsMonthFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").show();
			$("#yearOnly").hide();
			pdtCntGridDraw(pdtCntColumns);
			flag3Color();
		} else if(selectSts.value == "제품별,연도별") {
			dtClm2.header = '제품생산연도';
			pdtCntColumns = [cdClm2,dtClm2,cntClm];
			pdtCntDataSource.api.readData.url = './pdtPrdY';	
			pdtCntDataSource.api.readData.initParams = $("#stsYearFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").hide();
			$("#yearOnly").show();
			pdtCntGridDraw(pdtCntColumns);
			flag3Color();
			//pdtCntGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
		} 
	}
	//제품불량량	
	else if(flag == 4) {
		cntClm.header = '불량량'
		if(selectSts.value == "일별") {
			dtClm2.header = '제품생산일';
			fltCntColumns = [dtClm2,cdClm2,cntClm];
			fltCntDataSource.api.readData.url = './fltDate';
			$("#dateOnly").show();
			$("#monthOnly").hide();
			$("#yearOnly").hide();
			fltCntGridDraw(fltCntColumns);
		} else if(selectSts.value == "월별") {
			dtClm2.header = '제품생산월';
			fltCntColumns = [dtClm2,cdClm2,cntClm];
			fltCntDataSource.api.readData.url = './fltMonth';
			fltCntDataSource.api.readData.initParams = $("#stsMonthFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").show();
			$("#yearOnly").hide();
			fltCntGridDraw(fltCntColumns);
		} else if(selectSts.value == "연도별") {
			dtClm2.header = '제품생산연도';
			fltCntColumns = [dtClm2,cdClm2,cntClm];
			fltCntDataSource.api.readData.url = './fltYear';
			fltCntDataSource.api.readData.initParams = $("#stsYearFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").hide();
			$("#yearOnly").show();
			fltCntGridDraw(fltCntColumns);
		} else if(selectSts.value == "제품별,일별") {
			dtClm2.header = '제품생산일';
			fltCntColumns = [cdClm2,dtClm2,cntClm];
			fltCntDataSource.api.readData.url = './fltPrdD';	
			$("#dateOnly").show();
			$("#monthOnly").hide();
			$("#yearOnly").hide();
			fltCntGridDraw(fltCntColumns);
		} else if(selectSts.value == "제품별,월별") {
			dtClm2.header = '제품생산월';
			fltCntColumns = [cdClm2,dtClm2,cntClm];
			fltCntDataSource.api.readData.url = './fltPrdM';
			fltCntDataSource.api.readData.initParams = $("#stsMonthFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").show();
			$("#yearOnly").hide();
			fltCntGridDraw(fltCntColumns);
		} else if(selectSts.value == "제품별,연도별") {
			dtClm2.header = '제품생산연도';
			fltCntColumns = [cdClm2,dtClm2,cntClm];
			fltCntDataSource.api.readData.url = './fltPrdY';	
			fltCntDataSource.api.readData.initParams = $("#stsYearFrm").serializeObject();
			$("#dateOnly").hide();
			$("#monthOnly").hide();
			$("#yearOnly").show();
			fltCntGridDraw(fltCntColumns);
		} 
	}
	
})
//---------셀렉트 바뀔때 이벤트 끝--------


//---------Grid 깨지는거 refresh---------
window.setTimeout(function(){mtrInGrid.refreshLayout()}, 100);
window.setTimeout(function(){mtrOutGrid.refreshLayout()}, 100);
window.setTimeout(function(){pdtCntGrid.refreshLayout()}, 100);
window.setTimeout(function(){fltCntGrid.refreshLayout()}, 100);
//---------Grid 깨지는거 refresh끝---------

//--------chart--------
//새로고침후 자재입고량 차트 바로 그려주기
barChartMtrIn();

//차트조회
let btnChart = document.getElementById('btnChart');
btnChart.addEventListener('click', function() {
	let frm = $("#stsMonthFrm2").serializeObject()
	console.log(frm)
	if(frm.startDate <= frm.endDate) {
		if(flag == 1) {
			$('#barChartMtrIn').empty();
			barChartMtrIn();
		} else if(flag == 2) {
			$('#barChartMtrOut').empty();
			barChartMtrOut();
		} else if(flag == 3) {
			$('#barChartPdtCnt').empty();
			barChartPdtCnt();
		} else if(flag == 4) {
			$('#barChartFltCnt').empty();
			barChartFltCnt();
		}
	} else {
		alert("시작날짜가 종료날짜보다 더 큽니다. 다시 입력해주세요");
		return;
	}
})
	
//자재입고량 차트 그리기
function barChartMtrIn() {
	fetch('mtrInMtrMC',{
		method:'POST',
		headers:{
	        "Content-Type": "application/json"
	    },
	    body: JSON.stringify($("#stsMonthFrm2").serializeObject())
	})
	.then(response => response.json())
	.then(result=>{
		mtrInLists = result;
	})
	.then(() => {
		//차트-------------------------------------------------
		const el = document.getElementById('barChartMtrIn');
		  const data = {
		    categories: [],
		    series: [
		      {
		        name: '자재입고량',
		        data: [],
		        colorByCategories: true
		      }
		    ],
		  };
		  
		  for (mtrInList of mtrInLists) {
			  data.categories.push(mtrInList.mtrCd);
			  data.series[0].data.push(mtrInList.cnt);
		  }
		  
		  const options = {
		    chart: { title: '자재입고량', width: 700, height: 400 },
		    series: {
	          dataLabels: {
	            visible: true,
	          },
	        },
		  };

		  const chart = toastui.Chart.columnChart({ el, data, options });
		  //차트 끝-------------------------------------------------
		  
		  //다른차트 안보이게
		  $('#barChartMtrIn').show();
		  $('#barChartMtrOut').hide();
		  $('#barChartPdtCnt').hide();
		  $('#barChartFltCnt').hide();
	});	
}

	
//자재출고량 차트 그리기
function barChartMtrOut() {
	fetch('mtrOutMtrMC',{
		method:'POST',
		headers:{
	        "Content-Type": "application/json"
	    },
	    body: JSON.stringify($("#stsMonthFrm2").serializeObject())
	})
	.then(response => response.json())
	.then(result=>{
		mtrOutLists = result;
	})
	.then(() => {
		//차트-------------------------------------------------
		const el = document.getElementById('barChartMtrOut');
		  const data = {
		    categories: [],
		    series: [
		      {
		        name: '자재출고량',
		        data: [],
		        colorByCategories: true
		      }
		    ],
		  };
		  
		  for (mtrOutList of mtrOutLists) {
			  data.categories.push(mtrOutList.mtrCd);
			  data.series[0].data.push(mtrOutList.cnt);
		  }
		  
		  const options = {
		    chart: { title: '자재출고량', width: 700, height: 400 },
		    series: {
	          dataLabels: {
	            visible: true,
	          },
	        },
		  };

		  const chart = toastui.Chart.columnChart({ el, data, options });
		  //차트 끝-------------------------------------------------
		  
		  //다른차트 안보이게
		  $('#barChartMtrOut').show();
		  $('#barChartMtrIn').hide();
		  $('#barChartPdtCnt').hide();
		  $('#barChartFltCnt').hide();
	});
}	

	
//제품생산량 차트 그리기
function barChartPdtCnt() {
	fetch('pdtPrdMC',{
		method:'POST',
		headers:{
	        "Content-Type": "application/json"
	    },
	    body: JSON.stringify($("#stsMonthFrm2").serializeObject())
	})
	.then(response => response.json())
	.then(result=>{
		pdtCntLists = result;
	})
	.then(() => {
		//차트-------------------------------------------------
		const el = document.getElementById('barChartPdtCnt');
		  const data = {
		    categories: [],
		    series: [
		      {
		        name: '제품생산량',
		        data: [],
		        colorByCategories: true
		      }
		    ],
		  };
		  
		  for (pdtCntList of pdtCntLists) {
			  data.categories.push(pdtCntList.prdCd);
			  data.series[0].data.push(pdtCntList.cnt);
		  }
		  
		  const options = {
		    chart: { title: '제품생산량', width: 700, height: 400 },
		    series: {
	          dataLabels: {
	            visible: true,
	          },
	        },
		  };

		  const chart = toastui.Chart.columnChart({ el, data, options });
		  //차트 끝-------------------------------------------------
		  
		  //다른차트 안보이게
		  $('#barChartPdtCnt').show();
		  $('#barChartMtrIn').hide();
		  $('#barChartMtrOut').hide();
		  $('#barChartFltCnt').hide();
	});	
}

	
	
//제품불량량 차트 그리기
function barChartFltCnt() {
	fetch('fltPrdMC',{
		method:'POST',
		headers:{
	        "Content-Type": "application/json"
	    },
	    body: JSON.stringify($("#stsMonthFrm2").serializeObject())
	})
	.then(response => response.json())
	.then(result=>{
		fltCntLists = result;
	})
	.then(() => {
		//차트-------------------------------------------------
		const el = document.getElementById('barChartFltCnt');
		  const data = {
		    categories: [],
		    series: [
		      {
		        name: '제품불량량',
		        data: [],
		        colorByCategories: true
		      }
		    ],
		  };
		  
		  for (fltCntList of fltCntLists) {
			  data.categories.push(fltCntList.prdCd);
			  data.series[0].data.push(fltCntList.cnt);
		  }
		  
		  const options = {
		    chart: { title: '제품불량량', width: 700, height: 400 },
		    series: {
	          dataLabels: {
	            visible: true,
	          },
	        },
		  };

		  const chart = toastui.Chart.columnChart({ el, data, options });
		  //차트 끝-------------------------------------------------
		  
		  //다른차트 안보이게
		  $('#barChartFltCnt').show();
		  $('#barChartMtrIn').hide();
		  $('#barChartMtrOut').hide();
		  $('#barChartPdtCnt').hide();
	});	
}


  
//--------chart 끝--------

</script>
</body>
</html>