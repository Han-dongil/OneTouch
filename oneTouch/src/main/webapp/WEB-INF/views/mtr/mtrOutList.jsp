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
<script src="${path}/resources/js/modal.js"></script>
</head>
<style type="text/css">
	.tui-grid-cell-summary{
		text-align: right;
	}
</style>
<body>
	<div class="container">
		<h3>자재출고 조회</h3>
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
					<label>공정코드</label>
					<input type="text" id="prcCd" name="prcCd">
					<button type="button" id="btnPrcCd">ㅇ</button>&nbsp;
					<label>출고공정명</label>
					<input type="text" id="prcNm" name="prcNm" disabled="disabled">
				</div>
				<div>
					<label>자재코드</label>
					<input type="text" id="ditemCode" name="ditemCode">
					<button type="button" id="btnMtrCd">ㅇ</button>&nbsp;
					<label>자재명</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" id="ditemCodeNm" name="ditemCodeNm" disabled="disabled">
				</div>
				<div>
				  <label>자재구분</label>
				  <input type="radio" id="mtrRadio" name="mtrSect" value="" checked>
				  <label for="mtrRadio">전체</label>
				  <input type="radio" id="mtrRadio" name="mtrSect" value="MTR_SECT001">
				  <label for="mtrRadio">원자재</label>
				  <input type="radio" id="semiRadio" name="mtrSect" value="MTR_SECT002">
				  <label for="semiRadio">반제품</label>
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
toastr.options = {
	       "closeButton": true,
	       "debug": false,
	       "newestOnTop": false,
	       "progressBar": true,
	       "positionClass": "toast-top-center",
	       "preventDuplicates": false,
	       "onclick": null,
	       "showDuration": "3",
	       "hideDuration": "100",
	       "timeOut": "1500",
	       "extendedTimeOut": "1000",
	       "showEasing": "swing",
	       "hideEasing": "linear",
	       "showMethod": "fadeIn",
	       "hideMethod": "fadeOut",
	       "tapToDismiss": false,
	       "closeHtml": "확인"
	     }
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
		    readData: { url: './mtrOutList', method: 'POST' }
		  },
		  contentType: 'application/json',
		  initialRequest: false
		};

var grid = new Grid({
     el : document.getElementById('grid'),
     data : dataSource,
     columns : [
				{
				   header: '출고번호',
				   name: 'outNo',
				   hidden: true
				 },
				 {
				   header: '출고일자',
				   name: 'outDt',
				   align: 'center',
				   sortable: true
				 },
					{
				   header: '자재코드',
				   name: 'mtrCd',
				   align: 'center',
				   sortable: true
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
				   header: '출고공정',
				   name: 'prcNm',
				   align: 'center',
				   sortable: true
				 },
				 {
				   header: '출고량',
				   name: 'outAmt',
				   align: 'right',
				   formatter({value}){
					   return format(value);
				   },
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
			            outAmt: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            }
					}
				}
   });
   
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
grid.on('dblclick',(ev)=>{
	toastr["error"]("변경할 수 없습니다.", "경고입니다.")
})

//조회 버튼
btnFind.addEventListener("click", function(){
   let param= $("#frm").serializeObject();
   console.log(param);
   grid.readData(1,param,true);
})
//공정검색모달 row더블클릭 이벤트
function getModalPrc(param){
	dialog.dialog("close");
	$('#prcCd').val(param.prcCd);
	$('#prcNm').val(param.prcNm);
}
		
//자재검색모달 row더블클릭 이벤트
function getModalMtr(param){
	dialog.dialog("close");
	$('#ditemCode').val(param.mtrCd);
	$('#ditemCodeNm').val(param.mtrNm);
};
//업체검색버튼
btnPrcCd.addEventListener("click", function(){
	mPrc();
	$('#ui-id-1').html('공정 검색');
});
//자재검색버튼
btnMtrCd.addEventListener("click", function(){
	mMtr();
	$('#ui-id-1').html('자재 검색');
});


</script>
</body>
</html>