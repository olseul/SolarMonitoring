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
                  <h4 class="page-title">HOME | 관리 | 발전소 관리</h4>
                </div>
              </div>
            </div>
            <!-- Page Title Header Ends-->
            <div class="row">
				<div class="w-box">
					<h4>발전소 편집</h4>
					<div class="row"><!-- cont01 -->
					  <div class="table-area col-md-12">
							<table class="table v3">
								<colgroup>
									<col width="15%">
									<col width="35%">
									<col width="15%">
									<col width="35%">
								</colgroup>
								<tbody>
								<form id="siteForm">
								<tr>
									<th>발전소 ID<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="sid" id="sid" onkeydown="onlyNumberLimit(this,4)"; readonly>
									<br><br><span class="text-primary " style="display:none" id="sid-validate-txt"></span>
									</td>
									<th>발전소명<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="name" id="name" readonly>
									<br><br><span class="text-primary " style="display:none" id="name-validate-txt"></span>
									</td>
								</tr>
								<tr>
									<th>주소<span class="necessary">*</span></th>
									<td colspan="3">
										<p><input type="text" class="form-control" style="width: 50%;" name="address" id="address" value=""><button type="button" class="btn btn-outline-primary btn-sm ml-2" style="vertical-align: top;"  onclick="openPost();" >주소검색</button></p>
										<p style="margin-bottom: 0"><input type="text" class="form-control" style="width: 80%;" name="address2" id="address2" value=""></p>
									</td>
								</tr>
								<tr>
									<th>위도<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="latitude" id="latitude"></td>
									<th>경도<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="longitude" id="longitude"></td>
								</tr>
								<tr>
									<th>시공사</th>
									<td colspan="3"><input type="text" class="form-control" style="width: 50%;" value="" name="builder" id="builder"></td>
								</tr>
								<tr>
									<th>담당자</th>
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="owner" id="owner"></td>
									<th>연락처</th>
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="tel" id="tel"></td>
								</tr>
								<tr>
									<th>설치일자<span class="necessary">*</span></th>
									<td colspan="3"><input type="text" class="form-control" style="width: 50%;" value="" name="build_date" id="build_date"></td>
								</tr>
								<tr>
									<th>발전소 사진</th>
									<td colspan="3"><input type="file" id="file" class="form-control" style="width: 60%;" > <span><a href="/admin/site/image/view?sid=<%=request.getParameter("sid")%>" id="view-picture" target="_new" style="display:none;">사진보기</a></span></td>
								</tr>
								<tr>
									<th>메모</th>
									<td colspan="3"><textarea class="form-control" rows="5" name="memo" id="memo"></textarea></td>
								</tr>
								</form>
								<tr>
									<th>설비</th>
									<td colspan="3">
										<ul class="nav nav-tabs plant-tabs" id="plant" role="tablist">
											<li class="nav-item" role="presentation">
												<a class="nav-link active" id="plant01-tab" data-toggle="tab" href="#plant01" role="tab" aria-controls="plant01" aria-selected="true">인버터</a>
											</li>
											<li class="nav-item" role="presentation">
												<a class="nav-link" id="plant02-tab" data-toggle="tab" href="#plant02" role="tab" aria-controls="plant02" aria-selected="false">트래커</a>
											</li>
											<li class="nav-item" role="presentation">
												<a class="nav-link" id="plant03-tab" data-toggle="tab" href="#plant03" role="tab" aria-controls="plant03" aria-selected="false">센서스테이션</a>
											</li>
											<li class="nav-item" role="presentation">
												<a class="nav-link" id="plant04-tab" data-toggle="tab" href="#plant04" role="tab" aria-controls="plant04" aria-selected="false">ESS</a>
											</li>
										</ul>
										<div class="tab-content plant-cont" id="myTabContent">
											<div class="tab-pane fade show active" id="plant01" role="tabpanel" aria-labelledby="plant01-tab">
												<table class="table v4">
													<colgroup>
														<col width="10%">
														<col width="20%">
														<col width="20%">
														<col width="20%">
														<col width="*">
													</colgroup>
													<thead>
														<tr>
															<th>ID</th>
															<th>명칭</th>
															<th>위도</th>
															<th>경도</th>
															<th>모델명</th>
														</tr>
													  </thead>
													<tbody id="inverter-list">

													<tr>
														<!-- <td><input type="text" class="form-control" value="0123"></td>
														<td><input type="text" class="form-control" value="203동"></td> -->
														<td colspan="5"><button type="button" class="btn btn-outline-success ml-2" style="vertical-align: top" onclick="addDevice('inverter')">+ 인버터 추가</button></td>
													</tr>
													</tbody>
												</table>
											</div>
											<div class="tab-pane fade" id="plant02" role="tabpanel" aria-labelledby="plant02-tab">
												<table class="table v4">
													<colgroup>
														<col width="10%">
														<col width="20%">
														<col width="20%">
														<col width="20%">
														<col width="*">
													</colgroup>
													<thead>
														<tr>
															<th>ID</th>
															<th>명칭</th>
															<th>위도</th>
															<th>경도</th>
															<th>모델명</th>
														</tr>
													  </thead>
													<tbody id="tracker-list">
													
													<tr>
														<!-- <td><input type="text" class="form-control" value="0123"></td>
														<td><input type="text" class="form-control" value="203동"></td> -->
														<td colspan="5"><button type="button" class="btn btn-outline-success ml-2" style="vertical-align: top"  onclick="addDevice('tracker')">+ 트래커 추가</button></td>
													</tr>
													</tbody>
												</table>
											</div>
											<div class="tab-pane fade" id="plant03" role="tabpanel" aria-labelledby="plant03-tab">
												<table class="table v4">
													<colgroup>
														<col width="10%">
														<col width="20%">
														<col width="20%">
														<col width="20%">
														<col width="*">
													</colgroup>
													<thead>
														<tr>
															<th>ID</th>
															<th>명칭</th>
															<th>위도</th>
															<th>경도</th>
															<th>모델명</th>
														</tr>
													  </thead>
													<tbody id="sensorstation-list">
			
													<tr>
														<!-- <td><input type="text" class="form-control" value="0123"></td>
														<td><input type="text" class="form-control" value="203동"></td> -->
														<td colspan="5"><button type="submit" class="btn btn-outline-success ml-2" style="vertical-align: top"  onclick="addDevice('sensorstation')">+ 센서스테이션 추가</button></td>
													</tr>
													</tbody>
												</table>
											</div>
											<div class="tab-pane fade" id="plant04" role="tabpanel" aria-labelledby="plant04-tab">
												<table class="table v4">
													<colgroup>
														<col width="10%">
														<col width="20%">
														<col width="20%">
														<col width="20%">
														<col width="*">
													</colgroup>
													<thead>
														<tr>
															<th>ID</th>
															<th>명칭</th>
															<th>위도</th>
															<th>경도</th>
															<th>모델명</th>
														</tr>
													  </thead>
													<tbody id="ess-list">
													

														<tr>
														<!-- 	<td><input type="text" class="form-control" value="0123"></td>
															<td><input type="text" class="form-control" value="203동"></td> -->
															<td colspan="5"><button type="submit" class="btn btn-outline-success ml-2" style="vertical-align: top"  onclick="addDevice('ess')">+ ESS 추가</button></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</td>
								</tr>
								</tbody>
							</table>
						</div>
						<div class="col-md-12 text-right mb-2 mt-3"><button type="button" class="btn btn-primary mr-2" onclick="doSubmit();">저장</button><a href="/admin/site/list"><button type="button" class="btn btn-primary" >취소</button></a></div>
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

	function selectDeviceType(obj) {
		
		var deviceType = $(obj).val();
		
		if (deviceType == 'inverter') {
			$("#tr_capacity").show();
			$("#tr_pcs_capacity").hide();
			$("#tr_batt_capacity").hide();
			$("#tr_batt_type").hide();
			
			
		} else if (deviceType == 'tracker' || deviceType == 'sensorstation') {
			
			$("#tr_capacity").hide();
			$("#tr_pcs_capacity").hide();
			$("#tr_batt_capacity").hide();
			$("#tr_batt_type").hide();
			
		} else if (deviceType == 'ess') {
			
			$("#tr_capacity").hide();
			$("#tr_pcs_capacity").show();
			$("#tr_batt_capacity").show();
			$("#tr_batt_type").show();
			
		}
		
		
	}

	
	function doSubmit() {
	
		var deviceType = $("#devicetype").val();
		
		if( $("#sid").val() == '') {
			$("#sid").focus();
			alert("발전소 ID를 입력해 주세요.");
			return;
		}
		
		/* if (!sidValidation) {
			alert("발전소ID 중복확인을 해주세요.");
			return;
		} */
		
		if( $("#name").val() == '') {
			$("#name").focus();
			alert("발전소명을 입력해 주세요.");
			return;
		}
		
		/* if (!nameValidation){
			alert("발전소명 중복확인을 해주세요.");
			return;
		} */
		
		if( $("#address").val() == '') {
			alert("주소를 입력해 주세요.");
			return;
		}
		
		if( $("#build_date").val() == '') {
			$("#build_date").focus();
			alert("설치일자를 입력해 주세요.");
			return;
		}
		
		if( $("#latitude").val() == '') {
			$("#latitude").focus();
			alert("위도를 입력해 주세요.");
			return;
		}
		
		if( $("#longitude").val() == '' ) {
			$("#longitude").focus();
			alert("경도를 입력해 주세요.");
			return;
		}
		
		
		var inverter = getDeviceArrayFromHtml('inverter');
		var ess = getDeviceArrayFromHtml('ess');
		var sensorstation = getDeviceArrayFromHtml('sensorstation');
		var tracker = getDeviceArrayFromHtml('tracker');
		
		

		
	
		var data = {
				"sid" 		: $("#sid").val(),
				"name"		: $("#name").val(),
				"address"	: $("#address").val(),
				"address2"	: $("#address2").val(),
				"builder"	: $("#builder").val(),
				"owner"		: $("#owner").val(),
				"tel"		: $("#tel").val(),
				"latitude"  : $("#latitude").val(),
				"longitude" : $("#longitude").val(),
				"picture_url" : $("#file").val(),
				"memo"		: $("#memo").val(),
				"build_date" : $("#build_date").val(),
				"device": {
					"inverter" : inverter,
					"ess" : ess,
					"sensorstation": sensorstation,
					"tracker": tracker
				}
		}

		console.log( JSON.stringify(data ));
	
		
		var settings = {
				  "async": true,
				  "crossDomain": true,
				  "url": "<%=API_HOST%>/api/sites/"+$("#sid").val(),
				  "method": "PUT",
				  "headers": {
				    "authorization": "<%=authorization%>",
				    "content-type": "application/json;charset=UTF-8",
				    "cache-control": "no-cache",
				  },
				  "data": JSON.stringify(data)
				}

				$.ajax(settings).done(function (response) {
				  console.log(response);
				  
				  alert("사이트가 저장 되었습니다.");
				  sidValidation = false;
				  nameValidation = false;
				  
				}).fail(function(err){
					alert('사이트 등록이 실패하였습니다.' + err);
				});
		
//발전소 이미지 등록
		
		if ($("#file").val() ){
			
			console.log("put site image.");
		
			var form = new FormData();
			
			var file = document.getElementById("file");
			
			form.append('img', file.files[0]);
	
			var settings = {
			  "async": true,
			  "crossDomain": true,
			  "url": "<%=API_HOST%>/api/sites/"+$("#sid").val()+"/image",
			  "method": "PUT",
			  "headers": {
			    "authorization": "<%=authorization%>",
			    "cache-control": "no-cache"
			  },
			  "processData": false,
			  "contentType": false,
			  "mimeType": "multipart/form-data",
			  "data": form
			}
	
			$.ajax(settings).done(function (response) {
			  console.log(response);
			});
		
		}
		
		

	}
   
	var deviceArray = null;
	var sidValidation = false;
	var nameValidation = false;
	
   $(document).ready(function(){
	   
	   $.ajax({
			url: '/api/device/list',
			type: 'GET',
			data : { },
			cache: false,
			//  headers:{'Content-Type': 'application/json'},
			success: function (res) {
				console.log("result^^:"+JSON.stringify(res));
				deviceArray = res;
								

				readSiteData();
			
			}


		});
	   
	   
/* 	   "sid" 		: $("#sid").val(),
		"name"		: $("#name").val(),
		"address"	: $("#address").val(),
		"address2"	: $("#address2").val(),
		"builder"	: $("#builder").val(),
		"owner"		: $("#owner").val(),
		"tel"		: $("#tel").val(),
		"picture_url" : $("#file").val(),
		"memo"		: $("#memo").val(),
		"build_date" : $("#build_date").val(),
		"device": {
			"inverter" : inverter,
			"ess" : ess,
			"sensorstation": sensorstation,
			"tracker": tracker
		} */
	   
	   //발전소 데이터 읽기
	 
	   

	});
   
   function readSiteData(){
	   var settings = {
			   "async": true,
			   "crossDomain": true,
			   "url": '<%=API_HOST%>/api/sites/<%=request.getParameter("sid")%>',
			   "method": "GET",
			   "headers": {
			     "authorization": "<%=authorization%>",
			     "cache-control": "no-cache"
			   }
			 }

			 $.ajax(settings).done(function (res) {
				 
				 console.log( "read Site Data : ");
				 console.log( res);
				 
			  	$("#sid").val(res.sid);
			  	$("#name").val(res.name);
			  	$("#address").val(res.address);
			  	$("#address2").val(res.address2);
			  	$("#builder").val(res.builder);
			  	$("#owner").val(res.owner);
			  	$("#tel").val(res.tel);
			  	$("#memo").text(res.memo);
			  	$("#build_date").val(res.build_date.split(" ")[0]);
			  	$("#latitude").val(res.latitude);
			  	$("#longitude").val(res.longitude);
			  	
			  	
			  	if(res.picture_url){
			  		$("#view-picture").show();
			  	}
			  	
			  
			  	
			  	if (res.device && res.device.inverter){
			  		console.log("add inverters");
			  		var inverters = res.device.inverter;
			  		
			  		console.log("inverter length : " + inverters.length);
			  		
			  		for(i=0; i<inverters.length; i++){
			  			
			  			console.log("add inverter : " + i);
			  			
			  			addDevice('inverter', inverters[i].deviceid, inverters[i].name, inverters[i].model, inverters[i].latitude, inverters[i].longitude);
			  		}
			  	}
				if (res.device && res.device.ess){
					  		
			  		var esses = res.device.ess;
			  		for(i=0; i<esses.length; i++){
			  			addDevice('ess', esses[i].deviceid, esses[i].name, esses[i].model, esses[i].latitude, esses[i].longitude);
			  		}
			  	}
				if (res.device && res.device.sensorstation){
					
					var sensorstations = res.device.sensorstation;
					for(i=0; i<sensorstations.length; i++){
						addDevice('sensorstation', sensorstations[i].deviceid, sensorstations[i].name, sensorstations[i].model, sensorstations[i].latitude, sensorstations[i].longitude);
					}
				}
				if (res.device && res.device.tracker){
					
					var trackers = res.device.tracker;
					for(i=0; i<trackers.length; i++){
						addDevice('tracker', trackers[i].deviceid, trackers[i].name, trackers[i].model, trackers[i].latitude, trackers[i].longitude);
					}
				}
				
			  	
				 
			 });
   }
   
   function addDevice(type,deviceid, name, model, latitude, longitude) {	   
	   $("#"+type+"-list").prepend(createNewDeviceHtml(type, deviceid, name, model, latitude, longitude) );
	   
	   console.log("addDevice:" + name);
   }
   
   function deleteDevice(obj) {
	   
	   $(obj).parent().parent().remove();
   }
   
   function createNewDeviceHtml(type,deviceid, name, model, latitude, longitude){
	   var _deviceid ="";
	   var _name="";
	   var _model="";
	   var _latitude ="";
	   var _longitude = "";
	   
	   if (deviceid) _deviceid = deviceid;
	   if (name) _name = name;
	   if (model) _model = model;
	   if (latitude) _latitude = latitude;
	   if (longitude) _longitude = longitude;
	   
	   	var newDeviceHtml = '<tr>';

	   	newDeviceHtml += '<td><input type="text" class="form-control" value="'+_deviceid+'" name="deviceid" onblur="checkDivcieIdDuplication(this,\''+type+'\')" ></td>';
		newDeviceHtml += '<td><input type="text" class="form-control" value="'+_name+'" name="deviceName"></td>';
		newDeviceHtml += '<td><input type="text" class="form-control" value="'+_latitude+'" name="latitude"></td>';
		newDeviceHtml += '<td><input type="text" class="form-control" value="'+_longitude+'" name="longitude"></td>';
		newDeviceHtml += '<td>';
		
		newDeviceHtml += createDeviceSelect(type,_model);
		
		newDeviceHtml += '<button type="button" class="btn btn-danger ml-2" style="vertical-align: top" onclick="deleteDevice(this)">- 삭제</button>';
		newDeviceHtml += '</td>';
		newDeviceHtml += '</tr>';
		
		return newDeviceHtml;
   }
   

   function createDeviceSelect(type, value) {
	   
	   //console.log("deviceArray:"+JSON.stringify(deviceArray));
	   
	   var deviceSelect = "<select style='form-control' name='model'>";
	   
		for (j=0; j<deviceArray.length; j++) {
			
			var deviceType = deviceArray[j].devicetype;
			
			console.log("deviceType : " + deviceType);
			
			if ( deviceType == type){
				
				var selected = deviceArray[j].model==value?'selected':'';
				
				var option = '<option ' + selected  + '>';
				option += deviceArray[j].manufacturer + ' ' + deviceArray[j].model;
				option += '</option>';
				
				deviceSelect += option;
			}
			
		}
		
		deviceSelect += "</select>";
		
		console.log("deviceSelect : " + deviceSelect);
		
		return deviceSelect;
		
   }
   
   
   function getDeviceArrayFromHtml(type){
	   var devices = [];
	   
	   console.log("getDeviceArrayFromHtml : " + type);
	   
	   $("#"+type+"-list").find("tr").each(function(){
		   
		   console.log("aaaa" +  $(this).find("input[name=deviceid]").length);
		   
		   var deviceid = $(this).find("input[name=deviceid]").val();
		   var name = $(this).find("input[name=deviceName]").val();
		   var latitude = $(this).find("input[name=latitude]").val();
		   var longitude = $(this).find("input[name=longitude]").val();
		   var selectVal = $(this).find("select[name=model]").children("option:selected").text();
		  
		   
		   console.log("selectVal:" + selectVal);
		   
		   var manufacturer = selectVal.split(' ')[0];
		   var model = selectVal.split(' ')[1];
		   
		   if (deviceid){
			   var device = {
				   "deviceid":deviceid,
				   "name":name,
				   "latitude":latitude,
				   "longitude":longitude,
				   "manufacturer": manufacturer,
				   "model":model
				   
			   };
			   
			   devices.push(device);
		   }
		   
		   console.log("deviceid:" + deviceid );
	   });
	   
	   
	   return devices;
   }
   
   function checkDivcieIdDuplication(obj, type) {
	   
	   var deviceId = $(obj).val();
	   
	   var dupCount = 0;
	   
 		$("#"+type+"-list").find("tr").each(function(){
		   
		   var id = $(this).find("input[name=deviceid]").val();
		
		   if (id == deviceId) {
			   dupCount++;
		   }
		   
		 
	   });
 		
 		if (dupCount > 1) {
 			alert("장치 ID가 중복되었습니다. 확인해 주세요.");
 			
 			$(obj).val('');
 			
 			$(obj).focus();
 		}
   }
   
   function validateId() {
	   
	   var sid = $("#sid").val();
	   
	   var settings = {
			   "async": true,
			   "crossDomain": true,
			   "url": "<%=API_HOST%>/api/sites/" + sid,
			   "method": "GET",
			   "headers": {
			     "authorization": "<%=authorization%>",
			     "cache-control": "no-cache",
			     "content-type": "application/json;charset=utf-8"
			   }
			 }

			 $.ajax(settings).done(function (response) {
			   console.log(response);
			   
			   if (!response) {
				   sidValidation = true;
				   $("#sid-validate-txt").text("사용 가능한 ID입니다.");
				   $("#sid-validate-txt").show();
			   } else {
				   sidValidation = false;
				   
				   $("#sid-validate-txt").text("ID가 중복 되었습니다.");
				   $("#sid-validate-txt").show();
				   
			   }
			   
			 });
	   
	  
	   
   }
   
   function viewPicture(){
	   var settings = {
		   "async": true,
		   "crossDomain": true,
		   "url": "<%=API_HOST%>/api/sites/"+$("#sid").val()+"/image",
		   "method": "GET",
		   "headers": {
		     "authorization": "<%=authorization%>",
		     "cache-control": "no-cache",
		     "postman-token": "a1a47c13-4603-3824-d72a-8dfa44ddfd11"
		   }
		 }

		 $.ajax(settings).done(function (response) {
			 var imgSrc = "<img id='img-view'>";
			  
		   //console.log(response);
		 });
   }
   
   function validateName() {
		
	   var name = $("#name").val();
	   
	   if (name.length < 2) {
		   $("#name-validate-txt").text("2자 이상 입력을 하셔야 합니다.");
		   $("#name-validate-txt").show();
		   
		   return;
	   }
	   
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

			 $.ajax(settings).done(function (response) {
			   console.log(response);
			 
			   if ( response) {
				   
				   var nameIsOk = true;
				   
				   for (i=0; i<response.length; i++) {
					   
					   if ( response[i].name == name) {
						   
						   $("#name-validate-txt").text("중복된 이름입니다.");
						   $("#name-validate-txt").show();
						   
						   nameValidation = false;
						   
						   return;
					   }
					   
				   }
				   
				   $("#name-validate-txt").text("등록이 가능한 이름입니다.");
				   $("#name-validate-txt").show();
				   
				   nameValidation = true;
			   }
			   
			 });
   }
   
   </script>
  </body>
</html>