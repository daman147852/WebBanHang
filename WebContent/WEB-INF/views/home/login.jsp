<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="${pageContext.servletContext.contextPath}/">
<title>Đăng nhập</title>
<style>
body, html {
	height: 100%;
	font-family: Arial, Helvetica, sans-serif;
}

* {
	box-sizing: border-box;
}

.bg-img {
	/* The image used */
	background-image: url("./images/qc2.png");
	width: 100%;
	height: 100%;
	/* Center and scale the image nicely */
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
	position: relative;
}

/* Add styles to the form container */
.container {
	position: absolute;
	margin-top: 100px;
	margin-left: 200px;
	max-width: 500px;
	padding: 20px;
	background-color: clear;
}

/* Full-width input fields */
input[type=text], input[type=password] {
	width: 100%;
	padding: 15px;
	margin: 5px 0 22px 0;
	border: none;
	background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
	background-color: #ddd;
	outline: none;
}

/* Set a style for the submit button */
.btn {
	background-color: #4CAF50;
	color: white;
	padding: 16px 20px;
	border: none;
	cursor: pointer;
	width: 50%;
	opacity: 0.9;
}

.btn:hover {
	opacity: 1;
}

.mess {
	color: red;
}
</style>
</head>

<body>
	<div class="bg-img">
		<form action="home/login.htm" class="container" method="post">
			<h1>Đăng nhập</h1>

			<label for="email"><b>Username</b></label>
			<p class="mess">${message1}</p>
			<input type="text" placeholder="Nhập Username" name="username"
				required> <label for="psw"><b>Mật khẩu</b></label>
			<p class="mess">${message2}</p>
			<input type="password" placeholder="Nhập mật khẩu" name="password"
				required>


			<button type="submit" class="btn">Đăng nhập</button>
			<p>
				<b>Bạn chưa có tài khoản?<a href="home/register.htm"
					style="text-decoration: none"> Đăng kí ngay</a></b>
			</p>
		</form>
	</div>
</body>
</html>