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
					<div class="row"><!-- cont01 -->
					  <div class="col-md-12">
						<div class="search-box v1 grid-margin">
						  <div class="row">
							<div class="col-md-3">
								<div class="form-group row">
									<label class="col-sm-2 col-form-label">ID</label>
									<div class="col-sm-10">
									  <input type="text" class="form-control" id="tel">
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group row">
									<label class="col-sm-2 col-form-label">이름</label>
									<div class="col-sm-10">
									  <input type="text" class="form-control" id="name">
									</div>
								</div>
							</div>
							<div class="col-md-6 text-right">
							  <button type="button" onclick="start();" class="btn btn-success mr-2"><i class="fas fa-search"></i>검색</button>  
							</div>  
						  </div>
						</div>	
					  </div>
					</div>
					<div class="row"><!-- cont02 -->
						<div class="table-area col-md-12">
							<table class="table v2">
							  <colgroup>
								<col width="5%">
								<col width="10%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="*">
							  </colgroup>
							  <thead>
								<tr>
								  <th><input type="checkbox" onclick="checkAll(this);"></th>
								  <th>등급</th>
								  <th>ID</th>
								  <th>이름</th>
								  <th>연락처</th>
								  <th>이메일</th>
								  <th>주소</th>
								</tr>
							  </thead>
							  <tbody id="user-list">
								
                               
							  </tbody>
							</table>
							<div aria-label="Page navigation" id="navigation">
							  
							</div>

						</div>
						<div class="col-md-12 text-right mb-2"><button type="button" onclick="document.location.href='/admin/user/form';" class="btn btn-primary mr-2">추가</button><button type="button" class="btn btn-primary" onclick="deleteUsers()">삭제</button></div>

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
   
   <script>
   
   $(document).ready(function(){
	   
		start();
  	 	
	});
   
   function start(){
	   var tel = $("#tel").val();
	   var name = $("#name").val();
	   
	   if (!tel) tel ='';
	   if (!name) name ='';
   
	   
	   selectUserList(tel,name, displayUserList);
	   
   }
   
   
   var curPage = 1;
	var sizePerPage = 10;
	var dataList = null;
   
   function displayUserList(res){
	   
	   
		
	   $("#user-list").html('');
	   if (res && res.length > 0){

		   dataList = res;
			pageSize = res.length;
		    var nextMaxPage = curPage * sizePerPage;
			
			if (nextMaxPage > res.length) nextMaxPage = res.length;
			
			for (i=0; i<res.length; i++) {
				
				console.log(res[i].name);
				
				var role = res[i].roles=='ADMIN'?'관리자':'일반사용자';
				
				var user = '<tr id="'+res[i].tel+'">';
				user += '<td class="text-center"><input type="checkbox" value="'+res[i].tel+'"></td>';
				user += '<td class="text-center">'+role+'</td>';
				user += '<td class="text-center"><a href="/admin/user/view?tel='+res[i].tel+'">'+res[i].tel+'</a></td>';
				user += '<td class="text-center">'+res[i].name+'</td>';
				user += '<td class="text-center">'+res[i].tel+'</td>';
				user += '<td class="text-left">'+res[i].email+' </td>';
				user += '<td class="text-center">'+res[i].address+' '+res[i].address2+'</td>';
				user += '</tr>';
				
				if (i>=(curPage-1)*sizePerPage &&  i< nextMaxPage){
					$("#user-list").append(user);
				}
				
			}
		}
	   
	   if (res){
			displayNavigation(res);
		}
		
   }
   
   function goPage(iPage){
		curPage = iPage;
		displayUserList(dataList);
	}
   
   function checkAll(obj){
	   
	   var status = $(obj).prop("checked");
	   
	   console.log("checkAll status : " + status);
	   
	   $("#user-list").find('input[type=checkbox]').each(function(){
		   if(status) {
			   $(this).prop("checked",true);
		   } else {
			   $(this).prop("checked",false);
		   }
	   });
   }
   
   function deleteUsers() {
	   
	   var telList = [];
	   
	   $("#user-list").find('input[type=checkbox]').each(function(){
		   if($(this).prop("checked") ) {
			  telList.push( $(this).val());
		   }
	   });
	   
	   
	   if (telList.length > 0) {
			 $.ajax({
				url: '/api/user/delete',
				type: 'POST',
				data : {'telList': telList.toString() },
				cache: false,
				//  headers:{'Content-Type': 'application/json'},
				success: function (res) {
					console.log("result:"+JSON.stringify(res));

					for (i=0; i<telList.length; i++) {
						
						$("#"+telList[i]).hide();
						
					}

				}


			}); 
	   }
	   
	   console.log("telList:" + telList.toString());
	   console.log("telList:" + telList);
   }
   </script>
  </body>
</html>