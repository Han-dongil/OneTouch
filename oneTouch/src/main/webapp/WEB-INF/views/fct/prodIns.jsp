<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 토스트그리드 cdn -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<!-- 토스트 그리드 위에 데이트피커 가 선언되어야 작동이 된다 (순서가중요) -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>

<!-- 토스트그리드 cdn -->
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>

<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

<!-- toastr -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="${path}/resources/js/grid-common.js"></script>

<link rel="stylesheet" href="${path}/resources/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="${path}/resources/jquery-ui/images">

<style type="text/css">
.warning{background-color: orangered}
.caution{background-color: gold}
	
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
</hel>
<body>

<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">정기점검관리</h3>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12 grid-margin stretch-card">
			<div class="card bascard1">
				<div class="card-body">
					<!-- <h4 class="card-title">점검관리</h4> -->
					<form id="fixFrm" method="post">
						<div class="rowdiv">
							<span>
								<label class="labeltext">해당일자</label>&nbsp;&nbsp;
								<input type="text" id="fixFrom" name="fixFrom" class="datepicker jquerydtpicker"> 
								<label> ~ </label> 
								<input type="text" id="fixTo" name="fixTo" class="datepicker jquerydtpicker">
							</span>
							
							<span>
								<label class="form-check-label colline2">설비구분</label>
								<select id="fctCd" name="fctCd" class="selectoption"></select>
							</span>
							
							<span class="floatright">
								<button type="button" id="resetBtn" onclick=prodclear()  class="btn btn-main newalign">초기화</button>
								<button type="button" id="btnFind" class="btn btn-primary newalign">조회</button>
								
							</span>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<span class="floatright">
		<button type="button" id="prodChekCompleteBtn" class="btn btn-primary newalign2">점검대상조회</button>
		<button type="button" id="btnDel" class="btn btn-main newalign2">삭제</button>
		<button type="button" id="btnSave" class="btn btn-primary newalign2">저장</button>
	</span>
	<br><br>
	<hr>
	<div id="dialog-form" title="점검대상">점검대상 목록</div>
	<div id="grid"></div>
