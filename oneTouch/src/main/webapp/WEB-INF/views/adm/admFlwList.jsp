<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품공정흐름관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/modal.js"></script>

</head>
<body>
<br>
<h3>[제품공정흐름관리]</h3>
<hr>
<div class="flex row">
<div class = "col-4">
	<h4>✔제품목록</h4>
	<div align="right">
		<button id="btnDelPrd" type="button">삭제</button><hr>
	</div>
	<div id="grid1"></div>
	<br>
</div>
<div class= "col-8">
	<h4>✔제품상세정보</h4>
	<div align="right" style="margin-right: 3%;">
		<button type="button" id="btnReset">초기화</button>
		<button type="button" id="btnAddPrd">등록</button>
		<button type="button" id="btnEditPrd">수정</button><hr>
	</div>
	<form id="flwFrm" name="flwFrm" method="post">
		<label>제품코드&nbsp;</label><input id="prdCd" name="prdCd"><br>
		<label>제품명&emsp;&nbsp;</label><input id="prdNm" name="prdNm"><br>
		<label>제품규격&nbsp;</label><input id="prdStdNm" name="prdStdNm">
			<button type="button" id="btnprdStd">🔍</button><br>
		<label>관리단위&nbsp;</label><input id="mngUnitNm" name="mngUnitNm">
			<button type="button" id="btnmngUnit">🔍</button><br>
		<label>제품구분&nbsp;</label><input id="prdSectNm" name="prdSectNm">
			<button type="button" id="btnprdSect">🔍</button><br>
		<input type="hidden" id="prdSect" name="prdSect">
		<input type="hidden" id="mngUnit" name="mngUnit">
		<input type="hidden" id="prdStd" name="prdStd">
		<label>공정라인&nbsp;</label><input id="ableLineNo" name="ableLineNo" style="width: 500px;"><br>
		<label>사용여부&nbsp;</label><input id="useYn" name="useYn" type="checkbox" style="width: 20px;">
	</form>
	<div align="right" style="margin-right: 3%;">
	<hr>
	<button id="btnFlw" type="button">조회</button>
	<button id="btnAdd" type="button">추가</button>
	<button id="btnDel" type="button">삭제</button>
	<button id="btnSave" type="button">저장</button>
	</div>
	<h4>✔공정흐름</h4><br>
	<div id="grid2"></div>
	<div id="dialog-form" title="title"></div>
