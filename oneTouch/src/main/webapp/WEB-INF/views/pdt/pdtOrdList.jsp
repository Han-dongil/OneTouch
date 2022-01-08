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
	<form>
		<input type='date' class='btn'>
		<button>조회</button>
	</form>
	<div id="grid"></div>
	<script>
/* let dataSource;
	$.ajax({
	  url:"./pdtOrdlist",
	  dataType:'json',
	  success:function(result){
	  console.log("sssss")
	  console.log(result)
	  dataSource=result;
	  console.log(result[0]);
	  },
	  error:function(reject){
		  console.log("aaaaaa")
		  console.log(reject)
	  }
  })   */
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
				readData:{url:'./pdtOrdlist',method:'GET',
				//	initParams:{param:'param'}
	}
	//modifyData:{url:'./pdtOrdlist',method:'PUT'},
			},
			contentType:'application/json'
		}	  
	console.log(dataSource)
	const columns = [ {
		header : '주문번호',
		name : 'ordShtNo'
	}];
	
	const grid = new Grid({
	  el: document.getElementById('grid'),
	  data: dataSource ,
	  rowHeaders:['checkbox'] ,
	  columns,
	  columnOptions: {
		  frozenCount :2,
		  frozenBorderWidth:2 
	  }
	});
	/*
	grid.on('click',(ev)=>{
		
		console.log(ev)
		console.log("클릭됨 ㅎ ")
	})
	grid.on('response',function(ev){
		console.log(ev);
	}) */

  
  </script>
</body>
</html>