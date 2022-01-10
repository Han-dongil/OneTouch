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
			<button type="button" id="btnFind">조회</button>
			<button type="button" id="btnAdd">추가</button>
			<button type="button" id="btnDel">삭제</button>
			<button type="button" id="btnSave">저장</button>
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
const dataSource = {
		  api: {
		    readData: { url: './mtrInList', 
				    	method: 'GET', 
				    	/* initParams: { param: 'param' } */ },
	    	modifyData: { url: './mtrModify', 
	    				method: 'POST' }
		  },
		  contentType: 'application/json',
		};

      
//조건조회 ajax
function search(){
 $.ajax({
   url:'./mtrInList',
   method: 'POST',
   data:$("#frm").serialize(),
   dataType:'json',
   async : false
}).done(function(datas){
   grid.resetData(datas);
   //grid.resetOriginData();
});
}

const grid = new Grid({
     el : document.getElementById('grid'),
     data : dataSource,  // 컬럼명과 data명이 같다면 생략가능 
     rowHeaders : [ 'checkbox'],  //check박스 추가
     columns
   });
   
/*  
grid.on('response', function(ev) {
      // 성공/실패와 관계 없이 응답을 받았을 경우
      
      console.log(ev);
      grid.resetOriginData();
   });
*/
$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		} 
	});
	return o;
};
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
   /* let a= $("#frm").serialize();
   let a= $("#frm").serializeArray(); */
   let a= $("#frm").serializeObject();
   console.log(a);
   grid.readData(1,a,true);
})
</script>
</body>
</html>