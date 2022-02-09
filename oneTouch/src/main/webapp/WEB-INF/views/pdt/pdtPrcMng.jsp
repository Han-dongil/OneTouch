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
<%-- <script src="${path}/resources/js/grid-common.js"></script> --%>

<style>
.kioskcardtitle{
	font-size: 1.3rem !important;
}
.kiosklabel{
	font-size: 1.2rem !important;
}
.kiosklabel2{
	font-size: 1.2rem !important;
	margin-left: 10px;
	margin-bottom: -70px;
}
.kioskBtn1{
	margin: 70px 40px 40px 20px;	
	width: 200px;
	height: 200px;
	font-size: 3rem;
}
.kioskBtn2{
	margin-top: 42px !important;
	margin: 10px;
	padding-top: 14px;
	padding-bottom: 14px;
	width: 60px;
	height: 60px;
	font-size: 2rem;
	padding-left: 13px !important;
}
.kioskBtn3{
	margin-top: 42px !important;
	margin: 10px;
	padding-top: 16px;
	padding-bottom: 16px;
	font-size: 1.6rem;
	margin-left: 30px;
}

/*style에 추가했는데 안 먹혀서 잠시 여기에 있는 것 start*/

.btn-important {
  color: #fff;
  background-color: #F3797E !important;
  border-color: #F3797E !important;
}

.btn-important:hover {
  color: #fff;
  background-color: rgb(241, 105, 112) !important;
  border-color: rgb(239, 92, 100) !important;
}

.btn-important:focus, .btn-important.focus {
  color: #fff;
  background-color: rgb(241, 105, 112);
  border-color: rgb(239, 92, 100);
  box-shadow: 0 0 0 0.2rem rgb(247, 170, 174, 0.5);
}

.btn-important.disabled, .btn-important:disabled {
  color: #fff;
  background-color: #F3797E;
  border-color: #F3797E;
}

.btn-important:not(:disabled):not(.disabled):active, .btn-important:not(:disabled):not(.disabled).active,
.show > .btn-important.dropdown-toggle {
  color: #fff;
  background-color: rgb(239, 92, 100);
  border-color: rgb(237, 63, 71);
}

.btn-important:not(:disabled):not(.disabled):active:focus, .btn-important:not(:disabled):not(.disabled).active:focus,
.show > .btn-important.dropdown-toggle:focus {
  box-shadow: 0 0 0 0.2rem rgb(247, 170, 174, 0.5);
}

/*----------*/

.btn-start {
  color: #fff;
  background-color: #36b9ad;
  border-color: #36b9ad;
}

.btn-start:hover {
  color: #fff;
  background-color: rgb(51, 172, 160);
  border-color: rgb(49, 164, 152);
}

.btn-start:focus, .btn-start.focus {
  color: #fff;
  background-color: rgb(51, 172, 160);
  border-color: rgb(49, 164, 152);
  box-shadow: 0 0 0 0.2rem rgb(81, 204, 191, 0.5);
}

.btn-start.disabled, .btn-start:disabled {
  color: #fff;
  background-color: #36b9ad;
  border-color: #36b9ad;
}

.btn-start:not(:disabled):not(.disabled):active, .btn-start:not(:disabled):not(.disabled).active,
.show > .btn-start.dropdown-toggle {
  color: #fff;
  background-color: rgb(49, 164, 152);
  border-color: rgb(45, 149, 138);
}

.btn-start:not(:disabled):not(.disabled):active:focus, .btn-start:not(:disabled):not(.disabled).active:focus,
.show > .btn-start.dropdown-toggle:focus {
  box-shadow: 0 0 0 0.2rem rgb(81, 204, 191, 0.5);
}

/*----------*/

.btn-sub {
  color: #fff;
  background-color: #7DA0FA;
  border-color: #7DA0FA;
}

.btn-sub:hover {
  color: #fff;
  background-color: rgb(105, 145, 250);
  border-color: rgb(86, 131, 250);
}

.btn-sub:focus, .btn-sub.focus {
  color: #fff;
  background-color: rgb(105, 145, 250);
  border-color: rgb(86, 131, 250);
  box-shadow: 0 0 0 0.2rem rgb(165, 189, 252, 0.5);
}

.btn-sub.disabled, .btn-sub:disabled {
  color: #fff;
  background-color: #7DA0FA;
  border-color: #7DA0FA;
}

.btn-sub:not(:disabled):not(.disabled):active, .btn-sub:not(:disabled):not(.disabled).active,
.show > .btn-sub.dropdown-toggle {
  color: #fff;
  background-color: rgb(86, 131, 250);
  border-color: rgb(65, 116, 250);
}

.btn-sub:not(:disabled):not(.disabled):active:focus, .btn-sub:not(:disabled):not(.disabled).active:focus,
.show > .btn-sub.dropdown-toggle:focus {
  box-shadow: 0 0 0 0.2rem rgb(165, 189, 252, 0.5);
}
.bascard1{
	height:150px;
}
.bascard2{
	height:420px;
	margin-bottom: 12px;
}

