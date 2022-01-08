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
</head>
<body>
<div>
	<button type="button" id='btnFind'>조회</button>
	<button type="button" id='btnAdd'>추가</button>
	<button	type="button" id='btnDel'>삭제</button>
	<button type="button" id='btnSave'>저장</button>
</div>
<div id="grid" style="padding-right"></div>

<script type="text/javascript">
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
  
   //ajax 요청
  $.ajax({
	  url:'list1',	//나중에 이거 대신에 컨트롤러 요청하면 됨 
	  dataType:'json',
	  async : false
  }).done(function(datas){
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
         columns,
         //고정컬럼 (스크롤이 움직여도 고정되서 보인다)
         columnOptions: {
              frozenCount: 2, // 3개의 컬럼을 고정하고
              frozenBorderWidth: 3 // 고정 컬럼의 경계선 너비를 3px로 한다.
            }
         });
    
    
    //클릭 이벤트 그리드
    grid.on('click', (ev) => {
       console.log(ev)
         console.log('clicked!!');
       });
    grid.on('response', function(ev) {
    	   console.log(ev);
    	   grid.resetOriginData()	//현재 데이터를 변경된 데이터로 확장한다. 
       })
       
       btnAdd.addEventListener("click", function(){
    	   grid.appendRow({})
       })
       btnDel.addEventListener("click", function(){
    	   grid.removeCheckedRows(true); //삭제하는 방식 체크박스를 이용해서 삭제 
       })
       btnSave.addEventListener("click", function(){
    	   console.log('!!!!!!!!!!!!')
    	   grid.request('modifyData');
       })
       btnFind.addEventListener("click", function(){
    	   //grid.;
       })

</script>

</body>
</html>