<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<link rel="stylesheet" href="${path}/resources/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="${path}/resources/jquery-ui/images">

<script src="${path}/resources/js/grid-common.js"></script>
<script src="${path}/resources/js/modal.js"></script>
<script src="${path}/resources/js/toastr-options.js"></script>
</head>
<style type="text/css">
.tui-grid-cell-summary{
	text-align: right;
}
.labeltext{
width: 100px !important;
}
.colline2{
	margin-left: 60px;
	width: 100px !important;
}
.rowdiv{
	margin-bottom: 10px !important;
}
.bascard1{
	height:165px;
}
.modal .ui-dialog{
  position:fixed;
  top:50%; 
  left:50%;
  transform: translate(-50%,-50%);
 }
.ui-widget{
	z-index: 1000001 !important;
	position: relative;
}
</style>
<body>
<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">입고자재관리</h3>
				</div>
			</div>
		</div>
	</div>
	
	<div align="right"> 
		<button type="button" id="btnOrdFind" class="btn btn-primary newalign2">발주내역조회</button>
	</div>
	<br>
	
	<div class="row">
		<div class="col-md-12 grid-margin stretch-card"><!-- <div style="margin-top: 50px; border-top: 2px solid black; border-bottom : 2px solid black; padding: 5px;">  -->
			<div class="card bascard1">
				<div class="card-body">
					<!-- <h4 class="card-title">조회조건</h4> -->
					<form id="frm" method="post">
						<div class="rowdiv">
							<label class="labeltext">해당일자</label>
							<input type="text" id="startDate" name="startDate" class="datepicker jquerydtpicker"> 
							<label> ~ </label> 
							<input type="text" id="endDate" name="endDate" class="datepicker jquerydtpicker">
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">입고업체코드</label>
							<input id="compCd" name="compCd" class="inputtext" readonly>
							<button type="button" id="btnInCom" class="btn btn-primary mr-2 minibtn" onclick="inComList()"><i class="icon-search"></i></button>
							<label class="labeltext colline2">입고업체명</label>
							<input id="compNm" name="compNm" class="inputtext" readonly>
						</div>
						
						<span class="rowdiv">
							<label class="labeltext">자재코드</label>
							<input type="text" id="ditemCode" name="ditemCode" class="inputtext" readonly>
							<button type="button" id="btnMtrCd" class="btn btn-primary mr-2 minibtn" ><i class="icon-search"></i></button>
							<label class="labeltext colline2">자재명</label>
							<input type="text" id="ditemCodeNm" name="ditemCodeNm" class="inputtext" readonly>
						</span>
						
						<span>
							<button type="button" id="btnFind" class="btn btn-primary mr-2 floatrightbtn">조회</button>
						</span>
					</form>
				</div>
			</div>
		</div>
	</div>
		
	<span class="floatright">
		<button type="button" id='btnAdd' class="btn btn-main newalign">추가</button>
		<button	type="button" id='btnDel' class="btn btn-main newalign">삭제</button>
		<button type="button" id='btnSave' class="btn btn-primary newalign">저장</button> 
	</span>
	<br><br>
	<hr>
	<div id="grid"></div>
	<div id="dialog-form" class="modal"></div>
	<div id="dialog-ord" class="modal"></div>
	<div id="dialog-lot" class="modal"></div>
</div>
			
<!-- 
	<div class="container">
		<h3>자재입고 관리</h3>
		<div align="right">
			<button type="button" id="btnOrdFind">발주내역조회</button>
		</div>
		<hr>
		<form id="frm" method="post">
			<div>
				<div>
					<label>해당일자</label>
					<input type="Date" id="startDate" name="startDate">&nbsp;
					<label> ~ </label>&nbsp;
					<input type="Date" id="endDate" name="endDate">
				</div>
				<div>
					<label>업체코드</label>
					<input type="text" id="compCd" name="compCd">
					<button type="button" id="btnInCom" onclick="inComList()">ㅇ</button>&nbsp;
					<label>입고업체명</label>
					<input type="text" id="compNm" name="compNm" disabled="disabled">
				</div>
				<div>
					<label>자재코드</label>
					<input type="text" id="ditemCode" name="ditemCode">
					<button type="button" id="btnMtrCd">ㅇ</button>&nbsp;
					<label>자재명</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" id="ditemCodeNm" name="ditemCodeNm" disabled="disabled">
				</div>
			</div>
		</form>
		<div align="right">
			<button type="button" id="btnFind">조회</button>
			<button type="button" id="btnSave">저장</button>
			<button type="button" id="btnAdd">추가</button>
			<button type="button" id="btnDel">삭제</button>
		</div>
		<hr>
	</div>
