/*//자재업체 
function mMtrComp(){
	let mtrCompData;
		
	$.ajax({
		url : './modalMtrCompList',
		dataType : 'json',
		async : false,
		success : function(result){
			console.log(result);
			mtrCompData = result;
		}
	});
	
	dialog.dialog("open");
			
	$("#dialog-form").attr('title', '자재업체');
	
	$("#dialog-form").load("modalMtrComp", function(){
		let mtrCompGrid = tui.Grid;
		
		mtrCompGrid.applyTheme('striped',{
			cell:{
				header:{
					background:'#eef'
				},
				evenRow:{
					background:'#fee'
				}
			}
		})
		
		const mtrCompColumns = [ 
			{
				header: '자재업체코드',
				name: 'dtlCd',
				hidden: true
			},
			{
				header: '자재업체명',
				name: 'dtlNm'
			}
		];
		
		mtrCompGrid = new Grid({
			el : document.getElementById('mtrComp_grid'),
			data : mtrCompData,
			columns : mtrCompColumns
		});
		
		mtrCompGrid.on('dblclick', ev => {
			console.log(mtrCompGrid.getRow(ev.rowKey)) //ajax result(ev.rowKey)
			getModalMtrComp(mtrCompGrid.getRow(ev.rowKey));
		})
		
		mtrCompGrid.on('successResponse',function(ev){
			console.log("성공")
		})
		mtrCompGrid.on('failResponse',function(ev){
			console.log("실패")
		})
	});
}*/


//자재
function mMtr(){
	let mtrData;
		
	$.ajax({
		url : './modalMtrList',
		dataType : 'json',
		async : false,
		success : function(result){
			console.log(result);
			mtrData = result;
		}
	});
	
		
	dialog.dialog("open");
			
	$("#dialog-form").attr('title', '자재');
	
	$("#dialog-form").load("modalMtr", function(){
		let mtrGrid = tui.Grid;
		
		mtrGrid.applyTheme('striped',{
			cell:{
				header:{
					background:'#eef'
				},
				evenRow:{
					background:'#fee'
				}
			}
		})
		
		const mtrColumns = [ 
			{
				header: '자재코드',
				name: 'mtrCd',
				hidden: true
			},
			{
				header: '자재명',
				name: 'mtrNm'
			},
			{
				header: '규격',
				name: 'std',
				hidden: true
			},
			{
				header: '관리수량',
				name: 'mngAmt',
				hidden: true
			},
			{
				header: '단위',
				name: 'unit',
				hidden: true
			},
			{
				header: '업체코드',
				name: 'compCd',
				hidden: true
			},
			{
				header: '업체코드',
				name: 'compNm'
			},
			{
				header: '자재구분',
				name: 'mtrSect'
			},
			{
				header: '안전재고',
				name: 'safeStck',
				hidden: true
			}
		];
		
		mtrGrid = new Grid({
			el : document.getElementById('mtr_grid'),
			data : mtrData,
			columns : mtrColumns
		});
		
		mtrGrid.on('dblclick', ev => {
			console.log(mtrGrid.getRow(ev.rowKey)) //ajax result(ev.rowKey)
			getModalMtr(mtrGrid.getRow(ev.rowKey));
		})
		
		mtrGrid.on('successResponse',function(ev){
			console.log("성공")
		})
		mtrGrid.on('failResponse',function(ev){
			console.log("실패")
		})
	});
}


