<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/53a1b8a344.js" crossorigin="anonymous"></script>
<base href="${pageContext.servletContext.contextPath}/">
<title>Admin| Home</title>
<style>
body {font-family: "Lato", sans-serif;}

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
  .sidebar {padding-top: 15px;}
  .sidebar a {font-size: 18px;}
}
</style>
</head>
<body>
<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>
<div class="sidebar">
  <%-- <a href="#home"><i class="fa fa-fw fa-home"></i> ${sessionScope.admin.getFullname()}</a> --%>
  <a href="product/index.htm"><i class="far fa-list-alt"></i> Danh sách Son </a>
  <a href="product/insert.htm"><i class="far fa-plus-square"></i> Thêm Son </a>
  <a href="admin/manage.htm"><i class="far fa-list-alt"></i> Quản lý đơn hàng </a>
  <a href="admin/logout.htm"><i class="fas fa-sign-out-alt"></i> Đăng xuất </a>
</div>
<div class="main">
  <h2 style="margin-left: 250px; font-style: italic;"> Chào mừng ${sessionScope.admin.getFullname()}! </h2>
  <p style="margin-left: 250px"> Quay trở lại với trang web, mời bạn lựa chọn tác vụ </p>
   <img src="./images/hinh1.jpg" style="margin-left: 190px; width: 50%"/> 
</div>
</body>
</html>