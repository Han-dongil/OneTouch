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
<link rel="stylesheet" href="datepicker.css">
<script src="datepicker.js"></script>
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
select {
	width:100px;
	height: 30px;
}
</style>
<body>
	<label for="checkedY">지시완료</label>
	<input type="radio" id="checkedY" name="phs" value="Y">
	<label for="checkedN">미지시</label>
	<input type="radio" id="checkedN" name="phs" value="N">
	
	<button action='' id='selBtn' name='selBtn' onClick="dateSelectFnc()">조회</button>
	<button id="addBtn">계획추가</button>
	<button id="saveBtn">저장</button>
	<button id="delBtn">초기화</button>
	<!-- 	<input id="txtCo"> -->
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
		
	</select>
	<script>
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
	
	let lotGrid;
  	let lotData;
	let selectTag;
	let inGridData;
	let porObj;
  	let Grid = tui.Grid;
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
	    	header: '시작날짜',
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
		    	header: '종료날자',
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
		 		editor : 'text'
		},{
			header : '일별지시수량',
			name : 'instrCnt',
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
		},{
			header : '라인번호',
			name : 'lineNo',
		},{
			header : '공정코드',
			name : 'prcCd',
		},{
			header : '필요수량',
			name : 'needCnt',
			hidden:true
		},{
			header : '지시수량',
			name : 'instrCnt',
			hidden:true
		},{
			header : '시작날자',
			name : 'workStrDate',
			editor:'datePicker',
			hidden:true
		},{
			header : '종료날자',
			name : 'workEndDate',
			editor:'datePicker',
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
		rowHeaders:['checkbox'],
		columns:insertDtlColumns
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
		name : 'planNo'
	},{
		header : '주문번호',
		name : 'ordShtNo',
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
		hidden:true
	},{
		header : '제품코드',
		name : 'prdCd',
		hidden:true
	},{
		header : '필요수량',
		name : 'needCnt',
		hidden:true
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
			header : '사용가능수량',
			name : 'realCnt',
			hidden:true
		},{
			header : '출고수량',
			name : 'hldCnt',
		},{
			header : '사용량',
			name : 'useAmt',
			hidden:true
		},{
			header : '계획번호',
			name : 'planNo',
			hidden:false
		},{
			header : '라인번호',
			name : 'lineNo',
			hidden:true
		},{
			header : '공정코드',
			name : 'prcCd',
			hidden:true
		}],
	});  

	planGrid= new Grid({
		el: document.getElementById('planGrid'),
		data:null,
		rowHeaders:['checkbox'],
		columns:planColumns
	});	
	

	lotGrid = new Grid({
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
			header : '사용가능수량',
			name : 'realCnt',
			editor : 'text'
		},{
			header : '출고수량',
			name : 'hldCnt',
			editor : 'text'
		},{
			header : '사용량',
			name : 'useAmt',
		},{
			header : '계획번호',
			name : 'planNo',
			hidden:false
		}],
	});
	
	//document.getElementById('lotDiv').style="display:block"; //lot 그리드 히든풀기
	planGrid.on('editingStart',ev=>{
		
	})
	
	// 계획추가 그리드 셀렉트옵션 선택시 이벤트
	 	planGrid.on('editingFinish',ev=>{

	 		//plan 그리드 
	 		//라인번호 선택하면 공정코드가져옴
	 		if(ev.columnName=='lineNo'){
				disabledDays.length=0;
 				insertLineNo=planGrid.getValue(ev.rowKey,'lineNo');
	 			fetch('lotLineFind/'+planGrid.getValue(ev.rowKey,'lineNo'))
	 			.then(response=>response.json())
	 			.then(result=>{

	 				let i=0;
 					planColumns[2].editor.options.listItems.length=0;
 					$('#prcSelect').empty();
	 				for(obj of result){
	 					let prcSelect=document.getElementById('prcSelect');
	 					prcSelect.setAttribute('data-id',planGrid.getValue(ev.rowKey,'prdCd'));
						let optionTag=document.createElement('option');
						optionTag.value=obj.prcCd;
						optionTag.innerHTML=obj.prcNm;
						prcSelect.appendChild(optionTag);
		 				//planColumns[2].editor.options.listItems.push({text:obj.prcCd,value:obj.prcCd})

		 				i++;
	 				}
	 				
	 				///////////////////지시불가능날짜 불러오기
	 	    		let lineData={}
	 	 			lineData.lineNo=planGrid.getValue(ev.rowKey,'lineNo');
	 	 			fetch('slectDate',{
	 	 				method:'POST',
	 	 				headers:{
	 	 					"Content-Type": "application/json",
	 	 				},
	 	 				body:JSON.stringify(lineData)
	 	 			})
	 	 			.then(response=>response.json())
	 	 			.then(result=>{
	 	 				for(obj of result){
	 	 					if(obj.uphPdtAmt==0){
		 	 					disabledDays.push((obj.workStrDate).substring(0,10).replaceAll("-0","-"))
	 	 					}
	 	 					
	 	 				}
	 	 				console.log(disabledDays);
	 	 			})
	 				
	 			})
	 		}
	 		//제품코드로 라인번호 가져오기
	 		else if(ev.columnName=='prdCd'){
		 		fetch("lineNoFind/"+planGrid.getValue(ev.rowKey,'prdCd'))
		 		.then(response=>response.json())
		 		.then(result=>{
		 			let i=0;
		 			console.log(result)
		 			planGrid.setValue(planGrid.getData()[0].rowKey,'uphPdtAmt',result[0].uphPdtAmt)
		 			planColumns[1].editor.options.listItems.length=0;
					for(obj of result){
						console.log(obj)
						planColumns[0].editor.options.listItems.push({text:obj.lineNo,value:obj.lineNo})
		 				//planColumns[3].editor.options.listItems[i]={text:obj.lineNo,value:obj.lineNo}
						i++;
					}
		 		})
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
		
		abcde={'prdCd':prdCd, 'ordShtNo':ordShtNo , 'prcCd':prcCd};
		needLotCnt(abcde);
		
	}
	
	
	//모달에서 주문서 선택하면 어펜드로우시켜줌
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
		grid.blur();//커서 인풋밖으로빼냄
		planGrid.blur();//커서 인풋밖으로빼냄
		hiddenGrid.blur();//커서 인풋밖으로빼냄
		let msg='';
		//////////////////////////////////////////////////////////////////
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
			for(obj of result){
				console.log("요기")
				console.log(obj.uphPdtAmt)
				console.log(planGrid.getValue(planGrid.getData()[0].rowKey,'instrCnt'))
				if(obj.uphPdtAmt*1<planGrid.getValue(planGrid.getData()[0].rowKey,'instrCnt')*1){
					obj.uphPdtAmt//그날생산수량
					obj.workStrDate//해당일
					msg +=obj.workStrDate+'일의 생산 가능수량은' +obj.uphPdtAmt+'개입니다'
				}
				
			}
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
				.then(response=>response.json())
				.then(result=>{
					
				})
				grid.clear();
				planGrid.clear();
				insertDtlGrid.clear();
				lotGrid.clear();
				insertDtlGrid.clear();
				disabledDays.length=0;
			}
		})
		
		
		
		

	})
	
 	delBtn.addEventListener("click",function(){
		grid.clear()
		planGrid.clear()
		lotGrid.clear()
		hiddenGrid.clear()
		insertDtlGrid.clear()
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

//////////////////////안전재고
 //주문서검색 모달창
	let safeDialog = $( "#safe-dialog-form" ).dialog({
		autoOpen: false,
		modal:true,
		buttons:{"save":function(){alert("save")}}
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
		columns:[{
			header : '제품코드',
			name : 'prdCd'
		},{
			header : '필요수량',
			name : 'needCnt',
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
 		})
 		safeDialog.dialog('close');
		
	})
	
	planGrid.on('click',ev=>{
		if(ev.columnName=='prdCd'){
			if(grid.getValue(ev.rowKey,'ordShtNo')!='null'){
   			 fetch('ordShtSelect/'+grid.getValue(ev.rowKey,'ordShtNo'))
   			 .then(response=>response.json())
   			 .then(result=>{
   				 console.log(result)
   				 return result;
   			 })
   			 .then(x=>{
   				 if( (grid.getData()[grid.getRowCount()-1].ordShtNo)){
	    				 if( (grid.getData()[grid.getRowCount()-1].ordShtNo).substring(0,3)=='ORD'){
	    					 planGrid.resetData(x);
	    				 }
	    				 else{
		    				 planGrid.resetData([grid.getRow(ev.rowKey)]);
	    				 }
   				 }
					 for(let i=0 ; i<x.length;i++){
   					 planGrid.setValue(i,'planNo',insertPlanNo);
						 
					 }
  					 planColumns[0].editor.options.listItems.length=0;
  					 fetch('prdCdFind')
  						.then(response=>response.json())
  						.then(result=>{
  							 //planGrid.resetData(result)
  							 console.log(result)
  							 for(let obj of result){
  								
  								planColumns[0].editor.options.listItems.push({text:obj.prdCd,value:obj.prdCd})
  								 //planColumns[0].editor.options.listItems[i]={text:obj.prdCd,value:obj.prdCd}
  								 //i++;
  							 }
	   							 
  						})
   			 })
   		 }
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
		if(ev.columnName=='lineNo'){
			//planGrid.resetData([{}]);
	 		fetch("lineNoFind/"+planGrid.getValue(ev.rowKey,'prdCd'))
	 		.then(response=>response.json())
	 		.then(result=>{
	 			i=0
	 			for(obj of result){
		 			planColumns[1].editor.options.listItems[i]={text:obj.lineNo,value:obj.lineNo}
					i++;	 				
	 			}
	 			
	 		})
	 				
	 				
	 		
		}
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
		lotGrid.refreshLayout();
		fetch("lotCdFind/"+ev.target.getAttribute('data-id')+'/'+ev.target.value)
			.then(response=>response.json())
			.then(result=>{
				lotGrid.resetData(result);
				insertPrcCd=planGrid.getValue(ev.rowKey,'prcCd');
				inserMtrLot=ev.rowKey;
			})
		let createDate=planGrid.getModifiedRows().createdRows;		
		let updateData=planGrid.getModifiedRows().updatedRows;
		for(obj of createDate){
			obj.prcCd=ev.target.value;
		}	
		for(obj of updateData){
			obj.prcCd=ev.target.value;
		}	
		insertDtlGrid.appendRows(createDate);
		insertDtlGrid.appendRows(updateData);
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
		//document.getElementById('lotDiv').style='display:none';
		planGrid.appendRow([{}]);
		planGrid.setValue(planGrid.getData()[planGrid.getRowCount()-1].rowKey,'planNo',grid.getData()[0].planNo);
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
	})
//자재등록
	/* LotAddRow.addEventListener('click',ev=>{
		let modiData = lotGrid.getModifiedRows().updatedRows;
		let modiList=[];
		let prcSelect=document.getElementById('prcSelect');
		for(obj of modiData){
			obj.planNo=grid.getCheckedRows()[0].planNo;
			obj.lineNo=insertLineNo;
			obj.prcCd=prcSelect.value;
			console.log(obj);
			modiList.push(obj);
		}
		let checkedRow=(planGrid.getCheckedRows()[0]);
		console.log(checkedRow);
		checkedRow.prcCd=prcSelect.value;
		insertDtlGrid.appendRow(checkedRow);
		hiddenGrid.appendRows(modiList);
		document.getElementById('hidden');
		
	}) */
	lotGrid.on('check',ev=>{
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
		let lotData1=lotGrid.getModifiedRows().updatedRows[0];
		lotData1.planNo=grid.getData()[0].planNo;
		lotData1.lineNo=planGrid.getData()[0].lineNo;
		hiddenGrid.appendRows([lotData1]);
	})
	
	</script>

</body>
</html>