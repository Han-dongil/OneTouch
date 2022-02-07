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
<script src="${path}/resources/js/grid-common.js"></script>
<style>
.labeltext{
	width: 80px !important;
}
.colline2{
	margin-left: 100px;
	width: 120px !important;
}
.rowdiv{
	margin-bottom: 10px !important;
}
.inline{
	display: inline-block;
	margin-left: 0px !important;
	margin-top: 10px !important;
	margin-botton: 0px !important;
	margin-bottom: 0px !important;
}
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
					<h3 class="font-weight-bold page-title">제품BOM관리</h3>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 grid-margin stretch-card">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">제품정보</h4>
					<form id="bomFrm" name="bomFrm" method="post">
						<div class="rowdiv">
							<label class="labeltext">제품코드</label>&emsp;&nbsp;
							<input id="prdCd" name="prdCd" class="inputtext" readonly>
							<button type="button" id="btnPrdCd" class="btn btn-primary mr-2 minibtn"><i class="icon-search"></i></button>
						</div>
						<div class="rowdiv">
							<label class="labeltext">제품명</label>&emsp;&nbsp;
							<input id="prdNm" name="prdNm" class="inputtext" readonly>&emsp;&nbsp;&emsp;&nbsp;&emsp;&nbsp;
							<label class="labeltext colline2">제품규격</label>&emsp;&nbsp;
							<input id="prdStdNm" name="prdStdNm" class="inputtext" readonly>
						</div>
						<div class="rowdiv">
							<label class="labeltext">관리단위</label>&emsp;&nbsp;
							<input id="mngUnitNm" name="mngUnitNm" class="inputtext" readonly>&emsp;&nbsp;&emsp;&nbsp;&emsp;&nbsp;
							<label class="labeltext colline2">제품구분</label>&emsp;&nbsp;
							<input id="prdSectNm" name="prdSectNm" class="inputtext" readonly>
						</div>
						<div>
							<label class="labeltext">공정라인</label>&emsp;&nbsp;
							<input id="ableLineNo" name="ableLineNo" class="selectoption">&emsp;&nbsp;&emsp;&nbsp;&emsp;&nbsp;
							<label class="labeltext colline2">사용여부</label>&emsp;&nbsp;
							<span class="form-check form-check-flat form-check-primary inline">
								<label class="form-check-label chkboxalign">
									<!-- 사용여부&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
									<input id="useYn" name="useYn" type="checkbox" class="form-check-input" readonly>
								</label>
								
							</span>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<h4 class="gridtitle">✔제품소요량관리</h4>
	<span class="floatright">
		<button type="button" id="btnReset" class="btn btn-main newalign2">초기화</button>
		<button type="button" id="btnAdd" class="btn btn-main newalign2">추가</button>
		<button type="button" id="btnDel" class="btn btn-main newalign2">삭제</button>
		<button type="button" id="btnSave" class="btn btn-primary newalign2">저장</button>
	</span>
	<br><br>
	<hr>
	<div id="grid1"></div>
	<div id="dialog-form" title="title"></div>
