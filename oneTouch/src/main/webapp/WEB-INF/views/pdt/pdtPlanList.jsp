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
<!-- 	<input id="txtCo"> -->
	<button id="btnFindCo">주문서조회</button>
	<div id="dialog-form" title="주문서조회">미확인 주문서 목록</div>
	<div id="grid"></div>
	<div id="abc">
		<div id="inAbc">
			<button onclick="xFnc(event)">X</button>
			<form action="">
			</form>
			<div id="inGrid"></div>
		</div>
	</div>
	<script>
	let selectTag;
	let inGridData;
	let inGrid;
	let porObj;
    function xFnc(e) {
    	e.preventDefault();
    	console.log(e.target);
    	e.target.parentNode.parentNode.style="display:none";
    }
    
	//주문서 불러와서 모달에 띄워주기
	fetch('pdtOrdlist')
	.then(response=>response.json())
	.then(result=>{
		porObj=result;
		console.log(result)
		let tableTag=document.createElement('table');
		for(let obj of result){
			let i=0;
			let trTag=document.createElement("tr");
			let tdTag=document.createElement("td");
			tdTag.innerHTML=obj.ordShtNo;
			tdTag.setAttribute("data-ord-id",i);
			tdTag.setAttribute("onClick","ordFnc(event)");
			trTag.appendChild(tdTag);
			let tdTag1=document.createElement("td");
			tdTag1.innerHTML=obj.compCd;					
			trTag.appendChild(tdTag1);
			tableTag.appendChild(trTag)			
			i++;
		}
		document.getElementById('dialog-form').appendChild(tableTag);
	})
    //주문서검색 모달창
/* 	function selectCo(co){
		$("#txtCo").val(co);
		dialog.dialog("close");
	} */
	dialog = $( "#dialog-form" ).dialog({
		autoOpen: false,
		modal:true,
		buttons:{"save":function(){alert("save")}}
	});
	$("#btnFindCo").on("click",function(){
		dialog.dialog( "open" );
		/* $("#dialog-form").load("searchCo.jsp",function(){
			console.log("로드됨");
		}) */

	})
    
//    let dataSource; //그리드에 들어갈 데이터변수
    var dataSource = {
    		  withCredentials: false,  
    		  initialRequest: true,
    		  api: {
    		        readData: { url: './pdtPlanlist',method: 'GET'},
    		      //createData: { url: '/api/create', method: 'POST' },
    		      //updateData: { url: '/modifyData', method: 'POST' },
    		      //deleteData: { url: '/api/delete', method: 'DELETE' },
    		      modifyData: { url: './modifyData', method: 'POST' }  
    		  },
    		  contentType: 'application/json'
    		}
    	console.log(dataSource);
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
		  /* columnOptions: {
			  frozenCount :6,
			  frozenBorderWidth:3
		 	} */ 
		 });
	
	//모달 그리드 주문서->제품코드//필요수량 (readData)
/*  	inGridData={
  		  withCredentials: false,  
  		  initialRequest: true,
  		  api: {
  		        readData: { url: './pdtPlanDtllist/',method: 'POST'}
					},
		  contentType: 'application/json',
		  serializer(params) {
			    return JSON.stringify(params);
			  }   
  		  } 
  		     
  		
	//}
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
			frozenCount :2,
			frozenBorderWidth:2
		}
	}) */
	 
	
	
	
	
	//로우 클릭 이벤트
     grid.on('click', ev => {
    	 if(ev.columnName=='planDate'){
			document.getElementById("abc").style = 'display:block';
			$("#inGrid").empty();
			let a={'ordShtNo':grid.getValue(ev.rowKey,'ordShtNo')}
			/*inGridData.api.readData= { url: './pdtPlanDtllist/',method: 'POST'}
			inGrid.readData(1,a,true);//모달창 그리드 데이터 갱신 */
			//주문번호로 주문한제품 불러오기
			$.ajax({
				url:'./pdtPlanDtllist/',
				method:'POST',
				data:a,
				success:function(result){
					console.log(result)
					selectTag=document.createElement('select');
					for(let obj of result){
						let optionTag=document.createElement('option');
						optionTag.value=obj.prdCd;
						optionTag.innerHTML=obj.prdCd;
						selectTag.appendChild(optionTag);
					}
					let inGridTag=document.getElementById('inGrid');
					inGridTag.appendChild(selectTag)
					
					console.log(selectTag);
					selectTag.addEventListener("change",function(event){
						console.log(event.target.value);
						//제품코드로 공정불러오기
						$.ajax({
							url:'prdNameList/'+event.target.value,
							success:function(result){
								console.log(result);
								for(let obj of result){
									let ulTag=document.createElement('ul');
									ulTag.innerHTML="&nbsp;&nbsp;"+obj.prcCd
									let liTag=document.createElement('li');
									liTag.innerHTML="&nbsp;&nbsp;"+obj.fctNm
									ulTag.appendChild(liTag);
									inGridTag.appendChild(ulTag);
								}
							}
						})
					})
					
				}
			})
    		 
    	 }
			
			 
	}) 
/*  			//inGrid 클릭이벤트 // 제품코드 클릭
			inGrid.on("click",function(ev){
				grid.getValue(ev.rowKey,'prdCd');
			})  */
    	
	grid.on('click',function(ev){
	})			
	function ordFnc(ev){
		grid.appendRow(porObj[ev.target.getAttribute("data-ord-id")]);
		dialog.dialog('close');
	}

	
	addBtn.addEventListener("click",function(){
		grid.appendRow({})
		grid.resetOriginData();
	})
	saveBtn.addEventListener("click",function(){
		console.log(dataSource);
		grid.request('modifyData'); //변경or추가된 데이터만 보냄
	})
	</script>
</body>
</html>