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

</head>
<body>
	
	<form>
		<input type='date' id='altSendDt'>
		<button action='' id='selBtn' name='selBtn' onClick='selectDate()'>조회</button>
		<button type='button' id='delBtn' name='delBtn' onClick='DeleteChecked()'>선택삭제</button>
		
	</form>
	<div id='grid'></div>
	
	<script>
		let MsgAltVO={};
		let checked=[];
		let dataSource;
		
		selectAll();
		
		//전체조회
		function selectAll(){
			$.ajax({
				url : './msgAltList',
				dataType : 'json',
				async : false,
				success : function(result){
					console.log(result);
					dataSource = result;
				}
			});
		};
		
		let Grid = tui.Grid;
		
		Grid.applyTheme('striped', {
			cell : {
				header : {
					background:'#eef'
				},
				evenRow : {
					background:'#fee'
				}
			}
		})
		
		const columns = [
							{
								header : '메세지번호',
								name : 'msgNo'
							},
							{
								header : '알림발신일시',
								name : 'altSendDt'
							},
							{
								header : '알림발신부서',
								name : 'altSendDeptNm'
							},
							{
								header : '알림수신부서',
								name : 'altRecpDeptNm'
							},
							{
								header : '알림내용',
								name : 'altCmt'
							},
							{
								header : '알림확인여부',
								name : 'altChk'
							},
							{
								header : '알림확인일시',
								name : 'altChkDt'
							}
						];
		
		grid = new Grid({
			el : document.getElementById('grid'),
			data : dataSource,
			rowHeaders : ['checkbox'],
			columns
		});
		
		grid.on('successResponse', function(ev){
			console.log('성공');
		});
		
		grid.on('failResponse',function(ev){
			console.log("실패")
		})
		
		//메세지작성날짜 조건으로 검색
		function selectDate(){
			let altSendDt = document.getElementById('altSendDt').value;
			console.log(altSendDt);
			
			event.preventDefault();
			
			$.ajax({
				url : './msgAltDateList',
				method : 'POST',
				data : 'altSendDt=' + altSendDt,
				success : function(result){
					console.log(result);
					grid.resetData(result);
				}
			})
		}
		
		//체크박스 선택
		grid.on('check', (e) => {
			checked.push(dataSource[e.rowKey]);
			console.log(checked);
		})
		
		/* //체크한 데이터 삭제
		function DeleteChecked(){
			$.ajax({
				url:'./'
			})
		} */
		
		
	</script>
	
</body>
</html>