<div id="grid"></div>
<div id="dialog-form"></div>
<div id="dialog-ord"></div>
<div id="dialog-lot"></div> -->

<script type="text/javascript">
let rowk = -1;
let modifyList = [];

//---------포맷에 맞게 날짜 구하는 function---------
function getDateStr(dt){
	let year = dt.getFullYear();
	let month = (dt.getMonth() + 1);
	let day = dt.getDate();
	
	month = (month < 10) ? "0" + String(month) : month;
	day = (day < 10) ? "0" + String(day) : day;
	
	return  year + '-' + month + '-' + day;
};
function today() {
	let dt = new Date();
	return getDateStr(dt);
};
function lastWeek() {
	let dt = new Date();
	let day = dt.getDate();
	dt.setDate(day -7);
	return getDateStr(dt);
};
document.getElementById('startDate').value = lastWeek();
document.getElementById('endDate').value = today();
//---------포맷에 맞게 날짜 구하는 function 끝---------


//---------Jquery datepicker---------
	$(function() {
    //input을 datepicker로 선언
    $(".jquerydtpicker").datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
        ,changeYear: true //option값 년 선택 가능
        ,changeMonth: true //option값  월 선택 가능                
        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
        ,buttonImage: "${path}/resources/template/images/cal_lb_sm.png" //"http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
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
/*     $('#startDate').datepicker('setDate', '-1W'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
    $('#endDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)  */ 
    
});
//---------Jquery datepicker 끝---------


//---------mainGrid---------
let mainGrid = new Grid({
     el : document.getElementById('grid'),
     data : {
		  api: {
			    readData: { url: './mtrInForm', method: 'POST' },
			    deleteData: { url: './mtrDelete', method: 'POST'},
		    	modifyData: { url: './mtrModify', method: 'POST' }
			   },
			   contentType: 'application/json',
			   initialRequest: false
			},
	 scrollX : false,
	 scrollY : true,
	 bodyHeight: 325,
	 minBodyHeight: 325,
     rowHeaders : [ 'checkbox'],
     columns : [
				{
				   header: '입고번호',
				   name: 'inNo',
				   hidden: true
				 },
				 {
				   header: '입고일자',
				   name: 'inDate',
				   editor: {
							type: 'datePicker',
								options: {
								language: 'ko',
								format: 'yyyy-MM-dd',
								showAlways: true
								}
				  },
					validation: {
					   required:true
				  },
					align: 'center',
					sortable: true
				 },
				 {
				   header: '자재코드',
				   name: 'mtrCd',
				   align: 'center',
				   hidden: true
				 },
				 {
				   header: '자재명',
				   name: 'mtrNm',
				   align: 'left',
				   editor: 'text',
				   validation: {
					   required:true
				   },
				   sortable: true
				 },
				 {
				   header: '단위',
				   name: 'unitNm',
				   align: 'center',
				   sortable: true
				 },
				 {
				   header: '단위',
				   name: 'unit',
				   hidden: true
				 },
				 {
				   header: '업체',
				   name: 'compNm',
				   align: 'left',
				   sortable: true
				 },
				 {
				   header: '발주번호',
				   name: 'ordNo',
				   align: 'center',
				   width: 150,
				   editor: 'text',
				   sortable: true
				 },
				 {
					header: '발주량',
					name: 'ordAmt',
					align: 'right',
				    formatter({value}){
					   return format(value);
				    },
				    sortable: true
				 },
				 {
					header: '기입고량',
					name: 'inputAmt',
					align: 'right',
				    formatter({value}){
					   return format(value);
				    },
				    sortable: true
				 },
				 {
				   header: '불량량',
				   name: 'fltAmt',
				   align: 'right',
				   editor: 'text',
				   formatter({value}){
					   return format(value);
				   },
				   sortable: true
				 },
				 {
				   header: '입고량',
				   name: 'inAmt',
				   align: 'right',
				   editor: 'text',
				   formatter({value}){
					   return format(value);
				   },
					validation: {
						dataType: 'number',
		            	required: true
		          	},
				   sortable: true
				 },
				 {
					header: '미입고량',
					name: 'notinAmt',
					align: 'right',
				    formatter({value}){
					   return format(value);
				    },
				    sortable: true
				 },
				 {
				   header: '단가',
				   name: 'unitCost',
				   align: 'right',
				   editor: 'text',
				   formatter({value}){
					   return format(value);
				   },
				   validation: {
						dataType: 'number',
		            	required: true
		          	},
				   sortable: true
				 },
				 {
				   header: '총금액',
				   name: 'totCost',
				   align: 'right',
				   sortable: true,
				   formatter({value}){
					   return format(value);
				   }
				 },
				 {
				   header: '관리수량',
				   name: 'mngAmt',
				   hidden: true
				 },
				 {
				   header: '등록자',
				   name: 'empNo',
				   hidden: true
				 }
				],
				summary : {
					height: 40,
				   	position: 'bottom',
				   	columnContent: {
				   		ordNo: {
			                template(summary) {
			        			return '합 계';
			                }
			            },	
			            ordAmt: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            },
			            notinAmt: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            },
			            fltAmt: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            },
			            inAmt: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            },
			            unitCost: {
			                template(summary){
			        			return "MIN: "+format(summary.min)+"<br>"+"MAX: "+format(summary.max);
			                } 
			            },
			            totCost: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            }
					}
				}
   		});
