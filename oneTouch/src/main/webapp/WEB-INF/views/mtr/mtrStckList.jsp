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

<link rel="stylesheet" href="${path}/resources/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="${path}/resources/jquery-ui/images">

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

/* ???????????????????????? */
.warning{background-color: orangered}
.caution{background-color: gold}
</style>
<body>

<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">????????????</h3>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 grid-margin stretch-card"><!-- <div style="margin-top: 50px; border-top: 2px solid black; border-bottom : 2px solid black; padding: 5px;">  -->
			<div class="card bascard1">
				<div class="card-body" id="mtrCard">
					<!-- <h4 class="card-title">????????????</h4> -->
					<form id="frmMtr" method="post">
						<div class="rowdiv">
							<!-- <label class="labeltext">????????????</label>
							<input type="Date" id="startDate" name="startDate" class="datepicker" readonly> 
							<label> ~ </label> 
							<input type="Date" id="endDate" name="endDate" class="datepicker" readonly> -->
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">????????????</label>
							<input type="text" id="ditemCode" name="ditemCode" class="inputtext" readonly>
							<button type="button" id="btnMtrCd" class="btn btn-primary mr-2 minibtn" ><i class="icon-search"></i></button>
							<label class="labeltext colline2">?????????</label>
							<input type="text" id="ditemCodeNm" name="ditemCodeNm" class="inputtext" readonly>
						</div>
						
						<div id="mtrRadio" style="display:inline-block">
							<label class="labeltext">????????????</label>
							<div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="allRadio">
							  		<input type="radio" class="form-check-input" id="allRadio" name="mtrSect" value="" checked>
							  		??????
									<i class="input-helper"></i>
								</label>
							</div>
							                
							<!-- <div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="lotRadio">
							  		<input type="radio" class="form-check-input" id="lotRadio" name="mtrSect" value="MTR_SECT001">
							  		?????????
									<i class="input-helper"></i>
								</label>
							</div>
							                
							<div class="form-check checkwidth" style="display:inline-block">
							    <label class="form-check-label schCondLabel" for="semiRadio">
							  		<input type="radio" class="form-check-input" id="semiRadio" name="mtrSect" value="MTR_SECT002">
							  		?????????
									<i class="input-helper"></i>
								</label>
							</div> -->
						</div>
						<div>
							<span>
								<button type="reset" id="btnLotReset" class="btn btn-primary mr-2 floatrightbtn">?????????</button>
								<button type="button" id="btnMtrFind" class="btn btn-primary mr-2 floatrightbtn">??????</button>
							</span>
						</div>
					</form>
				</div>
				<div class="card-body" id="lotCard" style="display:none">
					<!-- <h4 class="card-title">????????????</h4> -->
					<form id="frmLot" method="post">
						<div class="rowdiv">
							<label class="labeltext">????????????</label>
							<input type="text" id="startDate" name="startDate" class="datepicker jquerydtpicker"> 
							<label> ~ </label> 
							<input type="text" id="endDate" name="endDate" class="datepicker jquerydtpicker">
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">????????????</label>
							<input type="text" id="ditemCode2" name="ditemCode" class="inputtext" readonly>
							<button type="button" id="btnMtrCd2" class="btn btn-primary mr-2 minibtn" ><i class="icon-search"></i></button>
							<label class="labeltext colline2">?????????</label>
							<input type="text" id="ditemCodeNm2" name="ditemCodeNm" class="inputtext" readonly>
						</div>
						
						<div id="lotRadio" style="display:inline-block">
							<label class="labeltext">????????????</label>
							<div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="allRadio2">
							  		<input type="radio" class="form-check-input" id="allRadio2" name="mtrSect" value="" checked>
							  		??????
									<i class="input-helper"></i>
								</label>
							</div>
							<!-- <div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="lotRadio">
							  		<input type="radio" class="form-check-input" id="lotRadio" name="mtrSect" value="MTR_SECT001">
							  		?????????
									<i class="input-helper"></i>
								</label>
							</div>
							                
							<div class="form-check checkwidth" style="display:inline-block">
							    <label class="form-check-label schCondLabel" for="semiRadio">
							  		<input type="radio" class="form-check-input" id="semiRadio" name="mtrSect" value="MTR_SECT002">
							  		?????????
									<i class="input-helper"></i>
								</label>
							</div> -->
						</div>
						<div>
							<label class="labeltext">??????Lot</label>          
							<input type="checkbox" id="spent" name="spent" class="form-check-input" value="spent">
							<i class="input-helper"></i>
						</div>
						<span>
							<button type="reset" id="btnLotReset" class="btn btn-primary mr-2 floatrightbtn">?????????</button>
							<button type="button" id="btnLotFind" class="btn btn-primary mr-2 floatrightbtn">??????</button>
						</span>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div id="tabs">
		<ul style="background:white">
		  <li><a href="#mtrTab">?????????</a></li>
		  <li><a href="#lotTab">Lot???</a></li>
		  
		  <li style="top:5px; float:right;">
		  	<button id = "mtrBtn" onclick=mtr() class="btn btn-main mr-2 floatrightbtn">excel</button>
		  	<button id="lotBtn" onclick=lot() class="btn btn-main mr-2 floatrightbtn">Lotexcel</button>
		  </li>
		</ul>
		<div id="mtrTab"></div>
		<div id="lotTab"></div>
	</div>
	<div id="dialog-form">
