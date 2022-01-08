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
	<h3>토스트 그리드d</h3>
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
   });
const columns = [
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
          name: 'city',
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
            header: '입고량',
            name: 'inAmt'
        },
        {
            header: '단가',
            name: 'unitCost'
        },
        {
            header: '입고일자',
            name: 'inDate'
        }
      ]
let dataSource;

//ajax요청
$.ajax({
   url:'./mtrInList',
   dataType:'json',
   async : false
}).done(function(datas){
   dataSource = datas; 
   console.log('111111111111')
});
/* const dataSource = {
        api: {
          readData: { url: './mtrInList', 
                   method: 'GET',
                   initParams: { param: 'param' } }
        },
        contentType: 'application/json'
      }; */

const grid = new Grid({
     el : document.getElementById('grid'),
     data : dataSource,  // 컬럼명과 data명이 같다면 생략가능 
     rowHeaders : [ 'checkbox'],  //check박스 추가
     columns
   });
   
/* grid.on('click', (ev) => {
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
}) */
</script>
</body>
</html>