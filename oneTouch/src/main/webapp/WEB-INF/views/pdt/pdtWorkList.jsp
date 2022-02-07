<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<c:set var="path" value="${pageContext.request.contextPath}"/>		
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script type="text/javascript"
	src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<link rel="stylesheet" href="${path}/resources/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="${path}/resources/jquery-ui/images">
</head>
<body>
	<form id="workSearchFrm" name="planSearchFrm">
		계획일자<input type="text" id="startDate" name="startDate" class="datepicker calander"> ~
		<input type="text" id="endDate" name="endDate" class="datepicker calander"> 
		<input type="radio" id="checkedN" name="nowPhs" value="N" checked>
		<label for="checkedN">진행중</label>
		<input type="radio" id="checkedY" name="nowPhs" value="Y">
		<label for="checkedY">공정완료</label>
		<input type="radio" id="checked" name="nowPhs" value="">
		<label for="checked">전체</label>
		<button type="button" id="findWork" name="findWork">생산지시 조회</button>
		<br>
		제품코드<input type="text" id="prdCd" name="prdCd">
		<button type="button" id="prdWork" name="prdWork">제품별 조회</button>
	</form>
	<div id="work-dialog-form" title="생산지시 조회">생산지시 조회
		<div id="modalGrid"></div>
	</div>
	<div id="mainGrid"></div>
	<script>
	$( function() {
		    $( ".datepicker" ).datepicker({
		      dateFormat:"yy-mm-dd",
		      regional:"ko",
              dateFormat: 'yy-mm-dd' //달력 날짜 형태
            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
            ,changeYear: true //option값 년 선택 가능
            ,changeMonth: true //option값  월 선택 가능                
            ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
            //,buttonText: "선택" //버튼 호버 텍스트              
            ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
            ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
            ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후) 
		   //  ,beforeShowDay: disableAllTheseDays
		    /*  ,buttonImage: "/oneTouch/resources/template/images/cal_lb_sm.png"
    	,buttonImageOnly: true */

		    });
	  } );
	let Grid = tui.Grid;
	//그리드 테마적용
	Grid.applyTheme('striped',{
		cell:{
			header:{
				background:'#eef'
			},
			evenRow:{
				background:'#fee'
			}
		}
	})
	///////////////////////////////////////////그리드//////////////////////////////////////////
	
	const modalColumns = [{
		header : '지시번호',
		name : 'instrNo'
	},{
		header : '계획번호',
		name : 'planNo',
 		editor : 'text'		
	},{
		header : '지시일자',
		name : 'instrDate',
 		editor : 'text'
	},{
		header : '생산완료일자',
		name : 'pdtFinDate',
 		editor : 'text'
	},{
		header : '작업우선순위',
		name : 'workProt',
 		editor : 'text'
	},{
		header : '현재상태',
		name : 'nowPhs',
 		editor : 'text'
	}];
	//그리드 생성
	modalGrid = new Grid({
		  el: document.getElementById('modalGrid'),
		  data: null,
		  rowHeaders:['checkbox'],
		  columns:modalColumns,
		  columnOptions: {
			  frozenCount :6,
			  frozenBorderWidth:2
		  }
		});
	const mainColumns = [{
		header : '지시번호',
		name : 'instrNo'
	},{
		header : '라인번호',
		name : 'lineNo',
 		editor : 'text'		
	},{
		header : '제품코드',
		name : 'prdCd',
 		editor : 'text'
	},{
		header : '지시수량',
		name : 'instrCnt',
 		editor : 'text'
	},{
		header : '생산수량',
		name : 'pdtCnt',
 		editor : 'text'
	},{
		header : '작업시작일',
		name : 'workStrDate',
 		editor : 'text'
	},{
		header : '가동시간',
		name : 'workStrTime',
 		editor : 'text'
	}];
	//메인그리드 생성
	mainGrid = new Grid({
		  el: document.getElementById('mainGrid'),
		  data: null,
		  rowHeaders:['checkbox'],
		  columns:mainColumns,
		  columnOptions: {
			  frozenCount :6,
			  frozenBorderWidth:2
		  }
		});	
	/////////////////////////////////모달///////////////////////////////////////
    //계획서검색 모달창
	workDialog = $( "#work-dialog-form" ).dialog({
		autoOpen: false,
		modal:true,
		height: 500,
		width: 1000,
		buttons:{"save":function(){alert("save")}}
	});
	
	//////////////////////////////이벤트리스너/////////////////////////////////
	findWork.addEventListener("click",ev=>{
		workDialog.dialog("open");
		modalGrid.refreshLayout();
		//계획서 조회
		let searchData=$('#workSearchFrm').serializeObject();
		fetch('workList',{
				method:'POST',
				headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(searchData)
		})
		.then(response=>response.json())
		.then(result=>{
			modalGrid.resetData(result);
		})
	})
	//제품별 디테일조회
	prdWork.addEventListener('click',ev=>{
		let searchData=$('#workSearchFrm').serializeObject();
		searchData.workNo='';
		fetch('workSearchList',{
				method:'POST',
				headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(searchData)
		})
		.then(response=>response.json())
		.then(result=>{
			mainGrid.resetData(result);
		})
	})
	//모달 계획서 클릭시 디테일 메인에띄움
	modalGrid.on('click',ev=>{
		fetch('workSearchList',{
				method:'POST',
				headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(modalGrid.getRow(ev.rowKey))
		})
		.then(response=>response.json())
		.then(result=>{
			mainGrid.resetData(result);
			workDialog.dialog("close");
		})		
	})
	
	</script>
</body>
</html>