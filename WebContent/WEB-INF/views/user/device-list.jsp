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
                  <h4 class="page-title">HOME | 관리 | 장치 관리</h4>
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
							<div class="col-md-4">
								<div class="form-group row">
									<label class="col-sm-3 col-form-label">장치종류</label>
									<div class="col-sm-9">
									  <select class="form-control" style="width: 50%;" name="devicetype" id="devicetype" onchange="selectDeviceType(this)">
										 <option value="inverter" <%=devicetype.equals("inverter")?"selected":"" %>>인버터</option>
										 <option value="tracker" <%=devicetype.equals("tracker")?"selected":"" %>>트랙커</option>
										 <option value="sensorstation" <%=devicetype.equals("sensorstation")?"selected":"" %>>센서스테이션</option>
										  <option value="ess" <%=devicetype.equals("ess")?"selected":"" %>>ESS</option>
									    </select>
									</div>
								</div>
							</div>
							<div class="col-md-8 text-right">
							  <button type="button" onclick="searchDevice();" class="btn btn-success mr-2"><i class="fas fa-search"></i>검색</button>  
							</div>  
						  </div>
						</div>	
					  </div>
					</div>
					<div class="row"><!-- cont02 -->
						<div class="table-area col-md-12">
							<table class="table v2" id="table-inverter">
							  <colgroup>
								<col width="5%">
								<col width="10%">
								<col width="15%">
								<col width="15%">
								<col width="10%">
								<col width="10%">
								<col width="*">
							  </colgroup>
							  <thead>
								<tr>
								  <th><input type="checkbox" onclick="checkAll(this)"></th>
								  <th>ID</th>
								  <th>모델명</th>
								  <th>용량 (kW)</th>
								  <th>A/S 담당자</th>
								  <th>A/S연락처</th>
								  <th>메모</th>
								</tr>
							  </thead>
							  <tbody id="inverter-list">
							
							  </tbody>
							</table>
							
							<table class="table v2" id="table-tracker" style="display:none;">
							  <colgroup>
								<col width="5%">
								<col width="10%">
								<col width="15%">
								<col width="10%">
								<col width="10%">
								<col width="*">
							  </colgroup>
							  <thead>
								<tr>
								  <th><input type="checkbox"></th>
								  <th>ID</th>
								  <th>모델명</th>
								  <th>A/S 담당자</th>
								  <th>A/S연락처</th>
								  <th>메모</th>
								</tr>
							  </thead>
							  <tbody id="tracker-list">
							  </tbody>
							</table>
							<table class="table v2" id="table-sensorstation" style="display:none;">
							  <colgroup>
								<col width="5%">
								<col width="10%">
								<col width="15%">
								<col width="10%">
								<col width="10%">
								<col width="*">
							  </colgroup>
							  <thead>
								<tr>
								  <th><input type="checkbox"></th>
								  <th>ID</th>
								  <th>모델명</th>
								  <th>A/S 담당자</th>
								  <th>A/S연락처</th>
								  <th>메모</th>
								</tr>
							  </thead>
							  <tbody id="sensorstration-list">
							  </tbody>
							</table>
							
							<table class="table v2" id="table-ess" style="display:none;">
							  <colgroup>
								<col width="5%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="15%">
								<col width="10%">
								<col width="10%">
								<col width="*">
							  </colgroup>
							  <thead>
								<tr>
								  <th><input type="checkbox"></th>
								  <th>ID</th>
								  <th>모델명</th>
								  <th>PCS용량(kW)</th>
								  <th>BATT.용량(kW)</th>
								  <th>BATT.타입</th>
								  <th>A/S 담당자</th>
								  <th>A/S연락처</th>
								  <th>메모</th>
								</tr>
							  </thead>
							  <tbody id="ess-list">
							  </tbody>
							 </table>
							
							<div aria-label="Page navigation" id="navigation">
							  
							</div>
						</div>
						<div class="col-md-12 text-right mb-2"><a href="/admin/device/form"><button type="button"  class="btn btn-primary mr-2">추가</button></a><button type="button" onclick="deleteDevices();" class="btn btn-primary">삭제</button></div>

					</div>
				</div>
			</div>
          </div>
          
          
           <!-- Modal -->
			<div class="modal fade weather-modal" id="infoModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
				  <div class="modal-header">
					<h5 class="modal-title" id="exampleModalLongTitle">안내 메세지</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					  <span aria-hidden="true">&times;</span>
					</button>
				  </div>
				  <div class="modal-body">
					<span id="modal-msg">장치가 등록되어 있는 발전소가 있는 경우</br> 삭제가 불가능합니다.</span>
					<p id="close-msg">5초 뒤에 창이 닫힙니다</p>
				  </div>
				  <div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
				  </div>
				</div>
			  </div>
			</div>	
   
   <script>
   
   $(document).ready(function(){
	   
	   var deviceType = '<%=StringUtil.nvl(devicetype)%>';
	   
	   if (deviceType == '' || deviceType == 'inverter') {
			$("#table-inverter").show();
			$("#table-tracker").hide();
			$("#table-sensorstation").hide();
			$("#table-ess").hide();
			
			
		} else if (deviceType == 'tracker'){
			$("#table-inverter").hide();
			$("#table-tracker").show();
			$("#table-sensorstation").hide();
			$("#table-ess").hide();
			
		} else if( deviceType == 'sensorstation') {
		
			$("#table-inverter").hide();
			$("#table-tracker").hide();
			$("#table-sensorstation").show();
			$("#table-ess").hide();
			
		} else if (deviceType == 'ess') {
			
			$("#table-inverter").hide();
			$("#table-tracker").hide();
			$("#table-sensorstation").hide();
			$("#table-ess").show();
			
		}
		
   
	   readDeviceList('<%=devicetype%>');
	   
	});
   
   function searchDevice() {
	   var deviceType = $("#devicetype").val();
	   
	   readDeviceList(deviceType); 
   }
   
   function selectDeviceType(obj) {
		
		var deviceType = $(obj).val();
		
		if (deviceType == '' || deviceType == 'inverter') {
			$("#table-inverter").show();
			$("#table-tracker").hide();
			$("#table-sensorstation").hide();
			$("#table-ess").hide();
			
			
		} else if (deviceType == 'tracker'){
			$("#table-inverter").hide();
			$("#table-tracker").show();
			$("#table-sensorstation").hide();
			$("#table-ess").hide();
			
		} else if( deviceType == 'sensorstation') {
		
			$("#table-inverter").hide();
			$("#table-tracker").hide();
			$("#table-sensorstation").show();
			$("#table-ess").hide();
			
		} else if (deviceType == 'ess') {
			
			$("#table-inverter").hide();
			$("#table-tracker").hide();
			$("#table-sensorstation").hide();
			$("#table-ess").show();
			
		}
		
		curPage = 1;
		
		 readDeviceList(deviceType);
		
	}


   var curPage = 1;
   var sizePerPage = 10;
   var device_type = '';
   
   function readDeviceList(dType){
	   
	   var deviceDatas = [];
	   var devicetype = dType;
	   
	   if (!devicetype){
		   devicetype = '<%=devicetype%>';
	   }
	   
	   $("#"+devicetype+"-list").html("");
	   
	   $.ajax({
			url: '/api/device/list',
			type: 'GET',
			data : { },
			cache: false,
			//  headers:{'Content-Type': 'application/json'},
			success: function (response) {
				console.log("result:"+JSON.stringify(response));

				for (i=0; i<response.length; i++) {
					
					var deviceType = response[i].devicetype;
					
					console.log("deviceType : " + deviceType);
					
					if ( deviceType == devicetype){
						
						deviceDatas.push(response[i]);
						
						console.log("deviceType2 : " + devicetype);
					}
					
					
				}
				
				var res = deviceDatas;
				device_type = devicetype;
				dataList = res;
				pageSize = res.length;
			    var nextMaxPage = curPage * sizePerPage;
				
				if (nextMaxPage > res.length) nextMaxPage = res.length;
					
				
				for (i=0; i<res.length; i++){

					var device = '';
					
					if (devicetype == '' || devicetype == 'inverter') {
						device = '<tr id="'+res[i].id+'">';
						device += '<td class="text-center"><input type="checkbox" value="'+devicetype+'/'+res[i].manufacturer+'/'+res[i].model+'"></td>';
						device += '<td class="text-center">'+res[i].id+'</td>';
						device += '<td class="text-center"><a href="/admin/device/view?model='+res[i].model+'">'+res[i].model+'</a></td>';
						device += '<td class="text-center">'+res[i].capacity+'</td>';
						device += '<td class="text-center">'+res[i].manager+'</td>';
						device += '<td class="text-left">'+res[i].manager_tel+' </td>';
						device += '<td class="text-center">'+res[i].memo+'</td>';
						device += '</tr>';
						
						if (i>=(curPage-1)*sizePerPage &&  i< nextMaxPage){
							$("#inverter-list").append(device);
						}
						
					} else if (devicetype == 'tracker' ) {  
					
						device = '<tr id="'+res[i].id+'">';
						device += '<td class="text-center"><input type="checkbox" value="'+devicetype+'/'+res[i].manufacturer+'/'+res[i].model+'"></td>';
						device += '<td class="text-center">'+res[i].id+'</td>';
						device += '<td class="text-center"><a href="/admin/device/view?model='+res[i].model+'">'+res[i].model+'</a></td>';
						device += '<td class="text-center">'+res[i].manager+'</td>';
						device += '<td class="text-left">'+res[i].manager_tel+' </td>';
						device += '<td class="text-center">'+res[i].memo+'</td>';
						device += '</tr>';
						
						if (i>=(curPage-1)*sizePerPage &&  i< nextMaxPage){
							$("#tracker-list").append(device);
						}
						
					} else if(devicetype == 'sensorstation') {
						device = '<tr id="'+res[i].id+'">';
						device += '<td class="text-center"><input type="checkbox" value="'+devicetype+'/'+res[i].manufacturer+'/'+res[i].model+'"></td>';
						device += '<td class="text-center">'+res[i].id+'</td>';
						device += '<td class="text-center"><a href="/admin/device/view?model='+res[i].model+'">'+res[i].model+'</a></td>';
						device += '<td class="text-center">'+res[i].manager+'</td>';
						device += '<td class="text-left">'+res[i].manager_tel+' </td>';
						device += '<td class="text-center">'+res[i].memo+'</td>';
						device += '</tr>';
						
						if (i>=(curPage-1)*sizePerPage &&  i< nextMaxPage){
							$("#sensorstration-list").append(device);
						}
						
					}else if (devicetype == 'ess') {
						
						device = '<tr id="'+res[i].id+'">';
						device += '<td class="text-center"><input type="checkbox" value="'+devicetype+'/'+res[i].manufacturer+'/'+res[i].model+'"></td>';
						device += '<td class="text-center">'+res[i].id+'</td>';
						device += '<td class="text-center"><a href="/admin/device/view?model='+res[i].model+'">'+res[i].model+'</a></td>';
						device += '<td class="text-center">'+res[i].pcs_capacity+'</td>';
						device += '<td class="text-center">'+res[i].batt_capacity+'</td>';
						device += '<td class="text-center">'+res[i].batt_type+'</td>';
						device += '<td class="text-center">'+res[i].manager+'</td>';
						device += '<td class="text-left">'+res[i].manager_tel+' </td>';
						device += '<td class="text-center">'+res[i].memo+'</td>';
						device += '</tr>';
						
						if (i>=(curPage-1)*sizePerPage &&  i< nextMaxPage){
							$("#ess-list").append(device);
						}
					}
						
					
					
				}
				
				displayNavigation(res);

			}


		});
   }
   
   function goPage(iPage){
		curPage = iPage;
		readDeviceList(device_type);
	}
   
   function checkAll(obj){
	   
	   var status = $(obj).prop("checked");
	   var devicetype = $("#devicetype").val();
	   
	   console.log("checkAll status : " + status);
	   
	   $("#"+devicetype+"-list").find('input[type=checkbox]').each(function(){
		   if(status) {
			   $(this).prop("checked",true);
		   } else {
			   $(this).prop("checked",false);
		   }
	   });
   }
   
   function deleteDevices() {
	   
	   var modelList = [];
	   var devicetype = $("#devicetype").val();
	   
	   $("#"+devicetype+"-list").find('input[type=checkbox]').each(function(){
		   if($(this).prop("checked") ) {
			   modelList.push( $(this).val());
		   }
	   });
	   
	   
	   if (modelList.length > 0) {
			 $.ajax({
				url: '/api/device/delete',
				type: 'POST',
				data : {'modelList': modelList.toString() },
				cache: false,
				//  headers:{'Content-Type': 'application/json'},
				success: function (res) {
					console.log("result:"+JSON.stringify(res));

					/* for (i=0; i<modelList.length; i++) {
						
						$("#"+modelList[i]).hide();
						
					} */
					
					if (res == "fail"){
						closetime=5;
						$("#infoModalCenter").modal("show");
						setTimeout(displayCloseTime, 1000);
					}

					readDeviceList(devicetype);
				}


			}); 
	   }
	   
	   console.log("modelList:" + modelList.toString());
	   console.log("modelList:" + modelList);
   }
   
   var closetime=5;
	function displayCloseTime(){
		
		if (closetime == 0) {
			$("#infoModalCenter").modal("hide");
		} else {
			$("#close-msg").text(closetime + "초 뒤에 창이 닫힙니다");
			closetime--;
			setTimeout(displayCloseTime, 1000);
		}
		
	}
   </script>
  </body>
</html>