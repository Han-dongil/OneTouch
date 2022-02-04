<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<style>
	tbody>tr>td{
		padding-top:7px !important;
		padding-bottom:7px !important;
		line-height:0.1 !important;
	}
	.badge-danger {
    color: #fff;
    background-color: crimson;
	}
	.badge-info{
    color: #fff;
    background-color: green;
	}
</style>
<body>
	<div class="row">
		<div class="col-6">
		<div class="col-lg-12 stretch-card"  style="display:inline-block">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">일일 생산계획</h4>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>라인</th>
									<th>제품명</th>
									<th>생산수량</th>
									<th>불량량</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>GLASS01</td>
									<td>PRD001</td>
									<td>1000</td>
									<td class="text-danger">28.76% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-danger">생산대기</label></td>
								</tr>
								<tr>
									<td>Dave</td>
									<td>53275535</td>
									<td>Photoshop</td>
									<td class="text-success">98.05% <i class="ti-arrow-up"></i></td>
									<td><label class="badge badge-warning">생산중</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td>Photoshop</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">생산완료</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td>Photoshop</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">생산완료</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td>Photoshop</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">생산완료</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td>Photoshop</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">생산완료</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td>Photoshop</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">생산완료</label></td>
								</tr>
								<tr>
									<td>John</td>
									<td>Premier</td>
									<td>Photoshop</td>
									<td class="text-danger">35.00% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-info">생산완료</label></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-lg-12 stretch-card"  style="display:inline-block">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">자재 재고현황</h4>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>자재코드</th>
									<th>자재명</th>
									<th>안전재고</th>
									<th>현재고</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Jacob</td>
									<td>Jacob</td>
									<td>Photoshop</td>
									<td class="text-danger">28.76% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-danger">발주시급</label></td>
								</tr>
								<tr>
									<td>Messsy</td>
									<td>Messsy</td>
									<td>Flash</td>
									<td class="text-danger">21.06% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-warning">수량체크</label></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			</div>
			<div class="col-lg-12 stretch-card" style="display:inline-block">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">설비 정기점검</h4>
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>설비코드</th>
									<th>설비명</th>
									<th>점검일</th>
									<th>D-day</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Jacob</td>
									<td>유리접합용가압오븐</td>
									<td class="text-danger">28.76% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-danger">D-Day</label></td>
								</tr>
								<tr>
									<td>Messsy</td>
									<td>Flash</td>
									<td class="text-danger">21.06% <i class="ti-arrow-down"></i></td>
									<td><label class="badge badge-warning">D-7</label></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</div>
</body>
</html>