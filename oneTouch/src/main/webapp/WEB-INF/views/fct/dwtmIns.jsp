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
<script src="${path}/resources/js/function.js"></script>

<link rel="stylesheet" href="${path}/resources/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="${path}/resources/jquery-ui/images">

<style type="text/css">
.red{
		background-color:red
		
	}
.green{
		background-color:#7DA0FA
		
	  }
.blue{
		background-color:#F3797E 
		
}
.labeltext1{
	width: 100px !important;
}
.inputsize{
	width: 45px;
}
.rowdiv{
	margin-bottom: 10px !important;
}
.colline1{
	margin-left: 20px;
	width: 90px !important;
}
.colline2{
	margin-left: 40px;
	width: 90px !important;
}
.colline3{
	width: 30px;
}
.bascard1{
	height: 120px;
}
.bascard2{
	height: 667px;
}
.kioskBtn1{
	margin: 70px 40px 40px 20px;	
	width: 170px;
	height: 170px;
	font-size: 3rem;
}
.btn-sub {
	color: #fff;
	background-color: #7DA0FA;
	border-color: #7DA0FA;
}
.addmiargin{
	margin-left: 20px;
}
</style>

</head>
<body>

<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">비가동관리</h3>
				</div>
			</div>
		</div>
	</div>

	<div class="flex row">
		<div class = "col-5">
			<h4 class="gridtitle">✔설비상태</h4>
			<br>
			<hr>
			<div class="row row1">
				<div class="col-md-12 grid-margin stretch-card">
					<div class="card bascard1">
						<div class="card-body bascard1">
						
							<label class="labeltext labeltext1">자재구분</label>
							<div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="fctSelectRdo">
							  		<input type="radio" class="form-check-input" id="fctSelectRdo" name="dwtmRao" value="" checked>
							  		동기
									<i class="input-helper"></i>
								</label>
							</div>
							                
							<div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="proceedingDwtm">
							  		<input type="radio" class="form-check-input" id="proceedingDwtm" name="dwtmRao">
							  		비동기
									<i class="input-helper"></i>
								</label>
							</div>
							                
							<div class="form-check checkwidth" style="display:inline-block">
							    <label class="form-check-label schCondLabel" for="dwtmFctSelectRdo">
							  		<input type="radio" class="form-check-input" id="dwtmFctSelectRdo" name="dwtmRao">
							  		비동기이력
									<i class="input-helper"></i>
								</label>
							</div>
							
							<div class="rowdiv">
								<label class="labeltext labeltext1">설비구분&nbsp;</label>
								<select id="checkPrcCd" name="checkPrcCd" class="inputtext" onclick=fctChekPrcCd()></select>
							</div>
						
						</div>
					</div>
				</div>
			</div>
			
			<div id="fctGridDiv"></div>
			<div id="dwtmFctGridDiv"></div>
			
		</div>
		
		<div class = "col-7">
			<h4 class="gridtitle">✔비가동등록</h4>
			<span class="floatright">
				<button type="button" id='btnCle' onclick=cleardetail()  class="btn btn-main btn1 newalign2">초기화</button>
				<button type="button" id='btnDel' onclick=dwtmSave() class="btn btn-main btn1 newalign2">삭제</button>
				<button type="button" id='btnSave' onclick=dwtmDelete() class="btn btn-primary btn1 newalign2">저장</button>
			</span>
			<br>
			<hr>
			<div class="row row1">
				<div class="col-md-12 grid-margin stretch-card">
					<div class="card bascard2">
						<div class="card-body bascard2">
							<form id="flwFrm" name="flwFrm" method="post">
								<div class="rowdiv">
									<label class="labeltext colline1">설비코드</label>
									<input type="text" id="fctCd" name="fctCd" class="inputtext" readonly>
									<button type="button" id="btnMtrCd" class="btn btn-primary mr-2 minibtn" ><i class="icon-search"></i></button>
									<label class="labeltext colline2">설비명</label>
									<input type="text" id="fctNm" name="fctNm" class="inputtext" readonly>
								</div>
								
								<div class="rowdiv">
									<label class="labeltext colline1">비가동코드</label>
									<input type="text" id="dwtmCd" name="dwtmCd" class="inputtext" readonly>
								</div>
								
								<div class="rowdiv">
									<label class="labeltext colline1">입력일자</label>
									<input type="text" name="dwtmDate" id="dwtmDate" class="datepicker jquerydtpicker"/>
								</div>
								
								<div class="rowdiv">
									<label class="labeltext colline1">작업자</label>
									<input type="text" id="empNo" name="empNo" class="inputtext">
									<button type="button" id="btndwtmEmp" class="btn btn-primary mr-2 minibtn" ><i class="icon-search"></i></button>
								</div>
								
								<div class="rowdiv blockdiv">
									<span>
										<input id="dwtmStartTime" name="dwtmStartTime" class="inputtext inputsize addmiargin">
										<label class="labeltext colline3">시</label>
										<input id="dwtmStartMinute" name="dwtmStartMinute" class="inputtext inputsize">
										<label class="labeltext colline3">분</label>
										<button type="button" id="clickStartBtn" onclick=startTime() class="btn btn-sub kioskBtn1">시작</button>	
										<input type="hidden" id="strDt" name="strDt">			
										
										<input id="dwtmEndTime" name="dwtmEndTime" class="inputtext inputsize">
										<label class="labeltext colline3">시</label>
										<input id="dwtmEndMinute" name="dwtmEndMinute" class="inputtext inputsize">
										<label class="labeltext colline3">분</label>
										<button type="button" id="clickEndBtn" onclick=endTime() class="btn btn-important kioskBtn1">종료</button><br>
										<input type="hidden" id="finDt" name="finDt">	
									</span>
								</div>
								
								<div class="rowdiv">
									<label class="labeltext colline1">비가동사유</label>
									<select id="msrMtt" name="msrMtt" class="inputtext inputsize1">
										<option value="점검">점검</option>
										<option value="수리">수리</option>
										<option value="대기">대기</option>
									</select>
									
								</div>
								
								<div class="rowdiv">
									<label class="labeltext colline1">작업내용</label>
									<input type="textarea" id="msrCmt" name="msrCmt" class="inputtext" style="width:360px; height:100px;">
								</div>
								
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>



