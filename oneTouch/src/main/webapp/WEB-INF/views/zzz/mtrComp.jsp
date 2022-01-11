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

	<div id="m_grid"></div>
	
	<script type="text/javascript">
		let mGrid = tui.Grid;
		
		const mColumns = [
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
		
		const mData = [
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
		
		mGrid = new Grid({
			el : document.getElementById('m_grid'),
			data : mData,
			columns : mColumns
		});
		
		mGrid.on('dblclick', ev => {
			console.log(mGrid.getRow(ev.rowKey)) //ajax result(ev.rowKey)
		})
	
	
		/* $("a").on("click", function(){
			var co = $(this).html();
			selectCo(co);
		}) */
	</script>
</body>
</html>