<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />

<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="${path}/resources/js/grid-common.js"></script>
<script src="${path}/resources/js/modal.js"></script>
<script src="${path}/resources/js/toastr-options.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div class="row">
		<div class="col-lg-6 grid-margin stretch-card">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">Hoverable Table</h4>
					<p class="card-description">
						Add class
						<code>.table-hover</code>
					</p>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>User</th>
									<th>Product</th>
									<th>Sale</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Jacob</td>
									<td>Photoshop</td>
									<td class="text-danger">28.76% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-danger">Pending</label></td>
								</tr>
								<tr>
									<td>Messsy</td>
									<td>Flash</td>
									<td class="text-danger">21.06% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-warning">In progress</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">Fixed</label></td>
								</tr>
								<tr>
									<td>Peter</td>
									<td>After effects</td>
									<td class="text-success">82.00% <i class="ti-arrow-up"></i></td>
									<td><label class="badge badge-success">Completed</label></td>
								</tr>
								<tr>
									<td>Dave</td>
									<td>53275535</td>
									<td class="text-success">98.05% <i class="ti-arrow-up"></i></td>
									<td><label class="badge badge-warning">In progress</label></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">Hoverable Table</h4>
					<p class="card-description">
						Add class
						<code>.table-hover</code>
					</p>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>User</th>
									<th>Product</th>
									<th>Sale</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Jacob</td>
									<td>Photoshop</td>
									<td class="text-danger">28.76% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-danger">Pending</label></td>
								</tr>
								<tr>
									<td>Messsy</td>
									<td>Flash</td>
									<td class="text-danger">21.06% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-warning">In progress</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">Fixed</label></td>
								</tr>
								<tr>
									<td>Peter</td>
									<td>After effects</td>
									<td class="text-success">82.00% <i class="ti-arrow-up"></i></td>
									<td><label class="badge badge-success">Completed</label></td>
								</tr>
								<tr>
									<td>Dave</td>
									<td>53275535</td>
									<td class="text-success">98.05% <i class="ti-arrow-up"></i></td>
									<td><label class="badge badge-warning">In progress</label></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">Hoverable Table</h4>
					<p class="card-description">
						Add class
						<code>.table-hover</code>
					</p>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>User</th>
									<th>Product</th>
									<th>Sale</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Jacob</td>
									<td>Photoshop</td>
									<td class="text-danger">28.76% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-danger">Pending</label></td>
								</tr>
								<tr>
									<td>Messsy</td>
									<td>Flash</td>
									<td class="text-danger">21.06% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-warning">In progress</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">Fixed</label></td>
								</tr>
								<tr>
									<td>Peter</td>
									<td>After effects</td>
									<td class="text-success">82.00% <i class="ti-arrow-up"></i></td>
									<td><label class="badge badge-success">Completed</label></td>
								</tr>
								<tr>
									<td>Dave</td>
									<td>53275535</td>
									<td class="text-success">98.05% <i class="ti-arrow-up"></i></td>
									<td><label class="badge badge-warning">In progress</label></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>