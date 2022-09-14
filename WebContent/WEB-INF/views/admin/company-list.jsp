<%@page import="com.sungchang.common.util.APIHostUtil"%>
<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./header.jsp" %>
<%@ include file="./LNB.jsp" %>
    <%
    String msg = request.getParameter("msg");
    
     
    %>

       <!-- partial -->
      	<input type="hidden" id="last-name" value="" disabled readonly/>
      	<input type="hidden" id="last-area" value="" disabled readonly/>
      	<input type="hidden" id="last-state" value="" disabled readonly/>
      	<input type="hidden" id="last-buildyear" value="" disabled readonly/>
      	
        <div class="main-panel">
          <div class="content-wrapper">
            <!-- Page Title Header Starts-->
            <div class="row page-title-header">
              <div class="col-12">
                <div class="page-header">
                  <h4 class="page-title">HOME | 발전소 선택</h4>
                </div>
              </div>
            </div>
            <!-- Page Title Header Ends-->
            <div class="row"><!-- cont01 -->
              <div class="col-md-4 grid-margin stretch-card">
                <div class="card">
                  <div class="card-header"><h4 class="card-title mb-0">전체 발전소 용량</h4></div>
				  <div class="card-body">
                    <div class="num-date">
                    	<img class="loading-content" src="/statics/assets/images/89.png" alt=""/>
                    	<strong class="shd" id="totalcapacity"></strong> kW</div>
                  </div>
                </div>
              </div>
              <div class="col-md-4 grid-margin stretch-card">
                <div class="card">
                  <div class="card-header"><h4 class="card-title mb-0">오늘 총 누적발전량</h4></div>
				  <div class="card-body">
                    <div class="num-date">
                    	<img class="loading-content" src="/statics/assets/images/89.png" alt=""/>
                    	<strong class="shd" id="sum_calc"></strong> kW</div>
                  </div> 
                </div>
              </div>
              <div class="col-md-4 grid-margin stretch-card">
                <div class="card">
                  <div class="card-header"><h4 class="card-title mb-0">오늘 Co2 감축량</h4></div>
				  <div class="card-body">
                    <div class="num-date">
                    	<img class="loading-content" src="/statics/assets/images/89.png" alt=""/>
                    	<strong class="shd" id="co2reduce"></strong> tCo2</div>
                  </div>
                </div>
              </div>
            </div>
			<div class="row"><!-- cont02 -->
              <div class="col-md-12 col-lg-12 col-xl-12">
                <div class="search-box grid-margin">
				  <div class="row">
					<div class="col-md-6 col-lg-6 col-xl-3">
						<div class="form-group row">
							<label class="col-md-4 col-lg-4 col-xl-3 col-form-label">지역</label>
							<div class="col-md-8 col-lg-8 col-xl-9">
							  <select class="form-control" id='area'>
                                
                              </select>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-lg-6 col-xl-3">
						<div class="form-group row"> 
							<label class="col-md-4 col-lg-4 col-xl-5 col-form-label">발전소</label>
							<div class="col-md-8 col-lg-8 col-xl-7">
                              <input type="text" class="form-control" id='site-name' >
							</div>
						</div>
					</div>
					<div class="col-sm-12 col-md-6 col-lg-6 col-xl-3">
						<div class="form-group row">
							<label class="col-sm-4 col-md-4 col-lg-4 col-xl-5 col-form-label">설치연도</label>
							<div class="col-sm-8 col-md-8 col-lg-8 col-xl-7">
							  <select class="form-control" id="buildyear">
                               
                              </select>
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-md-6 col-lg-6 col-xl-3"> 
						<div class="form-group row">
							<label class="col-sm-4 col-md-4 col-lg-4 col-xl-5 col-form-label">상태</label>
							<div class="col-sm-8 col-md-8 col-lg-8 col-xl-7">
							  <select class="form-control" id="state">
                               
                              </select>
							</div>
						</div>
					</div>
					<div class="col-md-12 col-lg-12 col-xl-12"><br></div>
					<div class="col-md-12 col-lg-12 col-xl-12 text-right">
					  <button type="button" class="btn btn-success mr-2 col-md-12 col-lg-12 col-xl-12" onclick="readSiteList();"><i class="fas fa-search"></i>검색</button>  
					</div>  
                  </div>
				</div>	
              </div>
            </div>
			<div class="row"><!-- cont03 -->
				<div class="col-md-12">
					<div class="table-area">
						<table class="table v1">
						  <thead>
							<tr>
							  <th>ID</th>
							  <th>발전소명</th>
							  <th>담당자</th>
							  <th>설비용량</th>
							  <th>순간발전량</th>
							  <th>오늘 누적발전량</th>
							  <th>설치연도</th>
							  <th>상태</th>
							</tr>
						  </thead>
						  <tbody id="site-list">
						  	<img class="loading-table" src="/statics/assets/images/89.png" alt=""/>
						  </tbody>
						</table>
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
   
   var timeoutHandler;
   $(document).ready(function(){
	   
	   initSetting();
	   readTotal();
	   readSiteList();
	   
	   clearInterval(timeoutHandler);
	   timeoutHandler = setInterval(function() { readSiteState(); }, 60000);
	});
   
   function initSetting() {
	   $("#last-name").val($("#site-name").val());
	   $("#last-area").val($("#site-area").val());
	   $("#last-state").val($("#site-state").val());
	   $("#last-buildyear").val($("#site-buildyear").val());
   }

   function readSiteList() {
		
	   var name = $("#site-name").val();
	   var area = $("#area").val();
	   var state = $("#state").val();
	   var buildyear = $("#buildyear").val();
	   
	   $("#last-name").val(name);
	   $("#last-area").val(area);
	   $("#last-state").val(state);
	   $("#last-buildyear").val(buildyear);
	   
	   console.log("name:" + name);
	    
	   if(!name) name='';
	   if(!area) area='';
	   if(!state) state='';
	   if(!buildyear) buildyear='';
	  
	   
	   var settings = {
		   "async": true,
		   "crossDomain": true,
		   "url": "<%=API_HOST%>/api/sitelist?name="+name+"&address="+area+"&buildyear="+buildyear+"&statecode="+state,
		   "method": "GET",
		   "headers": {
		     "authorization": "<%=authorization%>",
		     "cache-control": "no-cache",
		     "content-type": "application/json;charset=utf-8"
		   }
		 }
	   
	   	console.log(settings);
		   
	   	   $("#site-list").html('');
		   $(".loading-table").show();
	   
		  $.ajax(settings).done(function (response) {
			  $(".loading-table").hide();
			  clearInterval(timeoutHandler);
		   if ( response) {
			   $("#site-list").html(''); 
			
			   var filter = response.filter;
			   var sites = response.sites;
			   
			   displayFilter(filter);
			   
			   var site = '';
			   
			   for (i=0; i<sites.length; i++) {
				   
				   console.log(JSON.stringify(sites[i]));
				   
				   var state_code = '';
				   
				   if (sites[i].state == '발전중'){
					   state_code='ing';
				   } else if (sites[i].state == '발전중지'){
					   state_code='stop';
				   } else if (sites[i].state == '경고'){
					   state_code='warning';
				   } 
				   
				   var siteItem = sites[i];
				   
				   var sid = String(siteItem.sid);
				     
				   var pad ='';	  
				   for(j=0; j<(4-sid.length); j++){
					  pad +='0';
				   }
			       sid = pad + sid;
			      
				   
				    site='<tr id=' + sid + ' onClick="goSolarMonitoring('+siteItem.sid+',\''+sites[i].haveESS+'\')" >';
					site+='	 <td class="text-center" ><span class="badge badge-warning fnt20">'+sid+'</span></td>';
					site+='	 <td>'+sites[i].name+'<br><span class="fnt12">'+sites[i].address+'</span></td>';
					site+='  <td class="text-center">'+sites[i].owner+'</td>';
					site+='  <td class="text-center">'+sites[i].capacity+'</td>';
					site+='  <td class="text-center"><st id="sum_output">'+sites[i].sum_output+'</st>  </td>';
					site+='  <td class="text-center">'+sites[i].sum_todayaccu+'</td>';
					site+='  <td class="text-center">'+sites[i].buildyear+'</td>';
					site+='  <td class="text-center"><st id="state">'+sites[i].state+'</st><br><span id="code" class="circle-'+state_code+'" ></span></td>';
					site+='</tr>'; 
				   
					$("#site-list").append(site);
			   } 
			   
			   if(response.sites.length > 0)
			   timeoutHandler = setInterval(function() { readSiteState(); }, 60000);
		   }
		   
		 }); 
   }
   
   function readSiteState() {
	   var name = $("#last-name").val();
	   var area = $("#last-area").val();
	   var state = $("#last-state").val();
	   var buildyear = $("#last-buildyear").val();
	   
	   console.log("last ... name : " + name + ", area : " + area + ", state : " + state + ", buildyear : " + buildyear);
	   
	   if(!name) name='';
	   if(!area) area='';
	   if(!state) state='';
	   if(!buildyear) buildyear='';
	   
	   var settings = {
			   "async": true,
			   "crossDomain": true,
			   "url": "<%=API_HOST%>/api/sitestate?name="+name+"&address="+area+"&buildyear="+buildyear+"&statecode="+state,
			   "method": "GET",
			   "headers": {
			     "authorization": "<%=authorization%>",
			     "cache-control": "no-cache",
			     "content-type": "application/json;charset=utf-8"
			   }
	   };
		   
	  $.ajax(settings).done(function (response) {		     
		   if (response) {
			   
		   		for(var i =0 ; i < response.length; i++) {
		   			var _sid = response[i].sid;
		   			var _statecode = response[i].statecode;
		   			var _state = _statecode == 0 ? "발전중" : _statecode == 2 ? "발전중지" : "발전중지";
		   			
		   			$("#" + (_sid + "").padStart(4,"0") + ">td>st#state").html(_state); 
		   			$("#" + (_sid + "").padStart(4,"0") + ">td>span#code").removeClass("circle-stop");
		   			$("#" + (_sid + "").padStart(4,"0") + ">td>span#code").removeClass("circle-ing");
		   			
		   			$("#" + (_sid + "").padStart(4,"0") + ">td>span#code").addClass( _statecode == 0 ? "circle-ing" : _statecode == 2 ? "circle-stop" : "circle-stop");
		   			
		   		}
		   }
	 });
   }
   
   function readTotal(){
	   var settings = {
		   "async": true,
		   "crossDomain": true,
		   "url": "<%=API_HOST%>/api/totalsiteinfo",
		   "method": "GET",
		   "headers": {
		     "authorization":"<%=authorization%>",
		     "cache-control": "no-cache",
		   }
		 }

		 $.ajax(settings).done(function (response) {
		   console.log("read total:" + response);
		   
		   $("#totalcapacity").text(numberWithCommas(response.totalcapacity+''));
		   $("#sum_calc").text(numberWithCommas(response.sum_calc+''));
		   $("#co2reduce").text(numberWithCommas(response.co2reduce+''));
		   
		   $(".loading-content").hide();
		   
		 });
   }
      
   function displayFilter(filter){
	
	   var series_area = filter.series_area;
	   var series_state = filter.series_state;
	   var maxyear = filter.maxyear;
	   var minyear = filter.minyear;
	   
	   console.log("option length:" + $("#buildyear option").length);
	   if ($("#buildyear option").length == 0 ) {
		   
		   $("#buildyear").append('<option value="">전체</option>');
		   
		   for(i=maxyear; i>=minyear; i--){
			   var yearOption = "<option value="+i+" >" + i + "</option>";
			   
			   $("#buildyear").append(yearOption);
		   }
	   }
	   
		if ($("#area option").length == 0 ) {
		   
			$("#area").append('<option value="">전체</option>');
			
		   for(i=0; i<series_area.length; i++){
			   
			   var option = "<option >" + series_area[i] + "</option>";
			   
			   $("#area").append(option);
		   }
	   }
		
		if ($("#state option").length == 0 ) {
			
			$("#state").append('<option value="">전체</option>');
			   
		   for(i=0; i<series_state.length; i++){
			   var option = "";
			   
			   if(series_state[i] == "발전중지")
				   option = "<option value=2>" + series_state[i] + "</option>";
			   else
			   		option = "<option value="+i+">" + series_state[i] + "</option>";
			   
			   $("#state").append(option);
		   }
	   }
				
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
   
   function goSolarMonitoring(sid,haveEss){
	   if (sid){
	   	setCookie("sid", sid);
	   }
	   if (haveEss == 'true'){
		   	document.location.href="/admin/ess/monitoring";
	   } else{
	   		document.location.href="/admin/solar/monitoring";
	   }
   }
   </script>
  </body>
</html>