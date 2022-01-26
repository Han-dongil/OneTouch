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
		<h3>재고조정 관리</h3>
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
			<button type="button" id="btnSave">저장</button>
			<button type="button" id="btnAdd">추가</button>
			<button type="button" id="btnDel">삭제</button>
		</div>
		<hr>
	</div>
	<div id="grid"></div>
	<div id="dialog-form"></div>
	<div id="dialog-lot">
		<label>자재코드</label>
		<input type="text" id="mDitemCode" name="ditemCode" disabled="disabled">
		<br>
		<label>자재명</label>&nbsp;&nbsp;&nbsp;
		<input type="text" id="mDitemCodeNm" name="ditemCodeNm" disabled="disabled">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<label>단위</label>
		<input type="text" id="mUnitNm" name="unitNm" disabled="disabled">
	</div>

<script type="text/javascript">
let rowk = -1;
let dt = new Date();

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
		    readData: { url: './mtrCalForm', method: 'POST' },
		  	modifyData: { url: './mtrCalModify', method: 'POST'}
		  },
		  contentType: 'application/json',
		  initialRequest: false
		};

var mainGrid = new Grid({
     el : document.getElementById('grid'),
     data : dataSource,
     rowHeaders : [ 'checkbox'],
     columns : [
				 {
				   header: '정산구분',
				   name: 'calSectNm',
				   editor: {
						type: 'radio',
						options: {
					        listItems: [
					          { text: '입고정산', value: '입고정산' },
					          { text: '출고정산', value: '출고정산' }
					        ]
					     }
					},
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
				   header: '정산량',
				   name: 'calAmt',
				   formatter({value}){
					   if(value != null){
					   	return format(value);
					   } else{
					   	return 0;
					   }
				   },
				   align: 'right',
				   editor: 'text',
				   sortable: true
				 },
				 {
				   header: 'Lot No',
				   name: 'mtrLot',
				   align: 'center',
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
						unitNm: {
			                template(summary) {
			        			return '합 계';
			                } 
			            },	
			            calAmt: {
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
	rowk = ev.rowKey
	if(ev.columnName == "mtrLot"){
		if(mainGrid.getValue(ev.rowKey, 'mtrCd') == null || mainGrid.getValue(ev.rowKey, 'mtrCd') == ''){
			toastr["warning"]("자재코드를 입력해주세요.")
		}else{
			let row = mainGrid.getRow(ev.rowKey);
			 lotDialog.dialog("open");
			 document.getElementById('mDitemCode').value = row.mtrCd
			 document.getElementById('mDitemCodeNm').value = row.mtrNm
			 document.getElementById('mUnitNm').value = row.unitNm
			 lotGrid.readData(1,row,true);
			 lotGrid.refreshLayout();	
		}
	}
	if(ev.columnName == "mtrCd"){
		mMtr();
		$('#ui-id-1').html('자재 검색');
	}
});
mainGrid.on('editingFinish',(ev)=>{
	/* if(ev.columnName == 'rtnAmt' 
		&& mainGrid.getValue(ev.rowKey,'rtnAmt') > (mainGrid.getValue(ev.rowKey,'ordAmt') - mainGrid.getValue(ev.rowKey,'inAmt'))){
		ev.stop();
		toastr["warning"]("반품량이 너무 많습니다.")
	} */
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

//자재검색모달 row더블클릭 이벤트
function getModalMtr(param){
	dialog.dialog("close");
	console.log(rowk)
	console.log(param)
	if(rowk >= 0){
		mainGrid.blur();
		mainGrid.setValue(rowk, "mtrCd", param.mtrCd, false);
		mainGrid.setValue(rowk, "mtrNm", param.mtrNm, false);
		mainGrid.setValue(rowk, "unitNm", param.unitNm, false);
		/* mainGrid.setValue(rowk, "compNm", param.compNm, false);
		mainGrid.setValue(rowk, "mngAmt", param.mngAmt, false); */
		rowk = -1;
	} else {
		$('#ditemCode').val(param.mtrCd);
		$('#ditemCodeNm').val(param.mtrNm);
	}
};

//셀에 오늘날짜 넣는 function
function today(ev) {
	let year = dt.getFullYear()
	let month = ('0' + (dt.getMonth()+1)).slice(-2)
	let day = ('0' + (dt.getDate())).slice(-2)
	let str = year + '-' + month + '-' + day
	mainGrid.setValue(ev, 'calDate', str)
}

//조회버튼
btnFind.addEventListener("click", function(){
   let param= $("#frm").serializeObject();
   console.log(param)
   mainGrid.readData(1,param,true);
})
//저장버튼
btnSave.addEventListener("click", function(){
	mainGrid.blur();
	mainGrid.request('modifyData');
})
//추가버튼
btnAdd.addEventListener("click", function(){
	mainGrid.appendRow();
	today(mainGrid.getRowCount()-1)
	
});
//삭제버튼
btnDel.addEventListener("click", function(){
	mainGrid.removeCheckedRows(true);
});

//자재검색버튼
btnMtrCd.addEventListener("click", function(){
	mMtr();
	$('#ui-id-1').html('자재 검색');
});

//lot선택모달 설정
let lotDialog = $( "#dialog-lot" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 800,
	buttons:{
		"확인":()=>{
			let rows = lotGrid.getCheckedRows();
			console.log(rows);
			let year = dt.getFullYear()
			let month = ('0' + (dt.getMonth()+1)).slice(-2)
			let day = ('0' + (dt.getDate())).slice(-2)
			let str = year + '-' + month + '-' + day
			for(row of rows){
				row.calDate = str
				console.log(row);
			}
			mainGrid.setValue(rowk, 'mtrLot', rows[0].mtrLot)
			rows.splice(0,1);
			mainGrid.appendRows(rows);
			lotDialog.dialog("close");
		}
	}
});

//lot 모달
let lotDataSource = {
		  api: {
			  	readData: { url: './mtrLotModal',method: 'POST'}
		  },
		  contentType: 'application/json',
		  initialRequest: false
		}

let lotGrid = new Grid({
el : document.getElementById('dialog-lot'),
data : lotDataSource,
rowHeaders : [ 'checkbox'],
columns : [ 
			{
				header: '입고번호',
				name: 'inNo'
			},
			{
				header: 'Lot No',
				name: 'mtrLot'
			},
			{
				header: '홀딩수량',
				name: 'hldCnt'
			},
			{
				header: '재고수량',
				name: 'stckCnt'
			},
			{
				header: '정산일자',
				name: 'calDate',
				hidden: true
			},
			{
				header: '자재코드',
				name: 'mtrCd',
				hidden: true
			},
			{
				header: '자재명',
				name: 'mtrNm',
				hidden: true
			},
			{
				header: '단위',
				name: 'unitNm',
				hidden: true
			},
			{
				header: '정산량',
				name: 'calAmt',
				hidden: true
			}
			]
});
lotGrid.on('dblclick',function(ev){
	if(ev.columnName == "inNo" || ev.columnName == "mtrLot" || ev.columnName == "hldCnt" || ev.columnName == "stckCnt"){
		 toastr["error"]("변경할 수 없는 코드 입니다.", "경고입니다.")
	}
});
/*
//조회버튼 in 반품모달
rtnSearch.addEventListener("click", function(){
   let param= $("#rtnFrm").serializeObject();
   rtnGrid.readData(1,param,true);
});
 */
</script>
</body>
</html>