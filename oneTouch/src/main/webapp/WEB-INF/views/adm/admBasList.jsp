<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공통관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/modal.js"></script>
<style type="text/css">
.bascard{
	margin-bottom: 10px;
}
.bascard1{
	height: 125px;
}
.newalign{
	margin-bottom: 0rem !important;
}

</style>

</head>
<body>
<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">공통자료관리</h3>
				</div>
			</div>
		</div>
	</div>
	<div class=" flex row">
		<div class = "col-4">
			<div class="card bascard">
				<div class="card-body bascard1">
					<h4 class="card-title">기초코드</h4>
					<span style="padding-top: 10px;">
						<label class="schCondLabel">기초코드명</label>&nbsp;&nbsp;
						<input id="basNm" name="basNm" class="inputtext">
					</span>
					<span>
						<button type="button" id="btnSrc" class="btn btn-primary mr-2 floatrightbtn">조회</button>
					</span>
				</div>
			</div>
			<span class="floatright">
				<button type="button" id="btnAddBas" class="btn btn-main newalign">추가</button>
				<button type="button" id="btnDelBas" class="btn btn-main newalign">삭제</button>
				<button type="button" id="btnSaveBas" class="btn btn-primary newalign">저장</button>
			</span>
			<br><br>
			<hr>
			<div id="grid1"></div>
		</div>
		
		<div class= "col-8">
			<div class="card">
				<div class="card-body cardtitle">
					<h4 class="card-title cardtitleh4">상세코드</h4>
				</div>				
			</div>
			<br>
			<span class="floatright">
				<button type="button" id="btnAddDtl" class="btn btn-main newalign">추가</button>
				<button type="button" id="btnDelDtl" class="btn btn-main newalign">삭제</button>
				<button type="button" id="btnSaveDtl" class="btn btn-primary newalign">저장</button>
			</span>
			<br><br>
			<hr>
			<div id="grid2"></div>
			<div id="dialog-form" title="title"></div>
		</div>
	</div>
	
	
	
</div>

<!-- <br><h3>[공통자료관리]</h3><hr>
<div class="flex row">
	<div class = "col-4">
		<h4>✔기초코드</h4>
		<div align="right" style="margin-right: 3%;">
			<label>기초코드명&nbsp;</label>
			<input id="basNm" name="basNm" style="width: 100px;">
			<button type="button" id="btnSrc">검색</button>
		</div><br>
		<div id="grid1"></div>
		<br>
	</div>
	<div class= "col-8">
		<h4>✔상세코드</h4>
		<div align="right" style="margin-right: 3%;">
			<button type="button" id="btnAdd">추가</button>
			<button type="button" id="btnSave">저장</button>
		</div><br>
		<div id="grid2"></div>
	</div>
</div> -->
<script type="text/javascript">
	let basCodeVal;
	let basCode;
	let basName;
	let rowk;
	let Grid = tui.Grid;
	
 	Grid.applyTheme('default',{
		cell:{
			header:{
				background: '#4B49AC',
	            text: '#fff'
			}
		}
	}) 
	
	const columns1 = [{
		
			header : '기초코드',
			name : 'basCd',
			sortable : true,
			editor: 'text'
		},
		{
			header : '기초코드명',
			name : 'basNm',
			sortable : true,
			editor: 'text'
		},
		{
			header : '기초코드설명',
			name : 'basCmt',
			editor: 'text'
		}]
	
	const columns2 = [{
		
			header : '상세코드',
			name : 'dtlCd',
			editor : 'text'
		},
		{
			header : '상세코드명',
			name : 'dtlNm',
			editor : 'text',
			width : 180
		},
		{
			header : '코드설명란',
			name : 'dtlCmt',
			editor: 'text',
			width : 150
		},
		{
			header : '표시순서',
			name : 'seq',
			editor: 'text'
		},
		{
			header : '사용여부',
			name : 'useYn',
			editor: {
				type: 'radio',
				options: {
			        listItems: [
			          { text: 'Y', value: 'Y' },
			          { text: 'N', value: 'N' }
			        ]
			     }
			}
		},
		{
			header : '기초코드',
			name : 'basCd',
			hidden: true
		}]
	
	const dataSource1 = {
		api: {
			readData: {
				url:'./admBasList',
				method: 'GET'
			},
			modifyData: {
				url: './basAllModifyData', 
				method: 'POST'
			}
		},
		contentType: 'application/json'
	}
	
	const dataSource2 = {
			api: {
				readData:{
					url:'./admBasDtlList',
					method:'GET',
				},
				modifyData: { 
					url: './basDtlModifyData', 
					method: 'POST'}
			},
			contentType: 'application/json',
			initialRequest: false
	}
	
	const grid1 = new Grid({
		el: document.getElementById('grid1'),
		data: dataSource1,
		rowHeaders : [ 'checkbox' ],
		columns: columns1,
		bodyHeight: 530,
		minBodyHeight: 530
	});
	
	const grid2 = new Grid({
		el: document.getElementById('grid2'),
		data: dataSource2,
		rowHeaders : [ 'checkbox' ],
		columns: columns2,
		bodyHeight: 530,
		minBodyHeight: 530
	})
	
	grid2.on('editingStart', (ev) => {
		if(ev.columnName == 'dtlCd') {
			var value = grid2.getValue(ev.rowKey, 'dtlCd');
			if(value != null) {
				console.log(value);
				alert('상세코드는 수정이 불가능합니다');
				ev.stop();
			}
		}
	})

	//검색버튼
	btnSrc.addEventListener("click", function() {
		basName = {'basNm' : $('#basNm').val()};
		console.log("검색한값: "+$('#basNm').val());
		//console.log(basName);
		grid1.readData(1,basName,true);
	})
	
	//기초코드명 클릭하면 상세코드 받아옴
	grid1.on("click", (ev) => {
		if(ev.columnName === 'basCd' || ev.columnName === 'basNm' || ev.columnName === 'basCmt') {
			basCodeVal = grid1.getValue(ev.rowKey,'basCd');
			basCode = {'basCd' : basCodeVal};
			grid2.readData(1,basCode,true);
		}
	})
	
/* 	grid1.on('dblclick', (ev) => {
		mBas2();
		$('#ui-id-1').html('공통기초코드');
	})
	
	//모달설정
	let dialog;
	dialog = $( "#dialog-form" ).dialog({
		autoOpen : false,
		modal : true,
		resizable: false,
		height: "auto",
		width: 700,
		height: 400
	}); */
	
	/* 상세코드 기능 */	
	//저장버튼
	btnSaveDtl.addEventListener("click", function() {
		grid2.blur();
		grid2.request('modifyData');
	})
	
	//추가버튼
	btnAddDtl.addEventListener("click", function() {
		grid2.appendRow({});
		rowk = grid2.getRowCount() - 1;
		console.log(basCode);
		grid2.setValue(rowk, "basCd", basCodeVal, false);
		console.log(grid2.getValue(rowk, "basCd"));
	})
	
	//삭제버튼
	btnDelDtl.addEventListener("click", function() {
		grid2.removeCheckedRows(true);
	})
	
	/* 기초코드 기능 */
	//저장버튼
	btnSaveBas.addEventListener("click", function() {
		grid1.blur();
		grid1.request('modifyData');
	})
	
	//추가버튼
	btnAddBas.addEventListener("click", function() {
		grid1.appendRow({});
	})	
	
	//삭제버튼
	btnDelBas.addEventListener("click", function() {
		grid1.removeCheckedRows(true);
	})
	
</script>
</body>
</html>