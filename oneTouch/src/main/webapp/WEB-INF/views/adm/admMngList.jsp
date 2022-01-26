<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

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
					<h3 class="font-weight-bold page-title">공정관리</h3>
				</div>
			</div>
		</div>
	</div>
	
	<h4 class="gridtitle">✔공정리스트</h4>
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
<h3>[공정관리]</h3><hr>
<div align="right" style="margin-right: 3%;">
<button type="button" id="btnAdd">추가</button>
<button type="button" id="btnDel">삭제</button>
<button type="button" id="btnSave">저장</button>
</div>
<h4 align="left">✔공정리스트</h4>
<div id="grid"></div> -->

<script type="text/javascript">
	let checked=[];
	let prcLists=[];
	let unitLists=[];
	let value2;
	let value3;
	
	let Grid = tui.Grid;
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
	
	//공정구분 상세코드에서 받아오기
	$.ajax({
		url: './prcList',
		dataType:'json',
		async : false
	}).done(function(datas){
		console.log(datas);
		prcLists = datas;
	});
	
	//단위구분 상세코드에서 받아오기
	$.ajax({
		url: './unitList',
		dataType:'json',
		async : false
	}).done(function(datas){
		console.log(datas);
		unitLists = datas;
	});
	

	const columns = [{
			header : '공정코드',
			name : 'prcCd',
			editor: 'text'
		},
		{
			header : '공정명',
			name : 'prcNm',
			editor: 'text'
		},
		{
			header : '단위',
			name : 'mngUnitNm',
 			editor: {
				type: 'radio',
				options: {
					listItems: [
						
					]
				}
			} 
		},
		{
			header : '생산일수',
			name : 'pdtDay',
			editor: 'text'
		},
		{
			header : '공정구분',
			name : 'prcSectNm',
 			editor: {
				type: 'radio',
				options: {
					listItems: [
						
					]
				}
			} 
		},
		{
			header : '비고',
			name : 'cmt',
			editor: 'text'
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
			header : '공정구분코드',
			name : 'prcSect',
			hidden : true,
			
		},
		{
			header : '단위구분코드',
			name : 'mngUnit',
			hidden : true,
			
		}];
	
	for(i=0; i<prcLists.length; i++) {
		let a = {}

		a.text = prcLists[i].prcSectNm;
		a.value = prcLists[i].prcSectNm;
		columns[4].editor.options.listItems.push(a);
	}
	
	for(i=0; i<unitLists.length; i++) {
		let b = {}

		b.text = unitLists[i].mngUnitNm;
		b.value = unitLists[i].mngUnitNm;
		columns[2].editor.options.listItems.push(b);
	}
	
	

	//전체조회
	var dataSource = {
			api: {
				readData: {
					url:'./admMngList',
					method: 'GET'},
				modifyData: { 
					url: './admModifyData', 
					method: 'POST'}  
			},
			contentType: 'application/json'
	 };
	

			
	let grid = new Grid({
		el: document.getElementById('grid'),
		data: dataSource, //변수명과 필드명이 같으면 생략가능 원래: data : data,
		rowHeaders : [ 'checkbox' ],
		columns,
		bodyHeight: 500,
		minBodyHeight: 500
	}); 
		
	grid.on('editingStart', (ev) => {
		if(ev.columnName == 'prcCd') {
			var value = grid.getValue(ev.rowKey, 'prcCd');
				console.log(value);
			if(value != null) {
				alert('공정코드는 수정이 불가능합니다');
				ev.stop();
			}
		}
	})
	
	//수정할때 공정구분명 선택하면 공정구분코드도 히든컬럼에 들어가게 하기
	grid.on("editingFinish", ev => {
		if(ev.columnName == 'prcSectNm') {
			for(i=0; i<prcLists.length; i++) {
				/* console.log(prcLists[i].prcSectNm);
				console.log(grid.getValue(ev.rowKey,'prcSectNm')); */
				if(prcLists[i].prcSectNm == grid.getValue(ev.rowKey,'prcSectNm')) {
					value2 = prcLists[i].prcSect
				}
			}
			console.log(value2);
			grid.setValue(ev.rowKey, 'prcSect', value2, false );
		}
	})
	
	//수정할때 단위 선택하면 단위구분코드도 히든컬럼에 들어가게 하기
	grid.on("editingFinish", ev => {
		if(ev.columnName == 'mngUnitNm') {
			for(i=0; i<unitLists.length; i++) {
				if(unitLists[i].mngUnitNm == grid.getValue(ev.rowKey,'mngUnitNm')) {
					value3 = unitLists[i].mngUnit
				}
			}
			console.log(value3);
			grid.setValue(ev.rowKey, 'mngUnit', value3, false );
		}
	})
	
	//삭제버튼
	btnDel.addEventListener("click", function() {
		grid.removeCheckedRows(true);
	})
	
	//저장버튼
	btnSave.addEventListener("click", function() {
		grid.blur();
		grid.request('modifyData');
	})
	
	//등록버튼
	btnAdd.addEventListener("click", function() {
		grid.appendRow({});
	})	

</script>
</body>
</html>