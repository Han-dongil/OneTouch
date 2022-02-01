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
<div id="dialog-lot"></div>

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
			},  // 컬럼명과 data명이 같다면 생략가능 
	 scrollX : false,
	 scrollY : true,
	 bodyHeight: 400,
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
				   /* validation: {
		            	required: true
		          	}, */
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
					header: '미입고량',
					name: 'notinAmt',
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

//숫자 천의 자릿수마다 , 찍어주는 function
function format(value){
	value = value * 1;
	return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
//전체 row 총금액 계산해주는 function
function totCal(){
	let data;
	window.setTimeout(()=>{
		data = mainGrid.getData()
		for(i=0; i<data.length; i++){
			let val = data[i].inAmt*data[i].unitCost
			mainGrid.setValue(i,"totCost",val)
		}
	},100)
}

//클릭한 셀의 rowKey와 columnName을 가지고오는 함수
/* grid.on("click",(ev)=>{
	console.log(grid.getFocusedCell());
}) */

//삼항연산자 예시
/* let greeting = person => {
	  let name = person ? person.name : `stranger`
	  return `Howdy, ${name}`
	} */
//단가 * 입고량 바로 총금액으로 반영
// 내가 찍은 셀 확인 > 셀값 초기화 
mainGrid.on('editingFinish', (ev) => {
	if(ev.columnName == 'inAmt'){
		if(mainGrid.getValue(ev.rowKey, 'notinAmt') != ''){
			if(mainGrid.getValue(ev.rowKey, 'inAmt')*1 > mainGrid.getValue(ev.rowKey, 'notinAmt')*1){
				toastr["info"]("입고량이 해당자재의 미입고량보다 많습니다.")
				mainGrid.setValue(ev.rowKey, 'inAmt', mainGrid.getValue(ev.rowKey, 'inAmt'))
				//ev.stop();
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
}) 
//기존의 데이터는 수정이안되게 하는것
mainGrid.on('editingStart', (ev) => {
    if(ev.columnName == 'mtrNm') {
       var value = mainGrid.getValue(ev.rowKey, 'mtrCd');
    	rowk = ev.rowKey;
		mMtr();
    }else if(ev.columnName == 'ordNo') {
       value = mainGrid.getValue(ev.rowKey, 'ordNo');
       if(value != '') {
          /* alert('발주번호는 수정이 불가능합니다'); */
          /* toastr.info('hi'); */
    	   toastr["error"]("변경할 수 없는 코드 입니다.", "경고입니다.")
          ev.stop();
       }
    }
})
mainGrid.on('dblclick', (ev) => {
	if(ev.columnName == 'unitNm' || ev.columnName == 'compNm') {
	       toastr["info"]("자재명 수정해 주세요.")
	    }
})
mainGrid.on('onGridUpdated', ev => {
	//totCal();
	rowk = mainGrid.getRowCount();
})
//모달 설정
let dialog = $( "#dialog-form" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 500
});
//발주내역모달 설정
let ordDialog = $( "#dialog-ord" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 800,
	buttons:{
		"확인":()=>{
		let rows = ordGrid.getCheckedRows();
		for(row of rows){
			row.inDate = today();
			row.rowKey = mainGrid.getRowCount();
			row.inAmt = row.notinAmt;
			mainGrid.appendRow(row,{focus:true});
			mainGrid.setValue(row.rowKey,"totCost",row.notinAmt*row.unitCost)
		}
		/* for(let i=0; i<rows.length; i++){
			mainGrid.appendRow();
			mainGrid.setRow(mainGrid.getRowCount()-1,rows[i]);
			//mainGrid.setRow(rowk+i,rows[i]);
		}*/
		mainGrid.uncheckAll();
	/* 	let data;
		window.setTimeout(()=>{
			data = mainGrid.getData()
			for(i=0; i<data.length; i++){
				let val = data[i].inAmt*data[i].unitCost
				mainGrid.setValue(i,"totCost",val)
			}
		},100) */
		ordDialog.dialog("close");
	}
}
});
function getModalOrd(param){
	/* 	let flag = 0;
		for(data of mainGrid.getData()) {
			if(data.mtrCd == param.mtrCd) {
				alert("이미 등록된 자재입니다.")
				flag = 1;
			}
		}
		if(flag != 1) {
			mainGrid.setValue(rowk, "mtrCd", param.mtrCd, false);
			mainGrid.setValue(rowk, "mtrNm", param.mtrNm, false);
			dialog.dialog("close");		
		}
		 */
		param.rowKey = mainGrid.getRowCount();
		param.inAmt = 0;
		mainGrid.appendRow(param,{focus:true});
		totCal();
		mainGrid.setValue(param.rowKey, 'inDate', today())
		ordDialog.dialog("close");
	};

//업체검색모달 row더블클릭 이벤트
//메인의 input박스 채우는거랑, 모달속 input박스채우는거 구분
function getModalBas(param,ev){
	if(ev.id == "InCom"){
		$('#mCompCd').val(param.dtlCd);
		$('#mCompNm').val(param.dtlNm);
	} else if(ev.id == "btnInCom"){
		$('#compCd').val(param.dtlCd);
		$('#compNm').val(param.dtlNm);
	}
		dialog.dialog("close");
};
		
//자재검색모달 row더블클릭 이벤트
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

//발주내역 모달
let ordDataSource = {
		  api: {
			  	readData: { url: './mtrOrdModal',method: 'GET'
		     	 }
		  },
		  contentType: 'application/json'
		}

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
ordGrid.on('onGridUpdated', ev => {
	let datas = mainGrid.getData();
	let rows = ordGrid.getData();
	console.log(rowk)
	console.log(mainGrid.getRowCount()-1)
	//if(rowk != mainGrid.getRowCount()-1){
		for(i=rowk; i<mainGrid.getRowCount(); i++){
			for(row of rows){
				if(datas[i].ordNo == row.ordNo 
						&& datas[i].notinAmt == row.notinAmt
						&& datas[i].mtrNm == row.mtrNm){
					ordGrid.removeRow(row.rowKey)
				}
			}
		}
	//}
})
ordGrid.on('dblclick', ev => {
	getModalOrd(ordGrid.getRow(ev.rowKey));
});



//추가버튼
btnAdd.addEventListener("click", function(){
	//mainGrid.appendRow({},{'at':0});
	mainGrid.appendRow({},{focus:true});
	mainGrid.setValue(mainGrid.getRowCount()-1, 'inDate', today())
});
//삭제버튼
btnDel.addEventListener("click", function(){
	mainGrid.removeCheckedRows(true);
	mainGrid.request('deleteData');
});
//저장버튼
btnSave.addEventListener("click", function(){
	mainGrid.blur();
	mainGrid.request('modifyData');
	
});
//조회버튼
btnFind.addEventListener("click", function(){
   let param= $("#frm").serializeObject();
   mainGrid.readData(1,param,true);
});
//발주내역버튼
btnOrdFind.addEventListener("click", function(){
	ordDialog.dialog("open");
	ordGrid.readData();
	$('#ui-id-2').html('발주 내역');
	ordGrid.refreshLayout();
});
//업체검색버튼 function
function inComList(){
	mBas('MTR_COM',event.target);
	$('#ui-id-1').html('업체 검색');
};
//자재검색버튼
btnMtrCd.addEventListener("click", function(){
	mMtr();
	$('#ui-id-1').html('자재 검색');
});



/* //반품처리모달 설정
let rtnDialog = $( "#dialog-rtn" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 800,
	buttons:{
		"반품처리":()=>{
			rtnGrid.blur();
			rtnGrid.request('modifyData', {
				checkedOnly: true
			});
			
			//modify 처리 후 모달 자동으로 꺼주는 기능 **************************모르겠음
			rtnGrid.on('successResponse',function(ev){
				console.log(ev)
				rtnDialog.dialog("close");
			});
		}
	}
});
//반품 모달
let rtnDataSource = {
		  api: {
			  	readData: { url: './mtrRtnModal',method: 'POST'},
			  	modifyData: { url: './mtrRtnModify', method: 'POST'}
		  },
		  contentType: 'application/json'
		}

let rtnGrid = new Grid({
el : document.getElementById('dialog-rtn'),
data : rtnDataSource,
rowHeaders : [ 'checkbox'],
columns : [ 
			{
				header: '발주번호',
				name: 'ordNo',
				hidden: true
			},
			{
				header: '발주일자',
				name: 'ordDate'
			},
			{
				header: '입고업체명',
				name: 'compNm'
			},
			{
				header: '자재명',
				name: 'mtrNm'
			},
			{
				header: '단위',
				name: 'unit'
			},
			{
				header: '반품량',
				name: 'rtnAmt',
				editor: 'text'
			},	
			{
				header: '반품사유',
				name: 'cmt',
				editor: 'text'
			}
			]
});
rtnGrid.on('dblclick',function(ev){
	if(ev.columnName == "ordDate" || ev.columnName == "compNm" || ev.columnName == "mtrNm" || ev.columnName == "unit"){
		 toastr["error"]("변경할 수 없는 코드 입니다.", "경고입니다.")
	}
});
rtnGrid.on('successResponse',function(ev){
	console.log("성공")
});
rtnGrid.on('failResponse',function(ev){
	console.log("실패")
});


//반품처리버튼
btnRtn.addEventListener("click", function(){
	document.getElementById("mStartDate").value = null;
	document.getElementById("mEndDate").value = null;
	document.getElementById("mCompCd").value = null;
	document.getElementById("mCompNm").value = null;
	rtnDialog.dialog("open");
	rtnGrid.readData(1,{},true);
	rtnGrid.refreshLayout();
});
//조회버튼 in 반품모달
rtnSearch.addEventListener("click", function(){
   let param= $("#rtnFrm").serializeObject();
   rtnGrid.readData(1,param,true);
});
 */
</script>

</body>
</html>