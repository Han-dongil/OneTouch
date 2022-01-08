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
	<button type="button" id="btnAdd">추가</button>
	<button type="button" id="btnDel">삭제</button>
	<div id="grid"></div>
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
		
		const columns = [{
				header : '공정코드',
				name : 'prcCd'
			},
			{
				header : '공정명',
				name : 'prcNm'
			},
			{
				header : '단위',
				name : 'mngUnit'
			},
			{
				header : '생산일수',
				name : 'pdtDay'
			},
			{
				header : '공정구분',
				name : 'dtmNm'
			},
			{
				header : '비고',
				name : 'cmt'
			},
			{
				header : '표시순서',
				name : 'seq'
			},
			{
				header : '사용여부',
				name : 'useYn'
			}];
		
		let data;
		
		$.ajax({
			url:'./admMngList',
			dataType:'json',
			async:false
		}).done(function(datas) {
			console.log(datas);
			data = datas;
		})
		
	/* 	const dataSource = {
				api:{
					readData: {url:'./admMngList', method:'GET'}
				},
				contentType:'application/json'
			};
		console.log(dataSource+"mng") */
			
		const grid = new Grid({
		  el: document.getElementById('grid'),
		  data, //변수명과 필드명이 같으면 생략가능 원래: data : data,
		  rowHeaders : [ 'checkbox' ],
		  columns
		});
		
	</script>
</body>
</html>