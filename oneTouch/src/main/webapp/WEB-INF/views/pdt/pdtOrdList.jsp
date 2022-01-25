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
		<select name="phs" id="phs">
			<option value="N">미계획</option>
			<option value="Y">계획완료</option>
		</select>
		<button type="button" id='delBtn' name="delBtn" onClick="checkDelFnc()">선택삭제</button>
		<button type="button" action='' id='selBtn' name='selBtn' onClick="dateSelectFnc()">조회</button>
		<button type="button" id="addBtn" name="addBtn">주문서추가</button>
	</form>
	<div id="grid"></div>
	<script>
	let OrdVO={};
	let checked=[];
    let dataSource; //그리드에 들어갈 데이터변수
    //전체리스트 ajax
    listAll();
    function listAll(){
		$.ajax({
		  url:"pdtOrdlist",
		  dataType:'json',
		  async:false,
		  success:function(result){
			  dataSource=result;
		  },
		  error:function(reject){
			  console.log(reject)
		  }
	  	})
    }
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
/* 	 const dataSource={
			api:{
				readData:{url:'./pdtOrdlist',
					method:'GET',
					initParams:{param:'param'}},
			 	modifyData:{url:'./pdtOrdlist',method:'PUT'}, 
			},
			contentType:'application/json'
		}*/ 
	//그리드 컬럼 설정	
	const columns = [{
		header : '주문번호',
		name : 'ordShtNo'
	},{
		header : '납기일자',
		name : 'dueDate',
 		editor : 'text'		
	},{
		header : '주문날짜',
		name : 'ordDate',
 		editor : 'text'
	},{
		header : '업체번호',
		name : 'compCd',
 		editor : 'text'
	},{
		header : '현재상태',
		name : 'nowPhs',
 		editor : 'text'
	},{
		header : '비고',
		name : 'cmt',
	}];
	//그리드 생성
	grid = new Grid({
		  el: document.getElementById('grid'),
		  data:dataSource,
		  rowHeaders:['checkbox'],
		  columns,
		  columnOptions: {
			  frozenCount :6,
			  frozenBorderWidth:2
		  }
		});
	grid.on('successResponse',function(ev){
		console.log("성공")
	})
	grid.on('failResponse',function(ev){
		console.log("실패")
	})
	//날짜별 조회 ajax
	function dateSelectFnc(){
		console.log(document.getElementById('phs').value);
		let inputDate=document.getElementById('inputDate').value;
		event.preventDefault();
		$.ajax({
			url:'./ord',
			method:'POST',
			data:'ordDate='+inputDate+'&nowPhs='+document.getElementById('phs').value,
			success:function(result){
				console.log(result)
				grid.resetData(result);
			}
		})
	}
	//체크박스 선택
	grid.on('check',(e)=>{
		checked.push(dataSource[e.rowKey]);
		//console.log(grid.getValue(e.rowKey,'_checked'))
		checked[e.rowKey]._attributes=true;
		console.log(checked[e.rowKey]._attributes);
		//console.log(checked[e.rowKey]._attributes.check);
		
	})
	grid.on('uncheck',ev=>{
			//console.log(grid.getValue(ev.rowKey,'_checked'))
			console.log(checked[ev.rowKey]._attributes);
	}) 
	 //체크박스 삭제 ajax
 	function checkDelFnc(){
		$.ajax({
			url:'./ordDel',
			method:'POST',
			contentType : "application/json",
			data: JSON.stringify(checked),
			success:function(result){
				console.log(result);
				dataSource=result;
				grid.resetData(dataSource);
				checked.length=0;
			}
		})
	}
	addBtn.addEventListener('click',ev=>{
		grid.appendRow([{}]);
	})
	
	grid.on('click',ev=>{
		fetch('orderSeq')
		.then(response=>response.json)
		.then(result=>{
			console.log("dddd");
			grid.setValue(ev.rowKey,'ordShtNo', result.ordShtNo);
		})
	})
	
	
	</script>
</body>
</html>