<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수리관리</title>
<!-- 토스트 그리드 위에 데이트피커 가 선언되어야 작동이 된다 (순서가중요) -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>


<!-- 제어쿼리ui -->
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
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
.checkwidth{
	width:110px;
}
.bascard1{
	height:121px;
}
</style>
</head>
<body>

<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">수리내역관리</h3>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 grid-margin stretch-card"><!-- <div style="margin-top: 50px; border-top: 2px solid black; border-bottom : 2px solid black; padding: 5px;">  -->
			<div class="card bascard1">
				<div class="card-body">
					<!-- <h4 class="card-title">조회조건</h4> -->
					
					<form id="fixFrm" method="post">
						<!-- <div class="form-group"> -->
							<label class="labeltext">작업구분</label>
							<div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="requestRio">
							  		<input type="radio" class="form-check-input" id="requestRio" name="fixPhs" value="수리요청" checked>
							  		수리요청
									<i class="input-helper"></i>
								</label>
							</div>
							                
							<div class="form-check checkwidth" style="display:inline-block">
								<label class="form-check-label schCondLabel" for="fixingRio">
							  		<input type="radio" class="form-check-input" id="fixingRio" name="fixPhs" value="수리중">
							  		수리중
									<i class="input-helper"></i>
								</label>
							</div>
							                
							<div class="form-check checkwidth" style="display:inline-block">
							    <label class="form-check-label schCondLabel" for="completedRio">
							  		<input type="radio" class="form-check-input" id="completedRio" name="fixPhs" value="수리완료">
							  		수리완료
									<i class="input-helper"></i>
								</label>
							</div>
						<br>
						
						
						<span>
							<label class="labeltext">해당일자</label>
							<input type="text" id="fixFrom" name="fixFrom" class="datepicker jquerydtpicker"> 
							<label> ~ </label> 
							<input type="text" id="fixTo" name="fixTo" class="datepicker jquerydtpicker">
						</span>
						
						<span>
							<label class="form-check-label colline2">설비구분</label>
							<select id="fctCd" name="fctCd" class="selectoption"></select>
						</span>
						
						<span>
							<button type="button" id='btnFind' class="btn btn-primary mr-2 floatrightbtn">조회</button>
						</span>
					</form> 
				</div>
			</div>
		</div>
	</div>
	
	<span class="floatright">
		<!-- <button type="button" id='btnAdd' class="btn btn-main newalign">추가</button> -->
		<button	type="button" id='btnDel' class="btn btn-main newalign">삭제</button>
		<button type="button" id='btnSave' class="btn btn-primary newalign">저장</button> 
	</span>
	<br><br>
	<hr>
	<div id="grid"></div>
</div>


<script>

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
        ,buttonImage: "${path}/resources/template/images/cal_lb_sm.png" //"http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
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
    //$('.jquerydtpicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
    	       
});

//알림창 
function poll(){ 
			$.ajax({ 
				url: '../msgAltDept', 
				method: 'POST',
				data : 'altRecpDept=fct',
				success: function(result){ 
					console.log(result);
					if (result.length > 0){
						console.log(result[0])
						let msgNo = result[0].msgNo;
						console.log(msgNo);
						if (window.confirm('메세지발송일시: ' + result[0].altSendDt + '\n메세지발송부서: ' + result[0].altSendDeptNm + '\n메세지: ' + result[0].altCmt)){
							$.ajax({
								url:'../updateAltChkY',
								method: 'POST',
								data : 'msgNo=' + msgNo,
								success:function(result){
									console.log(result);
								}
							})
						} 
					}
					
				}, 
				/* dataType: "json",  */
				/* complete: poll, 
				timeout: 1000000 */
			}); 
		}
		
		window.setInterval(poll, 10000)


//공정 코드 조회 ajax 요청

	$.ajax({
		url:'./selectFixPrc',
		dataType: 'json',
		async : false
	}).done(function(datas){
		$('#fctCd').append("<option value='d'>전체</option>")
		for(let data of datas){
			$('#fctCd').append("<option value="+data.dtlCd+">"+data.dtlNm+"</option>")
		}
	}) 


	//let Grid = tui.Grid;
	let data;
	let checkForm;  //폼에 있는 조건을 담는 input을 가지고 옴 
	let el; //button을 커스텀 랜덩링 클래스에서 만들어줌 
	
	/* Grid.applyTheme('striped', {	
        cell: {
          header: {
            background: '#4B49AC',
            text: '#fff'
          },
          evenRow: {
        	  background:'#F5F7FF'
          }
          
        },
        //고정칼럼 색상 설정
        frozenBorder: {
             border: '#7978E9'
        }
      }); */
	
	 
	
	
