<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="${path}/resources/js/grid-common.js"></script>
</head>

<style>
.labeltext{
width: 100px !important;
}
.colline2{
	margin-left: 60px;
	width: 100px !important;
}
.bascard1{
	height:125px;
}
.rowdiv{
	margin-bottom: 10px !important;
}
hr{
	margin-top: -20px;
}
.checkwidth{
	width:114px;
}
</style>
<body>

<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">주문서조회</h3>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12 grid-margin stretch-card">
			<div class="card bascard1">
				<div class="card-body">
					<form name="frm" id="frm">
						<div class="rowdiv">
							<label class="labeltext">해당일자</label>
							<input type="Date" id="startDate" name="startDate" class="datepicker">
						</div>
						
						<label class="labeltext">진행상태</label>
						<div class="form-check checkwidth" style="display:inline-block">
							<label class="form-check-label schCondLabel" for="checked">
						  		<input type="radio" id="checked" name="nowPhs" value="" class="form-check-input" checked>
						  		전체
								<i class="input-helper"></i>
							</label>
						</div>
						                
						<div class="form-check checkwidth" style="display:inline-block">
							<label class="form-check-label schCondLabel" for="checkedY">
						  		<input type="radio" id="checkedY" name="nowPhs" value="Y" class="form-check-input">
						  		진행완료
								<i class="input-helper"></i>
							</label>
						</div>
						                
						<div class="form-check checkwidth" style="display:inline-block">
						    <label class="form-check-label schCondLabel" for="checkedN">
						  		<input type="radio" id="checkedN" name="nowPhs" value="N" class="form-check-input">
						  		진행중
								<i class="input-helper"></i>
							</label>
						</div>
						
						<span class="floatright">
							<button type="button" id='delBtn' name="delBtn" onClick="checkDelFnc()" class="btn btn-main newalign">삭제</button>
							<button type="button" action='' id='selBtn' name='selBtn' onClick="dateSelectFnc()" class="btn btn-primary newalign">조회</button>
							<!-- <button type="button" id="addBtn" name="addBtn" class="btn btn-primary mr-2 floatrightbtn">주문서추가</button> -->
						</span>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<hr>
	<div id="grid">
</div>



	<!-- <form name="frm" id="frm">
		<input type='date' id='inputDate' name="ordDate">
		<input type="radio" id="checkedY" name="nowPhs" value="Y" checked>
		<label for="checkedY">진행완료</label>
		<input type="radio" id="checkedN" name="nowPhs" value="N">
		<label for="checkedN">진행중</label>
		<input type="radio" id="checked" name="nowPhs" value="">
		<label for="checked">전체</label>
		<button type="button" id='delBtn' name="delBtn" onClick="checkDelFnc()">선택삭제</button>
		<button type="button" action='' id='selBtn' name='selBtn' onClick="dateSelectFnc()">조회</button>
		<button type="button" id="addBtn" name="addBtn">주문서추가</button>
	</form>
	<div id="grid"></div> -->
	
	
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
  	/* let Grid = tui.Grid; */
	//그리드 테마적용
	/* Grid.applyTheme('striped',{
		cell:{
			header:{
				background:'#eef'
			},
			evenRow:{
				background:'#fee'
			}
		}
	}) */
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
		  },
		  scrollY : true,
		  bodyHeight: 527,
		  minBodyHeight: 527
		});
	grid.on('successResponse',function(ev){
		console.log("성공")
	})
	grid.on('failResponse',function(ev){
		console.log("실패")
	})
	//날짜별 조회 ajax
	function dateSelectFnc(){
		let inputDate=document.getElementById('inputDate').value;
		let FormData=$("#frm").serialize()
		event.preventDefault();
		$.ajax({
			url:'./ord',
			method:'POST',
			data:FormData,
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