<%@page import="com.nhncorp.lucy.security.xss.XssPreventer"%>
<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./header.jsp" %>
<%@ include file="./LNB.jsp" %>
    <%
    String msg = request.getParameter("msg");
    %>

     
     <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
            <!-- Page Title Header Starts-->
            <div class="row page-title-header">
              <div class="col-12">
                <div class="page-header">
                  <h4 class="page-title">HOME | 관리 | 사용자 관리 (재인증 절차)</h4>
                </div>
              </div>
            </div>
            <!-- Page Title Header Ends-->
            <div class="row">
				<div class="w-box">
					<div class="row"><!-- cont01 -->
					  <div class="table-area col-md-12">
					    <form id="form" action="/admin/user/update" method="post">
						</form>
						</div>
						<div class="col-md-12 text-center mb-2 mt-3">
						
						<div style="font-size:22px; font-weight:bold;">관리자 재인증을 진행합니다. 접속 중인 관리자 계정 비밀번호를 입력해 주세요</div>
						<br>
						<d style="font-size:18px; font-weight:bold;">관리자 비밀번호 </d>
						<input type="password"  name="password_auth" id="password_auth"  class="form-control" maxlength="20" style="width: 30%; border-color:red;" autocomplete = "off">
						 <button type="button" onclick="doProcess()" class="btn btn-primary mr-2">확인</button><!-- <button type="submit" class="btn btn-primary">삭제</button> --></div>
					</div>
				</div>
			</div>
          </div>
          <!-- content-wrapper ends -->
          <!-- partial:partials/_footer.html
          <footer class="footer">
            <div class="container-fluid clearfix text-center">
              <span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Copyright © 2019 Solar Monitoring System. All rights reserved.</span>
            </div>
          </footer>
          <!-- partial -->
        </div>
        <!-- main-panel ends -->
      </div>
      <!-- page-body-wrapper ends -->
    </div>
   
   <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	var is_cert_ok = false;
	var cert_num = null;
	var dst_tel = "";
	
	function doProcess() {
		
		if($("#password_auth").val().length > 0) {
			var data = {
					"tel" : dst_tel,
					"passwordauth":$("#password_auth").val()
			};
			
			console.log("data:"+JSON.stringify(data));
			
			var settings = {
			  "async": true,
			  "crossDomain": true,
			  "url": "/admin/user/reauth/update",
			  "method": "POST",
			  "headers": {
			    "authorization": "<%=authorization%>",
			    "content-type": "application/json;charset=utf-8",
			    "cache-control": "no-cache",
			    "postman-token": "e36c61c4-58c1-ce20-dea9-1d3a08895299"
			  },
			  "data":JSON.stringify(data)
			}
	
			$.ajax(settings).done(function (response,r,t) {
				if(t.status == 200) {
					alert("관리자 재인증이 완료되었습니다.");
					document.location.href = response;
				}
			}).fail(function(err) {
				if(err.status == 405) {
					alert("현재 로그인 된 관리자 비밀번호가 일치하지 않습니다.");
				}
				else 
					alert('관리자 재인증에 실패하였습니다.' );
				
				document.location.href = "/admin/user/list";
			});
		} else {
			alert("접속 중인 관리자 비밀번호를 입력하세요.");
		}
		
		//$("#form").submit();
	}
   
   
	   
   $(document).ready(function(){
	   
	   <%
	   
	   	String tel = request.getParameter("tel");
	   
	   	if ( StringUtil.isEmpty(tel)) {
	   		out.println("alert('사용자 정보가 없습니다.');");
	   	}
	   %>
	   
	   dst_tel = "<%=tel%>";
   
  	 	
  	 	
  	 	
  	 	
	});
   

   </script>
  </body>
</html>