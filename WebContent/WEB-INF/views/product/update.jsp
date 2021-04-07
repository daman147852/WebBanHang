<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="${pageContext.servletContext.contextPath}/">
<title>Son|Cập nhật Son</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/53a1b8a344.js"
	crossorigin="anonymous"></script>
<style>
.bg-img {
	/* The image used */
	background-image: url("./images/hoatuyet.png");
	width: 100%;
	height: 100%;
	/* Center and scale the image nicely */
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
	position: relative;
}

body {
	font-family: "Lato", sans-serif;
}

.sidebar {
	height: 100%;
	width: 250px;
	position: fixed;
	z-index: 1;
	top: 0;
	left: 0;
	background-color: #358c88;
	overflow-x: hidden;
	padding-top: 16px;
}

.sidebar a {
	padding: 6px 8px 6px 16px;
	text-decoration: none;
	font-size: 20px;
	color: white;
	display: block;
}

.sidebar a:hover {
	color: black;
}

.main {
	margin-left: 250px; /* Same as the width of the sidenav */
	padding: 0px 10px;
}

@media screen and (max-height: 450px) {
	.sidebar {
		padding-top: 15px;
	}
	.sidebar a {
		font-size: 18px;
	}
}

.errors {
	color: red;
	font-style: italic;
}

.btn {
	background-color: #358c88;
	color: white;
}

.frm {
	width: 60%;
	padding: 12px 20px;
	margin: 8px 0;
	box-sizing: border-box;
	border: 2px solid #358c88;
	border-radius: 4px;
}

.frm2 {
	width: 60%;
	height: 100px;
	padding: 12px 20px;
	margin: 8px 0;
	box-sizing: border-box;
	border: 2px solid #358c88;
	border-radius: 4px;
}

.f1 {
	width: 20%;
	padding: 12px 20px;
	margin: 8px 0;
	box-sizing: border-box;
	border: 2px solid #358c88;
	border-radius: 4px;
}

.lb {
	font-weight: bold;
}

input[type=number]::-webkit-inner-spin-button, input[type=number]::-webkit-outer-spin-button
	{
	-webkit-appearance: none;
}
</style>
</head>
<body>
	<%response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");%>
	<div class="sidebar">
		<a href="admin/home.htm"><i class="fas fa-users-cog"></i>${sessionScope.admin.getFullname()}</a><hr>
		<a href="product/index.htm"><i class="far fa-list-alt"></i> Danh sách Son </a> 
		<a href="product/insert.htm"><iclass="far fa-plus-square"></i> Thêm Son </a> 
		<ahref="admin/manage.htm"><i class="far fa-list-alt"></i> Quản lý đơn hàng </a> 
		<a href="admin/logout.htm"><iclass="fas fa-sign-out-alt"></i> Đăng xuất </a>
	</div>
	
	<div class="main bg-img">
		<h2 class="lb">Cập nhật Son</h2>
		<p class="errors">${message}</p>
		<form:form action="product/update.htm" method="post"
			modelAttribute="product" enctype="multipart/form-data">
			<div class="form-group">
				<label class="lb">Mã Son</label> <br>
				<form:input readonly="true" class="frm" path="id" />
			</div>
			
			<div class="form-group">
				<label class="lb">Tên Son</label> <br>
				<form:input class="frm" path="name" />
				<form:errors class="errors" path="name" />
			</div>
			
			<div class="form-group">
				<label class="lb">Giá tiền</label> <br>
				<form:input class="frm" type="number" min="0" path="price" />
				<form:errors class="errors" path="price" />
			</div>
			
			<div class="form-group">
				<label class="lb">Loại</label> <br>
				<form:select class="f1" path="type.id" items="${types}"
					itemValue="id" itemLabel="name" />
			</div>
			
			<div class="form-group">
				<label class="lb">Mô tả</label> <br>
				<form:textarea class="frm" path="description" rows="5" />
				<form:errors class="errors" path="description" />
			</div>
			
			<div class="form-group">
				<div class="lb">Hình ảnh</div>
				<br>
				<form:input class="f1" readonly="true" path="image" />
				<input type="file" name="photo">
				<p class="errors">${message_image}</p>
			</div>
						
			<div class="form-group">
				<label class="lb">Số lượng</label> <br>
				<form:input class="f1" type="number" min="0" path="amount" />
				<form:errors class="errors" path="amount" />
			</div>
				
			<div class="form-group">
				<br>
				<button class="btn" style="margin-left: 30%">Cập nhật Son</button>
			</div>
		</form:form>
	</div>
</body>
</html>