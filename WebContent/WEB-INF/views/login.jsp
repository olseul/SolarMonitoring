<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
    String msg = request.getParameter("msg");
    %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Cluster Monitoring</title>
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
    
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <script src="/statics/assets/vendors/js/vendor.bundle.base.js"></script>
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
     
     <script type="text/javascript" src="/statics/js/rsa/jsbn.js"></script>
     <script type="text/javascript" src="/statics/js/rsa/rsa.js"></script>
     <script type="text/javascript" src="/statics/js/rsa/prng4.js"></script>
     <script type="text/javascript" src="/statics/js/rsa/rng.js"></script>
  </head>
  <body>
    <div class="container-scroller">
      <div class="container-fluid page-body-wrapper full-page-wrapper">
        <div class="content-wrapper d-flex align-items-center auth auth-bg-1 theme-one">
          <div class="row w-100">
            <div class="col-lg-4 mx-auto">
           
              <div class="auto-form-wrapper">
				<p class="text-center site-name">Cluster Monitoring</p>
				<br>
                 <form id="form" action="/login/submit" method="post">
                  <div class="form-group">
                    <div class="input-group">
                      <input type="text" class="form-control" name="phone" id="phone" maxLength="13" placeholder="전화번호">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="input-group">
                      <input type="password" class="form-control" name="password" id="password" maxLength="20" placeholder="비밀번호">
                    </div>
                  </div>
                  <div class="form-group">
                    <button type="button" class="btn btn-primary submit-btn btn-block" onclick="doSubmit();">로그인</button>
                    <small style="color:#ffffff;">※ 로그인 연속 10회 실패 시 5분 동안 계정 로그인이 차단됩니다.</small>
                    <br>
                    <small style="color:#ffffff;">※ 페이지 표시 시각 기준으로 20분마다 로그인 페이지가 갱신됩니다.</small>
                  </div>
                </form>
              </div>
            </div>
          </div>
		  <div class="row">
		      <div class="login-footer">
				<span class="footer-logo"><img src="/statics/assets/images/sungchang.png" width="176" height="47" alt="로고"/></span>
				성창 주식회사 | (28358) 충북 청주시 흥덕구 동촌로 149 | Tel : 043.272.6552~3 | Fax : 043.272.4884 | 대표 : 이재진<br>
				Copyright© Sungchang Co., Ltd. All Rights Reserved.
			  </div>	
		  </div>
        </div>
        <!-- content-wrapper ends -->
      </div>
      <!-- page-body-wrapper ends -->
    </div>
     <!-- Modal -->
			<div class="modal fade weather-modal" id="infoModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
				  <div class="modal-header">
					<h5 class="modal-title" id="exampleModalLongTitle">안내 메세지</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					  <span aria-hidden="true">&times;</span>
					</button>
				  </div>
				  <div class="modal-body">
					<span id="modal-msg">로그인이 실패하였습니다. </span>
					<p id="close-msg">5초 뒤에 창이 닫힙니다.</p>
				  </div>
				  <div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
				  </div>
				</div>
			  </div>
			</div>
    <!-- container-scroller -->
    <!-- plugins:js -->
        <!-- endinject -->
    <script>
    function doSubmit(){
    	if($("#phone").val() == '') {
    		alert("전화번호를 입력해주세요.");
    		$("#phone").focus();
    		return;
    	}
    	
    	if($("#password").val() == '') { 
    		alert("비밀번호를 입력해주세요.");
    		$("#password").focus();
    		return;
    	}
    	
    	var param = {"phone":$("#phone").val(), "password":$("#password").val()};
    	
    	param = encrypt(param,"<%=request.getAttribute("__md")%>","<%=request.getAttribute("__exp")%>");
    	
    	$.ajax({
			url: "/login/process",
			method: 'post',
			data : JSON.stringify(param),
			cache: false,
			  headers:{'content-type': 'application/json;charset=UTF-8'},
			success: function (response) {
				console.log("result:"+JSON.stringify(response));
				 
				  if(response && response.code == 'success'){
					  if(response.user.roles == 'ADMIN') {
						  document.location.href="/admin/sitelist"; 
					  } else {
						  setCookie("sid", response.user.sid);
						  document.location.href="/dashboard"; 
					  }
					  
				  } else if(response && response.code == 'success_default') {
					  alert("기본 비밀번호를 사용하고 있습니다. 비밀번호 변경을 권장합니다.");
					  if(response.user.roles == 'ADMIN') {
						  document.location.href="/admin/sitelist"; 
					  } else {
						  setCookie("sid", response.user.sid);
						  document.location.href="/dashboard";
					  }
				  }
				  
				  else {
					
					var close_msg = "";
					
					if (response.locklogin == "true"){
						close_msg = "로그인에 실패했습니다.";
					} else {
						close_msg = "로그인에 실패했습니다.";
					}
					  
					$("#modal-msg").html(close_msg);
					closetime=5;
					$("#close-msg").text(closetime + "초 뒤에 창이 닫힙니다");
					$("#infoModalCenter").modal("show");
					setTimeout(displayCloseTime, 0);
				  }
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) { 
				close_msg = "로그인에 실패했습니다.";
				$("#modal-msg").html(close_msg);
				closetime=5;
				$("#close-msg").text(closetime + "초 뒤에 창이 닫힙니다");
				$("#infoModalCenter").modal("show");
				setTimeout(displayCloseTime, 0);
            }  
		});
    	
    	
    	/* var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": "/login/process",
		  "method": "POST",
		  "headers": {
		    "content-type": "application/json;charset=UTF-8",
		    "cache-control": "no-cache",
		  },
		  "data": JSON.stringify(param)
		}

		$.ajax(settings).done(function (response) {
		  console.log(response);
		  
		  
		  if(response && response.code == 'success'){
			  if(response.user.roles == 'ADMIN') {
				  document.location.href="/admin/sitelist"; 
			  } else {
				  document.location.href="/user/dashboard";
			  }
			  
		  } else {
			
			var close_msg = "";
			
			if (response.locklogin){
				close_msg = response.lockexpires + "이후에 다시 시도해 주세요.";
			} else {
				close_msg = "로그인 " + response.lockcount + "회 실패 했습니다.";
			}
			  
			$("#modal-msg").html(close_msg);
			closetime=5;
			$("#infoModalCenter").modal("show");
			setTimeout(displayCloseTime, 1000);
		  }
		 
		  
		}).fail(function(err){
			alert('로그인 실패' + err);
		}); */
    	
    }
    
    function pressSubmit(e) {
    	if(e.key.toLowerCase() == "enter") doSubmit();
    }
    
    var closetime=5;
    var timeoutHandler;
	function displayCloseTime(){
		
		if (closetime == 0) {
			$("#infoModalCenter").modal("hide");
		} else {
			$("#close-msg").text(closetime + "초 뒤에 창이 닫힙니다");
			closetime--;
			clearTimeout(timeoutHandler);
			timeoutHandler = setTimeout(displayCloseTime, 1000);
		}
		
	}
    
	document.getElementById("phone").addEventListener("keyup",(e) => pressSubmit(e));
	document.getElementById("password").addEventListener("keyup",(e) => pressSubmit(e));
	
	var elapsed_minute = 0;
	$("document").ready(function() {
		setInterval(function() { console.log("elapsed " + (++elapsed_minute) + " minute."); }, 60 * 1000);
		setInterval(function() { location.reload(); }, 20 * 60 * 1000);
	}); 
   
    </script>
  </body>
</html>