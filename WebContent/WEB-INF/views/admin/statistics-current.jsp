<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./header.jsp" %>
<%@ include file="./LNB.jsp" %>
<!-- 	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <script src="/statics/js/jquery.number.js"></script>
    <script src="/statics/js/jquery.cookie.js"></script> -->
    <%
    String msg = request.getParameter("msg");
   
    %>
          <div class="main-panel">
          <div class="content-wrapper">
            <!-- Page Title Header Starts-->
            <div class="row page-title-header">
              <div class="col-12">
                <div class="page-header">
                  <h4 class="page-title">HOME | 통계분석 | 태양광 현황</h4>
				  <div class="reload"><a><i class="fas fa-sync-alt"></i></a><span style="font-size:15px; font-weight:bold;">페이지 갱신 시각 : </span><span id="current-time">----.--.-- --:--:--</span></div>
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
							<div class="col-md-2">
								<div class="form-group row">
									<label class="col-sm-4 col-form-label"  style="text-align: right;">범위</label>
									<div class="col-sm-8">
									  <select class="form-control" onchange="selectPeriod(this)" id="period">
									  	<option value="hourly">시간별</option>
										<option value="daily">일별</option>
										<option value="monthly">월별</option>
										
									  </select>
									</div>
								</div>
							</div>
							<div class="col-md-5">
								<div class="form-group row">
									<label class="col-sm-2 col-form-label"  style="text-align: right;">기간</label>
									<div class="col-sm-10">
									  <input type="text" class="form-control calendar" style="width: 30%" id="start_date" value="" autocomplete="off">&nbsp;~&nbsp;<input type="text" class="form-control calendar" style="width: 30%"  id="end_date"  autocomplete="off">
									</div>
								</div>
							</div>
							<div class="col-md-5 text-right">
							  <button type="button" onclick="start();" class="btn btn-success mr-2"><i class="fas fa-search"></i>검색</button>  
							</div>  
						  </div>
						</div>	
					  </div>
					</div>
					<div class="row"><!-- cont02 -->
						<div class="col-md-12 mb-5"> 
							<div class="loading-panel"> 
								<img class="loading-icon" src="/statics/assets/images/89.png"/>
							</div>
							<canvas id="mix" width="*" height="100"></canvas>
						</div>
					</div>
					<div class="row"><!-- cont03 -->
						<div class="table-area col-md-12 mb-5">
							<table class="table v3">
							  <tbody>
								<tr>
								  <th style="text-align: center;">태양광 발전량</th>
								  <td class="text-right" id="sum-generation">0 kW</td>
								  <th  style="text-align: center;">10:00~15:59 발전량</th>
								  <td class="text-right" id="sum-gen10to16">0 kW</td>
								  <th  style="text-align: center;">충전량</th>
								  <td class="text-right" id="sum-charge">0 kW</td>
								  <th  style="text-align: center;">방전량</th>
								  <td class="text-right" id="sum-discharge">0 kW</td>
								</tr>
							  </tbody>
							</table>
						</div>
					</div>
					<div class="row"><!-- cont04 -->
						<div class="col-md-8 text-left"><p style="font-size:8pt; color:red;"> 마이너스 발전량 발생하는 경우, 서로 다른 누적발전량이 반복 전송되어 누적발전량 사이의 차를 표시하는 상태입니다.<br>트랙커 제어기와 인버터 간 배선을 확인해 주세요.</p></div>
						<div class="col-md-4 text-right mb-2"><button type="button" onclick="excelDownload();" class="btn btn-primary btn-sm mr-2">엑셀다운</button><button type="button" class="btn btn-primary btn-sm" onclick="content_print()">프린트</button></div>
						<div class="table-area col-md-12"  id="printarea">
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
								  <th>No.</th>
								  <th>일자</th>
								  <th>태양광 발전량[kW]</th>
								  <th>10:00 ~ 15:59  발전량[kW]</th>
								  <th>충전량[kW]</th>
								  <th>방전량[kW]</th>
								</tr>
							  </thead>
							  <tbody id="current-list">
							
							  </tbody>
							</table>
							<div aria-label="Page navigation" id="navigation">
							  
							</div>

						</div>
					</div>
				</div>
			</div>
          </div>
          
          <form id="excelForm" action="/admin/statistics/current/downExcel" method="post">
          	<input type="hidden" name="data" id="data">
          	<input type="hidden" name="ptype" id="ptype" value="hourly">
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