/*//생산업체 
function mFctComp(){
	let fctCompData;
		
	$.ajax({
		url : './modalFctCompList',
		dataType : 'json',
		async : false,
		success : function(result){
			console.log(result);
			fctCompData = result;
		}
	});
	
	dialog.dialog("open");
			
	$("#dialog-form").attr('title', '설비업체');
	
	$("#dialog-form").load("modalFctComp", function(){
		let fctCompGrid = tui.Grid;
		
		fctCompGrid.applyTheme('striped',{
			cell:{
				header:{
					background:'#eef'
				},
				evenRow:{
					background:'#fee'
				}
			}
		})
		
		const fctCompColumns = [ 
			{
				header: '설비업체코드',
				name: 'dtlCd',
				hidden: true
			},
			{
				header: '설비업체명',
				name: 'dtlNm'
			}
		];
		
		fctCompGrid = new Grid({
			el : document.getElementById('fctComp_grid'),
			data : fctCompData,
			columns : fctCompColumns
		});
		
		fctCompGrid.on('dblclick', ev => {
			console.log(fctCompGrid.getRow(ev.rowKey)) //ajax result(ev.rowKey)
			getModalFctComp(fctCompGrid.getRow(ev.rowKey));
		})
		
		fctCompGrid.on('successResponse',function(ev){
			console.log("성공")
		})
		fctCompGrid.on('failResponse',function(ev){
			console.log("실패")
		})
	});
}


//자재구분
function mMtrSect(){
	let mtrSectData;
		
	$.ajax({
		url : './modalMtrSectList',
		dataType : 'json',
		async : false,
		success : function(result){
			console.log(result);
			mtrSectData = result;
		}
	});
	
	dialog.dialog("open");
			
	$("#dialog-form").attr('title', '자재구분');
	
	$("#dialog-form").load("modalMtrSect", function(){
		let mtrSectGrid = tui.Grid;
		
		mtrSectGrid.applyTheme('striped',{
			cell:{
				header:{
					background:'#eef'
				},
				evenRow:{
					background:'#fee'
				}
			}
		})
		
		const mtrSectColumns = [ 
			{
				header: '자재구분코드',
				name: 'dtlCd',
				hidden: true
			},
			{
				header: '자재구분',
				name: 'dtlNm'
			}
		];
		
		mtrSectGrid = new Grid({
			el : document.getElementById('mtrSect_grid'),
			data : mtrSectData,
			columns : mtrSectColumns
		});
		
		mtrSectGrid.on('dblclick', ev => {
			console.log(mtrSectGrid.getRow(ev.rowKey)) //ajax result(ev.rowKey)
			getModalMtrSect(mtrSectGrid.getRow(ev.rowKey));
		})
		
		mtrSectGrid.on('successResponse',function(ev){
			console.log("성공")
		})
		mtrSectGrid.on('failResponse',function(ev){
			console.log("실패")
		})
	});
}


//제품구분
function mPdtSect(){
	let pdtSectData;
		
	$.ajax({
		url : './modalPdtSectList',
		dataType : 'json',
		async : false,
		success : function(result){
			console.log(result);
			pdtSectData = result;
		}
	});
	
	dialog.dialog("open");
			
	$("#dialog-form").attr('title', '제품구분');
	
	$("#dialog-form").load("modalPdtSect", function(){
		let pdtSectGrid = tui.Grid;
		
		pdtSectGrid.applyTheme('striped',{
			cell:{
				header:{
					background:'#eef'
				},
				evenRow:{
					background:'#fee'
				}
			}
		})
		
		const pdtSectColumns = [ 
			{
				header: '제품구분코드',
				name: 'dtlCd',
				hidden: true
			},
			{
				header: '제품구분',
				name: 'dtlNm'
			}
		];
		
		pdtSectGrid = new Grid({
			el : document.getElementById('pdtSect_grid'),
			data : pdtSectData,
			columns : pdtSectColumns
		});
		
		pdtSectGrid.on('dblclick', ev => {
			console.log(pdtSectGrid.getRow(ev.rowKey)) //ajax result(ev.rowKey)
			getModalPdtSect(pdtSectGrid.getRow(ev.rowKey));
		})
		
		pdtSectGrid.on('successResponse',function(ev){
			console.log("성공")
		})
		pdtSectGrid.on('failResponse',function(ev){
			console.log("실패")
		})
	});
}*/


//공콩코드
function mBas(basCd){
	let basData;
		
	$.ajax({
		url : './modalBasList',
		method : 'POST',
		data : 'basCd=' + basCd,
		success : function(result){
			console.log(result);
			basData = result;
		}
	});
	
	dialog.dialog("open");
	
	let title;
	switch(basCd){
		case 'FCT_DIV' :
			title ='설비구분'
			break;
		case 'FCT_REP':
			title ='설비수리사항'
			break;
		case 'FCT_NO_USE':
			title ='비가동사유코드'
			break;
		case 'FCT_SIZE':
			title ='설비규격종류'
			break;
		case 'FCT_COM':
			title ='설비업체코드'
			break;
		case 'FCT_ACT':
			title ='설비점검후조치사항'
			break;
		case 'MTR_COM':
			title ='자재업체'
			break;
		case 'MTR_SIZE':
			title ='자재규격종류'
			break;
		case 'MTR_UNIT':
			title ='단위구분'
			break;
		case 'MTR_CAL':
			title ='정산구분'
			break;
		case 'MTR_SECT':
			title ='자재구분'
			break;
		case 'PDT_SECT':
			title ='제품구분'
			break;
		case 'PDT_PRC':
			title ='공정구분'
			break;
		case 'DEPT':
			title ='부서'
			break;
	}
			
	$("#dialog-form").attr('title', title);
	
	$("#dialog-form").load("modalBas", function(){
		let basGrid = tui.Grid;
		
		basGrid.applyTheme('striped',{
			cell:{
				header:{
					background:'#eef'
				},
				evenRow:{
					background:'#fee'
				}
			}
		})
		
		const basColumns = [ 
			{
				header: title + '코드',
				name: 'dtlCd',
				hidden: true
			},
			{
				header: title,
				name: 'dtlNm'
			}
		];
		
		basGrid = new Grid({
			el : document.getElementById('bas_grid'),
			data : basData,
			columns : basColumns
		});
		
		basGrid.on('dblclick', ev => {
			console.log(basGrid.getRow(ev.rowKey)) //ajax result(ev.rowKey)
			getModalBas(basGrid.getRow(ev.rowKey));
		})
		
		basGrid.on('successResponse',function(ev){
			console.log("성공")
		})
		basGrid.on('failResponse',function(ev){
			console.log("실패")
		})
	});
}