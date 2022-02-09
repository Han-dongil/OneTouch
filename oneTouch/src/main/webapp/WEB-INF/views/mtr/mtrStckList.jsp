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
.labeltext{
width: 100px !important;
}
.colline2{
	margin-left: 60px;
	width: 100px !important;
}
.bascard1{
	height:164px;
}
.rowdiv{
	margin-bottom: 10px !important;
}
hr{
	margin-top: -20px;
}
.checkwidth{
	width:110px;
}
.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
    border: 1px solid #3b3a88 !important;
    background: #4B49AC !important;
    font-weight: normal;
    color: #ffffff;
}

/* 안전재고수량경고 */
.warning{background-color: orangered}
.caution{background-color: gold}
</style>
<body>

<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">재고조회</h3>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 grid-margin stretch-card"><!-- <div style="margin-top: 50px; border-top: 2px solid black; border-bottom : 2px solid black; padding: 5px;">  -->
			<div class="card bascard1">
				<div class="card-body" id="mtrCard">
					<!-- <h4 class="card-title">조회조건</h4> -->
					<form id="frmMtr" method="post">
						<div class="rowdiv">
							<!-- <label class="labeltext">입고일자</label>
							<input type="Date" id="startDate" name="startDate" class="datepicker" readonly> 
							<label> ~ </label> 
							<input type="Date" id="endDate" name="endDate" class="datepicker" readonly> -->
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">자재코드</label>
							<input type="text" id="ditemCode" name="ditemCode" class="inputtext" readonly>
							<button type="button" id="btnMtrCd" class="btn btn-primary mr-2 minibtn" ><i class="icon-search"></i></button>
							<label class="labeltext colline2">자재명</label>
							<input type="text" id="ditemCodeNm" name="ditemCodeNm" class="inputtext" readonly>
						</div>
						
						<div id="mtrRadio" style="display:inline-block">
							<label class="labeltext">자재구분</label>
							<div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="allRadio">
							  		<input type="radio" class="form-check-input" id="allRadio" name="mtrSect" value="" checked>
							  		전체
									<i class="input-helper"></i>
								</label>
							</div>
							                
							<!-- <div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="lotRadio">
							  		<input type="radio" class="form-check-input" id="lotRadio" name="mtrSect" value="MTR_SECT001">
							  		원자재
									<i class="input-helper"></i>
								</label>
							</div>
							                
							<div class="form-check checkwidth" style="display:inline-block">
							    <label class="form-check-label schCondLabel" for="semiRadio">
							  		<input type="radio" class="form-check-input" id="semiRadio" name="mtrSect" value="MTR_SECT002">
							  		반제품
									<i class="input-helper"></i>
								</label>
							</div> -->
						</div>
						<div>
							<span>
								<button type="reset" id="btnLotReset" class="btn btn-primary mr-2 floatrightbtn">초기화</button>
								<button type="button" id="btnMtrFind" class="btn btn-primary mr-2 floatrightbtn">조회</button>
							</span>
						</div>
					</form>
				</div>
				<div class="card-body" id="lotCard" style="display:none">
					<!-- <h4 class="card-title">조회조건</h4> -->
					<form id="frmLot" method="post">
						<div class="rowdiv">
							<label class="labeltext">입고일자</label>
							<input type="Date" id="startDate" name="startDate" class="datepicker"> 
							<label> ~ </label> 
							<input type="Date" id="endDate" name="endDate" class="datepicker">
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">자재코드</label>
							<input type="text" id="ditemCode2" name="ditemCode" class="inputtext" readonly>
							<button type="button" id="btnMtrCd2" class="btn btn-primary mr-2 minibtn" ><i class="icon-search"></i></button>
							<label class="labeltext colline2">자재명</label>
							<input type="text" id="ditemCodeNm2" name="ditemCodeNm" class="inputtext" readonly>
						</div>
						
						<div id="lotRadio" style="display:inline-block">
							<label class="labeltext">자재구분</label>
							<div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="allRadio2">
							  		<input type="radio" class="form-check-input" id="allRadio2" name="mtrSect" value="" checked>
							  		전체
									<i class="input-helper"></i>
								</label>
							</div>
							<!-- <div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="lotRadio">
							  		<input type="radio" class="form-check-input" id="lotRadio" name="mtrSect" value="MTR_SECT001">
							  		원자재
									<i class="input-helper"></i>
								</label>
							</div>
							                
							<div class="form-check checkwidth" style="display:inline-block">
							    <label class="form-check-label schCondLabel" for="semiRadio">
							  		<input type="radio" class="form-check-input" id="semiRadio" name="mtrSect" value="MTR_SECT002">
							  		반제품
									<i class="input-helper"></i>
								</label>
							</div> -->
						</div>
						<div>
							<label class="labeltext">소진Lot</label>          
							<input type="checkbox" id="spent" name="spent" class="form-check-input" value="spent">
							<i class="input-helper"></i>
						</div>
						<span>
							<button type="reset" id="btnLotReset" class="btn btn-primary mr-2 floatrightbtn">초기화</button>
							<button type="button" id="btnLotFind" class="btn btn-primary mr-2 floatrightbtn">조회</button>
						</span>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div id="tabs">
		<ul style="background:white">
		  <li><a href="#mtrTab">자재별</a></li>
		  <li><a href="#lotTab">Lot별</a></li>
		  
		  <li style="top:5px; float:right;">
		  	<button id = "mtrBtn" onclick=mtr() class="btn btn-main mr-2 floatrightbtn">excel</button>
		  	<button id="lotBtn" onclick=lot() class="btn btn-main mr-2 floatrightbtn">excel</button>
		  </li>
		</ul>
		<div id="mtrTab"></div>
		<div id="lotTab"></div>
	</div>
	<div id="dialog-form">
