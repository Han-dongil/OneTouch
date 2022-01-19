<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공통관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

</head>
<body>
<br><h3>[공통자료관리]</h3><hr>
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
</div>
<script type="text/javascript">
	let basCodeVal;
	let basCode;
	let basName;
	let rowk;
	let Grid = tui.Grid;
	
 	Grid.applyTheme('default',{
		cell:{
			header:{
				background:'#eef'
			}
		}
	}) 
	
	const columns1 = [{
		
			header : '기초코드',
			name : 'basCd',
			sortable : true
		},
		{
			header : '기초코드명',
			name : 'basNm',
			sortable : true
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
					url: './basModifyData', 
					method: 'POST'}
			},
			contentType: 'application/json',
			initialRequest: false
	}
	
	const grid1 = new Grid({
		el: document.getElementById('grid1'),
		data: dataSource1,
		columns: columns1,
		bodyHeight: 500,
		minBodyHeight: 500
	});
	
	const grid2 = new Grid({
		el: document.getElementById('grid2'),
		data: dataSource2,
		columns: columns2,
		bodyHeight: 505,
		minBodyHeight: 505
	})
	
	grid2.on('editingStart', (ev) => {
		if(ev.columnName == 'dtlCd') {
			var value = grid2.getValue(ev.rowKey, 'dtlCd');
			if(value != null) {
				console.log(value);
				alert('공정코드는 수정이 불가능합니다');
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
		if(ev.columnName === 'basCd' || ev.columnName === 'basNm') {
			basCodeVal = grid1.getValue(ev.rowKey,'basCd');
			basCode = {'basCd' : basCodeVal};
			grid2.readData(1,basCode,true);
		}
	})
	
	//저장버튼
	btnSave.addEventListener("click", function() {
		grid2.blur();
		grid2.request('modifyData');
	})
	
	//추가버튼
	btnAdd.addEventListener("click", function() {
		grid2.appendRow({});
		rowk = grid2.getRowCount() - 1;
		console.log(basCode);
		grid2.setValue(rowk, "basCd", basCodeVal, false);
		console.log(grid2.getValue(rowk, "basCd"));
	})	
	
	
	
</script>
</body>
</html>