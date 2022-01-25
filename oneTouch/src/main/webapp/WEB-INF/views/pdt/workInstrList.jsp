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
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/template/json.min.js"></script>
</head>
<body>
	
	<button type="button" id="planModal" name="planModal">생산계획조회</button>
	<div id="workGrid"></div>
	<button type="button" id="prcSelectBtn" name="prcSelectBtn">공정조회</button>
	<div>ㅁㅁ</div>
	<div id="prcDtlGrid"></div>
	<button type="button" id="workAddBtn" name="workAddBtn">지시추가</button>
	<div id="plan-dialog-form" title="생산계획조회">
		<div>생산계획 조회</div>
		<select id="planCheck">
			<option value="N">미지시</option>
			<option value="Y">지시완료</option>
		</select>
		<button id="modalSearchBtn" name="modalSearchBtn">조회</button>
	</div>
	<div id="date-dialog-form" title="생산지시일정">생산지시 일정선택</div>
	<div id="hiddenGrid"></div>
	<div id="hiddenMainDiv"></div>
	<div id="hiddenModalMain"></div>
	<button type="button" id="modifyBtn" name="modifyBtn">지시등록</button>
	<button type="button" id="addRow">행추가</button>
	<button type="button" id="resetGrid">초기화</button>
	
	
	<script>
		let main2Grid;
		let Grid = tui.Grid;
		let planAll ;
		let prcResult;
		let selectPlanDtlNo;
		let setTimeCheck;
		let selectInstrDate;
		let hiddenMainGrid;
		let mainHiddenDiv=document.getElementById('hiddenMainDiv');
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
		Grid.setLanguage('ki',{
			net:{
				noDataToModify:'필수입력사항을 입력해주세요'
			}
		})
		
		let mainDataSource={
				api:{
					readData:{url:'planDtlList',
						method:'GET',
						},
				  	modifyData:{url:'./workInsert',method:'POST'},  
				},
				contentType:'application/json'
			} 
		//메인 그리드 컬럼 설정	
		const mainColumns = [{
			header : '제품번호',
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
			header : '계획번호',
			name : 'planNo'
		},{
			header : '지시번호',
			name : 'instrNo' 
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
		},{
			header : '라인번호',
			name : 'lineNo',
			editor:'text'
		},{
			header : '공정번호',
			name : 'prcCd',
			editor : 'text'
		},{
			header : '필요수량',
			name : 'needCnt',
			editor : 'text'
		},{
			header : '지시수량',
			name : 'instrCnt',
			editor : 'text'
		},{
			header : '작업지시일',
			name : 'instrDate',
			editor:'datePicker'
		},{
			header : '지시완료일',
			name : 'pdtFinDate',
			editor:'datePicker'
		},{
			header : '지시타임',
			name : 'workStrTime',
			hidden : false
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
		
		
		///////////////////공정그리드 메인3//////////////////////
		let prcDataSource={
				api:{
					readData:{url:'.',
						method:'GET'}
		
				 /* 	modifyData:{url:'./pdtOrdlist',method:'PUT'},  */
				},
				contentType:'application/json'
			} 
 		
		//공정그리드 컬럼 설정	
		let prcColumns = [
			
		{
			header : '라인번호',
			name : 'lineNo',
			
		},{
			header : '공정코드',
			name : 'prcCd',
			hidden : false
			
		},{
			header : '자재코드',
			name : 'mtrCd',
			hidden : false
		},{
			header : 'Lot번호',
			name : 'mtrLot',
			hidden : false
		},{
			header : '사용수량',
			name : 'hldCnt',
			hidden : false,
	  		editor : 'text'
		},{
			header : '재고수량',
			name : 'stckCnt',
			hidden : false,
			editor : 'text'
		},{
			header : '사용가능수량',
			name : 'realCnt',
			hidden : false,
		},{
			header : '지시번호',
			name : 'instrNo'
		},{
			header : '지시일자',
			name : 'instrDate',
			hidden : false
		}];
 		
		//그리드 생성
		let prcGrid = new Grid({
			  el: document.getElementById('prcDtlGrid'),
			  data:prcDataSource,
			  rowHeaders:['checkbox'],
			  columns:prcColumns,
			  columnOptions: {
				  frozenCount :11,
				  frozenBorderWidth:1
			  }
		});
		
		
		///////////////모달그리드/////////////////
 		let modalDataSource={
				api:{
					readData:{url:'.',
						method:'GET'}
				 /* 	modifyData:{url:'./pdtOrdlist',method:'PUT'},  */
				},
				contentType:'application/json'
			} 
 		
		//모달 그리드 컬럼 설정	
		let modalColumns = [{
			header : '지시번호',
			name : 'instrNo'
		},{
			header : '계획번호',
			name : 'planNo'
		},{
			header : '작업우선순위',
			name : 'workProt'
		},{
			header : '작업지시일',
			name : 'instrDate',
			editor:'datePicker'
		},{
			header : '지시완료일',
			name : 'pdtFinDate',
			editor:'datePicker'
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
				console.log(modalGrid.getCheckedRows()[0])
				fetch('planDtlList/'+modalGrid.getCheckedRows()[0].planNo)
				.then(response=>response.json())
				.then(result=>{
					console.log(result);
				})
				//modalGrid.getModifiedRows().updatedRows // 모달 지시 마스터 데이터
				
				
				
				/* fetch('workInsert',{
					method:'POST',
					headers:{
						"Content-Type": "application/json",
					},
					body:JSON.stringify(modalGrid.getRow(modalGrid.getCheckedRows()[0]))
				})
				alert("save"); */
				modalDialog.dialog('close');
				//modalGrid.readData();	
			}}
		
		});
		
		document.getElementById("planModal").addEventListener("click",()=>{
			modalDialog.dialog( "open" );
			modalGrid.refreshLayout();
			planListSelect();
		})
		
		//일정선택 모달창
		let dateDialog = $( "#date-dialog-form" ).dialog({
			autoOpen: false,
			modal:true,
			height: 500,
			width: 1000,
			buttons:{"save":function(){
				console.log(inputTime.value);
				prcGrid.setValue(setTimeCheck,'workStrTime',inputTime.value);
				dateDialog.dialog('close');
				alert("save");
				//modalGrid.readData();	
			}}
		
		});
		let inputTime=document.createElement('select');
		inputTime.type="select";
		inputTime.id="planTime";
		inputTime.name="planTime";
		for(i=1;i<4;i++){
			let optionTag=document.createElement('option');
			optionTag.value=i;
			optionTag.innerHTML=i+'파트';
			inputTime.appendChild(optionTag);
		}
		document.getElementById('date-dialog-form').appendChild(inputTime);
		//////////////////////////////히든그리드////////////////////////////////////
		
		let hiddenDataSource={
			api:{
				readData:{url:'.',
					method:'GET'}
			 /* 	modifyData:{url:'./pdtOrdlist',method:'PUT'},  */
			},
			contentType:'application/json'
		} 
 		
		//그리드 컬럼 설정	
		let hiddenColumns = [
			{
				header : '라인번호',
				name : 'lineNo',
				
			},{
				header : '공정코드',
				name : 'prcCd',
				hidden : false
			},{
				header : '자재코드',
				name : 'mtrCd',
				hidden : false
			},{
				header : 'Lot번호',
				name : 'mtrLot',
				hidden : false
			},{
				header : '홀딩수량',
				name : 'hldCnt',
				hidden : false,
		  		editor : 'text'
			},{
				header : '재고수량',
				name : 'stckCnt',
				hidden : false
			},{
				header : '지시번호',
				name : 'instrNo'
			},{
				header : '지시일자',
				name : 'instrDate',
				hidden : false
			}];
 		
		//그리드 생성
		let hiddenGrid = new Grid({
			  el: document.getElementById('hiddenGrid'),
			  data:hiddenDataSource,
			  rowHeaders:['checkbox'],
			  columns:hiddenColumns,
			  columnOptions: {
				  frozenCount :11,
				  frozenBorderWidth:1
			  }
		});
		///////////////////////////////////////////////////////////////
		//계획 모달그리드  체크/클릭 이벤트
		modalGrid.on('click',ev=>{
			if(ev.columnName=='instrNo'){
				let planNo=modalGrid.getValue(ev.rowKey,'planNo')
				
				console.log(planNo)
				fetch('planDtlList/'+planNo)
				.then(response=>response.json())
				.then(x=>{
					console.log(x)
					modalGrid.setValue(ev.rowKey,'instrNo',x[0].instrNo)
					for(let obj of x){
						obj.instrDate=selectInstrDate;
						obj.pdtFinDate=finDateSave;
						obj.instrNo=abc+lpad(def,4,"0");
						console.log(obj.instrNo)
					}
					if(modalGrid.getCheckedRows().length==1){
						mainGrid.resetData(x);
					}
					else{
						mainGrid.appendRows(x);
					}
				})
			}
		})
		modalGrid.on('check',ev=>{
			console.log("aaaaaaaaaaaaaa")
			console.log(ev.columnName)
			
			selectInstrDate=modalGrid.getValue(ev.rowKey,'instrDate')			
			let finDateSave=modalGrid.getValue(ev.rowKey,'pdtFinDate')	
			console.log(modalGrid.getValue(ev.rowKey,'planNo'));
			let planNo=modalGrid.getValue(ev.rowKey,'planNo')
			fetch('planDtlList/'+planNo)
			.then(response=>response.json())
			.then(x=>{
				let startInstrNo=x[0].instrNo
				console.log(startInstrNo)
				let abc=startInstrNo.substr(0,11)
				let def=startInstrNo.substr(11,15)
				for(let obj of x){
					obj.instrDate=selectInstrDate;
					obj.pdtFinDate=finDateSave;
					obj.instrNo=abc+lpad(def,4,"0");
					console.log(obj.instrNo)
				}
				if(modalGrid.getCheckedRows().length==1){
					mainGrid.resetData(x);
					hiddenModalGrid.resetData(modalGrid.getCheckedRows())
				}
				else{
					mainGrid.appendRows(x);
					hiddenModalGrid.appendRows(modalGrid.getCheckedRows())
				}
			})
		})
		//공정조회버튼 누르면 공정정보 
		prcSelectBtn.addEventListener('click',ev=>{
			hiddenMainGrid.appendRows(mainGrid.getCheckedRows());
			instrDate=mainGrid.getValue(mainGrid.getCheckedRows()[0],'instrDate')			
			let instrNo=mainGrid.getValue(mainGrid.getCheckedRows()[0],'instrNo')
			fetch('planDtlPrc',{
				method:'POST',
				headers:{
					"Content-Type": "application/json",
				},
				body:JSON.stringify(mainGrid.getCheckedRows())
			})
			.then(response=>response.json())
			.then(result=>{
				main2Grid=result;
				prcGrid.hideColumn('mtrLot');
				prcGrid.hideColumn('hldCnt');
				prcGrid.hideColumn('stckCnt');
				prcGrid.hideColumn('mtrCd');
/* 				prcGrid.showColumn('fctNm');
				prcGrid.showColumn('fctCd'); */
				prcColumns[4].hidden=true;
				let datas=[];
				for(let obj of result){
					obj.instrDate=selectInstrDate;
					obj.instrNo=instrNo;
					datas.push(obj)
				}
				if(mainGrid.getCheckedRows().length==1){
					prcGrid.resetData(datas);
					mainGrid.uncheck(mainGrid.getRow(mainGrid.getCheckedRowKeys()[0]))
				}
				else{
					prcGrid.appendRows(datas);
				}
				
			})
		})
		//메인그리드 이벤트
		mainGrid.on("click",ev=>{
		
			
		})
		
		//메인2그리드 누르면 자재정보
		prcGrid.on("click",ev=>{
			console.log("dddd")
			console.log(prcGrid.getRow(ev.rowKey))
			prcGrid.setValue(0,'instrDate',selectInstrDate);
			let prcResult=prcGrid.getValue(ev.rowKey,'prcCd');
			console.log(prcResult);
			console.log(prcGrid.getRow(ev.rowKey))
			if(prcColumns[4].hidden){
				prcColumns[4].hidden=false;
				console.log("들어옴")
				prcGrid.showColumn('mtrLot');
				prcGrid.showColumn('hldCnt');
				prcGrid.showColumn('stckCnt');
				prcGrid.showColumn('mtrCd');
/* 				prcGrid.hideColumn('fctNm');
				prcGrid.hideColumn('fctCd'); */
				prcGrid.resetData(main2Grid);
				console.log(ev.columnName)
				console.log(mainGrid.getRow(ev.rowKey))
				mainGrid.getValue(ev.rowKey,'planDtlNo')
				/* fetch('planDtlMtr',{
					method:'POST',
					headers:{
						"Content-Type": "application/json",
					},
					body:JSON.stringify({'planDtlNo':selectPlanDtlNo})
				})
				.then(response=>response.json())
				.then(result=>{
					
					prcGrid.resetData(result);
				 	for(i=0 ; i<prcGrid.getRowCount();i++){
				 		prcGrid.setValue(i,'instrDate',selectInstrDate)
				 		console.log(prcResult)
				 		prcGrid.setValue(i,'prcCd',prcResult);
				 		prcGrid.setValue(i,'planDtlNo',selectPlanDtlNo);
				 	}
					//detailGrid.resetData(result);
				}) */
			}
			console.log(ev.columnName)
			if(ev.columnName=='workStrTime'){
				dateDialog.dialog('open');
				setTimeCheck=ev.rowKey;
			}
		})
		
		workAddBtn.addEventListener('click',ev=>{
			console.log(prcGrid.getCheckedRows());
			hiddenGrid.appendRows(prcGrid.getCheckedRows())

		})
		modifyBtn.addEventListener('click',ev=>{
			let a={};
			a.planData=hiddenModalGrid.getData();
			a.detailData=hiddenMainGrid.getData();
			a.lotData=hiddenGrid.getData()
			fetch('workInsertAll',{
				method:'POST',
				headers:{
					"Content-Type": "application/json",
				},
				body:JSON.stringify(a)
			})
		})
		
		//////////////////////////////////////이벤트/////////////////////////////////////////
		mainGrid.on("click",ev=>{
			if(ev.columnName=='prdCd'){
				fetch('prdCdFind')
				.then(response=>response.json())
				.then(result=>{
					 //planGrid.resetData(result)
					 console.log(result)
					 let i=0
					 for(let obj of result){
						 mainColumns[0].editor.options.listItems[i]={text:obj.prdCd,value:obj.prdCd}
						 i++;
					 }
					 
					 mainGrid.refreshLayout();
					 
				})
			}
			
		})
		//모달에 플랜리스트 보여주기
		function planListSelect(){
			fetch('./modalPlanList/'+document.getElementById('planCheck').value)
			.then(response=>response.json())
			.then(result=>{
				console.log(result);
				let uniQuePlan=result.map(plan=>{
					return plan.planNo;
				})
				let set=new Set(uniQuePlan)
				let planNoArr=[...set]
				Array.isArray(planNoArr)
			let resultArr=[]
			for(obj of result){
				for(arrObj of planNoArr){
					if(arrObj == obj.planNo){
						resultArr.push(obj)
						
					}
				}
			}	
			modalGrid.resetData(resultArr);
			})
		}
		modalSearchBtn.addEventListener("click",ev=>{
			planListSelect();
		})
		//////////////////////////////////////히든그리드///////////////////////////////////////
		//메인 모달 히든그리드 생산지시M
				//그리드 생성
		let hiddenModalColumns = [{
			header : '지시번호',
			name : 'instrNo'
		},{
			header : '계획번호',
			name : 'planNo'
		},{
			header : '작업우선순위',
			name : 'workProt'
		},{
			header : '작업지시일',
			name : 'instrDate',
			editor:'datePicker'
		},{
			header : '지시완료일',
			name : 'pdtFinDate',
			editor:'datePicker'
		}];
		let hiddenModalGrid = new Grid({
			  el: document.getElementById('hiddenModalMain'),
			  data:null,
			  rowHeaders:['checkbox'],
			  columns: hiddenModalColumns,
			  columnOptions: {
				  frozenCount :11,
				  frozenBorderWidth:1
			  }
		});
 		
		//메인 히든 그리드 생성
		hiddenMainGrid = new Grid({
		 el: document.getElementById('hiddenMainDiv'),
		 data:null,
		 rowHeaders:['checkbox'],
		 columns:[{
				header : '계획번호',
				name : 'planNo',
				
			},{
				header : '지시번호',
				name : 'instrNo'
			},{
				header : '납기일자',
				name : 'dueDate'
			},{
				header : '작업우선순위',
				name : 'workProt',
				editor : 'text',
			    validation : {
			    	required : false
			    },
			},{
				header : '계획일자',
				name : 'planDate'
			},{
				header : '제품번호',
				name : 'prdCd'
			},{
				header : '라인번호',
				name : 'lineNo',
				editor:'text'
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
				name : 'instrDate'
			},{
				header : '지시완료일',
				name : 'pdtFinDate'
			},{
				header : '지시타임',
				name : 'workStrTime',
				hidden : false
			}],
		 columnOptions: {
		  frozenCount :11,
		  frozenBorderWidth:1
 }
		});
		
		
		
		
		addRow.addEventListener("click",ev=>{
			mainColumns[0].editor.options.listItems[i]={text:obj.prdCd,value:obj.prdCd}
			mainGrid.appendRow();
			mainGrid.disableColumn('planDtlNo')
			mainGrid.enableColumn('planDtlNo')
		})
		resetGrid.addEventListener("click",ev=>{
			
			for(i=0;i<mainGrid.getData().length;i++){
				mainGrid.removeRow(i);
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
	</script>
	
</body>
</html>