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
.checkwidth{
	width:110px;
}
.row1{
	margin-top: -25px;
}
</style>

</head>
<body>

<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">생산계획조회</h3>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12 grid-margin stretch-card"><!-- <div style="margin-top: 50px; border-top: 2px solid black; border-bottom : 2px solid black; padding: 5px;">  -->
			<div class="card bascard1">
				<div class="card-body">
					<!-- <h4 class="card-title">조회조건</h4> -->
					<form id="prcMove" name="prcMove">
						<div class="rowdiv">
							<label class="labeltext">계획일자</label>
							<input type="text" id="startDate" name="startDate" class="datepicker">
							<label> ~ </label> 
							<input type="text" id="endDate" name="endDate" class="datepicker">
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">지시상태</label>
							<div class="form-check checkwidth" style="display:inline-block">
							    <label class="form-check-label schCondLabel" for="checkedY">
							  		<input type="radio" class="form-check-input" id="checkedY" name="prcCheck" value="Y" checked>
							  		지시완료
									<i class="input-helper"></i>
								</label>
							</div>
							
							<div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="checkedN">
							  		<input type="radio" class="form-check-input" id="checkedN" name="prcCheck" value="N">
							  		미지시
									<i class="input-helper"></i>
								</label>
							</div>
						</div>
						
						<div class="rowdiv" style="display:inline-block">
							<label class="labeltext">자재LOT</label>
							<input id="mtrLot" name="mtrLot" class="inputtext" readonly>
						</div>
						
						<span>
							<button type="button" id="searchBtn" name="searchBtn" class="btn btn-primary mr-2 floatrightbtn">조회</button>
						</span>
						
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="flex row row1">
		<div class = "col-12">
		<h4 class="gridtitle">✔????</h4>
			<hr>
			<div id="grid"></div>
		</div>
	</div>
	<br>
	<div class="flex row">
		<div class = "col-4">
			<h4 class="gridtitle">✔?????</h4>
			<hr>
			<div id="movingGrid"></div>
		</div>
		
		<div class = "col-8">
			<h4 class="gridtitle">✔공정결과</h4>
			<hr>
			<div id="movingPrcGrid"></div>
		</div>
	</div>
</div>

<!-- <form id="prcMove" name="prcMove">
	작업일자<input type="text" id="startDate" name="startDate" class="datepicker">~ 
	<input type="text" id="endDate" name="endDate" class="datepicker"> 
	<label for="checkedY">진행완료</label>
	<input type="radio" id="checkedY" name="prcCheck" value="Y">
	<label for="checkedN">진행중</label>
	<input type="radio" id="checkedN" name="prcCheck" value="N" checked>
	<br/>LOT검색<input type="text" id="mtrLot" name="mtrLot">
	<button type="button" id="searchBtn" name="searchBtn">검색</button>
</form> 
<div class="row">
	<div id="grid" class="col-11"></div>
	<div id="movingGrid" class="col-4"></div>
	<div id="movingPrcGrid" class="col-7"></div>
</div> -->

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
  } );
	
///////////////////////////그리드생성/////////////////////////////
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
	//그리드 컬럼 설정	
	const columns = [{
		header : '라인번호',
		name : 'lineNo',
	},{
		header : '지시번호',
		name : 'instrNo',
	},{
		header : '작업시작일시',
		name : 'workStrDt',
	},{
		header : '지시수량',
		name : 'goalCnt',
	},{
		header : '생산량',
		name : 'pdtCnt',
	}];
	//그리드 생성
	grid = new Grid({
		  el: document.getElementById('grid'),
		  data:null,
		  rowHeaders:['checkbox'],
		  columns,
		  columnOptions: {
			  frozenCount :6,
			  frozenBorderWidth:2
	 	 },
	 	bodyHeight: 159,
		minBodyHeight: 159  
	});
