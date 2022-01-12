<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />

<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>

</head>
<body>
	<div class="container">
		<h3>자재입고 조회</h3>
		<form id="frm" method="post">
			<div>
				<div>
					<label>해당일자</label>
					<input type="Date" id="startDate" name="startDate"> 
					<label> ~ </label> 
					<input type="Date" id="endDate" name="endDate">
				</div>
				<div>
					<label>입고업체</label>
					<input type="text" id="inComCd" name="inComCd">
					<button type="button" id="btnInCom">ㅇ</button>
					<input type="text" id="inComName" name="inComName" readonly="true">
				</div>
				<div>
					<label>자재코드</label>
					<input type="text" id="ditemCode" name="ditemCode">
					<button type="button" id="matrPopBtn">ㅇ</button>
					<label>자재명</label>
					<input type="text" id="dItemCodeNm" name="dItemCodeNm" readonly="readonly">
				</div>
			</div>
		</form>
		<div align="right">
		<hr>
			<button type="button" id="btnFind">조회</button>
		</div>
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
const dataSource = {
		  api: {
		    readData: { url: './mtrInList', method: 'POST' },
	    	modifyData: { url: './mtrModify', method: 'POST' }
		  },
		  contentType: 'application/json',
		  initialRequest: false  
		};

var grid = new Grid({
     el : document.getElementById('grid'),
     data : dataSource,  // 컬럼명과 data명이 같다면 생략가능 
     rowHeaders : [ 'checkbox'],
     columns : [
				{
				   header: '입고번호',
				   name: 'inNo',
				   hidden: true
				 },
				 {
				   header: '입고일자',
				   name: 'inDate',
				   /* editor: {
						type: 'datePicker',
						options: {
						language: 'ko',
						format: 'YYYY-MM-dd'
						}
					}, */
				   sortable: true
				 },
					{
				   header: '자재코드',
				   name: 'mtrCd',
				   sortable: true
				 },
				 {
				   header: '자재명',
				   name: 'mtrNm',
				   sortable: true
				 },
				 {
				   header: '단위',
				   name: 'unit',
				   sortable: true
				 },
				 {
				   header: '업체',
				   name: 'comNm',
				   sortable: true
				 },
				 {
				   header: '발주번호',
				   name: 'ordNo',
				   sortable: true
				 },
				 {
				   header: '불량량',
				   name: 'fltAmt',
				   sortable: true
				 },
				 {
				   header: '입고량',
				   name: 'inAmt',
				   sortable: true
				 },
				 {
				   header: '단가',
				   name: 'unitCost',
				   sortable: true
				 },
				 {
				   header: '총금액',
				   name: 'totCost',
				   sortable: true
				 }
				]
     
   });
   
  
grid.on('response', function(ev) {
      grid.resetOriginData();
   });
 
btnFind.addEventListener("click", function(){
   let a= $("#frm").serializeObject();
   grid.readData(1,a,true);
})
</script>
</body>
</html>