<!-- <h3>[비가동 관리]</h3>
<hr>
<div align="right" style="margin-right: 3%;">
			<button id="btnCle" onclick=cleardetail()>clear</button>
			<button id="btnSave" onclick=dwtmSave()>저장</button>
			<button id="btnDel" onclick=dwtmDelete()>삭제</button>
			<hr>
		</div>
<div class="flex row">
	
	<div class = "col-6">
		<form id="dwtmFctSelectFrm" method="POST">
			<span>
				<label style="font-size: 30px; color: mediumblue; margin-right: 30px">✔설비</label>
				
				<label for="fctSelectRdo">비동기 등록
					<input type="radio" id="fctSelectRdo" name="dwtmRao" checked >
				</label>
				<label for="proceedingDwtm">비동기 중인 설비
					<input type="radio" id="proceedingDwtm" name="dwtmRao">
				</label>
				<label for="dwtmFctSelectRdo">비동기 이력
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
		<form id="flwFrm" name="flwFrm" method="post">
			<span>
				<label style="font-size: 30px; color: mediumblue;">✔상세코드</label><br>
				<label>설비코드</label>
				<input id='fctCd' name='fctCd'>
				<label>&nbsp;&nbsp;설비명</label>
				<input id='fctNm' name='fctNm'>
				<hr>
			</span>
			<label>비가동<br>이력번호&nbsp;</label><input style="width: 172px;" id="dwtmCd" name="dwtmCd" readonly><br>
			<hr>
			
				<label style="margin-right: 10px;">입력일자</label>
				<input style="margin-right: 20px" type="date" id="dwtmDate" name="dwtmDate">
				<input style="margin-right: 20px" type="hidden" id="hiddenDwtmDate" name="hiddenDwtmDate"><br>
				<label style="margin-right: 26px;">작업자</label>
				<input style="width: 172px;" type="text" id="empNo" name="empNo">
				<button type="button" id="btndwtmEmp"  style= width:50px;>🔍</button><br>
				<hr>
			
			<div>
				<label>비가동시간</label><br>
			</div>
			<span>
				<input style="width: 45px;" id="dwtmStartTime" name="dwtmStartTime">
				<label style="margin-right:10px;">시</label>
				<input style="width: 45px;" id="dwtmStartMinute" name="dwtmStartMinute">
				<label style="margin-right:20px;">분</label>
				<button type="button"  class="btn btn-sub kioskBtn1" id="clickStartBtn" onclick=startTime() >시작</button>	
				<input type="hidden" id="strDt" name="strDt">			
				
				<input style="width: 45px;" id="dwtmEndTime" name="dwtmEndTime">
				<label style="margin-right:10px;">시</label>
				<input style="width: 45px;" id="dwtmEndMinute" name="dwtmEndMinute">
				<label style="margin-right:10px;">분</label>
				<button type="button" id="clickEndBtn" onclick=endTime() class="btn btn-important kioskBtn1">종료</button><br>
				<input type="hidden" id="finDt" name="finDt">	
			</span>
			<hr>
			<label >비가동사유</label>
			<select style="width: 100px;" id="msrMtt" name="msrMtt" >
				<option value="점검">점검</option>
				<option value="수리">수리</option>
				<option value="대기">대기</option>
			</select>
			<hr>
			<label>작업내용</label>
			<input type="textarea" id="msrCmt" name="msrCmt" style="width:360px; height:100px;">
		</form>
		
	
	</div>
