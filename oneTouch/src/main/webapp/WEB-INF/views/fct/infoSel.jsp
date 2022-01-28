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
</head>
<body>
<form id="frm" method="post">
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
			
		<div style="margin-left:100px; margin-right:100px;margin-bottom:100px " id="grid"></div>
				
		
	<script type="text/javascript">
	let targetId = [];
	//공정코드 저장할 map 변수 
	let grid;
	let today;//날자변수
   let Grid = tui.Grid;
   //테마옵션 (선언된 그리드 바로빝에 해주면되고 또는 jsp 파일로 만들어서 넣어도됨)
   Grid.applyTheme('clean', {
      cell: {
    	  header: {
	            background: '#4B49AC',
	            text: '#fff'
	        },
	        /* evenRow: {
	        	background:'#F5F7FF'
	        } */
			},
	        row:{
	        	hover:{
	          	  background:'#F5F7FF'
	            }
	        }
     /*  //고정칼럼 색상 설정
      frozenBorder: {
           border: 'red'
      } */
    });
   
   //th 영역
    const columns = [
    {
    header: '설비코드',
    name: 'fctCd',
    editor: 'text',
    width:120,
    align:'center'
  },
  {
    header: '설비명',
    name: 'fctNm',
    editor: 'text',
    align:'center'
  },
  {
    header: '공정',
    name: 'prcCd',
    editor: 'text',
    width:70,
    align:'center'
  },
  {
    header: '설비규격',
    name: 'fctStd',
    editor: 'text',
    align:'center'
  },
  {
    header: '모델명',
    name: 'fctModel',
    editor: 'text',
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
     editor: 'datePicker'
  },
  {
    header: '구매금액',
    name: 'purchCost',
    editor: 'text',
    align:'center'
  },
  {
    header: '점검주기',
    name: 'chkProd',
    editor: 'datePicker',
    width:70,
    align:'center'
  },
  {
    header: '총생산량',
    name: 'totPdtAmt',
    editor: 'datePicker',
    width:70
  }/* ,
  {
    header: 'uph생산량',
    name: 'uphPdtAmt',
    editor: 'datePicker'
  },
  {
    header: '사번',
    name: 'empNo',
    editor: 'datePicker'
  } */
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
         bodyHeight:600,
         columns,
         width:1000
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
       
       function todayDate(){
			let d;
			fetch('./selectTodayDate')
			.then(response=>response.json())
			.then(result=>{
				d= result.todayDate.substr(0,10)
				console.log(d)
			})
			console.log(d)
			today = d;
		}
       	todayDate()
		console.log(today)
	
       //document.getElementById('fixFrom').value = ;
       checkSeach();
</script>
</body>
</html> 