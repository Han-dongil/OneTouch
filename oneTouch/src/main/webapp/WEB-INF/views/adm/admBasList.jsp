<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공통관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/modal.js"></script>
<style type="text/css">
.bascard{
	margin-bottom: 10px;
}
.bascard1{
	height: 125px;
}
.newalign{
	margin-bottom: 0rem !important;
}

</style>

</head>
<body>
<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">공통자료관리</h3>
				</div>
			</div>
		</div>
	</div>
	<div class=" flex row">
		<div class = "col-4">
			<div class="card bascard">
				<div class="card-body bascard1">
					<h4 class="card-title">기초코드</h4>
					<span style="padding-top: 10px;">
						<label class="schCondLabel">기초코드명</label>&nbsp;&nbsp;
						<input id="basNm" name="basNm" class="inputtext">
					</span>
					<span>
						<button type="button" id="btnSrc" class="btn btn-primary mr-2 floatrightbtn">조회</button>
					</span>
				</div>
			</div>
			<span class="floatright">
				<button type="button" id="btnAddBas" class="btn btn-main newalign">추가</button>
				<button type="button" id="btnDelBas" class="btn btn-main newalign">삭제</button>
				<button type="button" id="btnSaveBas" class="btn btn-primary newalign">저장</button>
			</span>
			<br><br>
			<hr>
			<div id="grid1"></div>
		</div>
		
		<div class= "col-8">
			<div class="card">
				<div class="card-body cardtitle">
					<h4 class="card-title cardtitleh4">상세코드</h4>
				</div>				
			</div>
			<br>
			<span class="floatright">
				<button type="button" id="btnAddDtl" class="btn btn-main newalign">추가</button>
				<button type="button" id="btnDelDtl" class="btn btn-main newalign">삭제</button>
				<button type="button" id="btnSaveDtl" class="btn btn-primary newalign">저장</button>
			</span>
			<br><br>
			<hr>
			<div id="grid2"></div>
			<div id="dialog-form" title="title"></div>
		</div>
	</div>	
