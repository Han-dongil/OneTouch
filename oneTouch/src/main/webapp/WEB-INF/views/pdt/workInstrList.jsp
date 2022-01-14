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
<script type="text/javascript"
	src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/template/json.min.js"></script>
</head>
<body>
	<button>생산계획조회</button>
	<div id="grid"></div>
	<div id="paln-dialog-form" title="생산계획조회">생산계획 조회</div>
	<script>
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
 		let dataSource={
				api:{
					readData:{url:'./workList',
						method:'GET',
						initParams:{param:'param'}},
				 	modifyData:{url:'./pdtOrdlist',method:'PUT'}, 
				},
				contentType:'application/json'
			} 
		//그리드 컬럼 설정	
		const columns = [{
			header : '주문번호',
			name : 'ordShtNo'
		},{
			header : '납기일자',
			name : 'dueDate'		
		},{
			header : '주문날짜',
			name : 'ordDate'
		},{
			header : '업체번호',
			name : 'compCd'
		},{
			header : '현재상태',
			name : 'nowPhs'
		},{
			header : '비고',
			name : 'cmt'
		}];
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
	</script>
	
</body>
</html>