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
                  <h4 class="page-title">HOME | 태양광 | 장치 제어</h4>
				  <div class="reload"><a href="javascript:start();"><i class="fas fa-sync-alt"></i></a><span id="current-time">2020.3.19 15:27:43</span></div>
                </div>
              </div>
            </div>
            <!-- Page Title Header Ends-->
            <div class="row">
				<div class="w-box">
					<h4 class="mb-4">장치 제어
						<div class="text-right setting-switch">
							<span>자동</span>
							<label class="switch ">
							  <input type="checkbox" class="success" id="auto-mode" onclick="changeControl(this)">
							  <span class="slider round"></span>
							</label>
							<span>수동</span>
						</div>
					</h4>
					<div class="row"><!-- cont01 -->
					  <div class="col-md-3 grid-margin stretch-card">
						<div class="card">
						  <div class="card-body">
							<div class="row">
								<a href="javascript:selectMode(2);" class="sel-night mode2 control-mode">
									<div class="weather-circle">
										<p><i class="far fa-moon"></i></p>
										<p>NIGHT</p>
									</div>
								</a>
							</div>
						  </div>
						</div>
					  </div>
					  <div class="col-md-3 grid-margin stretch-card">
						<div class="card">
						  <div class="card-body">
							<div class="row">
								<a href="javascript:selectMode(3);" class="sel-rain mode3 control-mode">
									<div class="weather-circle">
										<p><i class="fas fa-umbrella"></i></p>
										<p>RAIN</p>
									</div>
								</a>
							</div>
						  </div>
						</div>
					  </div>
					  <div class="col-md-3 grid-margin stretch-card">
						<div class="card">
						  <div class="card-body">
							<div class="row">
								<a href="javascript:selectMode(4);" class="sel-wind mode4 control-mode">
									<div class="weather-circle">
										<p><i class="fas fa-wind"></i></p>
										<p>WIND</p>
									</div>
								</a>
							</div>
						  </div>
						</div>
					  </div>
					  <div class="col-md-3 grid-margin  stretch-card">
						<div class="card">
						  <div class="card-body">
							<div class="row">
								<a href="javascript:selectMode(5);" class="sel-snow mode5 control-mode">
									<div class="weather-circle">
										<p><i class="fas fa-snowflake"></i></p>
										<p>SNOW</p>
									</div>
								</a>
							</div>
						  </div>
						</div>
					  </div>
					</div>
				</div>
			 </div>
          </div>
          <!-- content-wrapper ends -->
          
          
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
					<span id="modal-msg">[NIGHT 모드] 제어 명령을 전송했습니다</span>
					<p id="close-msg">5초 뒤에 창이 닫힙니다</p>
				  </div>
				  <div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
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
	
	$(document).ready(function(){
		
		var sid = getCookie("sid");
		
		console.log("Sid:"+sid);
			
		if(!sid) sid = "";
		
		//발전소 목록 조회
		selectSite(sid, start);
		
		
		

		
	});
	
	function start(){
		
		var sid = read_sid();
	

		read_solar_state(sid, displaySolarState);
		
		displayCurrentTime();
		
	}
	
	
	
	
	function displaySolarState(datas){
		console.log("displaySolarState~");
		
		modecode = datas.modecode;
		
		$(".control-mode").removeClass("select");
		
		$(".mode"+datas.modecode).addClass("select");
		
		
		if (datas.isauto == true) {
			$("#auto-mode").prop("checked",false);
		} else {
			$("#auto-mode").prop("checked",true);
		}
			
	}
	
	function selectMode(code) {
		
		var sid = read_sid();
		
		
		
		if ($("#auto-mode").prop("checked") == true) {
			update_solar_state(sid,'mode', false, code, displayUpdateControl );
		} else {
			console.log("수동 모두에서만 동작을 합니다..");
		}
	}
	
	function changeControl(obj) {
		
		console.log("changeControl");
		var sid = read_sid();
		
		update_solar_state(sid,'control', !$(obj).prop("checked"), modecode, displayUpdateControl );
	}
	
	
	function displayUpdateControl(datas){
		
		var modes = ['NONE', 'NIGHT','RAIN', 'WIND','SHOW'];
		
		if (datas.res_code == 1) {
		
			$("#modal-msg").text("등록된 트래커가 없습니다.");
			
			$("#infoModalCenter").modal("show");
			
			closetime =5;
			$("#close-msg").text(closetime + "초 뒤에 창이 닫힙니다");
			
			setTimeout(displayCloseTime, 1000);
			
		} else {
			if (datas.update_type == 'mode'){
				
				$("#modal-msg").text("["+modes[datas.modecode]+" 모드] 제어 명령을 전송했습니다");
				
			} else {
				$("#modal-msg").text("제어 명령을 전송했습니다");
			}
			
			$("#infoModalCenter").modal("show");
			
			closetime =5;
			$("#close-msg").text(closetime + "초 뒤에 창이 닫힙니다");
			setTimeout(displayCloseTime, 1000);
			
		}
	}
	
	
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