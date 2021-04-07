<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>SonShop|Lịch sử đặt hàng</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script src="https://kit.fontawesome.com/53a1b8a344.js"
	crossorigin="anonymous"></script>
<base href="${pageContext.servletContext.contextPath}/">
<style>
/* Dropdown Button */
.dropbtn {
	background-color: #4CAF50;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
}

/* The container <div> - needed to position the dropdown content */
.dropdown {
	position: relative;
	display: inline-block;
}

.dropbtn1 {
	background-color: white;
	color: black;
	padding: 16px;
	font-size: 16px;
	border: none;
}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

/* Links inside the dropdown */
.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {
	background-color: #ddd;
}

/* Show the dropdown menu on hover */
.dropdown:hover .dropdown-content {
	display: block;
}

/* Change the background color of the dropdown button when the dropdown content is shown */
.dropdown:hover .dropbtn {
	background-color: #358c88;
}

.binh {
	background-color: #358c88;
	height: 60px;
	color: white;
}

.chu {
	color: #2e6f51;
	background-color: white;
}

.navbar-fixed-top {
	top: -60px;
	transition: top 800ms ease 0s;
	position: fixed;
	z-index: 9999;
}

.show {
	top: 0px;
}

* {
	box-sizing: border-box;
}

/* Create two equal columns that floats next to each other */
.column {
	float: left;
	width: 50%;
	padding: 10px;
	height: 300px; /* Should be removed. Only for demonstration */
}

/* Clear floats after the columns */
.row:after {
	content: "";
	display: table;
	clear: both;
}

.binh {
	background-color: #358c88;
	height: 60px;
	color: white;
}
</style>
</head>
<body>
	<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>
	<nav class="navbar navbar-expand-sm" style="background-color: White;">
		<!-- logo -->
		<a class="navbar-brand" href="home/index.htm"> <img
			src="./images/valentina.png" alt="logo" style="width: 150px">
		</a>

		<form class="form-inline" action="home/search.htm">
			<input class="form-control mr-sm-2" type="text" style="width: 500px"
				placeholder="Tìm kiếm sản phẩm" name="search">
			<button class="btn btn-success binh" type="submit"
				style="height: 40px">Tìm kiếm</button>
		</form>

		<!-- Links -->
		<c:if test="${checkLogin == false}">
			<ul class="navbar-nav" style="margin-left: 300px; overflow: hidden;">
				<li class="nav-item"><a class="nav-link chu"
					href="home/login.htm"><img src="./images/logouser.png"
						style="width: 30px"> Đăng nhập</a></li>
				<li class="nav-item"><a class="nav-link chu" href="#"><img
						src="./images/call.png" style="width: 30px">0815764701</a></li>
			</ul>
		</c:if>
		
		<c:if test="${checkLogin == true}">
			<div class="dropdown " style="margin-left: 50px">
				<img src="./images/logouser.png" style="width: 30px">-
				<button class=" dropbtn1">${sessionScope.user.getFullname()}</button>
				<div class="dropdown-content">
					<a href="home/history.htm">Lịch sử đặt hàng</a> <a href="home/logout.htm">Đăng xuất</a>
				</div>
			</div>
			<ul class="navbar-nav" style="margin-left: 50px; overflow: hidden;">
				<li class="nav-item"><a class="nav-link chu" ><img
						src="./images/call.png" style="width: 30px; margin-right: ">0815764701</a></li>
			</ul>
		</c:if>
	</nav>


	<br>
	<h4 style="text-align: center; margin-bottom: 10px">Đơn Hàng Đã Đặt</h4>
	<hr width="80%" color="#358c88">
	
	<table class="table table-bordered table-hover">
		<tr>
		<th>Mã đơn hàng</th>
		<th>Họ và tên</th>
		<th>Địa chỉ</th>
		<th>Tên sản phẩm</th>
		<th>Đơn giá</th>
		<th>Số lượng</th>
		<th>Thành tiền</th>
		<th>Ngày mua</th>
		</tr>
		<c:forEach var="o" items="${orders}">
			<tr>
				<td>${o.code}</td>
				<td>${o.cusname}</td>
				<td>${o.cusadd}</td>
				<td>${o.product.name}</td>
				<td><fmt:formatNumber minFractionDigits="0" value="${o.product.price}"
						type="number" />
					₫</td>
				<td>${o.amount}</td>
				<td><fmt:formatNumber minFractionDigits="0" value="${o.product.price*o.amount}"
						type="number" />
					₫</td>
				<td><fmt:formatDate pattern="dd-MM-yyyy" value="${o.date}"/></td>
			</tr>
		</c:forEach>
	</table>
	
	
	<!-- Footer -->
	<footer class="page-footer font-small mdb-color pt-4"
		style="background-color: #358c88; color: white;">

		<!-- Footer Links -->
		<div class="container text-center text-md-left">

			<!-- Footer links -->
			<div class="row text-center text-md-left mt-3 pb-3">

				<!-- Grid column -->
				<div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
					<h6 class="text-uppercase mb-4 font-weight-bold">SonShop</h6>
					<p>Son lên là đẹp</p>
				</div>
				<!-- Grid column -->

				<hr class="w-100 clearfix d-md-none">

				<!-- Grid column -->
				<div class="col-md-4 col-lg-3 col-xl-3 mx-auto mt-3">
					<h6 class="text-uppercase mb-4 font-weight-bold">SON</h6>
					<p>
						<i class="fas fas fa-thumbs-up mr-3"></i> Son Thỏi
					</p>
					<p>
						<i class="fas fas fa-thumbs-up mr-3"></i> Son Kem
					</p>
					<p>
						<i class="fas fas fa-thumbs-up mr-3"></i> Son Lì
					</p>
					
				</div>

				<!-- Grid column -->
				<hr class="w-100 clearfix d-md-none">

				<!-- Grid column -->
				<div class="col-md-4 col-lg-3 col-xl-3 mx-auto mt-3">
					<h6 class="text-uppercase mb-4 font-weight-bold">Liên Hệ</h6>
					<p>
						<i class="fas fa-home mr-3"></i> PTITHCM, TPHCM, VietNam
					</p>
					<p>
						<i class="fas fa-envelope mr-3"></i> SonShop@gmail.com
					</p>
					<p>
						<i class="fas fa-phone mr-3"></i> 0815764701
					</p>
					
				</div>
				<!-- Grid column -->

			</div>
			<!-- Footer links -->

			<hr>

			<!-- Grid row -->
			<div class="row d-flex align-items-center">

				<!-- Grid column -->
				<div class="col-md-7 col-lg-8">

					<!--Copyright-->
					<p class="text-center text-md-left" style="text-align: center;">
						Desige by: <strong> DamQuangAn</strong>
					</p>

				</div>
				<!-- Grid column -->

				<!-- Grid column -->
				<div class="col-md-5 col-lg-4 ml-lg-0">

				

				</div>
				<!-- Grid column -->

			</div>
			<!-- Grid row -->

		</div>
		<!-- Footer Links -->

	</footer>
	<!-- Footer -->

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
</body>
</html>