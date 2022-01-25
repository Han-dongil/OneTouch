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

let dt = new Date();
/* toastr.options = {
	    "closeButton": true,
	    "debug": false,
	    "positionClass": "toast-bottom-left",
	    "onclick": null,
	    "showDuration": "1000",
	    "hideDuration": "1000",
	    "timeOut": "5000",
	    "extendedTimeOut": "1000",
	    "showEasing": "swing",
	    "hideEasing": "linear",
	    "showMethod": "fadeIn",
	    "hideMethod": "fadeOut"
	}
	 */
//VO 에서 임의 CRUD 값을 받아와서 이미 입력된 값으면 R 이란느 값이
// toastr 옵션 옵션설정이 위에 먼저 와있어야 설정이 먹는다.
toastr.options = {
       "closeButton": true,  //닫기버튼(X 표시)
       "debug": false,       //디버그
       "newestOnTop": false,
       "progressBar": true,  //진행률 표시
       "positionClass": "toast-top-center",
       "preventDuplicates": false,    //중복 방지(같은거 여러개 안뜸)
       "onclick": null,             //알림창 클릭시 alert 창 활성화 (다른것도 되는지는 연구해봐야함)
       "showDuration": "3",
       "hideDuration": "100",
       "timeOut": "1500",   //사라지는데 걸리는 시간
       "extendedTimeOut": "1000",  //마우스 올리고 연장된 시간
       "showEasing": "swing",
       "hideEasing": "linear",
       "showMethod": "fadeIn",
       "hideMethod": "fadeOut",
       "tapToDismiss": false,
       "closeHtml": "확인"
     }
   
//success: 성공(초록) , info:정보(하늘색) , warning:경고(주황) , error:에러(빨강)

//현재 펑션을 멈춤
let rowk = -1;
let lotGrid;

var Grid = tui.Grid;
Grid.applyTheme('striped', {
     cell: {
       header: {
         background: '#eef'
       },
       evenRow: {
         background: '#fee'
       }
    }
});
Grid.setLanguage('ko');
/* Grid.setLanguage('ko', {
  	display: {
        noData: 'No data.',
        loadingData: 'Loading data.',
        resizeHandleGuide: 'You can change the width of the column by mouse drag, ' +
                            'and initialize the width by double-clicking.'
    },
    net: {
        confirmCreate: 'Are you sure you want to create {{count}} data?',
        confirmUpdate: 'Are you sure you want to update {{count}} data?',
        confirmDelete: 'Are you sure you want to delete {{count}} data?',
        confirmModify: 'Are you sure you want to modify {{count}} data?',
        noDataToCreate: 'No data to create.',
        noDataToUpdate: 'No data to update.',
        noDataToDelete: 'No data to delete.',
        noDataToModify: '반품처리할 내용을 입력해 주세요.',
        failResponse: 'An error occurred while requesting data.\nPlease try again.'
    }
}); */

var mainGrid = new Grid({
     el : document.getElementById('grid'),
     data : {
		  api: {
			    readData: { url: './mtrInForm', method: 'POST' },
		    	modifyData: { url: './mtrModify', method: 'POST' }
			  },
			  contentType: 'application/json',
			  initialRequest: false
			},  // 컬럼명과 data명이 같다면 생략가능 
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
				   /* editor: 'datePicker', */
				   editor: {
					type: 'datePicker',
					options: {
					language: 'ko',
					format: 'yyyy-MM-dd'
					}
				 },
					align: 'center',
					/* editor: 'text', */
				   sortable: true
				 },
				 {
				   header: '자재코드',
				   name: 'mtrCd',
				   align: 'center',
				   editor: 'text',
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
				   header: '불량량',
				   name: 'fltAmt',
				   align: 'right',
				   editor: 'text',
				   formatter({value}){
					   return format(value);
				   },
					/* validation: {
						dataType: 'number'
		          	}, */
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
					/* validation: {
						dataType: 'number',
		            	required: true
		          	}, */
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
//단가 * 입고량 바로 총금액으로 반영
mainGrid.on('editingFinish', (ev) => {
	let inAmt = mainGrid.getValue(ev.rowKey,"inAmt")
	let unitCost = mainGrid.getValue(ev.rowKey,"unitCost")
	if(inAmt != 0){
		mainGrid.setValue(ev.rowKey,"totCost",inAmt*unitCost)
	}
}) 
//기존의 데이터는 수정이안되게 하는것
mainGrid.on('editingStart', (ev) => {
    if(ev.columnName == 'mtrCd') {
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
	if(ev.columnName == 'mtrNm' || ev.columnName == 'unit' || ev.columnName == 'compNm') {
	       toastr["warning"]("자재코드를 수정해 주세요.")
	    }
})
//셀에 오늘날짜 넣는 function
function today(ev) {
	let year = dt.getFullYear()
	let month = ('0' + (dt.getMonth()+1)).slice(-2)
	let day = ('0' + (dt.getDate())).slice(-2)
	let str = year + '-' + month + '-' + day
	mainGrid.setValue(ev, 'inDate', str)
}

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
mainGrid.on("response", function(ev) {
	//totCal()
		//mainGrid.setValue(0,"totCost",125)
      /* console.log(ev.xhr.response);
      if(ev.xhr.response == 0){
      	mainGrid.readData();
      } */ 
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
let ordDialog = $( "#dialog-ord" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 800
});

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
		mainGrid.setValue(rowk, "compNm", param.compNm, false);
		mainGrid.setValue(rowk, "mngAmt", param.mngAmt, false);
		rowk = -1;
	} else {
		$('#ditemCode').val(param.mtrCd);
		$('#ditemCodeNm').val(param.mtrNm);
	}
};
//mtrLot modal
/* function mMtrLot(){

	lotGrid = new Grid({
	el : document.getElementById('dialog-lot'),
	data : {
		  api: {
			  	readData: { url: './mtrLotModal',method: 'Post'
		     	 }
		  },
		  contentType: 'application/json'
		},
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
	lotGrid.on('dblclick', ev => {
		getModalOrd(ordGrid.getRow(ev.rowKey));
	});
} */
/* $('#dialog-ord').empty(); */

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

function getModalOrd(param){
	param.rowKey = mainGrid.getRowCount();
	mainGrid.appendRow(param);
	totCal();
	today(param.rowKey);
	ordDialog.dialog("close");
};

//추가버튼
btnAdd.addEventListener("click", function(){
	mainGrid.appendRow();
	console.log(mainGrid.getRowCount()-1)
	today(mainGrid.getRowCount()-1)
	
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
	ordDialog.dialog("open");
	ordGrid.readData();
	$('#ui-id-1').html('발주 내역');
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