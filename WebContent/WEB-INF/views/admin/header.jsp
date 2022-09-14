<%@page import="com.sungchang.common.util.APIHostUtil"%>
<%@page import="com.sungchang.common.util.DateUtil"%>
<%@page import="com.sungchang.common.vo.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
    <%
    	String authorization = (String)request.getSession().getAttribute("admin-authorization");
    	User user = (User)request.getSession().getAttribute("user"); 
    	
    	String roles = "";
    	String API_HOST = APIHostUtil.getHost(request);
    	 
    	
    	if (user == null) {

    %>
    <script> document.location.href="/login";</script>
    <%
    	return;
    	}  else {
    		roles = user.getRoles();
    	}
    	
    	
    %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>solarXEN v1.0</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="/statics/assets/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="/statics/assets/vendors/iconfonts/font-awesome/css/all.css">
    <link rel="stylesheet" href="/statics/assets/vendors/iconfonts/ionicons/css/ionicons.css">
    <link rel="stylesheet" href="/statics/assets/vendors/iconfonts/typicons/src/font/typicons.css">
    <link rel="stylesheet" href="/statics/assets/vendors/iconfonts/flag-icon-css/css/flag-icon.min.css">
	<link rel="stylesheet" href="/statics/assets/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link rel="stylesheet" href="/statics/assets/css/shared/style.css">
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="/statics/assets/css/monitoring/style.css">
    <!-- End Layout styles -->
    
    <link rel="stylesheet" href="/statics/js/jquery.ui/jquery-ui.css">
<!--     <link rel="stylesheet" href="/statics/js/yearpicker.css"> -->
        <!-- container-scroller -->
    <!-- plugins:js -->
    
    <script src="/statics/assets/vendors/js/vendor.bundle.base.js"></script>
<!--     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script> -->
	
    <!-- endinject -->
    <!-- Plugin js for this page-->
    <!-- End plugin js for this page-->
    <!-- inject:js -->
    
    <script src="/statics/assets/js/shared/off-canvas.js"></script>
    <script src="/statics/assets/js/shared/misc.js"></script>
    <!-- endinject -->
       <!-- Custom js for this page-->
    <script src="/statics/assets/js/shared/Chart.min.js"></script>
	<script src="/statics/assets/js/shared/utils.js"></script>
    <!-- Custom js for this page-->
    <script src="/statics/assets/js/monitoring/dashboard.js"></script>
    <script src="/statics/js/commonUtil.js"></script>
     <script src="/statics/js/jquery.ui/jquery-ui.js"></script>
     <script src="/statics/js/jquery.number.js"></script>
     <script src="/statics/js/jquery.cookie.js"></script>