//---------mainGrid 끝---------


//---------숫자데이터 구분자주는 기능---------
function format(value){
	value = value * 1;
	return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
};
//---------숫자데이터 구분자주는 기능 끝---------


//---------합계금액 입력해주는 function---------
function totCal(){
	let data;
		data = mainGrid.getData()
		for(i=0; i<data.length; i++){
			let val = data[i].inAmt*data[i].unitCost
			mainGrid.setValue(i,"totCost",val)
		}
};
//---------합계금액 입력해주는 function 끝---------


//---------mainGrid 입고량 validation & 합계금액 산출---------
mainGrid.on('editingFinish', (ev) => {
	if(ev.columnName == 'inAmt'){
		if(mainGrid.getValue(ev.rowKey, 'notinAmt') != ''){
			if(mainGrid.getValue(ev.rowKey, 'inAmt')*1 > mainGrid.getValue(ev.rowKey, 'notinAmt')*1){
				toastr["info"]("입고량이 해당자재의 미입고량보다 많습니다.")
				mainGrid.setValue(ev.rowKey, 'inAmt', mainGrid.getValue(ev.rowKey, 'inAmt'))
			} else {
				let inAmt = mainGrid.getValue(ev.rowKey,"inAmt")
				let unitCost = mainGrid.getValue(ev.rowKey,"unitCost")
				mainGrid.setValue(ev.rowKey,"totCost",inAmt*unitCost)
			}
		}
	}
	if(ev.columnName == 'unitCost'){
		let inAmt = mainGrid.getValue(ev.rowKey,"inAmt")
		let unitCost = mainGrid.getValue(ev.rowKey,"unitCost")
		mainGrid.setValue(ev.rowKey,"totCost",inAmt*unitCost)
	}
});
//---------mainGrid 입고량 validation & 합계금액 산출 끝---------


//---------mainGrid 기존의 발주번호는 수정불가 & 자재모달 open---------
mainGrid.on('editingStart', (ev) => {
    if(ev.columnName == 'mtrNm') {
       var value = mainGrid.getValue(ev.rowKey, 'mtrCd');
    	rowk = ev.rowKey;
		mMtr();
    }else if(ev.columnName == 'ordNo') {
       value = mainGrid.getValue(ev.rowKey, 'ordNo');
       if(value != '') {
    	  toastr["error"]("변경할 수 없는 코드 입니다.", "경고입니다.")
          ev.stop();
       }
    }
});
//---------mainGrid 기존의 발주번호는 수정불가 & 자재모달 open 끝---------


