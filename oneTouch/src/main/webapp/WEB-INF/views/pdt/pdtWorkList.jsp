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
	<form id="workSearchFrm" name="planSearchFrm">
		계획일자<input type="date" id="startDate" name="startDate"> ~
		<input type="date" id="endDate" name="endDate"> 
		<select name="nowPhs" id="nowPhs">
			<option value="N">지시완료</option>
			<option value="Y">공정시작</option>
		</select>
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
	},{
		header : 'bom코드',
		name : 'bomCd',
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