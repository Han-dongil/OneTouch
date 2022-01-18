<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재정보관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/modal.js"></script>
</head>
<body>
<br>
<h3>[자재정보관리]</h3>
<hr>
<div class="flex row">
	<div class = "col-4">
		<h4>✔자재목록</h4><br><br>
		<div id="grid"></div>
		<br>
	</div>
	<div class= "col-8">
		<h4>✔자재상세정보</h4>
		<div align="right" style="margin-right: 3%;">
			<button id="btnEdit">수정</button><hr>
		</div>
			<form id="mtrFrm" name="mtrFrm" method="post">
		<label>자재코드&nbsp;</label><input id="mtrCd" name="mtrCd" readonly><br>
		<label>자재명&emsp;&nbsp;</label><input id="mtrNm" name="mtrNm" readonly><br>
		<label>자재규격&nbsp;</label><input id="stdNm" name="stdNm">
			<button type="button" id="btnStd">🔍</button><br>
		<label>관리단위&nbsp;</label><input id="unitNm" name="unitNm">
			<button type="button" id="btnUnit">🔍</button><br>
		<label>자재구분&nbsp;</label><input id="mtrSectNm" name="mtrSectNm">
			<button type="button" id="btnMtrSect">🔍</button><br>
		<label>업체명&emsp;&nbsp;</label><input id="compNm" name="compNm">
			<button type="button" id="btnCompCd">🔍</button><br>
		<label>관리수량&nbsp;</label><input id="mngAmt" name="mngAmt" readonly><br>
		<label>안전재고&nbsp;</label><input id="safeStck" name="safeStck" readonly><br>
		<input type="hidden" id="std" name="std">
		<input type="hidden" id="unit" name="unit">
		<input type="hidden" id="mtrSect" name="mtrSect">
		<input type="hidden" id="compCd" name="compCd">
		<label>사용여부&nbsp;</label><input id="useYn" name="useYn" type="checkbox" style="width: 20px;">
	</form>
	</div>
</div>
<script type="text/javascript">
	let Grid = tui.Grid;
	
	Grid.applyTheme('striped',{
		cell:{
			header:{
				background:'#fee'
			}
		}
	})
	
	const columns = [{
		
			header : '자재코드',
			name : 'mtrCd',
			sortable : true //정렬
		},
		{
			header : '자재명',
			name : 'mtrNm',
			sortable : true
		}];
	
	const dataSource = {
			api: {
				readData: {
					url:'./admMtrList',
					method: 'GET'
				}
			},
			contentType: 'application/json'
		};
	
	const grid = new Grid({
		el: document.getElementById('grid'),
		data: dataSource,
		columns,
		bodyHeight: 650,
		minBodyHeight: 650
	});
	
	grid.on("click", (ev) => {
		if(ev.columnName === 'mtrCd' || ev.columnName === 'mtrNm') {
			mtrCode = {};
		}
	})
	
</script>
</body>
</html>