</div>
</div>
	<!-- <div class="container">
		<h3>???????????? ??????</h3>
		<hr>
		<form id="frm" method="post">
			<div>
				<div>
					<label>????????????</label>
					<input type="Date" id="startDate" name="startDate">&nbsp;
					<label> ~ </label>&nbsp;
					<input type="Date" id="endDate" name="endDate">
				</div>
				<div>
					<label>????????????</label>
					<input type="text" id="ditemCode" name="ditemCode">
					<button type="button" id="btnMtrCd">???</button>&nbsp;
					<label>?????????</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" id="ditemCodeNm" name="ditemCodeNm" disabled="disabled">
				</div>
				<div id="mtrRadio">
					<label>????????????</label>
					<input type="radio" id="allRadio" name="mtrSect" value="" checked>
					<label for="allRadio">??????</label>
					<input type="radio" id="lotRadio" name="mtrSect" value="MTR_SECT001">
					<label for="lotRadio">?????????</label>
					<input type="radio" id="mtrRadio" name="mtrSect" value="MTR_SECT002">
					<label for="mtrRadio">?????????</label>
				</div>
			</div>
		</form>
		<hr>
	</div>
	<div align="right">
		<button type="button" id="btnFind">??????</button>
	</div>
	<div id="tabs">
		<ul>
		  <li><a href="#lotTab">Lot???</a></li>
		  <li><a href="#mtrTab">?????????</a></li>
		</ul>
		<div id="lotTab"></div>
		<div id="mtrTab"></div>
	</div>
<div id="dialog-form"></div> -->

<script type="text/javascript">
//mtr ??????
 function mtr(){
	frmMtr.action='./mtrExcelTwoView.do';
	frmMtr.submit();
	
} 
//lot ??????
function lot(){
	
	frmLot.action='./LotExcelView.do';
	frmLot.submit();
}
//---------????????? ?????? ?????? ????????? function---------
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
//---------????????? ?????? ?????? ????????? function ???---------


