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
<script src="${path}/resources/js/grid-common.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<link rel="stylesheet" href="${path}/resources/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="${path}/resources/jquery-ui/images">

<style>
.labeltext{
width: 100px !important;
}
.colline2{
	margin-left: 60px;
	width: 100px !important;
}
.bascard1{
	height:176px;
}
.rowdiv{
	margin-bottom: 10px !important;
}
hr{
	margin-top: -20px;
}
.checkwidth{
	width:110px;
}
</style>

</head>
<body>

<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">생산지시관리</h3>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12 grid-margin stretch-card"><!-- <div style="margin-top: 50px; border-top: 2px solid black; border-bottom : 2px solid black; padding: 5px;">  -->
			<div class="card bascard1">
				<div class="card-body">
					<!-- <h4 class="card-title">조회조건</h4> -->
					<form id="workSearchFrm" name="workSearchFrm">
						<div class="rowdiv">
							<label class="labeltext">지시일자</label>
							<input type="text" id="startDate" name="startDate" class="datepicker">
							<label> ~ </label> 
							<input type="text" id="endDate" name="endDate" class="datepicker">
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">지시상태</label>
							<div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="checked">
							  		<input type="radio" class="form-check-input" id="checked" name="nowPhs" value="" checked>
							  		전체
									<i class="input-helper"></i>
								</label>
							</div>
							                
							<div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="checkedN">
							  		<input type="radio" class="form-check-input" id="checkedN" name="nowPhs" value="N">
							  		미지시
									<i class="input-helper"></i>
								</label>
							</div>
							                
							<div class="form-check checkwidth" style="display:inline-block">
							    <label class="form-check-label schCondLabel" for="checkedY">
							  		<input type="radio" class="form-check-input" id="checkedY" name="nowPhs" value="Y">
							  		공정진행
									<i class="input-helper"></i>
								</label>
							</div>
						</div>
						
						<div class="rowdiv" style="display:inline-block">
							<label class="labeltext">제품코드</label>
							<input id="prdCd" name="prdCd" class="inputtext">
							<!-- <button type="button" id="btnPrcCd" class="btn btn-primary mr-2 minibtn" onclick="inComList()"><i class="icon-search"></i></button>
							<label class="labeltext colline2">제품명</label>
							<input id="prdNm" name="prdNm" class="inputtext" readonly> -->
						</div>
						
						<span>
							<button type="button" id="searchBtn" name="searchBtn" class="btn btn-primary mr-2 floatrightbtn">조회</button>
						</span>
					</form>
				</div>
			</div>
		</div>
	</div>
	<hr>
	
	<div id="work-dialog-form" title="생산지시 조회">생산지시 조회
		<div id="modalGrid"></div>
	</div>
	<div id="mainGrid"></div>
</div>

	<!-- <form id="workSearchFrm" name="planSearchFrm">
		지시일자<input type="text" id="startDate" name="startDate" class="datepicker calander"> ~
		<input type="text" id="endDate" name="endDate" class="datepicker calander"> 
		<input type="radio" id="checked" name="nowPhs" value="" checked>
		<label for="checked">전체</label>
		<input type="radio" id="checkedN" name="nowPhs" value="N">
		<label for="checkedN">미진행</label>
		<input type="radio" id="checkedY" name="nowPhs" value="Y">
		<label for="checkedY">공정진행</label>
		<button type="button" id="searchBtn" name="searchBtn">조회</button>
		<br>
		제품코드<input type="text" id="prdCd" name="prdCd">
		<button type="button" id="prdWork" name="prdWork">제품별 조회</button>
	</form>
	<div id="work-dialog-form" title="생산지시 조회">생산지시 조회
		<div id="modalGrid"></div>
	</div>
	<div id="mainGrid"></div>  -->
	
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
		   //  ,beforeShowDay: disableAllTheseDays
		    /*  ,buttonImage: "/oneTouch/resources/template/images/cal_lb_sm.png"
    	,buttonImageOnly: true */
		    	       
		    });
       	   $('.datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
	        $('#startDate').datepicker('setDate', 'today-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
	  } );
	/* let Grid = tui.Grid; */
	//그리드 테마적용
	/* Grid.applyTheme('striped',{
		cell:{
			header:{
				background:'#eef'
			},
			evenRow:{
				background:'#fee'
			}
		}
	}) */
	///////////////////////////////////////////그리드//////////////////////////////////////////
	
	const modalColumns = [{
		header : '지시번호',
		name : 'instrNo',
        align:'center',
	},{
		header : '계획번호',
		name : 'planNo',
 		editor : 'text'	,
        align:'center',	
	},{
		header : '지시일자',
		name : 'instrDate',
 		editor : 'text',
        align:'center',
	},{
		header : '생산완료일자',
		name : 'pdtFinDate',
 		editor : 'text',
        align:'center',
	},{
		header : '작업우선순위',
		name : 'workProt',
 		editor : 'text',
 		hidden : true
	},{
		header : '현재상태',
		name : 'nowPhs',
 		editor : 'text',
        align:'center',
	}];
	//그리드 생성
	modalGrid = new Grid({
		  el: document.getElementById('modalGrid'),
		  data: null,
		  columns:modalColumns,
	      scrollY:true,
		  minBodyHeight : 250,
		  bodyHeight : 250,
		  columnOptions: {
			  frozenCount :6,
			  frozenBorderWidth:2
		  }
		});
	const mainColumns = [{
		header : '지시번호',
		name : 'instrNo',
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
		header : '지시수량',
		name : 'instrCnt',
 		editor : 'text',
        align:'right',
	},{
		header : '생산수량',
		name : 'pdtCnt',
 		editor : 'text',
        align:'right',
	},{
		header : '작업시작일',
		name : 'workStrDate',
 		editor : 'text',
        align:'center',
	},{
		header : '가동시간',
		name : 'workStrTime',
 		editor : 'text',
        align:'center',
 		hidden : true
	}];
	//메인그리드 생성
	mainGrid = new Grid({
		  el: document.getElementById('mainGrid'),
		  data: null,
		  columns:mainColumns,
	      scrollY:true,
		  minBodyHeight : 477,
		  bodyHeight : 477,
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
		height: 400,
		width: 1000,
	});
	
	//////////////////////////////이벤트리스너/////////////////////////////////
	searchBtn.addEventListener('click',ev=>{
		let searchData=$('#workSearchFrm').serializeObject();
		
		if(document.getElementById('prdCd').value!=''){
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
		}else{
			workDialog.dialog("open");
			modalGrid.refreshLayout();
			fetch('workList',{
				method:'POST',
				headers:{
				"Content-Type": "application/json",
			},
				body:JSON.stringify(searchData)
			})
			.then(response=>response.json())
			.then(result=>{
				console.log("sssss")
				modalGrid.resetData(result);
			})
		}
	})
/* 	findWork.addEventListener("click",ev=>{
		
		
		//계획서 조회
		

	})
	//제품별 디테일조회
	prdWork.addEventListener('click',ev=>{
		
	}) */
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