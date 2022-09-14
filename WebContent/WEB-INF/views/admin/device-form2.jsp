<%@page import="com.nhncorp.lucy.security.xss.XssPreventer"%>
<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./header.jsp" %>
<%@ include file="./LNB.jsp" %>
    <%
    String msg = XssPreventer.escape(request.getParameter("msg"));
    String model = XssPreventer.escape(request.getParameter("model"));
    %>

     
    <div class="main-panel">
          <div class="content-wrapper">
            <!-- Page Title Header Starts-->
            <div class="row page-title-header">
              <div class="col-12">
                <div class="page-header">
                  <h4 class="page-title">HOME | 관리 | 장치 관리</h4>
                </div>
              </div>
            </div>
            <!-- Page Title Header Ends-->
            <div class="row">
				<div class="w-box">
					<h4>장치 편집</h4>
					<div class="row"><!-- cont01 -->
					  <div class="table-area col-md-12">
					  		<form id="deviceForm" method="post">
							<table class="table v3">
								<colgroup>
									<col width="30%">
									<col width="*">
								</colgroup>
								<tbody>
								<tr>
									<th>장치 타입<span class="necessary">*</span></th>
									<td>
										<select class="form-control" style="width: 50%;" name="devicetype" id="devicetype">
										 <option value="inverter">인버터</option>
										 <option value="tracker">트랙커</option>
										  <option value="ess">ESS</option>
									    </select>
									</td>
								</tr>
								<tr>
									<th>모델명<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" style="width: 50%;" name="model" id="model" value="" readonly disabled></td>
								</tr>
								<tr>
									<th>제조사<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" style="width: 50%;" name="manufacturer" id="manufacturer" value="" readonly disabled></td>
								</tr>
								<tr id="tr_capacity">
									<th>용량<span class="necessary">*</span><br><small style="color:#0000ff;">0 초과 ~ 10,000 미만 범위 내에서 입력</small></th>
									<td><input type="text" class="form-control text-right" style="width: 30%;"  name="capacity" id="capacity"  onkeydown="onlyFixedLimit(this,4,1)" value="" maxlength="4"><span class="ml-2">kW</span></td>
								</tr>
								<tr id="tr_pcs_capacity" style="display:none;">
									<th>PCS 용량<span class="necessary">*</span><br><small style="color:#0000ff;">0 초과 ~ 10,000 미만 범위 내에서 입력</small></th>
									<td><input type="text" class="form-control text-right" style="width: 30%;"  name="pcs_capacity" id="pcs_capacity" onkeydown="onlyInteger(this,4)" value=""><span class="ml-2" maxlength="4">kW</span></td>
								</tr>
								<tr id="tr_batt_capacity" style="display:none;">
									<th>BATT 용량<span class="necessary">*</span><br><small style="color:#0000ff;">0 초과 ~ 10,000 미만 범위 내에서 입력</small></th>
									<td><input type="text" class="form-control text-right" style="width: 30%;"  name="batt_capacity" id="batt_capacity"  onkeydown="onlyFixedLimit(this,4,2)" value=""><span class="ml-2" maxlength="4">kW</span></td>
								</tr>
								<tr id="tr_batt_type" style="display:none;">
									<th>BATT 타입<span class="necessary">*</span></th>
									<td><input type="text" class="form-control text-right" style="width: 30%;"  name="batt_type" id="batt_type"  value="" maxlength="20"></td>
								</tr>
								<tr>
									<th>A/S 담당자<br><small style="color:#0000ff;">공란 또는 한글 2자 ~ 20자 입력</small></th>
									<td><input type="text" class="form-control" style="width: 50%;" name="manager" id="manager"  value="" maxlength="10"></td>
								</tr>
								<tr>
									<th>A/S 연락처</th>
									<td><input type="text" class="form-control" style="width: 50%;"  name="manager_tel" id="manager_tel" value="" onkeydown="onlyPhone(this)" maxlength="13" placeholder="000-000(0)-0000"></td>
								</tr>
								<tr>
									<th>메모</th>
									<td><textarea class="form-control" rows="5"  name="memo" id="memo" maxlength="100"></textarea></td>
								</tr>
								</tbody>
							</table>
							</form>
						</div>
						<div class="col-md-12 text-right mb-2 mt-3"><button type="button" onclick="doSubmit();" class="btn btn-primary mr-2">저장</button><button type="button" onclick="goList()"; class="btn btn-primary">취소</button></div>
					</div>
				</div>
			</div>
          </div>
          