//---------mainGrid 단위, 업체 수정불가 alert---------
mainGrid.on('dblclick', (ev) => {
	if(ev.columnName == 'unitNm' || ev.columnName == 'compNm') {
	       toastr["info"]("자재명 수정해 주세요.")
	    }
});
//---------mainGrid 단위, 업체 수정불가 alert 끝---------


//---------mainGrid row갯수 파악---------
mainGrid.on('onGridUpdated', ev => {
	rowk = mainGrid.getRowCount();
});
//---------mainGrid row갯수 파악 끝---------


//---------mainGrid modify후 focus---------
mainGrid.on("response", function(ev) {
	if(JSON.parse(ev.xhr.response).result != true) {
		let param= $("#frm").serializeObject();
		mainGrid.readData(1,param,true);
		setTimeout(function(){
			for(inNoData of mainGrid.getData()) {
				if(modifyList[modifyList.length-1] == inNoData.inNo) {
					mainGrid.focus(inNoData.rowKey, 'inDate', true);
					break;
				} else {
					mainGrid.focus(mainGrid.getRowCount()-1,'inDate',true);
					break;
				}
			}
		},100);
	}
});
//---------mainGrid modify후 focus 끝---------


//---------ordGrid---------
let ordDataSource = {
	api: {
		readData: { url: './mtrOrdModal',method: 'GET'
		}
	},
	contentType: 'application/json'
};

let ordGrid = new Grid({
el : document.getElementById('dialog-ord'),
data : ordDataSource,
scrollX : false,
scrollY : true,
bodyHeight: 300,
rowHeaders : [ 'checkbox'],
columns : [
			{
				header: '발주일자',
				name: 'ordDate',
				align: 'center'
			},
			{
				header: '입고업체명',
				name: 'compNm',
				align: 'left'
			},
			{
				header: '자재명',
				name: 'mtrNm',
				align: 'left'
			},
			{
				header: '단위',
				name: 'unitNm',
				align: 'center'
			},
			{
				header: '발주량',
				name: 'ordAmt',
				align: 'right'
			},
			{
				header: '미입고량',
				name: 'notinAmt',
				align: 'right'
			},
			{
				header: '기입고량',
				name: 'inputAmt',
			    hidden: true
			 },
			{
				header: '발주번호',
				name: 'ordNo',
				hidden: true
			},
			{
				header: '단위',
				name: 'unit',
				hidden: true
			},
			{
				header: '관리수량',
				name: 'mngAmt',
				hidden: true
			}	
			]
});
//---------ordGrid 끝---------


//---------ordGrid (mainGrid에 있는 데이터 제거)---------
ordGrid.on('onGridUpdated', ev => {
	let datas = mainGrid.getData();
	let rows = ordGrid.getData();
	if(rowk == -1){
		rowk = 0;	
	}
	for(i=rowk; i<mainGrid.getRowCount(); i++){
		for(row of rows){
			if(datas[i].ordNo == row.ordNo 
					&& datas[i].notinAmt == row.notinAmt
					&& datas[i].mtrNm == row.mtrNm){
				ordGrid.removeRow(row.rowKey)
			}
		}
	}
});
//---------ordGrid (mainGrid에 있는 데이터 제거) 끝---------


//---------모달 설정---------
let dialog = $( "#dialog-form" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 500
});
//---------모달 설정 끝---------


//---------발주내역모달 설정---------
let ordDialog = $( "#dialog-ord" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 800,
	buttons:{
		"확인":()=>{
		let rows = ordGrid.getCheckedRows();
		mainGrid.clear();
		for(row of rows){
			row.inDate = today();
			row.rowKey = mainGrid.getRowCount();
			row.inAmt = row.notinAmt;
			mainGrid.appendRow(row,{focus:true});
			mainGrid.setValue(row.rowKey,"totCost",row.notinAmt*row.unitCost)
		}
		mainGrid.uncheckAll();
		ordDialog.dialog("close");
		}
	}
});
//---------발주내역모달 설정 끝---------


