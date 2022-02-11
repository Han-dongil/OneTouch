<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<c:set var="path" value="${pageContext.request.contextPath}"/>	
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
 <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<link rel="stylesheet" href="${path}/resources/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="${path}/resources/jquery-ui/images">
<script src="${path}/resources/js/grid-common.js"></script>
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
.tHeadTag {
    background-color: dimgray;
    color: white;
}
.trTag:hover{
    background-color: slateblue;
    color: white;
}
.thTag{
    padding-top: 11px;
    padding-bottom: 11px;
    padding-left: 15px;
    padding-right: 20px;
}
.tdTag{
    padding-top: 8px;
    padding-bottom: 8px;
    padding-left: 15px;
    padding-right: 20px;
}
/* .trTag:nth-last-child(2n){  
    background-color: ghostwhite;
} */

/* #inAbc {
	background-color: beige;
	width: 70%;
	height: 1000px;
	left: 5%;
	top: 10%;
	position: absolute;
	z-index: 2;
} */
/* select {
	right : 2px;
	width:103%;
	height: 39px;
} */
#prcSelect {
	/* width:150px;
	height: 39px; */
	position: relative;
	top: 5px;
}
</style>
<body>

<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">생산계획관리</h3>
				</div>
			</div>
		</div>
	</div>
	
	<div class="flex row">
		<div class = "col-12">
			<h4 class="gridtitle">✔생산계획</h4>
			<span class="floatright">
				<button type="button" id="delBtn"  name ="delBtn" class="btn btn-main newalign2">초기화</button>
				<button type="button" id="addBtn"  name ="addBtn" class="btn btn-primary newalign2">계획추가</button>
				<button type="button" id="btnFindCo"  name ="btnFindCo" class="btn btn-primary newalign2">주문서조회</button>
				<button type="button" id="safeStckBtn"  name ="safeStckBtn" class="btn btn-primary newalign2">안전재고 생산계획</button>
				<button type="button" id="saveBtn"  name ="saveBtn" class="btn btn-primary newalign2">저장</button>
			</span>
			<div id="dialog-form" title="주문서조회"></div>
	        <div id="safe-dialog-form" title="안전재고 생산계획"></div>
			<br>
			<hr class="hr4">
			<div id="grid"></div>
		</div>
	</div>
	<br>
	<div class="flex row">
		<div class = "col-8">
			<h4 class="gridtitle">✔제품</h4>
			<span class="floatright">
				<button type="button" id="planGriaAddRow" name="planGriaAddRow" class="btn btn-main newalign2">행추가</button> 
				<select id="prcSelect" name="prcSelect" class="inputtext"></select>
			</span>
			<br>
			<hr class="hr4">
			<div id=planGrid></div>
		</div>
		
		<div class = "col-4">
			<h4 class="gridtitle">✔제품계획</h4>
			<hr class="hr4">
			<div id="insertDtlGrid"></div>
		</div>
	</div>
	<br>
	<div class="flex row">
		<div class = "col-8">
			<h4 class="gridtitle">✔사용가능자재</h4>
			<span class="floatright">
				<select id="mtrSelect" name="mtrSelect" class="inputtext"></select>
			</span>
			<hr class="hr4">
			<div id="lotDiv"></div>
		</div>
		
		<div class = "col-4">
			<h4 class="gridtitle">✔자재계획</h4>
			<hr class="hr4">
			<div id="hidden"></div>
		</div>
	</div>
	
</div>

<!-- 	<label for="checkedY">지시완료</label>
	<input type="radio" id="checkedY" name="phs" value="Y">
	<label for="checkedN">미지시</label>
	<input type="radio" id="checkedN" name="phs" value="N"> -->
	
<!-- 	<button action='' id='selBtn' name='selBtn' onClick="dateSelectFnc()">조회</button> -->
<!-- 	<button id="addBtn">계획추가</button>
	<button id="saveBtn">저장</button>
	<button id="delBtn">초기화</button>
		<input id="txtCo">
	<button id="btnFindCo">주문서조회</button>
	<button id="safeStckBtn">안전재고 생산계획</button>
	<div id="dialog-form" title="주문서조회">미확인 주문서 목록</div>
	<div id="safe-dialog-form" title="안전재고 생산계획">안전재고 계획등록</div>
	<div class="row">
		<div id="grid" class="col-12"></div>
		<br/>
	</div>
	<div class="row">
		<div id='planGrid' class="col-8"></div>
		<div id="insertDtlGrid" class="col-4" style="display:block"></div>
	<br/>
	</div>
	<br/>
		<button id="planGriaAddRow" name="planGriaAddRow">행추가</button> 
	<br/>
	<div class="row">
		<div id="lotDiv" style="display:block" class="col-8"></div>
		<div id='hidden' class="col-4" style="display:block"></div>
	</div>
	<br/>
		<select id="prcSelect" name="prcSelect">
	<br/>
		
	</select> -->
	