///////////////////////////그리드생성/////////////////////////////
	//그리드 컬럼 설정	
	const movingColumns = [
	{
		header : '라인번호',
		name : 'lineNo',
	}
	,{
		header : '지시번호',
		name : 'instrNo',
	},{
		header : 'LOT번호',
		name : 'mtrLot'
	}];
	//그리드 생성
	movingGrid = new Grid({
		  el: document.getElementById('movingGrid'),
		  data:null,
		  rowHeaders:['checkbox'],
		  columns:movingColumns,
		  columnOptions: {
			  frozenCount :6,
			  frozenBorderWidth:2
	 	 },
	 	bodyHeight: 159,
		minBodyHeight: 159
	});
	//prc moving 그리드
		//그리드 컬럼 설정	
	const movingPrcColumns = [{
		header : '지시번호',
		name : 'instrNo',
	},{
		header : '라인번호',
		name : 'lineNo',
	},{
		header : '공정코드',
		name : 'prcCd',
	},{
		header : '작업시작일',
		name : 'workStrDt',
	},{
		header : '작업종료일',
		name : 'workFinDt',
	},{
		header : '목표수량',
		name : 'goalCnt',
	},{
		header : '생산수량',
		name : 'pdtCnt',
	},{
		header : '불량률',
		name : 'fltCnt',
	},{
		header : '현재상태',
		name : 'nowPhs',
	}];
	//그리드 생성
	movingPrcGrid = new Grid({
		  el: document.getElementById('movingPrcGrid'),
		  data:null,
		  rowHeaders:['checkbox'],
		  columns:movingPrcColumns,
		  columnOptions: {
			  frozenCount :6,
			  frozenBorderWidth:2
	 	 },
	 	bodyHeight: 159,
		minBodyHeight: 159
	});

/////////////////////////////이벤트리스너//////////////////////////////
	searchBtn.addEventListener('click',ev=>{
		let searchData=$('#prcMove').serializeObject();
		fetch('movingSearchList',{
				method:'POST',
				headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(searchData)
		})
		.then(response=>response.json())
		.then(result=>{
			grid.resetData(result);
		})
	})
	//메인그리드 클릭
	grid.on('click',ev=>{

		let searchData=grid.getRow(ev.rowKey);
			fetch('PrcMovingLot',{
				method:'POST',
				headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(searchData)
		})
		.then(response=>response.json())
		.then(result=>{
			movingGrid.resetData(result);
		})
	})
	let v=[]; 
	//무빙그리드 클릭 
	movingGrid.on('click',ev=>{
		console.log(ev.rowKey)
		console.log("뭐지?")
		if(movingGrid.getValue(ev.rowKey,'mtrLot') != v[0]){
			console.log("배열초기화")
			v.length=0;
		}
		v.push(movingGrid.getValue(ev.rowKey,'mtrLot'));
		console.log(v);
		console.log(v.length);

		
		let searchData=movingGrid.getRow(ev.rowKey);	
		console.log(searchData)
		 fetch('prcMovingNonRoop',{
			method:'POST',
			headers:{
			"Content-Type": "application/json",
		},
		body:JSON.stringify(searchData)
		})
		.then(response=>response.json())
		.then(result=>{
			movingPrcGrid.resetData(result);
				console.log(v.length)
				movingShowFnc(movingGrid.getRow(ev.rowKey));
		}) 
		
		
	})
	
	function movingShowFnc(ev){
		console.log(ev)
		let searchData=movingGrid.getRow(ev);
		fetch('prcMovingShow',{
			method:'POST',
			headers:{
			"Content-Type": "application/json",
		},
		body:JSON.stringify(searchData)
		})
		.then(response=>response.json())
		.then(result=>{
			console.log(result)
			if(v[0]==ev.mtrLot || v[0]!=v[1]){
				console.log("if들어옴")
				movingPrcGrid.resetData(result);
				movingShowFnc(ev);
			}else{v.length=1||result.length==0}
			
			
			
		})
	}
	
	
	
	</script>
</body>
</html>