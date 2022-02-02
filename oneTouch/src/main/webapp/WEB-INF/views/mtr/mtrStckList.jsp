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
	/* 안전재고수량경고 */
	.warning{background-color: #F44336}
	.caution{background-color: #FF9800}
</style>
<body>
	<div class="container">
		<h3>자재재고 조회</h3>
		<hr>
		<form id="frm" method="post">
			<div>
				<div>
					<label>입고일자</label>
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
				<div id="mtrRadio">
					<label>자재구분</label>
					<input type="radio" id="allRadio" name="mtrSect" value="" checked>
					<label for="allRadio">전체</label>
					<!-- <input type="radio" id="lotRadio" name="mtrSect" value="MTR_SECT001">
					<label for="lotRadio">원자재</label>
					<input type="radio" id="mtrRadio" name="mtrSect" value="MTR_SECT002">
					<label for="mtrRadio">반제품</label> -->
				</div>
			</div>
		</form>
		<hr>
	</div>
	<div align="right">
		<button type="button" id="btnFind">조회</button>
	</div>
	<div id="tabs">
		<ul>
		  <li><a href="#lotTab">Lot별</a></li>
		  <li><a href="#mtrTab">자재별</a></li>
		</ul>
		<div id="lotTab"></div>
		<div id="mtrTab"></div>
	</div>
<div id="dialog-form"></div>

<script type="text/javascript">
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


//---------DB의 데이터로 자재구분 radio만드는 기능---------
fetch('mtrStckRadio')
.then(response=>response.json())
.then(result=>{
	let div = document.getElementById("mtrRadio");
	for(let i = 0; i < result.length; i++){
		let input = document.createElement("input");
		let label = document.createElement("label");
		input.type = "radio";
		input.name = "mtrSect";
		input.id = result[i].dtlCd;
		input.value = result[i].dtlCd;
		label.setAttribute("for",result[i].dtlCd);
		label.innerText = result[i].dtlCmt;
		div.appendChild(input);
		div.appendChild(label);
	}
});
//---------DB의 데이터로 자재구분 radio만드는 기능 끝---------


//---------Jquery tabs---------
$( function() {
    $( "#tabs" ).tabs({
    	activate: function( event, ui ) {
    		if(ui.newTab[0].innerText == '자재별'){
    			mtrGrid.refreshLayout();
    		} else {
    			lotGrid.refreshLayout();
    		}
    	}
    });
});
//---------Jquery tabs 끝---------


//---------lotGrid---------
const lotDataSource = {
	api: {
		readData: { url: './lotStckList', method: 'POST' }
	},
	contentType: 'application/json'
};


const lotColumns = [{
	   header: '자재코드',
	   name: 'mtrCd',
	   align: 'center',
	   sortable: true,
	   hidden: true
	 },
	 {
	   header: 'Lot No',
	   name: 'mtrLot',
	   align: 'center',
	   sortable: true
	 },
	 {
	   header: '자재명',
	   name: 'mtrNm',
	   align: 'center',
	   sortable: true
	 },
	 {
	   header: '단위명',
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
	   header: '홀딩수량',
	   name: 'hldCnt',
	   align: 'right',
	   sortable: true
	 },
	 {
	   header: '현재고',
	   name: 'stckCnt',
	   align: 'right',
	   sortable: true
	 },
	 {
	   header: '사용가능수량',
	   name: 'stckUse',
	   align: 'right',
	   sortable: true
	 },
	 {
	   header: '비고',
	   name: 'cmt',
	   align: 'left',
	   sortable: true
	 }
	]
	
var lotGrid = new Grid({
     el : document.getElementById('lotTab'),
     data : lotDataSource,
     scrollX : false,
     scrollY : true,
     bodyHeight: 400,
     columns : lotColumns,
				summary : {
					height: 40,
				   	position: 'bottom',
				   	columnContent: {
				   		mtrLot: {
			                template(summary) {
			        			return '합 계';
			                } 
			            },	
			            hldCnt: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            },
			            stckCnt: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            },
			            stckUse: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            }
					}
				}
   });
//---------lotGrid 끝---------


//---------lotGrid 깨지는거 refresh---------
window.setTimeout(function(){lotGrid.refreshLayout()}, 300);
//---------lotGrid 깨지는거 refresh끝---------
   