/*style에 추가했는데 안 먹혀서 잠시 여기에 있는 것 end*/
</style>
</head>
<body>
<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12 grid-margin">
			<div class="row">
				<div class="col-12 col-xl-8 mb-4 mb-xl-0">
					<h3 class="font-weight-bold page-title">생산공정관리</h3>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class = "col-4">
			<div class="card bascard1">
				<div class="card-body">
					<h4 class="card-title kioskcardtitle">작업지시 공정라인</h4>
					<span style="padding-top: 10px;">
						<form name="selectFrm" id="selectFrm">
							<label class="labeltext kiosklabel">라인번호</label>&emsp;&nbsp;
							<select name="lineNo" id="lineNo" class="selectoption"></select><br>
								
							<label class="labeltext kiosklabel">공정코드</label>&emsp;&nbsp;
							<select name="prcCd" id="prcCd" class="selectoption"></select>
						</form>
					</span>
				</div>
			</div><br>
			<div id="prcListGrid"></div>
		</div>
		
		<div class = "col-8">
			<div class="card bascard2">
				<div class="card-body">
					<h4 class="card-title kioskcardtitle">공정 가동관리</h4>
					<!-- <span style="padding-top: 10px;"> -->
						<div style="vertical-align: center">
							<div style="display:inline-block">
								<button class="btn btn-sub kioskBtn1" id="prcStart" name="prcStart">시작</button>
								<button class="btn btn-important kioskBtn1" id="prcEnd" name="prcEnd">종료</button>
							</div>
							<div style="display:inline-block;">
								<div>
									<label class="labeltext kiosklabel2">불량률</label><br>							
								</div>
								<div>
									<button class="btn btn-primary kioskBtn2" id="fltAdd" name="fltAdd">┼</button>
									<button class="btn btn-primary kioskBtn2" id="fltMinus" name="fltMinus">━</button>							
								</div>
							</div>
							<div style="display:inline-block">
								<button class="btn btn-main kioskBtn3" id="fastStop" name="fastStop">긴급중단</button>
							</div>
						</div>
					<!-- </span> -->
				</div>
			</div>
		</div>
	</div>
	<br>
	<div id="hiddenGrid"></div>

</div>




	
	<!-- <form name="selectFrm" id="selectFrm">
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
		
	</div> -->
	
	<script>
	let prcVO={};
	let lineNoTag=document.getElementById("lineNo");
	let prcCdTag=document.getElementById("prcCd");
	let Grid = tui.Grid;
	
	Grid.applyTheme('clean', {
		cell: {
			normal: {
				border: '#FFFFFF'
			},
			header: {
				background: '#4B49AC',
				text: '#fff'
			}
		},
		row: {
			hover: {
				background: '#eeeeff'
			}
		}
	});
	Grid.setLanguage('ko');
	
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
				name : 'instrNo',
		        align:'center',
			},{
				header : '작업타임',
				name : 'workStrTime',
		        align:'center',
				hidden:true
			},{
				header : '목표수량',
				name : 'goalCnt',
		        align:'right',
			},{
				header : '흐름순서',
				name : 'prcSeq',
		        align:'right',
			}],
		  columnOptions: {
			  frozenCount :10,
			  frozenBorderWidth:2
		  },
		  bodyHeight: 208,
		  minBodyHeight: 208
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
				name : 'instrNo',
		        align:'center',
			},{
				header : '라인번호',
				name : 'lineNo',
		        align:'center',
			},{
				header : '공정코드',
				name : 'prcCd',
		        align:'center',
			},{
				header : '시작시간',
				name : 'workStrDt',
		        align:'center',
			},{
				header : '종료시간',
				name : 'workFinDt',
		        align:'center',
			},{
				header : '목표수량',
				name : 'goalCnt',
		        align:'right',
			},{
				header : '생산량',
				name : 'pdtCnt',
		        align:'right',
			},{
				header : '불량량',
				name : 'fltCnt',
		        align:'right',
			},{
				header : '라인불량량',
				name : 'sumFlt',
		        align:'right',
			},{
				header : '현재상태',
				name : 'nowPhs',
		        align:'center',
			},{
				header : '제품LOT',
				name : 'prdLot',
		        align:'center',
			}],
		  columnOptions: {
			  frozenCount :10,
			  frozenBorderWidth:2
		  },
		  bodyHeight: 251,
		  minBodyHeight: 251
	});
