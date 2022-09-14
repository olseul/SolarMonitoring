<%@page import="com.nhncorp.lucy.security.xss.XssPreventer"%>
<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./header.jsp" %>
<%@ include file="./LNB.jsp" %>
    <%
    String msg = request.getParameter("msg");
    
    
    String devicetype = "inverter";
    
    if(request.getParameter("devicetype") != null) {
	    switch(request.getParameter("devicetype")) {
	    case "inverter":
	    	devicetype = "inverter";
	    	break;
	    case "tracker":
	    	devicetype = "tracker";
	    	break;
	    case "sensorstation":
	    	devicetype = "sensorstation";
	    	break;
	    case "ess":
	    	devicetype = "ess";
	    	break;
	    	default:
	    		break;
	    }
    }
    %>

     
       <!-- partial -->
       	<input type="hidden" id="lastDevice" value="inverter" readonly disabled/>
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
									  <select class="form-control" style="width: 50%;" name="devicetype" id="devicetype">
										 <option value="inverter" <%=devicetype.equals("inverter")?"selected":"" %>>인버터</option>
										 <option value="tracker" <%=devicetype.equals("tracker")?"selected":"" %>>트랙커</option>
										  <option value="ess" <%=devicetype.equals("ess")?"selected":"" %>>ESS</option>
									    </select>
									</div>
								</div>
							</div>
							<div class="col-md-7 text-right">
								<small style="color:#ff0000; display:none;" id="no_result">조회 결과가 없습니다.</small> 
							</div>
							<div class="col-md-1 text-right">
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
								  <th><input type="checkbox" onclick="checkAll(this)"></th>
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
								  <th><input type="checkbox" onclick="checkAll(this)"></th>
								  <th>ID</th>
								  <th>모델명</th>
								  <th>A/S 담당자</th>
								  <th>A/S연락처</th>
								  <th>메모</th>
								</tr>
							  </thead>
							  <tbody id="sensorstation-list">
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
								  <th><input type="checkbox" onclick="checkAll(this)"></th>
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
					<span id="modal-msg">장치를 삭제하는데 문제가 발생했습니다.<br>장치가 등록되어 있는 발전소가 있는 경우 삭제가 불가능합니다.</span>
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
	   initSetting();
	   
	   var deviceType = '<%=StringUtil.nvl(devicetype)%>';
	   var dataList;
	   
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
		
   
	   readDeviceList('<%=XssPreventer.escape(devicetype)%>');
	   
	});
   
   function initSetting() {
	   curPage = 1;
	   $("#devicetype").val("inverter");
   }
   
   function searchDevice() {
	  /*  var deviceType = $("#devicetype").val();
	   
	   readDeviceList(deviceType);  */

	   curPage = 1;
	   selectDeviceType();
   }
   
   function selectDeviceType() {
		
		var deviceType = $("#devicetype").val();
		
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
   
   function readPage() {
		if(dataList) {
			$("#table-"+device_type).find("input[type=checkbox]").each(function() { $(this).prop("checked",false); });
			
			pageSize = dataList.length;
		    var nextMaxPage = curPage * sizePerPage;
			
			if (nextMaxPage > dataList.length) nextMaxPage = dataList.length;
			
			$("#" + device_type + "-list").html('');
			
			for (i=0; i<dataList.length; i++){

				var device = '';
				
				if (device_type == '' || device_type == 'inverter') {
					
					
					device = '<tr id="' +device_type+'/'+dataList[i].manufacturer+'/'+dataList[i].model+'">';
					device += '<td class="text-center"><input type="checkbox" value="'+device_type+'/'+dataList[i].manufacturer+'/'+dataList[i].model+'"></td>';
					device += '<td class="text-center">'+dataList[i].id+'</td>';
					device += '<td class="text-center"><a href="/admin/device/view?model='+dataList[i].model+'">'+dataList[i].model+'</a></td>';
					device += '<td class="text-center">'+dataList[i].capacity+'</td>';
					device += '<td class="text-center">'+dataList[i].manager+'</td>';
					device += '<td class="text-center">'+dataList[i].manager_tel+' </td>';
					device += '<td class="text-center">'+dataList[i].memo+'</td>';
					device += '</tr>';
					
					if (i>=(curPage-1)*sizePerPage &&  i< nextMaxPage){
						$("#inverter-list").append(device);
					}
					
				} else if (device_type == 'tracker' ) {   
					device = '<tr id="' +device_type+'/'+dataList[i].manufacturer+'/'+dataList[i].model+'">';
					device += '<td class="text-center"><input type="checkbox" value="'+device_type+'/'+dataList[i].manufacturer+'/'+dataList[i].model+'"></td>';
					device += '<td class="text-center">'+dataList[i].id+'</td>';
					device += '<td class="text-center"><a href="/admin/device/view?model='+dataList[i].model+'">'+dataList[i].model+'</a></td>';
					device += '<td class="text-center">'+dataList[i].manager+'</td>';
					device += '<td class="text-center">'+dataList[i].manager_tel+' </td>';
					device += '<td class="text-center">'+dataList[i].memo+'</td>';
					device += '</tr>';
					
					if (i>=(curPage-1)*sizePerPage &&  i< nextMaxPage){
						$("#tracker-list").append(device);
					}
					
				} else if(device_type == 'sensorstation') {
					device = '<tr id="' +device_type+'/'+dataList[i].manufacturer+'/'+dataList[i].model+'">';
					device += '<td class="text-center"><input type="checkbox" value="'+device_type+'/'+dataList[i].manufacturer+'/'+dataList[i].model+'"></td>';
					device += '<td class="text-center">'+dataList[i].id+'</td>';
					device += '<td class="text-center"><a href="/admin/device/view?model='+dataList[i].model+'">'+dataList[i].model+'</a></td>';
					device += '<td class="text-center">'+dataList[i].manager+'</td>';
					device += '<td class="text-center">'+dataList[i].manager_tel+' </td>';
					device += '<td class="text-center">'+dataList[i].memo+'</td>';
					device += '</tr>';
					
					if (i>=(curPage-1)*sizePerPage &&  i< nextMaxPage){
						$("#sensorstation-list").append(device);
					}
					
				}else if (device_type == 'ess') {
					device = '<tr id="'+device_type+'/'+dataList[i].manufacturer+'/'+dataList[i].model+'">';
					device += '<td class="text-center"><input type="checkbox" value="'+device_type+'/'+dataList[i].manufacturer+'/'+dataList[i].model+'"></td>';
					device += '<td class="text-center">'+dataList[i].id+'</td>';
					device += '<td class="text-center"><a href="/admin/device/view?model='+dataList[i].model+'">'+dataList[i].model+'</a></td>';
					device += '<td class="text-center">'+dataList[i].pcs_capacity+'</td>';
					device += '<td class="text-center">'+dataList[i].batt_capacity+'</td>';
					device += '<td class="text-center">'+dataList[i].batt_type+'</td>';
					device += '<td class="text-center">'+dataList[i].manager+'</td>';
					device += '<td class="text-center">'+dataList[i].manager_tel+' </td>';
					device += '<td class="text-center">'+dataList[i].memo+'</td>';
					device += '</tr>';
					
					if (i>=(curPage-1)*sizePerPage &&  i< nextMaxPage){
						$("#ess-list").append(device);
					}
				}				
			}
			
			displayNavigation(dataList);
			
			if(pageSize <= sizePerPage) {
				$("#navigation").attr("style","visibility:hidden");
			} else {
				$("#navigation").attr("style","visibility:");
			}
		}
	}
   
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
				
				if(response.length == 0) $("#no_result").show();
			   	else $("#no_result").hide();

				for (i=0; i<response.length; i++) {
					
					var deviceType = response[i].devicetype;
					
					if ( deviceType == devicetype){
						
						deviceDatas.push(response[i]);
					}
					
					
				}
				
				$("#lastDevice").val($("#devicetype").val());
				var res = deviceDatas;
				device_type = devicetype;
				dataList = res;
				
				
				readPage();
			}
		});
   }
   
   function goPage(iPage){
		curPage = iPage;
		readPage();
		//readDeviceList(device_type);
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
	   var devicetype = $("#lastDevice").val();
	   
	   $("#"+devicetype+"-list").find('input[type=checkbox]').each(function(){
		   if($(this).prop("checked") ) {
			   modelList.push( $(this).val());
		   }
	   });
	   
	   
	   
	   if (modelList.length > 0) {
		   if(confirm("정말 삭제하시겠습니까? 삭제 시, 사용이 불가능할 수 있습니다.")) {
				 $.ajax({
					url: '/api/device/delete',
					type: 'POST',
					data : {'modelList': modelList.toString() },
					cache: false,
					//  headers:{'Content-Type': 'application/json'},
					success: function (res) {
						console.log("result:"+JSON.stringify(res));
	
						/* for (i=0; i<modelList.length; i++) {
							
							$("#"+modelList[i].replaceAll("/","\\/")).hide();
							
						}  */
						
						if (res == "fail"){
							closetime=5;
							$("#infoModalCenter").modal("show");
							setTimeout(displayCloseTime, 0);
						}
						initSetting();
						readDeviceList(devicetype);
					}
				}); 
		   }
	   }
	   
	   console.log("modelList:" + modelList.toString());
	   console.log("modelList:" + modelList);
   }
   
   var closetime=5;
   var timeoutHandler;
	function displayCloseTime(){
		
		if (closetime == 0) {
			$("#infoModalCenter").modal("hide");
		} else {
			$("#close-msg").text(closetime + "초 뒤에 창이 닫힙니다");
			closetime--;
			clearTimeout(timeoutHandler);
			timeoutHandler = setTimeout(displayCloseTime, 1000);
		}
		
	}
   </script>
  </body>
</html>