<!--      <script src="/statics/js/jquery.mtz.monthpicker.js"></script>
     <script src="/statics/js/yearpicker.js"></script> -->
     

	
    <!-- End custom js for this page-->
    
    <script>
    var api_host = "<%=API_HOST%>";
    var authorization = '<%=authorization%>';
    var tel = "<%=user.getTel()%>";
    </script>
      
    <!-- endinject -->
    
      <script>
      function check_UserValidate() {
  		var settings = {
  				  "async": true,
  				  "crossDomain": true,
  				  "url":api_host + "/api/users/telcheck",
  				  "method": "GET",
  				  "headers": {
  				    "authorization": authorization,
  				    "cache-control": "no-cache",
  				    "tel" : "<%=user.getTel()%>"
  				  }
  				} 

  				$.ajax(settings).done(function (res,t,r) {
  					if(r.status == 204) {
  						console.log("force logout");
  						
  						document.location.href="/logout";
  					}
  					
  					console.log(res);
  			 
  				});
  	  }
      
      
      $(document).ready(function(){
   			var sid = getCookie("sid");
    		
    		check_UserValidate();
   			
   		
			if(sid){
   				read_new_event(sid, displayEvent);
			}

			console.log("Header!!" + sid);
			
			setNowTime();
			
			
   			
      });
      
      function setNowTime(){
    	  $("#nowTime").text(getDateNow());
    	  
    	  setTimeout(function(){
				setNowTime();
				
			},1000)
      }
      
      function displayEvent(datas){
    	  console.log("displayEvent..");
    	  console.log(datas);
    	  if (datas && datas.newevent_count >0){
    	  	$("#newevent-count").text(datas.newevent_count);
    	  	$("#newevent-count").show();
    	  	
    	  	for(i=0; i<datas.newevents.length; i++){
    	  		var newevent = '<a class="dropdown-item preview-item" href="javascript:goEvent('+ datas.newevents[i].sid +');">';
                    newevent +='<div class="preview-item-content flex-grow py-2">';
                    newevent +='<p class="preview-subject ellipsis font-weight-medium text-dark">'+ datas.newevents[i].sid +' </p>';
                    newevent +='<p class="font-weight-light small-text"> '+ datas.newevents[i].eventphase+' </p>';
              		newevent +='</div>';
            	 newevent +='</a>';
           		
            	 $("#newevent-list").append(newevent);
    	  	}
    	  	
    	  } else {
    		  $("#newevent-count").text(datas.newevent_count);
    		  $("#newevent-count").show();
    		  var noevent = '<a class="dropdown-item preview-item" href="#">';
    		  noevent +=  '<div class="preview-item-content flex-grow py-2">';
    		  noevent += '<p class="preview-subject ellipsis font-weight-medium text-dark">'+ "이벤트 없음" +' </p>';
    		  noevent += '<p class="font-weight-light small-text"> '+ "발생한 알람이 없습니다." +' </p>';
    		  noevent += "</div>";
    		  noevent += '</a>';
    		  
    		  $("#newevent-list").append(noevent);
    	  }
      }
      
      function goEvent(sid){
    	  setCookie("sid",sid);
    	  //var sid = getCookie("sid");
     		
			if(!sid){
 				update_new_event(sid,callbacekUpdate );
			} else {
				check_new_event(sid);
			}
			
			document.location.href="/admin/manage/event";
      }
      
      function callbacekUpdate(){}
      </script>
 	<script src="/statics/js/api_common.js"></script>
     <script src="/statics/js/api_admin.js"></script>
  </head>
  <body>
    <div class="container-scroller">
      <!-- partial:partials/_navbar.html -->
      <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-top justify-content-center">
          <a class="navbar-brand brand-logo" href="/">
            <img src="/statics/assets/images/solarXEN.png" alt="logo" /> </a>
          <a class="navbar-brand brand-logo-mini" href="/">
            <img src="/statics/assets/images/solarXEN_mini.svg" alt="logo" style="width:100%;" /> </a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-center">
          <ul class="navbar-nav">
            <li class="nav-item font-weight-semibold d-none d-lg-block admin-title">관리자</li>
          </ul>
          <ul class="navbar-nav ml-auto">
            <li class="time-info"><i class="far fa-clock"></i><spam id="nowTime"></spam></li>
			<li class="nav-item dropdown d-none d-xl-inline-block user-dropdown"> 
              <a class="nav-link dropdown-toggle" id="UserDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
                <img class="img-xs rounded-circle" src="/statics/assets/images/face_sample.png" alt="Profile image"> </a>
              <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="UserDropdown">
                <div class="dropdown-header text-center">
                  <img class="img-md rounded-circle" src="/statics/assets/images/face_sample.png" alt="Profile image">
                  <p class="mb-1 mt-3 font-weight-semibold"><%=user.getName() %></p>
                  <p class="font-weight-light text-muted mb-0"><%=user.getEmail() %></p>
                </div>
                <a href="/logout" class="dropdown-item">Sign Out<i class="dropdown-item-icon ti-power-off"></i></a> 
              </div>
            </li>
			<li class="nav-item dropdown">
              <a class="nav-link count-indicator" id="messageDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
                <i class="fas fa-bell"></i>
                 <span class="count" id="newevent-count" style="display:none;"></span>  
              </a>
              <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list pb-0" aria-labelledby="messageDropdown" id="newevent-list">
              <!--   <a class="dropdown-item py-3">
                  <p class="mb-0 font-weight-medium float-left">You have 7 unread mails </p>
                  <span class="badge badge-pill badge-primary float-right">View all</span>
                </a> -->
                <div class="dropdown-divider"></div>

                
              </div>
            </li>
          </ul>
          <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
            <span class="mdi mdi-menu"></span>
          </button>
        </div>
      </nav>
      
    