<script>
	let planGridRowKey;
	///////////////////////////////////////////////////////////////////////////////////
	class abc{
		constructor(props){
			const { grid ,rowKey , columnInfo,value} =props;
			const el = document.createElement('select');
			
			let data = props.columnInfo.editor.options.listItems;
			
			for(let i =0 ; i< data.length ; i++){
				let opt = document.createElement('option');
				opt.innerText=data[i].text; 
				opt.value=data[i].value;
				if(opt.value==value){
				  opt.selected=true;
				}
				el.append(opt);
			}
			el.addEventListener('click',ev=>{
				ev.stopPropagation();
				console.log("aaa");
			})
			  
			this.el=el;
			  
		}
		
		getElement(){
			return this.el;
		}
		
		render(props){
			this.el.value=String(props.value);
		}
	}

	class abcEditor{
		constructor(props){
			let{grid,rowKet,columnInfo,value}=props;
			let el=document.createElement('div');
			let select = document.createElement('select');
			select.setAttribute('onChange','planGridBlur()')
			let data = props.columnInfo.editor.options.listItems;
		
			for(let i=0 ; i<data.length ; i++){
				let opt=document.createElement('option');
				opt.innerText=data[i].text;
				opt.value=data[i].value;
				if(opt.value==value){
					opt.selected=true;
				}
				select.append(opt);
			}
			el.append(select);
		
			select.addEventListener('click',ev=>{
				ev.stopPropagation();
			})
			el.align='center'
		  
			this.el=el;
			this.select = select;
		
		}
		
		getElement(){
			return this.el;
		}
		
		getValue(){
			return this.select.value;
		}
	
	}
	
	class lineEditor{
		constructor(props){
			let{grid,rowKet,columnInfo,value}=props;
			let el=document.createElement('div');
			let select = document.createElement('select');
			select.setAttribute('onChange','planGridBlur()')
			select.id='planSelectTag'
			let data = props.columnInfo.editor.options.listItems;
	
			for(let i=0 ; i<data.length ; i++){
				let opt=document.createElement('option');
				opt.innerText=data[i].text;
				opt.value=data[i].value;
				if(opt.value==value){
					opt.selected=true;
				}
				select.append(opt);
			}
	   		el.append(select);
	
			select.addEventListener('click',ev=>{
				ev.stopPropagation();
			})
			el.align='center'
	   
			this.el=el;
			this.select = select;
		}
	
		getElement(){
			return this.el;
		}
	
		getValue(){
			return this.select.value;
		}
	}  
	
	class prcEditor{
		constructor(props){
			let{grid,rowKet,columnInfo,value}=props;
			let el=document.createElement('div');
			let select = document.createElement('select');
			
			let data = props.columnInfo.editor.options.listItems;
			
			for(let i=0 ; i<data.length ; i++){
				let opt=document.createElement('option');
				opt.innerText=data[i].text;
				opt.value=data[i].value;
				if(opt.value==value){
					opt.selected=true;
				}
				select.append(opt);
			}
			el.append(select);
			
			select.addEventListener('click',ev=>{
				ev.stopPropagation();
			})
			el.align='center'
		  
			this.el=el;
			this.select = select;
		}
		
		getElement(){
			return this.el;
		}
		
		getValue(){
			return this.select.value;
		}
	} 
	
	class dateEditor{
		constructor(props){
			let{grid,rowKet,columnInfo,value}=props;
			let el=document.createElement('div');
			let select = document.createElement('input');
			select.type="text";
			select.class="calander";
			select.id="datepicker";
			
			let data = props.columnInfo.editor.options.listItems;
			
			el.append(select);
			
			select.addEventListener('click',ev=>{
				ev.stopPropagation();
			})
			el.align='center'
			
			this.el=el;
			this.select = select;	
		}
		
		getElement(){
			return this.el;
		}
		
		getValue(){
			return this.select.value;
		}
	
	}
 
	class dueDateEditor{
		constructor(props){
			let{grid,rowKet,columnInfo,value}=props;
			let el=document.createElement('div');
			let select = document.createElement('input');
			select.type="text";
			select.class="calander";
			select.id="datepicker1";
			
			let data = props.columnInfo.editor.options.listItems;
		
			el.append(select);
			
			select.addEventListener('click',ev=>{
				ev.stopPropagation();
			})
			el.align='center'
		  
			this.el=el;
			this.select = select;
		
		}
		
		getElement(){
			return this.el;
		}
		
		getValue(){
			return this.select.value;
		}
	
	}

	////////////////////////////////////////////////////////////////////////////////////
	
	//document.getElementsClassName('tui-select-box-placeholder')
	let planGridNeedCnt=0;
	let lotGridUseAmt=0;      
	let lotGrid;
  	let lotData;
	let selectTag;
	let inGridData;
	let porObj;
  	/* let Grid = tui.Grid; */
  	let modalDataSource;
  	let gridSelect;
  	let lotDiv = document.getElementById('lotDiv');
  	let hiddenGrid;
  	let insertPlanNo;
  	let insertLineNo;
  	let insertPrcCd;
  	let inserMtrLot;
  	let phsValue;

  	
  	function dateSelectFnc(){
 	  	if(document.getElementsByName('phs')[0].checked){
 	  		phsValue='Y'
 	  	}
 	  	else if(document.getElementsByName('phs')[1].checked){
 	  		phsValue='N'
 	  	}
		event.preventDefault();
		fetch('pdtPlanlist/'+phsValue)
		.then(response=>response.json())
		.then(result=>{
			grid.resetData(result);
		})
	}
  	
