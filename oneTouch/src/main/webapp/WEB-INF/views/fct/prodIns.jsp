<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 토스트그리드 cdn -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<!-- 토스트 그리드 위에 데이트피커 가 선언되어야 작동이 된다 (순서가중요) -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>

<!-- 토스트그리드 cdn -->
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>

<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>

<div>




	<div style="margin-top: 10px; border-top: 2px solid black; border-bottom: 2px solid black; padding: 5px;">
		<form id="fixFrm" method="post">
		<span style="margin-left: 100px;">
			<label>해당일자</label>
			<input type="Date" id="fixFrom" name="fixFrom"> 
			<label> ~ </label> 
			<input type="Date" id="fixTo" name="fixTo">
		
		
			<label>설비구분</label>
			<select id="fctCd" name="fctCd"></select>
		
	</form>
		<button type="button" id='btnFind'>조회</button>
		<button type="button" id='btnAdd'>추가</button>
		<button	type="button" id='btnDel'>clear</button>
		<button type="button" id='btnSave'>저장</button>
		</span>
		</div>
		<div>
		<button style="background: #4b49ac; width: 150px;color: white; height: 80px; "  type="button" id='prodChekCompleteBtn'>
			점검완료등록
		</button>
	</div>
	
	
	
</div>
	<div id="dialog-form" title="점검대상">점검대상 목록</div>
	<div id="grid"></div>
	
	
<script>


	let Grid = tui.Grid;
	let data;
	let prodCheckObj;	//점검대상인 데이터를 담는 변수
	let dialog;
	
	Grid.applyTheme('striped', {	
        cell: {
          header: {
            background: '#eef'
          },
          evenRow: {
            background: '#fee'
          }
          
        },
        //고정칼럼 색상 설정
        frozenBorder: {
             border: 'red'
        }
      });
	
	 dialog = $( "#dialog-form" ).dialog({ //<div id="dialog-form" title="title"></div> 같이 가져갈 것  //(이미 있다면 let선언 빼주거나 아니면 dialog 이름 바꿔서 사용)
		autoOpen : false,
		modal : true,
		resizable: false,
		height: "auto",
		width: 300, //530,  제품모달은 사이즈 530정도로~~
		modal: true,
		/* maxHeight: 600
		maxWidth: 600
		minHeight: 200
		minWidth: 200
		position: { my: "left top", at: "left bottom", of: button } */
	});
	
	
//  let dataSource; //그리드에 들어갈 데이터변수
	 var dataSource = {
		 initialRequest: false,
		 api: {
			readData: { url: './prodSelect',method: 'POST'},
			//createData: { url: '/api/create', method: 'POST' },
			//updateData: { url: '/modifyData', method: 'POST' },
			//deleteData: { url: '/api/delete', method: 'DELETE' },
			modifyData: { url: './fctModifyData', method: 'POST' }  
		 },
		 contentType: 'application/json',
	 };
   
   //th 영역
    const columns = [
    {
    header: '정기점검이력번호',
    name: 'prodChkNo',
    editor: 'text'
  },
  {
    header: '설비코드',
    name: 'fctCd',
    editor: 'text'
  },
  {
	    header: '설비이름',
	    name: 'fctNm',
	    editor: 'text'
  },
  {
    header: '점검일자',
    name: 'chkDt',
    editor: 'text'
  },
  {
    header: '차기점검일',
    name: 'chkExpectDt',
    editor: 'text'
  },
  {
    header: '판정',
    name: 'chkRslt',
    editor: 'text'
  },
  {
    header: '조치사항',
    name: 'msrMtt'
  },
  {
    header: '조치내역',
    name: 'msrCmt',
    editor: 'text'
  }
    ]
   
	let grid = new Grid({
	    el: document.getElementById('grid'),
	    data:dataSource,  //이름이 같다면 생격가능
	    rowHeaders : [ 'checkbox' ],
	    columns
	 });
   

    btnFind.addEventListener("click", function(){
    	checkRdo();
    	
    })
   
   btnDel.addEventListener("click", function(){
	   grid.removeCheckedRows(true);
   });
	   
   
	   
   //등록버튼
   btnAdd.addEventListener("click", function() {
		grid.appendRow({})
   });	
   
   btnSave.addEventListener("click", function() {
   		
   });
   
   //점검완료 등록 이벤트 
   prodChekCompleteBtn.addEventListener("click", function() {
   	
	   console.log('점검완료 등록')
	   dialog.dialog( "open" );
	   prodChekSelect();
   });
	 
   // 조회를 하기 위한 조건데이터를 form직렬화를 시켜서 json 타입으로 readData로 넘겨주는 함수 
   function checkRdo(){
	   let checkFormdata = $("#fixFrm").serializeObject();
    	console.log('&&&&&&&&&&&&&&&&&')
    	console.log(checkFormdata);
    	grid.readData(1,checkFormdata, true);	
	}
	
	//점검대상 모달에 조회 
	function prodChekSelect(){
		fetch('prodChekList',{
			method:'POST',
			body: JSON.stringify(data),
			headers:{
				'Content-Type' : 'application/json'
			}
		})
		.then(response=>response.json())
		.then(result=>{
			prodCheckObj=result;
			console.table(prodCheckObj);
			//grid.resetData(result)
		})
	}
	
	
	 //공정 코드 조회 ajax 요청

		$.ajax({
			url:'selectFixPrc',
			dataType: 'json',
			async : false
		}).done(function(datas){
			console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
			console.log(datas)
			$('#fctCd').append("<option value='d'>전체</option>")
			for(let data of datas){
				$('#fctCd').append("<option value="+data.dtlCd+">"+data.dtlNm+"</option>")
			}
		}) 
	   

</script>
</body>
</html>