//---------Jquery datepicker---------
	$(function() {
    //input??? datepicker??? ??????
    $(".jquerydtpicker").datepicker({
        dateFormat: 'yy-mm-dd' //?????? ?????? ??????
        ,showOtherMonths: true //??? ????????? ???????????? ???????????? ????????? ??????
        ,showMonthAfterYear:true // ???- ??? ??????????????? ?????? - ??? ??????
        ,changeYear: true //option??? ??? ?????? ??????
        ,changeMonth: true //option???  ??? ?????? ??????                
        ,showOn: "both" //button:????????? ????????????,????????? ???????????? ?????? ?????? ^ both:????????? ????????????,????????? ???????????? input??? ???????????? ?????? ??????  
        ,buttonImage: "${path}/resources/template/images/cal_lb_sm.png" //"http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //?????? ????????? ??????
        ,buttonImageOnly: true //?????? ???????????? ???????????? ????????????
        //,buttonText: "??????" //?????? ?????? ?????????              
        ,yearSuffix: "???" //????????? ?????? ?????? ??? ?????????
        ,monthNamesShort: ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'] //????????? ??? ?????? ?????????
        ,monthNames: ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'] //????????? ??? ?????? Tooltip
        ,dayNamesMin: ['???','???','???','???','???','???','???'] //????????? ?????? ?????????
        ,dayNames: ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'] //????????? ?????? Tooltip
        ,minDate: "-5Y" //?????? ????????????(-1D:?????????, -1M:?????????, -1Y:?????????)
        ,maxDate: "+5y" //?????? ????????????(+1D:?????????, -1M:?????????, -1Y:?????????)  
    });                    
    
    //???????????? ?????? ????????? ??????????????? ?????????.
    /*     $('#startDate').datepicker('setDate', '-1W'); //(-1D:?????????, -1M:?????????, -1Y:?????????), (+1D:?????????, -1M:?????????, -1Y:?????????)     
    $('#endDate').datepicker('setDate', 'today'); //(-1D:?????????, -1M:?????????, -1Y:?????????), (+1D:?????????, -1M:?????????, -1Y:?????????)  */      
});
//---------Jquery datepicker ???---------


//---------DB??? ???????????? ???????????? radio????????? ??????---------

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
//---------DB??? ???????????? ???????????? radio????????? ?????? ???---------



//---------Jquery tabs---------
$( function() {
    $( "#tabs" ).tabs({
    	activate: function( event, ui ) {
    		if(ui.newTab[0].innerText == 'Lot???'){
    			document.getElementById('startDate').value = lastWeek();
    			document.getElementById('endDate').value = today();
    			document.getElementById('ditemCode2').value = '';
    			document.getElementById('ditemCodeNm2').value = '';
    			document.getElementById('allRadio2').checked = true;
    			
    			lotGrid.readData(1,$("#frmLot").serializeObject(),true);
    			
    			document.getElementById('mtrBtn').setAttribute("style", "display:none");//??????
    			document.getElementById('lotBtn').setAttribute("style", "display:block");//??????
    			
    			document.getElementById('lotCard').setAttribute("style","display:block");
    			document.getElementById('mtrCard').setAttribute("style","display:none");
    			lotGrid.refreshLayout();
    		} else if(ui.newTab[0].innerText == '?????????'){
    			document.getElementById('ditemCode').value = '';
    			document.getElementById('ditemCodeNm').value = '';
    			document.getElementById('allRadio').checked = true;
    			
    			lotGrid.readData(1,$("#frmMtr").serializeObject(),true);
    			document.getElementById('mtrBtn').setAttribute("style", "display:block");//??????
    			document.getElementById('lotBtn').setAttribute("style", "display:none");//??????
    			
    			document.getElementById('lotCard').setAttribute("style","display:none");
    			document.getElementById('mtrCard').setAttribute("style","display:block");
    			mtrGrid.refreshLayout();
    		}
    	}
    });
});
//---------Jquery tabs ???---------
document.getElementById('mtrBtn').setAttribute("style", "display:block");//??????
document.getElementById('lotBtn').setAttribute("style", "display:none");//??????

//---------mtrGrid---------
const mtrDataSource = {
	api: {
		readData: { url: './mtrStckList', method: 'POST' }
	},
	contentType: 'application/json'
};
		