</div>
</div>
	<!-- <div class="container">
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
					<input type="radio" id="lotRadio" name="mtrSect" value="MTR_SECT001">
					<label for="lotRadio">원자재</label>
					<input type="radio" id="mtrRadio" name="mtrSect" value="MTR_SECT002">
					<label for="mtrRadio">반제품</label>
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
<div id="dialog-form"></div> -->

<script type="text/javascript">
//mtr 엑셀
function mtr(){
	console.log('mtr출력')
	window.location.href='./mtrExcelTwoView.do';
}
//lot 엑셀
function lot(){
	window.location.href='./MtrExcelView.do';
}
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

/* fetch('mtrStckRadio')
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
});  */

 fetch('mtrStckRadio')
.then(response=>response.json())
.then(result=>{
	let mtrDiv = document.getElementById("mtrRadio");
	let lotDiv = document.getElementById("lotRadio");
	let mtrIndiv = mtrDiv.innerHTML;
	let lotIndiv = lotDiv.innerHTML;
	for(let i = 0; i < result.length; i++){
		mtrIndiv += ' <div class="form-check checkwidth" style="display:inline-block"> ';
		mtrIndiv += ' <label class="form-check-label schCondLabel" for="' + result[i].dtlCd + '"> ';
		mtrIndiv += ' <input type="radio" class="form-check-input" id="' + result[i].dtlCd + '" name="mtrSect" value="' + result[i].dtlCd + '"> ';
		mtrIndiv += result[i].dtlNm;
		mtrIndiv += ' <i class="input-helper"></i> '
		mtrIndiv += ' </label> '
		mtrIndiv += ' </div> '
		
		lotIndiv += ' <div class="form-check checkwidth" style="display:inline-block"> ';
		lotIndiv += ' <label class="form-check-label schCondLabel" for="' + result[i].dtlCd + '"> ';
		lotIndiv += ' <input type="radio" class="form-check-input" id="' + result[i].dtlCd + '" name="mtrSect" value="' + result[i].dtlCd + '"> ';
		lotIndiv += result[i].dtlNm;
		lotIndiv += ' <i class="input-helper"></i> '
		lotIndiv += ' </label> '
		lotIndiv += ' </div> '
	}
	mtrDiv.innerHTML = mtrIndiv;
	lotDiv.innerHTML = lotIndiv;
}); 
//---------DB의 데이터로 자재구분 radio만드는 기능 끝---------



