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
	<button type="button" id="planModal" name="planModal">생산계획조회</button>
	<div id="workGrid"></div>
	<div id="workDtlGrid"></div>
	<div id="plan-dialog-form" title="생산계획조회">생산계획 조회</div>
	<script>
		let Grid = tui.Grid;
		
		//메인그리드 설정
		//생산계획 조회 모달 그리드
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
		let mainDataSource={
				api:{
					readData:{url:'./findWorkList',
						method:'GET'}
				 /* 	modifyData:{url:'./pdtOrdlist',method:'PUT'},  */
				},
				contentType:'application/json'
			} 
		//그리드 컬럼 설정	
		const mainColumns = [{
			header : '계획번호',
			name : 'planNo'
		},{
			header : '작업우선순위',
			name : 'workProt',
		},{
			header : '작업지시일자',
			name : 'instrDate',
		},{
			header : '생산완료일자',
			name : 'pdtFinDate',
		},{
			header : '작업지시번호',
			name : 'instrNo',
		},{
			header : '제품번호',
			name : 'prdCd',
		},{
			header : '지시수량',
			name : 'instrCnt',
		},{
			header : '공정번호',
			name : 'prcCd',
		},{
			header : '작업시작일',
			name : 'workStrDate',
		},{
			header : 'bom',
			name : 'bomCd',
		}];
		//그리드 생성
		let mainGrid = new Grid({
			  el: document.getElementById('workGrid'),
			  data:mainDataSource,
			  rowHeaders:['checkbox'],
			  columns:mainColumns,
			  columnOptions: {
				  frozenCount :10,
				  frozenBorderWidth:2
			  }
		});
		

 		let modalDataSource={
				api:{
					readData:{url:'./modalPlanList',
						method:'GET'}
				 /* 	modifyData:{url:'./pdtOrdlist',method:'PUT'},  */
				},
				contentType:'application/json'
			} 
		//그리드 컬럼 설정	
		let modalColumns = [{
			header : '계획번호',
			name : 'planNo'
		},{
			header : '납기일자',
			name : 'dueDate'
		},{
			header : '작업우선순위',
			name : 'workPort'
		},{
			header : '계획일자',
			name : 'planDate'
		},{
			header : '계획디테일번호',
			name : 'planDtlNo'
		},{
			header : '제품번호',
			name : 'prdCd'
		},{
			header : '공정번호',
			name : 'prcCd'
		},{
			header : '필요수량',
			name : 'needCnt'
		},{
			header : '지시수량',
			name : 'instrCnt'
		},{
			header : '작업지시일',
			name : 'workStrDate'
		},{
			header : '작업계획일',
			name : 'workPlanTime'
		}];
		//그리드 생성
		let modalGrid = new Grid({
			  el: document.getElementById('plan-dialog-form'),
			  data:modalDataSource,
			  rowHeaders:['checkbox'],
			  columns:modalColumns,
			  columnOptions: {
				  frozenCount :11,
				  frozenBorderWidth:1
			  }
		});
		
		//계획서검색 모달창
		let modalDialog = $( "#plan-dialog-form" ).dialog({
			autoOpen: false,
			modal:true,
			height: 500,
			width: 1000,
			buttons:{"save":function(){
				alert("save")
				modalGrid.readData();	
			}}
		
		});
		
		document.getElementById("planModal").addEventListener("click",()=>{
			modalDialog.dialog( "open" );
			modalGrid.readData();
		})
		
		// 모달그리드 체크선택 확인
		modalGrid.on('check',ev=>{
			console.log(modalGrid.getRow(ev.rowKey));
			mainGrid.appendRows([modalGrid.getRow(ev.rowKey)]);
			modalDialog.dialog('close');
		})
	</script>
	
</body>
</html>