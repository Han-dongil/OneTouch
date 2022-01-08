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