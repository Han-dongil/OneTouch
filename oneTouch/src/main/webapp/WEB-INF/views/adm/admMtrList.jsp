<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재정보관리</title>
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
.labeltext{
	width: 80px !important;
}
.bascard1{
	height: 680px;
}
.inline{
	display: inline-block;
	margin-left: 0px !important;
	margin-top: 10px !important;
	margin-botton: 0px !important;
	margin-bottom: 0px !important;
}
.rowdiv{
	margin-bottom: 15px !important;
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
	<div class="flex row">
		<div class = "col-4">
			<h4 class="gridtitle">✔자재목록</h4>
			<br><br>
			<hr>
			<div id="grid"></div>
		</div>
		<div class= "col-8">
			<h4 class="gridtitle">✔자재상세정보</h4>
			<span class="floatright">
				<button type="button" id="btnAdd" class="btn btn-main newalign2">추가</button>
				<button type="button" id="btnDel" class="btn btn-main newalign2">삭제</button>
				<button type="button" id="btnSave" class="btn btn-primary newalign2">저장</button>
			</span>
			<br><br>
			<hr>
			<div class="card bascard">
				<div class="card-body bascard1">
					<h4 class="card-title">기초코드</h4>
					<form id="mtrFrm" name="mtrFrm" method="post">
						<div class="rowdiv">
							<label class="labeltext">자재코드&nbsp;</label>
							<input id="mtrCd" name="mtrCd" class="inputtext" readonly>
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">자재명&emsp;&nbsp;</label>
							<input id="mtrNm" name="mtrNm" class="inputtext" readonly>
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">자재규격&nbsp;</label>
							<input id="stdNm" name="stdNm" class="inputtext">
							<button type="button" id="btnStd" class="btn btn-primary mr-2 minibtn"><i class="icon-search"></i></button>
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">관리단위&nbsp;</label>
							<input id="unitNm" name="unitNm" class="inputtext">
							<button type="button" id="btnUnit" class="btn btn-primary mr-2 minibtn"><i class="icon-search"></i></button>
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">자재구분&nbsp;</label>
							<input id="mtrSectNm" name="mtrSectNm" class="inputtext">
							<button type="button" id="btnMtrSect" class="btn btn-primary mr-2 minibtn"><i class="icon-search"></i></button>
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">업체명&emsp;&nbsp;</label>
							<input id="compNm" name="compNm" class="inputtext">
							<button type="button" id="btnCompCd" class="btn btn-primary mr-2 minibtn"><i class="icon-search"></i></button>
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">관리수량&nbsp;</label>
							<input id="mngAmt" name="mngAmt" class="inputtext" readonly>
						</div>
						
						<div class="rowdiv">
							<label class="labeltext">안전재고&nbsp;</label>
							<input id="safeStck" name="safeStck" class="inputtext" readonly>
							<input type="hidden" id="std" name="std">
							<input type="hidden" id="unit" name="unit">
							<input type="hidden" id="mtrSect" name="mtrSect">
							<input type="hidden" id="compCd" name="compCd">
						</div>
						
						<div class="rowdiv">
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
	
	<div id="dialog-form" title="title"></div>
</div>


<!-- <br>
<h3>[자재정보관리]</h3>
<hr>
<div class="flex row">
	<div class = "col-4">
		<h4>✔자재목록</h4>
		<div align="right">
			<button id="btnAdd">등록</button><hr>
		</div>
		<div id="grid"></div>
		<br>
	</div>
	<div class= "col-8">
		<h4>✔자재상세정보</h4>
		<div align="right" style="margin-right: 3%;">
			<button id="btnEdit">수정</button><hr>
		</div>
			<form id="mtrFrm" name="mtrFrm" method="post">
				<label>자재코드&nbsp;</label><input id="mtrCd" name="mtrCd" readonly><br>
				<label>자재명&emsp;&nbsp;</label><input id="mtrNm" name="mtrNm" readonly><br>
				<label>자재규격&nbsp;</label><input id="stdNm" name="stdNm">
					<button type="button" id="btnStd">🔍</button><br>
				<label>관리단위&nbsp;</label><input id="unitNm" name="unitNm">
					<button type="button" id="btnUnit">🔍</button><br>
				<label>자재구분&nbsp;</label><input id="mtrSectNm" name="mtrSectNm">
					<button type="button" id="btnMtrSect">🔍</button><br>
				<label>업체명&emsp;&nbsp;</label><input id="compNm" name="compNm">
					<button type="button" id="btnCompCd">🔍</button><br>
				<label>관리수량&nbsp;</label><input id="mngAmt" name="mngAmt" readonly><br>
				<label>안전재고&nbsp;</label><input id="safeStck" name="safeStck" readonly><br>
				<input type="hidden" id="std" name="std">
				<input type="hidden" id="unit" name="unit">
				<input type="hidden" id="mtrSect" name="mtrSect">
				<input type="hidden" id="compCd" name="compCd">
				<label>사용여부&nbsp;</label><input id="useYn" name="useYn" type="checkbox" style="width: 20px;">
			</form>
			<div id="dialog-form" title="title"></div>
	</div>
</div> -->


<script type="text/javascript">
	let Grid = tui.Grid;
	
	Grid.applyTheme('default',{
		cell:{
			/* header:{
				background:'#eef'
			} */
			header: {
	            background: '#4B49AC',
	            text: '#fff'
	        }
		}
	})
	
	const columns = [{
		
			header : '자재코드',
			name : 'mtrCd',
			sortable : true //정렬
		},
		{
			header : '자재명',
			name : 'mtrNm',
			sortable : true
		}];
	
	const dataSource = {
			api: {
				readData: {
					url:'./admMtrList',
					method: 'GET'
				}
			},
			contentType: 'application/json'
		};
	
	const grid = new Grid({
		el: document.getElementById('grid'),
		data: dataSource,
		columns,
		bodyHeight: 640,
		minBodyHeight: 640
	});
	
	grid.on("click", (ev) => {
		if(ev.columnName === 'mtrCd' || ev.columnName === 'mtrNm') {
			mtrCode = {'mtrCd': grid.getValue(ev.rowKey,'mtrCd')};
			console.log(mtrCode);
			
			//자재상세정보 받아오기
			$.ajax({
				url:'./admMtrDtlList',
				dataType:'json',
				data : mtrCode,
				async : false
			}).done(function(datas) {
				MtrDtl = datas.data.contents[0];
				console.log(MtrDtl);
				document.getElementById('mtrCd').setAttribute('value',MtrDtl.mtrCd);
				document.getElementById('mtrNm').setAttribute('value',MtrDtl.mtrNm);
				document.getElementById('stdNm').setAttribute('value',MtrDtl.stdNm);
				document.getElementById('unitNm').setAttribute('value',MtrDtl.unitNm);
				document.getElementById('mtrSectNm').setAttribute('value',MtrDtl.mtrSectNm);
				document.getElementById('compNm').setAttribute('value',MtrDtl.compNm);
				document.getElementById('mngAmt').setAttribute('value',MtrDtl.mngAmt);
				document.getElementById('safeStck').setAttribute('value',MtrDtl.safeStck);
				document.getElementById('std').setAttribute('value',MtrDtl.std);
				document.getElementById('unit').setAttribute('value',MtrDtl.unit);
				document.getElementById('mtrSect').setAttribute('value',MtrDtl.mtrSect);
				document.getElementById('compCd').setAttribute('value',MtrDtl.compCd);
				//console.log($('#mtrFrm').serialize());
				
				if(MtrDtl.useYn == 'Y') {
					document.getElementById('useYn').checked = true
				} else {
					document.getElementById('useYn').checked = false
				}
			})
		}
	})
	
		//수정버튼
	btnEdit.addEventListener("click", function() {
		//console.log($('#useYn').is(':checked'));
		//console.log($('#flwFrm'));
		//console.log(document.getElementById('useYn').getAttribute('value'));
		if(!confirm("수정하시겠습니까?")){
			return false;
		}
		$.ajax({
			url: "updateMtr",
			method: "POST",
			data: $('#mtrFrm').serializeObject(),
			dataType: 'json',
			//contentType: 'application/json',
			success: function(result) {
				console.log("수정완료!!!!!!!!!!!")
				console.log(result)
			}
		})
	})
	
	//자재규격검색버튼
	btnStd.addEventListener("click", function() {
		mBas('MTR_SIZE');
		$('#ui-id-1').html('자재규격종류');
	});
	
	//관리단위검색버튼
	btnUnit.addEventListener("click", function() {
		mBas('MTR_UNIT');
		$('#ui-id-1').html('관리단위');
	});
	
	//자재구분검색버튼
	btnMtrSect.addEventListener("click", function() {
		mBas('MTR_SECT');
		$('#ui-id-1').html('자재구분');
	});
	
	//업체명검색버튼
	btnCompCd.addEventListener("click", function() {
		mBas('MTR_COM');
		$('#ui-id-1').html('업체명');
	});
	
	//모달설정
	let dialog;
	dialog = $( "#dialog-form" ).dialog({
		autoOpen : false,
		modal : true,
		resizable: false,
		height: "auto",
		width: 400
	});
	
	//모달창내에서 더블클릭
	function getModalBas(param){
		//선택한 값 parameter받아서 각자 처리
		//각각의 인풋에 값 넣어주기 위해서 if문 쓰기
		if(param.dtlCd.includes('SIZE')) {
			$("#stdNm").val(param.dtlNm);
			$("#std").val(param.dtlCd);
		} else if(param.dtlCd.includes('UNIT')) {
			$("#unitNm").val(param.dtlNm);
			$("#unit").val(param.dtlCd);
		} else if(param.dtlCd.includes('SECT')) {
			$("#mtrSectNm").val(param.dtlNm);
			$("#mtrSect").val(param.dtlCd);
		} else {
			$("#compNm").val(param.dtlNm);
			$("#compCd").val(param.dtlCd);
		}
		//console.log(param.dtlNm);
		dialog.dialog("close");
	} 

	//등록버튼
	btnAdd.addEventListener("click", function() {
		grid.appendRow({});
/* 		rowk = mainGrid.getRowCount() - 1;
		console.log(rowk);
		prdCdVal = document.getElementById("prdCd").value
		mainGrid.setValue(rowk, "prdCd", prdCdVal, false);
		console.log(mainGrid.getValue(rowk,'prdCd')); */
	})	
	
</script>
</body>
</html>