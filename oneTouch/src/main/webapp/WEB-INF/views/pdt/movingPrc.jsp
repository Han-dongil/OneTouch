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
	<label for="checkedY">진행완료</label>
	<input type="radio" id="checkedY" name="prcCheck" value="Y">
	<label for="checkedN">진행중</label>
	<input type="radio" id="checkedN" name="prcCheck" value="N">
	<button type="button" id="searchBtn" name="searchBtn">검색</button>
</form> 
<div class="row">
	<div id="grid" class="col-11"></div>
	<div id="movingGrid" class="col-4"></div>
	<div id="movingPrcGrid" class="col-7"></div>
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
	 	 }  
	});
///////////////////////////그리드생성/////////////////////////////
	//그리드 컬럼 설정	
	const movingColumns = [{
		header : 'LOT번호',
		name : 'mtrLot'
	},{
		header : '지시번호',
		name : 'instrNo',
	},{
		header : '라인번호',
		name : 'lineNo',
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
	 	 }  
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
		console.log("dddddddddddddd")
		if(movingGrid.getValue(ev.rowKey,'instrNo') != v[0]){
			v.length=0;
		}
		v.push(movingGrid.getValue(ev.rowKey,'instrNo'));
		console.log(v);
		console.log(v.length);

		
		let searchData=movingGrid.getRow(ev.rowKey);		
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
			if(movingGrid.getValue(ev.rowKey,'instrNo') == v[0] && v.length==1){
				console.log("aaaaaaaaaaaaaaaaa")
				console.log(v.length)
				movingShowFnc(movingGrid.getValue(ev.rowKey,'instrNo'));
				
				
			}
			else{
				console.log("a22222222222222")
				console.log(v.length)
			}
		}) 
		
		
	})
	
	function movingShowFnc(ev){
		console.log(ev)
		console.log("ddddd")
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
			if(v[0]==ev ){
				movingPrcGrid.resetData(result);
				movingShowFnc(ev);
			}
			
			
			
		})
	}
	
	</script>
</body>
</html>