//---------Jquery tabs---------
$( function() {
    $( "#tabs" ).tabs({
    	activate: function( event, ui ) {
    		if(ui.newTab[0].innerText == 'Lot별'){
    			document.getElementById('startDate').value = lastWeek();
    			document.getElementById('endDate').value = today();
    			document.getElementById('ditemCode2').value = '';
    			document.getElementById('ditemCodeNm2').value = '';
    			document.getElementById('allRadio2').checked = true;
    			
    			lotGrid.readData(1,$("#frmLot").serializeObject(),true);
    			
    			document.getElementById('mtrBtn').setAttribute("style", "display:none");//종현
    			document.getElementById('lotBtn').setAttribute("style", "display:block");//종현
    			
    			document.getElementById('lotCard').setAttribute("style","display:block");
    			document.getElementById('mtrCard').setAttribute("style","display:none");
    			lotGrid.refreshLayout();
    		} else if(ui.newTab[0].innerText == '자재별'){
    			document.getElementById('ditemCode').value = '';
    			document.getElementById('ditemCodeNm').value = '';
    			document.getElementById('allRadio').checked = true;
    			
    			lotGrid.readData(1,$("#frmMtr").serializeObject(),true);
    			document.getElementById('mtrBtn').setAttribute("style", "display:block");//종현
    			document.getElementById('lotBtn').setAttribute("style", "display:none");//종현
    			
    			document.getElementById('lotCard').setAttribute("style","display:none");
    			document.getElementById('mtrCard').setAttribute("style","display:block");
    			mtrGrid.refreshLayout();
    		}
    	}
    });
});
//---------Jquery tabs 끝---------
document.getElementById('mtrBtn').setAttribute("style", "display:block");//종현
document.getElementById('lotBtn').setAttribute("style", "display:none");//종현

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
					   align: 'left',
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
     bodyHeight: 369,
     minBodyHeight: 369,
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
			        			return "MIN: "+format(summary.min)+"<br>"+"MAX: "+format(summary.max);
			                } 
			            }
					}
				}
   });
//---------mtrGrid 끝---------


//---------mtrGrid 깨지는거 refresh---------
window.setTimeout(function(){mtrGrid.refreshLayout()}, 300);
//---------mtrGrid 깨지는거 refresh끝---------

   
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
	   align: 'left',
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
     bodyHeight: 369,
     minBodyHeight: 369,
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
   
   
//---------mtr 조회 버튼---------
btnMtrFind.addEventListener("click", function(){
   let a= $("#frmMtr").serializeObject();
   mtrGrid.readData(1,a,true);
});
//---------mtr 조회 버튼 끝---------


//---------lot 조회 버튼---------
btnLotFind.addEventListener("click", function(){
   let a= $("#frmLot").serializeObject();
   lotGrid.readData(1,a,true);
});
//---------lot 조회 버튼 끝---------


//---------자재검색모달 row더블클릭 이벤트---------
function getModalMtr(param,btn){
	dialog.dialog("close");
	console.log(btn)
	if( btn == "mtrBtn"){
		$('#ditemCode').val(param.mtrCd);
		$('#ditemCodeNm').val(param.mtrNm);
	} else if( btn == "lotBtn"){
		$('#ditemCode2').val(param.mtrCd);
		$('#ditemCodeNm2').val(param.mtrNm);
	}
};
//---------자재검색모달 row더블클릭 이벤트 끝---------


//---------자재검색버튼---------
btnMtrCd.addEventListener("click", function(){
	mMtr("mtrBtn");
	$('#ui-id-1').html('자재 검색');
});
//---------자재검색버튼 끝---------


//---------자재검색버튼---------
btnMtrCd2.addEventListener("click", function(){
	mMtr("lotBtn");
	$('#ui-id-1').html('자재 검색');
});
//---------자재검색버튼 끝---------


</script>
</body>
</html>