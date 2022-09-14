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
<style>
	@media screen and (min-width: 1200px) {
		#m_header {
			display: none;
		}
		
		.menu_bg {
			display: none;
		} 
		
		.sidebar_menu {
			display: none;
		}	
		
		#xen-mini-img {
			display: none;
		}
		
		#weather_icon {
			width: 50px!important;
			height: 55px;
		}
		
		#logout {
	    	font-size: 15px!important;
	    	font-weight: 600;
	    }
	}
	
	@media (min-width: 769px) and (max-width: 1199px) {
		#m_header {
			display: none;
		}
		
		.menu_bg {
			display: none;
		} 
		
		.sidebar_menu {
			display: none;
		}
		
		#xen-mini-img {
			display: none;
		}
		
		#weather_icon {
			width: 50px!important;
			height: 55px;
		}
		
		#logout {
	    	font-size: 15px!important;
	    	font-weight: 600;
	    }
	}
	
	@media (min-width: 360px) and (max-width: 768px) {
		#menu_container {
			display: none;
		}

		#xen-mini-img {
			height: 55%;
			vertical-align: middle;
			margin-left: 10px;
		}
		
		#weather_icon {
			width: 140%;
			height: 55px;
		}
		
		#notm_header {
			display: none;
		}
		
		#logout {
	    	font-size: 15px!important;
	    	font-weight: 600;
	    	width: 80%!important;
	    }
		
		.menu_body {
			list-style: none;
			padding-inline-start: 0px;
		}		
			
	}
	
	html, body {
	    height: 100%;
	}
	
	#xen-img {
		width: 100%!important;
		height: 93%!important;
		vertical-align: middle;
	}
	
	#xen-logo {
		position: relative;
	}
	
	#m_header {
		display: flex;
	}
	
	#label {
		font-size: 0.9vw;
	}
	
	#value {
		color: #ffa000;
		
	}
	
	#sub_div {
		display: flex;
	}
	
	#header-temperature, #header-humidity {
		padding-bottom: 0px!important;
		
	}
	
	#menu_container {
		width: 190px!important;
		top: 55px!important;
		min-height: 540px;
	}
	
	#menu_underline {
		position: absolute;
		left: 50%!important;
		bottom: 0!important;
		transform: translateX(-50%);
		margin-top: 0px!important;
	}
	
	#ci_logo {
		width: 70px!important;
		margin-bottom: 40px!important;
	}
	
	#contents {
		padding-left: 190px!important;
	}
	
	#ham-menu {
		font-size: 25px;
		vertical-align: middle;
		margin-left: 10px;
		color: #fff;
	}
    
    .menu_bg{
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.7);
        position: fixed;
        top:0;
        display: none;
        z-index: 998;
    }
    
    .menu_btn {
    	color: #fff;
    }
    
    .sidebar_menu{
        width: 190px;
        height: 100%;
        min-height: 560px;
        background: #45525f;
        position: fixed;
        top:0;
        left: -50%;
        z-index: 999;
    }
    .close_btn{
        margin:10px;
        font-size: 28px;
    }
    
    .close_btn > a{
        display: block;
        width: 100%;
        height: 100%;
        color: #fff;
    }
    .menu_wrap{
        list-style: none;
        padding: 0px 20px;   
    }
    .menu_wrap li a{
        color: #fff;
        text-decoration: none;
    }
    
    #logout {
    	font-size: 17px!important;
    	font-weight: 600;
    }
    
    .slidemenu_body {
    	height: 35px;
	    line-height: 35px;
	    vertical-align: middle;
	    font-weight: 600;
	    border: solid 1px #434d5a;
	    border-left: none;
	    border-right: none;
    }
    
    .slidemenu_body>a {
    	color: #fff;
	    text-decoration: none;
	    margin-left: 10px;
    }
    
    .submenu {
    	background: #1f252c;
    	margin: 0px;
    }

	.slidemenu_body>.submenu>li {
		line-height: 30px;
	}
	
	.slidemenu_body>.submenu>li>a {
		text-decoration: none;
		color: #fff;
	}
	
	
	.slidemenu_body:hover {
		background: #637080;
	}
	
	.right_icon {
		float: right;
		height: 35px;
		line-height: 35px!important;
		margin-right: 15px;
	}
	

</style>

