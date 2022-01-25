<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>설비등록페이지</title>
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<!-- 토스트그리드 cdn -->
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/modal.js"></script>
<style>
	 td>input {
	  width:100px;
	  height:25px;
	  font-size:1px;
	} 
	td{
		font-size:1px;
	}
</style>

</head>
<body>
	<div class="row" >
		<div class="col-4"></div>
		<div class="col-8">
			<div>
				<button type="button" id='btnFind'>조회</button>
				<button type="button" id='btnAdd'>추가</button>
				<button type="button" id='btnDel'>삭제</button>
				<button type="button" id='btnSave'>저장</button>
				<button type="button" id='btnEdit'>수정</button>
			</div>
			<div class="row" style="/* margin-top: 10px; */ border-top: 2px solid black; border-bottom: 2px solid black; padding: 5px;">
				<div class="col-7" style="margin-top: 30px;">
				<form id="infoFrm" method="post" enctype="multipart/form-data">
					<table>
						<tr>
							<td>설비코드</td>
							<td><input type="text" id="fctCd" name="fctCd" value="" /></td>
							<td>모델명</td>
							<td><input type="text" id="fctModel" name="fctModel" value="" /></td>
							<td>사용여부</td>
							<td><input type="checkbox" id="useYn" name="useYn" checked="" /></td>
						</tr>
						<tr>
							<td>설비규격</td>
							<td><input type="text" id="fctStd" name="fctStd" value="" /></td>
							<td>라인번호</td>
							<td><input type="text" id="lineNo" name="lineNo" value="" /></td>
							<td>공정</td>
							<td><input type="text" id="prcCd" name="prcCd" value="" /></td>
							
						</tr>
						<tr>
							<td>입고일</td>
							<td><input type="date" id="inDate" name="inDate" value="" /></td>
							<td>구매금액</td>
							<td>
								<input type="text" id="purchCost" name="purchCost" onkeyup="inputNumberFormat(this)" value="" />원
							</td>
							<td>회사코드</td>
							<td><input type="text" id="compCd" name="compCd" value="" /></td>
						</tr>
						<tr>
							<!-- <td>이미지</td>
							<td><input type="text" id="FctImg" name="FctImg" value="" /></td> -->
							<td>시간당 생산량</td>
							<td><input type="text" id="uphPdtAmt" name="uphPdtAmt"
								value="" /></td>
							<td>담당자</td>
							<td><input type="text" id="empNo" name="empNo" value="" /></td>
							<td>점검주기</td>
							<td><input type="number" id="chkProd" name="chkProd" value="" /></td>
							<td>
								<select id="chkProdUnit" name="chkProdUnit">
									<option value="Y">년</option>
									<option value="M">달</option>
									<option value="W">주</option>
									<option value="D">일</option>
								</select>
							</td>
						</tr>
					</table>
					<div class="col-5">
				<img src="resources/img/아이유.jpg" id="fctImges" style="width: 252px; height: 150px;">
				<div class ='uploadDiv'>
					<td><input style=" margin-bottom: 20px;" type="file" id="fctImg" name="uploadFile" value="" multiple onchange="setThumbnail(event)"/></td>
					<!-- <button id='uploadBtn'>Upload</button> -->
				</div>
				</form>
			</div>
			
			</div>
		</div>
		<div id="dialog-form" title="모달테스트"></div>
			<div id="grid" style=""></div>
	</div> <!-- row -->
	<div id="fctGubundialog-form" title="설비구분"></div>
	<script>
	let dialog; 
	
	//설비업체 Modal start=========================================================================================
	dialog = $( "#dialog-form" ).dialog({   
		autoOpen : false,
		modal : true,
	});

	$("#compCd").on("click", function(){
		mBas('FCT_COM',event.target);
	});	
	function getModalBas(param, btn){ //모달에서 값을 선택했을 때 호출 나중에 주석 풀어서 사용
		console.log('getModalBas 메서드 출력')
		console.log(btn.id)
			if(btn.id == 'fctCd'){
				console.log('공정코드 메소드')
				$("#fctCd").val(param.dtlCd);
				$("#fctNm").val(param.dtlNm);
				console.log(param.dtlCd);
				dialog.dialog('close');
			}
			else if(btn.id == 'compCd'){
				console.log('회사코드 클릭하면 이쪽으로 옴 ')
				$("#compCd").val(param.dtlCd);
				dialog.dialog('close');
			}
		} 

	
	//설비업체 Modal end=========================================================================================
	

	let targetId = [];
	let s = 'd';
   var Grid = tui.Grid;
   //테마옵션 (선언된 그리드 바로빝에 해주면되고 또는 jsp 파일로 만들어서 넣어도됨)
   Grid.applyTheme('striped', {	
        cell: {
        	header: {
	            background: '#4B49AC',
	            text: '#fff'
	        },
	        evenRow: {
	        	background:'#F5F7FF'
	        }
          
        },
        //고정칼럼 색상 설정
        frozenBorder: {
             border: 'red'
        }
      });
   
   //th 영역
    const columns = [
    {
    header: '설비코드',
    name: 'fctCd',
    editor: 'text'
  },
  {
    header: '설비명',
    name: 'fctNm',
    editor: 'text'
  },
  {
    header: '공정',
    name: 'prcCd',
    editor: 'text'
  },
  {
    header: '설비규격',
    name: 'fctStd',
    editor: 'text'
  },
  {
    header: '모델명',
    name: 'fctModel',
    editor: 'text'
  },
  {
    header: '회사코드',
    name: 'compCd'
  },
  {
    header: '사용목적',
    name: 'usePurp'
  },  
  {     
  	//날짜(데이터피커) cdn 받아서 넣었다
     headet: '입고일',
     name: 'inDate',
     editor: 'datePicker'
  }/* ,
  {
    header: '구매금액',
    name: 'purchCost',
    editor: 'text'
  } */
  /* {
    header: '점검주기',
    name: 'chkProd',
    editor: 'text'
  },
  {
    header: '총생산량',
    name: 'totPdtAmt',
    editor: 'text'
  },
  {
    header: 'uph생산량',
    name: 'uphPdtAmt',
    editor: 'text'
  },
  {
    header: '사번',
    name: 'empNo',
    editor: 'text'
  } */
    ]
   
	
	let data;
    let dataVO;
    let checkPrcCd = 'd';    	//검색 조건을 사용하지 않지만 검색 메소드 매개변수에 vo가 있기 때문에 쓰레기 값을 넣어준다. 
    let vo={};					//map형식으로 보내주기 위해서 초기화 
    vo.checkPrcCd=checkPrcCd;   //vo에 키 값을 정해서 밸류 값을 넣어주는 초기화 
    
   //ajax 요청
	  
	  $.ajax({
		  url:'./list1',	//나중에 이거 대신에 컨트롤러 요청하면 됨 
		  method: 'POST',
		  data: JSON.stringify(vo),
		  contentType: "application/json",
		  async : false					//동기 = 절차적 
	  }).done(function(datas){
		  console.log(datas)
		  data = datas;
	  }) 
   
  
