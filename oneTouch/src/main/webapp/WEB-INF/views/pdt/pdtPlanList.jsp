<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>	
</head>
<body>
<div id='grid'></div>
	
	<script>
    let dataSource; //그리드에 들어갈 데이터변수
    
    function listAll(){
		$.ajax({
		  url:"./pdtPlanlist",
		  dataType:'json',
		  async:false,
		  success:function(result){
			  dataSource=result;
		  },
		  error:function(reject){
			  console.log(reject)
		  }
	  	})
    }
    listAll();    
	//그리드 컬럼 설정	
	const columns = [{
		header : '계획번호',
		name : 'planNo'
	},{
		header : '주문번호',
		name : 'ordShtNo'		
	},{
		header : '납기일짜',
		name : 'dueDate'
	},{
		header : '작업우선순위',
		name : 'workProt'
	},{
		header : '계획일짜',
		name : 'planDate'
	}];
	
  	let Grid = tui.Grid;
  	
	//그리드 테마적용
	Grid.applyTheme('striped',{
		cell:{
			header:{
				background:'#eef'
			},
			evenRow:{
				background:'#fee'
			}
		}
	})

	//그리드 생성
	grid = new Grid({
		  el: document.getElementById('grid'),
		  data:dataSource,
		  rowHeaders:['checkbox'],
		  columns,
		  columnOptions: {
			  frozenCount :2,
			  frozenBorderWidth:2
		  }
		});
	
	</script>
</body>
</html>