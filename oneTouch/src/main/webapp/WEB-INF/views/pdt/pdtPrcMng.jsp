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
<body>
	<form name="selectFrm" id="selectFrm">
		라인번호 : <select name="lineNo" id="lineNo">
		</select>
		공정코드 : <select name="prcCd" id="prcCd">
		</select>
	</form>
	<div class="row">
		<div id="prcListGrid" class="col-3" ></div>
		<div class="col-8" style="border:solid">
		<button class="dongilBtn" id="prcStart" name="prcStart">시작</button>
		<button class="dongilBtn" id="prcEnd" name="prcEnd">종료</button>
		<button class="dongilBtn" id="fltAdd" name="fltAdd">+</button>
		<button class="dongilBtn" id="fltMinus" name="fltMinus">-</button>
		<button class="dongilBtn" id="fastStop" name="fastStop">긴급중단</button>
		</div>
	</div>
	<div id="hiddenGrid">
		
	</div>
	<script>
	let prcVO={};
	let lineNoTag=document.getElementById("lineNo");
	let prcCdTag=document.getElementById("prcCd");
	let Grid = tui.Grid;
	//select option 에 line 번호 뿌려주기
	fetch('lineList')
	.then(response=>response.json())
	.then(result=>{
		for(obj of result){
			let optionTag=document.createElement("option");
			optionTag.value=obj.lineNo;
			optionTag.innerHTML=obj.lineNo;
			lineNoTag.appendChild(optionTag);
		}
	})



	
///////////////////////////////////////////그리드///////////////////////////////////////////	
	//메인 그리드 생성
	let mainGrid = new Grid({
		  el: document.getElementById('prcListGrid'),
		  data:null,
		  columns:[{
				header : '지시번호',
				name : 'instrNo'
			},{
				header : '작업타임',
				name : 'workStrTime'
			},{
				header : '생산수량',
				name : 'pdtCnt'
			},{
				header : '흐름순서',
				name : 'prcSeq'
			}],
		  columnOptions: {
			  frozenCount :10,
			  frozenBorderWidth:2
		  }
	});
	//main그리드 데이터 
	function prcGridData(prcVO){
		console.log(prcVO)
		fetch('prdPrcList',{
			method:'POST',
			headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(prcVO)
		})
		.then(response=>response.json())
		.then(result=>{
			mainGrid.resetData(result);
		})
	}
	//히든그리드
		let hiddenGrid = new Grid({
		  el: document.getElementById('hiddenGrid'),
		  data:null,
		  columns:[{
				header : '지시번호',
				name : 'instrNo'
			},{
				header : '라인번호',
				name : 'lineNo'
			},{
				header : '공정코드',
				name : 'prcCd'
			},{
				header : '시작시간',
				name : 'workStrDt'
			},{
				header : '종료시간',
				name : 'workFinDt'
			},{
				header : '목표수량',
				name : 'goalCnt'
			},{
				header : '생산량',
				name : 'pdtCnt'
			},{
				header : '불량량',
				name : 'fltCnt'
			},{
				header : '현재상태',
				name : 'nowPhs'
			},{
				header : '제품LOT',
				name : 'prdLot'
			}],
		  columnOptions: {
			  frozenCount :10,
			  frozenBorderWidth:2
		  }
	});
///////////////////////////////////////////이벤트리스너///////////////////////////////////////
	//시작버튼
	prcStart.addEventListener('click',ev=>{
		fetch('prcStart',{
			method:'POST',
			headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify()
		})
		.then(response=>response.json())
		.then(result=>{
			
			
		})
	})
	//select option 에 prc코드 뿌려주기
	lineNoTag.addEventListener('change',ev=>{
		hiddenGrid.resetData([{}]);
		hiddenGrid.setValue(0,'lineNo',ev.target.value)
		$('#prcCd').empty();
		fetch('prcCdFromlineNo/'+ev.target.value)
		.then(response=>response.json())
		.then(result=>{
			for(obj of result){
				let optionTag=document.createElement("option");
				optionTag.value=obj.prcCd;
				optionTag.innerHTML=obj.prcCd;
				prcCdTag.appendChild(optionTag);
			}
		})
	})
	mainGrid.on("click",ev=>{
		hiddenGrid.setValue(0,'instrNo',mainGrid.getValue(ev.rowKey,'instrNo'))
		mainGrid.getRow(ev.rowKey)
	})
	
	//lineNo prcCd 선택시 해당 조건에맞는 작업지시 데이터 불러와서 그리드에 표시
	prcCdTag.addEventListener('change',ev=>{
		console.log(ev.target.value)
		prcVO=$('#selectFrm').serializeObject()
		hiddenGrid.setValue(0,'prcCd',ev.target.value)
		prcGridData(prcVO)
	})
	</script>
</body>
</html>