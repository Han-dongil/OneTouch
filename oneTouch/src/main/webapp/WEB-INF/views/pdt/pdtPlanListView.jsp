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
	<form id="planSearchFrm" name="planSearchFrm">
		계획일자<input type="text" id="startDate" name="startDate" class="datepicker"> ~
		<input type="text" id="endDate" name="endDate" class="datepicker"> 
		<input type="radio" id="checkedN" name="nowPhs" value="N" checked>
		<label for="checkedN">미지시</label>
		<input type="radio" id="checkedY" name="nowPhs" value="Y">
		<label for="checkedY">지시완료</label>
		<input type="radio" id="checked" name="nowPhs" value="">
		<label for="checked">전체</label>
		<button type="button" id="findPlan" name="findPlan">계획서 조회</button>
		<br>
		제품코드<input type="text" id="prdCd" name="prdCd">
		<button type="button" id="prdPlan" name="prdPlan">제품별 조회</button>
	</form>
	<div id="plan-dialog-form" title="계획서 조회">계획서 조회
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
		header : '계획서번호',
		name : 'planNo',
        align:'center',
	},{
		header : '주문번호',
		name : 'ordShtNo',
 		editor : 'text'	,
        align:'center',	
	},{
		header : '납기일자',
		name : 'dueDate',
 		editor : 'text',
        align:'center',
	},{
		header : '계획일자',
		name : 'planDate',
 		editor : 'text',
        align:'center',
	},{
		header : '작업우선순위',
		name : 'workProt',
 		editor : 'text',
 		hidden : true,
        align:'center',
	},{
		header : '현재상태',
		name : 'nowPhs',
 		editor : 'text',
 		hidden : true,
        align:'center',
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
		header : '계획서번호',
		name : 'planNo',
        align:'center',
		
	},{
		header : '라인번호',
		name : 'lineNo',
 		editor : 'text'	,
        align:'center',	
	},{
		header : '제품코드',
		name : 'prdCd',
 		editor : 'text',
        align:'center',
	},{
		header : '필요수량',
		name : 'needCnt',
 		editor : 'text',
        align:'right',
	},{
		header : '지시수량',
		name : 'instrCnt',
 		editor : 'text',
        align:'right',
	},{
		header : '작업시작일',
		name : 'workStrDate',
 		editor : 'text',
        align:'center',
	},{
		header : '가동시간',
		name : 'workPlanTime',
 		editor : 'text',
        align:'center',
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
	planDialog = $( "#plan-dialog-form" ).dialog({
		autoOpen: false,
		modal:true,
		height: 500,
		width: 1000,
		buttons:{"save":function(){alert("save")}}
	});
	
	//////////////////////////////이벤트리스너/////////////////////////////////
	findPlan.addEventListener("click",ev=>{
		planDialog.dialog("open");
		modalGrid.refreshLayout();
		//계획서 조회
		let searchData=$('#planSearchFrm').serializeObject();
		fetch('planSearchList',{
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
	prdPlan.addEventListener('click',ev=>{
		let searchData=$('#planSearchFrm').serializeObject();
		searchData.planNo='';
		fetch('planDtlList',{
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
		fetch('./planDtlList',{
				method:'POST',
				headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(modalGrid.getRow(ev.rowKey))
		})
		.then(response=>response.json())
		.then(result=>{
			mainGrid.resetData(result);
			planDialog.dialog("close");
		})		
	})
	
	</script>
</body>
</html>