<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설비등록페이지</title>
<!-- 토스트그리드 cdn -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />

<!-- 토스트 그리드 위에 데이트피커 가 선언되어야 작동이 된다 (순서가중요) -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<!-- 토스트그리드 cdn -->
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>

<link rel="stylesheet"
   href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"
   integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
   crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>

<div id="dialog-form" title="모달테스트"></div>
<p class="validateTips">All form fields are required.</p>
<div>
	<button type="button" id='btnFind'>조회</button>
	<button type="button" id='btnAdd'>추가</button>
	<button	type="button" id='btnDel'>삭제</button>
	<button type="button" id='btnSave'>저장</button>
	<button type="button" id='btnEdit'>수정</button>
</div>
<div style="margin-top: 10px; border-top: 2px solid black; border-bottom : 2px solid black; padding: 5px;">
	<form id="infoFrm"  method="post">
		<table>
			<tr>
				<td>설비코드</td>
				<td><input type="text" id="fctCd" name = "fctCd" value= "" /></td>
				<td>사용여부</td>
				<td><input type="checkbox" id="useYn" name = "useYn" checked=""/></td>
				<td>공정</td>
				<td><input type="text" id="prcCd" name = "prcCd" value=""/></td>
				<td>설비명</td>
				<td><input type="hidden" id="fctNm" name = "fctNm" value=""/></td>
			</tr>
			<tr>
				<td>설비규격</td>
				<td><input type="text" id="fctStd" name = "fctStd" value=""/></td>
				<td>모델명</td>
				<td><input type="text" id="fctModel" name = "fctModel" value=""/></td>
				<td>회사코드</td>
				<td><input type="text" id="compCd" name = "compCd" value=""/></td>
			</tr>
			<tr>
				<td>입고일</td>
				<td><input type="date" id="inDate" name = "inDate" value=""/></td>
				<td>구매금액</td>
				<td><input type="text" id="purchCost" name = "purchCost" value=""/></td>
				<td>점검주기</td>
				<td><input type="text" id="chkProd" name = "chkProd" value=""/></td>
			</tr>
			<tr>
				<td>이미지</td>
				<td><input type="text" id="FctImg" name = "FctImg" value=""/></td>
				<td>시간당 생산량</td>
				<td><input type="text" id="uphPdtAmt" name = "uphPdtAmt" value=""/></td>
				<td>담당자</td>
				<td><input type="text" id="empNo" name = "empNo" value=""/></td>
			</tr>
			
		</table>
	</form>
</div>

<div id="grid" style="padding-right"></div>


<script>
	let dialog = $("#dialog-form").dialog({
		autoOpen: false,
		modal:true
	});
	
	$("#btnFind").on("click", function(){
		dialog.dialog("open");
		$("#dialog-form").load("searchCO.jsp",function(){
			console.log("로드됨")
		})
	});
	
	let targetId = [];
	let s = 'd';
   var Grid = tui.Grid;
   //테마옵션 (선언된 그리드 바로빝에 해주면되고 또는 jsp 파일로 만들어서 넣어도됨)
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
   
   //th 영역
    const columns = [
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
    header: '공정',
    name: 'prcCd',
    editor: 'text'
  },
  {
	    header: '설비규격',
	    name: 'fctStd',
	    editor: 'text'
  },
  {
	    header: '모델명',
	    name: 'fctModel',
	    editor: 'text'
  },
  {
	    header: '회사코드',
	    name: 'compCd'
  },
  {
	    header: '사용목적',
	    name: 'usePurp'
  },  
  {     //날짜(데이터피커) cdn 받아서 넣었다
	     headet: '입고일',
	     name: 'inDate',
	     editor: 'datePicker'
  },
  {
	    header: '구매금액',
	    name: 'purchCost',
	    editor: 'text'
  },
  {
	    header: '점검주기',
	    name: 'chkProd',
	    editor: 'text'
  },
  {
	    header: '총생산량',
	    name: 'totPdtAmt',
	    editor: 'text'
  },
  {
	    header: 'uph생산량',
	    name: 'uphPdtAmt',
	    editor: 'text'
  },
  {
	    header: '사번',
	    name: 'empNo',
	    editor: 'text'
  }
    ]
   
	
	let data;
    let dataVO;
    let checkPrcCd = 'd';    	//검색 조건을 사용하지 않지만 검색 메소드 매개변수에 vo가 있기 때문에 쓰레기 값을 넣어준다. 
    let vo={};					//map형식으로 보내주기 위해서 초기화 
    vo.checkPrcCd=checkPrcCd;   //vo에 키 값을 정해서 밸류 값을 넣어주는 초기화 
    
   //ajax 요청
	  
	  $.ajax({
		  url:'list1',	//나중에 이거 대신에 컨트롤러 요청하면 됨 
		  method: 'POST',
		  data: JSON.stringify(vo),
		  contentType: "application/json",
		  async : false					//동기 = 절차적 
	  }).done(function(datas){
		  console.log(datas)
		  data = datas;
	  }) 
   
  