//---------업체검색모달 row더블클릭 이벤트---------
//메인의 input박스 채우는거랑, 모달속 input박스채우는거 구분
function getModalBas(param,ev){
		$('#compCd').val(param.dtlCd);
		$('#compNm').val(param.dtlNm);
		dialog.dialog("close");
};
//---------업체검색모달 row더블클릭 이벤트 끝---------


//---------업체검색버튼 클릭 event---------
function inComList(){
	mBas('MTR_COM',event.target);
	$('#ui-id-1').html('업체 검색');
};
//---------업체검색버튼 클릭 event 끝---------


//---------자재검색모달 row더블클릭 이벤트---------
//input채우는 거랑, 그리드의 셀 채우는거 구분
function getModalMtr(param){
	dialog.dialog("close");
	if(rowk >= 0){
		mainGrid.blur();
		mainGrid.setValue(rowk, "mtrCd", param.mtrCd, false);
		mainGrid.setValue(rowk, "mtrNm", param.mtrNm, false);
		mainGrid.setValue(rowk, "unit", param.unit, false);
		mainGrid.setValue(rowk, "unitNm", param.unitNm, false);
		mainGrid.setValue(rowk, "compNm", param.compNm, false);
		mainGrid.setValue(rowk, "mngAmt", param.mngAmt, false);
		rowk = -1;
	} else {
		$('#ditemCode').val(param.mtrCd);
		$('#ditemCodeNm').val(param.mtrNm);
	}
};
//---------자재검색모달 row더블클릭 이벤트 끝---------


//---------자재검색버튼---------
btnMtrCd.addEventListener("click", function(){
	mMtr();
	$('#ui-id-1').html('자재 검색');
});
//---------자재검색버튼 끝---------

//---------추가버튼---------
btnAdd.addEventListener("click", function(){
	mainGrid.appendRow({'mtrNm':''},
						 {focus:true});
	mainGrid.setValue(mainGrid.getRowCount()-1, 'inDate', today())
});
//---------추가버튼 끝---------


//---------조회버튼---------
btnFind.addEventListener("click", function(){
   let param= $("#frm").serializeObject();
   mainGrid.readData(1,param,true);
});
//---------조회버튼 끝---------


//---------삭제버튼---------
btnDel.addEventListener("click", function(){
	mainGrid.removeCheckedRows(true);
	mainGrid.request('deleteData');
});
//---------삭제버튼 끝---------


//---------저장버튼---------
btnSave.addEventListener("click", function(){
	mainGrid.blur();
	
	 rowk = mainGrid.getRowCount();
     
     for(i=0; i<rowk; i++) {
        if(mainGrid.getRow(i).mtrNm == '') {
           alert("자재명은 필수입력칸입니다!!");
           return;
        }
       /*  else if(mainGrid.getRow(i).inAmt == 0) {
           alert("입고량은 필수입력칸입니다!!");
           return;
        } */
        else if(mainGrid.getRow(i).unitCost == 0) {
           alert("단가는 필수입력칸입니다!!");
           return;
        }
     }  
	
	let create = mainGrid.getModifiedRows().createdRows;
	let update = mainGrid.getModifiedRows().updatedRows;
	for(let i=0; i<create.length; i++) {
		modifyList.push(create[i].inNo);
	}
	for(let i=0; i<update.length; i++) {
		modifyList.push(update[i].inNo);
	 }
	mainGrid.request('modifyData');
	mainGrid.focus(mainGrid.getRowCount()-1,'inNo')
});
//---------저장버튼 끝---------


//---------발주내역버튼---------
btnOrdFind.addEventListener("click", function(){
	ordDialog.dialog("open");
	ordGrid.readData();
	$('#ui-id-2').html('발주 내역');
	ordGrid.refreshLayout();
});
//---------발주내역버튼 끝---------
</script>
</body>
</html>