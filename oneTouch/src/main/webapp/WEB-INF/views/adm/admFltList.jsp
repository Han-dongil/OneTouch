<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>불량코드관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/modal.js"></script>
</head>
<body>
<br>
<h3>[불량코드관리]</h3><hr>
<div align="right" style="margin-right: 3%;">
	<button type="button" id="btnAdd">추가</button>
	<button type="button" id="btnDel">삭제</button>
	<button type="button" id="btnSave">저장</button>
</div>
<h4 align="left">✔불량코드리스트</h4>
<div id="grid"></div>
<div id="dialog-form" title="title"></div>
<script type="text/javascript">
	let Grid = tui.Grid;
	
	Grid.applyTheme('default',{
		cell:{
			header:{
				background:'#eef'
			}
		}
	}) 
	
	
	const columns = [{
		header : '불량코드',
		name : 'fltCd',
		sortable : true
	},
	{
		header : '불량명',
		name : 'fltNm',
		editor: 'text'
	},
	{
		header : '불량내역',
		name : 'fltMtt',
		editor: 'text',
		width : 300
	},
	{
		header : '불량구분',
		name : 'fltSect',
		editor : {
			type: 'radio',
			options: {
		        listItems: [
		          { text: '자재불량', value: '자재불량' },
		          { text: '생산불량', value: '생산불량' }
		        ]
		     }
		}
	},
	{
		header : '발생공정명',
		name : 'prcNm'
	},
	{
		header : '비고',
		name : 'cmt',
		editor: 'text'
	},
	{
		header : '표시순서',
		name : 'seq',
		editor: 'text',
		sortable : true
	},
	{
		header : '발생공정코드',
		name : 'prcCd',
		hidden : true
	}]
	
	//전체조회
	var dataSource = {
			api: {
				readData: {
					url:'./admFltList',
					method: 'GET'},
				modifyData: { 
					url: './fltModifyData', 
					method: 'POST'}  
			},
			contentType: 'application/json'
	 };
	
	//그리드생성
	let grid = new Grid({
	  el: document.getElementById('grid'),
	  data: dataSource, 
	  rowHeaders : [ 'checkbox' ],
	  columns
	}); 
	
	
	let dialog;
	dialog = $( "#dialog-form" ).dialog({
		autoOpen : false,
		modal : true,
		resizable: false,
		height: "auto",
		width: 800
	});
	
	//사용공정명 더블클릭 모달띄우기
	grid.on("dblclick", (ev)=> {
		fltSectVal = grid.getValue(ev.rowKey, 'fltSect');
		if (ev.columnName === 'prcNm' && fltSectVal == '생산불량') {
			rowk = ev.rowKey;
			mPrc();
			$('#ui-id-1').html('발생공정명');
		}
	})
	
	//사용공정명 더블클릭한 모달창 안에서 더블클릭
	function getModalPrc(param) {
		console.log("더블클릭공정");
		grid.setValue(rowk, "prcCd", param.prcCd, false);
		grid.setValue(rowk, "prcNm", param.prcNm, false);
		dialog.dialog("close");	
	}
	
	//삭제버튼
	btnDel.addEventListener("click", function() {
		grid.removeCheckedRows(true);
	})
	
	//저장버튼
	btnSave.addEventListener("click", function() {
		grid.blur();
		grid.request('modifyData');
	})
	
	//등록버튼
	btnAdd.addEventListener("click", function() {
		grid.appendRow({})
	})	

	
</script>
</body>
</html>