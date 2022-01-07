<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<h1>Hello world! ㅋㅋ</h1>

	<P>The time on the server is ${serverTime}.</P>
	<script>
	   fetch("./pdtOrdlist")
	  .then(response=>response.json()) 
	   .then(result=>{
		  console.log("ssssssssssssss")
		  console.log(result)
	  }) 
	</script>
</body>
</html>
