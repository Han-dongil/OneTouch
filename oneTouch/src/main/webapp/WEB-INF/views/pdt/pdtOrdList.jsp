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
		<input type='date' id='inputDate'>
		<button action='' id='selBtn' name='selBtn' onClick="abcFnc()">조회</button>
	</form>
	<div id="grid"></div>
	<script>
	

	
    let dataSource;
	$.ajax({
	  url:"./pdtOrdlist",
	  dataType:'json',
	  async:false,
	  success:function(result){
		  console.log("sssss")
		  console.log(result)
		  dataSource=result;
		  console.log(result);
	  },
	  error:function(reject){
		  console.log("aaaaaa")
		  console.log(reject)
	  }
  })
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
/* 	 const dataSource={
			api:{
				readData:{url:'./pdtOrdlist',
					method:'GET',
					initParams:{param:'param'}},
			 	modifyData:{url:'./pdtOrdlist',method:'PUT'}, 
			},
			contentType:'application/json'
		}*/ 
	const columns = [{
		header : '주문번호',
		name : 'ordShtNo'
	},{
		header : '납기일자',
		name : 'dueDate'		
	},{
		header : '주문날짜',
		name : 'ordDate'
	},{
		header : '업체번호',
		name : 'compCd'
	},{
		header : '현재상태',
		name : 'nowPhs'
	},{
		header : '비고',
		name : 'cmt'
	}];
	grid = new Grid({
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
	
	function abcFnc(){
		let inputDate=document.getElementById('inputDate').value;
		event.preventDefault();
		$.ajax({
			url:'./ord',
			method:'POST',
			data:'ordDate='+inputDate,
			success:function(result){
				console.log(result)
				grid.resetData(result);
			}
		})
	}
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