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
<link rel="stylesheet" href="${path}/resources/jquery-ui/MonthPicker.min.css">

<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/grid-common.js"></script>
<!-- <script src="https://code.jquery.com/jquery-1.12.1.min.js"></script> -->
<script src="${path}/resources/jquery-ui/MonthPicker.min.js"></script>
<script src="https://cdn.rawgit.com/digitalBush/jquery.maskedinput/1.4.1/dist/jquery.maskedinput.min.js"></script>

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
		<input type="text" id="startDate" name="startDate" class="datepicker jquerydtpicker">&nbsp;
		<input id="ImageButton" type="text" class="Default"/>
		<label> ~ </label>&nbsp;
		<input type="text" id="endDate" name="endDate" class="datepicker jquerydtpicker">&nbsp;
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
$(function() {
    //input을 datepicker로 선언
    $(".datepicker").datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
        ,changeYear: true //option값 년 선택 가능
        ,changeMonth: true //option값  월 선택 가능                
        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
        ,buttonImage: "/oneTouch/resources/template/images/cal_w_sm.png" //"http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
        ,buttonImageOnly: false //버튼 이미지만 깔끔하게 보이게함
        //,buttonText: "선택" //버튼 호버 텍스트              
        ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
        ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
    });                    
    
    //초기값을 오늘 날짜로 설정해줘야 합니다.
    $('#startDate').datepicker('setDate', 'today-1M');
    $('#endDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
    	       
    
});

var options = {
        MonthFormat: 'yymm',       
        ShowIcon: false,
        i18n: {
            year: '년도',
            prevYear: '이전년도',
            nextYear: '다음년도',
            next12Years: '다음 12년',
            prev12Years: '이전 12년',
            nextLabel: '다음',
            prevLabel: '이전',
            buttonText: 'Open Month Chooser',
            jumpYears: '년도로 이동',
            backTo: '뒤로',
            months: ['1 월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
        }
    };
    
//$('.Default').MonthPicker(options);  
$(document).ready(function(){
	$("#ImageButton").MonthPicker({
	    Button: '<img class="icon" src="images/icon.gif" />'
	});
	
})

    
    
/* function getDateStr(dt){
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
document.getElementById('endDate').value = today(); */

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