const mtrColumns = [{
					   header: '????????????',
					   name: 'mtrCd',
					   align: 'center',
					   sortable: true
					 },
					 {
					   header: '?????????',
					   name: 'mtrNm',
					   align: 'left',
					   sortable: true
					 },
					 {
					   header: '?????????',
					   name: 'unitNm',
					   align: 'center',
					   sortable: true
					 },
					 {
					   header: '????????????',
					   name: 'mtrSectNm',
					   align: 'center',
					   sortable: true
					 },
					 {
					   header: '?????????',
					   name: 'mtrStckCnt',
					   align: 'right',
					   sortable: true
					 },
					 {
					   header: '????????????',
					   name: 'hldCnt',
					   align: 'right',
					   sortable: true
					 },
					 {
					   header: '??????????????????',
					   name: 'stckUse',
					   align: 'right',
					 /*   validation: {
					        validatorFn: (value, row, columnName) => Number(value) > Number(row['safeStck'])
					   }, */
					   sortable: true
					 },
					 {
					   header: '????????????',
					   name: 'safeStck',
					   align: 'right',
					   sortable: true
					 },
					 {
					   header: '????????????',
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
			        			return '??? ???';
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
//---------mtrGrid ???---------


//---------mtrGrid ???????????? refresh---------
window.setTimeout(function(){mtrGrid.refreshLayout()}, 300);
//---------mtrGrid ???????????? refresh???---------

   
//---------lotGrid---------
const lotDataSource = {
	api: {
		readData: { url: './lotStckList', method: 'POST' }
	},
	contentType: 'application/json'
};


const lotColumns = [{
	   header: '????????????',
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
	   header: '?????????',
	   name: 'mtrNm',
	   align: 'left',
	   sortable: true
	 },
	 {
	   header: '?????????',
	   name: 'unitNm',
	   align: 'center',
	   sortable: true
	 },
	 {
	   header: '????????????',
	   name: 'mtrSectNm',
	   align: 'center',
	   sortable: true
	 },
	 {
	   header: '?????????',
	   name: 'stckCnt',
	   align: 'right',
	   sortable: true
	 },
	 {
	   header: '????????????',
	   name: 'hldCnt',
	   align: 'right',
	   sortable: true
	 },
	 {
	   header: '??????????????????',
	   name: 'stckUse',
	   align: 'right',
	   sortable: true
	 },
	 {
	   header: '??????',
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
			        			return '??? ???';
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
//---------lotGrid ???---------


//---------???????????? ????????????---------
let dialog;
dialog = $( "#dialog-form" ).dialog({
	autoOpen : false,
	modal : true,
	resizable: false,
	height: "auto",
	width: 500
});
//---------???????????? ???????????? ???---------


//---------??????????????? ??????????????? ??????---------
function format(value){
	value = value * 1;
	return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
};
//---------??????????????? ??????????????? ?????? ???---------


//---------lotGrid ???????????? alert---------
lotGrid.on('dblclick', function(ev) {
	toastr["error"]("????????? ??? ????????????.", "???????????????.")
});
//---------lotGrid ???????????? alert ???---------


//---------mtrGrid ???????????? ?????? ?????? ??????---------
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
//---------mtrGrid ???????????? ?????? ?????? ?????????---------


//---------mtrGrid ???????????? alert---------
mtrGrid.on('dblclick', function(ev) {
	toastr["error"]("????????? ??? ????????????.", "???????????????.")
});
//---------mtrGrid ???????????? alert ???---------
   
   
//---------mtr ?????? ??????---------
btnMtrFind.addEventListener("click", function(){
   let a= $("#frmMtr").serializeObject();
   mtrGrid.readData(1,a,true);
});
//---------mtr ?????? ?????? ???---------


//---------lot ?????? ??????---------
btnLotFind.addEventListener("click", function(){
   let a= $("#frmLot").serializeObject();
   lotGrid.readData(1,a,true);
});
//---------lot ?????? ?????? ???---------


//---------?????????????????? row???????????? ?????????---------
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
//---------?????????????????? row???????????? ????????? ???---------


//---------??????????????????---------
btnMtrCd.addEventListener("click", function(){
	mMtr("mtrBtn");
	$('#ui-id-1').html('?????? ??????');
});
//---------?????????????????? ???---------


//---------??????????????????---------
btnMtrCd2.addEventListener("click", function(){
	mMtr("lotBtn");
	$('#ui-id-1').html('?????? ??????');
});
//---------?????????????????? ???---------


</script>
</body>
</html>