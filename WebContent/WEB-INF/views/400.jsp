<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<% response.setStatus(200); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>solarXEN v1.0</title>
</head>
<body>
	<div>
		<h1>400 ERROR</h1>
		<hr>
		<p>서버가 요청을 인식하지 못했습니다.</p>
		<p>사이트 관리자에게 문의해 주세요.</p>
		<small style="color:#001f69; font-weight:bold;">성창주식회사 부설연구소 김건우 대리 (1577-6552)</small>
		<br>
		<br> 
		<button onclick="back()">뒤로가기</button>
	</div>
	
	<script>
		function back() { 
			history.back(); 
		}
	
	</script>
</body>
</html>