/////////////////////////////////////그리드///////////////////////////////////////  	
	//그리드 테마적용
	/* Grid.applyTheme('striped',{
		cell:{
			header:{
				background:'#eef'
			},
			evenRow:{
				background:'#fee'
			}
		}
	}) */
  	//생산계획모달 (주문서x)메인그리드
  	let planColumns = [  	{
    	header: '제품코드',
        name: 'prdCd',
        align:'center',
        editor:{
          type:abcEditor,
          options:{
            listItems:[
            ]
          }
        },
        rederer:{
          type:abc
        }
      },{
			header : '제품명',
			name : 'prdNm',
			align: 'center',
		},{
    	header: '라인번호',
        name: 'lineNo',
        align:'center',
        editor:{
          type:lineEditor,
          options:{
            listItems:[
            ]
          }
        },
        rederer:{
          type:abc
        }
      },{
	    	header: '시작일자',
	        name: 'workStrDate',
	        align:'center',
	        editor:{
	          type:dateEditor,
	          options:{
	            listItems:[
	            ]
	          }
	        },
	        rederer:{
	          type:abc
	        }
	      },{
		    	header: '종료일자',
		        name: 'workEndDate',
		        align:'center',
		        editor:{
		          type:dateEditor,
		          options:{
		            listItems:[
		            ]
		          }
		        },
		        rederer:{
		          type:abc
		        }
		      },{
    	header: '공정코드',
        name: 'prcCd',
        align:'center',
        editor:{
          type:prcEditor,
          options:{
            listItems:[
            ]
          }
        },
        rederer:{
          type:abc
        },
        hidden:true
      },{
			header : '필요수량',
			name : 'needCnt',
			align: 'right',
		 		editor : 'text'
		},{
			header : '일별지시수량',
			name : 'instrCnt',
			align: 'right',
		 		editor : 'text'
		}
/* 		,{
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
		} */
		,{
			header : '계획번호',
			name : 'planNo',
			hidden:false
		}];

  	let insertDtlColumns = [  	{
			header : '제품코드',
			name : 'prdCd',
			align: 'center',
		},{
			header : '라인번호',
			name : 'lineNo',
			align: 'center',
		},{
			header : '공정코드',
			name : 'prcCd',
			align: 'center',
		},{
			header : '필요수량',
			name : 'needCnt',
			align: 'right',
			hidden:true
		},{
			header : '지시수량',
			name : 'instrCnt',
			align: 'right',
			hidden:true
		},{
			header : '시작날자',
			name : 'workStrDate',
			editor:'datePicker',
			align: 'center',
			hidden:true
		},{
			header : '종료날자',
			name : 'workEndDate',
			editor:'datePicker',
			align: 'center',
			hidden:true
		},{
			header : '작업시간',
			name : 'workPlanTime',
			hidden:true
		},{
			header : '계획번호',
			name : 'planNo',
			hidden:false
		}];
  	insertDtlGrid= new Grid({
		el: document.getElementById('insertDtlGrid'),
		data:null,
		scrollY:true,
		minBodyHeight : 120,
		bodyHeight : 120,
		columns:insertDtlColumns
	});	

	
    //주문서검색 모달창
	dialog = $( "#dialog-form" ).dialog({
		autoOpen: false,
		modal:true,
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
    			readData: { url: '.',method: 'GET'},
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
		name : 'planNo',
		align: 'center',
	},{
		header : '주문번호',
		name : 'ordShtNo',
		align: 'center',
	},{
    	header: '납기일자',
        name: 'dueDate',
        align:'center',
        editor:{
          type:dueDateEditor,
          options:{
            listItems:[
            ]
          }
        },
        rederer:{
          type:abc
        }
      },{
		header : '작업우선순위',
		name : 'workProt',
		editor : 'text'
	},{
		header : '계획일자',
		name : 'planDate',
		editor:'datePicker',
		align: 'center',
		hidden:true
	},{
		header : '제품코드',
		name : 'prdCd',
		hidden:true
	},{
		header : '필요수량',
		name : 'needCnt',
		hidden:true
	}
  ];

	//그리드 생성
	grid = new Grid({
		el: document.getElementById('grid'),
		data:dataSource,
		columns,
		minBodyHeight : 104,
		bodyHeight : 104,
	});  

	//자재 hidden grid
	
 	hiddenGrid = new Grid({
		el: document.getElementById('hidden'),
		data:null,
		scrollY:true,
		minBodyHeight : 170,
		bodyHeight : 170,
		columns:[{
			header : '자재코드',
			name : 'mtrCd',
			align: 'center',
		},{
			header : '공정코드',
			name : 'prcCd',
			align: 'center',
		},{
			header : '자재로트',
			name : 'mtrLot',
			align: 'center',
		},{
			header : '사용가능수량',
			name : 'realCnt',
			align: 'right',
			hidden:true
		},{
			header : '출고수량',
			name : 'hldCnt',
			align: 'right',
		},{
			header : '사용량',
			name : 'useAmt',
			hidden:true
		},{
			header : '계획번호',
			name : 'planNo',
			align: 'center',
			hidden:false
		},{
			header : '라인번호',
			name : 'lineNo',
			align: 'center',
			hidden:true
		},{
			header : '공정코드',
			name : 'prcCd',
			align: 'center',
			hidden:true
		}],
	});  

	planGrid= new Grid({
		el: document.getElementById('planGrid'),
		data:null,
		scrollY:true,
		minBodyHeight : 120,
		bodyHeight : 120,
		columns:planColumns
	});	
	

	lotGrid = new Grid({
		el: document.getElementById('lotDiv'),
		data:null,
		scrollY:true,
		minBodyHeight : 130,
		bodyHeight : 130,
		columns:[{
			header : '자재코드',
			name : 'mtrCd',
			align: 'center',
		},{
			header : '자재로트',
			name : 'mtrLot',
			align: 'center',
		},{
			header : '사용가능수량',
			name : 'realCnt',
			editor : 'text',
			align: 'right',
		},{
			header : '출고수량',
			name : 'hldCnt',
			editor : 'text',
			align: 'right',
		},{
			header : '사용량',
			name : 'useAmt',
			align: 'right',
		},{
			header : '계획번호',
			name : 'planNo',
			align: 'right',
			hidden:true
		}
	   ]
			,summary : {
		        height: 40,
		        position: 'bottom',
		        columnContent: {
		        	hldCnt: {
		               template(summary) {
		            	   let needLotCnt=planGridNeedCnt*lotGridUseAmt-summary.sum*1
		            	   return "필요수량 : "+planGridNeedCnt*lotGridUseAmt+'<br/>부족수량 : '+needLotCnt;
		               }
		           }}
		}
	});
	
	//document.getElementById('lotDiv').style="display:block"; //lot 그리드 히든풀기
	planGrid.on('editingStart',ev=>{
		
	})
	
	// 계획추가 그리드 셀렉트옵션 선택시 이벤트
	 	planGrid.on('editingFinish',ev=>{
			if(ev.columnName=='needCnt'){
				planGridNeedCnt=planGrid.getRow(ev.rowKey).needCnt
			}
	 		//plan 그리드 
	 		//라인번호 선택하면 공정코드가져옴
	 		if(ev.columnName=='lineNo'){
				prcFindFnc(ev.rowKey);
	 		}
	 		
	 		
	 		//제품코드로 라인번호 가져오기
	 		 else if(ev.columnName=='prdCd'){
	 			lineFindFnc(ev.rowKey);
	 		} 
	 		
 		})

	//로우 클릭 이벤트
     grid.on('click', ev => {
    	 //메인그리드 클릭시 모달창open
    	 console.log();
    	 if(ev.columnName=='dueDate'){
    		
 			/////////////////////
    		 $( function() {
  			    $( "#datepicker1" ).datepicker({
  			      dateFormat:"yy-mm-dd",
  			      regional:"ko",
  			     // beforeShowDay: disableAllTheseDays
  			    });
  			  $('.datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
  	          $('#startDate').datepicker('setDate', 'today-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)  
  			  } );
    	 }
    	 
    	 if(ev.columnName=='planDate'){
    		 
    	 }
    	//생산계획번호 불러오기
    	else if(ev.columnName=='planNo'){
    	 		fetch('planNoFind')
    	 		.then(response=>response.json())
    	 		.then(result=>{
    	 			if(grid.getData().length==1){
	    	 			grid.setValue(ev.rowKey,'planNo',result.planNo);
    	 			}
    	 			else{
	    	 			grid.setValue(ev.rowKey,'planNo',(grid.getData()[0].planNo).substring(0,11)+lpad((grid.getData()[0].planNo).substring(11,15)*1+(grid.getData().length-1)*1,4,'0'));
    	 			}
    	 		})
    	 	}
    	 /////////////////////////////////////////////////
    	 else if(ev.columnName=='planDate'&&grid.getValue(ev.rowKey,'planNo')!=null){
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
  			
  ///////////////////////////////////자재lot그리드 useAmt
  		const lotColumns = [{
  			header : '자재코드',
  			name : 'mtrCd',
			align: 'center',
  		},{
  			header : 'LOT번호',
  			name : 'mtrLot'
  		},{
  			header : '재고수량',
  			name : 'stckCnt',
			align: 'right',
  		},{
  			header : '홀딩수량',
  			name : 'hldCnt',
  	  		editor : 'text',
			align: 'right',
  		},{
  			header : '지시수량',
  			name : 'instrCnt',
  	  		editor : 'text',
			align: 'right',
  		},{
  			header : '필요수량',
  			name : 'needCnt',
			align: 'right',
  		},{
  			header : '계획번호',
  			name : 'planNo',
			align: 'center',
  			hidden:false
  		},{
  			header : '상품번호',
  			name : 'prdCd',
			align: 'center',
  			hidden:false
  		},{
  			header : '공정코드',
  			name : 'prcCd',
			align: 'center',
  			hidden:false
  		}];
  		
  			$.ajax({
  				url:'./pdtPlanDtllist',
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
		let planNo;

		console.log(planNo)
		abcde={'prdCd':prdCd, 'ordShtNo':ordShtNo , 'prcCd':prcCd ,'planNo':planNo};
		console.log(abcde)
		needLotCnt(abcde);
		
	}
	
	
	//모달에서 주문서 선택하면 어펜드로우시켜줌
	function ordFnc(ev){
		console.log(ev.target.getAttribute("data-ord-id"));
		grid.resetData([{'ordShtNo':ev.target.getAttribute("data-ord-id")}]);
		fetch('planNoFind')
 		.then(response=>response.json())
 		.then(result=>{
			grid.setValue(grid.getData()[0].rowKey,'planNo',result.planNo);
 		})
 		.then(()=>{
 			 fetch('ordShtSelect/'+grid.getValue(0,'ordShtNo'))
  			 .then(response=>response.json())
  			 .then(result=>{
  				 console.log(result)
  				 return result;
  			 })
  			 .then(x=>{
  				planGrid.resetData(x)
  				for(let i=0 ; i< x.length ; i++){
					planGrid.setValue(i,'planNo',grid.getData()[0].planNo);
  				}
						 
 					 fetch('prdCdFind')
					.then(response=>response.json())
					.then(result=>{
						 planColumns[0].editor.options.listItems.length=0;
						 for(let obj of result){
							planColumns[0].editor.options.listItems.push({text:obj.prdNm,value:obj.prdCd})
							
						 }
  							 
					})
					lineFindFnc(0);
					prcFindFnc(0)
					
  			 })
 			
 		})
		dialog.dialog('close');
	}
	
	addBtn.addEventListener("click",function(){
		grid.clear();
		planGrid.clear();
		insertDtlGrid.clear();
		lotGrid.clear();
		insertDtlGrid.clear();
		hiddenGrid.clear();
		grid.appendRow({})
		fetch('planNoFind')
 		.then(response=>response.json())
 		.then(result=>{
 			grid.setValue((grid.getData()[grid.getRowCount()-1]).rowKey  ,'planNo',result.planNo);
 		})
		
		grid.resetOriginData();
	})
	
	saveBtn.addEventListener("click",function(){
		console.log(dataSource);
		grid.blur();//커서 인풋밖으로빼냄
		planGrid.blur();//커서 인풋밖으로빼냄
		hiddenGrid.blur();//커서 인풋밖으로빼냄
		let msg='';
		//////////////////////////////////////////////////////////////////
		let flag=0;
		let flag1=0;
		for(obj of planGrid.getData()){
			if(obj.workStrDate==''||obj.workStrDate==null||obj.workEndDate==''||obj.workEndDate==null){
				flag=1;
			}
			else if(obj.instrCnt==''||obj.instrCnt==null||obj.needCnt==''||obj.needCnt==null){
				flag1=1;
			}
		}
		
		if(grid.getValue(grid.getData(grid.getRowCount()-1)[0].rowKey,'dueDate')==null||grid.getValue(grid.getData(grid.getRowCount()-1)[0].rowKey,'dueDate')==''){
			alert('납기일자를 입력해주세요')
		}
		else if(flag1==1){
			alert('수량을 입력해주세요')
		} 
		else if(flag==1){
			alert('시작일자 또는 종료일자를 입력해주세요')
		} 
		else if(document.querySelectorAll('#mtrSelect>option').length-1>hiddenGrid.getData().length){
			alert('자재계획을 입력해주세요')
		} 
		else if(document.querySelectorAll('#prcSelect>option').length-1>insertDtlGrid.getData().length){
			alert('제품계획을 입력해주세요')
		} 
		else{
	   		let lineData={}
			lineData.lineNo=planGrid.getValue(planGrid.getData()[0].rowKey,'lineNo');
			fetch('slectDate',{
				method:'POST',
				headers:{
					"Content-Type": "application/json",
				},
				body:JSON.stringify(lineData)
			})
			.then(response=>response.json())
			.then(result=>{
				
				fetch("planDateCal",{
					method:'POST',
					headers:{
						"Content-Type": "application/json",
					},
					body:JSON.stringify(planGrid.getData()[0])
				})
				.then(response=>response.json())
				.then(dateResult=>{
					let resultDate=result.map(ev=>{
						return ev.workStrDate;
					})
					let dateResultDate=dateResult.map(ev=>{
						return ev.workStrDate;
					})
					let uniqueDate=dateResultDate.filter(x=>{
						if(!resultDate.includes(x)){
							return x;
						}
						});
					fetch('updFind/'+planGrid.getData()[0].lineNo)
					.then(response=>response.json())
					.then(x=>{
						let upd=x.upd;
						for(a of uniqueDate){
							let object={}
							object.uphPdtAmt=upd;
							object.workStrDate=a;
							console.log(object);
							result.push(object);
						}
						result=result.sort((a,b)=>{
							return a.workStrDate<b.workStrDate ? -1:1;
						})
						console.log(result);
						for(obj of result){//생산가능수량
							//시작~끝  
							for(date of dateResult){  //날짜~  
								if(obj.uphPdtAmt*1<planGrid.getValue(planGrid.getData()[0].rowKey,'instrCnt')*1 && obj.workStrDate==date.workStrDate){
									obj.uphPdtAmt//그날생산수량
									obj.workStrDate//해당일
									msg +=(obj.workStrDate).substring(0,10)+'일의 생산 가능수량은' +obj.uphPdtAmt+'개입니다\n'
								}
							}
						}
						return msg;
					})
					.then(msg=>{
						if(msg!=''){
							
							alert(msg);
						}
						else{
							let planInsertData={};
							planInsertData.plan=grid.getData();     //메인그리드 생산계획 데이터
							planInsertData.detail=insertDtlGrid.getData(); //플랜그리드 디테일 데이터
							planInsertData.lot=hiddenGrid.getData();					//히든그리드 자재정보 데이터
							
							
							fetch('planDtlInsert',{
								method:'POST',
								headers:{
									"Content-Type": "application/json",
								},
								body:JSON.stringify(planInsertData)
							})
							.then(result=>{
								alert("계획등록 완료!")
								
							})
	/* 						grid.clear();
							planGrid.clear();
							insertDtlGrid.clear();
							lotGrid.clear();
							insertDtlGrid.clear();
							hiddenGrid.clear(); */
							disabledDays.length=0;
						}
	
					})
				})
			})
			
			
		}
		
		
		

	})
	
 	delBtn.addEventListener("click",function(){
 		planGridNeedCnt=0;
		lotGrid.setValue(0,'hldCnt',0)
		grid.clear();
		planGrid.clear();
		insertDtlGrid.clear();
		lotGrid.clear();
		insertDtlGrid.clear();
		hiddenGrid.clear();
		$('#prcSelect').empty()
		$('#mtrSelect').empty()
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
		tableTag.border=1;
		let tHeadTag=document.createElement('thead');
		let thTag=document.createElement('th');
		thTag.innerHTML='주문번호';
		tHeadTag.appendChild(thTag);
		thTag=document.createElement('th');
		thTag.innerHTML='업체코드';
		thTag.setAttribute('class','thTag')
		tHeadTag.appendChild(thTag);
		tHeadTag.setAttribute('class','tHeadTag')
		tableTag.appendChild(tHeadTag);
		let tBodyTag=document.createElement('tbody');
		for(let obj of result){
		let i=0;
			let trTag=document.createElement("tr");
			trTag.setAttribute('class','trTag')
			let tdTag=document.createElement("td");
			tdTag.innerHTML=obj.ordShtNo;
			tdTag.setAttribute('class','tdTag')
			tdTag.setAttribute("data-ord-id",obj.ordShtNo);
			tdTag.setAttribute("onClick","ordFnc(event)");
			trTag.appendChild(tdTag);
			let tdTag1=document.createElement("td");
			tdTag1.setAttribute('class','tdTag');
			tdTag1.setAttribute("data-ord-id",obj.ordShtNo);
			tdTag1.setAttribute("onClick","ordFnc(event)");
			tdTag1.innerHTML=obj.compCd;					
			trTag.appendChild(tdTag1);
			tBodyTag.appendChild(trTag);
			tableTag.appendChild(tBodyTag);
			i++;
		}
		document.getElementById('dialog-form').appendChild(tableTag);
	})
}

//////////////////////안전재고
 //주문서검색 모달창
	let safeDialog = $( "#safe-dialog-form" ).dialog({
		autoOpen: false,
		modal:true,
		//buttons:{"save":function(){alert("save")}}
	});
	
	
	safeStckBtn.addEventListener('click',ev=>{
		fetch('safeStckView')
		.then(response=>response.json())
		.then(result=>{
			console.log(result);
			safeDialog.dialog( "open" );
		  	safeGrid.refreshLayout();
	    	safeGrid.resetData(result);
		
	    	
	    	
	    	return result;
			
		})
	})	
	
	//그리드 생성
	safeGrid = new Grid({
		el: document.getElementById('safe-dialog-form'),
		data:null,		
		scrollY:true,
		minBodyHeight : 150,
		bodyHeight : 350,
		columns:[{
			header : '제품코드',
			name : 'prdCd',
			align: 'center',
		},{
			header : '필요수량',
			name : 'needCnt',
			align: 'right',
		}],
	}); 
	safeGrid.on('click',ev=>{
		console.log(safeGrid.getRow(ev.rowKey))
		grid.resetData([safeGrid.getRow(ev.rowKey)]);
		planGrid.resetData([safeGrid.getRow(ev.rowKey)]);
		fetch('planNoFind')
 		.then(response=>response.json())
 		.then(result=>{
 			grid.check((grid.getData()[grid.getRowCount()-1]).rowKey);
 			grid.setValue((grid.getData()[grid.getRowCount()-1]).rowKey  ,'planNo',result.planNo);
 			planGrid.setValue((grid.getData()[grid.getRowCount()-1]).rowKey  ,'planNo',result.planNo);
 			planGrid.setValue((grid.getData()[grid.getRowCount()-1]).rowKey,'prdCd',safeGrid.getValue(ev.rowKey,'prdCd'));
 			planGrid.setValue((grid.getData()[grid.getRowCount()-1]).rowKey,'needCnt',safeGrid.getValue(ev.rowKey,'needCnt'));

 		}).then(()=>{
 			lineFindFnc(ev.rowKey)
 		})
 		safeDialog.dialog('close');
		
		
	})
	
	planGrid.on('click',ev=>{
		if(ev.columnName=='prdCd'){
			 fetch('prdCdFind')
			.then(response=>response.json())
			.then(result=>{
				 planColumns[0].editor.options.listItems.length=0;
				 for(let obj of result){
					planColumns[0].editor.options.listItems.push({text:obj.prdNm,value:obj.prdCd})
				 }
				 
			})
		}
 		if(ev.columnName=='workStrDate' || ev.columnName=='workEndDate'){
 			
 			//////////////////////////////////
 			$( function() {
 			    $( "#datepicker" ).datepicker({
 			    	dateFormat:"yy-mm-dd",
 	  			      regional:"ko",
 	  			      beforeShowDay: disableAllTheseDays

 			    });
 			  } );
 		}
/* 		if(ev.columnName=='lineNo'){
			//planGrid.resetData([{}]);
	 		fetch("lineNoFind/"+planGrid.getValue(ev.rowKey,'prdCd'))
	 		.then(response=>response.json())
	 		.then(result=>{
	 			i=0
	 			planColumns[1].editor.options.listItems.length=0;
	 			for(obj of result){
		 			planColumns[1].editor.options.listItems[i]={text:obj.lineNo,value:obj.lineNo}
					i++;	 				
	 			}

	 		})
	 				
	 				
	 		
		} */
	})
	
		// 특정날짜들 배열
	let disabledDays = [];
	// 특정일 선택막기
	function disableAllTheseDays(date) {
	    var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
	    for (i = 0; i < disabledDays.length; i++) {
	        if($.inArray(y + '-' +(m+1) + '-' + d,disabledDays) != -1) {
	            return [false];
	        }
	    }
	    return [true];
	}
	
	//상품코드 공정코드로 자재목록 불러오기
	prcSelect.addEventListener('change',ev=>{
		
		lotDiv.style="display:block";
		lotGrid.clear()
		lotGrid.refreshLayout();
		if(ev.target.value!='라인선택'){
			fetch("findBomList/"+ev.target.getAttribute('data-id')+'/'+ev.target.value+'/'+'select')
				.then(response=>response.json())
				.then(result=>{
					console.log(result)
					$("#mtrSelect").empty()
					let optionTag=document.createElement('option')
					optionTag.value='--자재선택--'
					optionTag.innerHTML='--자재선택--'
					document.getElementById('mtrSelect').appendChild(optionTag)
					for(obj of result){
						
						let optionTag=document.createElement('option');
						optionTag.value=obj.mtrCd
						optionTag.innerHTML=obj.mtrCd
						document.getElementById('mtrSelect').setAttribute('data-id',obj.prdCd)
						document.getElementById('mtrSelect').setAttribute('data-prc',obj.prcCd)
						document.getElementById('mtrSelect').appendChild(optionTag)
						
					}
					
					//lotGrid.resetData(result);
					//insertPrcCd=planGrid.getValue(ev.rowKey,'prcCd');
					inserMtrLot=ev.rowKey;
					return result;
				}).then(()=>{
					let createData=planGrid.getModifiedRows().createdRows;		
					let updateData=planGrid.getModifiedRows().updatedRows;
					for(obj of createData){
						obj.prcCd=ev.target.value;
					}	
					for(obj of updateData){
						obj.prcCd=ev.target.value;
					}	
					let i =0;
					let result;
					if(createData!=''){
						result=createData
					}else{
						result=updateData
					}
					console.log("aaaaaaaaaaaaaaaaa")
					console.log(planGrid.getRow(planGridRowKey))
					let planData =planGrid.getRow(planGridRowKey);
					planData.prcCd=ev.target.value;
					console.log(insertDtlGrid.getData())
					for(a of insertDtlGrid.getData()){
						if(planData.prcCd==a.prcCd&&planData.prdCd==a.prdCd){
							i=1;
						}
						
					}
					let prcSelect=document.getElementById('prcSelect').value;
					if(i==0&&prcSelect!='--공정선택--'){
						planData.rowKey=insertDtlGrid.getRowCount()-1;
						insertDtlGrid.appendRow(planData);
						//lotGridUseAmt=lotGrid.getData()[0].useAmt;
					}
					for(obj of hiddenGrid.getData()){
						if(obj.hldCnt=='0'){
							hiddenGrid.removeRow(obj.rowKey);
						}
					}
					
					console.log(ev)
					planGridNeedCnt=planGrid.getValue(ev,'instrCnt')
					lotGrid.setValue(0,'hldCnt',0)
				})
			
		}
	})
	
	
	
	////////lPad ////////
	function lpad(str,padLen,padStr){
		str+="";
		padStr+="";
		while(str.length<padLen)
			str=padStr+str;
		str=str.length>=padLen ? str.substring(0,padLen) : str;
		return str;
	}
// lpad("01",5,"0") // 00001	

//plan 그리드 행추가
	planGriaAddRow.addEventListener('click',ev=>{
		if(grid.getValue(0,'ordShtNo')!='null'){
  			
  		 }
		//document.getElementById('lotDiv').style='display:none';
		planGrid.appendRow([{}]);
		planGrid.setValue(planGrid.getData()[planGrid.getRowCount()-1].rowKey,'planNo',grid.getData()[0].planNo);
		fetch('prdCdFind')
		.then(response=>response.json())
		.then(result=>{
			 //planGrid.resetData(result)
			 console.log(result)
			 let i=0
			 planColumns[0].editor.options.listItems.length=0
			 for(let obj of result){
				 planColumns[0].editor.options.listItems[i]={text:obj.prdNm,value:obj.prdCd}
				 i++;
			 }
			 planGrid.setValue(planGrid.getRowCount()-1,'prdCd',result[0].prdCd)
			 planGrid.setValue(planGrid.getRowCount()-1,'prdNm',result[0].prdNm)
			 lineFindFnc(planGrid.getRowCount()-1);
			 prcFindFnc(planGrid.getRowCount()-1)
		})
	})

	lotGrid.on('editingFinish',ev=>{
		let modiData = lotGrid.getModifiedRows().updatedRows;
		let modiList=[];
		let prcSelect=document.getElementById('prcSelect');
		
		for(obj of modiData){
			obj.planNo=grid.getData()[0].planNo;
			obj.lineNo=insertLineNo;
			obj.prcCd=prcSelect.value;
			console.log(obj);
			modiList.push(obj);
		}
		let lotData1=lotGrid.getRow(ev.rowKey);
		lotData1.planNo=grid.getData()[0].planNo;
		lotData1.lineNo=planGrid.getData()[0].lineNo;
		let i = 0;
		for(z=0 ; z<hiddenGrid.getData().length ; z++){
			if(lotData1.mtrLot == hiddenGrid.getData()[z].mtrLot && lotData1.prdCd == hiddenGrid.getData()[z	].prdCd){
				i=1
			}
		}
		
			
		
		console.log("여기")
		console.log(lotData1)
		if(i==0){
			hiddenGrid.appendRows([lotData1]);
		}
		
		
		let hiddenGetData=hiddenGrid.getData();
		let m=0;
		let hiddenInsertData =hiddenGetData.map(x=>{
			if(lotData1.mtrLot == x.mtrLot && lotData1.prdCd == x.prdCd){
				lotData1.rowKey=m;
				m++;
				return lotData1;
			}
			else{
				x.rowKey=m;
				m++;
				return x;
			}
		})
		
		hiddenGrid.resetData(hiddenInsertData)
	})
	
	
	function planGridBlur(){
		
		planGrid.blur();
		
	}
	function lineFindFnc(ev){
		fetch("lineNoFind/"+planGrid.getValue(ev,'prdCd'))
 		.then(response=>response.json())
 		.then(result=>{
 			let i=0;
 			console.log(result)
 			planGrid.setValue(planGrid.getData()[0].rowKey,'uphPdtAmt',result[0].uphPdtAmt)
 			planColumns[2].editor.options.listItems.length=0;
			for(obj of result){
				console.log(obj)
				planColumns[2].editor.options.listItems[i]={text:obj.lineNo,value:obj.lineNo}
				//planColumns[0].editor.options.listItems.push({text:obj.lineNo,value:obj.lineNo})
 				//planColumns[3].editor.options.listItems[i]={text:obj.lineNo,value:obj.lineNo}
				i++;
			}
 			planGrid.setValue(ev,'lineNo',result[0].lineNo)
 			for(let i=0; i<planColumns[0].editor.options.listItems.length ;i++){
 				if(planColumns[0].editor.options.listItems[i].value==planGrid.getValue(ev,'prdCd')){
 					planGrid.setValue(ev,'prdNm',planColumns[0].editor.options.listItems[i].text);
 					
 				}
 			}
 			prcFindFnc(ev)
			
 		})
	}
	function prcFindFnc(ev){
			planGridRowKey=ev;
			disabledDays.length=0;
				insertLineNo=planGrid.getValue(ev,'lineNo');
 			fetch('lotLineFind/'+planGrid.getValue(ev,'lineNo'))
 			.then(response=>response.json())
 			.then(result=>{
 				planGridNeedCnt=planGrid.getRow(ev).needCnt;
 				let i=0;
					planColumns[3].editor.options.listItems.length=0;
					$('#prcSelect').empty();
					let prcSelect=document.getElementById('prcSelect');
					prcSelect.setAttribute('data-id',planGrid.getValue(ev,'prdCd'));
				let optionTag=document.createElement('option');
				optionTag.value='--공정선택--';
				optionTag.innerHTML='--공정선택--';
				prcSelect.appendChild(optionTag);
 				for(obj of result){
 					let prcSelect=document.getElementById('prcSelect');
 					prcSelect.setAttribute('data-id',planGrid.getValue(ev,'prdCd'));
					let optionTag=document.createElement('option');
					optionTag.value=obj.prcCd;
					optionTag.innerHTML=obj.prcNm;
					prcSelect.appendChild(optionTag);
	 				//planColumns[2].editor.options.listItems.push({text:obj.prcCd,value:obj.prcCd})

	 				i++;
 				}
 				
 				console.log("dd여기")
 				console.log(ev)
 				///////////////////지시불가능날짜 불러오기
 	    		let lineData={}
 	 			lineData.lineNo=insertLineNo;
 				console.log(insertLineNo)
 	 			fetch('slectDate',{
 	 				method:'POST',
 	 				headers:{
 	 					"Content-Type": "application/json",
 	 				},
 	 				body:JSON.stringify(lineData)
 	 			})
 	 			.then(response=>response.json())
 	 			.then(result=>{
 	 					console.log(result)
 	 				for(obj of result){
 	 					if(obj.uphPdtAmt<=0){
	 	 					disabledDays.push((obj.workStrDate).substring(0,10).replaceAll("-0","-"))
 	 					}
 	 					
 	 				}
 	 				console.log(disabledDays);

 	 			})
 				
 			})
	}
	
	mtrSelect.addEventListener('change',ev=>{
		if(ev.target.value!='자재선택'){
			fetch("addPlanLotSelect/"+ev.target.getAttribute('data-id')+'/'+ev.target.getAttribute('data-prc')+'/'+ev.target.value)
				.then(response=>response.json())
				.then(result=>{
										
					lotGrid.resetData(result);
				}).then(()=>{
					
					planGridNeedCnt=planGrid.getValue(ev,'instrCnt')
					lotGrid.setValue(0,'hldCnt',0)
					lotGridUseAmt=lotGrid.getData()[0].useAmt
				})
			
		}
	})
	insertDtlGrid.on('click',ev=>{
		lotGrid.clear()
		for(obj of hiddenGrid.getData()){
			if(insertDtlGrid.getValue(ev.rowKey,'prcCd')==obj.prcCd){
				obj.rowKey=lotGrid.getRowCount()-1;
				lotGrid.appendRow(obj);
			}
			
		}
		
		
	})
	
	
	
	</script>

</body>
</html>