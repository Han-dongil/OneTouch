<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/modal.js"></script>


</head>
<body>

	<div class="container">
		<h3>자재입고 관리</h3>
		<div align="right">
			<button type="button" id="btnOrdFind">발주내역 조회</button>
		<hr>
		</div>
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
					<input type="text" id="inComCd" name="inComCd">
					<button type="button" id="btnInCom">ㅇ</button>&nbsp;
					<label>입고업체명</label>
					<input type="text" id="inComName" name="inComName" readonly="true">
				</div>
				<div>
					<label>자재코드</label>
					<input type="text" id="ditemCode" name="ditemCode">
					<button type="button" id="matrPopBtn">ㅇ</button>&nbsp;
					<label>자재명</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" id="dItemCodeNm" name="dItemCodeNm" readonly="true">
				</div>
			</div>
		</form>
		<div align="right">
		<hr>
			<button type="button" id="btnFind">조회</button>
			<button type="button" id="btnSave">저장</button>
			<button type="button" id="btnAdd">추가</button>
			<button type="button" id="btnDel">삭제</button>
		</div>
	</div>
<div id="grid"></div>
<div id="dialog-form" title="title"></div>

<script type="text/javascript">
let rowk = -1;

var Grid = tui.Grid;
Grid.applyTheme('striped', { //cell style
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
				   validation: true
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
				   name: 'comNm',
				   align: 'center',
				   sortable: true
				 },
				 {
				   header: '발주번호',
				   name: 'ordNo',
				   align: 'center',
					editor: 'text',
				   sortable: true
				 },
				 {
				   header: '불량량',
				   name: 'fltAmt',
				   align: 'center',
					editor: 'text',
				   sortable: true
				 },
				 {
				   header: '입고량',
				   name: 'inAmt',
				   align: 'center',
					editor: 'text',
				   sortable: true,
				 },
				 {
				   header: '단가',
				   name: 'unitCost',
				   align: 'center',
					editor: 'text',
				   sortable: true,
				 },
				 {
				   header: '총금액',
				   name: 'totCost',
				   align: 'center',
					editor: 'text',
				   sortable: true
				 }
				]
     
   });
  
grid.on('response', function(ev) {
      console.log(ev.xhr.response);
      if(ev.xhr.response == 0){
      grid.readData();
      }
   });
 
/* 
var grid = new Grid({
    el : document.getElementById('grid'),
    data : dataSource,  // 컬럼명과 data명이 같다면 생략가능 
    rowHeaders : [ 'checkbox'],
    columns : [
    	
    ]
});
 */


let dialog; //가져가서 사용할 때는 주석 풀어서 사용(이미 있다면 let선언 빼주거나 아니면 dialog 이름 바꿔서 사용)
dialog = $( "#dialog-form" ).dialog({ //갸져가서 주석 풀어서 사용 이미 있으면 빼고해도 됨     //<div id="dialog-form" title="title"></div> 같이 가져갈 것
	autoOpen : false,
	modal : true,
});




btnAdd.addEventListener("click", function(){
	grid.appendRow({}, 
			{
				extendPrevRowSpan: true,
				focus: true
			});
})
btnDel.addEventListener("click", function(){
	grid.removeCheckedRows(true);
})
btnSave.addEventListener("click", function(){
	grid.blur();
	grid.request('modifyData');
})
btnFind.addEventListener("click", function(){
   let a= $("#frm").serializeObject();
   grid.readData(1,a,true);
})
btnOrdFind.addEventListener("click", function(){
})
btnInCom.addEventListener("click", function(){
	mBas('MTR_COM');
})
grid.on("dblclick",(ev)=>{
	console.log(ev);
	console.log(grid);
	
	if (ev.columnName === 'mtrCd'){
		rowk = ev.rowKey;
		mMtr();
	}
})

grid.on("click",(ev)=>{
	console.log(grid.getFocusedCell());
})

function getModalBas(param){
			$('#inComCd').val(param.dtlCd);
			$('#inComName').val(param.dtlNm);
			dialog.dialog("close");
		}
		
function getModalMtr(param){
	dialog.dialog("close");
	if(rowk >= 0){
		console.log(11111111);
		console.log(rowk);
		console.log(param.mtrCd);
		//grid.appendRow({});
		
		//grid.setValue(rowk+1, "mtrCd", "aa", false);
		grid.appendRow({'mtrCd':'aa'});
		
		
		rowk = -1;
	}
}

</script>
</body>
</html>