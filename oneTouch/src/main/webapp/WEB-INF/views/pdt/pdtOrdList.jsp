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
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/grid-common.js"></script>
<link rel="stylesheet" href="${path}/resources/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="${path}/resources/jquery-ui/images">
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
							<label class="labeltext">주문일자</label>
							<input type="text" id="startDate" name="startDate" class="datepicker jquerydtpicker"> ~
							<input type="text" id="endDate" name="endDate" class="datepicker jquerydtpicker"> 
							<!-- <input type="text" id="inputDate" name="ordDate" class="datepicker jquerydtpicker"/> -->
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
							<!-- <button type="button" id='delBtn' name="delBtn" onClick="checkDelFnc()" class="btn btn-main newalign">삭제</button> -->
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
	
	$(function() {
	    //input을 datepicker로 선언
	    $(".datepicker").datepicker({
	        dateFormat: 'yy-mm-dd' //달력 날짜 형태
	        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	        ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
	        ,changeYear: true //option값 년 선택 가능
	        ,changeMonth: true //option값  월 선택 가능                
	        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
	        ,buttonImage: "/oneTouch/resources/template/images/cal_lb_sm.png" //"http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	        ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
	        //,buttonText: "선택" //버튼 호버 텍스트              
	        ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
	        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
	        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
	        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
	        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
	        ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	        ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
	    });                    
	    
	    //초기값을 오늘 날짜로 설정해줘야 합니다.
	    $('.datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
	    $('#startDate').datepicker('setDate', 'today-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
	    	       
	});
	
	let OrdVO={};
	let checked=[];
    let dataSource; //그리드에 들어갈 데이터변수
    //전체리스트 ajax
    setTimeout(()=>{
	    dateSelectFnc();
    	
    },500)
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
		name : 'ordShtNo',
		align: 'center',
	},{
		header : '납기일자',
		name : 'dueDate',
 		editor : 'text'	,
		align: 'center',	
	},{
		header : '주문일자',
		name : 'ordDate',
 		editor : 'text',
		align: 'center',
	},{
		header : '업체번호',
		name : 'compCd',
 		editor : 'text',
		align: 'center',
	},{
		header : '현재상태',
		name : 'nowPhs',
 		editor : 'text',
		align: 'center',
	},{
		header : '비고',
		name : 'cmt',
	}];
	//그리드 생성
	grid = new Grid({
		  el: document.getElementById('grid'),
		  data:null,
		  columns,
		  scrollY : true,
		  bodyHeight: 528,
		  minBodyHeight: 528
		});
	grid.on('successResponse',function(ev){
		console.log("성공")
	})
	grid.on('failResponse',function(ev){
		console.log("실패")
	})
	//날짜별 조회 ajax
	function dateSelectFnc(){
		let FormData=$("#frm").serialize()
	//	event.preventDefault();
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