</div> -->

<script>

$(function() {
    //input을 datepicker로 선언
    $("#datepicker").datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
        ,changeYear: true //option값 년 선택 가능
        ,changeMonth: true //option값  월 선택 가능                
        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
        ,buttonImage: "/oneTouch/resources/template/images/cal_w_sm.png" //"http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
        ,buttonImageOnly: false //버튼 이미지만 깔끔하게 보이게함
        //,buttonText: "선택" //버튼 호버 텍스트              
        ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
        ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
    });                    
    
    //초기값을 오늘 날짜로 설정해줘야 합니다.
    $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
    	       
});

	let Grid = tui.Grid;
	let data;	
	let dwtmData;
	let checkPrcCd = 'd';    	//검색 조건을 사용하지 않지만 검색 메소드 매개변수에 vo가 있기 때문에 쓰레기 값을 넣어준다. 
	let vo={};					//map형식으로 보내주기 위해서 초기화 ;
	let fctCheckData;
	let dwtmCheckData;
	let DwtmVO; 
	let rdostatus =1; //비동기 등록, 비동기 중인 설비 라이도 버튼 값 
	let dwtmList = [];

	Grid.applyTheme('clean', {	
        cell: {
        	header: {
	            background: '#4B49AC',
	            text: '#fff'
	        },
	       
          
        }
       
      });
	
	
