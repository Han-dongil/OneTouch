<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통계</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>

<form action="">
	<div>
		<label>해당일자</label>
		<input type="Date" id="startDate" name="startDate">&nbsp;
		<label> ~ </label>&nbsp;
		<input type="Date" id="endDate" name="endDate">
	</div>
</form>
<div id="tabs">
	<ul>
	  <li><a href="#mtrIn">자재입고량</a></li>
	  <li><a href="#mtrOut">자재출고량</a></li>
	  <li><a href="#pdtCnt">제품생산량</a></li>
	  <li><a href="#fltCnt">제품불량량</a></li>
	</ul>
	<div id="mtrInTab"></div>
	<div id="mtrOutTab"></div>
	<div id="pdtCntTab"></div>
	<div id="fltCntTab"></div>
</div>
<script type="text/javascript">

//---------Jquery tabs---------
$( function() {
    $( "#tabs" ).tabs({
    	activate: function( event, ui ) {
    		if(ui.newTab[0].innerText == '자재입고량'){
    			mtrInGrid.refreshLayout();
    		} /* else if(ui.newTab[1].innerText == '자재출고량'){
    			mtrOutGrid.refreshLayout();
    		} else if(ui.newTab[1].innerText == '제품생산량'){
    			pdtCntGrid.refreshLayout();
    		} else {
    			fltCntGrid.refreshLayout();
    		} */
    	}
    });
});
//---------Jquery tabs 끝---------

//---------mtrInGrid---------
//컬럼
const mtrInColumns = [{
		header:'입고일',
		name:'inDate',
		align: 'center'
	},
	{
		header:'자재코드',
		name:'mtrCd',
		align: 'center'
	},
	{
		header:'입고량',
		name:'cnt',
		align: 'center'
	}];
	
//데이터소스	
const mtrInDataSource = {
		api: {
			readData: { 
				url: './mtrInDate', 
				method: 'GET' 
			}
		},
		contentType: 'application/json'	
	};

//그리드
const grid1 = new Grid({
	el: document.getElementById('mtrInTab'),
	columns: columns1,
	data: dataSource1,
	scrollY : true
})

//---------mtrInGrid 끝---------
//---------mtrOutGrid---------
//---------mtrOutGrid 끝---------
//---------pdtCntGrid---------
//---------pdtCntGrid 끝---------
//---------fltCntGrid---------
//---------fltCntGrid 끝---------




//---------Grid 깨지는거 refresh---------
/* window.setTimeout(function(){mtrOutGrid.refreshLayout()}, 300);
window.setTimeout(function(){pdtCntGrid.refreshLayout()}, 300);
window.setTimeout(function(){fltCntGrid.refreshLayout()}, 300); */
//---------Grid 깨지는거 refresh끝---------

</script>
</body>
</html>