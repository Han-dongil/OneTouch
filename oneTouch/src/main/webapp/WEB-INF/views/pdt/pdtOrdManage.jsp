<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
</head>
<body>
<div id="grid"></div>
	<script>
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
		const dataSource={
			api:{
				readData:{url:'./pdtOrdManage',
					method:'GET',
					initParams:{param:'param'}},
			/* 	modifyData:{url:'./pdtOrdlist',method:'PUT'}, */
			},
			contentType:'application/json'
		}
		const columns = [{
			header : '주문번호',
			name : 'ordShtNo'
		}];
		console.log(dataSource);
		const grid = new Grid({
			  el: document.getElementById('grid'),
			  data:dataSource,
			  rowHeaders:['checkbox'],
			  columns,
			  columnOptions: {
				  frozenCount :2,
				  frozenBorderWidth:2
			  }
		});
		grid.on('successResponse',function(ev){
			console.log("성공")
		})
		grid.on('failResponse',function(ev){
			console.log("실패")
		})
	</script>
</body>
</html>