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
	//--------변수선언--------
	let checked=[];
	let prcLists=[];
	let unitLists=[];
	let value2;
	let value3;
	let mngCnt;
	let rowk;
	let Grid = tui.Grid;
	//--------변수선언 끝--------
	
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
	//--------그리드 css 끝--------

	//--------그리드컬럼 선언--------
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
	//--------그리드컬럼 선언 끝--------
	
	//--------아작스로 단위랑 공정구분 리스트담기--------
		//공정구분 상세코드에서 받아오기
		$.ajax({
			url: './prcList',
			dataType:'json',
			async : false
		}).done(function(datas){
			prcLists = datas;
		});
		
		//단위구분 상세코드에서 받아오기
		$.ajax({
			url: './unitList',
			dataType:'json',
			async : false
		}).done(function(datas){
			unitLists = datas;
		});
		
		//공정구분
		for(i=0; i<prcLists.length; i++) {
			let a = {}

			a.text = prcLists[i].prcSectNm;
			a.value = prcLists[i].prcSectNm;
			columns[4].editor.options.listItems.push(a);
		}
		
		//단위
		for(i=0; i<unitLists.length; i++) {
			let b = {}

			b.text = unitLists[i].mngUnitNm;
			b.value = unitLists[i].mngUnitNm;
			columns[2].editor.options.listItems.push(b);
		}
	//--------아작스로 단위랑 공정구분 리스트담기 끝--------
	
	//--------dataSource 선언--------
	var dataSource = {
			api: {
				readData: {
					url:'./admMngList',
					method: 'GET'},
				modifyData: { 
					url: './mngModifyData', 
					method: 'POST'}  
			},
			contentType: 'application/json'
	 };
	 //--------dataSource 선언 끝--------

	//--------그리드 그리기--------		
	let grid = new Grid({
		el: document.getElementById('grid'),
		data: dataSource, //변수명과 필드명이 같으면 생략가능 원래: data : data,
		rowHeaders : [ 'checkbox' ],
		columns,
		bodyHeight: 500,
		minBodyHeight: 500
	}); 
	//--------그리드 그리기 끝--------	
	
	//--------공정관리 그리드 기능 (grid)--------
	
		//그리드 업뎃후에 공정코드갯수세기
	 	grid.on('onGridUpdated',function() {
	 		mngCnt = grid.getRowCount();
	 	})
	 	
	 	//등록버튼
		btnAdd.addEventListener("click", function() {
			rowk = grid.getRowCount() - 1;
			if(grid.getRowCount() == 0) {
				seqVal = 1;
			} else {			
				seqVal = parseInt(grid.getValue(rowk,'seq'))+1
			}
			grid.appendRow({'prcCd':'',
							'prcNm':'',
							'mngUnitNm':'',
							'pdtDay':'',
							'prcSectNm':'',
							'cmt':'',
							'seq':seqVal,
							'useYn':'Y'},
							{focus : true});
		})	
		
		//삭제버튼
		btnDel.addEventListener("click", function() {
			grid.removeCheckedRows(true);
			grid.request('modifyData');	
		})
		
		//저장버튼
		btnSave.addEventListener("click", function() {
			grid.blur();
			rowk = grid.getRowCount();
			if(mngCnt <= rowk) {
				for(i=mngCnt; i<rowk; i++) {
					if(grid.getRow(i).prcCd == '') {
						alert("공정코드는 필수입력칸입니다!!");
						return;
					} else if(grid.getRow(i).prcNm == '') {
						alert("공정명은 필수입력칸입니다!!");
						return;
					} else if(grid.getRow(i).mngUnitNm == '') {
						alert("단위 필수입력칸입니다!!");
						return;
					} else if(grid.getRow(i).pdtDay == '') {
						alert("생산일수는 필수입력칸입니다!!");
						return;
					} else if(grid.getRow(i).prcSectNm == '') {
						alert("공정구분은 필수입력칸입니다!!");
						return;
					} else if(grid.getRow(i).seq == '') {
						alert("표시순서는 필수입력칸입니다!!");
						return;
					} else if(grid.getRow(i).useYn == '') {
						alert("사용여부는 필수입력칸입니다!!");
						return;
					}
				}
				grid.request('modifyData');
			}
		})

	
		//공정코드 수정불가알림
		grid.on('editingStart', (ev) => {
			if(ev.columnName == 'prcCd') {
				if(mngCnt > ev.rowKey) {
					alert('공정코드는 수정이 불가능합니다');
					ev.stop();
				}
			}
		})
		
		
		//수정할때 공정구분명 선택하면 공정구분코드도 히든컬럼에 들어가게 하기
		grid.on("editingFinish", ev => {
			if(ev.columnName == 'prcSectNm') {
				for(i=0; i<prcLists.length; i++) {
					if(prcLists[i].prcSectNm == grid.getValue(ev.rowKey,'prcSectNm')) {
						value2 = prcLists[i].prcSect
					}
				}
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
				grid.setValue(ev.rowKey, 'mngUnit', value3, false );
			}
		})
		
	    //그리드 readData(등록수정삭제 후에)
		grid.on("response", function(ev) {
			if(ev.xhr.response == "mngCont") {
				grid.readData();
				console.log("그리드 readData했음");
			}
		})
	
	//--------공정관리 그리드 기능 끝(grid)--------
</script>
</body>
</html>