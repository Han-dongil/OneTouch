 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<!-- 토스트그리드 cdn -->
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
</head>
<body>
<form id="frm" method="post">
			<div>
				<div>
					<label>설비구분</label>
					<select id="fctCd" name="fctCd"></select>
					<label>점검일자기준 출력</label>
					<input type="checkbox" id="searchCheck" name="searchCheck" value="1" onclick="checkClick(event)">
				</div>
				
				<div>
					<div id="checkDiv">
						<label>자료구분</label>
						<label>
							<span>점검일자</span>
						</label>
						<input type="radio" name="orderBy" value="dDate" id="radio-1" checked="checked">
						<label>
							<span>차기점검일</span>
						</label>
						<input type="radio" name="orderBy" value="dCompanyNm" id="radio-2"> 
							
					</div>
				</div>
				
				<div>
					<button type="button" id="searcnBtn" onclick="checkSeach(event)">조회</button>
					<button type="button" id="resetBtn">새자료</button>
					<button type="button" id="excelBtn">Excel</button>
					<button type="button" id="printBtn">인쇄</button>
				</div>
			</div>
		</form>
	<div id="grid"></div>
	
	<script type="text/javascript">
	let targetId = [];
	//공정코드 저장할 map 변수 
	let grid;
	
   let Grid = tui.Grid;
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
    editor: 'datePicker'
  },
  {
    header: '점검주기',
    name: 'chkProd',
    editor: 'datePicker'
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
    
    //공정 코드 조회 ajax 요청
    
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
    
    
     //공정코드 조건조회 ajax 
     function checkSeach(event){
    	let target = document.getElementById('fctCd')
	 	let checkPrcCd = target.options[target.selectedIndex].value
	 	 let vo={};
	 	 vo.checkPrcCd=checkPrcCd;
    	console.log('맵확인하기!!!!!!!!!')
    	console.log(vo)
    	
	 	 $.ajax({
	 		url:'list1',
	 		method: "POST",
	 		data: JSON.stringify(vo),
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
         rowHeaders : [ 'checkbox' ],
         columns,
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
       checkSeach();
</script>
</body>
</html> 