</div>
<script type="text/javascript">
	//--------변수선언--------
	let basCodeVal;
	let basCode;
	let basName;
	let rowk;
	let chkRowKeys;
	let basDtlLength;
	let sum = 0;
	let seqVal = 0;
	let basAllCnt = 0;
	let basDtlCnt = 0;
	let Grid = tui.Grid;
	//--------변수선언 끝--------
	
	//--------그리드 css--------
 	Grid.applyTheme('default',{
		cell:{
			header:{
				background: '#4B49AC',
	            text: '#fff'
			}
		}
	})
	//--------그리드 css 끝--------
	
	//--------그리드컬럼 선언--------
	const columns1 = [{
		
			header : '기초코드',
			name : 'basCd',
			sortable : true,
			editor: 'text'
		},
		{
			header : '기초코드명',
			name : 'basNm',
			sortable : true,
			editor: 'text'
		},
		{
			header : '기초코드설명',
			name : 'basCmt',
			editor: 'text'
		}]

	const columns2 = [{
		
			header : '상세코드',
			name : 'dtlCd',
			editor : 'text'
		},
		{
			header : '상세코드명',
			name : 'dtlNm',
			editor : 'text',
			width : 180
		},
		{
			header : '코드설명란',
			name : 'dtlCmt',
			editor: 'text',
			width : 150
		},
		{
			header : '표시순서',
			name : 'seq',
			editor: 'text'
		},
		{
			header : '사용여부',
			name : 'useYn',
			editor: {
				type: 'radio',
				options: {
			        listItems: [
			          { text: 'Y', value: 'Y' },
			          { text: 'N', value: 'N' }
			        ]
			     }
			}
		},
		{
			header : '기초코드',
			name : 'basCd',
			hidden: true
		}]
 	//--------그리드컬럼 선언 끝--------
	
 	//--------dataSource 선언--------
	const dataSource1 = {
		api: {
			readData: {
				url:'./admBasList',
				method: 'GET'
			},
			modifyData: {
				url: './basAllModifyData', 
				method: 'POST'
			}
		},
		contentType: 'application/json'
	}

	const dataSource2 = {
			api: {
				readData:{
					url:'./admBasDtlList',
					method:'GET',
				},
				modifyData: { 
					url: './basDtlModifyData', 
					method: 'POST'}
			},
			contentType: 'application/json',
			initialRequest: false
	}
 	//--------dataSource 선언 끝--------
 	
	//--------그리드 그리기--------
	const grid1 = new Grid({
		el: document.getElementById('grid1'),
		data: dataSource1,
		rowHeaders : [ 'checkbox' ],
		columns: columns1,
		bodyHeight: 400,
		minBodyHeight: 400
	});
	
	const grid2 = new Grid({
		el: document.getElementById('grid2'),
		data: dataSource2,
		rowHeaders : [ 'checkbox' ],
		columns: columns2,
		bodyHeight: 460,
		minBodyHeight: 460
	})
	//--------그리드 그리기 끝--------
	
	//--------기초코드 기능 (그리드1)--------
	
		//그리드1 업뎃후에 기초코드갯수세기
	 	grid1.on('onGridUpdated',function() {
	 		basAllCnt = grid1.getRowCount();
	 	})
	 	
	 	//검색버튼
		btnSrc.addEventListener("click", function() {
			basName = {'basNm' : $('#basNm').val()};
			console.log("검색한값: "+$('#basNm').val());
			//console.log(basName);
			grid1.readData(1,basName,true);
		})
		
		//기초코드명 클릭하면 상세코드 받아옴
		grid1.on("click", (ev) => {
			if(ev.columnName === 'basCd' || ev.columnName === 'basNm' || ev.columnName === 'basCmt') {
				basCodeVal = grid1.getValue(ev.rowKey,'basCd');
				basCode = {'basCd' : basCodeVal};
				grid2.readData(1,basCode,true);
			}
		})
		
		//추가버튼
		btnAddBas.addEventListener("click", function() {
			grid1.appendRow({'basCd':'',
							 'basNm':'',
							 'basCmt':''},
							 {focus : true});
		})	
		
		//삭제버튼
		btnDelBas.addEventListener("click", function() {
			chkRowKeys = grid1.getCheckedRowKeys();
			for(i=0; i<chkRowKeys.length; i++) {
				basCodeVal = grid1.getValue(chkRowKeys[i],'basCd');
		 		$.ajax({
					url: './admBasDtlList',
					data: {'basCd':basCodeVal},
					dataType: 'json',
					async : false	
				}).done(function(datas){
					basDtlLength = datas.data.contents.length;
					sum += basDtlLength;
				})	
			}
			if(sum == 0) {
				grid1.removeCheckedRows(true);
			} else {
				alert("삭제 불가능");
			}
			sum = 0;
			grid1.request('modifyData');	
		})
		
		//저장버튼
		btnSaveBas.addEventListener("click", function() {
			grid1.blur();
			rowk = grid1.getRowCount();
			if(basAllCnt <= rowk) {
				for(i=basAllCnt; i<rowk; i++) {
					if(grid1.getRow(i).basCd == '') {
						alert("기초코드는 필수입력칸입니다!!");
						return;
					} else if(grid1.getRow(i).basNm == '') {
						alert("기초코드명은 필수입력칸입니다!!");
						return;
					}
				}
				grid1.request('modifyData');		
			}
		})
		
		//기초코드 수정불가알림
		grid1.on('editingStart', (ev) => {
			if(ev.columnName == 'basCd') {
				console.log(basAllCnt);
				console.log(ev.rowKey);
				if(basAllCnt > ev.rowKey) {
					alert('기초코드는 수정이 불가능합니다');
					ev.stop();
				}
			}
		})
		
		//그리드1 readData(등록수정삭제 후에)
		grid1.on("response", function(ev) {
			if(ev.xhr.response == "basAllCont") {
				grid1.readData();
				console.log("그리드1 readData했음");
			}
		})
		
	//--------기초코드 기능 끝(그리드1)--------	
	
	//--------상세코드 기능 (그리드2)--------	
	
		//그리드2 다 업뎃후에 기초코드갯수세기
	 	grid2.on('onGridUpdated',function() {
	 		basDtlCnt = grid2.getRowCount();
	 	})	
		
		//추가버튼
		btnAddDtl.addEventListener("click", function() {
			rowk = grid2.getRowCount();
			if(rowk == 0) {
				seqVal = 1;
			} else {			
				seqVal = parseInt(grid2.getValue(rowk-1,'seq'))+1
			}
			grid2.appendRow({'dtlCd':'',
							 'dtlNm':'',
							 'seq':seqVal,
							 'useYn':'Y'},
							 {focus : true});		
			grid2.setValue(rowk, "basCd", basCodeVal, false);
		})
		
		//삭제버튼
		btnDelDtl.addEventListener("click", function() {
			grid2.removeCheckedRows(true);
			grid2.request('modifyData');	
		})
		
		//저장버튼
		btnSaveDtl.addEventListener("click", function() {
			grid2.blur();
			rowk = grid2.getRowCount();
			if(basDtlCnt <= rowk) {
				for(i=0; i<grid2.getRowCount(); i++) {
					if(grid2.getRow(i).dtlCd == '') {
						alert("상세코드는 필수입력칸입니다!!");
						return;
					} else if(grid2.getRow(i).dtlNm == '') {
						alert("상세코드명은 필수입력칸입니다!!");
						return;
					} else if(grid2.getRow(i).seq == '') {
						alert("표시순서는 필수입력칸입니다!!");
						return;
					} else if(grid2.getRow(i).useYn == '') {
						alert("사용여부는 필수입력칸입니다!!");
						return;
					}
				}			
			}
			grid2.request('modifyData');
		})	
		
		//상세코드 수정불가알림
		grid2.on('editingStart', (ev) => {
			if(ev.columnName == 'dtlCd') {
				if(basDtlCnt > ev.rowKey) {
					alert('상세코드는 수정이 불가능합니다');
					ev.stop();
				}
			}
		})
				
		//그리드2 readData(등록수정삭제 후에)
		grid2.on("response", function(ev) {
			if(ev.xhr.response == "basDtlCont") {
				grid2.readData();
				console.log("그리드2 readData했음");
			}
		})
	
	//--------상세코드 기능 끝(그리드2)--------	
	
</script>
</body>
</html>