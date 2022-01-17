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
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>

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
		<h3>자재입고 관리</h3>
		<div align="right">
			<button type="button" id="btnOrdFind" align="right">발주내역 조회</button>
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
					<button type="button" id="btnInCom">ㅇ</button>&nbsp;
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
let lotGrid;
let lotDataSource;


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
		    readData: { url: './mtrInForm', method: 'POST' },
	    	modifyData: { url: './mtrModify', method: 'POST' }
		  },
		  contentType: 'application/json',
		  initialRequest: false
		};
		
var mainGrid = new Grid({
     el : document.getElementById('grid'),
     data : dataSource,  // 컬럼명과 data명이 같다면 생략가능 
     rowHeaders : [ 'checkbox'],
     columns : [
				{
				   header: '입고번호',
				   name: 'inNo'
				   /* ,
				   hidden: true */
				 },
				 {
				   header: '입고일자',
				   name: 'inDate',
				   /* editor: {
						type: 'datePicker',
						options: {
						language: 'ko',
						format: 'YYYY-MM-dd'
						}
					}, */
					align: 'center',
					editor: 'text',
				   sortable: true
				 },
					{
				   header: '자재코드',
				   name: 'mtrCd',
				   align: 'center',
					editor: 'text',
				   sortable: true,
				   validation: {
		            	required: true
		          	}
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
				   align: 'left',
				   sortable: true
				 },
				 {
				   header: '업체',
				   name: 'compNm',
				   align: 'left',
				   validation: {
		            	required: true
		          	},
				   sortable: true
				 },
				 {
				   header: '발주번호',
				   name: 'ordNo',
				   align: 'center',
					editor: 'text',
					validation: {
		            	required: true
		          	},
				   sortable: true
				 },
				 {
				   header: '불량량',
				   name: 'fltAmt',
				   align: 'right',
					editor: 'text',
					validation: {
						dataType: 'number'
		          	},
				   sortable: true
				 },
				 {
				   header: '입고량',
				   name: 'inAmt',
				   align: 'right',
					editor: 'text',
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
					validation: {
		            	required: true
		          	},
				   sortable: true
				 },
				 {
				   header: '총금액',
				   name: 'totCost',
				   align: 'right',
					editor: 'text',
				   sortable: true
				 },
				 {
				   header: '자재LOT NO.',
				   name: 'mtrLot',
				   align: 'center',
					editor: 'text',
					validation: {
		            	required: true
		          	},
				   sortable: true
				 },
				{
				   header: '관리수량',
				   name: 'mngAmt'
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


function format(value){
	value = value * 1;
	return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
  
mainGrid.on('response', function(ev) {
      /* console.log(ev.xhr.response); */
      if(ev.xhr.response == 0){
      	mainGrid.readData();
      }
   });
 

mainGrid.on("dblclick",(ev)=>{
	console.log(ev);
	if (ev.columnName === 'mtrCd'){
		rowk = ev.rowKey;
		mMtr();
	} else if(ev.columnName === 'mtrLot'){
		rowk = ev.rowKey;
		mainGrid.getValue(rowk,'mtrCd');
		mainGrid.getValue(rowk,'inAmt');
		let data = [{'mtrCd':mainGrid.getValue(rowk,'mtrCd'),
					'inAmt':mainGrid.getValue(rowk,'inAmt')}]
		console.log(data)
		mMtrLot();
		lotGrid.readData(1,data,true)
		
	}
});

//클릭한 셀의 rowKey와 columnName을 가지고오는 함수
/* grid.on("click",(ev)=>{
	console.log(grid.getFocusedCell());
}) */



//모달 설정
let dialog = $( "#dialog-form" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 500
});
//발주내역모달 설정
let wideDialog = $( "#dialog-ord" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 800
});
//lot부여모달 설정
let lotDialog = $( "#dialog-lot" ).dialog({
	autoOpen : false,
	modal : true,
	buttons:{"저장":function(){
		alert("lot부여완료")
		lotGrid.blur();
		lotGrid.request('modifyData');
	}},
	resizable: false,
	height: "auto",
	width: 800
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
//mtrLot modal
function mMtrLot(){
lotDataSource = {
		  api: {
			  	readData: { url: './mtrLotModal',method: 'Post'
		     	 }
		  },
		  contentType: 'application/json'
		}

lotGrid = new Grid({
el : document.getElementById('dialog-lot'),
data : lotDataSource,
columns : [ 
			{
				header: '순서',
				name: 'seq'
			},
			{
				header: '자재LOTNO',
				name: 'mtrLot'
			},
			{
				header: '입고량',
				name: 'stckCnt'
			},
			{
				header: '비고',
				name: 'cmt'
			}
			]
});
/* lotGrid.on('dblclick', ev => {
	getModalOrd(ordGrid.getRow(ev.rowKey));
}); */
}
/* $('#dialog-ord').empty(); */

//mtrOrd modal
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
columns : [ 
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
				header: '관리수량',
				name: 'mngAmt',
				hidden: true
			},		
			{
				header: '발주번호',
				name: 'ordNo',
				hidden: true
			}
			]
});
ordGrid.on('dblclick', ev => {
	getModalOrd(ordGrid.getRow(ev.rowKey));
});

ordGrid.on('successResponse',function(ev){
	console.log("성공")
});
ordGrid.on('failResponse',function(ev){
	console.log("실패")
});

//발주내역모달
function getModalOrd(param){
	console.log(param)
	param.rowKey = mainGrid.getRowCount();
	mainGrid.appendRow(param);	
	
	wideDialog.dialog("close");
};

//추가버튼
btnAdd.addEventListener("click", function(){
	mainGrid.appendRow({}, 
			{
				extendPrevRowSpan: true,
				focus: true
			});
});
//삭제버튼
btnDel.addEventListener("click", function(){
	mainGrid.removeCheckedRows(true);
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
	wideDialog.dialog("open");
	ordGrid.readData();
	$('#ui-id-1').html('발주 내역');
	ordGrid.refreshLayout();
});
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