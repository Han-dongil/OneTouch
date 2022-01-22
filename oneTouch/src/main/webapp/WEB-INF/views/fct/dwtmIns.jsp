<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비동괴 관리</title>
<!-- 토스트 그리드 위에 데이트피커 가 선언되어야 작동이 된다 (순서가중요) -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<!-- 제어쿼리ui -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<!-- 제어쿼리ui -->
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>

<h3>[비가동 관리]</h3>
<hr>
<div align="right" style="margin-right: 3%;">
			<button id="btnSel">조회</button>
			<button id="btnCle" onclick=cleardetail()>clear</button>
			<button id="btnSave">저장</button>
			<button id="btnDel">삭제</button>
			<hr>
		</div>
<div class="flex row">
	
	<div class = "col-5">
		<form id="dwtmFctSelectFrm" method="POST">
			<span>
				<label style="font-size: 30px; color: mediumblue; margin-right: 30px">✔설비</label>
				
				<label for="fctSelectRdo">비동기 등록
					<input type="radio" id="fctSelectRdo" name="dwtmRao" checked >
				</label>
				<label for="dwtmFctSelectRdo">비동기 중인 설비
					<input type="radio" id="dwtmFctSelectRdo" name="dwtmRao">
				</label>
				<hr>
			</span>
				<label>설비구분</label>
				<select id="checkPrcCd" name="checkPrcCd" onclick=fctChekPrcCd()></select>
				<hr>
			
			
		</form>
		<div id="fctGridDiv"></div>
		<div id="dwtmFctGridDiv"></div>
		<br>
	</div>
	<div class= "col-6">
	
		<span>
			<label style="font-size: 30px; color: mediumblue;">✔상세코드</label><br>
			<label>설비코드</label>
			<input id='fctCd' name='fctCd'>
			<label>&nbsp;&nbsp;설비명</label>
			<input id='fctNm' name='fctNm'>
			<hr>
		</span>
		
		<form id="flwFrm" name="flwFrm" method="post">
			<label>비가동<br>이력번호&nbsp;</label><input style="width: 172px;" id="dwtmCd" name="dwtmCd" disabled><br>
			<hr>
			
				<label style="margin-right: 10px;">입력일자</label>
				<input style="margin-right: 20px" type="date" id="dwtmDate" name="dwtmDate"><br>
				<label style="margin-right: 26px;">작업자</label>
				<input style="width: 172px;" type="text" id="empNo" name="empNo">
				<button type="button" id="btndwtmEmp"  style="background:#72BE44" width:50px;>🔍</button><br>
				<hr>
			
			<div>
				<label>비가동시간</label><br>
			</div>
			<span>
				<input style="width: 45px;" id="dwtmStartTime" name="dwtmStartTime">
				<label style="margin-right:10px;">시</label>
				<input style="width: 45px;" id="dwtmStartMinute" name="dwtmStartMinute">
				<label style="margin-right:20px;">분</label>
				<button type="button" id="clickStartBtn" onclick=startTiem() style="background: #72BE44;  width: 100px;  height: 100px; font-size:42px;margin-right:10px;">시작</button>	
				<input type="hidden" id="strDt" name="strDt">			
				
				<input style="width: 45px;" id="dwtmEndTime" name="dwtmEndTime">
				<label style="margin-right:10px;">시</label>
				<input style="width: 45px;" id="dwtmEndMinute" name="dwtmEndMinute">
				<label style="margin-right:10px;">분</label>
				<button type="button" id="clickEndBtn" onclick=endTime() style="background: red; width: 100px;  height: 100px; font-size:42px;">종료</button><br>
				<input type="hidden" id="finDt" name="finDt">	
			</span>
			<hr>
			<label >비가동사유</label>
			<select style="width: 100px;" id="dwtmSelectBtn" name="dwtmSelectBtn" >
				<option value="점검">점검</option>
				<option value="수리">수리</option>
				<option value="대기">대기</option>
			</select>
			<hr>
			<label>작업내용</label>
			<input type="textarea" id="msrCmt" name="msrCmt" style="width:360px; height:100px;">
		</form>
		
	
	</div>
