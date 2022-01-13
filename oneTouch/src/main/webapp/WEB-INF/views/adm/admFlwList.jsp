<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정흐름관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

</head>
<body>
<div id="grid1"></div>
<div id="grid2"></div>
<div id="grid3"></div>
<script type="text/javascript">
	let Grid = tui.Grid;
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
	
	const columns1 = [{
			header : '제품코드',
			name : 'prdCd'
		},
		{
			header : '제품명',
			name : 'prdNm'
		}];
	
	var dataSource1 = {
			api: {
				readData: {
					url:'./admPrdList',
					method: 'GET'
				}
			},
			contentType: 'application/json'
	};
	
	const grid1 = new Grid({
		el: document.getElementById('grid1'),
		data: dataSource1,
		rowHeaders: ['checkbox'],
		columns: columns1
	});
	
	
</script>
</body>
</html>