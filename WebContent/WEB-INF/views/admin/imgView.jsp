<%@page import="com.sungchang.common.util.APIHostUtil"%>
<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
  <%
    	String authorization = (String)request.getSession().getAttribute("admin-authorization");
  		String API_HOST = APIHostUtil.getHost(request);
    %>
    <html>
    <head>
    <!-- plugins:js -->
    <script src="/statics/assets/vendors/js/vendor.bundle.base.js"></script>
    <!-- endinject -->
    <!-- Plugin js for this page-->
    <!-- End plugin js for this page-->
    <!-- inject:js -->
    <script src="/statics/assets/js/shared/off-canvas.js"></script>
    <script src="/statics/assets/js/shared/misc.js"></script>
    <!-- endinject -->
    <!-- Custom js for this page-->
    <script src="/statics/assets/js/monitoring/dashboard.js"></script>
    <script src="/statics/js/commonUtil.js"></script>
</head>
    <body>
    
    <img id="img-view" style="width:200px;height:200px">
    
    <script>
    $(document).ready(function(){
    	var settings = {
 			   "async": true,
 			   "crossDomain": true,
 			   "url": "<%=API_HOST%>/api/sites/<%=request.getParameter("sid")%>/image",
 			   "method": "GET",
 			   "headers": {
 			     "authorization": "<%=authorization%>",
 			    "content-type": "image/png;charset=UTF-8",
 			     "cache-control": "no-cache",
 			     "postman-token": "a1a47c13-4603-3824-d72a-8dfa44ddfd11"
 			   }
 			 }

 			 $.ajax(settings).done(function (response) {
 				 console.log(response);
 				 $("#img-view").attr("src","data:"+response);
 			 });
    });
    </script>
    </body>
    </html>