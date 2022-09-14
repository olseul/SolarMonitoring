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
                  <h4 class="page-title">HOME | ESS | 스케줄 제어</h4>
				  <div class="reload"><a><i class="fas fa-sync-alt"></i></a><span style="font-size:15px; font-weight:bold;">페이지 갱신 시각 : </span><span id="current-time">----.--.-- --:--:--</span></div>
                </div>
              </div>
            </div>
            <!-- Page Title Header Ends-->
            <div class="row">
				<div class="w-box">
					<div class="row"><!-- cont01 -->
					  <div class="col-md-4"><!-- <canvas id="SOCchart" width="100%" height="100%"></canvas> --></div>
					  <div class="col-md-8">
						
					    <form>
                          <div class="form-group row">
                            <label class="col-sm-3 col-form-label">출력 (W) [ 0 ~ 10000 ] </label>
                            <div class="col-sm-9">
                              <input type="text" name="reqOutput" id="reqOutput" class="form-control" onKeyup="validSoc(this);" >
                            </div>
                          </div>
                          
						  <div class="form-group row">
                            <label class="col-sm-3 col-form-label">동작 모드</label>
                            <div class="col-sm-9">
                            		<!-- <input type='hidden' name='opmode' id='opmode' value='2'> -->
	                              <p style="font-size:16px; font-weight:bold;">CP</p>
                            </div>
                          </div>
						  <div class="form-group row">
                            <label class="col-sm-3 col-form-label">월</label>
                            <div class="col-sm-9">
                              <select class="form-control form-control-lg" name="monthStart" id="monthStart" style="width: 40%">
								<option value=1>1월</option>
								<option value=2>2월</option>
								<option value=3>3월</option>
								<option value=4>4월</option>
								<option value=5>5월</option>
								<option value=6>6월</option>
								<option value=7>7월</option>
								<option value=8>8월</option>
								<option value=9>9월</option>
								<option value=10>10월</option>
								<option value=11>11월</option>
								<option value=12>12월</option>
								
							  </select>&nbsp;~&nbsp;
							  <select class="form-control form-control-lg"  name="monthEnd" id="monthEnd"  style="width: 40%">
								<option value=1>1월</option>
								<option value=2>2월</option>
								<option value=3>3월</option>
								<option value=4>4월</option>
								<option value=5>5월</option>
								<option value=6>6월</option>
								<option value=7>7월</option>
								<option value=8>8월</option>
								<option value=9>9월</option>
								<option value=10>10월</option>
								<option value=11>11월</option>
								<option value=12 selected>12월</option>
							  </select>
                            </div>
                          </div>
						  <div class="form-group row">
                            <label class="col-sm-3 col-form-label">요일</label>
                            <div class="col-sm-9">
                              <a href="#" class="select-day select" id="mon">월</a>
							  <a href="#" class="select-day select"  id="tue">화</a>
							  <a href="#" class="select-day select" id="wed">수</a>
							  <a href="#" class="select-day select" id="thur">목</a>
							  <a href="#" class="select-day select" id="fri">금</a>
							  <a href="#" class="select-day select" id="sat">토</a>
							  <a href="#" class="select-day select" id="sun">일</a>
                            </div>
                          </div>
						  <div class="form-group row">
                            <label class="col-sm-3 col-form-label">시간</label>
                            <div class="col-sm-9">
                              <select class="form-control form-control-lg"  name="chargemode" id="chargemode" style="width: 25%">
								<option value="true">충전</option>
								<option value="false">방전</option>
							  </select>
							  <select class="form-control" name="timeStartHour" id="timeStartHour" style="width: 15%">
							  </select>&nbsp;:&nbsp;<select class="form-control" name="timeStartMinute" id="timeStartMinute" style="width: 15%"> 
							  </select> &nbsp;~&nbsp;
							  <select class="form-control" name="timeEndHour" id="timeEndHour" style="width: 15%">
							  </select>&nbsp;:&nbsp;<select class="form-control" name="timeEndMinute" id="timeEndMinute" style="width: 15%">
							  </select>
							  <!-- <input type="text" class="form-control"  name="timeStart" id="timeStart" style="width: 25%" >&nbsp;~&nbsp;
							  <input type="text" class="form-control"  name="timeEnd" id="timeEnd" style="width: 25%" > -->
							  <input type="hidden" name="idx" id="idx">							 
							  
                            </div>
                          </div>
						  <div class="form-group row">
                            <label class="col-sm-3 col-form-label">메모</label>
                            <div class="col-sm-9">
                              <textarea class="form-control"  rows="4" name="memo" id="memo" maxLength="100"></textarea>
                              <small>메모는 100자까지 입력할 수 있습니다.</small>
                            </div>
                          </div>
                          
                          <div class="form-group row">
                            <label class="col-sm-3 col-form-label"></label>
                            <div class="col-sm-9">
                             <button type="button" onclick="initSchedule();" class="btn btn-success mr-2">데이터 초기화</button>
                             <button type="button" onclick="saveSchedule();" class="btn btn-success mr-2"><i class="fas fa-plus"></i>추가/수정</button>
                            </div>
                          </div>
                          
                          
                        </form>	
					  </div>
					</div>
					<div class="row"><!-- cont02 -->
						<div class="table-area col-md-12">
							<table class="table v2">
							  <colgroup>
								<col width="10%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="*">
								<col width="15%">
							  </colgroup>
							  <thead>
								<tr>
								  <th>구분</th>
								  <th>시작시간</th>
								  <th>종료시간</th>
								  <th>실행시간</th>
								  <th>메모</th>
								  <th>관리</th>
								</tr>
							  </thead>
							  <tbody id="schedule-list">
								
                                
							  </tbody>
							</table>
							<div aria-label="Page navigation" id="navigation">
							  <!-- <ul class="pagination justify-content-center">
								<li class="page-item disabled">
								  <a class="page-link" href="#" tabindex="-1">이전</a>
								</li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item active"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item">
								  <a class="page-link" href="#">다음</a>
								</li>
							  </ul> -->
							</div>

						</div>
					</div>
				</div>
			</div>
          </div>
          <!-- partial:partials/_footer.html
          <footer class="footer">
            <div class="container-fluid clearfix text-center">
              <span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Copyright © 2019 Solar Monitoring System. All rights reserved.</span>
            </div>
          </footer>
          
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
					<span id="modal-msg">저장되었습니다.</span>
					<p id="close-msg">5초 뒤에 창이 닫힙니다</p>
				  </div>
				  <div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
				  </div>
				</div>
			  </div>
			</div>
          
          <!-- partial -->
        </div>
        <!-- main-panel ends -->
      </div>
      <!-- page-body-wrapper ends -->
    </div>

    <!-- End custom js for this page-->
	<script>
	
	var modecode = 1;
	var closetime = 0;
	var myChart;
	
	$(document).ready(function(){
		
		var sid = getCookie("sid");
		
		console.log("Sid:"+sid);
			
		if(!sid) sid = "";
		
		//발전소 목록 조회
		selectSite(sid, start);
		
		
		$(".select-day").on('click',function(){
			if($(this).attr("disabled") != "disabled") {
				if($(this).hasClass('select')){
					$(this).removeClass('select');
				} else {
					$(this).addClass('select');
				}
			}
		});
		
		for(i=0; i<24; i++){
			var hour = '0'+i;
			hour = hour.slice(-2);
			var option = '<option value="'+hour+'">' +hour+'</option>';
			
			$("#timeStartHour").append(option);
			$("#timeEndHour").append(option);
		}
		
		for(i=0; i<60; i++){
			var minute = '0'+i;
			minute = minute.slice(-2);
			var option = '<option value="'+minute+'">' +minute+'</option>';
			
			$("#timeStartMinute").append(option);
			$("#timeEndMinute").append(option);
		}
		
	});
	
	function start(){
		
		var sid = read_sid();
	

		read_ess_soc(sid, displayESSSoc);
		read_ess_schedule_list(sid, displayEssScheduleList);
		
		displayCurrentTime();
	}
	
	function disableFields(flag) {
		$(".form-control").attr("disabled", flag);
		$(".select-day").attr("disabled", flag);
 		$(".btn.btn-success").attr("disabled" ,flag);
	}
	
	
	function displayESSSoc(datas){
		
		
		if (!datas) {
			
			closetime=5;
			$("#modal-msg").text("ESS 장치가 없습니다.");
			$("#infoModalCenter").modal("show");
			disableFields(true);
			setTimeout(displayCloseTime, 1000);
			$("#site-select").attr("disabled",false);
			
			if(myChart != null)		myChart.destroy();
			$("#schedule-list").html("");
			return;
		} else {
			disableFields(false);
		}
					
		var ctx = document.getElementById("SOCchart");
		
		if(myChart != null)		myChart.destroy();
		
		myChart = new Chart(ctx, {
		  type: 'bar',
		  data: {
			labels: ["MIN(%)", "MAX(%)"],
			datasets: [{
			  data: [datas.socMin, datas.socMax],
			  backgroundColor: '#00cbfa'

			}]
		  },
		  options: {
			  legend: false,  
			responsive: true,
			title: {
				display: true,
				text: 'SOC'},
			scales: {
			  xAxes: [{
				ticks: {
				  maxRotation: 10,
				  minRotation: 5
				}
			  }],
			  yAxes: [{
				ticks: {
				  beginAtZero: true,
				  max:100,
				  min:0
				}
			  }]
			}
		  }
		});
		
			
	}
	
	var curPage = 1;
	var sizePerPage = 10;
	var dataList = null;
	function displayEssScheduleList(datas){
		
		$("#schedule-list").html("");
		
		if (datas){
			dataList = datas;
			pageSize = datas.length;
			
			var nextMaxPage = curPage * sizePerPage;
			
			if (nextMaxPage > datas.length) nextMaxPage = datas.length;
			
			for (i=(curPage-1)*sizePerPage; i< nextMaxPage; i++){
				var schedule = '<tr id="schedule-">';
				schedule += '<td class="text-center">'+datas[i].chargemodePhase+'</td>';
				schedule += '  <td class="text-center">'+datas[i].timeStart+'</td>';
				schedule += '  <td class="text-center">'+datas[i].timeEnd+'</td>';
				schedule += '  <td class="text-center">'+datas[i].timeRun+'</td>';
				schedule += '  <td class="text-center">'+datas[i].memo+'</td>';
				schedule += '  <td class="text-center"><button type="button" onclick="viewSchedule('+datas[i].idx+');" class="btn btn-success mr-2"><i class="fas fa-edit"></i> 수정</button><button type="button" onclick="deleteSchedule('+datas[i].idx+');" class="btn btn-success mr-2"><i class="fas fa-minus"></i> 삭제</button></td>';
				schedule += '</tr>';
				
				$("#schedule-list").append(schedule);
			}
		
			console.log("Call displayNavigation...");
			displayNavigation(datas);
		
		} else {
			$("#schedule-list").html("<tr><td class='text-center' colspan=6>등록된 스케줄이 없습니다.</td></tr>");
		}
		
		
	}
	
	function goPage(iPage){
		curPage = iPage;
		displayEssScheduleList(dataList);
	}
	
	
	
	
	function viewSchedule(schedule_id){
		var sid = read_sid();
		read_ess_schedule_detail(sid, schedule_id, function(datas){

			var weekcode = datas.weekcode;
			var weekcode2 = weekcode.toString(2);
			console.log("weekcode:" + weekcode2);
			
			for( j=weekcode2.length; j<7;j++){
				weekcode2 = "0" + weekcode2;
			}
			
			$("#idx").val(schedule_id);
			
			$("#reqOutput").val(datas.reqOutput);
			$("#opmode").val(datas.opmode);
			$("#monthStart").val(datas.monthStart);
			$("#monthEnd").val(datas.monthEnd);
			$("#chargemode").val(datas.chargemode?"true":"false");
			/* $("#timeStart").val(datas.timeStart);
			$("#timeEnd").val(datas.timeEnd); */
			$("#memo").val(datas.memo);
			
			var timeStart = datas.timeStart.split(":");
			var timeEnd = datas.timeEnd.split(":");
			
			$("#timeStartHour").val(timeStart[0]);
			$("#timeStartMinute").val(timeStart[1]);
			$("#timeEndHour").val(timeEnd[0]);
			$("#timeEndMinute").val(timeEnd[1]);

			
			$(".select-day").removeClass("select");
			
			var days = ['mon','tue','wed','thur','fri','sat','sun'];
			
			for(i=0;i<7; i++){
				if (weekcode2.charAt(i) == '1') {
					$("#"+days[i]).addClass('select');
				}
			}
			 
			
		});
	}
	

	
	function deleteSchedule(schedule_id){
		
		var sid = read_sid();
		
		if(confirm("스케줄을 삭제하시겠습니까?")){
			delete_ess_schedule(sid, schedule_id, null);
			if($("#idx").val() == schedule_id) { $("#idx").val(""); }
			
			//삭제 성공여부 확인하여  메세지 뛰우기....
			read_ess_soc(sid, displayESSSoc);
			read_ess_schedule_list(sid, displayEssScheduleList);
		}
	}
	
	function initSchedule(){
		$("#idx").val('');
		
		$("#reqOutput").val('');
		$("#monthStart").val(1);
		$("#monthEnd").val(12);
		$("#chargemode").val("true");
		$("#timeStart").val('');
		$("#timeEnd").val('');
		$("#memo").val('');
		$("#timeStartHour").val('00');
		$("#timeStartMinute").val('00');
		$("#timeEndHour").val('00');
		$("#timeEndMinute").val('00');
		
		var days = ['mon','tue','wed','thur','fri','sat','sun'];
		
		for(i=0;i<7; i++){
			$("#" + days[i]).addClass('select');			
		}

	}
	
	function saveSchedule(){
		
		var sid = read_sid();
		
		var idx = $("#idx").val();
		
		var reqOutput = $("#reqOutput").val();
		var opmode = $("#opmode").val();
		var monthStart = $("#monthStart").val();
		var monthEnd = $("#monthEnd").val();
		var chargemode = $("#chargemode").val();
		var timeStart = $("#timeStartHour").val()+":" +$("#timeStartMinute").val();
		var timeEnd = $("#timeEndHour").val()+":" +$("#timeEndMinute").val();
		var memo = $("#memo").val();
		
/* 		alert(opmode); */
		
		if (reqOutput == ''){
			$("#reqOutput").focus();
			return;
		}
		
		/* if(timeStart == ''){
			$("#timeStart").focus();
			return;
		}
		
		if(timeEnd == ''){
			$("#timeEnd").focus();
			return;
		} */
		
		var weekStr = '';
		
		var days = ['mon','tue','wed','thur','fri','sat','sun'];
		
		for(i=0;i<7; i++){
			if ($("#" + days[i]).hasClass('select')) {
				weekStr += '1';
			} else {
				weekStr += '0';
			}
		}
		
		var schedule = {
			    "reqoutput" : reqOutput,
			    "opmode" : opmode,
			    "monthStart" : monthStart,
			    "monthEnd" : monthEnd,
			    "weekcode" : weekStr,
			    "chargemode" : chargemode,
			    "timeStart" : timeStart,
			    "timeEnd" : timeEnd,
			    "memo" : memo
			}
		
		console.log("param:" + JSON.stringify(schedule));
		
		if (idx != '') {
			
			update_ess_schedule(sid,idx,JSON.stringify(schedule), function(response,t,r){
				if(r.status == 200) {
					console.log("ess schedule updated!!!");
					closetime=5;
					$("#modal-msg").text("스케줄 정보가 변경되었습니다.");
					$("#infoModalCenter").modal("show");
					displayCloseTime();
					read_ess_soc(sid, displayESSSoc);
					read_ess_schedule_list(sid, displayEssScheduleList);
				} else {
					closetime=5;
					$("#modal-msg").text("스케줄 정보 변경이 실패하였습니다.");
					$("#infoModalCenter").modal("show");
					displayCloseTime();					
				}
			})
			
		} else {
			create_ess_schedule(sid,JSON.stringify(schedule), function(response,t,r){
				
				if(r.status == 201) {
					console.log("ess schedule created!!!");
					closetime=5;
					$("#modal-msg").text("스케줄 정보가 저장되었습니다.");
					$("#infoModalCenter").modal("show");
					displayCloseTime();
					read_ess_soc(sid, displayESSSoc);
					read_ess_schedule_list(sid, displayEssScheduleList);
				}
				else {
						closetime=5;
						$("#modal-msg").text("스케줄 정보 등록이 실패하였습니다.");
						$("#infoModalCenter").modal("show");
						displayCloseTime();					
					} 
			})
		}
		
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
	
	
	
	function validSoc(obj){
		
		var val = $(obj).val().replace(/[^0-9]/g,"");
		
		if (val < 0) val = 0;
		if (val > 10000) val = 10000;
		
		$(obj).val(val);
	}
	
	
	</script>
  </body>
</html>