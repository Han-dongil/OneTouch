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

<script src="${path}/resources/js/modal.js"></script>

<style type="text/css">
	.tui-grid-cell-summary{
		text-align: center;
	}
</style>
</head>
<body>
	<div class="container">
		<h3>자재재고 조회</h3>
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
fetch('mtrStckRadio')
.then(response=>response.json())
.then(result=>{
	console.log("result");
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
})
//Jquery tabs
$( function() {
    $( "#tabs" ).tabs({
    	activate: function( event, ui ) {
    		if(ui.newTab[0].innerText == '자재별'){
    				mtrGrid.refreshLayout();
    		}
    	}
    });
    
  } );

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
	   header: 'Lot No',
	   name: 'mtrLot',
	   align: 'center',
	   sortable: true
	 },
	 {
	   header: '홀딩수량',
	   name: 'hldCnt',
	   align: 'center',
	   sortable: true
	 },
	 {
	   header: '현재고',
	   name: 'stckCnt',
	   align: 'center',
	   sortable: true
	 },
	 {
	   header: '비고',
	   name: 'cmt',
	   align: 'center',
	   sortable: true
	 }
	]
	
var lotGrid = new Grid({
     el : document.getElementById('lotTab'),
     data : lotDataSource,
     columns : lotColumns,
				summary : {
					height: 40,
				   	position: 'bottom',
				   	columnContent: {
				   		ordNo: {
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
			            }
					}
				}
   });
window.setTimeout(function(){lotGrid.refreshLayout()}, 100);
   
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
					   align: 'center',
					   sortable: true
					 },
					 {
					   header: '현재고',
					   name: 'mtrStckCnt',
					   align: 'center',
					   sortable: true
					 },
					 {
					   header: '안전재고',
					   name: 'safeStck',
					   align: 'center',
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
			            }
					}
				}
   });
   
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
}

lotGrid.on('response', function(ev) {
	console.log("lotev")
	console.log(ev)
      //grid.resetOriginData();
   });
mtrGrid.on('response', function(ev) {
	console.log("mtrev")
	console.log(ev)
      //grid.resetOriginData();
   });
   
btnFind.addEventListener("click", function(){
   let a= $("#frm").serializeObject();
   lotGrid.readData(1,a,true);
   mtrGrid.readData(1,a,true);
})

//자재검색모달 row더블클릭 이벤트
function getModalMtr(param){
	dialog.dialog("close");
	$('#ditemCode').val(param.mtrCd);
	$('#ditemCodeNm').val(param.mtrNm);
};

//자재검색버튼
btnMtrCd.addEventListener("click", function(){
	mMtr();
	$('#ui-id-1').html('자재 검색');
});


</script>
</body>
</html>