<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<title>Insert title here</title>
</head>
<body>

	<div id="mtr_grid"></div>
	
	<script type="text/javascript">
		let mtrGrid = tui.Grid;
		
		const mtrColumns = [
		       {
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
		        }
		      ]
		
		const mtrData = [
			  {
			    id: '10012',
			    city: 'Seoul',
			    country: 'South Korea'
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
			    city: 'Reykjavik',
			    country: 'Iceland'
			  }
			];
		
		mtrGrid = new Grid({
			el : document.getElementById('mtr_grid'),
			data : mtrData,
			columns : mtrColumns
		});
		
		mtrGrid.on('dblclick', ev => {
			console.log(mtrGrid.getRow(ev.rowKey)) //ajax result(ev.rowKey)
		})
	
	
		/* $("a").on("click", function(){
			var co = $(this).html();
			selectCo(co);
		}) */
	</script>
</body>
</html>