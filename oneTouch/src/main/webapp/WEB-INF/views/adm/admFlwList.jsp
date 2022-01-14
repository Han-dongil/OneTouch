<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정흐름관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

</head>
<body>
<br>
<h3>[제품공정흐름관리]</h3>
<hr>
<div class="flex row">
<div class = "col-4">
	<h4>✔제품목록</h4>
	<div id="grid1"></div>
	<br>
</div>
<div class= "col-8">
	<h4>✔제품정보</h4>
	<div align="right" style="margin-right: 3%;">
		<button id="btnEdit">수정</button><hr>
	</div>
	<form id="flwFrm" name="flwFrm" method="post">
		<label>제품코드&nbsp;</label><input id="prdCd" name="prdCd" value=""/>
		<label>제품명&emsp;&nbsp;</label><input id="prdNm" name="prdNm" disabled="disabled"><br>
		<label>제품규격&nbsp;</label><input id="prdStd" name="prdStd">
		<label>재고&emsp;&emsp;&nbsp;</label><input id="stck" name="stck"><br>
		<label>관리단위&nbsp;</label><input id="mngUnit" name="mngUnit">
		<label>제품구분&nbsp;</label><input id="prdSect" name="prdSect"><br>
		<label>사용여부&nbsp;</label><input id="useYn" name="useYn" type="checkbox">
	</form>
	<hr>
	<div align="right" style="margin-right: 3%;">
	<button id="btnFlw" type="button">공정흐름보기</button>
	<button id="btnDel" type="button">공정흐름지우기</button>
	<button id="btnSave" type="button">저장</button>
	</div>
	<h4>✔공정흐름</h4><br>
	<div id="grid2"></div>
</div>
</div>
<script type="text/javascript">
	let prdCode1;
	let prdCode2;
	let PrdDtl;

	let Grid = tui.Grid;
	Grid.applyTheme('striped',{
		cell:{
			header:{
				background:'#fee'
			},
			evenRow:{
				background:'#eef'
			}
		}
	})
	
	const columns1 = [{
		
			header : '제품코드',
			name : 'prdCd',
			sortable : true
		},
		{
			header : '제품명',
			name : 'prdNm'
		}];
	
	const columns2 = [{
		
		header : '공정순서',
		name : 'prcSeq',
		sortable : true
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
				}
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
		rowHeaders: ['checkbox'],
		columns: columns1,
		bodyHeight: 540,
		minBodyHeight: 540
	});
	
	const grid2 = new Grid({
		el: document.getElementById('grid2'),
		data: dataSource2,
		columns: columns2,
		bodyHeight: 272,
		minBodyHeight: 272
	})

	grid1.on("click", (ev) =>{
		if(ev.columnName === 'prdNm'){
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
				document.getElementById('prdCd').setAttribute('value',PrdDtl.prdCd);
				document.getElementById('prdNm').setAttribute('value',PrdDtl.prdNm);
				document.getElementById('prdStd').setAttribute('value',PrdDtl.prdStd);
				document.getElementById('mngUnit').setAttribute('value',PrdDtl.mngUnitNm);
				document.getElementById('prdSect').setAttribute('value',PrdDtl.prdSectNm);
				document.getElementById('stck').setAttribute('value',PrdDtl.stck);
				//$('#prdCd').val(PrdDtl.prdCd);
				//$('#prdNm').val(PrdDtl.prdNm);
				//$('#prdStd').val(PrdDtl.prdStd);
				//$('#mngUnit').val(PrdDtl.mngUnitNm);
				//$('#prdSect').val(PrdDtl.prdSectNm);
				//$('#stck').val(PrdDtl.stck);
				/* console.log(PrdDtl.useYn);
				console.log($('#prdNm').val()); */
				console.log($('#flwFrm').serialize());
				
				if(PrdDtl.useYn == 'Y') {
					document.getElementById('useYn').checked = true
				} else {
					document.getElementById('useYn').checked = false
				}
			})
		}
	})

	//공정흐름보기 버튼
	btnFlw.addEventListener("click", function() {
		prdCode2 = {'prdCd':$('#prdCd').val()};
		console.log(prdCode2);
		grid2.readData(1,prdCode2,true);
	})
	
	//공정흐름지우기 버튼
	btnDel.addEventListener("click", function(){
		/* grid2.checkAll();	
		grid2.removeCheckedRows(true); */
		cnt = grid2.getRowCount();
		for(i=0; i<cnt; i++) {
			grid2.removeRow(i);
		}
	})
	
	//저장버튼
	btnSave.addEventListener("click", function() {
		grid2.blur();
		grid2.request('modifyData');
	})
	



	
	
	//수정버튼
	btnEdit.addEventListener("click", function() {
		console.log($('#useYn').is(':checked'));
		/* if($('#useYn').is(':checked')){
			document.getElementById('useYn').setAttribute('value','Y');
		} else {
			document.getElementById('useYn').setAttribute('value','N');		}
		 */
		console.log($('#flwFrm'));
		console.log(document.getElementById('useYn').getAttribute('value'));
		
		$.ajax({
			url: "updatePrd",
			method: "POST",
			data: $('#flwFrm').serializeObject(),
			contentType: 'application/json',
			success: function(result) {
				console.log(result)
			}
		})
	})	
	
	
</script>
</body>
</html>