/*    const dataSource = {
		  api: {
		    readData: { url: 'list',
		    	method: 'GET',
		    	initParams: { param: 'param' } },				//data = initParams
		  modifyData: { url: '${pageContext.request.contextPath}/modifyData', method: 'PUT' },
		  },
		  contentType:'application/json'
		};  */
  //그리드를 id 값안에다가 붙여넣어준다.
  const grid = new Grid({
         el: document.getElementById('grid'),
         data:data,  //이름이 같다면 생격가능
         rowHeaders : [ 'checkbox' ],
         columns
         //고정컬럼 (스크롤이 움직여도 고정되서 보인다)
         /* columnOptions: {
              frozenCount: 2, // 3개의 컬럼을 고정하고
              frozenBorderWidth: 3 // 고정 컬럼의 경계선 너비를 3px로 한다.
            } */
         });
    
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
		document.getElementById('fctNm').value = dataVO.fctNm;
		
	})
    
    //클릭 이벤트 그리드
    grid.on('check', (ev) => {
    	
    	let vo = {fctCd:""};
       vo.fctCd = data[ev.rowKey].fctCd;
      console.log(vo)
      targetId.push(vo);
      
      console.log(targetId)
    	  
    })
      
         
       
    grid.on('response', function(ev) {
    	   console.log(ev);
    	   grid.resetOriginData()	//현재 데이터를 변경된 데이터로 확장한다. 
       })
       
       btnAdd.addEventListener("click", function(){
    	   grid.appendRow({})
       })
       btnDel.addEventListener("click", function(){
    	   //삭제 아작스 처리
    	      	
    	   		
    	      $.ajax({
    	    	  
    	    	  url: "deleteInfo",
    	    	  method: "POST",
    	    	  data: JSON.stringify(targetId),			//json을 string으로 바꿔줘야함 
    	    	  contentType:"application/json",			//넘겨주는 데이터가 json이라는 걸 알려주는 것 
    	    	  success:function(result){
    	    		  console.log('성공')
    	    		  grid.resetData(result)
    	    		  targetId.length = 0;
    	    	  }
    	   
       		})
       })
        btnSave.addEventListener("click", function(){
        	console.log('11111111111111')
        	console.log($('#infoFrm').serialize())
    	   //등록아작스 
    	    $.ajax({
    	    	  
    	    	  url: "infoInsert",
    	    	  method: "POST",
    	    	  data:$('#infoFrm').serialize(),
    	    	  dataType:'Json',
    	    	  			
    	    	  success:function(result){
    	    		  console.log('성공')
    	    		  grid.resetData(result)
    	    	  }
    	   
       		})
    	   //grid.request('modifyData');
       })//add버튼 
       
       btnFind.addEventListener("click", function(){
    	   //grid.;
       }) 
       //수정 아작스 
       btnEdit.addEventListener("click", function(){
    	   console.log('수수수수수수수저엊어ㅓ저어저어정')
    	   $.ajax({
 	    	  url: "Updateinfo",
 	    	  method: "POST",
 	    	  data:$('#infoFrm').serialize(),
 	    	  dataType:'Json',
 	    	  			
 	    	  success:function(result){
 	    		  console.log('성공')
 	    		  grid.resetData(result)
 	    	  }
 	   
    		})
       })

</script>

</body>
</html>