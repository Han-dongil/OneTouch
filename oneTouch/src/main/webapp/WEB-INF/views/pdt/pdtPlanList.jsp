<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script type="text/javascript"
	src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
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
	<select name="phs" id="phs">
		<option value="N">미지시</option>
		<option value="Y">지시완료</option>
	</select>
	<button action='' id='selBtn' name='selBtn' onClick="dateSelectFnc()">조회</button>
	<button id="addBtn">계획추가</button>
	<button id="saveBtn">저장</button>
	<button id="delBtn">삭제</button>
	<!-- 	<input id="txtCo"> -->
	<button id="btnFindCo">주문서조회</button>
	<div id="dialog-form" title="주문서조회">미확인 주문서 목록</div>
	<div id="paln-dialog-form" title="생산계획 디테일">
	<div id='planGrid'></div>
	<div id="lotDiv" style="display:none"></div>
	<div id='hidden'></div>
	생산계획 디테일
	</div>
	<div id="grid"></div>
	<form id="planFrm" name="planFrm">
		<input type="hidden" name="planNo" id="planNo">
		<input type="hidden" name="prdCd" id="prdCd">
		<input type="hidden" name="prcCd" id="prcCd">
		<input type="hidden" name="needCnt" id="needCnt">
		<input type="hidden" name="instrCnt" id="instrCnt">
		<input type="hidden" name="mtrLot" id="mtrLot">
		<input type="hidden" name="ordShtNo" id="ordShtNo">
		<input type="hidden" name="fctCd" id="fctCd">
	</form>
	<script>
	let lotGrid;
  	let lotData;
	let selectTag;
	let inGridData;
	let porObj;
  	let Grid = tui.Grid;
  	let modalDataSource;
  	let gridSelect;
  	let lotDiv;
  	let resetdataaa;
  	let gridw;
  	let hiddenGrid;
  	function dateSelectFnc(){
		event.preventDefault();
		fetch('pdtPlanlist/'+document.getElementById('phs').value)
		.then(response=>response.json())
		.then(result=>{
			grid.resetData(result);
		})
	}
  	
