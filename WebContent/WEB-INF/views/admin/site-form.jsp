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
					<h4>발전소 등록</h4>
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
									<th>발전소 ID<span class="necessary">*</span><br><small style="color:#0000ff;">숫자 1~4자리 입력</small></th>
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="sid" id="sid" onkeydown="onlyInteger(this,4)";><button type="button" class="btn btn-outline-primary btn-sm ml-2" style="vertical-align: top;" onclick="validateId()">중복확인</button>
									<br><br><span class="text-primary " style="display:none" id="sid-validate-txt"></span>
									</td>
									<th>발전소명<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="name" id="name" maxlength="20"><button type="button" class="btn btn-outline-primary btn-sm ml-2" style="vertical-align: top;" onclick="validateName()">중복확인</button>
									<br><br><span class="text-primary " style="display:none" id="name-validate-txt"></span>
									</td>
								</tr>
								<tr>
									<th>주소<span class="necessary">*</span><br><br><br>상세주소</th>
									<td colspan="3">
										<p><input type="text" class="form-control" style="width: 50%;" name="address" id="address" value="" maxlength="128" readonly="readonly"><button type="button" class="btn btn-outline-primary btn-sm ml-2" style="vertical-align: top;"  onclick="openPost();" >주소검색</button></p>
										<p style="margin-bottom: 0"><input type="text" class="form-control" style="width: 80%;" name="address2" id="address2" value="" maxlength="128"></p>
									</td>
								</tr>
								<tr>
									<th>위도<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" style="width: 50%;" value="0" maxlength="10" name="latitude" id="latitude" onkeydown="onlyNumberLimit(this,10)"></td>
									<th>경도<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" style="width: 50%;" value="0" maxlength="11" name="longitude" id="longitude" onkeydown="onlyNumberLimit(this,11)"></td>
								</tr>
								<tr>
									<th>시공사</th>
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="builder" id="builder" maxlength="20"></td>
									<th>담당자<br><small style="color:#0000ff;">빈칸 또는 한글 2자 ~ 20자 입력</small></th> 
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="owner" id="owner" maxlength="20"></td>
								</tr>
								<tr>
									<th>발전소 담당자 연락처(ID)<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="tel" id="tel" maxLength="13" onkeydown="onlyPhone(this)" placeholder="000-000(0)-0000"></td>
									<th>설치일자<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="build_date" id="build_date" onkeydown="onlyDate(this)" placeholder="YYYY-MM-DD" maxlength="10"></td>
								</tr>
								<tr>
									<th>트랙커 네트워크 공인 IP</th>
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="tracker_ip" id="tracker_ip" onkeydown="" placeholder="x.x.x.x" maxlength="15"></td>
									<th>트랙커 네트워크 Port<br><small style="color:#0000ff;">빈칸 또는 0 ~ 65535 범위 값 입력</small></th>
									<td><input type="text" class="form-control" style="width: 50%;" value="" name="tracker_port" id="tracker_port" onkeydown="onlyInteger(this,5)" maxlength="5"></td>
								</tr>
								<tr>
									<th>메모</th>
									<td colspan="3"><textarea class="form-control" rows="5" name="memo" id="memo" maxlength="100"></textarea></td>
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
												<a class="nav-link" id="plant02-tab" data-toggle="tab" href="#plant02" role="tab" aria-controls="plant02" aria-selected="false">트랙커</a>
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
														<td colspan="5"><button type="button" class="btn btn-outline-success ml-2" style="vertical-align: top"  onclick="addDevice('tracker')">+ 트랙커 추가</button></td>
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
														<col width="15%">
														<col width="10%">
														<col width="10%">
														<col width="15%">
														<col width="10%">
														<col width="*">
													</colgroup>
													<thead>
														<tr>
															<th>ID</th>
															<th>명칭</th>
															<th>위도</th>
															<th>경도</th>
															<th>IP</th>
															<th>Port</th>
															<th>모델명</th>
														</tr>
													  </thead>
													<tbody id="ess-list">
													<tr>
													<td><input type="text" class="form-control" value="" name="deviceid" maxlength="3" onblur="checkDivcieIdDuplication(this,\''+type+'\')" onkeydown="onlyNumberLimit(this,3)"></td>
													<td><input type="text" class="form-control" value="" name="deviceName" maxlength="10"></td>
													<td><input type="text" class="form-control" value="" name="latitude" maxlength="10" onkeydown="onlyNumberLimit(this,10)"></td> 
													<td><input type="text" class="form-control" value="" name="longitude" maxlength="11" onkeydown="onlyNumberLimit(this,11)"></td>
													<td><input type="text" class="form-control" value="" id="ess_ip" name="ip" maxlength="15" onkeydown=""></td>
													<td><input type="text" class="form-control" value="" name="port" onkeydown="onlyNumberLimit(this,5)"></td>
													<td id="ess-type"></td>
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
						<div class="col-md-12 text-right mb-2 mt-3"><button type="button" class="btn btn-primary mr-2" onclick="doSubmit();">등록</button><a href="/admin/site/list"><button type="button" class="btn btn-primary" >취소</button></a></div>
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
		var telPattern = "^([0-9]{3})-([0-9]{3,4})-([0-9]{4})$";
		var ownerPattern = "^([가-힣]{2,20})$";
		var deviceType = $("#devicetype").val();
		var datePattern = "^20([0-9]{2})-(([0][1-9])|([1][0-2]))-(([0][1-9])|([1][0-9])|([2][0-9])|([3][0-1]))$";
		var ipPattern = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$";
		var bDate;
		
		if( $("#sid").val() == '') {
			$("#sid").focus();
			alert("발전소 ID를 입력해 주세요.");
			return;
		}
		
		if (!sidValidation) {
			alert("발전소ID 중복확인을 해주세요.");
			return;
		}
		
		if( $("#name").val() == '') {
			$("#name").focus();
			alert("발전소명을 입력해 주세요.");
			return;
		}
		
		if (!nameValidation){
			alert("발전소명 중복 확인을 해주세요.");
			return;
		}
		
		if( $("#address").val() == '') {
			alert("주소를 입력해 주세요.");
			return;
		}
		
		if((bDate = new Date($("#build_date").val())) != "Invalid Date" && $("#build_date").val().match(datePattern)) {
			if(bDate.setHours(0) < new Date("2000-01-01").setHours(0) || bDate.setHours(0) >= new Date()) {
				$("#build_date").focus();
				alert("설치 일자는 2000년부터 현재 사이의 날짜를 입력해주세요.");
				return;
			}
		}
		else {
			alert("설치 일자가 잘못된 형식으로 입력되었습니다.");
			return;
		}
		
		if( $("#build_date").val() == '') {
			$("#build_date").focus();
			alert("설치 일자를 입력해 주세요.");
			return;
		}
		
		if( $("#latitude").val() == '') {
			$("#latitude").focus();
			alert("위도를 입력해 주세요.");
			return;
		}
		
		if(Number($("#latitude")) != NaN && ($("#longitude").val() > 90 || $("#longitude").val() < -90)) {
			$("#longitude").focus();
			alert("경도 값을 범위에 맞게 입력해 주세요.");
			return;
		}
		
		if( $("#longitude").val() == '') {
			$("#longitude").focus();
			alert("경도를 입력해 주세요.");
			return;
		}
		
		if(Number($("#longitude")) != NaN && ( $("#longitude").val() > 180 || $("#longitude").val() < -180)) {
			$("#longitude").focus();
			alert("경도 값을 범위에 맞게 입력해 주세요.");
			return;
		}
		
		if( !($("#owner").val().length == 0 || $("#owner").val().match(ownerPattern) ) ) {
			$("#owner").focus();
			alert("담당자를 빈칸 또는 양식에 맞게 입력해 주세요.");
			return;
		}
		
		if( $("#tel").val() == '') {
			$("#tel").focus();
			alert("발전소 담당자 연락처(ID)를 입력해 주세요.");
			return;
		}
		
		if( !$("#tel").val().match(telPattern)) {
			$("#tel").focus();
			alert("발전소 담당자 연락처(ID)를 양식에 맞게 입력해 주세요.");
			return;
		}
		
		if( !($("#tracker_ip").val().length == 0 || $("#tracker_ip").val().match(ipPattern)) ) {
			$("#tracker_ip").focus();
			alert("트랙커 네트워크 공인 IP를 빈칸 또는 양식에 맞게 입력해 주세요.");
			return;
		}
		
		if( !($("#ess_ip").val().length == 0 || $("#ess_ip").val().match(ipPattern)) ) {
			$("#ess_ip").focus();
			alert("ESS IP를  빈칸 또는 양식에 맞게 입력해 주세요.");
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
				"memo"		: $("#memo").val(),
				"build_date" : $("#build_date").val(),
				"tracker_ip" : $("#tracker_ip").val(),
				"tracker_port" : $("#tracker_port").val(),
				"device": {
					"inverter" : inverter,
					"ess" : ess,
					"sensorstation": sensorstation,
					"tracker": tracker
				}
		}

		console.log( data );
	
		
		var settings = {
				  "async": true,
				  "crossDomain": true,
				  "url": "/admin/site/add",
				  "method": "POST",
				  "headers": {
				    "authorization": "<%=authorization%>",
				    "content-type": "application/json;charset=UTF-8",
				    "cache-control": "no-cache",
				  },
				  "data": JSON.stringify(data)
				}

				$.ajax(settings).done(function (response) {
				  console.log(response);
				  
				  alert("사이트가 등록되었습니다.");
				  
				  sidValidation = false;
				  nameValidation = false;
				  
				  document.location.href = "/admin/site/list";
				  
				}).fail(function(err){
					console.log(err);
					alert('사이트 등록이 실패하였습니다.' );
				});
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
				console.log("result:"+JSON.stringify(res));
				deviceArray = res;
				
				 $("#ess-type").html(createDeviceSelect('ess',''));
			}


		});

	});
   
   function addDevice(type) {
	   $("#"+type+"-list").prepend(createNewDeviceHtml(type) );
   }
   
   function deleteDevice(obj) {
	   
	   $(obj).parent().parent().remove();
   }
   
   function createNewDeviceHtml(type){	   
	   	var newDeviceHtml = '<tr>';

	   	newDeviceHtml += '<td><input type="text" class="form-control" value="" name="deviceid" maxlength="3" onblur="checkDivcieIdDuplication(this,\''+type+'\')" onkeydown="onlyNumberLimit(this,3)"></td>';
		newDeviceHtml += '<td><input type="text" class="form-control" value="" name="deviceName" maxlength="10"></td>';
		newDeviceHtml += '<td><input type="text" class="form-control" value="" name="latitude" onkeydown="onlyFixedLimit(this,3,8)"></td>';
		newDeviceHtml += '<td><input type="text" class="form-control" value="" name="longitude" onkeydown="onlyFixedLimit(this,3,8)"></td>';
		if(type == 'ess') {
			newDeviceHtml += '<td><input type="text" class="form-control" value="" name="ip" onkeydown=""></td>';
			newDeviceHtml += '<td><input type="text" class="form-control" value="" name="port" onkeydown="onlyNumberLimit(this,5)"></td>';
		}
		
		
		newDeviceHtml += '<td>';
		
		newDeviceHtml += createDeviceSelect(type,'');
		
		newDeviceHtml += '<button type="button" class="btn btn-danger ml-2" style="vertical-align: top" onclick="deleteDevice(this)">- 삭제</button>';
		newDeviceHtml += '</td>';
		newDeviceHtml += '</tr>';
		
		return newDeviceHtml;
   }
   

   function createDeviceSelect(type, value) {
	   
	   console.log("deviceArray:"+JSON.stringify(deviceArray));
	   
	   var deviceSelect = "<select style='form-control' name='model'>";
	   
		for (i=0; i<deviceArray.length; i++) {
			
			var deviceType = deviceArray[i].devicetype;
			
			console.log("deviceType : " + deviceType);
			
			if ( deviceType == type){
				
				var selected = deviceArray[i].model==value?'selected':'';
				
				var option = '<option ' + selected  + '>';
				option += deviceArray[i].manufacturer + ' ' + deviceArray[i].model;
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
			   var device;
			   
			   if(type == 'ess') {
				   var ip = $(this).find("input[name=ip]").val();
				   var port = $(this).find("input[name=port]").val();
				   
				   device = {
					   "deviceid":deviceid,
					   "name":name,
					   "latitude":latitude,
					   "longitude":longitude,
					   "manufacturer": manufacturer,
					   "model":model,
					   "ip":ip,
					   "port":port,
				   };
			   }
			   else
			   device = {
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
		
		   if (id == deviceId && id != '') {
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
	   var sidPattern = "^([0-9]{1,4})$";
	   
	   var sid = $("#sid").val();
	   
	   if(sid.length > 0 && !sid.match(sidPattern)) {
		   sidValidation = false;
		   $("#sid-validate-txt").text("유효하지 않은 값입니다."); 
		   $("#sid-validate-txt").show();
	   }
	   
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
		   } else if(sid === "") {
			   sidValidation = false;
			   $("#sid-validate-txt").text("숫자로 ID를 입력하세요.");
			   $("#sid-validate-txt").show();
		   } else {
			   sidValidation = false;
			   
			   $("#sid-validate-txt").text("ID가 중복 되었습니다.");
			   $("#sid-validate-txt").show();
			   
		   }
		   
		 });
	   
	  
	   
   }
   
   function validateName() {
		var namePattern = "^([가-힣0-9A-Za-z]{2,20})$";
	   var name = $("#name").val();
	   
	   if (!name.match(namePattern)) {
		   $("#name-validate-txt").text("한글,영문,숫자를 조합하여 2자 이상, 20자 이내로 입력해 주세요.");
		   $("#name-validate-txt").show(); 
		   
		   return;
	   }
	   
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