</div>
</div>
<script type="text/javascript">
	//--------변수선언--------
	let prdCode1;
	let prdCode2;
	let prdCodeVal;
	let rowk;
	let PrdDtl;
	let lineSplit =[];
	let Grid = tui.Grid;
	//--------변수선언 끝--------
	
	document.getElementById('btnEditPrd').setAttribute('disabled', true);
	
	//--------그리드 css--------
	Grid.applyTheme('default',{
		cell:{
			/* header:{
				background:'#eef'
			} */
			header: {
	            background: '#4B49AC',
	            text: '#fff'
	        },
	        evenRow: {
	        	background:'#F5F7FF'
	        }
		}
	})
	//--------그리드 css--------
	
	const columns1 = [{
		
			header : '제품코드',
			name : 'prdCd',
			sortable : true, //정렬
			editor : 'text'
		},
		{
			header : '제품명',
			name : 'prdNm',
			sortable : true,
			editor : 'text'
		}];
	
	const columns2 = [{
		
		header : '공정순서',
		name : 'prcSeq',
		sortable : true,
		editor : 'text'
	},
	{
		header : '공정명',
		name : 'prcNm'
	},
	{
		header : '작업설명',
		name : 'workCmt',
		editor : 'text'
	},
	{
		header : '기준부하율',
		name : 'stdLoad',
		editor : 'text'
	},
	{
		header : '단가',
		name : 'unitCost',
		editor : 'text'
	},
	{
		header : 'LEAD타임',
		name : 'leadTime',
		editor : 'text'
	},
	{
		header : '제품코드',
		name : 'prdCd',
		hidden : true
	},
	{
		header : '공정코드',
		name : 'prcCd',
		hidden : true
	}];
	
	var dataSource1 = {
			api: {
				readData: {
					url:'./admPrdList',
					method: 'GET'
				},
				modifyData: { 
					url: './prdModifyData', 
					method: 'POST'}
			},
			contentType: 'application/json'
	};
	
	var dataSource2 = {
			api: {
				readData:{
					url:'./admFlwList',
					method:'GET',
				},
				modifyData: { 
					url: './flwModifyData', 
					method: 'POST'}
			},
			contentType: 'application/json',
			initialRequest: false
	}
	
	const grid1 = new Grid({
		el: document.getElementById('grid1'),
		data: dataSource1,
		columns: columns1,
		bodyHeight: 520,
		minBodyHeight: 520,
		rowHeaders : [ 'checkbox' ]
	});
	
	const grid2 = new Grid({
		el: document.getElementById('grid2'),
		data: dataSource2,
		columns: columns2,
		bodyHeight: 180,
		minBodyHeight: 180,
		rowHeaders : [ 'checkbox' ]
	})

	
	
	//제품명 클릭하면 제품상세정보 받아옴
	grid1.on("click", (ev) =>{
		
		if(ev.columnName === 'prdCd' || ev.columnName === 'prdNm'){	
				prdCode1 = {'prdCd':grid1.getValue(ev.rowKey,'prdCd')};
				console.log(prdCode1);
				
				//제품상세정보 받아오기
				$.ajax({
					url:'./admPrdDtlList',
					dataType:'json',
					data : prdCode1,
					async : false
				}).done(function(datas) {
					PrdDtl = datas.data.contents[0];
					console.log(PrdDtl);
					document.getElementById('prdCd').setAttribute('value',PrdDtl.prdCd);
					document.getElementById('prdNm').setAttribute('value',PrdDtl.prdNm);
					document.getElementById('prdStdNm').setAttribute('value',PrdDtl.prdStdNm);
					document.getElementById('mngUnitNm').setAttribute('value',PrdDtl.mngUnitNm);
					document.getElementById('prdSectNm').setAttribute('value',PrdDtl.prdSectNm);
					document.getElementById('prdStd').setAttribute('value',PrdDtl.prdStd);
					document.getElementById('mngUnit').setAttribute('value',PrdDtl.mngUnit);
					document.getElementById('prdSect').setAttribute('value',PrdDtl.prdSect);
					document.getElementById('ableLineNo').setAttribute('value',PrdDtl.ableLineNo);
					
					if(PrdDtl.useYn == 'Y') {
						document.getElementById('useYn').checked = true
					} else {
						document.getElementById('useYn').checked = false
					}
					
					//제품코드는 수정 안되게 막아주기
					document.getElementById('prdCd').setAttribute('readonly',true);
					document.getElementById('btnAddPrd').setAttribute('disabled', true);
					document.getElementById('btnEditPrd').disabled = undefined;	
	
					})
			
		}
	})

	/*공정흐름*/
		//공정순서 자동추가알림
		grid2.on('editingStart', (ev) => {
			if(ev.columnName == 'prcSeq') {
				var value = grid2.getValue(ev.rowKey, 'prcSeq');
					console.log(value);
				if(value == null) {
					alert('표시순서는 자동추가됩니다');
					ev.stop();
				}
			}
		})
		
		//공정순서 수정막기
		grid2.on('editingStart', (ev) => {
			if(ev.columnName == 'prcSeq') {
				var value = grid2.getValue(ev.rowKey, 'prcSeq');
				if(value != null) {
					ev.stop();
				}
			}
		})
	
			
		//조회 버튼
		btnFlw.addEventListener("click", function() {
			prdCodeVal = $('#prdCd').val();
			prdCode2 = {'prdCd' : prdCodeVal};
			console.log(prdCodeVal);
			grid2.readData(1,prdCode2,true);
		})
		
			
		//추가버튼
		btnAdd.addEventListener("click", function() {
			rowk = grid2.getRowCount() - 1;
			if(grid2.getRowCount() == 0) {
				seqVal = 1;
			} else {			
				seqVal = parseInt(grid2.getValue(rowk,'prcSeq'))+1
			}
			grid2.appendRow({'prcSeq':seqVal});
			//console.log(prdCodeVal);
			grid2.setValue(rowk, "prdCd", prdCodeVal, false);
		})	
		
		//삭제버튼
		btnDel.addEventListener("click", function(){
			grid2.removeCheckedRows(true);
		})
		
		//저장버튼
		btnSave.addEventListener("click", function() {
			grid2.blur();
			grid2.request('modifyData');
		})
	/*공정흐름끝*/
		
	//제품규격검색버튼
	btnprdStd.addEventListener("click", function() {
		mBas('PDT_SIZE');
		$('#ui-id-1').html('제품규격종류');
	})
	
	//단위검색버튼
	btnmngUnit.addEventListener("click", function() {
		mBas('MTR_UNIT');
		$('#ui-id-1').html('단위구분');
	})
	
	//제품구분검색버튼
	btnprdSect.addEventListener("click", function() {
		mBas('PDT_SECT');
		$('#ui-id-1').html('제품구분');
	})

	
	//모달설정
	let dialog;
	dialog = $( "#dialog-form" ).dialog({
		autoOpen : false,
		modal : true,
		resizable: false,
		height: "auto",
		width: 300
	});
	

	//모달창내에서 더블클릭
	function getModalBas(param){
		//선택한 값 parameter받아서 각자 처리
		//각각의 인풋에 값 넣어주기 위해서 if문 쓰기
		if(param.dtlCd.includes('PDT_SECT')) {
			console.log("1")
			$("#prdSectNm").val(param.dtlNm);
			$("#prdSect").val(param.dtlCd);
		} else if(param.dtlCd.includes('MTR')) {
			console.log("2")
			$("#mngUnitNm").val(param.dtlNm);
			$("#mngUnit").val(param.dtlCd);
		} else {
			console.log("3")
			$("#prdStdNm").val(param.dtlNm);
			$("#prdStd").val(param.dtlCd);
		}
		//console.log(param.dtlNm);
		dialog.dialog("close");
	} 

	//사용공정명 더블클릭 모달띄우기
	grid2.on("dblclick", (ev)=> {
		if (ev.columnName === 'prcNm') {
			rowk = ev.rowKey;
			mPrc();
			$('#ui-id-1').html('사용공정명');
		}
	})
	
	//사용공정명 더블클릭한 모달창 안에서 더블클릭
	function getModalPrc(param) {
		console.log("더블클릭공정");
		grid2.setValue(rowk, "prcCd", param.prcCd, false);
		grid2.setValue(rowk, "prcNm", param.prcNm, false);
		dialog.dialog("close");	
	}
	
	dialog = $( "#dialog-form" ).dialog({
		autoOpen : false,
		modal : true,
		resizable: false,
		height: "auto",
		width: 500,
		height: 400
	});
	
	
	/*제품*/
		//수정버튼
		btnEditPrd.addEventListener("click", function() {
			//console.log($('#useYn').is(':checked'));
			//console.log($('#flwFrm'));
			//console.log(document.getElementById('useYn').getAttribute('value'));
			if(!confirm("수정하시겠습니까?")){
				return false;
			}
			$.ajax({
				url: "./updatePrd",
				method: "POST",
				data: $('#flwFrm').serializeObject(),
				dataType: 'json',
				//contentType: 'application/json',
				success: function(result) {
					console.log("수정완료!!!!!!!!!!!")
					console.log(result)
				}
			})
			$('#flwFrm')[0].submit();
		})	
		
		//등록버튼
		btnAddPrd.addEventListener("click", function() {
			if(!confirm("등록하시겠습니까?")){
				return false;
			}
			$.ajax({
				url: "./insertPrd",
				method: "POST",
				data: $('#flwFrm').serializeObject(),
				dataType: 'json',
				success: function(result) {
					console.log("등록완료!!!!!!!!!!!")
					console.log(result)
				}
			})
			$('#flwFrm')[0].submit();
		})
		
		//초기화버튼
		btnReset.addEventListener("click", function() {
			if(!confirm("초기화하시겠습니까?")){
				return false;
			}
			$('#flwFrm')[0].submit();
			
		})
		
		//삭제버튼
		btnDelPrd.addEventListener("click", function() {
			grid1.removeCheckedRows(true);
			grid1.request('modifyData');
		})
	/*제품 끝*/

</script>
</body>
</html>