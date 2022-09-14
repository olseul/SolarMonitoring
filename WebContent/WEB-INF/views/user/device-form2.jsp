<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./header.jsp" %>
<%@ include file="./LNB.jsp" %>
    <%
    String msg = request.getParameter("msg");
    String model = request.getParameter("model");
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
										<select class="form-control" style="width: 50%;" name="devicetype" id="devicetype" onchange="selectDeviceType(this)">
										 <option value="inverter">인버터</option>
										 <option value="tracker">트랙커</option>
										 <option value="sensorstation">센서스테이션</option>
										  <option value="ess">ESS</option>
									    </select>
									</td>
								</tr>
								<tr>
									<th>모델명<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" style="width: 50%;" name="model" id="model" value=""></td>
								</tr>
								<tr>
									<th>제조사<span class="necessary">*</span></th>
									<td><input type="text" class="form-control" style="width: 50%;" name="manufacturer" id="manufacturer" value="" readonly></td>
								</tr>
								<tr id="tr_capacity">
									<th>용량<span class="necessary">*</span></th>
									<td><input type="text" class="form-control text-right" style="width: 30%;"  name="capacity" id="capacity"  value=""><span class="ml-2">kW</span></td>
								</tr>
								<tr id="tr_pcs_capacity" style="display:none;">
									<th>PCS 용량<span class="necessary">*</span></th>
									<td><input type="text" class="form-control text-right" style="width: 30%;"  name="pcs_capacity" id="pcs_capacity"  value=""><span class="ml-2">kW</span></td>
								</tr>
								<tr id="tr_batt_capacity" style="display:none;">
									<th>BATT 용량<span class="necessary">*</span></th>
									<td><input type="text" class="form-control text-right" style="width: 30%;"  name="batt_capacity" id="batt_capacity"  value=""><span class="ml-2">kW</span></td>
								</tr>
								<tr id="tr_batt_type" style="display:none;">
									<th>BATT 타입<span class="necessary">*</span></th>
									<td><input type="text" class="form-control text-right" style="width: 30%;"  name="batt_type" id="batt_type"  value=""></td>
								</tr>
								<tr>
									<th>A/S 담당자</th>
									<td><input type="text" class="form-control" style="width: 50%;" name="manager" id="manager"  value=""></td>
								</tr>
								<tr>
									<th>A/S 연락처</th>
									<td><input type="text" class="form-control" style="width: 50%;"  name="manager_tel" id="manager_tel"  value=""></td>
								</tr>
								<tr>
									<th>메모</th>
									<td><textarea class="form-control" rows="5"  name="memo" id="memo" ></textarea></td>
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
		
		if( $("#model").val() == '') {
			$("#model").focus();
			return;
		}
		if( $("#manufacturer").val() == '') {
			$("#manufacturer").focus();
			return;
		}
		
		
		if (deviceType == 'inverter') {
			
			if ($("#capacity").val() == '') {
				$("#capacity").focus();
				return;
			}
			
			
		} else if (deviceType == 'tracker' || deviceType == 'sensorstation') {
			

		} else if (deviceType == 'ess') {
			
			if ($("#pcs_capacity").val() == '') {
				$("#pcs_capacity").focus();
				return;
			}
			
			if ($("#batt_capacity").val() == '') {
				$("#batt_capacity").focus();
				return;
			}
			
			if ($("#batt_type").val() == '') {
				$("#batt_type").focus();
				return;
			}

		}
		
		
		
		var params = $("#deviceForm").serialize();
		params += "&devicetype=" + $("#devicetype").val();
		params += "&model="+$("#model").val();
		
		console.log("params:" + params);
		
		$.ajax({
			url: '/api/device/update',
			type: 'POST',
			data : params,
			cache: false,
			//  headers:{'Content-Type': 'application/json'},
			success: function (res) {
				console.log("result:"+res);

				if (res == 10) {
					document.location.href="/admin/login";
				} else 	if (res == 200 || res==201) {
					alert("장치 정보가 업데이트 되었습니다.");
				} else {
					alert("장치 정보를 업데이트하는데 문제가 발생하였습니다.");
				}

			}


		});
   
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