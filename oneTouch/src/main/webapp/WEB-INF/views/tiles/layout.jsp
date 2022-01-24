<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>OneTouch</title>


<!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Skydash Admin</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="${path}/resources/template/vendors/feather/feather.css">
  <link rel="stylesheet" href="${path}/resources/template/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="${path}/resources/template/vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="${path}/resources/template/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="${path}/resources/template/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" type="text/css" href="${path}/resources/template/js/select.dataTables.min.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="${path}/resources/template/css/vertical-layout-light/style.css">
    <link rel="stylesheet" href="${path}/resources/template/css/newstyle.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="${path}/resources/template/images/favicon.png" />
    <!-- plugins:js -->
  <script src="${path}/resources/template/vendors/js/vendor.bundle.base.js"></script>
 
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
  
  <script src="${path}/resources/template/json.min.js"></script>

</head>
<body>
	<div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <header><tiles:insertAttribute name="header" /></header>
    
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
      <!-- partial:partials/_settings-panel.html -->
      <sidebar><tiles:insertAttribute name="sidebar" /></sidebar>
      
      <!-- partial -->
      
      <!-- partial:partials/_sidebar.html -->
      <nav><tiles:insertAttribute name="nav" /></nav>
      
      <!-- partial -->
      <div class="main-panel">
        <article>
			<tiles:insertAttribute name="content" />
		</article>
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
        <footer><tiles:insertAttribute name="footer" /></footer>
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>   
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->


  <!-- endinject -->
  <!-- Plugin js for this page -->
  <script src="${path}/resources/template/vendors/chart.js/Chart.min.js"></script>
  <script src="${path}/resources/template/vendors/datatables.net/jquery.dataTables.js"></script>
  <script src="${path}/resources/template/vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
  <script src="${path}/resources/template/js/dataTables.select.min.js"></script>

  <!-- End plugin js for this page -->
  <!-- inject:js -->
  <script src="${path}/resources/template/js/off-canvas.js"></script>
  <script src="${path}/resources/template/js/hoverable-collapse.js"></script>
  <script src="${path}/resources/template/js/template.js"></script>
  <script src="${path}/resources/template/js/settings.js"></script>
  <script src="${path}/resources/template/js/todolist.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="${path}/resources/template/js/dashboard.js"></script>
  <script src="${path}/resources/template/js/Chart.roundedBarCharts.js"></script>
  <!-- End custom js for this page-->
    
 
</body>
</html>