<script>

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
		var modelPattern = "^([0-9A-Za-z-_]{2,20})$";
		var manufacturerPattern = "^([0-9A-Za-z-_]{2,20})$";
		var telPattern = "^([0-9]{3})-([0-9]{3,4})-([0-9]{4})$";
		var managerPattern = "^([가-힣]{2,20})$";
		
		if( $("#model").val() == '') {
			$("#model").focus();
			alert("모델명을 입력해 주세요.");
			return;
		}
		
		if( $("#manufacturer").val() == '') {
			$("#manufacturer").focus();
			alert("제조사를 입력해 주세요.");
			return;
		}
		
		if( !($("#manager").val().length == 0 || $("#manager").val().match(managerPattern))) {
			$("#manager").focus();
			alert("A/S 담당자를 빈칸 또는 양식에 맞게 입력해 주세요.");
			return;
		}
		if( !($("#manager_tel").val().length == 0 || $("#manager_tel").val().match(telPattern))) {
			$("#manager_tel").focus();
			alert("A/S 담당자 연락처를 빈칸 또는 양식에 맞게 입력해 주세요.");
			return;
		}
		
		if (deviceType == 'inverter') {
			if ($("#capacity").val() <= 0) {
				$("#capacity").focus();
				alert("인버터 용량은 0보다 큰 값을 입력해야 합니다.");
				return;
			}
			
			if ($("#capacity").val() == '') {
				$("#capacity").focus();
				alert("인버터 용량을 입력해 주세요.");
				return;
			}
			
			
		} else if (deviceType == 'tracker' || deviceType == 'sensorstation') {
			

		} else if (deviceType == 'ess') {
			
			if ($("#pcs_capacity").val() <= 0) {
				$("#pcs_capacity").focus();
				alert("PCS 용량은 0보다 큰 값을 입력해야 합니다.");
				return;
			}
			
			if ($("#batt_capacity").val() <= 0) {
				$("#batt_capacity").focus();
				alert("BATT 용량은 0보다 큰 값을 입력해야 합니다.");
				return;
			}
			
			if ($("#pcs_capacity").val() == '') {
				$("#pcs_capacity").focus();
				alert("PCS 용량을 입력해 주세요.");
				return;
			}
			
			if ($("#batt_capacity").val() == '') {
				$("#batt_capacity").focus();
				alert("BATT 용량을 입력해 주세요.");
				return;
			}
			
			if ($("#batt_type").val() == '') {
				$("#batt_type").focus();
				alert("BATT 타입을 입력해 주세요.");
				return;
			}

		}
		
		
		
		var params = {}; 
		
		$("#deviceForm").serializeArray().forEach(function(v) { params[v.name] = v.value; });
		params["model"] = $("#model").val();
		params["devicetype"] = $("#devicetype").val();
		params["manufacturer"] = $("#manufacturer").val();
		
		//$("#deviceForm").serialize();
		
		console.log("params:" + params);
		
		var settings = {
				  "async": true,
				  "crossDomain": true,
				  "url": "/admin/devices/update",
				  "method": "PUT",
				  "headers": {
				    "authorization": "<%=authorization%>",
				    "content-type": "application/json;charset=utf-8",
				    "cache-control": "no-cache",
				    "postman-token": "e36c61c4-58c1-ce20-dea9-1d3a08895299"
				  },
				  "data":JSON.stringify(params)
				}
		
		$.ajax(settings).done(function (response) {
			alert("장치 정보가 업데이트 되었습니다.");
		  document.location.href = "/admin/device/list";
		}).fail(function(err) {
			alert('장치 정보 업데이트에 실패하였습니다.' );
		});
		
		/* $.ajax({
			url: '/admin/device/update',
			method: 'PUT',
			async: true,
			crossDomain: true,
			data : { "a" : "b" },  
			cache: false,
			  headers:{"Content-Type" : "application/json;charset=UTF-8",
				  		"cache-control": "no-cache"},
			success: function (res) {
				console.log("result:"+res);

				if (res == 10) {
					document.location.href="/admin/login";
				} else 	if (res == 200 || res==201) {
					alert("장치 정보가 업데이트 되었습니다.");
					document.location.href = "/admin/device/list";
				} else {
					alert("장치 정보 업데이트에 실패하였습니다.");
				}

			}, error : function(res) {
				console.log("result : " + res);
			}


		}); */
   
	}
	
	function goList(){
		document.location.href="/admin/device/list?devicetype=" + $("#devicetype").val();
	}
   
   $(document).ready(function(){
	   $.ajax({
			url: '/api/device/list',
			type: 'GET',
			data : { },
			cache: false,
			//  headers:{'Content-Type': 'application/json'},
			success: function (res) {
				console.log("result:"+JSON.stringify(res));

				for (i=0; i<res.length; i++) {
					
				
					
					if (res[i].model == '<%=model%>'){
						$("#devicetype").val(res[i].devicetype);
						$("#devicetype").prop("disabled",true);
						$("#model").val(res[i].model);
						$("#model").prop("disabled",true);
						$("#manufacturer").val(res[i].manufacturer);
						
						var deviceType = res[i].devicetype;
						
						if (deviceType == 'inverter') {
							$("#tr_capacity").show();
							$("#tr_pcs_capacity").hide();
							$("#tr_batt_capacity").hide();
							$("#tr_batt_type").hide();
							
							$("#capacity").val(res[i].capacity);
							
							
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
							
							$("#pcs_capacity").val(res[i].pcs_capacity);
							$("#batt_capacity").val(res[i].batt_capacity);
							$("#batt_type").val(res[i].batt_type);
							
						}
						
						$("#manager").val(res[i].manager);
						$("#manager_tel").val(res[i].manager_tel);
						$("#memo").val(res[i].memo);
						
					}
					
				}

			}
		});
	});
   
   
   

   </script>
  </body>
</html>