//  let dataSource; //그리드에 들어갈 데이터변수
   var dataSource = {
	  //withCredentials: false,  
	  initialRequest: false,
	  api: {
		readData: { url: './fctFixList',method: 'POST'},
		//createData: { url: '/api/create', method: 'POST' },
		//updateData: { url: '/modifyData', method: 'POST' },
		//deleteData: { url: '/api/delete', method: 'DELETE' },
		modifyData: { url: './fctModifyData', method: 'POST' }  
	  },
	  contentType: 'application/json',
	  };
	 
//th 영역
	    const columns = [
	    {
	    header: '설비코드',
	    name: 'fctCd',
    	sortable: true
	  },
	  {
	    header: '수리요청일',
	    name: 'reqDt',
    	sortable: true
	  },
	  {
	    header: '수리시작일',
	    name: 'strDt',
    	sortable: true
	  },
	  {
		    header: '수리완료일',
		    name: 'finDt',
	    	sortable: true
	  },
	  {
			header : '설비수리상태',
			name : 'fixPhs',
			editor: {
				type: 'radio',
				options: {
			        listItems: [
			          { text: '수리요청', value: '수리요청'},
			          { text: '수리시작', value: '수리중'},
			          { text: '수리완료', value: '수리완료'}
			        ]
			     }
			},
		     align:'center'
	  },
	  {
		    header: '수리사항',
		    name: 'fixCmt',
		    editor: 'text',
		    sortable: true,
		     align:'center'
	  },
	  {
		    header: '수량',
		    name: 'cnt',
		    editor: 'text',
		    sortable: true,
		     align:'right'
	  },
	  {
		    header: '단가',
		    name: 'unitCost',
		    editor: 'text',
		    sortable: true,
		     align:'right'
	  },
	  {
		    header: '총합계',
		    name: 'totCost',
		    editor: 'text',
		    sortable: true,
		     align:'right'
	  },
	  {
		    header: '수리코드',
		    name: 'fixCd',
	  }
	    ]
	    
	    
	   
    //라디오 클릭하면 값 가져오기 
  	$("input[name='fixPhs']:radio").change(function () {
  		
  		console.log('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
  		console.log(grid.getData())
  		checkRdo();
  		
  		
  	})
  	
  	
	
  
	   
  //그리드를 id 값안에다가 붙여넣어준다.
  let grid = new Grid({
         el: document.getElementById('grid'),
         data:dataSource,  //이름이 같다면 생격가능
         rowHeaders : [ 'checkbox' ],
         columns,
         //고정컬럼 (스크롤이 움직여도 고정되서 보인다)
         /* columnOptions: {
              frozenCount: 2, // 3개의 컬럼을 고정하고
              frozenBorderWidth: 3 // 고정 컬럼의 경계선 너비를 3px로 한다.
            } */
        bodyHeight: 468,
 		minBodyHeight: 468
    });
    grid.on('response', function(ev) {
	    if(ev.xhr.response ==0 ){
		   grid.readData();
	   	  } 
	   });
    
    // 검색 조건을 readData로 넘겨주는 함수 
    function checkRdo(){
		   let checkFormdata = $("#fixFrm").serializeObject();
	    	console.log('&&&&&&&&&&&&&&&&&')
	    	console.log(checkFormdata);
	    	grid.readData(1,checkFormdata, true);	
	    	
	    	
		}
    
    
    //수량컬럼 입려후 이벤트 처리 
    grid.on('editingFinish', function(ev){
    	if(ev.columnName == 'unitCost'){
    		console.log('수량 컬럼 입력 후 이벤트 동장 성공')
    		let cntValue = grid.getValue(ev.rowKey,'unitCost');
    		let unitValue = grid.getValue(ev.rowKey,'cnt');
    		grid.setValue(ev.rowKey,'totCost',cntValue*unitValue,true)
    		console.log(cntValue * unitValue)
    		
    	}
    	
    })
    
    
    btnFind.addEventListener("click", function(){
    	checkRdo();
    	//
    })
   
	   btnDel.addEventListener("click", function(){
		   grid.removeCheckedRows(true);
		   grid.request('modifyData');
	   });
	   
	   btnSave.addEventListener("click", function(){
		 	grid.blur();	//커서 빼주는 거 ?
 			grid.request('modifyData');
	   });
	   
      checkRdo();
	
	  	
	  	
	  
   
</script>
</body>
</html>