//---------mtrGrid---------
const mtrDataSource = {
	api: {
		readData: { url: './mtrStckList', method: 'POST' }
	},
	contentType: 'application/json'
};
		
const mtrColumns = [{
					   header: '자재코드',
					   name: 'mtrCd',
					   align: 'center',
					   sortable: true
					 },
					 {
					   header: '자재명',
					   name: 'mtrNm',
					   align: 'center',
					   sortable: true
					 },
					 {
					   header: '단위명',
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
					   header: '홀딩수량',
					   name: 'hldCnt',
					   align: 'right',
					   sortable: true
					 },
					 {
					   header: '현재고',
					   name: 'mtrStckCnt',
					   align: 'right',
					   sortable: true
					 },
					 {
					   header: '사용가능수량',
					   name: 'stckUse',
					   align: 'right',
					 /*   validation: {
					        validatorFn: (value, row, columnName) => Number(value) > Number(row['safeStck'])
					   }, */
					   sortable: true
					 },
					 {
					   header: '안전재고',
					   name: 'safeStck',
					   align: 'right',
					   sortable: true
					 },
					 {
					   header: '사용구분',
					   name: 'useYn',
					   align: 'center',
					   sortable: true
					 },
					 ];
					 
var mtrGrid = new Grid({
     el : document.getElementById('mtrTab'),
     data : mtrDataSource,
     scrollX : false,
     scrollY : true,
     bodyHeight: 400,
     columns : mtrColumns,
				summary : {
					height: 40,
				   	position: 'bottom',
				   	columnContent: {
				   		mtrSectNm: {
			                template(summary) {
			        			return '합 계';
			                } 
			            },	
			            hldCnt: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            },
			            mtrStckCnt: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            },
			            stckUse: {
			                template(summary) {
			        			var sumResult = (summary.sum);
			        			return format(sumResult);
			                } 
			            },
			            safeStck: {
			                template(summary){
			        			return "MIN: "+summary.min+"<br>"+"MAX: "+summary.max;
			                } 
			            }
					}
				}
   });
//---------mtrGrid 끝---------


//---------자재코드 모달설정---------
let dialog;
dialog = $( "#dialog-form" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 500
});
//---------자재코드 모달설정 끝---------


//---------숫자데이터 구분자주는 기능---------
function format(value){
	value = value * 1;
	return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
};
//---------숫자데이터 구분자주는 기능 끝---------


//---------lotGrid 수정불가 alert---------
lotGrid.on('dblclick', function(ev) {
	toastr["error"]("변경할 수 없습니다.", "경고입니다.")
});
//---------lotGrid 수정불가 alert 끝---------


//---------mtrGrid 안전재고 근접 수량 표시---------
mtrGrid.on('onGridUpdated', function(ev) {
	for(i=0; i < mtrGrid.getRowCount()-1; i++){
		if(mtrGrid.getData()[i].stckUse*1 < mtrGrid.getData()[i].safeStck*1){
			mtrGrid.addRowClassName(i,'warning')
		}
		else if(mtrGrid.getData()[i].stckUse*1 < mtrGrid.getData()[i].safeStck*1.5){
			mtrGrid.addRowClassName(i,'caution')
		}
	}
});
//---------mtrGrid 안전재고 근접 수량 표시끝---------


//---------mtrGrid 수정불가 alert---------
mtrGrid.on('dblclick', function(ev) {
	toastr["error"]("변경할 수 없습니다.", "경고입니다.")
});
//---------mtrGrid 수정불가 alert 끝---------
   
   
//---------조회 버튼---------
btnFind.addEventListener("click", function(){
   let a= $("#frm").serializeObject();
   lotGrid.readData(1,a,true);
   mtrGrid.readData(1,a,true);
});
//---------조회 버튼 끝---------


//---------자재검색모달 row더블클릭 이벤트---------
function getModalMtr(param){
	dialog.dialog("close");
	$('#ditemCode').val(param.mtrCd);
	$('#ditemCodeNm').val(param.mtrNm);
};
//---------자재검색모달 row더블클릭 이벤트 끝---------


//---------자재검색버튼---------
btnMtrCd.addEventListener("click", function(){
	mMtr();
	$('#ui-id-1').html('자재 검색');
});
//---------자재검색버튼 끝---------


</script>
</body>
</html>