</div>
<script>

	let Grid = tui.Grid;
	let data;	
	let dwtmData;
	let checkPrcCd = 'd';    	//검색 조건을 사용하지 않지만 검색 메소드 매개변수에 vo가 있기 때문에 쓰레기 값을 넣어준다. 
	let vo={};					//map형식으로 보내주기 위해서 초기화 ;
	let fctCheckData;
	let dwtmCheckData;
	let DwtmVO; 
	let rdostatus =1; //비동기 등록, 비동기 중인 설비 라이도 버튼 값 

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
		const fctColumns = [
			{
				header: '설비코드',
				name: 'fctCd',
				editor: 'text',
				width:140
			},
			{
				header: '설비명',
				name: 'fctNm',
				editor: 'text',
				width:100
			},
			{
				header: '사용공정',
				name: 'prcCd',
				editor: 'text',
				width:60
			},
			{
				header: '공정이름',
				name: 'prcNm',
				editor: 'text',
				width:100
			},
			{
				header: '설비상태',
				name: 'fctPhs',
				editor: 'text',
				width:50
			}
		]
		
		
		
	 //그리드를 id 값안에다가 붙여넣어준다.
	  let fctGrid = new Grid({
	         el: document.getElementById('fctGridDiv'),
	         data: data,  //이름이 같다면 생격가능
	         rowHeaders : [ 'checkbox' ],
	         columns :fctColumns,
	         bodyHeight: 600,
	 		 minBodyHeight: 600,
	 		columnOptions: {
	 			 minWidth:50
	 			 }
	         });
		         
		//th 영역
		const dwtmColumns = [
			{
				header: '비동기이력',
				name: 'dwtmCd',
				editor: 'text',
				width:140
			},
			{
				header: '설비명',
				name: 'fctNm',
				editor: 'text',
				width:100
			},
			{
				header: '시작',
				name: 'strDt',
				editor: 'text',
				width:60
			},
			{
				header: '종료',
				name: 'finDt',
				editor: 'text',
				width:100
			},
			{
				header: '비동기 상태',
				name: 'msrMtt',
				editor: 'text',
				width:50
			}
		]
		
	 //그리드를 id 값안에다가 붙여넣어준다.
	  let dwtmGrid = new Grid({
	         el: document.getElementById('dwtmFctGridDiv'),
	         data: dwtmCheckData,  //이름이 같다면 생격가능
	         rowHeaders : [ 'checkbox' ],
	         columns :dwtmColumns,
	         bodyHeight: 600,
	 		 minBodyHeight: 600,
	 		columnOptions: {
	 			 minWidth:50
	 			 }
	         });
		 // 설비 리스튼ajax 요청
		  
		 
	//공정 코드 조회 ajax 요청 select 부분에 담아서 보여주기 
	$.ajax({
		url:'admMngList',
		dataType: 'json',
		async : false
	}).done(function(datas){
		let list = datas.data.contents;
		console.log(list)
		$('#checkPrcCd').append("<option value='d'>전체</option>")
		  for(let contentss of list){
			$('#checkPrcCd').append("<option value="+contentss.prcCd+">"+contentss.prcNm+"</option>")
		}  
	}) 
	
	//fct그리드 클릭 이벤트
	fctGrid.on('click', (ev) =>{
		
		fctCheckData = data[ev.rowKey];
		console.log(fctCheckData.fctNm);
		
		document.getElementById('fctCd').value = fctCheckData.fctCd;
		document.getElementById('fctNm').value =fctCheckData.fctNm;
	})
	
	dwtmGrid.on('click',(ev)=>{
		console.log(ev)
		dwtmCheckData = dwtmData[ev.rowKey]	
		console.log(dwtmCheckData)
		console.log(dwtmCheckData.dwtmCd)
		document.getElementById('fctCd').value = dwtmCheckData.fctCd;
		document.getElementById('fctNm').value = dwtmCheckData.fctNm;
		document.getElementById('dwtmCd').value = dwtmCheckData.dwtmCd;
		document.getElementById('empNo').value = dwtmCheckData.empNo;
		document.getElementById('dwtmSelectBtn').value = dwtmCheckData.msrMtt;
		document.getElementById('msrCmt').value = dwtmCheckData.msrCmt;
		document.getElementById('dwtmStartTime').value = dwtmCheckData.dwtmStartTime;
		document.getElementById('dwtmStartMinute').value = dwtmCheckData.dwtmStartMinute;
		document.getElementById('dwtmEndTime').value = dwtmCheckData.dwtmEndTime;
		document.getElementById('dwtmEndMinute').value = dwtmCheckData.dwtmEndMinute;
		
		//아작스로 값 담아서 ev로 rowKey걸어주기 
	})
	//refreshLayout();
	 //라디오 클릭하면 값 가져오기 
  	$("input[name='dwtmRao']:radio").change(function (e) {
  		if(e.target.id == 'fctSelectRdo'){
  			rdostatus = 1;
  			console.log('비가동 그리드 숨기기')
  			document.getElementById("dwtmFctGridDiv").style = 'display:none';
  			document.getElementById("fctGridDiv").style = 'display:block';
	  		console.log("설비 그리드에 뿌리기 ")
	  		fctChekPrcCd();	//페이지 접속후 기본으로 설비를 보여주는 그리드 출력하는 함수
	  		fctGrid.refreshLayout();
	  		
	  		document.getElementById('fctCd').disabled = false;
  			document.getElementById('fctNm').disabled = false;
  			document.getElementById('dwtmDate').disabled = false;
  			document.getElementById('empNo').disabled = false;
  			document.getElementById('dwtmStartTime').disabled = false;
  			document.getElementById('dwtmStartMinute').disabled = false;
  			document.getElementById('dwtmEndTime').disabled = false;
  			document.getElementById('dwtmEndMinute').disabled = false;
	  		
	  		
  		}
  		else{
  			rdostatus = 0;
  			console.log('232')
  			document.getElementById("dwtmFctGridDiv").style.display = 'block';
  			document.getElementById("fctGridDiv").style.display = 'none';
  			dwtmselect();	//비가동 조회
  			dwtmGrid.refreshLayout();
  			
  			document.getElementById('fctCd').disabled = true;
  			document.getElementById('fctNm').disabled = true;
  			document.getElementById('dwtmDate').disabled = true;
  			document.getElementById('empNo').disabled = true;
  			document.getElementById('dwtmStartTime').disabled = true;
  			document.getElementById('dwtmStartMinute').disabled = true;
  			document.getElementById('dwtmEndTime').disabled = true;
  			document.getElementById('dwtmEndMinute').disabled = true;
  		}
  		
  	});
	
  		
  		
  //select 버튼 누르면 조건에 맞게 조회하기
	function chageLangSelect(event){
		let langSelect = document.getElementById("prcCd")
		console.log('셀렉트 이벤트 발생')
		console.log(event.target)
	}
  
  	//비동기 테이블 조회 
  	function dwtmselect(){
  		
  		dwtmCheckData = $("#dwtmFctSelectFrm").serializeObject();
  		console.log('7777777777777777777777777777777777777777777777')
  		console.log(dwtmCheckData)
			$.ajax({
				url:'dwtmSelectAll',
				method:'POST',
				data: JSON.stringify(dwtmCheckData),
				contentType:"application/json"
			}).done(function(datas){
				console.log(datas)
				dwtmData = datas;	
				dwtmGrid.resetData(datas)
				
			}) 
			
  	}
  	
  	
	//설비구분을 SELECT로 선택해서 조회하기 
	function fctChekPrcCd(){
		console.log(rdostatus)
		if(rdostatus == 1){
			console.log('111111설비 테이플 ')
			
			fctCheckData = $("#dwtmFctSelectFrm").serializeObject();
			 $.ajax({
				  url:'list1',	//나중에 이거 대신에 컨트롤러 요청하면 됨 
				  method: 'POST',
				  data: JSON.stringify(fctCheckData),
				  contentType: "application/json",
				  async : false					//동기 = 절차적 
			  }).done(function(datas){
				  fctGrid.resetData(datas);		//fct그리드에 데이터를 넣어준다.
				  data = datas;
				  console.log(data)
			  }) 
		}
		else{
			dwtmCheckData = $("#dwtmFctSelectFrm").serializeObject();
	  		console.log('7777777777777777777777777777777777777777777777')
	  		console.log(dwtmCheckData)
				$.ajax({
					url:'dwtmSelectAll',
					method:'POST',
					data: JSON.stringify(dwtmCheckData),
					contentType:"application/json"
				}).done(function(datas){
					console.log(datas)
					dwtmData = datas;	
					dwtmGrid.resetData(datas)
					
				}) 
		}
		
	
	}	
  		
  		
	//상세보기 input 클리어
	function cleardetail(){
			 console.log('clear')
			 document.getElementById('fctCd').value='';
			 document.getElementById('fctNm').value='';
			 document.getElementById('dwtmCd').value='';
			 document.getElementById('empNo').value='';
			 document.getElementById('startDwtmTimeHours').value='';
			 document.getElementById('startDwtmTimeMinutes').value='';
			 document.getElementById('endDwtmTimeHours').value='';
			 document.getElementById('endDwtmTimeMinutes').value='';
			 document.getElementById('dwtmSelectBtn').value='';
			 document.getElementById('msrCmt').value='';
		 }
	//종료 버튼 현재시간 구하는 함수
	function endTime(){
			 let today = new Date();
			 let hours = today.getHours();		//시
			 let minutes = today.getMinutes();	//분
			 console.log(hours)
			 console.log(minutes)
			 
			 document.getElementById('endDwtmTimeHours').value = hours;
			 document.getElementById('endDwtmTimeMinutes').value = minutes;
			 document.getElementById('finDt').value = today;
		 }
	//시작 버튼 현재시간 구하는 함수 
	function startTiem(){
			 let today = new Date();
			 let hours = today.getHours();		//시
			 let minutes = today.getMinutes();	//분
			 console.log(hours)
			 console.log(minutes)
			 
			 document.getElementById('startDwtmTimeHours').value = hours;
			 document.getElementById('startDwtmTimeMinutes').value = minutes;
			 document.getElementById('strDt').value = today;
		 }
		 
	
	fctChekPrcCd();	//페이지 접속후 기본으로 설비를 보여주는 그리드 출력하는 함수
</script>
</body>
</html>