<html>
	
	<head>
		<meta name="viewport" content="width=device-width, height=device-height,initial-scale=1, maximum-scale=1">
	
		<title>jui-test</title> 
		
		<!-- Load jui library -->
		<link rel="stylesheet" href="/statics/assets/jui/dist/jui-ui.classic.css"/>
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
			
			
		    $(document).ready(function(){
		    	 
		        $('.menu_btn>a').on('click', function(){
		            $('.menu_bg').show(); 
		            $('.sidebar_menu').show().animate({
		                left:0
		            });  
		        });
		        $('.close_btn>a').on('click', function(){
		            $('.menu_bg').hide(); 
		            $('.sidebar_menu').animate({
		                left: '-' + 50 + '%'
		                       },function(){
		$('.sidebar_menu').hide(); 
		}); 
		        });
		 
		    });


			
   		</script>
   		
   		
   		



   		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 header">
   			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" id="m_header">
   				<div class="col-1 menu_btn">
   					<a href="#">      
        				<i class="icon-menu" id="ham-menu"></i> 
       				</a>
   				</div>
   				
   				<div class="col-6" id="xen-logo">
	   				<a href="#">
		   				<img src="/statics/assets/images/solarXEN_.png" id="xen-mini-img"/>
		   			</a>
	   			</div>
   				
   				<div class="col-5" id="sub_div">
		   			<div class="col-2" id="right-weather-bar">
		   					<img src="/statics/assets/images/weather1.svg" id="weather_icon" alt="weather_icon"/>
		   			</div>
		   			
		   			<div id="header-temperature" class="col-5">
				   		<div id="label" class="col-5">온도</div>
			  			<div id="value" class="col-5"><b>0.0</b></div>
			  			<div id="unit" class="col-2"> ℃</div>
				  	</div>
			   		<div id="header-humidity" class="col-5">
			   			<div id="label" class="col-5">습도</div>
			   			<div id="value" class="col-5"><b>0</b></div>
			   			<div id="unit" class="col-2"> %</div>
			   		</div>
		   		</div>
   			</div>
   			
   			
   			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 header" id="notm_header">
   				<div class="col-xs-2 col-sm-2 col-md-2 col-lg-1 col-xl-1" id="header-logo">
		   			<a href="#">
		   				<img id="xen-img" src="/statics/assets/images/solarXEN.png"/>
		   			</a>
		   		</div>
		   		<div id="header-weather" class="col-xs-6 col-sm-6 col-md-6 col-lg-9 col-xl-9">
		   			<img src="/statics/assets/images/weather1.svg" id="weather_icon" alt="weather_icon"/>
		   		</div>
		   		
		   		<div id="header-temperature" class="col-xs-2 col-sm-2 col-md-2 col-lg-1 col-xl-1">
		   			<div id="label" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">온도</div>
			   		<div id="value" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4"><b>0.0</b></div>
			   		<div id="unit" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4"> ℃</div>
		   		</div>
		   		
		   		<div id="header-humidity" class="col-xs-2 col-sm-2 col-md-2 col-lg-1 col-xl-1">
		   			<div id="label" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">습도</div>
			   		<div id="value" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4"><b>0</b></div>
			   		<div id="unit" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4"> %</div>
		   		</div>
		   	</div>
   		</div>
   		
   		<div class="menu_bg"></div>
		<div class="sidebar_menu">
		     <div class="close_btn"><a href="#">       
		     		<i class="icon-close"></i>
		         </a>
		     </div>
		     
		     <ul class="menu_body">
		     	<li class="slidemenu_body"><a href="/juitest1" id="menu1" class="<%=uri.contains("juitest1") ? "active" : ""%>"><span class="icon-check"> 발전소 선택</span></a></li>
		     	<li class="slidemenu_body"><a href="/juitest2" id="menu2" class="<%=uri.contains("juitest2") ? "active" : ""%>"><span class="icon-realtime"> 현황</span></a></li>
		     	<li class="slidemenu_body"><a href="/juitest3" id="menu3" class="<%=uri.contains("juitest3") ? "active" : ""%>"><span class="icon-was"> 모니터링</span></a></li>
		     	<li class="slidemenu_body"><a href="/juitest4" id="menu4" class="<%=uri.contains("juitest4") ? "active" : ""%>"><span class="icon-check"> 통계분석</span></a></li>
		     	<li class="slidemenu_body"><a href="/juitest5" id="menu5" class="<%=uri.contains("juitest5") ? "active" : ""%>"><span class="icon-template"> 보고서</span></a></li>
		     	<li class="slidemenu_body"><a href="/juitest6" id="menu6" class="<%=uri.contains("juitest6") ? "active" : ""%>"><span class="icon-bell"> 장치알림</span></a></li>
		     	<li class="slidemenu_body"><a onclick="toggleSubmenu()" id="menu-management" class="<%=uri.contains("juitest7")|uri.contains("juitest8")|uri.contains("juitest9") ? "active" : ""%>"><span class="icon-gear"> 관리</span><span class="icon-plus right_icon"></span></a>
		     		<ul class="submenu">
			 			<li id="menu7" class="<%=uri.contains("juitest7") ? "active" : ""%>"><a href="/juitest7">사용자 관리</a></li>
			  			<li id="menu8" class="<%=uri.contains("juitest8") ? "active" : ""%>"><a href="/juitest8">발전소 관리</a></li>
						<li id="menu9" class="<%=uri.contains("juitest9") ? "active" : ""%>"><a href="/juitest9">장치 관리</a></li>
					</ul>
				</li>
		     </ul>
		     
		     <div id="menu_underline">
			   	<a class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 btn" draggable="false" id="logout" onclick="logout()">Logout</a>
			   	<img alt="logo" src="/statics/assets/images/sungchang_logo.gif" id="ci_logo"/>
			 </div>
		</div>
   		
   		
	   	<div class="row" id="body">
	   		<div id="menu_container">
	   			<div class="vmenu">
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
	   				<a class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 btn" draggable="false" id="logout" onclick="logout()">Logout</a>
	   				<img alt="logo" src="/statics/assets/images/sungchang_logo.gif" id="ci_logo"/>
	   			</div>
	   		</div>
	   		
	   		
	   		
		   	<div id="contents">