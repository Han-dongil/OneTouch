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
	<button type="button" id="modifyBtn" name="modifyBtn">저장</button>
	<button type="button" id="resetGrid">초기화</button>
	<div id="workGrid"></div>
	<div class="row">
		<div id="prcDtlGrid" class="col-9"></div>
		<div id="hiddenGrid" style="display:block" class="col-3"></div>
	</div>
	<div id="plan-dialog-form" title="생산계획조회">
		<div>생산계획 조회</div>
		<select id="planCheck">
			<option value="N">미지시</option>
			<option value="Y">지시완료</option>
		</select>
		<button id="modalSearchBtn" name="modalSearchBtn">조회</button>
	</div>
	<div id="date-dialog-form" title="생산지시일정">생산지시 일정선택</div>
	<div id="hiddenMainDiv" style="display:none"></div>
	<div id="hiddenModalMain" style="display:none"></div>
	
	
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
/////////////////////////////////////////////////////////////////////////
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
		class prdEditor{
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
 
		
///////////////////////////////////////////////////////////////////////////		
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
		const mainColumns = [
			{
				header : '제품코드',
				name : 'prdCd'
			}
/* 			{
	    	header: '제품코드',
	        name: 'prdCd',
	        align:'center',
	        editor:{
	          type:prdEditor,
	          options:{
	            listItems:[
	            ]
	          }
	        },
	        rederer:{
	          type:abc
	        }
	      } */
		,{
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
			hidden:true
		},{
			header : '계획일자',
			name : 'planDate',
			hidden : true
		},{
			header : '라인번호',
			name : 'lineNo',
			editor:'text'
		},{
			header : '공정번호',
			name : 'prcCd',
		},{
			header : '필요수량',
			name : 'needCnt',
		},{
			header : '지시수량',
			name : 'instrCnt',
		},{
			header : '작업지시일',
			name : 'instrDate',
		},{
			header : '지시완료일',
			name : 'pdtFinDate',
			editor:'datePicker',
			hidden:true
		},{
			header : '지시타임',
			name : 'workStrTime',
			hidden : true
		}];

		
		//그리드 생성
		let mainGrid = new Grid({
			  el: document.getElementById('workGrid'),
			  data:mainDataSource,
			  columns:mainColumns,
			  scrollY:true,
			  minBodyHeight : 250,
			  bodyHeight : 250,
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
			hidden : true
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
			name : 'instrNo',
			hidden : true
		},{
			header : '지시일자',
			name : 'instrDate',
			hidden : true
		}];
 		
		//그리드 생성
		let prcGrid = new Grid({
			  el: document.getElementById('prcDtlGrid'),
			  data:prcDataSource,
			  columns:prcColumns,
			  scrollY:true,
			  minBodyHeight : 250,
			  bodyHeight : 250,
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
			editor:'datePicker',
			hidden : true
		}];
 		
		//그리드 생성
		let modalGrid = new Grid({
			  el: document.getElementById('plan-dialog-form'),
			  data:modalDataSource,
			  rowHeaders:['checkbox'],
			  columns:modalColumns,
			  scrollY:true,
			  minBodyHeight : 250,
			  bodyHeight : 250,
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
				hidden : true
				
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
				hidden : false
			},{
				header : '사용수량',
				name : 'hldCnt',
				hidden : false,
		  		editor : 'text'
			},{
				header : '재고수량',
				name : 'stckCnt',
				hidden : true
			},{
				header : '지시번호',
				name : 'instrNo',
				hidden : true
			},{
				header : '지시일자',
				name : 'instrDate',
				hidden : true
			}];
 		
		//그리드 생성
		let hiddenGrid = new Grid({
			  el: document.getElementById('hiddenGrid'),
			  data:hiddenDataSource,
			  columns:hiddenColumns,
			  scrollY:true,
			  minBodyHeight : 250,
			  bodyHeight : 250,
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
			modalGrid.blur();
			
			selectInstrDate=modalGrid.getValue(ev.rowKey,'instrDate')			
			console.log(modalGrid.getValue(ev.rowKey,'planNo'));
			let planNo=modalGrid.getValue(ev.rowKey,'planNo')
			fetch('planDtlList/'+planNo)
			.then(response=>response.json())
			.then(x=>{
				console.log(x);
				let startInstrNo=x[0].instrNo
				console.log(startInstrNo)
				let abc=startInstrNo.substr(0,11)
				let def=startInstrNo.substr(11,15)
				for(let obj of x){
					obj.instrDate=selectInstrDate;
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
			modalDialog.dialog('close');
			
		})
		mainGrid.on('click',ev=>{
			/* for(i=0;i<mainGrid.getData().length;i++){
				if(i!=ev.rowKey){
					mainGrid.uncheck(i);
				}
			} */
			prcGrid.clear();
			console.log(mainGrid.getRow(ev.rowKey).prcCd)
			let instrNo;
			console.log(ev.rowKey)
			if(hiddenMainGrid.getData().length==0){
				hiddenMainGrid.appendRow(mainGrid.getRow(ev.rowKey));
			}else{
				let z =0;
				for(obj of hiddenMainGrid.getData()){
					if(obj.prcCd==mainGrid.getRow(ev.rowKey).prcCd){
						z=1;
					}
				}
				if(z==0){
					hiddenMainGrid.appendRow(mainGrid.getRow(ev.rowKey))
				}
			}

			
			
			
			instrDate=mainGrid.getValue(mainGrid.getRow(ev.rowKey),'instrDate')			
			instrNo=mainGrid.getValue(mainGrid.getRow(ev.rowKey),'instrNo')
			
			fetch('planDtlPrc',{
				method:'POST',
				headers:{
					"Content-Type": "application/json",
				},
				body:JSON.stringify(mainGrid.getRow(ev.rowKey))
			})
			.then(response=>response.json())
			.then(result=>{
				main2Grid=result;
				let datas=[];
				for(let obj of result){
					obj.instrDate=selectInstrDate;
					obj.instrNo=instrNo;
					datas.push(obj)
				}
				let i
				if(prcGrid.getData().length==0){
					prcGrid.appendRows(datas);	
				}
				i = 0;
				console.log(prcGrid.getData())
				console.log()
				for(obj of datas){
					for(lot of prcGrid.getData())
						if(obj.mtrLot==lot.mtrLot){
							i=1;
						}
					
				}
				if(i==0){					
					prcGrid.appendRows(datas);	
				}
				/* if(mainGrid.getCheckedRows().length==1){
					prcGrid.resetData(datas);
					//mainGrid.uncheck(mainGrid.getRow(mainGrid.getCheckedRowKeys()[0]))
				}
				else{
					prcGrid.appendRows(datas);
				} */
				
			})
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
		
		prcGrid.on('editingFinish',ev=>{
			prcGrid.blur();
			console.log(prcGrid.getCheckedRows());
			hiddenGrid.appendRows([prcGrid.getRow(ev.rowKey)])

		})
		modifyBtn.addEventListener('click',ev=>{
			let a={};
			let b=[];
			let map=new Map();
			a.planData=hiddenModalGrid.getData();
			for(obj of hiddenMainGrid.getData()){
				if(map.has(obj.prcCd))
				{}
				else{
					map.set(obj.prcCd)
					b.push(obj)					
				}	
			}
			a.detailData=b;
			a.lotData=hiddenGrid.getData()
			 fetch('workInsertAll',{
				method:'POST',
				headers:{
					"Content-Type": "application/json",
				},
				body:JSON.stringify(a)
			})
			mainGrid.clear();
			modalGrid.clear();
			prcGrid.clear();
			hiddenModalGrid.clear();
			hiddenMainGrid.clear();
			hiddenGrid.clear();
		})
		
		//////////////////////////////////////이벤트/////////////////////////////////////////
		/* mainGrid.on("click",ev=>{
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
			
		}) */
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
			editor:'datePicker',
			hidden : true
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
				name : 'pdtFinDate',
				hidden : true
			},{
				header : '지시타임',
				name : 'workStrTime',
				hidden : true
			}],
		 columnOptions: {
		  frozenCount :11,
		  frozenBorderWidth:1
 }
		});
		
		resetGrid.addEventListener("click",ev=>{
			mainGrid.clear();
			modalGrid.clear();
			prcGrid.clear();
			hiddenModalGrid.clear();
			hiddenMainGrid.clear();
			hiddenGrid.clear();
			
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
/* rowAdd.addEventListener('click',ev=>{
	mainGrid.appendRow([{}]);
}) */
	</script>
	
</body>
</html>