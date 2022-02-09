 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> 
<!-- 토스트그리드 cdn -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />

<!-- 토스트 그리드 위에 데이트피커 가 선언되어야 작동이 된다 (순서가중요) -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<!-- 토스트그리드 cdn -->
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="${path}/resources/js/function.js"></script>
<script src="${path}/resources/js/grid-common.js"></script>

<link rel="stylesheet" href="${path}/resources/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="${path}/resources/jquery-ui/images">

<style>
.labeltext{
	width: 80px !important;
}
.colline2{
	margin-left: 100px;
	width: 90px !important;
}
.bascard1{
	height:80px;
}
</style>
</head>
<body>

<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0"> 
					<h3 class="font-weight-bold page-title">설비조회</h3>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12 grid-margin stretch-card">
			<div class="card bascard1">
				<div class="card-body">
					<!-- <h4 class="card-title">설비정보</h4> -->
					<form id="frm" method="post">
						<div class="rowdiv">
							<span>
								<label class="labeltext">해당일자</label>&nbsp;&nbsp;
								<input type="text" id="fixFrom" name="fixFrom" class="datepicker jquerydtpicker"> 
								<label> ~ </label> 
								<input type="text" id="fixTo" name="fixTo" class="datepicker jquerydtpicker">
							</span>
							
							<span>
								<label class="form-check-label colline2">설비구분</label>
								<select id="checkPrcCd" name="checkPrcCd" class="selectoption"></select>
							</span>
							
							<span class="floatright">
								<button type="button" id="searcnBtn" class="btn btn-primary newalign" onclick="checkSeach(event)">조회</button>
								<!-- <button type="button" id="excelBtn" class="btn btn-main newalign">Excel</button>
								<button type="button" id="printBtn" class="btn btn-main newalign">인쇄</button> -->
							</span>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<span class="floatright">
		<form action="./fctExcelView.do">
			<button type="sumit" id="excelBtn" class="btn btn-main newalign">Excel</button>
		</form>
	</span>
	<br><br>
	<hr>
	<div id="grid"></div>				
</div>


<!-- <form id="frm" method="post">
	<div style="margin-top: 10px; border-top: 2px solid black; border-bottom : 2px solid black; padding: 5px;">
		<div>
			<span>
					<label class="schCondLabel">해당일자</label>&nbsp;&nbsp;
					<input type="Date" id="fixFrom" value="" name="fixFrom" class="datepicker"> 
					<label> ~ </label> 
					<input type="Date" id="fixTo" name="fixTo" class="datepicker">
				</span>&nbsp;&nbsp;
				
				<span>
					<label class="form-check-label">설비구분</label>
					<select id="checkPrcCd" name="checkPrcCd" class="selectoption"></select>
				</span>
		</div>
	</div>
	<div style="margin-top: 20px;">
		<button type="button" id="searcnBtn" class="btn btn-primary mr-2 floatrightbtn" onclick="checkSeach(event)">조회</button>
		<button type="button" id="resetBtn" class="btn btn-primary mr-2 floatrightbtn">새자료</button>
		<button type="button" id="excelBtn" class="btn btn-primary mr-2 floatrightbtn">Excel</button>
		<button type="button" id="printBtn" class="btn btn-primary mr-2 floatrightbtn">인쇄</button>
	</div>
</form> 
	