///////////////////////////////////////////이벤트리스너///////////////////////////////////////
	//라인불량 동기화
	function fltCheck(){
		fetch('fltCheck',{
			method:'POST',
			headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(hiddenGrid.getData())
		})
		.then(response=>response.json())
		.then(result=>{
			console.log("dddddd")
			console.log(result.prcCd)
			console.log(hiddenGrid.getRow(0).prcCd)
			if(result.sumFlt!=result.goalCnt&&result.prcCd==hiddenGrid.getRow(0).prcCd){
				hiddenGrid.setValue(0,'sumFlt',result.sumFlt*1);
				hiddenGrid.setValue(0,'pdtCnt',result.pdtCnt*1);
				console.log(result)
				fltCheck();
				
			}else{
				console.log("불량률 100퍼 !!!!!!!!! 공장망하겟누")
			}
		})
	}
	//긴급중단버튼
	fastStop.addEventListener('click',ev=>{
		fetch('fastStop',{
			method:'POST',
			headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(hiddenGrid.getData())
		})
		.then(response=>response.json)
		.then(result=>{
			alert('관리부서에 알림을 보냇습니다');
			hiddenGrid.setValue(0,'nowPhs','긴급중단');
		})
	})

	//시작버튼
	prcStart.addEventListener('click',ev=>{
		
		fetch('playingPrcFind',{
			method:'POST',
			headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(hiddenGrid.getRow(0))
		})
		.then(response=>response.json())
		.then(result=>{
			if(result.length==0){
				fetch('prcStart',{
					method:'POST',
					headers:{
						"Content-Type": "application/json",
					},
					body:JSON.stringify(hiddenGrid.getData())
				})
				.then(response=>response.json())
				.then(result=>{
					hiddenGrid.setValue(0,'fltCnt',0);
					alert(result.msg);
					
					console.log(result);  // result.workStrDt  << 시작시간 화면에띄워줘야댐
					hiddenGrid.setValue(0,'workStrDt',result.workStrDt);
					hiddenGrid.setValue(0,'nowPhs',result.nowPhs);
					fltCheck();
				})
			}
			else{
				alert('이전 작업지시가 종료되지 않았습니다.')
			}
		})
	})
	//종료버튼
	prcEnd.addEventListener('click',ev=>{
		hiddenGrid.setValue(0,'pdtCnt',hiddenGrid.getValue(0,'goalCnt')*1-hiddenGrid.getValue(0,'sumFlt')*1)
		fetch('prcEnd',{
			method:'POST',
			headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(hiddenGrid.getData())
		})
		.then(response=>response.json())
		.then(result=>{
			console.log(result);
			hiddenGrid.setValue(0,'workFinDt',result.workFinDt);
			hiddenGrid.setValue(0,'nowPhs',result.nowPhs);
			hiddenGrid.setValue(0,'prdLot',result.prdLot);
			//hiddenGrid.setValue(0,'pdtCnt',hiddenGrid.getValue(0,'goalCnt')*1-hiddenGrid.getValue(0,'fltCnt')*1);
			alert(result.msg)
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
			prcGridData($('#selectFrm').serializeObject())
		})
	})
	mainGrid.on("click",ev=>{
		hiddenGrid.resetData([{}])
		hiddenGrid.setValue(0,'instrNo',mainGrid.getValue(ev.rowKey,'instrNo'))
		hiddenGrid.setValue(0,'instrNo',mainGrid.getValue(ev.rowKey,'instrNo'))
		//hiddenGrid.setValue(0,'pdtCnt',0)
		hiddenGrid.setValue(0,'lineNo',document.getElementById('lineNo').value)
		hiddenGrid.setValue(0,'prcCd',document.getElementById('prcCd').value)
		hiddenGrid.setValue(0,'goalCnt',mainGrid.getValue(ev.rowKey,'goalCnt'))
		mainGrid.getRow(ev.rowKey)
		

		
		
		fetch('selectPrcReal',{
			method:'POST',
			headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(hiddenGrid.getData())
		})
		.then(response=>response.json())
		.then(result=>{
			console.log(result)
			hiddenGrid.resetData([result])
		})
		.then(()=>{
			//hiddenGrid.resetData([{}])
			//hiddenGrid.setValue(0,'fltCnt',0);
			hiddenGrid.setValue(0,'instrNo',mainGrid.getValue(ev.rowKey,'instrNo'))
			//hiddenGrid.setValue(0,'pdtCnt',0)
			hiddenGrid.setValue(0,'lineNo',document.getElementById('lineNo').value)
			hiddenGrid.setValue(0,'prcCd',document.getElementById('prcCd').value)
			hiddenGrid.setValue(0,'goalCnt',mainGrid.getValue(ev.rowKey,'goalCnt'))
			
		})
		fltCheck();
	})
	//불량+버튼
	fltAdd.addEventListener('click',ev=>{
		if(hiddenGrid.getValue(0,'goalCnt')*1>hiddenGrid.getValue(0,'pdtCnt')*1+hiddenGrid.getValue(0,'fltCnt')*1){
			hiddenGrid.setValue(0,'fltCnt',hiddenGrid.getValue(0,'fltCnt')*1+1);
			updateFlt();
		}
		else{
			alert("불량량은 목표수량을 초과할수없습니다")
		}
	})
	//불량-버튼
	fltMinus.addEventListener('click',ev=>{
		if(hiddenGrid.getValue(0,'fltCnt')*1>=0){
			hiddenGrid.setValue(0,'fltCnt',hiddenGrid.getValue(0,'fltCnt')*1-1);
			updateFlt();
		}
		else{
			alert("불량이 0보다 적을수 없습니다.")
		}
	})
	function updateFlt(){
		fetch('fltUpdate',{
			method:'POST',
			headers:{
				"Content-Type": "application/json",
			},
			body:JSON.stringify(hiddenGrid.getData())
		})
		.then(response=>response.json())
		.then(result=>{
			console.log(result);  // 
		})
	}

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