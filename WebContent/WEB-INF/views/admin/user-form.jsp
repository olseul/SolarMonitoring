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
					  <form id="form"> 
							<table class="table v3">
								<colgroup>
									<col width="30%">
									<col width="*">
								</colgroup>
								<tbody>
								<tr>
									<th>등급<span class="necessary">*</span></th>
									<td>
										<select class="form-control" style="width: 50%;" name="roles" id="roles">
										 <option value="USER">사용자</option>
										 <option value="ADMIN">관리자</option>
									    </select>
									</td>
								</tr>
								<tr>
									<th>연락처(ID)<span class="necessary">*</span></th>
									<td>
										<input type="text" class="form-control" name="tel" id="tel" value="" placeholder="000-000(0)-0000" maxLength="13" onkeydown="onlyPhone(this)" style="width: 50%;">
										<span class="text-primary fnt12">※ ID는 연락처로 사용됩니다.</span>
									</td>
								</tr>
								<tr>
									<th>비밀번호<span class="necessary">*</span><br><small style="color:#0000ff;">영문 대소문자,숫자,특수문자 조합으로 8자 ~ 20자 입력</small></th>
									<td><input type="password" maxlength="20" name="password" id="password" class="form-control" style="width: 50%;" onfocusout="passwordCheck()" autocomplete = "off"></td>
									
								</tr>
								<tr>
									<th>비밀번호 확인<span class="necessary">*</span></th>
									<td><input type="password" maxlength="20" name="password2" id="password2"  class="form-control" style="width: 50%;" onfocusout="passwordCheck()" autocomplete = "off">
									<span class="text-primary fnt12 text-warning" id="password-warning" style="display:none;">※비밀번호를 다르게 입력하였습니다.</span></td>
								</tr>
								<tr>
									<th>이름<span class="necessary">*</span><br><small style="color:#0000ff;">한글 2자 ~ 20자 입력</small></th>
									<td><input type="text" maxlength="20" class="form-control" name="name" id="name" style="width: 50%;"></td>
								</tr>
								<tr>
									<th>주소<span class="necessary">*</span><br><br><br>상세주소</th> 
									<td> 
										<p><input type="text" class="form-control" maxlength="128" style="width: 50%;" name="address" id="address" readonly="readonly"><button type="button" class="btn btn-outline-primary btn-sm ml-2" style="vertical-align: top;" onclick="openPost();">주소검색</button></p>
										<p style="margin-bottom: 0"><input type="text" class="form-control" maxlength="128" style="width: 80%;" name="address2" id="address2"></p>
									</td>
								</tr>
								<tr>
									<th>이메일<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" name="email" id="email" placeholder="example@example.com" maxlength="64" style="width: 50%;"></td>
								</tr>
								<tr>
									<th>메모</th>
									<td><textarea class="form-control" rows="5" name="memo" id="memo" maxlength="100"></textarea></td>
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
			
				//$("#postcode").val(data.zonecode   );
				
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
		var pw = $("#password").val();
		var pw2 = $("#password2").val()
		
		if ((pw.length > 0 && pw2.length > 0) && pw != pw2) {
			$("#password-warning").show();
			return;
		} else {
			$("#password-warning").hide();
		}
	}
	
	function doSave() {
		var telPattern = "^([0-9]{3})-([0-9]{3,4})-([0-9]{4})$";
		var namePattern = "^([가-힣]{2,20})$";
		var addressPattern = "^([가-힣A-Z0-9\\.\\- ]{1,128})$";
		var emailPattern = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";
		
		if ($("#tel").val() == '') {
			$("#tel").focus();
			alert("연락처를 입력해 주세요.");
			return;
		}
		
		if( !$("#tel").val().match(telPattern)) {
			$("#tel").focus();
			alert("연락처를 양식에 맞게 입력해 주세요.");
			return;
		}
		
		if ($("#password").val() == '') {
			$("#password").focus();
			alert("비밀번호를 입력해 주세요.");
			return;
		}
		
		
		if ($("#password").val() != $("#password2").val()) {
			$("#password2").focus();
			$("#password-warning").show();
			alert("비밀번호 확인 입력을 다시 확인해 주세요.");
			return;
		}
		
		
		if ($("#name").val() == '') {
			$("#name").focus();
			alert("이름을 입력해 주세요.");
			return;
		}
		
		if (!$("#name").val().match(namePattern)) {
			$("#name").focus();
			alert("이름을 양식에 맞게 입력해 주세요.");
			return;
		}
		
		if ($("#address").val() == '') {
			$("#address").focus();
			alert("주소를 입력해 주세요.");
			return;
		}
		
		if (!$("#address").val().match(addressPattern)) {
			$("#address").focus();
			alert("주소를 다시 입력해 주세요.");
			return;
		}
		
		if ($("#email").val() == '') {
			$("#email").focus();
			alert("이메일 주소를 입력해 주세요.");
			return;
		}
		
		if (!$("#email").val().match(emailPattern)) {
			$("#email").focus();
			alert("이메일 주소를 양식에 맞게 입력해 주세요.");
			return;
		}
		
		//var data = $("#form").serialize();
		
		//$("#form").submit();
		
		var data = {
				tel 		: $('#tel').val(),
				password	: $('#password').val(),
				name		: $("#name").val(),
				postcode	: $("#postcode").val(),
				address		: $("#address").val(),
				address2	: $("#address2").val(),
				email		: $("#email").val(),
				memo  		: $("#memo").val(),
				roles 		: $("#roles").val() === "ADMIN" ? "ADMIN" : "USER"
		}
		

		var settings = {
				  "async": true, 
				  "crossDomain": true,
				  "url": "/admin/user/add",
				  "method": "POST",
				  "headers": {
				    "authorization": "<%=authorization%>",
				    "content-type": "application/json;charset=UTF-8",
				    "cache-control": "no-cache",
				  },
				  "data": JSON.stringify(data)//JSON.stringify(data)
				}

				$.ajax(settings).done(function (response) {
				  console.log(response);
				  alert("사용자가 등록되었습니다.");
				  document.location.href = "/admin/user/list";
				}).fail(function(err){
					
					console.log(err);
					if(err.status == 409) {
						alert("동일한 사용자 ID가 존재합니다.");
						$("#tel").focus();
					}
					else if(err.status == 406) {
						alert("비밀번호 입력 기준에 맞춰 입력해 주세요.");
						$("#password").focus();
					}
					else 
						alert('사용자 등록이 실패하였습니다.' );
				});
	}
   
   
   $(document).ready(function(){

	});
   

   </script>
  </body>
</html>