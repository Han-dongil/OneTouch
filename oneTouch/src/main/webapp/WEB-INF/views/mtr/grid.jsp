<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>
<body>
	<h3>토스트 그리드</h3>
<div>
   <button type="button" id="btnFind">조회</button>
   <button type="button" id="btnAdd">추가</button>
   <button type="button" id="btnDel">삭제</button>
   <button type="button" id="btnSave">저장</button>
</div>
<div id="grid"></div>
<script type="text/javascript">
var Grid = tui.Grid;
Grid.applyTheme('striped', { //cell style
     cell: {
       header: {
         background: '#eef'
       },
       evenRow: {
         background: '#fee'
       }
     },
     frozenBorder: {
          border: '#ff0000'
        }
   });
const columns = [
       {//column name들
          header: 'ID',
          name: 'id'
        },
        {
          header: 'CITY',
          name: 'city',
          editor: 'text'
        },
        {
          header: 'COUNTRY',
          name: 'country'
        },
        {
          header: '작업일자',
          name: 'wdate',
          editor: 'datePicker'
        },
        {//select box
          header: 'BROWSER',
          name: 'browser',
          formatter: 'listItemText',
          editor: {
            type: 'select',
            options: {
              listItems: [
                { text: 'IE 9', value: 1 },
                { text: 'IE 10', value: 2 },
                { text: 'IE 11', value: 3 },
                { text: 'Firefox', value: 4 },
                { text: 'Chrome', value: 5 }
                 ]
               }
             }        
           }
      ]
      
/* const data = [
     {
       id: '10012',
       city: 'Seoul',
       country: 'South Korea',
       wdate: '2022-01-06'
     },
     {
       id: '10013',
       city: 'Tokyo',
       country: 'Japan'    
     },
     {
       id: '10014',
       city: 'London',
       country: 'England'
     },
     {
       id: '10015',
       city: 'Ljubljana',
       country: 'Slovenia'
     },
     {
       id: '10016',
       city: 'Reykjavik dddddddddddddddddddddd',
       country: 'Iceland'
     }
   ];
    */
let data;

//ajax요청
/* $.ajax({
   url:'${pageContext.request.contextPath}/resources/json/city.json',
   data : {},
   dataType:'json',
   async : false
}).done(function(datas){
   data = datas; 
}); */
const dataSource = {
        api: {
          readData: { url: '${pageContext.request.contextPath}/resources/json/city.json', 
                   method: 'GET', 
                   initParams: { param: 'param' } },
          modifyData: { url: '${pageContext.request.contextPath}/modifyData', 
                   method: 'PUT' }
        },
        contentType: 'application/json',
      };

const grid = new Grid({
     el : document.getElementById('grid'),
     data : dataSource,  // 컬럼명과 data명이 같다면 생략가능 
     rowHeaders : [ 'checkbox'],  //check박스 추가
     columns,
     columnOptions: {
        frozenCount: 2,  //브라우저 크기 줄여도 해당 컬럼들 크기는 고정
        frozenBorderWidth: 2
     }
   });
   
grid.on('click', (ev) => {
      console.log(ev);
        console.log('clicked!!');
   });
   
grid.on('response', function(ev) {
      // 성공/실패와 관계 없이 응답을 받았을 경우
      
      console.log(ev);
      grid.resetOriginData();
   });

btnAdd.addEventListener("click", function(){
   grid.appendRow({});
})
btnDel.addEventListener("click", function(){
   grid.removeCheckedRows(true);
})
btnSave.addEventListener("click", function(){
   grid.request('modifyData');
})
btnFind.addEventListener("click", function(){
   //grid.request('modifyData');
})
</script>
</body>
</html>








<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</head>
<body>
	<div class="container">
		<h3>자재입고 조회</h3>
		<form id="frm" method="post">
			<div>
				<div>
					<label>해당일자</label>
					<input type="Date" id="from" name="from"> 
					<label> ~ </label> 
					<input type="Date" id="to" name="to">
				</div>
				<div>
					<label>입고업체</label>
					<input type="text" id="inComCd" name="inComCd">
					<button type="button" id="btnInCom">검색</button>
					<input type="text" id="InComName" name="InComName" readonly="true">
					<!-- <span>~</span>
					<input type="text" id="searchKeywordTo" name="searchKeywordTo">
					<button type="button" id="entrpsPopBtn1">검색</button>
					<input type="text" id="searchKeywordToNm" readonly="true"> -->
				</div>
				<div>
					<label>자재코드</label>
					<input type="text" id="dItemcode" name="dItemcode">
					<button type="button" id="matrPopBtn">검색</button>
					<label>자재명</label>
					<input type="text" id="dItemcodeNm" name="dItemcodeNm" readonly="readonly">
				</div>
				<div>
					<label>정렬구분</label>
					<div>
						<label>
							<span>일자</span>
						</label>
						<input type="radio" name="orderBy" value="dDate" id="radio-1" checked="checked">
						<label>
							<span>업체</span>
						</label>
						<input type="radio" name="orderBy" value="dCompanyNm" id="radio-2"> 
							<label>
								<span>자재</span>
							</label>
						<input type="radio" name="orderBy" value="dItemcode" id="radio-3">
					</div>
				</div>
				<div>
					<button type="button" id="searcnBtn">조회</button>
					<button type="button" id="resetBtn">새자료</button>
					<button type="button" id="excelBtn">Excel</button>
					<button type="button" id="printBtn">인쇄</button>
				</div>
			</div>
		</form>
		<div>
			<button type="button" id="btnFind" onclick="search()">조회</button>
			<button type="button" id="btnAdd">추가</button>
			<button type="button" id="btnDel" onclick="delRow()">삭제</button>
			<button type="button" id="btnSave">저장</button>
		</div>
	</div>
