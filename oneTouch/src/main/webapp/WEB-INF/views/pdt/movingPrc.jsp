<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

</head>
<body>
<form id="prcMove" name="prcMove">
	작업일자<input type="date" id="startDate" name="startDate">~ 
	<input type="date" id="endDate" name="endDate"> 
	<button type="button" id="searchBtn" name="searchBtn">검색</button>
</form> 
<div class="row">
	<div id="grid" class="col-11"></div>
	<div id="movingGrid" class="col-4"></div>
</div>

	<script>
///////////////////////////그리드생성/////////////////////////////
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
	//그리드 컬럼 설정	
	const columns = [{
		header : '공정코드',
		name : 'prcCd'
	},{
		header : '라인번호',
		name : 'lineNo',
	},{
		header : '지시번호',
		name : 'instrNo',
	},{
		header : '작업시작일시',
		name : 'workStrDate',
	},{
		header : '작업종료일시',
		name : 'workFinDate',
	},{
		header : '지시수량',
		name : 'instrCnt',
	},{
		header : '생산량',
		name : 'pdtCnt',
	},{
		header : '현재상태',
		name : 'nowPhs',
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
	 	 }  
	});
///////////////////////////그리드생성/////////////////////////////
	//그리드 컬럼 설정	
	const movingColumns = [{
		header : '공정코드',
		name : 'prcCd'
	},{
		header : '라인번호',
		name : 'lineNo',
	},{
		header : '지시번호',
		name : 'instrNo',
	},{
		header : '작업시작일시',
		name : 'workStrDate',
	},{
		header : '작업종료일시',
		name : 'workFinDate',
	},{
		header : '지시수량',
		name : 'instrCnt',
	},{
		header : '생산량',
		name : 'pdtCnt',
	},{
		header : '현재상태',
		name : 'nowPhs',
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
	 	 }  
	});

/////////////////////////////이벤트리스너//////////////////////////////
	searchBtn.addEventListener('click',ev=>{
		let searchData=$('#prcMove').serializeObject();
		fetch('prcMovingList',{
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
	</script>
</body>
</html>