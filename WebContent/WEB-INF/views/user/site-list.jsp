<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./header.jsp" %>
<%@ include file="./LNB.jsp" %>
    <%
    String msg = request.getParameter("msg");
    String devicetype = StringUtil.nvl(request.getParameter("devicetype"),"inverter");
    %>

     
        <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
            <!-- Page Title Header Starts-->
            <div class="row page-title-header">
              <div class="col-12">
                <div class="page-header">
                  <h4 class="page-title">HOME | 관리 | 발전소 관리</h4>
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
									<label class="col-sm-2 col-form-label">지역</label>
									<div class="col-sm-10">
									  <select class="form-control">
									  <option>전체</option>
									  </select>
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="form-group row">
									<label class="col-sm-3 col-form-label">발전소</label>
									<div class="col-sm-9">
									  <input type="text" class="form-control" id="name">
									</div>
								</div>
							</div>
							<div class="col-md-6 text-right">
							  <button type="button" class="btn btn-success mr-2"><i class="fas fa-search" onclick="start()"></i>검색</button>  
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
								<col width="*%">
								<col width="15%">
								<col width="15%">
								<col width="10%">
							  </colgroup>
							  <thead>
								<tr>
								  <th><input type="checkbox" onclick="checkAll(this)"></th>
								  <th>ID</th>
								  <th>발전소명</th>
								  <th>주소</th>
								  <th>시공사</th>
								  <th>담당자</th>
								  <th>연락처</th>
								  <th>설치일자</th>
								</tr>
							  </thead>
							  <tbody id="site-list">
								
							  </tbody>
							</table>
							<div aria-label="Page navigation" id="navigation">
							  
							</div>
						</div>
						<div class="col-md-12 text-right mb-2"><a href="/admin/site/form"><button type="button" class="btn btn-primary mr-2">추가</button></a><button type="button"  onclick="deleteSite()" class="btn btn-primary">삭제</button></div>
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
   

   var curPage = 1;
	var sizePerPage = 10;
	//var dataList = null;
	
	function start(){
		curPage = 1;
		readSiteList();
	}
   function readSiteList() {
		
	   var name = $("#name").val();
	   
	   console.log("name:" + name);
	   
	   if(!name) name='';
	  
	   
	   var settings = {
		   "async": true,
		   "crossDomain": true,
		   "url": "<%=API_HOST%>/api/sites?name="+name+"&address=",
		   "method": "GET",
		   "headers": {
		     "authorization": "<%=authorization%>",
		     "cache-control": "no-cache",
		     "content-type": "application/json;charset=utf-8"
		   }
		 }
	   
	   	console.log(settings);

	   $("#site-list").html('');
	   
		 $.ajax(settings).done(function (response) {
		   console.log(response);
		 
		   if ( response) {
			   
			    pageSize = response.length;
			    var nextMaxPage = curPage * sizePerPage;
				
				if (nextMaxPage > response.length) nextMaxPage = response.length;
				
			   var nameIsOk = true;
			   
			   var site = '';
			   for (i=0; i<response.length; i++) {
				   
				   console.log("sid:" + response[i].sid);
				   
				   	site='<tr>';
					site+='	  <td class="text-center"><input type="checkbox" value='+response[i].sid+'></td>';
					site+='  <td class="text-center"><a href="/admin/site/view?sid='+response[i].sid+'">'+response[i].sid+'</a></td>';
					site+='  <td class="text-center">'+response[i].name+'</td>';
					site+='  <td class="text-center">'+response[i].address+'  </td>';
					site+='  <td class="text-center">'+response[i].builder+'</td>';
					site+='  <td class="text-center">'+response[i].owner+'</td>';
					site+='  <td class="text-center">'+response[i].tel+'</td>';
					site+='  <td class="text-center">'+response[i].build_date.split(' ')[0]+'</td>';
					site+='</tr>';
				   
					if (i>=(curPage-1)*sizePerPage &&  i< nextMaxPage){
						$("#site-list").append(site);
					}
			   }
			   
		   }
		   
		   if (response){
				displayNavigation(response);
			}
		   
		 });
   }
   
   function goPage(iPage){
		curPage = iPage;
		readSiteList();
	}
   
   function checkAll(obj){
	   
	   var status = $(obj).prop("checked");

	   
	   $("#site-list").find('input[type=checkbox]').each(function(){
		   if(status) {
			   $(this).prop("checked",true);
		   } else {
			   $(this).prop("checked",false);
		   }
	   });
   }
   
   function deleteSite() {
	   
	   var siteList = [];
		   
	   $("#site-list").find('input[type=checkbox]').each(function(){
		   if($(this).prop("checked") ) {
			   siteList.push( $(this).val());
		   }
	   });
	   
	   var siteLength = siteList.length;
	   
	   if (siteList.length > 0) {
		   for(i=0; i<siteList.length; i++){
			   var settings = {
				   "async": true,
				   "crossDomain": true,
				   "url": "<%=API_HOST%>/api/sites/" + siteList[i],
				   "method": "DELETE",
				   "headers": {
				     "authorization": "<%=authorization%>",
				     "cache-control": "no-cache",
				   }
				 }
	
				 $.ajax(settings).done(function (response) {
				   console.log(response);
				   siteLength--;
				   
				   if (siteLength == 0) {
					   readSiteList();
				   }
				 });
		   }
	   }
	   
   }
   </script>
  </body>
</html>