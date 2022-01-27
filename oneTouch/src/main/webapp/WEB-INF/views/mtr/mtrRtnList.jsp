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
		<h3>자재반품 조회</h3>
		<hr>
		<form id="frm" method="post">
			<div>
				<div>
					<label>반품요청일자</label> <input type="Date" id="startDate"
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
		</div>
		<hr>
	</div>
	<div id="grid"></div>
	<div id="dialog-form"></div>

<script type="text/javascript">
const dataSource = {
		  api: {
		    readData: { url: './mtrRtnList', method: 'POST' }
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
				header: '반품번호',
				name: 'rtnNo',
				hidden: true
				},
				{
				header: '반품요청일자',
				name: 'rtnReqDate',
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
				header: '단가',
				name: 'unitCost',
				align: 'right',
				sortable: true
				},
				{
				header: '반품량',
				name: 'rtnAmt',
				align: 'right',
				sortable: true
				},
				{
				header: '금액',
				name: 'totCost',
				align: 'right',
				formatter({value}){
					   return format(value);
			   	},
				sortable: true
				},
				{
				header: '반품사유',
				name: 'cmt',
				align: 'left'
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
						unitCost: {
			                template(summary){
			        			return "MIN: "+summary.min+"<br>"+"MAX: "+summary.max;
			                } 
			            },
						rtnAmt: {
								template(summary) {
									var sumResult = (summary.sum);
									return format(sumResult);
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
mainGrid.on('dblclick',function(ev){
	if(ev.columnName == "rtnReqDate" ||
		ev.columnName == "compNm" || 
		ev.columnName == "mtrCd" ||
		ev.columnName == "mtrNm" ||
		ev.columnName == "unit" ||
		ev.columnName == "rtnAmt" ||
		ev.columnName == "totCost" ||
		ev.columnName == "cmt"
		){
		 toastr["error"]("변경할 수 없는 코드 입니다.", "경고입니다.")
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
function totCal(){
	let data;
	window.setTimeout(()=>{
		data = mainGrid.getData()
		for(i=0; i<data.length; i++){
			let val = data[i].rtnAmt*data[i].unitCost
			console.log(val)
			mainGrid.setValue(i,"totCost",val)
		}
	},100)
}
mainGrid.on("response", function(ev){
	totCal()
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
	$('#ditemCode').val(param.mtrCd);
	$('#ditemCodeNm').val(param.mtrNm);
};

//조회버튼
btnFind.addEventListener("click", function(){
   let param= $("#frm").serializeObject();
   mainGrid.readData(1,param,true);
})
//업체검색모달 row더블클릭 이벤트
function getModalBas(param){
	dialog.dialog("close");
	$('#compCd').val(param.dtlCd);
	$('#compNm').val(param.dtlNm);
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