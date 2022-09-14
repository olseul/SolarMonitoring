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
					<h4>사용자 편집</h4>
					<div class="row"><!-- cont01 -->
					  <div class="table-area col-md-12">
					  <form id="form" action="/admin/user/update" method="post">
							<table class="table v3">
								<colgroup>
									<col width="30%">
									<col width="*">
								</colgroup>
								<tbody>
								<tr>
									<th>등급<span class="necessary">*</span></th>
									<td>
										<select class="form-control" style="width: 50%;" name="roles" id="roles" disabled>
										 <option value="USER">사용자</option>
										 <option value="ADMIN">관리자</option>
									    </select>
									</td>
								</tr>
								<tr>
									<th>연락처(ID)<span class="necessary">*</span></th>
									<td>
										<input type="text" class="form-control" name="tel" id="tel" value="" maxLength="13" style="width: 50%;" disabled>
										<span class="text-primary fnt12">※ ID는 연락처로 사용됩니다.</span>
									</td>
								</tr>

								<tr>
									<th>새 비밀번호<span class="necessary">*</span><br><small style="color:#0000ff;">영문 대소문자,숫자,특수문자 조합으로 8자 ~ 20자 입력</small></th>
									<td><input type="password" name="password" id="password" class="form-control" maxlength="20" style="width: 50%;" autocomplete = "off" onfocusout="passwordCheck()"></td>
								</tr>
								<tr>
									<th>비밀번호 확인<span class="necessary">*</span></th>
									<td><input type="password"  name="password2" id="password2"  class="form-control" maxlength="20" style="width: 50%;"  autocomplete = "off" onfocusout="passwordCheck()">
									<span class="text-primary fnt12 text-warning" id="password-warning" style="display:none;">※비밀번호를 다르게 입력하였습니다.</span></td>
								</tr>
								<tr>
									<th>이름<span class="necessary">*</span><br><small style="color:#0000ff;">한글 2자 ~ 20자 입력</small></th>
									<td><input type="text" class="form-control" name="name" id="name" maxlength="20" style="width: 50%;"></td>
								</tr>
								<tr>
									<th>주소<span class="necessary">*</span><br><br><br>상세주소</th>
									<td>
										<p><input type="text" class="form-control" style="width: 50%;" name="address"  maxlength="128" id="address" readonly="readonly"><button type="button" class="btn btn-outline-primary btn-sm ml-2" style="vertical-align: top;" onclick="openPost();">주소찾기</button></p>
										<p style="margin-bottom: 0"><input type="text" class="form-control" style="width: 80%;" name="address2" id="address2"  maxlength="128"></p>
									</td>
								</tr>
								<tr>
									<th>이메일<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" name="email" id="email"  maxlength="64" placeholder="example@example.com" style="width: 50%;"></td>
								</tr>
								<tr>
									<th>메모</th>
									<td><textarea class="form-control" rows="5" name="memo" id="memo"  maxlength="100"></textarea></td> 
								</tr>
								</tbody>
							</table>
							</form>
						</div>
						<div class="col-md-12 text-right mb-2 mt-3">
						<d style="font-size:18px; font-weight:bold;">관리자 비밀번호 <span class="necessary" style="color:red;">*</span></d>
						<input type="password"  name="password_auth" id="password_auth"  class="form-control" maxlength="20" style="width: 10%; border-color:red;" autocomplete = "off">
						 <button type="button" onclick="doSave()" class="btn btn-primary mr-2">수정</button><!-- <button type="submit" class="btn btn-primary">삭제</button> --></div>
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
		var namePattern = "^([가-힣]{2,20})$";
		var addressPattern = "^([가-힣A-Z0-9\\.\\- ]{1,128})$";
		var emailPattern = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";
		
		if ($("#tel").val() == '') {
			$("#tel").focus();
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
			alert("비밀번호 재입력란을 다시 확인해 주세요.");
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
		
		console.log("tel:"+ $("#tel").val());
		
		var data = {
				"password":$("#password").val(),
				"name":$("#name").val(),
				"address":$("#address").val(),
				"address2":$("#address2").val(),
				"email":$("#email").val(),
				"memo":$("#memo").val(),
				"roles":$("#roles").val(),
				"passwordauth":$("#password_auth").val()
		};
		
		console.log("data:"+JSON.stringify(data));
		
		var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": "/admin/user/update/"+$("#tel").val(),
		  "method": "PUT",
		  "headers": {
		    "authorization": "<%=authorization%>",
		    "content-type": "application/json;charset=utf-8",
		    "cache-control": "no-cache",
		    "postman-token": "e36c61c4-58c1-ce20-dea9-1d3a08895299"
		  },
		  "data":JSON.stringify(data)
		}

		$.ajax(settings).done(function (response) {
			alert("사용자 정보가 업데이트 되었습니다.");
		  document.location.href = "/admin/user/list";
		}).fail(function(err) {
			if(err.status == 406) {
				alert("비밀번호 입력 기준에 맞춰 입력해 주세요.");
				$("#password").focus();
			}
			else if(err.status == 405) {
				alert("현재 로그인 된 관리자 비밀번호가 일치하지 않습니다.");
			}
			else 
				alert('사용자 정보 업데이트에 실패하였습니다.' );
		});
		
		
		//$("#form").submit();
	}
   
   
	   
   $(document).ready(function(){
	   
	   <%
	   
	   	String tel = XssPreventer.escape(request.getParameter("tel"));
	   
	   	if ( StringUtil.isEmpty(tel)) {
	   		out.println("alert('사용자 정보가 없습니다.');");
	   	}
	   %>
   
  	 	$.ajax({
			url: '/api/user/view',
			type: 'GET',
			data : {"tel":"<%=tel%>" },
			cache: false,
			//  headers:{'Content-Type': 'application/json'},
			success: function (res) {
				console.log("result:"+JSON.stringify(res));
				
				if (res && res != ''){

					$("#roles").val(res.roles);
					$("#tel").val(res.tel);
					$("#name").val(res.name);
					//$("#postcode").val(res.postcode);
					$("#address").val(res.address);
					$("#address2").val(res.address2);
					$("#email").val(res.email);
					$("#memo").text(res.memo);
					
					
				}

			}


		});
  	 	
  	 	
  	 	
	});
   

   </script>
  </body>
</html>