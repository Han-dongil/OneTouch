<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>불량코드관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/modal.js"></script>

<style>
hr{
	margin-top: 0.4rem !important;
}
</style>

</head>
<body>

<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">불량코드관리</h3>
				</div>
			</div>
		</div>
	</div>
	
	<h4 class="gridtitle">✔불량코드리스트</h4>
	<span class="floatright">
		<button type="button" id="btnAdd" class="btn btn-main newalign2">추가</button>
		<button type="button" id="btnDel" class="btn btn-main newalign2">삭제</button>
		<button type="button" id="btnSave" class="btn btn-primary newalign2">저장</button>
	</span>
	<br><br>
	<hr>
	<div id="grid"></div>
	<div id="dialog-form" title="title"></div>
</div>



<!-- <br>
<h3>[불량코드관리]</h3><hr>
<div align="right" style="margin-right: 3%;">
	<button type="button" id="btnAdd">추가</button>
	<button type="button" id="btnDel">삭제</button>
	<button type="button" id="btnSave">저장</button>
</div>
<h4 align="left">✔불량코드리스트</h4>
<div id="grid"></div>
<div id="dialog-form" title="title"></div> -->


<script type="text/javascript">
	//--------변수선언--------
	let rowk;
	let fltCnt;
	let Grid = tui.Grid;
	//--------변수선언 끝--------
	
	//--------그리드 css--------
	Grid.applyTheme('default',{
		cell:{
			header: {
	            background: '#4B49AC',
	            text: '#fff'
	        },
	        evenRow: {
	        	background:'#F5F7FF'
	        }
		}
	}) 
	//--------그리드 css 끝--------
	
	//--------그리드컬럼 선언--------
	const columns = [{
		header : '불량코드',
		name : 'fltCd',
		sortable : true,
		editor: 'text'
	},
	{
		header : '불량명',
		name : 'fltNm',
		editor: 'text'
	},
	{
		header : '불량내역',
		name : 'fltMtt',
		editor: 'text',
		width : 300
	},
	{
		header : '불량구분',
		name : 'fltSect',
		editor : {
			type: 'radio',
			options: {
		        listItems: [
		          { text: '자재불량', value: '자재불량' },
		          { text: '생산불량', value: '생산불량' }
		        ]
		     }
		}
	},
	{
		header : '발생공정명',
		name : 'prcNm'
	},
	{
		header : '비고',
		name : 'cmt',
		editor: 'text'
	},
	{
		header : '표시순서',
		name : 'seq',
		editor: 'text',
		sortable : true
	},
	{
		header : '발생공정코드',
		name : 'prcCd',
		hidden : true
	}]
	//--------그리드컬럼 선언 끝--------
	
	//--------dataSource 선언--------
	var dataSource = {
			api: {
				readData: {
					url:'./admFltList',
					method: 'GET'},
				modifyData: { 
					url: './fltModifyData', 
					method: 'POST'}  
			},
			contentType: 'application/json'
	 };
	 //--------dataSource 선언 끝--------

	//--------그리드 그리기--------		
	let grid = new Grid({
		el: document.getElementById('grid'),
		data: dataSource, 
		rowHeaders : [ 'checkbox' ],
		columns,
		bodyHeight: 450,
		minBodyHeight: 450
	}); 
	//--------그리드 그리기 끝--------	
	
	//--------불량코드관리 그리드 기능 (grid)--------
	
		//그리드 업뎃후에 불량코드갯수세기
	 	grid.on('onGridUpdated',function() {
	 		fltCnt = grid.getRowCount();
	 	})
	
		//등록버튼
		btnAdd.addEventListener("click", function() {
			rowk = grid.getRowCount() - 1;
			if(grid.getRowCount() == 0) {
				seqVal = 1;
			} else {			
				seqVal = parseInt(grid.getValue(rowk,'seq'))+1
			}
			grid.appendRow({'fltCd':'',
							'fltNm':'',
							'fltMtt':'',
							'fltSect':'',
							'prcNm':'',
							'cmt':'',
							'seq':seqVal},
							{focus : true});
		})	
		
		//삭제버튼
		btnDel.addEventListener("click", function() {
			grid.removeCheckedRows(true);
			grid.request('modifyData');	
		})
		
		//저장버튼----덜됨
		btnSave.addEventListener("click", function() {
			grid.blur();
			rowk = grid.getRowCount();
			if(fltCnt <= rowk) {
				for(i=fltCnt; i<rowk; i++) {
					if(grid.getRow(i).fltNm == '') {
						alert("불량명은 필수입력칸입니다!!");
						return;
					} else if(grid.getRow(i).fltMtt == '') {
						alert("불량내역은 필수입력칸입니다!!");
						return;
					} else if(grid.getRow(i).fltSect == '') {
						alert("불량구분은 필수입력칸입니다!!");
						return;
					} else if(grid.getRow(i).prcNm == '') {
						alert("발생공정명은 필수입력칸입니다!!");
						return;
					} else if(grid.getRow(i).seq == '') {
						alert("표시순서는 필수입력칸입니다!!");
						return;
					} 
				}
				grid.request('modifyData');
			}
		})
		
		//모달설정
		let dialog;
		dialog = $( "#dialog-form" ).dialog({
			autoOpen : false,
			modal : true,
			resizable: false,
			height: "auto",
			width: 700,
			height: 400
		});
		
		//불량코드 수정불가알림
		grid.on('editingStart', (ev) => {
			if(ev.columnName == 'fltCd') {
				if(fltCnt > ev.rowKey) {
					alert('불량코드는 수정이 불가능합니다');
					ev.stop();
				} else {
					alert('불량코드는 자동추가됩니다');
					ev.stop();
				}
			}
		})
		
		//불량코드 자동추가알림
		grid.on('editingStart', (ev) => {
			if(ev.columnName == 'fltCd') {
				var value = grid.getValue(ev.rowKey, 'fltCd');
					console.log(value);
				if(value == null) {
					alert('불량코드는 자동추가됩니다');
					ev.stop();
				}
			}
		})
		
		//사용공정명 더블클릭 모달띄우기
		grid.on("dblclick", (ev)=> {
			fltSectVal = grid.getValue(ev.rowKey, 'fltSect');
			if (ev.columnName === 'prcNm' && fltSectVal == '생산불량') {
				rowk = ev.rowKey;
				mPrc();
				$('#ui-id-1').html('발생공정명');
			}
			if((ev.columnName === 'prcNm' && fltSectVal == null) ||
					(ev.columnName === 'prcNm' && fltSectVal == '')) {
				alert("불량구분을 먼저 선택해주세요")
				ev.stop();
			}
		})
		
		//자재불량 선택했을때 발생공정명 컬럼에 '해당사항없음' 붙여주기----덜됨
		grid.on("editingFinish", (ev) => {
			if(ev.columnName === 'fltSect' && fltSectVal == '자재불량') {
				grid.setValue(ev.rowKey, 'prcNm', '해당사항없음', false);
			}
		})
		
		
		//사용공정명 더블클릭한 모달창 안에서 더블클릭
		function getModalPrc(param) {
			console.log("더블클릭공정");
			grid.setValue(rowk, "prcCd", param.prcCd, false);
			grid.setValue(rowk, "prcNm", param.prcNm, false);
			dialog.dialog("close");	
		}
		
		//그리드 readData(등록수정삭제 후에)
		grid.on("response", function(ev) {
			if(ev.xhr.response == "fltCont") {
				grid.readData();
				console.log("그리드 readData했음");
			}
		})

	//--------불량코드관리 그리드 기능 끝(grid)--------
</script>
</body>
</html>