</div>

	
<script>


	/* let Grid = tui.Grid; */
	let data;
	let prodCheckObj;	//점검대상인 데이터를 담는 변수
	let dialog;
	let checkedRowdata;	//체크 행의 데이터를 저장하는 변수
	let now;
	let prodNo;	//만들어질 정기점검이력번호
	let predictprodChkNo;
	
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
	
	/* Grid.applyTheme('clean',{	
        cell: {
            header: {
              background: '#eef'
            }
          },
          currentRow: {
          	background: '#fee'
          }
     	}) ;  */
	
	 dialog = $( "#dialog-form" ).dialog({
		autoOpen : false,
		modal : true,
		resizable: true,
		height: "auto",
		width: 1300, //530,  제품모달은 사이즈 530정도로~~
		modal: true,
		buttons:{"불러오기":function(){
			fetch('./selectTodayDate')
			.then(response=> response.json())
			.then(result=>{
				console.log('결과값 가져오기')
				console.log(result)
				now = result.fixTo.substr(0,10)
				console.log(now)
			})
			.then(x=>{
				fetch('./selectExpectFctProd')
				.then(response=> response.json())
				.then(result=>{
					console.log('테스트입니다요요요용오오오옹호호호로로로오오오우우유유유류루루루유룰')
					console.log(result.predictProdChkNo)
					predictprodChkNo = result.predictProdChkNo; 
				})
				.then(x=>{
					var temp = [];
					for(i=0; i<checkedRowdata.length; i++){
						console.log(checkedRowdata)
						temp.push({
									chkExpectDt:''
								   ,chkProd:checkedRowdata[i].chkProd
								   ,chkProdUnit:checkedRowdata[i].chkProdUnit
								   ,chkDt:now
								   ,prodChkNo:predictprodChkNo
							       ,fctCd:checkedRowdata[i].fctCd
							       ,chkRslt:checkedRowdata[i].chkRslt
							       ,fctNm:checkedRowdata[i].fctNm
								   ,msrMtt:''		   
								   ,msrCmt:''})
					}
					console.table(temp)
					//mainGrid.appendRows(temp);
					mainGrid.resetData(temp);
					
					
					let rowK = mainGrid.getRowCount();
					
			    	console.log('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
			    	console.log(rowK)
					for(i =0; i< rowK; i++){
						mainGrid.setValue(i, 'chkRslt','');
						mainGrid.setValue(i, 'msrMtt','');
						mainGrid.setValue(i, 'msrCmt','');
						mainGrid.uncheck(i);
						
					}
			    	prodCheckGrid.refreshLayout();
					dialog.dialog( "close" );
					
					
				})
			})
				
		
			
			
			
		}}
		/* maxHeight: 600
		maxWidth: 600
		minHeight: 200
		minWidth: 200
		position: { my: "left top", at: "left bottom", of: button } */
	});
	
	
//  let dataSource; //그리드에 들어갈 데이터변수
	 var dataSource = {
		 initialRequest: false,
		 api: {
			readData: { url: './prodSelect',method: 'POST'},
			//createData: { url: '/api/create', method: 'POST' },
			//updateData: { url: '/modifyData', method: 'POST' },
			//deleteData: { url: '/api/delete', method: 'DELETE' },
			modifyData: { url: './prodModifyData', method: 'POST' }  
		 },
		 contentType: 'application/json',
	 };
	 
	 var dataSourceProdCheck = {
			 initialRequest: true,
			 api: {
				readData: { url: './prodChekList',method: 'POST'},
				//createData: { url: '/api/create', method: 'POST' },
				//updateData: { url: '/modifyData', method: 'POST' },
				//deleteData: { url: '/api/delete', method: 'DELETE' },
				//modifyData: { url: './fctModifyData', method: 'POST' }  
			 },
			 contentType: 'application/json',
		 };
   
   //th 영역
    const columns = [
    {
	    header: '정기점검이력번호',
	    name: 'prodChkNo',
	    editor: 'text',
	    align:'left'
  },
  {
	   header: '설비코드',
	   name: 'fctCd',
	   editor: 'text',
	    align:'center'
  },
  {
	    header: '설비이름',
	    name: 'fctNm',
	    editor: 'text',
	    align:'left'
  },
  {
	    header: '점검일자',
	    name: 'chkDt',
	    editor: 'text',
	    align:'center'
  },
  {
	    header: '점검주기',
	    name: 'chkProd',
	    editor: 'text',
	    align:'right'
  },
  {
	    header: '점검주기단위',
	    name: 'chkProdUnit',
	    editor: 'text',
	    align:'center'
  },
  {
	    header: '판정',
	    name: 'chkRslt',
	    editor:{
	    	type:'radio',
	    	options: {
	    		listItems:[
	    		{text: '적합', value: '적합'},
	    		{text: '부적합', value: '부적합'}
	    		]
	    	}
	    },
	    validation : {
	    	required : true
	    },
	    align:'center'
  },
  {
	    header: '조치사항',
	    name: 'msrMtt',
	    editor:{
	    	type:'radio',
	    	options: {
	    		listItems:[
	    		{text: '수리', value: '수리'},
	    		{text: '점검', value: '점검'},
	    		{text: '교체', value: '교체'}
	    		]
	    	}
	    },
	    validation : {
	    	required : true
	    },
	    align:'center'
  },
  {
	    header: '조치내역',
	    name: 'msrCmt',
	    editor: 'text',
	    validation : {
	    	required : true
	    },
	    align:'left'
  }
    ]
   
	let mainGrid = new Grid({
	    el: document.getElementById('grid'),
	    data:dataSource,  //이름이 같다면 생격가능
	    rowHeaders : [ 'checkbox' ],
	    columns: columns,
	    bodyHeight: 509,
        minBodyHeight: 509,
	 });
   
   //disapbleColumn 컬럼수정을 막는 코드
    /* mainGrid.disableColumn('prodChkNo')
	mainGrid.disableColumn('chkDt')
	mainGrid.disableColumn('chkExpectDt')
	mainGrid.disableColumn('chkProd')
	mainGrid.disableColumn('chkProdUnit') */
   
   mainGrid.on('editingStart', (ev) => {
	   console.log('startstartstartstartstart')
	   try{
		   console.log('trytrytrytrytrytry')
		   if(ev.columnName == "prodChkNo" || ev.columnName == "chkDt" || ev.columnName == "chkExpectDt" || ev.columnName == "chkProd" || ev.columnName == "chkProdUnit" || ev.columnName == "prodChkNo" || ev.columnName == "fctCd" || ev.columnName == "fctNm"){
				console.log('ininininininininininininininininin')
			  	//success: 성공(초록), info : 정보(하늘색), warning:경고(주항), error:에러(빨강)
				alert("변경할 수 없는 코드 입니다.")
			  	//toastr["warning"]("변경할 수 없는 코드 입니다.", "경고입니다.")
				
				//현재함수 종료
			   ev.stop();
		   }
	   }catch (err)
	   {
		   alert('예외에러 발생 위치: 338줄' + err);
	   }
   });
	   
	   
	   
   
   
  //th 영역
    const columnsProdCheck = [
	    {
		    header: '정기점검이력번호',
		    name: 'prodChkNo',
		    editor: 'text',
		    width: 200,
		     align:'center'
	  },
	  {
		    header: '설비이름',
		    name: 'fctNm',
		    editor: 'text',
		    align:'left'
	  },
	  {
		    header: '설비코드',
		    name: 'fctCd',
		    editor: 'text',
		    width: 200,
		     align:'center'
	  },
	  {
		    header: '점검일자',
		    name: 'chkDt',
		    editor: 'text',
		    align:'center'
	  },
	  {
		    header: '차기점검일',
		    name: 'chkExpectDt',
		    editor: 'text',
		    align:'center'
	  },
	  {
		    header: '남은 점검일수',
		    name: 'dayDiff',
		    editor: 'text',
		    align:'center'
		    
	  }
    ]
   
    let prodCheckGrid = new Grid({
	    el: document.getElementById('dialog-form'),
	    data: dataSourceProdCheck,  //이름이 같다면 생격가능
	    rowHeaders : [ 
	    	{type : 'checkbox'} ],
	   columns: columnsProdCheck
	 });
    
    

    btnFind.addEventListener("click", function(){
    	checkRdo();
    	
    })
   
   btnDel.addEventListener("click", function(){
	   mainGrid.removeCheckedRows(true);
   });

   btnSave.addEventListener("click", function() {
	    mainGrid.blur();	//커서 빼주는 거 ?
		mainGrid.request('modifyData');

   });
   
   //점검완료 등록 이벤트 
   prodChekCompleteBtn.addEventListener("click", function() {
   	
	   console.log('점검완료 등록')
	   dialog.dialog( "open" );
	   prodCheckGrid.refreshLayout();
	   console.log('모달창 띄울 때 뜨는 값 ')
	   console.log(dataSourceProdCheck)
	   for(i=0;i<prodCheckGrid.getRowCount();i++){
			if(prodCheckGrid.getData()[i].dayDiff<=1){
				prodCheckGrid.addRowClassName(i,'warning')
			}
			else if(prodCheckGrid.getData()[i].dayDiff > 1 && prodCheckGrid.getData()[i].dayDiff <= 3){
				prodCheckGrid.addRowClassName(i,'caution')
			}
			/* else{
				prodCheckGrid.addRowClassName(i,'green')
			} */
	   }
	   
	   
	   
	   //button
	   /* let btn = document.createElement('button');
	   btn.innerHTML = '확인'
	   document.getElementById('dialog-form').appendChild(btn) */
	   
	   
   });
   
   //체크 이벤트 처리 
    //클릭 이벤트 그리드
     prodCheckGrid.on('check', () => {
    	 console.table(prodCheckGrid.getCheckedRows())
    	checkedRowdata = prodCheckGrid.getCheckedRows();
    	 console.log('오브젝트배열 담는 변수 찍어보기 ')
    	 console.log(checkedRowdata)
    	/* let vo = {prodChkNo:""};
       vo.prodChkNo = data[ev.rowKey].prodChkNo;
      console.log(vo)
      targetId.push(vo);
      console.log('111111111111111111111111111111111222222')
      console.log(targetId) */
    	  
    });
     prodCheckGrid.on('uncheck', (ev) => {
    	  alert(`uncheck: ${ev.rowKey}`);
     });
	 
   // 조회를 하기 위한 조건데이터를 form직렬화를 시켜서 json 타입으로 readData로 넘겨주는 함수 
   function checkRdo(){
	   
	   let checkFormdata = $("#fixFrm").serializeObject();
	   console.log('fixFrm출력하기')
	   console.log(checkFormdata)
	   mainGrid.readData(1,checkFormdata, true);
    	
    	
	}
	
	//점검대상 모달에 조회 
	function prodChekSelect(){
		/* fetch('prodChekList',{
			method:'POST',
			body: JSON.stringify(data),
			headers:{
				'Content-Type' : 'application/json'
			}
		})
		.then(response=>response.json())
		.then(result=>{
			prodCheckObj=result;
			console.table(prodCheckObj);
			dataSouce = result;
			//grid.resetData(result)
		}) */
	}
	
	
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
	   
		function prodclear(){
			console.log('초기화')
			mainGrid.clear()
	 }
		
</script>
</body>
</html>