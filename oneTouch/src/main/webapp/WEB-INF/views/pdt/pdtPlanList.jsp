<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
</head>
<style>
	#abc {
		display: none;
		width: 100%;
		height: 2000px;
		top: 0px;
		background-color: rgba(0, 0, 0, 0.3);
		position: absolute;
		z-index: 9;
	}

	#inAbc {
		background-color: beige;
		width: 70%;
		height: 1000px;
		left: 5%;
		top: 10%;
		position: absolute;
		z-index: 2;
	}
	#inGrid{
		width:200px;
	}
</style>
<body>
	<button id="addBtn">계획추가</button>
	<button id="saveBtn">저장</button>
	<div id="grid"></div>
	<div id="abc">
		<div id="inAbc">
			<button onclick="xFnc(event)">X</button>
			<form action="">
				<input id="na" name="na">

			</form>
			<div id="inGrid"></div>

		</div>
	</div>
	<script>
	let inGrid;
	let inGridData;
    function xFnc(e) {
    	e.preventDefault();
    	console.log(e.target)
    	e.target.parentNode.parentNode.style="display:none"
    }
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
		name : 'ordShtNo',
		editor : 'text'
	},{
		header : '납기일짜',
		name : 'dueDate',
		editor : 'text'
		
	},{
		header : '작업우선순위',
		name : 'workProt',
		editor : 'text'
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
			  frozenCount :6,
			  frozenBorderWidth:2
		  }
		});
	//모달그리드 생성
    

    grid.on('click', ev => {
    	
    	if(ev.columnName=='planDate'){
			$("#inGrid").empty();
			document.getElementById("abc").style = 'display:block';
			document.getElementById("na").value = dataSource[ev.rowKey].ordShtNo;
			$.ajax({
				url:"./pdtPlanDtllist/"+dataSource[ev.rowKey].ordShtNo,
				async:false,
				success:function(result){
					console.log(result);
					inGridData=result;
				}
			})
			//모달그리드 생성
			inGrid = new tui.Grid({
				el: document.getElementById('inGrid'),
				data:inGridData,
				rowHeaders:['checkbox'],
				columns:[{
			          header: '제품코드',
			          name: 'prdCd',
			  		  editor : 'text'
			        },
			        {
			          header: "필요수량",
			          name: "needCnt",
			          editor : 'text'
			        }
			      ],
				columnOptions: {
					frozenCount :6,
					frozenBorderWidth:2
				}
			
			});
			//inGrid 클릭이벤트 // 제품코드 클릭
			inGrid.on("click",function(ev){
				console.log(inGridData[ev.rowKey]);
			})
    	}
	})
	addBtn.addEventListener("click",function(){
		grid.appendRow({})
		grid.resetOriginData();
	})

	</script>
</body>
</html>