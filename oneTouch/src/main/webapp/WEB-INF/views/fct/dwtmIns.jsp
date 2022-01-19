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
<div align="right" style="margin-right: 3%;">
			<button id="btnSel">조회</button>
			<button id="btnCle">clear</button>
			<button id="btnSave">저장</button>
			<button id="btnDel">삭제</button>
			<hr>
		</div>
<div class="flex row">
	<div class = "col-4">
		<span>
			<label style="font-size: 30px; color: mediumblue;">✔설비</label>
			<label>설비구분</label>
			<select id="fctCd" name="fctCd"></select>
		</span>
		<div id="mainGrid"></div>
		<br>
	</div>
	<div class= "col-8">
		<span>
			<label style="font-size: 30px; color: mediumblue;">✔상세코드</label>
			<label>설비코드</label>
			<input id='fctCd' name='fctCd'>
			<label>설비명</label>
			<input id='fctNm' name='fctNm'>
			<hr>
		</span>
		
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
		
		<div id="dialog-form" title="title"></div>
	</div>
</div>
<script>

	let Grid = tui.Grid;
	let data;
	let checkPrcCd = 'd';    	//검색 조건을 사용하지 않지만 검색 메소드 매개변수에 vo가 있기 때문에 쓰레기 값을 넣어준다. 
	let vo={};					//map형식으로 보내주기 위해서 초기화 
	vo.checkPrcCd=checkPrcCd;   //vo에 키 값을 정해서 밸류 값을 넣어주는 초기화 

	

	Grid.applyTheme('striped', {	
        cell: {
          header: {
            background: '#eef'
          },
          evenRow: {
            background: '#fee'
          }
          
        },
        //고정칼럼 색상 설정
        frozenBorder: {
             border: 'red'
        }
      });
	
	
//  let dataSource; //그리드에 들어갈 데이터변수
	  
		//th 영역
		const mainColumns = [
			{
				header: '설비코드',
				name: 'fctCd',
				editor: 'text'
			},
			{
				header: '설비명',
				name: 'fctNm',
				editor: 'text'
			},
			{
				header: '사용공정',
				name: 'prcCd',
				editor: 'text'
			},
			{
				header: '설비상태',
				name: 'fctPhs',
				editor: 'text'
			}
		]
		
		 $.ajax({
			  url:'list1',	//나중에 이거 대신에 컨트롤러 요청하면 됨 
			  method: 'POST',
			  data: JSON.stringify(vo),
			  contentType: "application/json",
			  async : false					//동기 = 절차적 
		  }).done(function(datas){
			  data = datas;
		  }) 
		
		
		
	 //그리드를 id 값안에다가 붙여넣어준다.
	  let mainGrid = new Grid({
	         el: document.getElementById('mainGrid'),
	         data: data,  //이름이 같다면 생격가능
	         rowHeaders : [ 'checkbox' ],
	         columns :mainColumns,
	         bodyHeight: 400,
	 		 minBodyHeight: 500
	         });
		         
		 // 설비 리스튼ajax 요청
		  
		 
		//공정 코드 조회 ajax 요청

	$.ajax({
		url:'selectFixPrc',
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