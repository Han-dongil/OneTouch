<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Upload with Ajax</title>
<style>
	.uploadResult{
		width:100%;
		background-color: gray;
	}
	.uploadReslt ul{
		displary:flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
	}
	.uploadResult ul li img{
		width: 100px;
		height: 100px;
	}
</style>
</head>
<body>
	<h1>Upload with Ajax</h1>
	
	<div class ='uploadDiv'>
		<input type = 'file' name='uploadFile' multiple>
	</div>
	<div class='uploadResult'>
		<ul>
		
		</ul>
	</div>
	
	<button id='uploadBtn'>Upload</button>
	
 
	<script type="text/javascript">
	
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
	
	
			var cloneObj = $(".uploadDiv").clone();				//input type=file 복제 값을 아무것도 주지 않고 복제 한다
			
			$("#uploadBtn").on("click", function(e){
				
				var formData = new FormData();
				
				var inputFile = $("input[name='uploadFile']");
				
				var files = inputFile[0].files;		
				console.log(files);
				
				//aadd filedate to formdata
				 for(var i =0; i< files.length; i++){
					 
					 if(!checkExtension(files[i].name, files[i].size)){
						 return false;
					 }
					 formData.append("uploadFile", files[i]);
			} 
			
			$.ajax({
				url: 'uploadAjaxAction',
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				dataType:'json',
				success: function(result){
					console.log(result);
					console.log(cloneObj.html())
					
					showUploadedFile(result);
					$(".uploadDiv").html(cloneObj.html());			//input type=file 초기화
					//alert("Uploaded");
				}
			}); //$.ajax
			
		});
	
	</script> 
</body>
</html>