<div id="grid"></div>

<script type="text/javascript">
let checked = [];

var Grid = tui.Grid;
Grid.applyTheme('striped', { //cell style
     cell: {
       header: {
         background: '#eef'
       },
       evenRow: {
         background: '#fee'
       }
     },
   });
const columns = [
		
        {
          header: '입고번호',
          name: 'inNo',
          hidden: true
        },
        {
        header: '업체',
        name: 'comNm'
	    },
        {
          header: '입고일자',
          name: 'inDate'
        },
       	{//column name들
          header: '자재코드',
          name: 'mtrCd'
        },
        {
          header: '자재명',
          name: 'mtrNm',
        },
        {
          header: '단위',
          name: 'unit',
        },
        {
          header: '발주번호',
          name: 'ordNo',
        },
        {
          header: '불량량',
          name: 'fltAmt',
		  editor: 'text'
        },
        {
          header: '입고량',
          name: 'inAmt',
          editor: 'text'
        },
        {
          header: '단가',
          name: 'unitCost'
        },
        {
          header: '총금액',
          name: 'totCost'
        }
      ]
/* const dataSource = {
		  api: {
		    readData: { url: './mtrInList', 
				    	method: 'GET', 
				    	initParams: { param: 'param' } },
	    	modifyData: { url: './mtr', 
	    				method: 'POST' }
		  },
		  contentType: 'application/json',
		}; */
let dataSource;
      
//조건조회 ajax
function search(){
 $.ajax({
   url:'./mtrInList',
   method: 'POST',
   data:$("#frm").serialize(),
   dataType:'json',
   async : false
}).done(function(datas){
	console.log(datas)
   dataSource = datas;
   grid.resetData(dataSource);
   //grid.resetOriginData();
});
}

const grid = new Grid({
     el : document.getElementById('grid'),
     data : dataSource,  // 컬럼명과 data명이 같다면 생략가능 
     rowHeaders : [ 'checkbox'],  //check박스 추가
     columns
   });
//체크박스 선택
 grid.on('check', (ev) => {
	/*  vo.inNo = dataSource[ev.rowKey].inNo */;
      /* checked.push(dataSource[ev.rowKey]) */
      checked.push(grid.getValue(ev.rowKey,'inNo'));
      console.log(grid.getValue(ev.rowKey,'_checked'));
      
      console.log("checked"+checked)
   });
   
//체크박스 해제하는 펑션도 추가해주기
 grid.on('check', (ev) => {
	/*  vo.inNo = dataSource[ev.rowKey].inNo */;
      /* checked.push(dataSource[ev.rowKey]) */
      checked.push(grid.getValue(ev.rowKey,'inNo'));
      console.log("checked"+checked)
   });
   
//체크row 삭제 ajax
function delRow(){
	$.ajax({
		url:'./mtrDelRow',
		method: 'POST',
		contentType: "application/json",
		data: JSON.stringify(checked),
		success: function(datas){
			//grid.resetOriginData();
			/* grid.resetData(datas);
			//readData
			checked.length=0; */
			search();
		}
	})
};

/*const dataSource = {
        api: {
          readData: { url: './mtrInList', 
                   method: 'GET',
                   initParams: { param: 'param' } }
        },
        contentType: 'application/json'
      }; */

   
/*  
grid.on('response', function(ev) {
      // 성공/실패와 관계 없이 응답을 받았을 경우
      
      console.log(ev);
      grid.resetOriginData();
   });
*/
btnAdd.addEventListener("click", function(){
   grid.appendRow({});
})
btnDel.addEventListener("click", function(){
   grid.removeCheckedRows(true);
})
btnSave.addEventListener("click", function(){
   grid.request('modifyData');
})
btnFind.addEventListener("click", function(){
   //grid.request('modifyData');
   search();
})
</script>
</body>
</html>









