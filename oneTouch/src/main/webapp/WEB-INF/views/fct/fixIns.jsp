<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수리관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
</head>
<body>
<div style="margin-top: 50px; border-top: 2px solid black; border-bottom : 2px solid black; padding: 5px;">
  <input type="radio" id="requestRio" name="fixRio" value="수리요청" checked>
  <label for="request">수리요청</label>
    <input type="radio" id="fixingRio" name="fixRio" value="수리중">
  <label for="fixing">수리중</label>
    <input type="radio" id="completedRio" name="fixRio" value="수리완료">
  <label for="completed">수리완료</label>
  
  <span style="margin-left: 100px;">
  	<label>해당일자</label>
	<input type="Date" id="from" name="from"> 
	<label> ~ </label> 
	<input type="Date" id="to" name="to">
	<button type="button" id='btnFind'>조회</button>
	</span>
</div>
	
	<div id="grid"></div>
<script>
	var Grid = tui.Grid;
	let data;
	
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
	    header: '수리요청일',
	    name: 'fctNm',
	    editor: 'text'
	  },
	  {
	    header: '수리시작일',
	    name: 'prcCd',
	    editor: 'text'
	  },
	  {
		    header: '수리완료일',
		    name: 'fctStd',
		    editor: 'text'
	  },
	  {
		    header: '수리사항',
		    name: 'fctModel',
		    editor: 'text'
	  },
	  {
		    header: '수량',
		    name: 'compCd'
	  },
	  {
		    header: '단가',
		    name: 'usePurp'
	  },  
	  {     //날짜(데이터피커) cdn 받아서 넣었다
		     header: '금액',
		     name: 'inDate',
		     editor: 'datePicker'
	  }
	    ]
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
	   
	   
	   //라디오 클릭하면 값 가져오기 
	  	$("input[name='fixRio']:radio").change(function () {
	  		checkRdo();
	  	})
		
	  	let vo={};	//검색값을 담는 배열
		//체크된 라디오 버튼 value 값 가져오는 함수 
		//라디오버튼 값을 이용해서 아작스 사용 
		function checkRdo(){
			var obj_value = $("input:radio[name='fixRio']:checked").val();
			vo.checkRadio=obj_value;
		    $.ajax({
		    	url:'ajax/fctFixList',
		    	method:'POST',
		    	data: JSON.stringify(vo),
		    	contentType: "application/json",
		    	async : false
		    }).done(function(datas){
		    	console.log('리스트조회 결과값 ')
		    	console.log(datas)
		    	data=datas;
		    })
		}
		
	  	//페이지 로드 될때 처음 라디오 checked 된 id 값 가져오기 
	   checkRdo();
   
</script>
</body>
</html>