</div>
<script>
	//--------변수선언--------
	let rowk;
	let BomCnt = 0;
	let prdCdVal;
	let modifyList = [];
	//--------변수선언 끝--------
		
	//--------제품정보 보여주는 form 기능--------
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
			//height: 550,
			width:  900
		});
		
		//제품코드 눌렀을때 나오는 모달에서 더블클릭했을때 실행되는 함수
		function getModalPrd(param) {
			document.getElementById('prdCd').value = param.prdCd;
			document.getElementById('prdNm').value = param.prdNm;
			document.getElementById('prdStdNm').value = param.prdStdNm;
			document.getElementById('mngUnitNm').value = param.mngUnitNm;
			document.getElementById('prdSectNm').value = param.prdSectNm;
			document.getElementById('ableLineNo').value = param.ableLineNo;
			if(param.useYn == 'Y') {
				document.getElementById('useYn').checked = true
			} else {
				document.getElementById('useYn').checked = false
			}
			
			/* lineSplit = param.ableLineNo.split("/")
			for(i=0;i<lineSplit.length;i++) {
				let option = document.createElement('option');
				option.value = lineSplit[i];
				option.innerHTML = lineSplit[i];
				document.getElementById('ableLineNo').appendChild(option);
			} */
			
			dialog.dialog("close");
			
			//bom보여주기
			prdCode = {'prdCd':$('#prdCd').val()};
			mainGrid.readData(1,prdCode,true);
		}		
	//--------제품정보 보여주는 form 기능 끝--------
	
	//--------그리드컬럼 선언--------
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
	//--------그리드컬럼 선언 끝--------
	
	//--------dataSource 선언--------
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
	//--------dataSource 선언 끝--------
	
	//--------그리드 그리기--------
	let mainGrid = new Grid({
		el: document.getElementById('grid1'),
		data: dataSource,
		rowHeaders : [ 'checkbox' ],
		columns,
		bodyHeight: 330,
		minBodyHeight: 330
	})
	//--------그리드 그리기 끝--------
	

	//--------제품 bom 그리드 기능 (mainGrid)--------
	
		//메인그리드 업뎃후에 bom코드갯수세기
	 	mainGrid.on('onGridUpdated',function() {
	 		BomCnt = mainGrid.getRowCount();
	 	})
	 	
		//자재명 더블클릭 모달띄우기
		mainGrid.on("dblclick", (ev)=> {
			if (ev.columnName === 'mtrNm' || 
					ev.columnName === 'mtrCd') {
				rowk = ev.rowKey;
				mMtr();
				$('#ui-id-1').html('자재');
			}
		})
		
		//자재명 더블클릭한 모달창안에서 더블클릭
		function getModalMtr(param) {
			//같은 자재 못들어가게 체크
			let flag = 0;
			for(data of mainGrid.getData()) {
				if(data.mtrCd == param.mtrCd) {
					alert("이미 등록된 자재입니다.")
					flag = 1;
				}
			}
			if(flag != 1) {
				mainGrid.setValue(rowk, "mtrCd", param.mtrCd, false);
				mainGrid.setValue(rowk, "mtrNm", param.mtrNm, false);
				dialog.dialog("close");		
			}
		}
		
		//사용공정명 더블클릭 모달띄우기
		mainGrid.on("dblclick", (ev)=> {
			if (ev.columnName === 'prcNm') {
				rowk = ev.rowKey;
				mPrc();
				$('#ui-id-1').html('사용공정명');
			}
		})
		
		//사용공정명 더블클릭한 모달창 안에서 더블클릭
		function getModalPrc(param) {
			mainGrid.setValue(rowk, "prcCd", param.prcCd, false);
			mainGrid.setValue(rowk, "prcNm", param.prcNm, false);
			dialog.dialog("close");	
		}
		
		//등록버튼
		btnAdd.addEventListener("click", function() {
			if(document.getElementById('prdCd').value != '' &&
				document.getElementById('prdCd').value != null) {
					mainGrid.appendRow({'mtrCd':'',
										'mtrNm':'',
										'useAmt':'',
										'ordChk':'',
										'pdtChk':'',
										'prcNm':'',
										'cmt':''},
										{focus : true});
					rowk = mainGrid.getRowCount() - 1;
					prdCdVal = document.getElementById("prdCd").value
					mainGrid.setValue(rowk, "prdCd", prdCdVal, false);			
			} else {
				alert('제품코드를 먼저 선택하세요');
			}
		})
		
		//삭제버튼
		btnDel.addEventListener("click", function() {
			mainGrid.removeCheckedRows(true);
			mainGrid.request("modifyData");
		})
		
		//저장버튼
		btnSave.addEventListener("click", function() {
			mainGrid.blur();
			//필수입력
			rowk = mainGrid.getRowCount();
			for(i=0; i<rowk; i++) {
				if(mainGrid.getRow(i).mtrCd == '') {
					alert("자재코드는 필수입력칸입니다!!");
					return;
				} else if(mainGrid.getRow(i).mtrNm == '') {
					alert("자재명은 필수입력칸입니다!!");
					return;
				} else if(mainGrid.getRow(i).useAmt == '') {
					alert("사용량은 필수입력칸입니다!!");
					return;
				} else if(mainGrid.getRow(i).ordChk == '') {
					alert("발주는 필수입력칸입니다!!");
					return;
				} else if(mainGrid.getRow(i).pdtChk == '') {
					alert("생산은 필수입력칸입니다!!");
					return;
				} else if(mainGrid.getRow(i).prcNm == '') {
					alert("사용공정명은 필수입력칸입니다!!");
					return;
				}
			}
			let create = mainGrid.getModifiedRows().createdRows;
			let update = mainGrid.getModifiedRows().updatedRows;
			for(let i=0; i<create.length; i++) {
				modifyList.push(create[i].mtrCd);
			}
			for(let i=0; i<update.length; i++) {
				modifyList.push(update[i].mtrCd);
			}
			mainGrid.request('modifyData');
		})
			
		//초기화버튼
		btnReset.addEventListener("click", function() {
			if(!confirm("초기화하시겠습니까?")){
				return;
			}
			formClear();
		})
		
		//초기화함수
		function formClear() {
			document.getElementById('prdCd').value = '';
			document.getElementById('prdNm').value = '';
			document.getElementById('prdStdNm').value = '';
			document.getElementById('mngUnitNm').value = '';
			document.getElementById('prdSectNm').value = '';
			document.getElementById('useYn').checked = false;
			document.getElementById('ableLineNo').value = '';
			mainGrid.clear();
		}
		
		//메인그리드 readData(등록수정삭제 후에)
		mainGrid.on("response", function(ev) {
			if(JSON.parse(ev.xhr.response).result != true) {
				console.log(JSON.parse(ev.xhr.response));
				mainGrid.resetData(JSON.parse(ev.xhr.response));
				for(mtrCdData of mainGrid.getData()) {
					if(modifyList[modifyList.length-1] == mtrCdData.mtrCd) {
						mainGrid.focus(mtrCdData.rowKey, 'mtrCd', true);
						break;
					} else {
						mainGrid.focus(mainGrid.getRowCount()-1,'mtrCd',true);
					}
				}
				console.log("메인그리드 readData했음");
			}
		})

	//--------제품 bom 그리드 기능 끝(mainGrid)--------
</script>
</body>
</html>