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
	<div id="prcDtlGrid"></div>
	<div id="workDtlGrid"></div>
	<div id="plan-dialog-form" title="생산계획조회">생산계획 조회</div>
	<div id="date-dialog-form" title="생산지시일정">생산지시 일정선택</div>
	<script>
		let Grid = tui.Grid;
		let planAll ;
		let prcResult;
		let selectPlanDtlNo;
		let setTimeCheck;
		
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
					readData:{url:'.',
						method:'GET'}
				 /* 	modifyData:{url:'./pdtOrdlist',method:'PUT'},  */
				},
				contentType:'application/json'
			} 
		//메인 그리드 컬럼 설정	
		const mainColumns = [{
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
		//디테일그리드생성
			let detailDataSource={
			api:{
				readData:{url:'./findWorkList',
					method:'GET'}
			 /* 	modifyData:{url:'./pdtOrdlist',method:'PUT'},  */
			},
			contentType:'application/json'
		} 
		//메인3그리드 컬럼 설정	
		const detailColumns = [{
			header : '계획번호',
			name : 'instrDtlNo',
			hidden : true
		}];
		
		let detailGrid = new Grid({
			  el: document.getElementById('workDtlGrid'),
			  data:null,
			  rowHeaders:['checkbox'],
			  columns:detailColumns,
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
			header : '설비종류',
			name : 'fctNm',
			
		},{
			header : '설비코드',
			name : 'fctCd',
			
		},{
			header : '공정코드',
			name : 'prcCd',
			hidden : true
			
		},{
			header : '자재코드',
			name : 'mtrCd',
			hidden : true
		},{
			header : 'Lot번호',
			name : 'mtrLot',
			hidden : true
		},{
			header : '홀딩수량',
			name : 'hldCnt',
			hidden : true,
	  		editor : 'text'
		},{
			header : '재고수량',
			name : 'stckCnt',
			hidden : true
		},{
			header : '계획디테일번호',
			name : 'planDtlNo',
			hidden : true
		},{
			header : '일정선택',
			name : 'selectDate',
			hidden : true
		},{
			header : '지시일자',
			name : 'workStrDate',
			hidden : false
		},{
			header : '지시타임',
			name : 'workStrTime',
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
 		
		//그리드 컬럼 설정	
		let modalColumns = [{
			header : '계획번호',
			name : 'planNo'
		},{
			header : '홀딩수량',
			name : 'hldCnt'
		},{
			header : '',
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
				//modalGrid.readData();	
			}}
		
		});
		
		document.getElementById("planModal").addEventListener("click",()=>{
			modalDialog.dialog( "open" );
			fetch('./modalPlanList')
			.then(response=>response.json())
			.then(result=>{
				console.log(result);
				let uniQuePlan=result.map(plan=>{
					return plan.planNo;
				})
				
				let set=new Set(uniQuePlan)
				let planNoArr=[...set]
				Array.isArray(planNoArr)
			
			for(obj of result){
				for(arrObj of planNoArr){
					if(arrObj == obj.planNo){
						modalGrid.appendRow(obj);
					}
				}
			}	
			/* let uniquePrcCd=result.map(x=>{
				return x.prcCd;
			})
			let set = new Set(uniquePrcCd);
			let uniqueArr=[...set];
			Array.isArray(uniqueArr)
			console.log(result) */
				
				
			})
		})
		
		//일정선택 모달창
		let dateDialog = $( "#date-dialog-form" ).dialog({
			autoOpen: false,
			modal:true,
			height: 500,
			width: 1000,
			buttons:{"save":function(){
				prcGrid.setValue(setTimeCheck,'workStrDate',inputStart.value);
				prcGrid.setValue(setTimeCheck,'workStrTime',inputTime.value);
				dateDialog.dialog('close');
				alert("save");
				//modalGrid.readData();	
			}}
		
		});
		let inputStart=document.createElement('input');
		inputStart.type="date";
		inputStart.id="sDate";
		inputStart.name="sDate";
		document.getElementById('date-dialog-form').appendChild(inputStart);
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
		//////////////////////////////////////////////////////////////////
		
		// 모달그리드 체크선택 확인
		modalGrid.on('check',ev=>{
			console.log(modalGrid.getValue(ev.rowKey,'planNo'));
			let planNo=modalGrid.getValue(ev.rowKey,'planNo')
			fetch('planDtlList/'+planNo)
			.then(response=>response.json())
			.then(x=>{
				mainGrid.appendRows(x);
			})
			modalDialog.dialog('close');
		})
		//메인그리드 누르면 공정정보 
		mainGrid.on("click",ev=>{
			selectPlanDtlNo=mainGrid.getValue(ev.rowKey,'planDtlNo')
			console.log(ev.columnName)
			console.log(mainGrid.getRow(ev.rowKey))
			mainGrid.getValue(ev.rowKey,'prcCd')
			fetch('planDtlPrc',{
				method:'POST',
				headers:{
					"Content-Type": "application/json",
				},
				body:JSON.stringify(mainGrid.getRow(ev.rowKey))
			})
			.then(response=>response.json())
			.then(result=>{
				console.log(result);
				prcGrid.hideColumn('mtrLot');
				prcGrid.hideColumn('hldCnt');
				prcGrid.hideColumn('stckCnt');
				prcGrid.hideColumn('mtrCd');
				prcGrid.hideColumn('planDtlNo');
				prcGrid.hideColumn('selectDate');
				prcColumns[1].hidden=true;
				prcGrid.resetData(result);
			})
			
		})
		
		//메인2그리드 누르면 자재정보
		prcGrid.on("click",ev=>{
			let prcResult=prcGrid.getValue(ev.rowKey,'prcCd');
			if(prcColumns[1].hidden){
				prcColumns[1].hidden=false;
				console.log("들어옴")
				prcGrid.showColumn('mtrLot');
				prcGrid.showColumn('hldCnt');
				prcGrid.showColumn('stckCnt');
				prcGrid.showColumn('mtrCd');
				prcGrid.showColumn('planDtlNo');
				prcGrid.showColumn('selectDate');
				
				console.log(ev.columnName)
				console.log(mainGrid.getRow(ev.rowKey))
				mainGrid.getValue(ev.rowKey,'planDtlNo')
				fetch('planDtlMtr',{
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
				 		prcGrid.setValue(i,'prcCd',prcResult);
				 		prcGrid.setValue(i,'planDtlNo',selectPlanDtlNo);
				 	}
					//detailGrid.resetData(result);
				})
			}
			console.log(ev.columnName)
			if(ev.columnName=='selectDate'){
				dateDialog.dialog('open');
				setTimeCheck=ev.rowKey;
		}
		})
		
		
	</script>
	
</body>
</html>