<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비동괴 관리</title>
<!-- 토스트 그리드 위에 데이트피커 가 선언되어야 작동이 된다 (순서가중요) -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
</head>
<body>
<h3>[비가동 관리]</h3>
<hr>
<div class="flex row">
	<div class = "col-4">
		<span>
			<label>✔설비</label>
			<label>공정구분</label>
			<select id="fctCd" name="fctCd"></select>
		</span>
		<div id="grid1"></div>
		<br>
	</div>
	<div class= "col-8">
		<h4>✔제품상세정보</h4>
		<div align="right" style="margin-right: 3%;">
			<button id="btnEdit">수정</button><hr>
		</div>
		<form id="flwFrm" name="flwFrm" method="post">
			<label>제품코드&nbsp;</label><input id="prdCd" name="prdCd" readonly><br>
			<label>제품명&emsp;&nbsp;</label><input id="prdNm" name="prdNm" readonly><br>
			<label>제품규격&nbsp;</label><input id="prdStdNm" name="prdStdNm">
				<button type="button" id="btnprdStd">🔍</button><br>
			<label>관리단위&nbsp;</label><input id="mngUnitNm" name="mngUnitNm">
				<button type="button" id="btnmngUnit">🔍</button><br>
			<label>제품구분&nbsp;</label><input id="prdSectNm" name="prdSectNm">
				<button type="button" id="btnprdSect">🔍</button><br>
			<input type="hidden" id="prdSect" name="prdSect">
			<input type="hidden" id="mngUnit" name="mngUnit">
			<input type="hidden" id="prdStd" name="prdStd">
			<label>사용여부&nbsp;</label><input id="useYn" name="useYn" type="checkbox" style="width: 20px;">
		</form>
		<div align="right" style="margin-right: 3%;">
		<hr>
		<button id="btnFlw" type="button">공정흐름보기</button>
		<button id="btnDel" type="button">공정흐름지우기</button>
		<button id="btnSave" type="button">저장</button>
		</div>
		<h4>✔공정흐름</h4><br>
		<div id="grid2"></div>
		<div id="dialog-form" title="title"></div>
	</div>
</div>
<script>
Grid.applyTheme('clean', {
    cell: {
      header: {
        background: '#eef'
      }
    },
    //고정칼럼 색상 설정
    frozenBorder: {
         border: 'red'
    }
  });	
	//th 영역
	const columns = [
		{
			header: '설비코드',
			name: 'fctCd',
			editor: 'text'
		},
		{
			header: '총생산량',
			name: 'totPdtAmt',
			editor: 'datePicker'
		},
		{
			header: 'uph생산량',
			name: 'uphPdtAmt',
			editor: 'datePicker'
		},
		{
			header: '사번',
			name: 'empNo',
			editor: 'datePicker'
		}
	]
	
	//공정 코드조회 ajax조회
	 $.ajax({
	    	url:'selectPrc',
	    	dataType: 'json',
	    	async : false
	    }).done(function(datas){
	    	$('#fctCd').append("<option value='d'>전체</option>")
	    	for(let data of datas){
	    		$('#fctCd').append("<option value="+data.dtlCd+">"+data.dtlNm+"</option>")
	    	}
	    }) 
</script>
</body>
</html>