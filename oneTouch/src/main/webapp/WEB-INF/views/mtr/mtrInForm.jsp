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
<div id="dialog-form" title="title"></div>
<div id="dialog-form2" title="title"></div>

<script type="text/javascript">
let rowk = -1;

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
		
var grid = new Grid({
     el : document.getElementById('grid'),
     data : dataSource,  // 컬럼명과 data명이 같다면 생략가능 
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
				   align: 'center',
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
				   align: 'center',
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
				   align: 'center',
					editor: 'text',
					validation: {
						dataType: 'number'
		          	},
				   sortable: true
				 },
				 {
				   header: '입고량',
				   name: 'inAmt',
				   align: 'center',
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
				   align: 'center',
					editor: 'text',
					validation: {
		            	required: true
		          	},
				   sortable: true
				 },
				 {
				   header: '총금액',
				   name: 'totCost',
				   align: 'center',
					editor: 'text',
				   sortable: true
				 },
				 {
				   header: '자재LOT NO.',
				   name: '',
				   align: 'center',
					editor: 'text',
					validation: {
		            	required: true
		          	},
				   sortable: true
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
  
grid.on('response', function(ev) {
      /* console.log(ev.xhr.response); */
      if(ev.xhr.response == 0){
      	grid.readData();
      }
   });
 

grid.on("dblclick",(ev)=>{
	console.log(ev);
	if (ev.columnName === 'mtrCd'){
		rowk = ev.rowKey;
		mMtr();
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

let dialogOrd = $( "#dialog-form2" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 500
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
	/* console.log($('#ditemCode').val(param.mtrCd)) */
	if(rowk >= 0){
		//grid.appendRow({});
		grid.blur();
		grid.setValue(rowk, "mtrCd", param.mtrCd, false);
		grid.setValue(rowk, "mtrNm", param.mtrNm, false);
		grid.setValue(rowk, "unit", param.unit, false);
		grid.setValue(rowk, "compNm", param.compNm, false);
		//grid.appendRow({'mtrCd':'aa'});
		rowk = -1;
	} else {
		$('#ditemCode').val(param.mtrCd);
		$('#ditemCodeNm').val(param.mtrNm);
	}
};

let modalDataSource = {
		  api: {
			  	readData: { url: '.',method: 'GET'
		     	 }  
		  },
		  contentType: 'application/json'
		}

let ordGrid = new tui.Grid({
el : document.getElementById('dialog-form2'),
data : modalDataSource,
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
			}						
			]
});

//발주 모달
function mMtrOrd(){
	let ordData;
	$.ajax({
		url : './mtrOrdModal',
		dataType : 'json',
		async : false,
		success : function(a){
			/* ordData = {'result':true};
			ordData.data = {'contents':a}; */
			console.log(a);
			ordGrid.resetData(a);
		}
	});
	$("#dialog-form2").attr('title', '발주 내역');
	
	dialogOrd.dialog("open");
	
		
		ordGrid.on('dblclick', ev => {
			console.log(ordGrid.getRow(ev.rowKey)) //ajax result(ev.rowKey)
			getModalOrd(ordGrid.getRow(ev.rowKey));
		})
		
		ordGrid.on('successResponse',function(ev){
			console.log("성공")
		})
		ordGrid.on('failResponse',function(ev){
			console.log("실패")
		})
} 

//발주내역모달
function getModalOrd(param){
	console.log(param);
	grid.appendRow(param);		
	dialogOrd.dialog("close");
};

//추가버튼
btnAdd.addEventListener("click", function(){
	grid.appendRow({}, 
			{
				extendPrevRowSpan: true,
				focus: true
			});
});
//삭제버튼
btnDel.addEventListener("click", function(){
	grid.removeCheckedRows(true);
});
//저장버튼
btnSave.addEventListener("click", function(){
	grid.blur();
	grid.request('modifyData');
});
//조회버튼
btnFind.addEventListener("click", function(){
   let param= $("#frm").serializeObject();
   grid.readData(1,param,true);
});
//발주내역버튼
btnOrdFind.addEventListener("click", function(){
	mMtrOrd();
});
//업체검색버튼
btnInCom.addEventListener("click", function(){
	mBas('MTR_COM');
});
//자재검색버튼
btnMtrCd.addEventListener("click", function(){
	mMtr();
});


</script>

</body>
</html>