/////////////////////////////////////그리드///////////////////////////////////////  	
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
  	//생산계획모달 (주문서x)메인그리드
  	let planColumns = [{
		header : '제품코드',
		name : 'prdCd',          
		formatter: 'listItemText',
		      editor: {
		    	 type: 'select',
		         options: {
		            listItems: [
		            ]
		          }
		        },
		},{
			header : '공정코드',
			name : 'prcCd',          
			formatter: 'listItemText',
			editor: {
				type: 'select',
				options: {
					listItems: [
					]
				}
			},
		},{
			header : '필요수량',
			name : 'needCnt',
		 		editor : 'text'
		},{
			header : '지시수량',
			name : 'instrCnt',
		 		editor : 'text'
		},{
			header : '지시날자',
			name : 'workStrDate',
	 		editor : 'text',
			editor:'datePicker'
		},{
			header : '작업시간',
			name : 'workPlanTime',
			editor: {
				type: 'select',
				options: {
					listItems: [
						{text:'00:00~08:00',value:'1'},
						{text:'08:00~14:00',value:'2'},
						{text:'14:00~24:00',value:'3'}
					]
				}
			}
		},{
			header : '설비코드',
			name : 'fctCd',
			hidden:false
		}];


	//생산계획 모달창
	planDialog = $( "#paln-dialog-form" ).dialog({
		autoOpen: false,
		modal:true,
		height: 500,
		width: 1000,
		buttons:{"자재등록":()=>{
			hiddenGrid.appendRows(gridw.getModifiedRows().updatedRows);
			document.getElementById('hidden')
			
		},
			"행추가":function(){
			document.getElementById('lotDiv').style='display:none';
			planGrid.appendRow({})
			fetch('prdCdFind')
			.then(response=>response.json())
			.then(result=>{
				 //planGrid.resetData(result)
				 console.log(result)
				 let i=0
				 for(let obj of result){
					 planColumns[0].editor.options.listItems[i]={text:obj.prdCd,value:obj.prdCd}
					 i++;
				 }
			})
		},
		"save":function(){
			alert("save")
		  	if(gridSelect=='addLot'){
				console.log(planFrm)
	 			lotGrid.blur();//커서 인풋밖으로빼냄
	 			let planFormData=$("#planFrm").serializeObject()
	 			console.log(planFormData);
	 			lotGrid.getModifiedRows()
	 			let insertData={}
	 			insertData.plan=[planFormData];
	 			insertData.detail=lotGrid.getModifiedRows().updatedRows;
	 			console.log(insertData);
	 			fetch('planDtlInsert',{
	 				method:'POST',
	 				headers:{
						"Content-Type": "application/json",
					},
					body:JSON.stringify(insertData)
	 			}) 
		  	}
		  	else if(gridSelect=='addPlan'){
		  		let insertObject={};
		  		insertObject.plan=grid.getModifiedRows().createdRows
		  		insertObject.detail=planGrid.getModifiedRows().createdRows
		  		insertObject.lot=hiddenGrid.getData()
		  		fetch('addInsertPlan',{
	 				method:'POST',
	 				headers:{
						"Content-Type": "application/json",
					},
					body:JSON.stringify(insertObject)
	 			})
		  	}
		}}
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
		needOrdCd();
	});
	
    var dataSource = {
    		withCredentials: false,  
    		initialRequest: true,
    		api: {
    			readData: { url: '.'+phs,method: 'GET'},
    			//createData: { url: '/api/create', method: 'POST' },
    			//updateData: { url: '/modifyData', method: 'POST' },
    			//deleteData: { url: '/api/delete', method: 'DELETE' },
    			modifyData: { url: './modifyData', method: 'POST' }  
    		},
    		contentType: 'application/json'
    	}
    	modalDataSource = {
    		withCredentials: false,  
    		initialRequest: true,
    		api: {
    			readData: { url: '.',method: 'GET'},
    			modifyData: { url: './planDtlInsert', method: 'POST' }  
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
		editor:'datePicker'
	},{
		header : '작업우선순위',
		name : 'workProt',
		editor : 'text'
	},{
		header : '계획일자',
		name : 'planDate',
		editor:'datePicker'
	}];

	//그리드 생성
	grid = new Grid({
		el: document.getElementById('grid'),
		data:dataSource,
		rowHeaders:['checkbox'],
		columns,
	});  
	

	//자재 hidden grid
	
 	hiddenGrid = new Grid({
		el: document.getElementById('hidden'),
		data:null,
		rowHeaders:['checkbox'],
		columns:[{
			header : '자재코드',
			name : 'mtrCd'
		},{
			header : '자재로트',
			name : 'mtrLot',
		},{
			header : '현재재고',
			name : 'stckCnt',
			editor : 'text'
		},{
			header : '홀딩수량',
			name : 'hldCnt',
			editor : 'text'
		},{
			header : '사용량',
			name : 'useAmt',
		}],
	});  

	
	planGrid= new Grid({
		el: document.getElementById('planGrid'),
		data:null,
		rowHeaders:['checkbox'],
		columns:planColumns
	});	
	

	gridw = new Grid({
		el: document.getElementById('lotDiv'),
		data:null,
		rowHeaders:['checkbox'],
		columns:[{
			header : '자재코드',
			name : 'mtrCd'
		},{
			header : '자재로트',
			name : 'mtrLot',
		},{
			header : '현재재고',
			name : 'stckCnt',
			editor : 'text'
		},{
			header : '홀딩수량',
			name : 'hldCnt',
			editor : 'text'
		},{
			header : '사용량',
			name : 'useAmt',
		}],
	});
	
	// 계획추가 그리드 셀렉트옵션 선택시 이벤트
	 	planGrid.on('editingFinish',ev=>{
	 		if(ev.columnName=='prcCd'){
	 			document.getElementById('lotDiv').style="display:block";
	 			console.log(planGrid.getValue(ev.rowKey,'prcCd'));
	 			fetch('lotCdFind/'+planGrid.getValue(ev.rowKey,'prcCd')+'/'+planGrid.getValue(ev.rowKey,'prdCd'))
	 			.then(response=>response.json())
	 			.then(result=>{
		     		gridw.resetData(result);
		     		console.log(gridw.getData())
		     		//hiddenGrid.resetData(gridw.getModifiedRows().createdRows());
	 			})
	 		}
	 		else if(ev.columnName=='prdCd'){
		 		fetch('prcCdFind/'+planGrid.getValue(ev.rowKey,'prdCd'))
		 		.then(response=>response.json())
		 		.then(result=>{
		 			console.log(result)
		 			let i=0
					for(let obj of result){
						planColumns[1].editor.options.listItems[i]={text:obj.prcCd,value:obj.prcCd}
						i++;
				 	}
		 		})
	 		}
	 	})

	//로우 클릭 이벤트
     grid.on('click', ev => {
    	 //$("#hidden").empty();
    	 if(grid.getValue(ev.rowKey,'planNo')==null && ev.columnName=='planDate'){
		  	planDialog.dialog( "open" );
		  	gridSelect='addPlan';
    	 }
    	 /////////////////////////////////////////////////
    	 if(ev.columnName=='planDate'&&grid.getValue(ev.rowKey,'planNo')!=null){
   		  	gridSelect='addLot';
  	    	 planDialog.dialog( "open" );
      		//히든태그에 계획번호 입력
      		document.getElementById("planNo").value=grid.getValue(ev.rowKey,'planNo');
      		let ulDiv=document.createElement("div");
   			ulDiv.id="prdSelect";   	
   			document.getElementById("paln-dialog-form").appendChild(ulDiv);
   			console.log(ulDiv)
  			let a={'ordShtNo':grid.getValue(ev.rowKey,'ordShtNo')}
  			//히든폼에 주문번호저장
  			planFrm.ordShtNo.value=grid.getValue(ev.rowKey,'ordShtNo');
  			/*dataSource.api.readData= { url: 'order',method: 'GET'}
  			inGrid.readData(1,a,true);//모달창 그리드 데이터 갱신 */
  			//주문번호로 주문한제품 불러오기
  			
  /////////////////////////////////
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
  		},{
  			header : '계획번호',
  			name : 'planNo',
  			hidden:false
  		},{
  			header : '상품번호',
  			name : 'prdCd',
  			hidden:false
  		},{
  			header : '공정코드',
  			name : 'prcCd',
  			hidden:false
  		}];
  		lotGrid	= new Grid({
  			el: document.getElementById('paln-dialog-form'),
  			data:modalDataSource,
  			rowHeaders:['checkbox'],
  			columns:lotColumns
  		});	
  		
  		lotGrid.on("editingFinish",ev=>{
  			console.log(lotGrid.getValue(ev.rowKey,'instrCnt'));
  			lotGrid.setValue(ev.rowKey,'hldCnt',lotGrid.getValue(ev.rowKey,'instrCnt'),false)
  			//히든태그 instrCnt 입력
  			document.getElementById("instrCnt").value=lotGrid.getValue(ev.rowKey,'instrCnt');
  			//히든태그 mtpLot 입력
  			document.getElementById("mtrLot").value=lotGrid.getValue(ev.rowKey,'mtrLot');
   			//lotGrid에 prcCd 입력
  			lotGrid.setValue(ev.rowKey,'prcCd',planFrm.prcCd.value,false)
  			
  			//히든태그 planNo 입력
  			lotGrid.setValue(ev.rowKey,'planNo',document.getElementById("planNo").value,false)
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
  					prdCd=planFrm.prdCd.value;
  					let prcCd=planFrm.prcCd.value;

  					let ordShtNo=planFrm.ordShtNo.value;
  					let abcde={'prdCd':result[0].prdCd, 'ordShtNo':grid.getValue(ev.rowKey,'ordShtNo')};
  					//히든태그 needCnt 입력
  					document.getElementById("needCnt").value=result[0].needCnt;
  					document.getElementById("prdCd").value=result[0].prdCd;
  					//제품코드로 공정불러오기
  					needPrcCd(result[0].prdCd);
  					//lot재고 조회
  					abcde={'prdCd':prdCd, 'ordShtNo':ordShtNo , 'prcCd':prcCd};
  					needLotCnt(abcde);
  					//셀렉트태그 선택이벤트
  					selectTag.addEventListener("change",function(event){
  						$("#prdSelect").empty();
  						//히든태그 prdcd 입력
  						console.log("dddddddddddd");
  						console.log(event.target.value);
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
    	 
    	 
////////////////////////////////////////////////메모장자리

	}) 

	function liFnc(ev){
		console.log(event.target)
		//히든태그에 prcCd 입력
		document.getElementById("fctCd").value=event.target.innerHTML;
		let b=event.target.parentNode.getAttribute("data-prcKey");
		console.log(b);
		document.getElementById("prcCd").value=b;
		console.log(planFrm)
		let prdCd=planFrm.prdCd.value;
		let prcCd=planFrm.prcCd.value;
		let ordShtNo=planFrm.ordShtNo.value;
		

		abcde={'prdCd':prdCd, 'ordShtNo':ordShtNo , 'prcCd':prcCd};
		needLotCnt(abcde);
		
		
		
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
			lotGrid.resetData(result);
		})
	}
//제품코드로 공정조회
function needPrcCd(prdCd){
	$.ajax({
		url:'prdNameList/'+prdCd,
		success:function(result){
			let ulDiv=document.getElementById("prdSelect");
			console.log(ulDiv);
			let uniquePrcCd=result.map(x=>{
				return x.prcCd;
			})
			let set = new Set(uniquePrcCd);
			let uniqueArr=[...set];
			Array.isArray(uniqueArr)
			console.log(result)
			for(unique of uniqueArr){
				let ulTag=document.createElement('ul');
				ulTag.innerHTML=unique;
				ulTag.setAttribute("data-prcKey",unique);
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