/*    const dataSource = {
		  api: {
		    readData: { url: 'list',
		    	method: 'GET',
		    	initParams: { param: 'param' } },				//data = initParams
		  modifyData: { url: '${pageContext.request.contextPath}/modifyData', method: 'PUT' },
		  },
		  contentType:'application/json'
		};  */
  //그리드를 id 값안에다가 붙여넣어준다.
  const grid = new Grid({
         el: document.getElementById('grid'),
         data:data,  //이름이 같다면 생격가능
         rowHeaders : [ 'checkbox' ],
         columns,
         bodyHeight: 600,
 		 minBodyHeight: 600,
 		/* columnOptions: {
 			minWidth
 			 } */
         //고정컬럼 (스크롤이 움직여도 고정되서 보인다)
         /* columnOptions: {
              frozenCount: 2, // 3개의 컬럼을 고정하고
              frozenBorderWidth: 3 // 고정 컬럼의 경계선 너비를 3px로 한다.
            } */
         });
    
	grid.on('click',(ev) =>{
		
		dataVO = data[ev.rowKey];
		console.log(dataVO.useYn)
		
		document.getElementById('fctCd').value = dataVO.fctCd;
		document.getElementById('fctNm').value = dataVO.fctNm;
		document.getElementById('useYn').value = (dataVO.useYn=='Y')?'true':'false';
		document.getElementById('prcCd').value = dataVO.prcCd;
		document.getElementById('fctStd').value = dataVO.fctStd;
		document.getElementById('fctModel').value = dataVO.fctModel;
		document.getElementById('compCd').value = dataVO.compCd;
		document.getElementById('inDate').value = dataVO.inDate;
		document.getElementById('purchCost').value = dataVO.purchCost;
		document.getElementById('chkProd').value = dataVO.chkProd;
		document.getElementById('fctImg').value = dataVO.fctImg;
		document.getElementById('uphPdtAmt').value = dataVO.uphPdtAmt;
		document.getElementById('empNo').value = dataVO.empNo;
		//document.getElementById('fctNm').value = dataVO.fctNm;
		
	})
    
    //클릭 이벤트 그리드
    grid.on('check', (ev) => {
    	
    	let vo = {fctCd:""};
       vo.fctCd = data[ev.rowKey].fctCd;
      console.log(vo)
      targetId.push(vo);
      
      console.log(targetId)
    	  
    })
      
         	
       
    grid.on('response', function(ev) {
    	   console.log(ev);
    	   grid.resetOriginData()	//현재 데이터를 변경된 데이터로 확장한다. 
       })
       
       btnAdd.addEventListener("click", function(){
    	   grid.appendRow({})
       })
       btnDel.addEventListener("click", function(){
    	   //삭제 아작스 처리
    	      	
    	   		
    	      $.ajax({
    	    	  
    	    	  url: "./deleteInfo",
    	    	  method: "POST",
    	    	  data: JSON.stringify(targetId),			//json을 string으로 바꿔줘야함 
    	    	  contentType:"application/json",			//넘겨주는 데이터가 json이라는 걸 알려주는 것 
    	    	  success:function(result){
    	    		  console.log('성공')
    	    		  grid.resetData(result)
    	    		  targetId.length = 0;
    	    	  }
    	   
       		})
       })
       
        btnSave.addEventListener("click", function(){
        	console.log('11111111111111')
        	//console.log($('#infoFrm').serialize())
        	
        	let infoForm = document.getElementById('infoFrm')
        	var formData = new FormData(infoForm);
        	console.log(formData)
			
			
    	   //등록아작스 
    	    $.ajax({
    	    	  
    	    	  url: "./infoInsert",
    	    	  processData: false,
  				  contentType: false,
    	    	  method: "POST",
    	    	  data:formData,
    	    	  dataType:'Json',
    	    	  success:function(result){
    	    		  console.log('성공')
    	    		  grid.resetData(result)
    	    	  }
    	   
       		})
    	   //grid.request('modifyData');
       })//add버튼 
       
   	
		//설비구분 Modal start=========================================================================================
		//let dialog; //가져가서 사용할 때는 주석 풀어서 사용(이미 있다면 let선언 빼주거나 아니면 dialog 이름 바꿔서 사용)
		
		$("#fctCd").on("click", function(){
			console.log('설비코드 버튼 클릭')
			mBas('FCT_DIV',event.target);
		})
		$("#fctNm").on("click", function(){
			console.log('설비이름 버튼 클릭')
			mBas('FCT_DIV',event.target);
		})
	
		//설비구분 Modal end=========================================================================================
		
       //공정 Modal start=========================================================================================
		//let dialog; //가져가서 사용할 때는 주석 풀어서 사용(이미 있다면 let선언 빼주거나 아니면 dialog 이름 바꿔서 사용)
		//dialog = $( "#dialog-form" ).dialog({ //갸져가서 주석 풀어서 사용 이미 있으면 빼고해도 됨     //<div id="dialog-form" title="title"></div> 같이 가져갈 것
		//	autoOpen : false,
		//	modal : true,
		//});
		
		$("#prcCd").on("click", function(){
			mPrc();
		})
		//라인 input 클릭 이벤트 
		$("#lineNo").on("click", function(){
			mLine();
		})
		
		function getModalPrc(param){//모달에서 값을 선택했을 때 호출
			//선택한 값 parameter받아서 각자 처리
			$("#prcCd").val(param.prcCd);
			console.log(param);
			dialog.dialog("close");
		}
		//공정 Modal end=========================================================================================
       
       
       btnFind.addEventListener("click", function(){
    	   //grid.;
    	   
       }) 
       //수정 아작스 
       btnEdit.addEventListener("click", function(){
    	   console.log('수수수수수수수저엊어ㅓ저어저어정')
    	   $.ajax({
 	    	  url: "./Updateinfo",
 	    	  method: "POST",
 	    	  data:$('#infoFrm').serialize(),
 	    	  dataType:'Json',
 	    	  			
 	    	  success:function(result){
 	    		  console.log('성공')
 	    		  grid.resetData(result)
 	    	  }
 	   
    		})
       })
       //금액 천단위 구분 기호 함수
       function inputNumberFormat(obj) {
			obj.value = comma(uncomma(obj.value));
		}
       function comma(str) {
    	     str = String(str);
    	     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    	 }

    	 function uncomma(str) {
    	     str = String(str);
    	     return str.replace(/[^\d]+/g, '');
    	 }
    	 //천단위 구분 기호 끝


       
	function setThumbnail(event) { 
		
		var reader = new FileReader(); 
		reader.onload = function(event) { 
			
			document.getElementById('fctImges').setAttribute("src", event.target.result); 
			
		}; 
		reader.readAsDataURL(event.target.files[0]); 
	}
    	 
	var regex = new RegExp("(/*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;	//5MB
	
	var uploadResult = $(".uploadResult ul");
	
	//이미지파일 보여주기 
	function showUploadedFile(uploadResultArr){
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
			console.log(obj);
			if(!obj.image){
				str +="<li><img src='/resources/img/images.jpg'>"+obj.fileName+"</li>";
			}else{
				//str +="<li>"+ obj.fileName+"</li>";
				
				var fileCallPath = encodeURIComponent( obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				
				str += "<li><img src='display?fileName="+fileCallPath+"'></li>";
			}
		});
		uploadResult.append(str)
	}
	
/* 	//파일 이름을 목록으로 보여주는 부분 함수
	function showUploadedFile(uploadResultArr){
		var str = "";
		console.log('show')
		console.log(uploadResultArr)
		
		$(uploadResultArr).each(function(i, obj){
			str += "<li>" + obj.fileName + "</li>"; 
		});
		uploadResult.append(str);
	}// end showUploadeFile
	 */
	console.log('uploadResult'+uploadResult)
	
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할수 없습니다.");
			return false;
		}
		return true;
	}
	
	
			
			
			
			
	
	

</script>

</body>
</html>