//  let dataSource; //그리드에 들어갈 데이터변수
	  
		//th 영역
		const fctColumns = [
			{
				header: '설비코드',
				name: 'fctCd',
				editor: 'text',
			},
			{
				header: '설비명',
				name: 'fctNm',
				editor: 'text',
			},
			{
				header: '사용공정',
				name: 'prcCd',
				editor: 'text',
			},
			{
				header: '공정이름',
				name: 'prcNm',
				editor: 'text',
			},
			{
				header: '설비상태',
				name: 'fctPhs',
				editor: 'text',
				width: 70,
				align : 'center'
			}
		]
		
		
		
	 //그리드를 id 값안에다가 붙여넣어준다.
	  let fctGrid = new Grid({
	         el: document.getElementById('fctGridDiv'),
	         data: data,  //이름이 같다면 생격가능
	         columns :fctColumns,
	         bodyHeight: 480,
	 		 minBodyHeight: 480,
	 		columnOptions: {
	 			 minWidth:40
	 			 }
	         });
		         
		//th 영역
		const dwtmColumns = [
			{
				header: '비동기이력',
				name: 'dwtmCd',
				editor: 'text',
			},
			{
				header: '설비명',
				name: 'fctNm',
				editor: 'text',
			},
			{
				header: '시작',
				name: 'strDt',
				editor: 'text',
			},
			{
				header: '종료',
				name: 'finDt',
				editor: 'text',
			},
			{
				header: '비동기 상태',
				name: 'msrMtt',
				editor: 'text',
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
	/* $.ajax({
		url:'./admMngList',
		dataType: 'json',
		async : false
	}).done(function(datas){
		let list = datas.data.contents;
		console.log(list)
		$('#checkPrcCd').append("<option value='d'>전체</option>")
		  for(let contentss of list){
			$('#checkPrcCd').append("<option value="+contentss.prcCd+">"+contentss.prcNm+"</option>")
		}  
	})  */
	
	//fct그리드 클릭 이벤트
	fctGrid.on('click', (ev) =>{
		
		
		
		fctCheckData = data[ev.rowKey];
		console.log('그리드 클릭 이벤트 ')
		console.log(fctCheckData)
		if(fctCheckData.fctPhs == '가동'){
			alert("현재 가동중인 설비이므로 비가동 등록을 할수 없습니다.")
			cleardetail()
		}		
		else if(fctCheckData.fctPhs == '대기'){
			console.log('N인 비가동 클ㄹ릭')			
			document.getElementById('fctCd').value = fctCheckData.fctCd;
			document.getElementById('fctNm').value =fctCheckData.fctNm;
			document.getElementById('msrCmt').disabled = true;
			document.getElementById('clickEndBtn').disabled = true;	//그리드 클릭했을 때 버튼 비활성화
			document.getElementById('dwtmEndTime').disabled = true;	//그리드 클릭했을 때 버튼 비활성화
			document.getElementById('dwtmEndMinute').disabled = true;	//그리드 클릭했을 때 버튼 비활성화
			document.getElementById('fctCd').readOnly = true;	//그리드 클릭했을 때 버튼 비활성화
			document.getElementById('fctNm').readOnly = true;	//그리드 클릭했을 때 버튼 비활성화
			document.getElementById('dwtmDate').disabled = true;	//그리드 클릭했을 때 버튼 비활성화
			//fctGrid.addCellClassName(ev.rowKey,'fctPhs','green')	
			console.log('ev찍어용')	
			console.log(ev)
		}
			
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
		document.getElementById('msrMtt').value = dwtmCheckData.msrMtt;
		document.getElementById('msrCmt').value = dwtmCheckData.msrCmt;
		document.getElementById('dwtmStartTime').value = dwtmCheckData.dwtmStartTime;
		document.getElementById('dwtmStartMinute').value = dwtmCheckData.dwtmStartMinute;
		document.getElementById('dwtmEndTime').value = dwtmCheckData.dwtmEndTime;
		document.getElementById('dwtmEndMinute').value = dwtmCheckData.dwtmEndMinute;
		
	})
	 //라디오 클릭하면 값 가져오기 
  	$("input[name='dwtmRao']:radio").change(function (e) {
  		if(e.target.id == 'fctSelectRdo'){
  			rdostatus = 1;
  			document.getElementById("dwtmFctGridDiv").style = 'display:none';
  			document.getElementById("fctGridDiv").style = 'display:block';
  			document.getElementById('clickEndBtn').disabled = true;
	  		fctChekPrcCd();	//페이지 접속후 기본으로 설비를 보여주는 그리드 출력하는 함수
	  		fctGrid.refreshLayout();
	  		
	  		document.getElementById('fctCd').disabled = false;
  			document.getElementById('fctNm').disabled = false;
  			document.getElementById('dwtmDate').disabled = false;
  			document.getElementById('empNo').disabled = false;
  			document.getElementById('dwtmStartTime').disabled = false;
  			document.getElementById('dwtmStartMinute').disabled = false;
  			document.getElementById('dwtmEndTime').disabled = true;
  			document.getElementById('dwtmEndMinute').disabled = true;
  			document.getElementById('clickStartBtn').disabled = false;	
  		}
  		else if(e.target.id == 'proceedingDwtm'){
  			document.getElementById('dwtmStartTime').disabled = true;	//그리드 클릭했을 때 버튼 비활성화
  			document.getElementById('dwtmStartMinute').disabled = true;	//그리드 클릭했을 때 버튼 비활성화
  			document.getElementById('clickEndBtn').disabled = false;	//그리드 클릭했을 때 버튼 비활성화
  			document.getElementById('clickStartBtn').disabled = true;	//그리드 클릭했을 때 버튼 비활성화
  			document.getElementById('dwtmEndTime').disabled = false;	//그리드 클릭했을 때 버튼 비활성화
  			document.getElementById('dwtmEndMinute').disabled = false;	//그리드 클릭했을 때 버튼 비활성화
  			document.getElementById('msrCmt').disabled = false;	//그리드 클릭했을 때 버튼 비활성화
  			
  			rdostatus = 2;
  			document.getElementById("dwtmFctGridDiv").style.display = 'block';
  			document.getElementById("fctGridDiv").style.display = 'none';
  			dwtmCheckData = $("#dwtmFctSelectFrm").serializeObject();
			dwtmCheckData.proceedCheck = 'proceed'
			console.log(dwtmCheckData)
			dwtmselect();
			dwtmGrid.refreshLayout();
  			
  		}
  		else{
  			
  			document.getElementById('clickEndBtn').disabled = true;	//그리드 클릭했을 때 버튼 비활성화
  			document.getElementById('clickStartBtn').disabled = true;	//그리드 클릭했을 때 버튼 비활성화
  			rdostatus = 0;
  			console.log('232')
  			document.getElementById("dwtmFctGridDiv").style.display = 'block';
  			document.getElementById("fctGridDiv").style.display = 'none';
  			dwtmCheckData = $("#dwtmFctSelectFrm").serializeObject();
  			dwtmCheckData.proceedCheck = 'done'
  			dwtmselect();	//비가동 조회
  			dwtmGrid.refreshLayout();
  			
  			document.getElementById('fctCd').readOnly = true;
  			document.getElementById('fctNm').readOnly= true;
  			document.getElementById('dwtmDate').disabled = true;
  			document.getElementById('empNo').disabled = true;
  			document.getElementById('dwtmStartTime').disabled = true;
  			document.getElementById('dwtmStartMinute').disabled = true;
  			document.getElementById('dwtmEndTime').disabled = true;
  			document.getElementById('dwtmEndMinute').disabled = true;
  			document.getElementById('msrCmt').disabled = false;	// 작업 내용 
  			
  		}
  		
  	});
	
	//삭제 기능 함수
	function dwtmDelete(){
		console.log('삭제 버튼 이벤트 성공')
		let dwtmInsertData = $("#flwFrm").serializeObject();
		$.ajax({
			url:"./dwtmDelete",
			method:"post",
			data:JSON.stringify(dwtmInsertData),
			contentType:"application/json"
		}).done(function(datas){
			console.log(datas)
			alert('삭제완료');
		})		
		
		
	}
	 //저장 클릭이벤트에 사용할 함수
  	function dwtmSave(){
		//input name으로 라디오 버튼 객체 가져오기
		let raoBtnLength = document.getElementsByName("dwtmRao").length;
		let raoBtnValue; 
		for(let i =0; i <raoBtnLength;i++){
			if(document.getElementsByName("dwtmRao")[i].checked == true){
				raoBtnValue = document.getElementsByName("dwtmRao")[i].parentNode.innerText
				
			}
		}
			if(raoBtnValue.trim() == '비동기 등록'){
		  		let dwtmInsertData = $("#flwFrm").serializeObject();
		  		$.ajax({
					url:"./dwtmInsret",
					method:"post",
					data:JSON.stringify(dwtmInsertData),
					contentType:"application/json"
				}).done(function(datas){
					console.log(datas)
					alert('등록완료');
				})		
			}
			else if(raoBtnValue.trim() == '비동기 중인 설비'){
				//업데이트 ajax
				let dwtmInsertData = $("#flwFrm").serializeObject();
				$.ajax({
					url:"./dwtmUpdate",
					method:"post",
					data:JSON.stringify(dwtmInsertData),
					contentType:"application/json"
				}).done(function(datas){
					console.log(datas)
					alert('비동기 등록완료 했습니다');
				})	
			}
	 	};	
	
  		
  //select 버튼 누르면 조건에 맞게 조회하기
	function chageLangSelect(event){
		let langSelect = document.getElementById("prcCd")
	}
  
  	//비동기 테이블 조회 
  	function dwtmselect(){
  		console.log('비동기 테이블 조회 아작스 ')
  		console.log(dwtmCheckData)
			$.ajax({
				url:'./dwtmSelectAll',
				method:'POST',
				data: JSON.stringify(dwtmCheckData),
				contentType:"application/json"
			}).done(function(datas){
				console.log('시간가져오기 테스트')
				console.log(datas) 
				dwtmData = datas;	
				dwtmGrid.resetData(datas)
				
			}) 
			
  	}
  	
  	
	//설비구분을 SELECT로 선택해서 조회하기 
	setInterval(function() {
		fctChekPrcCd()
		changePhs()
	}, 10000) 
	
	function fctChekPrcCd(){
		if(rdostatus == 1){
			fctCheckData = $("#dwtmFctSelectFrm").serializeObject();
			 $.ajax({
				  url:'./list1',	//나중에 이거 대신에 컨트롤러 요청하면 됨 
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
		else if(rdostatus == 2){
			dwtmCheckData = $("#dwtmFctSelectFrm").serializeObject();
			dwtmCheckData.proceedCheck = 'proceed'
			console.log('공정구분 조회 ')
			console.log(checkPrcCd)
			console.log(dwtmCheckData)
			
			dwtmSelect()
			
		}
		else{
			dwtmCheckData = $("#dwtmFctSelectFrm").serializeObject();
			dwtmCheckData.proceedCheck = 'done'
			dwtmSelect()
		}
	}	
  		
  		
	function dwtmSelect(){
		console.log('공정구분 검색')
		console.log(dwtmCheckData)
			$.ajax({
				url:'./dwtmSelectAll',
				method:'POST',
				data: JSON.stringify(dwtmCheckData),
				contentType:"application/json"
			}).done(function(datas){
				dwtmData = datas;	
				dwtmGrid.resetData(datas)
			}) 
	}
	//상세보기 input 클리어
	function cleardetail(){
			 console.log('clear')
			 document.getElementById('fctCd').value='';
			 document.getElementById('fctNm').value='';
			 document.getElementById('dwtmCd').value='';
			 document.getElementById('dwtmDate').value='';
			 document.getElementById('empNo').value='';
			 document.getElementById('dwtmStartTime').value='';
			 document.getElementById('dwtmStartMinute').value='';
			 document.getElementById('dwtmEndTime').value='';
			 document.getElementById('dwtmEndMinute').value='';
			 document.getElementById('msrMtt').value='';
			 document.getElementById('msrCmt').value='';
		 }

	
	//종료 버튼 현재 시간 구하는 함수
	function endTime(){
			 let today = new Date();
			 let year =  today.getFullYear();
			 let month =  today.getMonth()+1;
			 let day =  today.getDate();
			 let hours = today.getHours();		//시
			 let minutes = today.getMinutes();	//분
			 let testlpad = lpad(month,2,'0')
			 
			 
			 let dwtmstrDate = year+'-'+lpad(month,2,'0')+'-'+lpad(day,2,'0');
			 console.log('날짜 값 테스트 test')
			 console.log(dwtmstrDate )
			 let dbstrdt = dwtmstrDate + ' '+ hours +':' + lpad(minutes,2,'0');
			 console.log('시간 분 테스트')
			 console.log(dbstrdt)
			 
			 document.getElementById('dwtmEndTime').value = hours;
			 document.getElementById('dwtmEndMinute').value = minutes;
			 document.getElementById('finDt').value = dbstrdt;
			 
		 }
	//시작 버튼 현재시간 구하는 함수 
	function startTime(){
			 let today = new Date();
			 let year =  today.getFullYear();
			 let month =  today.getMonth()+1;
			 let day =  today.getDate();
			 let hours = today.getHours();		//시
			 let minutes = today.getMinutes();	//분
			 let testlpad = lpad(month,2,'0')
			 
			 
			 let dwtmstrDate = year+'-'+lpad(month,2,'0')+'-'+lpad(day,2,'0');
			 console.log('날짜 값 테스트 test')
			 console.log(dwtmstrDate )
			 let dbstrdt = dwtmstrDate + ' '+ hours +':' + lpad(minutes,2,'0');
			 console.log('시간 분 테스트')
			 console.log(dbstrdt)
			 
			 document.getElementById('dwtmStartTime').value = hours;
			 document.getElementById('dwtmStartMinute').value = minutes;
			 document.getElementById('strDt').value = dbstrdt;
			 document.getElementById('dwtmDate').value = dwtmstrDate;
			 
		 }
	
	$.ajax({
		url:'./selectFixPrc',
		dataType: 'json',
		async : false
	}).done(function(datas){
		console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
		console.log(datas)
		$('#checkPrcCd').append("<option value='d'>전체</option>")
		for(let data of datas){
			$('#checkPrcCd').append("<option value="+data.dtlCd+">"+data.dtlNm+"</option>")
		}
	}) 

	function changePhs(){
		
		for( object of fctGrid.getData()){
			if(object.fctPhs == '가동'){
				
				fctGrid.addCellClassName(object.rowKey,'fctPhs','red');
			}
			else if(object.fctPhs == '대기'){
				fctGrid.addCellClassName(object.rowKey,'fctPhs','green');
			}
			else if(object.fctPhs == '비가동'){
				fctGrid.addCellClassName(object.rowKey,'fctPhs','blue');
			}
			
		}
		
		
		
	}
	
	fctChekPrcCd();	//페이지 접속후 기본으로 설비를 보여주는 그리드 출력하는 함수
	document.getElementById("dwtmFctGridDiv").style = 'display:none';
	
	changePhs()	//설비 상태 값을 이용한 색 주는 함수


	
	
</script>
</body>
</html>