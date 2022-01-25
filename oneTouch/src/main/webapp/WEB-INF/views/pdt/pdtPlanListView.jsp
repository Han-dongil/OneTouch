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
		<input type="date" id="endDate" name="endDate"> 제품코드
		<input type="text" id="prdCd" name="prdCd">
		<select name="phs" id="phs">
			<option value="N">미지시</option>
			<option value="Y">지시완료</option>
		</select>
		<button type="button" id="findPlan" name="findPlan">계획서 조회</button>
	</form>
		<div id="plan-dialog-form" title="계획서 조회">계획서 조회
			<div id="modalGrid"></div>
		</div>

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
		name : 'ordShtNo'
	},{
		header : '주문번호',
		name : 'dueDate',
 		editor : 'text'		
	},{
		header : '납기일자',
		name : 'ordDate',
 		editor : 'text'
	},{
		header : '현재상태',
		name : 'compCd',
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
	/////////////////////////////////모달///////////////////////////////////////
    //계획서검색 모달창
	planDialog = $( "#plan-dialog-form" ).dialog({
		autoOpen: false,
		modal:true,
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
			console.log(result);
		})
	})
	</script>
</body>
</html>