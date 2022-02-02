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
	<form id="planSearchFrm" name="planSearchFrm">
		계획일자<input type="date" id="startDate" name="startDate"> ~
		<input type="date" id="endDate" name="endDate"> 
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
		name : 'planNo'
	},{
		header : '주문번호',
		name : 'ordShtNo',
 		editor : 'text'		
	},{
		header : '납기일자',
		name : 'dueDate',
 		editor : 'text'
	},{
		header : '계획일자',
		name : 'planDate',
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
		header : '계획서번호',
		name : 'planNo'
	},{
		header : '라인번호',
		name : 'lineNo',
 		editor : 'text'		
	},{
		header : '제품코드',
		name : 'prdCd',
 		editor : 'text'
	},{
		header : '필요수량',
		name : 'needCnt',
 		editor : 'text'
	},{
		header : '지시수량',
		name : 'instrCnt',
 		editor : 'text'
	},{
		header : '작업시작일',
		name : 'workStrDate',
 		editor : 'text'
	},{
		header : '가동시간',
		name : 'workPlanTime',
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