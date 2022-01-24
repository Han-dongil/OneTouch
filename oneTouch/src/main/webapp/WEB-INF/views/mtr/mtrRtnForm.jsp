<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
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
		<h3>자재반품 관리</h3>
		<hr>
		<form id="frm" method="post">
			<div>
				<div>
					<label>발주일자</label> <input type="Date" id="startDate"
						name="startDate">&nbsp; <label> ~ </label>&nbsp; <input
						type="Date" id="endDate" name="endDate">
				</div>
				<div>
					<label>입고업체</label> <input type="text" id="compCd" name="compCd">
					<button type="button" id="btnInCom">ㅇ</button>
					&nbsp; <label>입고업체명</label> <input type="text" id="compNm"
						name="compNm" disabled="disabled">
				</div>
				<div>
					<label>자재코드</label> <input type="text" id="ditemCode"
						name="ditemCode">
					<button type="button" id="btnMtrCd">ㅇ</button>
					&nbsp; <label>자재명</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
						type="text" id="ditemCodeNm" name="ditemCodeNm"
						disabled="disabled">
				</div>
			</div>
		</form>
		<div align="right">
			<button type="button" id="btnFind">조회</button>
			<button type="button" id="btnSave">저장</button>
		</div>
		<hr>
	</div>
	<div id="grid"></div>
	<div id="dialog-form"></div>

<script type="text/javascript">
let rowk = -1;

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
		    readData: { url: './mtrRtnForm', method: 'POST' },
		  	modifyData: { url: './mtrRtnModify', method: 'POST'}
		  },
		  contentType: 'application/json'
		};

var mainGrid = new Grid({
     el : document.getElementById('grid'),
     data : dataSource,
     rowHeaders : [ 'checkbox'],
     columns : [
				{
				header: '발주번호',
				name: 'ordNo',
				hidden: true
				},
				{
				header: '발주일자',
				name: 'ordDate',
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
				name: 'unit',
				align: 'center',
				sortable: true
				},
				{
				header: '업체',
				name: 'compNm',
				align: 'left',
				sortable: true
				},
				{
				header: '발주량',
				name: 'ordAmt',
				align: 'right',
				sortable: true
				},
				{
				header: '입고량',
				name: 'inAmt',
				align: 'right',
				sortable: true
				},
				{
				header: '반품량',
				name: 'rtnAmt',
				align: 'right',
				editor: 'text',
				sortable: true
				},	
				{
				header: '반품사유',
				name: 'cmt',
				align: 'left',
				editor: 'text'
				}
				],
				summary : {
					height: 40,
					position: 'bottom',
					columnContent: {
						compNm: {
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
						inAmt: {
							template(summary) {
								var sumResult = (summary.sum);
								return format(sumResult);
							}
						},
						rtnAmt: {
								template(summary) {
									var sumResult = (summary.sum);
									return format(sumResult);
								}
						}
					}
				}
});
mainGrid.on('response', function(ev) {
   });
mainGrid.on('dblclick',function(ev){
	if(ev.columnName == "ordDate" ||
		ev.columnName == "compNm" || 
		ev.columnName == "mtrNm" || 
		ev.columnName == "unit" ||
		ev.columnName == "mtrCd" ||
		ev.columnName == "ordAmt" ||
		ev.columnName == "inAmt"
		){
		 toastr["error"]("변경할 수 없는 코드 입니다.", "경고입니다.")
	}
});
mainGrid.on('editingFinish',(ev)=>{
	if(ev.columnName == 'rtnAmt' 
		&& mainGrid.getValue(ev.rowKey,'rtnAmt') > (mainGrid.getValue(ev.rowKey,'ordAmt') - mainGrid.getValue(ev.rowKey,'inAmt'))){
		ev.stop();
		toastr["warning"]("반품량이 너무 많습니다.")
	}
})
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
};

//업체검색모달 row더블클릭 이벤트
function getModalBas(param){
	$('#compCd').val(param.dtlCd);
	$('#compNm').val(param.dtlNm);
	dialog.dialog("close");
};
		
//자재검색모달 row더블클릭 이벤트
function getModalMtr(param){
	dialog.dialog("close");
	if(rowk >= 0){
		mainGrid.blur();
		mainGrid.setValue(rowk, "mtrCd", param.mtrCd, false);
		mainGrid.setValue(rowk, "mtrNm", param.mtrNm, false);
		mainGrid.setValue(rowk, "unit", param.unit, false);
		mainGrid.setValue(rowk, "compNm", param.compNm, false);
		mainGrid.setValue(rowk, "mngAmt", param.mngAmt, false);
		rowk = -1;
	} else {
		$('#ditemCode').val(param.mtrCd);
		$('#ditemCodeNm').val(param.mtrNm);
	}
};

//조회버튼
btnFind.addEventListener("click", function(){
   let param= $("#frm").serializeObject();
   mainGrid.readData(1,param,true);
})
//저장버튼
btnSave.addEventListener("click", function(){
	mainGrid.blur();
	mainGrid.request('modifyData');
});
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