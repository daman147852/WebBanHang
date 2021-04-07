<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>SonShop|Đặt hàng</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<base href="${pageContext.servletContext.contextPath}/">
<style>
.frm {
	width: 70%;
	height: 30px;
	padding: 12px 20px;
	margin: 8px 0;
	box-sizing: border-box;
	border: 1px solid #358c88;
}

.contain {
	width: 70%;
	margin-top: 10px;
	box-sizing: border-box;
	border: 2px solid #358c88;
	border-radius: 4px;
	
}
</style>
</head>
<body>
	<div style="background-color: #f1f1f1f1; height: 60px">
		<a href="home/index.htm"><img src="./images/valentina.png" alt="logo" style="width: 90px; margin-left: 45%"></a>
	</div>
	<div class="container contain">
		<h3 style="text-align: center; margin-top: 10px">Thông Tin Giao Hàng</h3>
		${message}
		<form action="home/order/${product.id}.htm" method="post">
			<div class="form-group" style="margin-left: 100px">
				<label><b>Họ và tên</b></label>
				<input name="fullname" class="frm" style="margin-left: 20px" value="${sessionScope.user.getFullname()}"/>
			</div>
			<div class="form-group" style="margin-left: 100px">
				<label><b>Địa chỉ</b></label>
				<input name="address" class="frm" style="margin-left: 40px" value="${sessionScope.user.getAddress()}"/>
			</div>
			<div class="form-group" style="margin-left: 100px">
				<label><b>Email</b></label>
				<input name="email" readonly="true" class="frm" style="margin-left: 50px" value="${sessionScope.user.getEmail()}"/>
			</div>
			<div class="form-group" style="margin-left: 100px">
				<label><b>Điện thoại</b></label>
				<input name="phone" class="frm" style="margin-left: 12px" value="${sessionScope.user.getPhone()}"/>
			</div>
			<hr>
			<h5 style="text-align: center;">Thông tin Son đã đặt</h5>
			<div class="form-group" style="margin-left: 100px">
				<label><b>Tên sản phẩm: </b> ${product.name}</label>
				<br>
				<label><b>Giá tiền: </b> <fmt:formatNumber minFractionDigits="0" value="${product.price}" type="number"/> đ</label>
				<br>
				<label><b>Loại: </b> ${product.type.name}</label>
				<br>
				<label><b>Số lượng: </b></label>
				<input name="amount" type="number" style="margin-left: 12px" min="1" max="10"/>

			</div>
			<button class="btn"
					style="background-color: #358c88; color: white; width: 18%; margin-left: 350px; margin-bottom: 10px">Mua hàng</button>
		</form>
	</div>
	
	
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.1.min.js"
		type="text/javascript"></script>

	<script src="https://kit.fontawesome.com/53a1b8a344.js"
		crossorigin="anonymous"></script>
</body>
</html>