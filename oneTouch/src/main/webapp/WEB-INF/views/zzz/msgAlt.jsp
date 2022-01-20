<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

<!-- modal창 호출 시 필요 -->
<script src="${path}/resources/js/modal.js"></script>


</head>
<body>
	<input id='rtn'>
	<button type='button' id='btnMtrComp'>자재업체</button>
	<button type='button' id='btnMtr'>자재</button>
	<button type='button' id='btnFctComp'>설비업체</button>
	<button type='button' id='btnMtrSect'>자재구분</button>
	<button type='button' id='btnPdtSect'>제품구분</button>
	<button type='button' id='btnFctDiv'>설비구분</button>
	<button type='button' id='btnPrd'>제품</button>
	<button type='button' id='btnPrc'>공정</button>
	
	
	<!-- modal창 만들 때 필요 -->
	<div id="dialog-form" title="title"></div>
	
	
	<form>
		<input type='date' id='altSendDt'>
		<button action='' id='selBtn' name='selBtn' onClick='selectDate()'>조회</button>
		<button type='button' id='delBtn' name='delBtn' onClick='DeleteChecked()'>선택삭제</button>
	</form>
	
	<div id='grid'></div>
	
	<script type="text/javascript">
		
		//Modal~~~~
		
		//자재 Modal start=========================================================================================
		$("#dialog-form").attr('title', '자재');
		let dialog = $( "#dialog-form" ).dialog({ //<div id="dialog-form" title="title"></div> 같이 가져갈 것  //(이미 있다면 let선언 빼주거나 아니면 dialog 이름 바꿔서 사용)
			autoOpen : false,
			modal : true,
			resizable: false,
			height: "auto",
			width: 300, //530,  제품모달은 사이즈 530정도로~~
			modal: true,
			/* maxHeight: 600
			maxWidth: 600
			minHeight: 200
			minWidth: 200
			position: { my: "left top", at: "left bottom", of: button } */
		});
		
		$("#btnMtr").on("click", function(){
			mMtr();
		})
		
		function getModalMtr(param){//모달에서 값을 선택했을 때 호출
			//선택한 값 parameter받아서 각자 처리
			$("#rtn").val(param);
			console.log(param);
			dialog.dialog("close");
		}
		//자재 Modal end=========================================================================================
			
			
		//제품 Modal start=========================================================================================
		//let dialog; //가져가서 사용할 때는 주석 풀어서 사용(이미 있다면 let선언 빼주거나 아니면 dialog 이름 바꿔서 사용)
		//dialog = $( "#dialog-form" ).dialog({ //갸져가서 주석 풀어서 사용 이미 있으면 빼고해도 됨     //<div id="dialog-form" title="title"></div> 같이 가져갈 것
		//	autoOpen : false,
		//	modal : true,
		//});
		
		$("#btnPrd").on("click", function(){
			mPrd();
		})
		
		function getModalPrd(param){//모달에서 값을 선택했을 때 호출
			//선택한 값 parameter받아서 각자 처리
			$("#rtn").val(param);
			console.log(param);
			dialog.dialog("close");
		}
		//제품 Modal end=========================================================================================
			
		
		//공정 Modal start=========================================================================================
		//let dialog; //가져가서 사용할 때는 주석 풀어서 사용(이미 있다면 let선언 빼주거나 아니면 dialog 이름 바꿔서 사용)
		//dialog = $( "#dialog-form" ).dialog({ //갸져가서 주석 풀어서 사용 이미 있으면 빼고해도 됨     //<div id="dialog-form" title="title"></div> 같이 가져갈 것
		//	autoOpen : false,
		//	modal : true,
		//});
		
		$("#btnPrc").on("click", function(){
			mPrc();
		})
		
		function getModalPrc(param){//모달에서 값을 선택했을 때 호출
			//선택한 값 parameter받아서 각자 처리
			$("#rtn").val(param);
			console.log(param);
			dialog.dialog("close");
		}
		//공정 Modal end=========================================================================================
			
		
		//************************공통코드 모듈에서 가져다 쓰는 방법************************
		//자재업체 Modal start=========================================================================================
		//let dialog; //가져가서 사용할 때는 주석 풀어서 사용(이미 있다면 let선언 빼주거나 아니면 dialog 이름 바꿔서 사용)
		//dialog = $( "#dialog-form" ).dialog({ //갸져가서 주석 풀어서 사용 이미 있으면 빼고해도 됨     //<div id="dialog-form" title="title"></div> 같이 가져갈 것
		//	autoOpen : false,
		//	modal : true,
		//});
		
		$("#btnMtrComp").on("click", function(){
			mBas('MTR_COM');
		})
		
		function getModalBas(param){
			//선택한 값 parameter받아서 각자 처리
			$("#rtn").val(param);
			console.log(param);
			dialog.dialog("close");
		} 
		//자재업체 Modal end=========================================================================================
		
		
		//설비업체 Modal start=========================================================================================
		//let dialog; //가져가서 사용할 때는 주석 풀어서 사용(이미 있다면 let선언 빼주거나 아니면 dialog 이름 바꿔서 사용)
		//dialog = $( "#dialog-form" ).dialog({ //갸져가서 주석 풀어서 사용 이미 있으면 빼고해도 됨     //<div id="dialog-form" title="title"></div> 같이 가져갈 것
		//	autoOpen : false,
		//	modal : true,
		//});
		
		$("#btnFctComp").on("click", function(){
			mBas('FCT_COM');
		})
		
		/* function getModalBas(param){ //모달에서 값을 선택했을 때 호출 나중에 주석 풀어서 사용
			//선택한 값 parameter받아서 각자 처리
			$("#rtn").val(param);
			console.log(param);
			dialog.dialog("close");
		} */
		//설비업체 Modal end=========================================================================================
			
			
		//자재구분 Modal start=========================================================================================
		//let dialog; //가져가서 사용할 때는 주석 풀어서 사용(이미 있다면 let선언 빼주거나 아니면 dialog 이름 바꿔서 사용)
		//dialog = $( "#dialog-form" ).dialog({ //갸져가서 주석 풀어서 사용 이미 있으면 빼고해도 됨     //<div id="dialog-form" title="title"></div> 같이 가져갈 것
		//	autoOpen : false,
		//	modal : true,
		//});
		
		$("#btnMtrSect").on("click", function(){
			mBas('MTR_SECT');
		})
		
		/* function getModalBas(param){ //모달에서 값을 선택했을 때 호출 나중에 주석 풀어서 사용
			//선택한 값 parameter받아서 각자 처리
			$("#rtn").val(param);
			console.log(param);
			dialog.dialog("close");
		} */
		//자재구분 Modal end=========================================================================================
			
			
		//제품구분 Modal start=========================================================================================
		//let dialog; //가져가서 사용할 때는 주석 풀어서 사용(이미 있다면 let선언 빼주거나 아니면 dialog 이름 바꿔서 사용)
		//dialog = $( "#dialog-form" ).dialog({ //갸져가서 주석 풀어서 사용 이미 있으면 빼고해도 됨     //<div id="dialog-form" title="title"></div> 같이 가져갈 것
		//	autoOpen : false,
		//	modal : true,
		//});
		
		$("#btnPdtSect").on("click", function(){
			mBas('PDT_SECT');
		})
		
		/* function getModalBas(param){ //모달에서 값을 선택했을 때 호출 나중에 주석 풀어서 사용
			//선택한 값 parameter받아서 각자 처리
			$("#rtn").val(param);
			console.log(param);
			dialog.dialog("close");
		} */
		//제품구분 Modal end=========================================================================================
			
			
		//설비구분 Modal start=========================================================================================
		//let dialog; //가져가서 사용할 때는 주석 풀어서 사용(이미 있다면 let선언 빼주거나 아니면 dialog 이름 바꿔서 사용)
		//dialog = $( "#dialog-form" ).dialog({ //갸져가서 주석 풀어서 사용 이미 있으면 빼고해도 됨     //<div id="dialog-form" title="title"></div> 같이 가져갈 것
		//	autoOpen : false,
		//	modal : true,
		//});
		
		$("#btnFctDiv").on("click", function(){
			mBas('FCT_DIV');
		})
		
		/* function getModalBas(param){ //모달에서 값을 선택했을 때 호출 나중에 주석 풀어서 사용
			//선택한 값 parameter받아서 각자 처리
			$("#rtn").val(param);
			console.log(param);
			dialog.dialog("close");
		} */
		//설비구분 Modal end=========================================================================================
			
			
			
			
			
			
	
		
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
					//console.log(result);
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
		
		//체크한 데이터 삭제
		function DeleteChecked(){
			$.ajax({
				url : './msgAltDelete',
				method : 'POST',
				contentType : 'application/json',
				data : JSON.stringify(checked),
				success : function(result){
					console.log(result);
					grid.resetData(result);
					checked.length=0;
				}
			})
		}
		
		function poll(){ 
			$.ajax({ 
				url: './msgAltDept', 
				method: 'POST',
				data : 'altRecpDept=fct',
				success: function(result){ 
					console.log(result);
					if (result.length > 0){
						console.log(result[0])
						let msgNo = result[0].msgNo;
						console.log(msgNo);
						if (window.confirm('메세지발송일시: ' + result[0].altSendDt + '\n메세지발송부서: ' + result[0].altSendDeptNm + '\n메세지: ' + result[0].altCmt)){
							$.ajax({
								url:'./updateAltChkY',
								method: 'POST',
								data : 'msgNo=' + msgNo,
								success:function(result){
									console.log(result);
								}
							})
						} 
					}
					
				}, 
				/* dataType: "json",  */
				/* complete: poll, 
				timeout: 1000000 */
			}); 
		}
		
		window.setInterval(poll, 10000)

		
	</script>
	
</body>
</html>