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
<script src="${path}/resources/js/grid-common.js"></script>
<script src="${path}/resources/js/modal.js"></script>
<script src="${path}/resources/js/toastr-options.js"></script>

</head>
<style type="text/css">
	.tui-grid-cell-summary{
		text-align: right;
	}
</style>
<body>
	<div class="container">
		<h3>재고조정 조회</h3>
		<hr>
		<form id="frm" method="post">
			<div>
				<div>
					<label>정산일자</label>
					<input type="Date" id="startDate" name="startDate">&nbsp;
					<label> ~ </label>&nbsp;
					<input type="Date" id="endDate" name="endDate">
				</div>
				<div>
					<label>자재코드</label>
					<input type="text" id="ditemCode" name="ditemCode">
					<button type="button" id="btnMtrCd">ㅇ</button>&nbsp;
					<label>자재명</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" id="ditemCodeNm" name="ditemCodeNm" disabled="disabled">
				</div>
				<div>
				  <label>정산구분</label>
				  <input type="radio" id="adjAllRadio" name="calSect" value="" checked>
				  <label for="mtrRadio">전체</label>
				  <input type="radio" id="adjInRadio" name="calSect" value="MTR_CAL001">
				  <label for="adjInRadio">정산입고</label>
				  <input type="radio" id="adjOutRadio" name="calSect" value="MTR_CAL002">
				  <label for="adjOutRadio">정산출고</label>
				</div>
			</div>
		</form>
		<div align="right">
			<button type="button" id="btnFind">조회</button>
		</div>
		<hr>
	</div>
<div id="grid"></div>
<div id="dialog-form"></div>

<script type="text/javascript">
//---------포맷에 맞게 날짜 구하는 function---------
function getDateStr(dt){
	let year = dt.getFullYear();
	let month = (dt.getMonth() + 1);
	let day = dt.getDate();
	
	month = (month < 10) ? "0" + String(month) : month;
	day = (day < 10) ? "0" + String(day) : day;
	
	return  year + '-' + month + '-' + day;
}
function today() {
	let dt = new Date();
	return getDateStr(dt);
}
function lastWeek() {
	let dt = new Date();
	let day = dt.getDate();
	dt.setDate(day -7);
	return getDateStr(dt);
}
document.getElementById('startDate').value = lastWeek();
document.getElementById('endDate').value = today();
//---------포맷에 맞게 날짜 구하는 function 끝---------


//---------mainGrid---------
const dataSource = {
	api: {
		readData: { url: './mtrCalList', method: 'POST' }
	},
	contentType: 'application/json',
	initialRequest: false
};

var mainGrid = new Grid({
     el : document.getElementById('grid'),
     data : dataSource,
     scrollX : false,
     scrollY : true,
     bodyHeight: 400,
     columns : [
				 {
				   header: '정산번호',
				   name: 'calNo',
				   align: 'center',
				   hidden: true
				 },
				 {
				   header: '정산구분',
				   name: 'calSectNm',
				   align: 'center',
				   sortable: true
				 },
				 {
				   header: '정산일자',
				   name: 'calDate',
				   align: 'center',
				   sortable: true
				 },
				 {
				   header: '자재코드',
				   name: 'mtrCd',
				   align: 'center',
				   sortable: true,
				   hidden: true
				 },
				 {
				   header: '자재명',
				   name: 'mtrNm',
				   align: 'left',
				   sortable: true
				 },
				 {
				   header: '단위',
				   name: 'unitNm',
				   align: 'center',
				   sortable: true
				 },
				 {
				   header: 'Lot No',
				   name: 'mtrLot',
				   align: 'center',
				   sortable: true
				 },
				 {
				   header: '정산량',
				   name: 'calAmt',
				   formatter({value}){
					   return format(value);
				   },
				   align: 'right',
				   sortable: true
				 },
				 {
				   header: '재고수량',
				   name: 'stckCnt',
				   align: 'right',
				   sortable: true
				 },
				 {
				   header: '비고',
				   name: 'cmt',
				   align: 'left',
				   sortable: true
				 }
				 
				],
				summary : {
					
					height: 40,
				   	position: 'bottom',
				   	columnContent: {
				   		mtrLot: {
			                template(summary) {
			        			return '합 계';
			                } 
			            },	
			            calAmt: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            },
			            stckCnt: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            }
					}
				}
   });
//---------mainGrid 끝---------


//---------mainGrid 수정불가 alert---------
mainGrid.on('dblclick',(ev)=>{
	toastr["error"]("변경할 수 없습니다.", "경고입니다.")
});
//---------mainGrid 수정불가 alert 끝---------


//---------숫자데이터 구분자주는 기능---------
function format(value){
	value = value * 1;
	return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
};
//---------숫자데이터 구분자주는 기능 끝---------


//---------모달 설정---------
let dialog;
dialog = $( "#dialog-form" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 500
});
//---------모달 설정 끝---------


//---------자재검색모달 row더블클릭 이벤트---------
function getModalMtr(param){
	dialog.dialog("close");
	$('#ditemCode').val(param.mtrCd);
	$('#ditemCodeNm').val(param.mtrNm);
};
//---------자재검색모달 row더블클릭 이벤트 끝---------


//---------자재검색버튼---------
btnMtrCd.addEventListener("click", function(){
	mMtr();
	$('#ui-id-1').html('자재 검색');
});
//---------자재검색버튼 끝---------


//---------조회버튼---------
btnFind.addEventListener("click", function(){
   let a= $("#frm").serializeObject();
   mainGrid.readData(1,a,true);
});
//---------조회버튼 끝---------
</script>
</body>
</html>