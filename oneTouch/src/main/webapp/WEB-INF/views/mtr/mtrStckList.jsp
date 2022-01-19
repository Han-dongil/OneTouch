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

<script src="${path}/resources/js/modal.js"></script>

<style type="text/css">
	.tui-grid-cell-summary{
		text-align: center;
	}
</style>
</head>
<body>
	<div class="container">
		<h3>자재재고 조회</h3>
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
					<label>자재코드</label>
					<input type="text" id="ditemCode" name="ditemCode">
					<button type="button" id="btnMtrCd">ㅇ</button>&nbsp;
					<label>자재명</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" id="ditemCodeNm" name="ditemCodeNm" disabled="disabled">
				</div>
				<div>
					<label>구분</label>
					<input type="radio" id="lotRadio" name="mtrSect" value="lot" checked>
					<label for="lotRadio">LOT별</label>
					<input type="radio" id="mtrRadio" name="mtrSect" value="mtr">
					<label for="mtrRadio">자재별</label>
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
var Grid = tui.Grid;
Grid.applyTheme('striped', {
     cell: {
       header: {
         background: '#eef'
       },
       evenRow: {
         background: '#fee'
       }
     },
   });
const dataSource = {
		  api: {
		    readData: { url: './mtrInList', method: 'POST' }
		  },
		  contentType: 'application/json'
		};

var grid = new Grid({
     el : document.getElementById('grid'),
     data : dataSource,
     rowHeaders : [ 'checkbox'],
     columns : lotColumns,
				summary : {
					
					height: 40,
				   	position: 'bottom',
				   	columnContent: {
				   		ordNo: {
			                template(summary) {
			        			return '합 계';
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
			        			return "MIN: "+summary.min+"<br>"+"MAX: "+summary.max;
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
   
   
	const lotColumns = [{
						   header: '자재코드',
						   name: 'mtrCd',
						   align: 'center',
						   sortable: true
						 },
						 {
						   header: '자재명',
						   name: 'mtrNm',
						   align: 'center',
						   sortable: true
						 },
						 {
						   header: '단위명',
						   name: 'unitNm',
						   align: 'center',
						   sortable: true
						 },
						 {
						   header: '자재구분',
						   name: 'mtrSectNm',
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
						   header: '홀딩수량',
						   name: 'hldCnt',
						   align: 'center',
						   sortable: true
						 },
						 {
						   header: '현재고',
						   name: 'lotStckCnt',
						   align: 'center',
						   sortable: true
						 },
						 {
						   header: '비고',
						   name: 'cmt',
						   align: 'center',
						   sortable: true
						 }
						]
	const mtrColumns = [{
						   header: '자재코드',
						   name: 'mtrCd',
						   align: 'center',
						   sortable: true
						 },
						 {
						   header: '자재명',
						   name: 'mtrNm',
						   align: 'center',
						   sortable: true
						 },
						 {
						   header: '단위명',
						   name: 'unitNm',
						   align: 'center',
						   sortable: true
						 },
						 {
						   header: '자재구분',
						   name: 'mtrSectNm',
						   align: 'center',
						   sortable: true
						 },
						 {
						   header: '홀딩수량',
						   name: 'hldCnt',
						   align: 'center',
						   sortable: true
						 },
						 {
						   header: '현재고',
						   name: 'mtrStckCnt',
						   align: 'center',
						   sortable: true
						 },
						 {
						   header: '안전재고',
						   name: 'safeStck',
						   align: 'center',
						   sortable: true
						 }
						 ];
let dialog;
dialog = $( "#dialog-form" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 500
});

function format(value){
	value = value * 1;
	return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
grid.on('response', function(ev) {
      grid.resetOriginData();
   });
btnFind.addEventListener("click", function(){
   let a= $("#frm").serializeObject();
   grid.readData(1,a,true);
})
//업체검색모달 row더블클릭 이벤트
function getModalBas(param){
			$('#compCd').val(param.dtlCd);
			$('#compNm').val(param.dtlNm);
			dialog.dialog("close");
		};
		
//자재검색모달 row더블클릭 이벤트
function getModalMtr(param){
	dialog.dialog("close");
	$('#ditemCode').val(param.mtrCd);
	$('#ditemCodeNm').val(param.mtrNm);
};
//업체검색버튼
btnInCom.addEventListener("click", function(){
	mBas('MTR_COM');
	$('#ui-id-1').html('업체 검색');
});
//자재검색버튼
btnMtrCd.addEventListener("click", function(){
	mMtr();
	$('#ui-id-1').html('자재 검색');
});


</script>
</body>
</html>