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
</style>
<body>
	<button id="addBtn">계획추가</button>
	<button id="saveBtn">저장</button>
	<button id="delBtn">삭제</button>
<!-- 	<input id="txtCo"> -->
	<button id="btnFindCo">주문서조회</button>
	<div id="dialog-form" title="주문서조회">미확인 주문서 목록</div>
	<div id="paln-dialog-form" title="생산계획 디테일">생산계획 디테일</div>
	<div id="grid"></div>
	<div id="abc">
		<div id="inAbc">
			<button onclick="xFnc(event)">X</button>
			<form action="">
			</form>
			<div id="inGrid"></div>
		</div>
	</div>
	<button id="aaa">새로고침</button>
	<script>

  	let lotData;
	let selectTag;
	let inGridData;
	let porObj;
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


    function xFnc(e) {
    	e.preventDefault();
    	e.target.parentNode.parentNode.style="display:none";
    }
	//생산계획 모달창
	planDialog = $( "#paln-dialog-form" ).dialog({
		autoOpen: false,
		modal:true,
		buttons:{"save":function(){alert("save")}}
	});
	$("#btnFindCo").on("click",function(){
		
		
	})
	

    //주문서검색 모달창
	dialog = $( "#dialog-form" ).dialog({
		autoOpen: false,
		modal:true,
		buttons:{"save":function(){alert("save")}}
	});
	$("#btnFindCo").on("click",function(){
		dialog.dialog( "open" );
		$("#dialog-form").empty();
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
    		planDialog.dialog( "open" );
    		$("#paln-dialog-form").empty();
    		//주문서 불러와서 모달에 띄워주기
    		 
			/* document.getElementById("abc").style = 'display:block';
			$("#inGrid").empty(); */
			let a={'ordShtNo':grid.getValue(ev.rowKey,'ordShtNo')}
			/*dataSource.api.readData= { url: 'order',method: 'GET'}
			inGrid.readData(1,a,true);//모달창 그리드 데이터 갱신 */
			//주문번호로 주문한제품 불러오기
			
				//자재lot그리드
			const lotColumns = [{
				header : '자재코드',
				name : 'mtrCd'
			},{
				header : 'LOT번호',
				name : 'mtrLot'
			},{
				header : '재고수량',
				name : 'stckCnt'
			},{
				header : '홀딩수량',
				name : 'hldCnt',
		  		editor : 'text'
			}];
			let lotGrid	= new Grid({
				el: document.getElementById('paln-dialog-form'),
				data:null,
				columns:lotColumns
			});	
			
			
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
					let inGridTag=document.getElementById('paln-dialog-form');
					inGridTag.appendChild(selectTag)
					
					console.log(selectTag);
					selectTag.addEventListener("change",function(event){
						//제품코드로 공정불러오기
						$.ajax({
							url:'prdNameList/'+event.target.value,
							success:function(result){
								console.log(result);
								for(let obj of result){
									let ulTag=document.createElement('ul');
									ulTag.setAttribute("click","ulFnc()");
									ulTag.innerHTML="&nbsp;&nbsp;"+obj.prcCd
									let liTag=document.createElement('li');
									liTag.innerHTML="&nbsp;&nbsp;"+obj.fctNm
									ulTag.appendChild(liTag);
									inGridTag.appendChild(ulTag);
								}
							}
						})
	
						
						fetch("lotCntList",{
							method:'POST',
							headers:{
								"Content-Type": "application/json",
							},
							body:JSON.stringify({'prdCd':event.target.value})
						})
						.then(response=>response.json())
						.then(result=>{
							lotGrid.resetData(result);
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
			
    function ulFnc(){

	}
			
	grid.on('click',function(ev){
		
		console.log(grid.getDescendantRows(ev.rowKey));
		console.log(grid.getDepth(ev.rowKey));
		console.log(grid.getData()[0]);
		console.log(grid.getCheckedRows());
	})	
	//모달에서 주문서 선택하면 어펜드로우시켜줌
	function ordFnc(ev){
		grid.appendRow(porObj[ev.target.getAttribute("data-ord-id")]);
		console.log(porObj[ev.target.getAttribute("data-ord-id")])
		console.log(ev.target.innerHTML);
		console.log(grid.getDescendantRows(ev.rowKey));
		dialog.dialog('close');
		
	}
	addBtn.addEventListener("click",function(){
		grid.appendRow({})
		grid.resetOriginData();
	})
	saveBtn.addEventListener("click",function(){
		console.log(dataSource);
		grid.request('modifyData'); //변경or추가된 데이터만 보냄
		grid.readData();
	})
 	delBtn.addEventListener("click",function(){
		grid.removeCheckedRows(true);
	}) 
 	grid.on("response",function(){
		console.log("새로고쳐라");
		grid.resetOriginData();	
		
		//grid.readData();
	}) 
	aaa.addEventListener("click",function(){
		console.log("aaaaaaaaaaaaaaaaaa")
		grid.readData();
		grid.resetOriginData();		
		
	})
	</script>
	
</body>
</html>