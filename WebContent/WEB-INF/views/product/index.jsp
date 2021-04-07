<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="${pageContext.servletContext.contextPath}/">
<title>Son</title>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/53a1b8a344.js" crossorigin="anonymous"></script>
  <style>
  .bg-img {


  /* Center and scale the image nicely */
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  position: relative;
}
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
.KichThuoc{
	 height: 150px;
  	width: 150px;
}
  </style>
</head>
<body>
<%response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");%>
<div class="sidebar">
  <a href="admin/home.htm"><i class="fas fa-users-cog"></i> ${sessionScope.admin.getFullname()}</a>
  <hr>
  <a href="product/index.htm"><i class="far fa-list-alt"></i> Danh sách Son </a>
  <a href="product/insert.htm"><i class="far fa-plus-square"></i> Thêm Son </a>
  <a href="admin/manage.htm"><i class="far fa-list-alt"></i> Quản lý đơn hàng </a>
  <a href="admin/logout.htm"><i class="fas fa-sign-out-alt"></i> Đăng xuất </a>
</div>
<div class="main">
<div class="bg-img">         
<h2 style="font-weight: bold;">Danh sách Son</h2>
  <table class="table table-bordered table-sm table-hover" width="80%">
    <thead>
      <tr style="background-color: #358c88; color: white">
        <th>Mã</th>
        <th>Tên Son</th>
        <th>Loại Son</th>
        <th>Giá tiền</th>
        <th>Mô tả</th>
        <th>Số lượng</th>  
       	<th>Hình ảnh</th>
       	<th>Sửa</th>
       	<th>Xóa</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach var="p" items="${products}">
      <tr>
        <td>${p.id}</td>
        <td>${p.name}</td>
        <td>${p.type.name}</td> 
        <td><fmt:formatNumber minFractionDigits="0" value="${p.price}" type="number"/>đ</td>
        <td><textarea rows="5">${p.description}</textarea></td>
        <td>${p.amount}</td>      
        <td><img src="./images/${p.image}" class = "KichThuoc" >
        <td><a href="product/update/${p.id}.htm">Sửa</a></td>
        <td><a href="product/delete/${p.id}.htm">Xóa</a></td>      
      </tr>
      </c:forEach>
    </tbody>
  </table>
  </div>
 </div>
</body>
</html>