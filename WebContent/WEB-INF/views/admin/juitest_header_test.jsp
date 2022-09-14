<%@page import="java.net.URI"%>
<%@page import="com.sungchang.common.util.APIHostUtil"%>
<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
    String msg = request.getParameter("msg");
    String uri = request.getRequestURI();
    %>
<!DOCTYPE html>
<html>
	
	<head>
		<meta name="viewport" content="initial-scale=1, maximum-scale=1">
	
		<title>jui-test</title> 
		
		<!-- Load jui library -->
    	<link rel="stylesheet" href="/statics/assets/jui/dist/jui-ui.min.classic.css"/>
    	<!-- <link rel="stylesheet" href="/statics/assets/jui/dist/ui-jennifer.min.classic.css"/> -->
    	
    	<link rel="stylesheet" href="/statics/assets/jui-grid/dist/jui-grid.classic.css"/>
    	<link rel="stylesheet" href="/statics/assets/jui-grid/dist/jui-grid.dark.css"/>
    	<!-- <link rel="stylesheet" href="/statics/assets/jui-grid/dist/grid-jennifer.classic.css"/>  -->
    	<link rel="stylesheet" href="/statics/assets/css/monitoring/juitest_style.css"/>
 
     	
    	<script  src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	
		<script src="/statics/assets/jui-core/dist/jui-core.js"></script>
		<script src="/statics/assets/jui-chart/dist/jui-chart.js"></script>
		<!-- Basic script components -->
		<script src="/statics/assets/jui/dist/jui-ui.js"></script>
		
		
		<!-- Grid script components -->
		<script src="/statics/assets/jui-grid/dist/jui-grid.min.js"></script>
	</head>
	
	
    <body class="jui">
   	
   		<script>
			function toggleSubmenu() {
				$(".submenu").toggle();
			}
			
			function logout() {
				if(confirm("로그아웃 하시겠습니까?")) {
					// 세션 해제 코드
					window.location="login";
				}
				
			}
   		</script>
   	
	   	<div class="header">
	   		<div id="header-logo">
	   			<a href="#">
	   				<img src="/statics/assets/images/solarXEN.png"/>
	   			</a>
	   		</div>
	   		<div class="header-headline col-xs-11 col-sm-11 col-md-11 col-lg-11 col-xl-11">  			
		   		<div id="header-title" class="col-xs-4 col-sm-4 col-md-6 col-lg-9 col-xl-9"> 
		   		</div>
		   		<div id="header-weather" class="col-xs-2 col-sm-2 col-md-2 col-lg-1 col-xl-1"> 
		   			<img src="/statics/assets/images/weather1.svg" id="weather_icon" alt="weather_icon"/>
		   		</div>
		   		<div id="header-temperature" class="col-xs-3 col-sm-3 col-md-2 col-lg-1 col-xl-1">
		   			<div id="label" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">온도</div>
		   			<div id="value" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">0.0</div>
		   			<div id="unit" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4"> ℃</div>
		   		</div>
		   		<div id="header-humidity" class="col-xs-3 col-sm-3 col-md-2 col-lg-1 col-xl-1">
		   			<div id="label" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">습도</div>
		   			<div id="value" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">0</div>
		   			<div id="unit" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4"> %</div>
		   		</div>
	   		</div>
	   	</div> 
	   	<div class="row" id="body">
	   		<div id="menu_container">
	   			<div class="vmenu" id="menu">
	   				<a href="/juitest1" id="menu1" class="<%=uri.contains("juitest1") ? "active" : ""%>">발전소 선택</a> 
	   				<a href="/juitest2" id="menu2" class="<%=uri.contains("juitest2") ? "active" : ""%>">현황</a> 
	   				<a href="/juitest3" id="menu3" class="<%=uri.contains("juitest3") ? "active" : ""%>">모니터링</a> 
	   				<a href="/juitest4" id="menu4" class="<%=uri.contains("juitest4") ? "active" : ""%>">통계분석</a>
	   				<a href="/juitest5" id="menu5" class="<%=uri.contains("juitest5") ? "active" : ""%>">보고서</a>
	   				<a href="/juitest6" id="menu6" class="<%=uri.contains("juitest6") ? "active" : ""%>">장치알림</a>
	   				<a onclick="toggleSubmenu()" id="menu-management" class="<%=uri.contains("juitest7")|uri.contains("juitest8")|uri.contains("juitest9") ? "active" : ""%>">관리</a>
	   				<ul class="submenu">
	   					<li id="menu7" class="<%=uri.contains("juitest7") ? "active" : ""%>"><a href="/juitest7"> - 사용자 관리</a></li>
	   					<li id="menu8" class="<%=uri.contains("juitest8") ? "active" : ""%>"><a href="/juitest8"> - 발전소 관리</a></li>
	   					<li id="menu9" class="<%=uri.contains("juitest9") ? "active" : ""%>"><a href="/juitest9"> - 장치 관리</a></li>
	   				</ul>
	   			</div>
	   			
	   			<div id="menu_underline">
	   				<a class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 btn large" draggable="false" id="logout" onclick="logout()">Logout</a>
	   				<img alt="logo" src="/statics/assets/images/sungchang_logo.gif" id="ci_logo"/>
	   			</div>
   			</div>
		   	<div id="contents">