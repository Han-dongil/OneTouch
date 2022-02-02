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
	<div id="dialog-form">
		<label>자재구분</label>
		<input type="text" id="mDitemCode" name="ditemCode">
		<br>
		<label>입고업체</label>&nbsp;&nbsp;&nbsp;
		<input type="text" id="mDitemCodeNm" name="ditemCodeNm">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
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

const dataSource = {
		  api: {
		    readData: { url: './mtrCalForm', method: 'POST' },
		  	createData: { url: './mtrCalCreate', method: 'POST'}
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
     rowHeaders : [ 'checkbox'],
     columns : [
				 {
				   header: '정산구분',
				   name: 'calSectNm',
				   align: 'center',
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
				   editor: {
						type: 'datePicker',
						options: {
						language: 'ko',
						format: 'yyyy-MM-dd'
						}
					 },
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
				   header: '재고수량',
				   name: 'stckCnt',
				   align: 'right',
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
				   header: '비고',
				   name: 'cmt',
				   align: 'left',
				   sortable: true,
				   editor: 'text'
				 },
				 {
				   header: '정산구분',
				   name: 'calSect',
				   hidden: true
				 },
				 {
				   header: '단위',
				   name: 'unit',
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
mainGrid.on('editingFinish', function(ev) {
	if(ev.columnName == 'calSectNm'){
		if(mainGrid.getValue(ev.rowKey,'calSectNm') == '입고정산'){
			mainGrid.setValue(ev.rowKey,'calSect','MTR_CAL001')
		}else if(mainGrid.getValue(ev.rowKey,'calSectNm') == '출고정산'){
			mainGrid.setValue(ev.rowKey,'calSect','MTR_CAL002')
		}
	}
	if(ev.columnName == 'calAmt'){
		if(mainGrid.getValue(ev.rowKey,'calSectNm') == '출고정산'){
			if(mainGrid.getValue(ev.rowKey,'calAmt') > mainGrid.getValue(ev.rowKey,'stckCnt')){
				toastr["warning"]("출고정산량이 현재고보다 많습니다.")
				ev.stop();
			}
		}
	}
	mainGrid.refreshLayout();
   });
mainGrid.on('dblclick',function(ev){
	rowk = ev.rowKey
	if(ev.columnName == "mtrLot"){
		$('#ui-id-2').html('자재별 LOT정보');
		if(mainGrid.getValue(ev.rowKey, 'mtrNm') == null || mainGrid.getValue(ev.rowKey, 'mtrNm') == ''){
			toastr["warning"]("자재를 선택해 주세요.")
		}else if(mainGrid.getValue(ev.rowKey, 'calSectNm') == null || mainGrid.getValue(ev.rowKey, 'calSectNm') == ''){
			toastr["warning"]("정산 구분을 입력해 주세요.")
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
	if(ev.columnName == "mtrNm"){
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
	if(rowk >= 0){
		mainGrid.blur();
		mainGrid.setValue(rowk, "mtrCd", param.mtrCd, false);
		mainGrid.setValue(rowk, "mtrNm", param.mtrNm, false);
		mainGrid.setValue(rowk, "unitNm", param.unitNm, false);
		mainGrid.setValue(rowk, "unit", param.unit, false);
		/* mainGrid.setValue(rowk, "compNm", param.compNm, false);
		mainGrid.setValue(rowk, "mngAmt", param.mngAmt, false); */
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
	mainGrid.request('createData');
	//mainGrid.readData();
})
//추가버튼
btnAdd.addEventListener("click", function(){
	mainGrid.appendRow({},{focus:true});
	mainGrid.setValue(mainGrid.getRowCount()-1, 'calDate', today())
});
//삭제버튼
btnDel.addEventListener("click", function(){
	mainGrid.removeCheckedRows(true);
	mainGrid.request('deleteData');
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
			let year = dt.getFullYear()
			let month = ('0' + (dt.getMonth()+1)).slice(-2)
			let day = ('0' + (dt.getDate())).slice(-2)
			let str = year + '-' + month + '-' + day
			let calSect = mainGrid.getValue(rowk, 'calSect')
			let calSectNm = mainGrid.getValue(rowk, 'calSectNm')
			for(row of rows){
				row.calDate = str
				row.calSect = calSect
				row.calSectNm = calSectNm
			}
			mainGrid.setValue(rowk, 'mtrLot', rows[0].mtrLot)
			mainGrid.setValue(rowk, 'stckCnt', rows[0].stckCnt)
			rows.splice(0,1);
			console.log("rows")
			console.log(rows)
			
			for(let i=0; i<rows.length; i++){
				mainGrid.appendRow();
				mainGrid.setRow(mainGrid.getRowCount()-1,rows[i]);
				//mainGrid.setRow(rowk+i,rows[i]);
			}
			mainGrid.uncheckAll();
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
scrollX : false,
scrollY : true,
bodyHeight: 400,
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
				header: '단위코드',
				name: 'unit',
				hidden: true
			},
			{
				header: '정산량',
				name: 'calAmt',
				hidden: true
			},
			{
				header: '정산구분',
				name: 'calSectNm',
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