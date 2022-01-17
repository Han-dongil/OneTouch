<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
 
 
</head>
<body>

<div style="margin-top: 50px; border-top: 2px solid black; border-bottom : 2px solid black; padding: 5px;">
	<div  style="margin-left: 600px;">
		<button type="button" id='btnFind'>조회</button>
		<button type="button" id='btnAdd'>추가</button>
		<button	type="button" id='btnDel'>삭제</button>
		<button type="button" id='btnSave'>저장</button>
	</div>
	<form id="fixFrm" method="post">
		  <input type="radio" id="requestRio" name="fixPhs" value="수리요청" checked>
		  <label for="request">수리요청</label>
		  <input type="radio" id="fixingRio" name="fixPhs" value="수리중">
		  <label for="fixing">수리중</label>
		  <input type="radio" id="completedRio" name="fixPhs" value="수리완료">
		  <label for="completed">수리완료</label>
		  
		<span style="margin-left: 100px;">
			<label>해당일자</label>
			<input type="Date" id="fixFrom" name="fixFrom"> 
			<label> ~ </label> 
			<input type="Date" id="fixTo" name="fixTo">
		</span>
		<span >
			<label>설비구분</label>
			<select id="fctCd" name="fctCd"></select>
		</span>
	</form>
</div>
	<div id="grid"></div>
<script>

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


	let Grid = tui.Grid;
	let data;
	let checkForm;  //폼에 있는 조건을 담는 input을 가지고 옴 
	let el; //button을 커스텀 랜덩링 클래스에서 만들어줌 
	
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
	    editor: 'text',
    	sortable: true
	  },
	  {
	    header: '수리요청일',
	    name: 'reqDt',
	    editor: 'text',
	    editor: 'text',
    	sortable: true
	  },
	  {
	    header: '수리시작일',
	    name: 'strDt',
	    editor: 'text',
	    editor: 'datePicker',
    	sortable: true
	  },
	  {
		    header: '수리완료일',
		    name: 'finDt',
		    editor: 'text',
		    editor: 'datePicker',
	    	sortable: true
	  },
	  {
		    header: '수리사항',
		    name: 'fixCmt',
		    editor: 'text',
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
			}
	  },
	  {
		    header: '수량',
		    name: 'cnt',
		    sortable: true
	  },
	  {
		    header: '단가',
		    name: 'unitCost',
		    sortable: true
	  },
	  {
		    header: '단가',
		    name: 'unitCost',
		    sortable: true
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
    
    
   
    btnFind.addEventListener("click", function(){
    	checkRdo();
    	//
    })
   
	   btnDel.addEventListener("click", function(){
		   grid.removeCheckedRows(true);
	   });
	   
	   btnSave.addEventListener("click", function(){
		 	grid.blur();	//커서 빼주는 거 ?
 			grid.request('modifyData');
	   });
	   
	   //등록버튼
	   btnAdd.addEventListener("click", function() {
			grid.appendRow({})
	   });	
	   
	   
	  
	   checkRdo();
	
	  	
	  	
	  
   
</script>
</body>
</html>