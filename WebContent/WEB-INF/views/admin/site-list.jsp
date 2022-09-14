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
									  <select class="form-control" id="area">
									  <option value="">전체</option>
									  <option>강원</option>
									  <option>경북</option>
									  <option>경남</option>
									  <option>전북</option>
									  <option>전남</option>
									  <option>제주특별자치도</option>
									  <option>충북</option>
									  <option>충남</option>
									  <option>서울</option>
									  <option>광주</option>
									  <option>대구</option>
									  <option>대전</option>
									  <option>부산</option>
									  <option>울산</option>
									  <option>인천</option>
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
							<div class="col-md-5 text-right">
								<small style="color:#ff0000; display:none;" id="no_result">조회 결과가 없습니다.</small> 
							</div>
							<div class="col-md-1 text-right">
							  <button type="button" class="btn btn-success mr-2"  onclick="start()"><i class="fas fa-search"></i>검색</button>  
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
   		initSetting();
	    start();	   
	});
   

   var curPage = 1;
	var sizePerPage = 10;
	//var dataList = null;
	
	var dataList;
	
   function initSetting() {
	   curPage = 1;
	   $("#name").val("");
   }
	
	function start(){
		curPage = 1;
		readSiteList();
	}
	
	function readPage() {
		if(dataList) {
			$(".table.v2").find("input[type=checkbox]").each(function() { $(this).prop("checked",false); });
			
			pageSize = dataList.length;
		    var nextMaxPage = curPage * sizePerPage;
			
			if (nextMaxPage > dataList.length) nextMaxPage = dataList.length;
			
		   var nameIsOk = true;
		   $("#site-list").html('');
		   var site = '';
		   for (i=0; i<dataList.length; i++) {
			   
			   console.log("sid:" + dataList[i].sid);
			   
			   	site='<tr id=' + dataList[i].sid + '>';
				site+='	  <td class="text-center"><input type="checkbox" value='+dataList[i].sid+'></td>';
				site+='  <td class="text-center"><a href="/admin/site/view?sid='+dataList[i].sid+'">'+dataList[i].sid+'</a></td>';
				site+='  <td class="text-center">'+dataList[i].name+'</td>';
				site+='  <td class="text-center">'+dataList[i].address+'  </td>';
				site+='  <td class="text-center">'+dataList[i].builder+'</td>';
				site+='  <td class="text-center">'+dataList[i].owner+'</td>';
				site+='  <td class="text-center">'+dataList[i].tel+'</td>';
				site+='  <td class="text-center">'+dataList[i].build_date.split(' ')[0]+'</td>';
				site+='</tr>';
			   
				if (i>=(curPage-1)*sizePerPage &&  i< nextMaxPage){
					$("#site-list").append(site);
				}
		   }
		}
		
		if (dataList){
			displayNavigation(dataList);
		}
		
		if(pageSize <= sizePerPage) {
			$("#navigation").attr("style","visibility:hidden");
		} else {
			$("#navigation").attr("style","visibility:");
		}
	}
	
   function readSiteList() {
		
	   var name = $("#name").val();
	   var address = $("#area").val();
	   
	   console.log("name:" + name);
	   
	   if(!name) name='';
	  
	   
	   var settings = {
		   "async": true,
		   "crossDomain": true,
		   "url": "<%=API_HOST%>/api/sites?name="+name+"&address="+address,
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
			   	if(response.length == 0) $("#no_result").show();
			   	else $("#no_result").hide();
		   }		   
		   
		   dataList = response;
		   readPage();
		 });
   }
   
   function goPage(iPage){
		curPage = iPage;
		readPage();
		//readSiteList();
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
		   if(confirm("정말 삭제하시겠습니까? 삭제 시, 사용이 불가능할 수 있습니다.")) {
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
					   /* for (i=0; i<siteList.length; i++) {
							
						$("#"+siteList[i]).hide();
						} */ 
					   
					    siteLength--;
					   
					   if (siteLength == 0) {
						   initSetting();
						   readSiteList(); 
					   }
					 });
			   }
		   }
	   }
	   
   }
   </script>
  </body>
</html>