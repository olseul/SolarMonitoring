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
                  <h4 class="page-title">HOME | 운영 | 월별 보고서</h4>
				  <div class="reload"><a><i class="fas fa-sync-alt"></i></a><span style="font-size:15px; font-weight:bold;">페이지 갱신 시각 : </span><span id="current-time">----.--.-- --:--:--</span></div>
                </div>
              </div>
            </div>
            <!-- Page Title Header Ends-->
			<div class="row"><!-- cont01 -->
			  <div class="col-md-12">
				<div class="search-box grid-margin">
				  <div class="row">
					<div class="col-md-2">
						<div class="form-group">
							<select class="form-control" id="period">
							 <option value="monthly">월별</option>
							 <option value="quarter">분기별</option>
							</select>
						</div>
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<select class="form-control" id="year">
							 <option>2022</option>
							 <option selected>2021</option>
							 <option>2020</option>
							 <option >2019</option>
							 <option >2018</option>
							</select>
						</div>
					</div>
					<div class="col-md-8 text-right">
					  <button type="button" onclick="start();" class="btn btn-success mr-2"><i class="fas fa-search"></i>검색</button>  
					</div>  
				  </div>
				</div>	
			  </div>
			</div>
			<div class="row" id="report-list"><!-- cont03 -->
				<div class="loading-panel" style="background:#323b44;">
					<img class="loading-icon" src="/statics/assets/images/89.png"/> 
				</div>
			</div>
          </div>
          <form id="excelForm" action="/admin/statistics/benefit/downExcel" method="post">
          	<input type="hidden" id="url" name="url">
          </form>
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
	
	var closetime = 0;
	
	$(document).ready(function(){
		
		var sid = getCookie("sid");
		
		console.log("Sid:"+sid);
			
		if(!sid) sid = "";
		
		//발전소 목록 조회
		selectSite(sid, start);
		
		
		
	});
	
	function selectPeriod(obj){
		
		if ($(obj).val() == 'daily'){
			
			$("#sdate").datepicker('option','dateFormat','yy-mm');
			var d = new Date();
			date = [
			  d.getFullYear(),
			  ('0' + (d.getMonth() + 1)).slice(-2)
			].join('-');
			
			$("#sdate").val(date);
			
		} else {
			$("#sdate").datepicker('option','dateFormat','yy');
			var d = new Date();
			$("#sdate").val(d.getFullYear());
		}
		
		$("#ptype").val($(obj).val());
	}
	
	
	function start(){
		
		var sid = read_sid();
	
		var period = $("#period").val();
		var year = $("#year").val();
		
		read_export_report(sid,period, year, displayReports);
		
		displayCurrentTime();

	}
	
	function getReportData(list, unit){
		
		if (list){
			for(j=0; j<list.length; j++){
				
				if(list[j].unit == unit) {
					return list[j];
				}
			}
		}
		return null;
	}
	
	function displayReports(period, datas){
		
		$("#report-list").html('');
		
			
			var title = '';
			var report = '';
			if (period == 'monthly'){
				
				for(i=1; i<=12; i++){
					title = i + "월";
					
					var reportData = getReportData(datas.data, i);
					
					if (reportData){
						
						if (reportData.generation > 0) {
							report = '<div class="col-md-3 grid-margin stretch-card" onclick="downloadPdf(\''+reportData.url+'\')">';
						   	report += '	<div class="card">';
							report += '	<div class="card-header"><h4 class="card-title mb-0 text-center">'+title+'</h4></div>';
							report += '		<div class="card-body text-center v1">';
							report += '			<div class="row">';
							report += '				<div class="col-md-4 text-right">';
							report += '					<i class="fas fa-file-invoice report-ico"></i>';
							report += '				</div>';
							report += '				<div class="col-md-8">';
							report += '					<div class="totle-kwh v2">';
							report += '						<div><span>전년동월발전량</span><span><strong>'+$.number(reportData.prev_generation,0)+'</strong> kW</span></div>';
							report += '						<div><span>발전량</span><span><strong>'+$.number(reportData.generation,0)+'</strong> kW</span></div>';
							report += '					</div>';
							report += '				</div>';
							report += '			</div>';
							report += '		</div>';
							report += '	</div>';
							report += '</div>';
						} else {
							
							report = '<div class="col-md-3 grid-margin stretch-card" >';
						   	report += '	<div class="card">';
							report += '	<div class="card-header"><h4 class="card-title mb-0 text-center">'+title+'</h4></div>';
							report += '		<div class="card-body text-center v1" style="height:159px">';
							report += '			<div class="row">';
							report += '				<div class="col-md-8">';
							report += '				<div style="text-align:center;"><span style="text-align:center;">보고서 미생성</span></div>';
							report += '			</div>';
							report += '			</div>';
							report += '		</div>';
							report += '	</div>';
							report += '</div>';
							
						}
					
					} else {
						
						report = '<div class="col-md-3 grid-margin stretch-card" >';
					   	report += '	<div class="card">';
						report += '	<div class="card-header"><h4 class="card-title mb-0 text-center">'+title+'</h4></div>';
						report += '		<div class="card-body text-center v1" style="height:159px">';
						report += '			<div class="row">';
						report += '				<div class="col-md-8">';
						report += '				<div style="text-align:center;"><span style="text-align:center;">보고서 미생성</span></div>';
						report += '			</div>';
						report += '			</div>';
						report += '		</div>';
						report += '	</div>';
						report += '</div>';
						
					}
					
				
					$("#report-list").append(report);
				}
				
				
			} else {
				
				
				for(i=1; i<=4; i++){
					title = i + '분기';
					
					var reportData = getReportData(datas.data, i);
					
					if (reportData){
						if(reportData.generation > 0) {						
							report = '<div class="col-md-3 grid-margin stretch-card" onclick="downloadPdf(\''+reportData.url+'\')">';
						   	report += '	<div class="card">';
							report += '	<div class="card-header"><h4 class="card-title mb-0 text-center">'+title+'</h4></div>';
							report += '		<div class="card-body text-center v1">';
							report += '			<div class="row">';
							report += '				<div class="col-md-4 text-right">';
							report += '					<i class="fas fa-file-invoice report-ico"></i>';
							report += '				</div>';
							report += '				<div class="col-md-8">';
							report += '					<div class="totle-kwh v2">';
							report += '						<div><span>전년동월발전량</span><span><strong>'+$.number(reportData.prev_generation,0)+'</strong> kW</span></div>';
							report += '						<div><span>발전량</span><span><strong>'+$.number(reportData.generation,0)+'</strong> kW</span></div>';
							report += '					</div>';
							report += '				</div>';
							report += '			</div>';
							report += '		</div>';
							report += '	</div>';
							report += '</div>';
						}
					} else {
						
						report = '<div class="col-md-3 grid-margin stretch-card" >';
					   	report += '	<div class="card">';
						report += '	<div class="card-header"><h4 class="card-title mb-0 text-center">'+title+'</h4></div>';
						report += '		<div class="card-body text-center v1" style="height:159px">';
						report += '			<div class="row">';
						report += '				<div class="col-md-8">';
						report += '				<div style="text-align:center;"><span style="text-align:center;">보고서 미생성</span></div>';
						report += '			</div>';
						report += '			</div>';
						report += '		</div>';
						report += '	</div>';
						report += '</div>';
						
					}
					
				
					$("#report-list").append(report);
				}
			}
			
			
			
			
		
		
	}
	
	function excelDownload(){
		$("#excelForm").prop("target","_new").submit();
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
	
	
	function downloadPdf(url) {
	
		$("#url").val(url);
		$("#excelForm").prop("action","/admin/manage/report/pdf" ).prop("target","_new").submit();
	}
	
	   function content_print(){
		    
		    	var initBody = document.body.innerHTML;
		    	window.onbeforeprint = function(){
		     		document.body.innerHTML = document.getElementById("printarea").innerHTML;
		    	}
		    	window.onafterprint = function(){
		     		document.body.innerHTML = initBody;
		     		initCalendar('yy-mm');
		     		start();
		   		 } 
		    	window.print();
		   		 
		  	  
			 // printPop.setContent($("#"+id).html());
		   }  
	
	
	</script>
  </body>
</html>