<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet"> -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css" rel="stylesheet">
<!--      -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
    <script src="/statics/js/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>
    
    <!-- End custom js for this page-->
	<script>
	
	var closetime = 0;
	
	$(document).ready(function(){
		
		var sid = getCookie("sid");
		
		console.log("Sid:"+sid);
			
		if(!sid) sid = "";
		
		initCalendar('yy-mm-dd');
		//발전소 목록 조회
		selectSite(sid, start);
		
		
		
	});
	
	function selectPeriod(obj){
		
		 if ($(obj).val() == 'hourly'){
			
			/* $(".calendar").datepicker('option','dateFormat','yy-mm-dd');
			var d = new Date();
			date = [
			  d.getFullYear(),
			  ('0' + (d.getMonth() + 1)).slice(-2),
			  ('0' + (d.getDate() + 1)).slice(-2)
			].join('-');
			
			$(".calendar").val(date); */
			
			 initCalendar('yy-mm-dd');
		} else if ($(obj).val() == 'daily'){
			
			/* $(".calendar").datepicker('option','dateFormat','yy-mm-dd');
			var d = new Date();
			date = [
					  d.getFullYear(),
					  ('0' + (d.getMonth() + 1)).slice(-2),
					  ('0' + (d.getDate() + 1)).slice(-2)
					].join('-');
			
			$(".calendar").val(date); */
			initCalendar('yy-mm-dd2');
			
		} else if( $(obj).val() == 'monthly') {
			/* $(".calendar").datepicker('option','dateFormat','yy-mm');
			var d = new Date();
			date = [
			  d.getFullYear(),
			  ('0' + (d.getMonth() + 1)).slice(-2)
			].join('-');
			
			$(".calendar").val(date); */
			
			initCalendar('yy-mm');
		} 
		
		$("#ptype").val($(obj).val());
	}
	
	var datepicker_default = null;
	var endDt = new Date();
	var lastFormat = 'yy-mm-dd';
	
	function initCalendar(format){
		console.log(format);
		endDt = new Date();
		
		lastFormat = format;
		// 조회 제한 
		// 시간별 : 1월
		// 일별 : 1년
		// 월별 : 3년
		if (!format || format == 'yy-mm-dd'){
			
			/* $(".calendar").datepicker({
		         minViewMode: "days",
		         format: 'yyyy-mm-dd',
		         autoclose: true,
		         language:'ko'
		       }); */
			
			/* $(".calendar#start_date").datepicker({
				minViewMode: "days",
		        format: 'yyyy-mm-dd',
		        autoclose: true,
		        language:'ko'
			}); */
		   
	       $(".calendar#start_date").datepicker("destroy").datepicker({
				minViewMode: "days",
		        format: 'yyyy-mm-dd',
		        autoclose: true,
		        language:'ko',
		        startDate : new Date(new Date(endDt).setDate(endDt.getDate()-30)),
		        endDate : endDt
       	   });
			
			$(".calendar#end_date").datepicker("destroy").datepicker({
				minViewMode: "days",
		        format: 'yyyy-mm-dd',
		        autoclose: true,
		        language:'ko',
		        startDate : new Date('2000-02-01'),
		        endDate : endDt
			});
			
		} else if(format == 'yy-mm-dd2') {
			$(".calendar#start_date").datepicker("destroy").datepicker({
				minViewMode: "days",
		        format: 'yyyy-mm-dd',
		        autoclose: true,
		        language:'ko',
		        startDate : new Date(new Date(endDt).setFullYear(endDt.getFullYear()-1)),
		        endDate : endDt
       	   });
			
			$(".calendar#end_date").datepicker("destroy").datepicker({
				minViewMode: "days",
		        format: 'yyyy-mm-dd',
		        autoclose: true,
		        language:'ko',
		        startDate : new Date('2001-01-01'),
		        endDate : endDt
			});
		} else if (format == 'yy-mm'){
			
			$('.calendar#start_date').datepicker("destroy").datepicker({
		         minViewMode: "months",
		         format: 'yyyy-mm',
		         autoclose: true,
		         language:'ko',
		         startDate : new Date(new Date(endDt).setFullYear(endDt.getFullYear()-3)),
		         endDate : endDt
		       });
			
			$('.calendar#end_date').datepicker("destroy").datepicker({
		         minViewMode: "months",
		         format: 'yyyy-mm',
		         autoclose: true,
		         language:'ko',
		         startDate : new Date('2003-01-01'),
		         endDate : endDt
		       });
			
		} else {
			console.log("years picker");
			
		  $('.calendar#start_date').datepicker("destroy").datepicker({
         	minViewMode: "years",
         	format: 'yyyy',
        	 autoclose: true,
        	 language:'ko',
        	 startDate : new Date(new Date(endDt).setFullYear(endDt.getFullYear()-3)),
	         endDate : endDt
	       });
		  
		  $('.calendar#end_date').datepicker("destroy").datepicker({
         	minViewMode: "years",
         	format: 'yyyy',
        	 autoclose: true,
        	 language:'ko',
	         endDate : endDt
	       });
		}
		
		$('.calendar#end_date').datepicker().on('hide', function(e) {
			
			if(lastFormat == 'yy-mm-dd') {
				endDt = new Date($(".calendar#end_date").val());
				
				var startDt = new Date($(".calendar#start_date").val().length != 0 ? $(".calendar#start_date").val() : new Date());
				var endlimitDt = new Date(new Date(endDt).setDate(endDt.getDate()-30));
				
				$(".calendar#start_date").datepicker('setStartDate',endlimitDt);
				
				if(startDt < endlimitDt)
					$(".calendar#start_date").datepicker("setDate", endlimitDt.getFullYear() + "-" + (endlimitDt.getMonth() + 1) + "-" + endlimitDt.getDate());
				else if (startDt >= endDt) 
					$(".calendar#start_date").datepicker("setDate", endDt.getFullYear() + "-" + (endDt.getMonth() + 1) + "-" + endDt.getDate());
			
			}
			else if(lastFormat == 'yy-mm-dd2') {
				endDt = new Date($(".calendar#end_date").val());
				
				var startDt = new Date($(".calendar#start_date").val().length != 0 ? $(".calendar#start_date").val() : new Date());
				var endlimitDt = new Date(new Date(endDt).setFullYear(endDt.getFullYear()-1));
				
				$(".calendar#start_date").datepicker('setStartDate',endlimitDt);
				
				if(startDt < endlimitDt)
					$(".calendar#start_date").datepicker("setDate", endlimitDt.getFullYear() + "-" + (endlimitDt.getMonth() + 1) + "-" + endlimitDt.getDate());
				else if (startDt >= endDt) 
					$(".calendar#start_date").datepicker("setDate", endDt.getFullYear() + "-" + (endDt.getMonth() + 1) + "-" + endDt.getDate());
				
				
			}
			else if(lastFormat == 'yy-mm') {
				endDt = new Date($(".calendar#end_date").val());
				
				var startDt = new Date($(".calendar#start_date").val().length != 0 ? $(".calendar#start_date").val() : new Date());
				var endlimitDt = new Date(new Date(endDt).setFullYear(endDt.getFullYear()-3));
				
				$(".calendar#start_date").datepicker('setStartDate',endlimitDt);
				
				if(startDt < endlimitDt)
					$(".calendar#start_date").datepicker("setDate", endlimitDt);
				else if (startDt >= endDt) 
					$(".calendar#start_date").datepicker("setDate", endDt);
				
				
			}
		});
		
		var d = new Date();
		date = [
		  d.getFullYear(),
		  ('0' + (d.getMonth() + 1)).slice(-2),
		  ('0' + (d.getDate() )).slice(-2)
		].join('-');
			
		$("#end_date").datepicker("setDate", date);
		//$("#end_date").val(date);				

		d.setDate(d.getDate() - 1);

		date = [
				  d.getFullYear(),
				  ('0' + (d.getMonth() + 1)).slice(-2),
				  ('0' + (d.getDate() )).slice(-2)
				].join('-');
		
		$("#start_date").datepicker("setDate", date);
		//$("#start_date").val(date);
	}
	
	
	function initCalendar_old(format){
		console.log("initCalendar:" + format);
		datepicker_default = {
	            closeText : "닫기",
	            prevText : "이전달",
	            nextText : "다음달",
	            currentText : "오늘",
	            changeMonth: true,
	            changeYear: true,
	            monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
	            monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
	            dayNames : [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ],
	            dayNamesShort : [ "일", "월", "화", "수", "목", "금", "토" ],
	            dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
	            weekHeader : "주",
	            firstDay : 0,
	            isRTL : false,
	            showMonthAfterYear : true,
	            yearSuffix : ''
	             
	           // showOn: 'both'
	            //buttonImage:'/resources/image/calendar.png',
	            //buttonImageOnly: true,
	             
	            //showButtonPanel: true
	        }
	      
	        datepicker_default.closeText = "선택";
	        datepicker_default.dateFormat = format;
	        datepicker_default.onClose = function (dateText, inst) {
		          /*   var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
		            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
		            $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
		            $(this).datepicker('setDate', new Date(year, month, 1)); */
		        }
		      
		        datepicker_default.beforeShow = function () {
		           /*  var selectDate = $("#sdate").val().split("-");
		            var year = Number(selectDate[0]);
		            var month = Number(selectDate[1]) - 1;
		            $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) ); */
		        }
		 
			$(".calendar").datepicker(datepicker_default);
			
			var d = new Date();
			date = [
			  d.getFullYear(),
			  ('0' + (d.getMonth() + 1)).slice(-2),
			  ('0' + (d.getDate() )).slice(-2)
			].join('-');
			
			$("#end_date").val(date);
			
					

			d.setDate(d.getDate() - 1);

			date = [
					  d.getFullYear(),
					  ('0' + (d.getMonth() + 1)).slice(-2),
					  ('0' + (d.getDate() )).slice(-2)
					].join('-');
					
			$("#start_date").defaultDate = date;
			$("#start_date").val(date);
			
	}
	
	function start(){
		
		var sid = read_sid();
	
		var period = $("#period").val();
		var start_date = $("#start_date").val();
		var end_date = $("#end_date").val();
		
		
		if(new Date(start_date) <= new Date(end_date)) {
			curPage = 1;
			read_statistics_current(sid,period, start_date, end_date, displayCurrent);
			displayCurrentTime();
		} else {
			alert("조회 종료 기간은 조회 시작 기간보다 크거나 같아야 합니다.");
		}
	}
	
	var curPage = 1;
	var sizePerPage = 10;
	var dataList = null;
	var m_period = null;
	
	var chartData = null; 
	
	function displayCurrent(period, datas){
		console.log("displayCurrent! : ");
		console.log(datas);
		
		$("#current-list").html('');
		$("#data").val(JSON.stringify(datas));
		
		var generation = 0;
		var charge = 0;
		var discharge = 0;
		var benefit =0;
		var gen10to16 = 0;
		
		var labels 		= [];
		var generations = [];
		var charges 	= [];
		var discharges 	= [];
		var gen10to16s	= [];
		
		m_period = period;
		dataList = datas;
		pageSize = datas.data.length;
		
		var nextMaxPage = curPage * sizePerPage;
		
		if (nextMaxPage > datas.data.length) nextMaxPage = datas.data.length;
		
		if (!datas.data || datas.data.length == 0){
			item += '<td class="text-center"></td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '</tr>';  
				
			$("#current-list").append(item);
		}
		
		if(pageSize <= sizePerPage) {
			$("#navigation").attr("style","visibility:hidden");
		} else {
			$("#navigation").attr("style","visibility:");
		}
		
		for(i=0; i<datas.data.length ; i++) {

			var d = new Date(datas.data[i].reg_date);
			var strDate = '';
			if (period =='monthly'){
				strDate = d.getFullYear() + "년 " + ('0' + (d.getMonth() + 1)).slice(-2) +"월";
				labels.push(d.getFullYear() + "-" + ('0' + (d.getMonth() + 1)).slice(-2));
			} else if(period == 'daily') {
				strDate = ('0' + (d.getMonth() + 1)).slice(-2) +"월 " +('0' + (d.getDate() )).slice(-2)+"일"
				labels.push(('0' + (d.getMonth() + 1)).slice(-2) +"-" +('0' + (d.getDate() )).slice(-2));
			} else {
				strDate = ('0' + (d.getDate() )).slice(-2)+"일 " + datas.data[i].unit +"시";
				labels.push(strDate);
			}
			
			console.log(strDate);
			//labels.push(strDate);
			
			var item = "<tr>";
			item += '<td class="text-center">'+(i+1)+'</td>';
			item += '<td class="text-right">'+strDate+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].generation,3)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].gen10to16,3)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].charge,3)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].discharge,3)+'</td>';
			item += '</tr>';  
			
			if (i>=(curPage-1)*sizePerPage &&  i< nextMaxPage){
			
				$("#current-list").append(item);
			}
			
			generation += datas.data[i].generation;
			charge += datas.data[i].charge;
			discharge += datas.data[i].discharge;
			gen10to16 += datas.data[i].gen10to16;
			
			
			
			
			generations.push(datas.data[i].generation);
			charges.push(datas.data[i].charge);
			
			console.log(charges);
			discharges.push(datas.data[i].discharge);
			gen10to16s.push(datas.data[i].gen10to16);
			
			
		}
		
		$("#sum-generation").text($.number(datas.info.sum_generation,3) + " kW");
		$("#sum-charge").text($.number(datas.info.sum_charge,3) + " kW");
		$("#sum-discharge").text($.number(datas.info.sum_discharge,3) + " kW");
		$("#sum-gen10to16").text($.number(datas.info.sum_gen10to16,3) + " kW");
		
		
	//	if (datas.data){
			displayNavigation(datas.data);
	//	} 
		
		if(chartData) chartData.destroy();
		
		
		const mix = document.getElementById('mix').getContext('2d')

		chartData = new Chart(mix, {
		  type: 'bar',
			data: {
			  labels: labels,
			  datasets: [ {
				  label: "태양광 발전량",
				  type: "line",
				  borderColor: "#ffd300",
				  data: generations,
				  fill: false,
				  backgroundColor: "#c4e9ff"
				}, 
				{
				  label: "10:00~15:59 발전량",
				  type: "line",
				  borderColor: "#b5e004",
				  data: gen10to16s,
				  fill: false,
				  backgroundColor: "#b5e004"
				}, {
				  label: "충전량",
				  type: "bar",
				  backgroundColor: "#0090b7",
				  data: charges
				}, {
					  label: "방전량",
					  type: "bar",
					  backgroundColor: "#ab8ce4",
					  data: discharges
					}
			  ]
			},
			options: {
			  title: {
				display: false,
			  },
			  legend: { display: true},
	          scales: {
	    		xAxes: [{
	    			scaleLabel: {
	    				display: true,
	    				labelString : '날짜 및 시간 (datetime)'
	    			}
	    		  }],
	    		  yAxes: [{
	    			scaleLabel: {
	    				display: true,
	    				labelString : '발전량 (kW)'
	    			}
	    		  }]
	    	}
			}
		});
		
		
	}
	
	function goPage(iPage){
		curPage = iPage;
		displayCurrent(m_period, dataList);
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
	
	
	function displayForPrint(){
		

		
		$("#current-list").html('');
		//$("#data").val(JSON.stringify(datas));
		
		var generation = 0;
		var charge = 0;
		var discharge = 0;
		var benefit =0;
		var gen10to16 = 0;
		
		var labels 		= [];
		var generations = [];
		var charges 	= [];
		var discharges 	= [];
		var gen10to16s	= [];
		
		m_period = period;
		var datas = 	dataList;
		pageSize = datas.data.length;

		
		if (!datas.data || datas.data.length == 0){
			item += '<td class="text-center"></td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '</tr>';  
				
			$("#current-list").append(item);
				
		}
		
		for(i=0; i<datas.data.length ; i++) {

			var d = new Date(datas.data[i].reg_date);
			var strDate = '';
			if (period =='monthly'){
				strDate = d.getFullYear() + "년 " + ('0' + (d.getMonth() + 1)).slice(-2) +"월";
				labels.push(d.getFullYear() + "-" + ('0' + (d.getMonth() + 1)).slice(-2));
			} else if(period == 'daily') {
				strDate = ('0' + (d.getMonth() + 1)).slice(-2) +"월 " +('0' + (d.getDate() )).slice(-2)+"일"
				labels.push(('0' + (d.getMonth() + 1)).slice(-2) +"-" +('0' + (d.getDate() )).slice(-2));
			} else {
				strDate = ('0' + (d.getDate() )).slice(-2)+"일 " + datas.data[i].unit +"시";
			}
			
			console.log(strDate);
			labels.push(strDate);
			
			var item = "<tr>";
			item += '<td class="text-center">'+(i+1)+'</td>';
			item += '<td class="text-right">'+strDate+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].generation,3)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].gen10to16,3)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].charge,3)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].discharge,3)+'</td>';
			item += '</tr>';  
			

			$("#current-list").append(item);

		}
		
	}
	
	   function print_setLandscape() {
		    var css = '@page { size : portrait; }';
	   		var style = document.createElement('style');
	   		style.type = 'text/css';
	   		style.media = 'print';
	   		
	   		if(style.styleSheet) {
	   			
	   		} else {
	   			style.appendChild(document.createTextNode(css));
	   		}
	   		
	   		document.getElementById("printarea").appendChild(style);
	   }
	
	   function content_print(){
		   
		   	var period = $("#period").val();
			var start_date = $("#start_date").val();
			var end_date = $("#end_date").val() ;
			
		   displayForPrint();
		   $("#navigation").html("");
		    
	    	var initBody = document.body.innerHTML;
	    	window.onbeforeprint = function(){
	    		print_setLandscape();
	    		$("#printarea table *").css("font-size","5px");
	     		document.body.innerHTML = document.getElementById("printarea").innerHTML;
	    	}
	    	window.onafterprint = function(){
	     		document.body.innerHTML = initBody;
	     		
	     		if(period == 'monthly'){
	     			initCalendar('yy-mm');
	     		} else {
	     			initCalendar('yy-mm-dd');
	     		}
	     		$("#printarea table *").css("font-size","");
					
	     		$("#period").val(period);
	     		$("#start_date").val(start_date);
	     		$("#end_date").val(end_date); 
	     		
	     		window.onbeforeprint = null;
	     		window.onafterprint = null;
	     		
	     		selectSite(getCookie("sid"), start); 
	   		 } 
	    	
	    	
	    	window.print();
	   		 
	  	  
		 // printPop.setContent($("#"+id).html());
	   }  
	
	
	</script>
  </body>
</html>