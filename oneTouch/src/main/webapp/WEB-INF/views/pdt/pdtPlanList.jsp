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
	<div id="paln-dialog-form" title="생산계획 디테일">생산계획 디테일
	</div>
	<div id="grid"></div>
	<div id="abc">
		<div id="inAbc">
			<button onclick="xFnc(event)">X</button>
			<form action=""></form>
			<div id="inGrid"></div>
		</div>
	</div>
	<form id="planFrm" name="planFrm">
		<input type="hidden" name="planNo" id="planNo">
		<input type="hidden" name="prdCd" id="prdCd">
		<input type="hidden" name="prcCd" id="prcCd">
		<input type="hidden" name="needCnt" id="needCnt">
		<input type="hidden" name="instrCnt" id="instrCnt">
		<input type="hidden" name="mtrLot" id="mtrLot">
	</form>
	<script>
	let lotGrid;
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
		buttons:{"save":function(){alert("save")
			fetch('planDtlInsert',{
				method:'POST',
				headers:{
					"Content-Type": "application/json",
				},
				body:JSON.stringify($('#planFrm').serializeObject())
				})
			
		}}
	});
	
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
		needOrdCd();
	})
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
		header : '납기일자',
		name : 'dueDate',
		editor : 'text'
		
	},{
		header : '작업우선순위',
		name : 'workProt',
		editor : 'text'
	},{
		header : '계획일자',
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
	
	//로우 클릭 이벤트
     grid.on('click', ev => {
    	 if(ev.columnName=='planDate'){
    		//히든태그에 계획번호 입력
    		document.getElementById("planNo").value=grid.getValue(ev.rowKey,'planNo');
    		planDialog.dialog( "open" );
    		$("#paln-dialog-form").empty();
    		let ulDiv=document.createElement("div");
 			ulDiv.id="prdSelect";   	
 			document.getElementById("paln-dialog-form").appendChild(ulDiv);
 			console.log(ulDiv)
/*     		let prdCdOrdNo={'prdCd':event.target.value , 'ordShtNo':grid.getValue(ev.rowKey,'ordShtNo')}
			needPrcCd(prdCdOrdNo); */
			/* document.getElementById("abc").style = 'display:block';
			$("#inGrid").empty(); */
			let a={'ordShtNo':grid.getValue(ev.rowKey,'ordShtNo')}
			/*dataSource.api.readData= { url: 'order',method: 'GET'}
			inGrid.readData(1,a,true);//모달창 그리드 데이터 갱신 */
			//주문번호로 주문한제품 불러오기
			
				//자재lot그리드 useAmt
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
			},{
				header : '지시수량',
				name : 'instrCnt',
		  		editor : 'text'
			},{
				header : '필요수량',
				name : 'needCnt',
			}];
			lotGrid	= new Grid({
				el: document.getElementById('paln-dialog-form'),
				data:null,
				columns:lotColumns
			});	
			
			lotGrid.on("editingFinish",ev=>{
				console.log(lotGrid.getValue(ev.rowKey,'instrCnt'));
				lotGrid.setValue(ev.rowKey,'hldCnt',lotGrid.getValue(ev.rowKey,'instrCnt'),false)
				//히든태그 prdcd 입력
				document.getElementById("instrCnt").value=lotGrid.getValue(ev.rowKey,'instrCnt');
				//히든태그 prdcd 입력
				document.getElementById("instrCnt").value=lotGrid.getValue(ev.rowKey,'instrCnt');
			})
			
			$.ajax({
				url:'./pdtPlanDtllist/',
				method:'POST',
				data:a,
				success:function(result){
					selectTag=document.createElement('select');
					console.log(result);
					for(let obj of result){
						let optionTag=document.createElement('option');
						optionTag.value=obj.prdCd;
						optionTag.innerHTML=obj.prdCd;
						selectTag.appendChild(optionTag);
					}
					let inGridTag=document.getElementById('paln-dialog-form');
					
					inGridTag.appendChild(selectTag)
					let abcde={'prdCd':result[0].prdCd, 'ordShtNo':grid.getValue(ev.rowKey,'ordShtNo')};
					//히든태그 needCnt 입력
					document.getElementById("needCnt").value=result[0].needCnt;
					document.getElementById("prdCd").value=result[0].prdCd;
					//제품코드로 공정불러오기
					needPrcCd(result[0].prdCd);
					//lot재고 조회
					needLotCnt(abcde);
					//셀렉트태그 선택이벤트
					selectTag.addEventListener("change",function(event){
						$("#prdSelect").empty();
						//히든태그 prdcd 입력
						document.getElementById("prdCd").value=event.target.value;
						//히든태그 needCnt 입력
						document.getElementById("needCnt").value=event.target.value;
						prdCdOrdNo={'prdCd':event.target.value , 'ordShtNo':grid.getValue(ev.rowKey,'ordShtNo')}

						console.log(planFrm)
						//제품코드로 공정불러오기
						
						needPrcCd(event.target.value);
						//lot재고 조회
						needLotCnt(prdCdOrdNo);
					})
				}
			})
    	 }
	}) 

	function liFnc(ev){
		console.log("dddd")
		console.log(event.target.innerHTML)
		//히든태그에 prcCd 입력
		document.getElementById("prcCd").value=event.target.innerHTML;
		console.log(planFrm)
	}
			
	grid.on('click',function(ev){
		
/* 		console.log(grid.getDescendantRows(ev.rowKey));
		console.log(grid.getDepth(ev.rowKey));
		console.log(grid.getData()[0]);
		console.log(grid.getCheckedRows()); */
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
		grid.blur();//커서 인풋밖으로빼냄
		grid.request('modifyData'); //변경or추가된 데이터만 보냄
	})
	
 	delBtn.addEventListener("click",function(){
		grid.removeCheckedRows(true);
	}) 
	
 	grid.on("response",function(ev){
 		console.log(ev)
		if(ev.xhr.response=="a"){
			grid.readData();
		}
	}) 

// 제품코드로	필요수량/lot별재고/자재코드 불러오기
function needLotCnt(abcde){
		fetch("lotCntList",{
			method:'POST',
			headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(abcde)
			})
		.then(response=>response.json())
		.then(result=>{
			console.log(result);
			lotGrid.resetData(result);
		})
	}
//제품코드로 공정조회
function needPrcCd(prcCd){
	$.ajax({
		url:'prdNameList/'+prcCd,
		success:function(result){
			let ulDiv=document.getElementById("prdSelect");
			console.log(ulDiv);
			let uniquePrcCd=result.map(x=>{
				return x.prcCd;
			})
			let set = new Set(uniquePrcCd);
			let uniqueArr=[...set];
			Array.isArray(uniqueArr)
			for(unique of uniqueArr){
				let ulTag=document.createElement('ul');
				ulTag.innerHTML="&nbsp;&nbsp;"+unique
				for(let obj of result){
					if(obj.prcCd==unique){
						let liTag=document.createElement('li');
						liTag.innerHTML=obj.fctNm
						ulTag.appendChild(liTag);
						liTag=document.createElement('li');
						liTag.setAttribute("onClick","liFnc()");
						liTag.innerHTML=obj.fctCd
						ulTag.appendChild(liTag);
						let inGridTag=document.getElementById('paln-dialog-form');
						ulDiv.appendChild(ulTag);
						inGridTag.appendChild(ulDiv);
					}
				}
			}
		}
	})
}
//주문서 모달에 조회
function needOrdCd(){
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
}
	
	
	</script>

</body>
</html>