<div id="grid"></div>-->
				
		
	<script type="text/javascript">
	let targetId = [];
	//공정코드 저장할 map 변수 
	let grid;
	let pastDay;//날자변수
	let todayDay;//날자변수
	
	
	//데이트픽커
	$(function() {
    //input을 datepicker로 선언
    $(".jquerydtpicker").datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
        ,changeYear: true //option값 년 선택 가능
        ,changeMonth: true //option값  월 선택 가능                
        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
        ,buttonImage: "/oneTouch/resources/template/images/cal_lb_sm.png" //"http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
        ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
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
    $('.jquerydtpicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
    	       
});
	
	
   	/* let Grid = tui.Grid; */
   	//테마옵션 (선언된 그리드 바로빝에 해주면되고 또는 jsp 파일로 만들어서 넣어도됨)
   	/* Grid.applyTheme('clean', {
		cell: {
    	  header: {
	            background: '#4B49AC',
	            text: '#fff'
	        },
			},
	        row:{
	        	hover:{
	          	  background:'#F5F7FF'
	            }
	        } 
    });*/
   
   //th 영역
    const columns = [
    {
    header: '설비코드',
    name: 'fctCd',
    align:'center'
  },
  {
    header: '설비명',
    name: 'fctNm',
    align:'center'
  },
  {
    header: '공정',
    name: 'prcCd',
   /*  width:70, */
    align:'center'
  },
  {
    header: '설비규격',
    name: 'fctStd',
    align:'center'
  },
  {
    header: '모델명',
    name: 'fctModel',
    align:'center'
  },
  {
    header: '회사코드',
    name: 'compCd',
    align:'center'
  },
  {
    header: '사용목적',
    name: 'usePurp',
    align:'center'
  },  
  {     //날짜(데이터피커) cdn 받아서 넣었다
     headet: '입고일',
     name: 'inDate',
     align:'center'
  },
  {
    header: '구매금액',
    name: 'purchCost',
    align:'right'
  },
  {
    header: '점검주기',
    name: 'chkProd',
   /*  width:70, */
    align:'center'
  },
  {
    header: '총생산량',
    name: 'totPdtAmt',
    align:'right'
  }
    ]
	let data;
    let dataVO;
    
    //구분 정해서 조회ajax
  	/* $.ajax({
  		url:'selectCheck',
  		dataType:'json',
  		async : false
  	}).done(function(datas){
  		console.log(datas)
  	}) */
    
    //설비구분 코드 조회 ajax 요청

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
    
    
		
		
     //공정코드 조건조회 ajax 
     function checkSeach(event){
    	let target = document.getElementById('fctCd')
    	let checkVal = $("#frm").serializeObject();
    	console.log('첨에 조회를 불러온다.')
    	console.log(checkVal)
    	/* console.log('조회')
    	console.log(checkVal)
	 	let checkPrcCd = target.options[target.selectedIndex].value
	 	 let vo={};
	 	 vo.checkPrcCd=checkPrcCd;
    	console.log('맵확인하기!!!!!!!!!')
    	console.log(vo)
    	 */
	 	 $.ajax({
	 		url:'./list1',
	 		method: "POST",
	 		data: JSON.stringify(checkVal),
	 		contentType:"application/json",
	 		async: false,
	 		success:function(result){
	 			grid.resetData(result);
	 			
	 		}
	 		
	 	}) 
	 	
    }  
	/*     //설비 목록 조회 ajax 요청
	   $.ajax({
		  url:'list1',	//나중에 이거 대신에 컨트롤러 요청하면 됨 
		  dataType:'json',
		  async : false					//동기 = 절차적 
	  }).done(function(datas){
		  data = datas;
	  })  */
    
  
  //그리드를 id 값안에다가 붙여넣어준다.
   grid = new Grid({
         el: document.getElementById('grid'),
         data:data,  //이름이 같다면 생격가능
         /* rowHeaders : [ 'checkbox' ], */
         bodyHeight: 509,
         minBodyHeight: 509,
         columns
         //고정컬럼 (스크롤이 움직여도 고정되서 보인다)
         /* columnOptions: {
              frozenCount: 2, // 3개의 컬럼을 고정하고
              frozenBorderWidth: 3 // 고정 컬럼의 경계선 너비를 3px로 한다.
            } */
         });
    
   //check조건 함수 
   function checkClick(c){
	   let cv = c.target.checked
	   console.log(cv)
	    if(cv != true){
		   document.getElementById('checkDiv').style.display = "none";
	   }
	    else{
	    	document.getElementById('checkDiv').style.display = "block";
	    }
	  
   }
	grid.on('click',(ev) =>{
		
		dataVO = data[ev.rowKey];
		console.log(dataVO.useYn)
		
		document.getElementById('fctCd').value = dataVO.fctCd;
		document.getElementById('useYn').value = (dataVO.useYn=='Y')?'true':'false';
		document.getElementById('prcCd').value = dataVO.prcCd;
		document.getElementById('fctStd').value = dataVO.fctStd;
		document.getElementById('fctModel').value = dataVO.fctModel;
		document.getElementById('compCd').value = dataVO.compCd;
		document.getElementById('inDate').value = dataVO.inDate;
		document.getElementById('purchCost').value = dataVO.purchCost;
		document.getElementById('chkProd').value = dataVO.chkProd;
		document.getElementById('FctImg').value = dataVO.FctImg;
		document.getElementById('uphPdtAmt').value = dataVO.uphPdtAmt;
		document.getElementById('empNo').value = dataVO.empNo;
	})
    

      
         
       
    /* grid.on('response', function(ev) {
    	   console.log(ev);
    	   grid.resetOriginData()	//현재 데이터를 변경된 데이터로 확장한다. 
       }) */
       
      /*  btnAdd.addEventListener("click", function(){
    	   grid.appendRow({})
       })
       btnDel.addEventListener("click", function(){
    	   //삭제 아작스 처리
    	      	
    	
       })
        btnSave.addEventListener("click", function(){
        	console.log('11111111111111')
        	console.log($('#infoFrm').serialize())
    	   
    	   
    	   
    
    	   //grid.request('modifyData');
       })
       btnFind.addEventListener("click", function(){
    	   //grid.;
       })  */
   
       
		
       	/* resetBtn.addEventListener("click", function(){
       		if(!confirm("초기화하시겠습니까?")){
       			return;
       		}
       		grid.clear()
       	}) */
      checkSeach()
      
</script>
</body>
</html> 