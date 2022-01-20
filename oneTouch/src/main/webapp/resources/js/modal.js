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
				align: 'center'
			},
			{
				header: '자재명',
				name: 'mtrNm',
				align: 'center'
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
				header: '단위코드',
				name: 'unit',
				hidden: true
			},
			{
				header: '단위',
				name: 'unitNm',
				align: 'center'
			},
			{
				header: '업체코드',
				name: 'compCd',
				hidden: true
			},
			{
				header: '업체명',
				name: 'compNm',
				align: 'center'
			},
			{
				header: '자재구분코드',
				name: 'mtrSect',
				hidden: true
			},
			{
				header: '자재구분',
				name: 'mtrSectNm',
				align: 'center'
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


//제품
function mPrd(){
	let prdData;
		
	$.ajax({
		url : './modalPrdList',
		dataType : 'json',
		async : false,
		success : function(result){
			console.log(result);
			prdData = result;
		}
	});
		
	dialog.dialog("open");
			
	$("#dialog-form").attr('title', '제품');
	
	$("#dialog-form").load("modalPrd", function(){
		let prdGrid = tui.Grid;
		
		prdGrid.applyTheme('striped',{
			cell:{
				header:{
					background:'#eef'
				},
				evenRow:{
					background:'#fee'
				}
			}
		})
		
		const prdColumns = [ 
			{
				header: '제품코드',
				name: 'prdCd',
				hidden: true
			},
			{
				header: '제품명',
				name: 'prdNm'
			},
			{
				header: '제품규격',
				name: 'prdStd'
			},
			{
				header: '관리단위코드',
				name: 'mngUnit',
				hidden: true
			},
			{
				header: '관리단위',
				name: 'mngUnitNm'
			},
			{
				header: '가능라인',
				name: 'ableLineNo'
			},
			{
				header: '제품구분',
				name: 'prdSect'
			}
		];
		
		prdGrid = new Grid({
			el : document.getElementById('prd_grid'),
			data : prdData,
			columns : prdColumns
		});
		
		prdGrid.on('dblclick', ev => {
			console.log(prdGrid.getRow(ev.rowKey)) //ajax result(ev.rowKey)
			getModalPrd(prdGrid.getRow(ev.rowKey));
		})
		
		prdGrid.on('successResponse',function(ev){
			console.log("성공")
		})
		prdGrid.on('failResponse',function(ev){
			console.log("실패")
		})
	});
}


//공정
function mPrc(){
	let prcData;
		
	$.ajax({
		url : './modalPrcList',
		dataType : 'json',
		async : false,
		success : function(result){
			console.log(result);
			prcData = result;
		}
	});
		
	dialog.dialog("open");
			
	$("#dialog-form").attr('title', '공정');
	
	$("#dialog-form").load("modalPrc", function(){
		let prcGrid = tui.Grid;
		
		prcGrid.applyTheme('striped',{
			cell:{
				header:{
					background:'#eef'
				},
				evenRow:{
					background:'#fee'
				}
			}
		})

		const prcColumns = [ 
			{
				header: '공정코드',
				name: 'prcCd',
				hidden: true
			},
			{
				header: '공정명',
				name: 'prcNm'
			},
			{
				header: '관리단위코드',
				name: 'mngUnit'
			},
			{
				header: '관리단위',
				name: 'mngUnitNm'
			},
			{
				header: '생산일수',
				name: 'pdtDay'
			},
			{
				header: '공정구분코드',
				name: 'prcSect',
				hidden: true
			},
			{
				header: '공정구분',
				name: 'prcSectNm'
			},
			{
				header: '비고',
				name: 'cmt',
				hidden: true
			},
			{
				header: '표시순서',
				name: 'seq',
				hidden: true
			}
		];
	
		prcGrid = new Grid({
			el : document.getElementById('prc_grid'),
			data : prcData,
			columns : prcColumns
		});
	
		prcGrid.on('dblclick', ev => {
			console.log(prcGrid.getRow(ev.rowKey)) //ajax result(ev.rowKey)
			getModalPrc(prcGrid.getRow(ev.rowKey));
		})
	
		prcGrid.on('successResponse',function(ev){
			console.log("성공")
		})
		prcGrid.on('failResponse',function(ev){
			console.log("실패")
		})
	});
}


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
				//hidden: true
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