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
                  <h4 class="page-title">HOME | 관리 | 사용자 관리</h4>
                </div>
              </div>
            </div>
            <!-- Page Title Header Ends-->
            <div class="row">
				<div class="w-box">
					<h4>사용자 등록</h4>
					<div class="row"><!-- cont01 -->
					  <div class="table-area col-md-12">
					  <form id="form" action="/admin/user/add" method="post">
							<table class="table v3">
								<colgroup>
									<col width="30%">
									<col width="*">
								</colgroup>
								<tbody>
								<tr>
									<th>등급<span class="necessary">*</span></th>
									<td>
										<select class="form-control" style="width: 50%;" name="roles">
										 <option value="USER">사용자</option>
										 <option value="ADMIN">관리자</option>
									    </select>
									</td>
								</tr>
								<tr>
									<th>연락처(ID)<span class="necessary">*</span></th>
									<td>
										<input type="text" class="form-control" name="tel" id="tel" value="" style="width: 50%;">
										<span class="text-primary fnt12">※ ID는 연락처로 사용됩니다.</span>
									</td>
								</tr>
								<tr>
									<th>새 비밀번호<span class="necessary">*</span></th>
									<td><input type="password" name="password" id="password" class="form-control" style="width: 50%;"  autocomplete = "off"></td>
								</tr>
								<tr>
									<th>비밀번호 확인<span class="necessary">*</span></th>
									<td><input type="password"  name="password2" id="password2"  class="form-control" style="width: 50%;"  autocomplete = "off">
									<span class="text-primary fnt12 text-warning" id="password-warning" style="display:none;">※비밀번호를 다르게 입력하였습니다.</span></td>
								</tr>
								<tr>
									<th>이름<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" name="name" id="name" style="width: 50%;"></td>
								</tr>
								<tr>
									<th>주소<span class="necessary">*</span></th>
									<td>
										<p><input type="text" class="form-control" style="width: 30%;" name="postcode" id="postcode" readonly placeholder="우편번호"><button type="button" class="btn btn-outline-primary btn-sm ml-2" style="vertical-align: top;" onclick="openPost();">우편번호찾기</button></p>
										<p><input type="text" class="form-control" style="width: 80%;" name="address" id="address"></p>
										<p style="margin-bottom: 0"><input type="text" class="form-control" style="width: 80%;" name="address2" id="address2"></p>
									</td>
								</tr>
								<tr>
									<th>이메일<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" name="email" id="email" style="width: 50%;"></td>
								</tr>
								<tr>
									<th>메모</th>
									<td><textarea class="form-control" rows="5" name="memo" id="memo"></textarea></td>
								</tr>
								</tbody>
							</table>
							</form>
						</div>
						<div class="col-md-12 text-right mb-2 mt-3"><button type="button" onclick="doSave()" class="btn btn-primary mr-2">추가</button><!-- <button type="submit" class="btn btn-primary">삭제</button> --></div>
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

	function openPost(){
		new daum.Postcode({
			oncomplete: function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
				// 예제를 참고하여 다양한 활용법을 확인해 보세요.
				console.log(data   );

				console.log(data.zonecode);
				console.log(data.roadAddress);
				console.log(data.jibunAddress);
			
				$("#postcode").val(data.zonecode   );
				
				if ( data.userSelectedType == 'J' ) {
					$("#address").val(data.jibunAddress);
					
				} else {
					$("#address").val(data.roadAddress);
				}
			//	
			}
		}).open();
	}
	
	function passwordCheck(){
		if ($("#password").val() != $("#password2").val()) {
			$("#password2").focus();
			$("#password-warning").show();
			return;
		} else {
			$("#password-warning").hide();
		}
	}
	
	function doSave() {
		
		if ($("#tel").val() == '') {
			$("#tel").focus();
			return;
		}
		
		if ($("#password").val() == '') {
			$("#password").focus();
			return;
		}
		
		
		if ($("#password").val() != $("#password2").val()) {
			$("#password2").focus();
			$("#password-warning").show();
			return;
		}
		
		
		if ($("#name").val() == '') {
			$("#name").focus();
			return;
		}
		
		
		if ($("#address").val() == '') {
			$("#address").focus();
			return;
		}
		
		if ($("#address2").val() == '') {
			$("#address2").focus();
			return;
		}
		
		if ($("#email").val() == '') {
			$("#email").focus();
			return;
		}
		
		
		$("#form").submit();
	}
   
   
   $(document).ready(function(){

	});
   

   </script>
  </body>
</html>