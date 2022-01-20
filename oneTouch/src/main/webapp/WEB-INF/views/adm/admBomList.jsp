<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOM관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/modal.js"></script>
</head>
<body>
<br>
<h3>[제품BOM관리]</h3>
<hr>
<h4>✔제품정보</h4>
<form id="bomFrm" name="bomFrm" method="post">
	<label>제품코드&nbsp;</label><input id="prdCd" name="prdCd" readonly>
	<button type="button" id="btnPrdCd">🔍</button><br>
	<label>제품명&emsp;&nbsp;</label><input id="prdNm" name="prdNm" readonly><br>
	<label>제품규격&nbsp;</label><input id="prdStdNm" name="prdStdNm" readonly><br>
	<label>관리단위&nbsp;</label><input id="mngUnitNm" name="mngUnitNm" readonly><br>
	<label>제품구분&nbsp;</label><input id="prdSectNm" name="prdSectNm" readonly><br>
	<label>공정라인&nbsp;</label><select id="ableLineNo" name="ableLineNo"></select><br>
	<label>사용여부&nbsp;</label><input id="useYn" name="useYn" type="checkbox" style="width: 20px;" readonly>
</form>
<hr>
<div align="right" style="margin-right: 3%;">
<button type="button" id="btnAdd">추가</button>
<button type="button" id="btnDel">삭제</button>
<button type="button" id="btnSave">저장</button>
</div>
<h4>✔제품소요량관리</h4>
<div id="grid1"></div>
<div id="dialog-form" title="title"></div>
<script>
	let rowk;
	let Grid = tui.Grid;
	
	Grid.applyTheme('default',{
		cell:{
			header:{
				background:'#eef'
			}
		}
	}) 
	
	
	
	//제품코드옆의 돋보기 누르면
	btnPrdCd.addEventListener("click", function() {
		mPrd();
		$('#ui-id-1').html('제품코드');
	})
	
	//모달설정
	let dialog;
	dialog = $( "#dialog-form" ).dialog({
		autoOpen : false,
		modal : true,
		resizable: false,
		height: "auto",
		width: 800
	});
	
	const columns = [{
		header: '자재코드',
		name: 'mtrCd'
	},
	{
		header: '자재명',
		name: 'mtrNm'
	},
	{
		header: '사용량',
		name: 'useAmt',
		editor: 'text'
	},
	{
		header: '발주',
		name: 'ordChk',
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
		header: '생산',
		name: 'pdtChk',
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
		header: '사용공정명',
		name: 'prcNm'
	},
	{
		header: '비고',
		name: 'cmt',
		editor: 'text'
	},
	{
		header: '사용공정코드',
		name: 'prcCd',
		hidden : true
	},
	{
		header: '제품코드',
		name: 'prdCd',
		hidden : true
	},
	{
		header: 'bom코드',
		name: 'bomCd',
		hidden : true
	}]
	
	var dataSource = {
			api: {
				readData: {
					url: './admBomList',
					method: 'GET'
				},
				modifyData: {
					url: './bomModifyData',
					method: 'POST'
				}
			},
			contentType: 'application/json',
			initialRequest: false
	}
	
	let mainGrid = new Grid({
		el: document.getElementById('grid1'),
		data: dataSource,
		rowHeaders : [ 'checkbox' ],
		columns
	})
	
	function getModalPrd(param) {
		//제품정보 보여주기
		console.log(param);
		document.getElementById('prdCd').value = param.prdCd;
		document.getElementById('prdNm').value = param.prdNm;
		document.getElementById('prdStdNm').value = param.prdStdNm;
		document.getElementById('mngUnitNm').value = param.mngUnitNm;
		document.getElementById('prdSectNm').value = param.prdSectNm;
		if(param.useYn == 'Y') {
			document.getElementById('useYn').checked = true
		} else {
			document.getElementById('useYn').checked = false
		}
		
		lineSplit = param.ableLineNo.split("/")
		for(i=0;i<lineSplit.length;i++) {
			let option = document.createElement('option');
			option.value = lineSplit[i];
			option.innerHTML = lineSplit[i];
			document.getElementById('ableLineNo').appendChild(option);
		}
		
		dialog.dialog("close");
		
		//bom보여주기
		prdCode = {'prdCd':$('#prdCd').val()};
		console.log(prdCode);
		mainGrid.readData(1,prdCode,true);
	}
	
	//자재명 더블클릭 모달띄우기
	mainGrid.on("dblclick", (ev)=> {
		console.log(ev);
		if (ev.columnName === 'mtrNm') {
			rowk = ev.rowKey;
			mMtr();
			$('#ui-id-1').html('자재');
		}
	})
	
	//자재명 더블클릭한 모달창안에서 더블클릭
	function getModalMtr(param) {
		console.log("더블클릭자재");
		mainGrid.setValue(rowk, "mtrCd", param.mtrCd, false);
		mainGrid.setValue(rowk, "mtrNm", param.mtrNm, false);
		dialog.dialog("close");	
	}
	
	//사용공정명 더블클릭 모달띄우기
	mainGrid.on("dblclick", (ev)=> {
		console.log(ev);
		if (ev.columnName === 'prcNm') {
			rowk = ev.rowKey;
			mPrc();
			$('#ui-id-1').html('사용공정명');
		}
	})
	
	//사용공정명 더블클릭한 모달창 안에서 더블클릭
	function getModalPrc(param) {
		console.log("더블클릭공정");
		mainGrid.setValue(rowk, "prcCd", param.prcCd, false);
		mainGrid.setValue(rowk, "prcNm", param.prcNm, false);
		dialog.dialog("close");	
	}
	
	//삭제버튼
	btnDel.addEventListener("click", function() {
		mainGrid.removeCheckedRows(true);
	})
	
	//저장버튼
	btnSave.addEventListener("click", function() {
		mainGrid.blur();
		mainGrid.request('modifyData');
	})
	
	//등록버튼
	btnAdd.addEventListener("click", function() {
		mainGrid.appendRow({});
		rowk = mainGrid.getRowCount() - 1;
		console.log(rowk);
		prdCdVal = document.getElementById("prdCd").value
		mainGrid.setValue(rowk, "prdCd", prdCdVal, false);
		console.log(mainGrid.getValue(rowk,'prdCd'));
	})	
</script>
</body>
</html>