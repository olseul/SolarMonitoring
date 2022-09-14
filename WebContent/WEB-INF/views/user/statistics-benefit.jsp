<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./header.jsp" %>
<%@ include file="./LNB.jsp" %>
	<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <script src="/statics/js/jquery.number.js"></script>
    <script src="/statics/js/jquery.cookie.js"></script> -->
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
                  <h4 class="page-title">HOME | 통계분석 | 발전수익 현황</h4>
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
							<div class="col-md-6">
								<div class="form-group row">
									<label class="col-sm-2 col-form-label"  style="text-align: right;">범위</label>
									<div class="col-sm-10">
									  <select class="form-control" style="width: 30%" id="period" onchange="selectPeriod(this);">
									    <option value="daily">일별</option>
										<option value="monthly">월별</option>
									  </select>
									  <input type="text" class="form-control" style="width: 30%" id="sdate" autocomplete="off">
									</div>
								</div>
							</div>
							<div class="col-md-6 text-right">
							  <button type="button" class="btn btn-success mr-2" onclick="start();"><i class="fas fa-search"></i>검색</button>  
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
								  <td class="text-right" id="generation">0 kW</td>
								  <th style="text-align: center;">충전량</th>
								  <td class="text-right" id="charge">0 kW</td>
								  <th style="text-align: center;">방전량</th>
								  <td class="text-right" id="discharge">0 kW</td>
								  <th style="text-align: center;">예상 수익</th>
								  <td class="text-right" id="benefit">0원</td>
								</tr>
							  </tbody>
							</table>
						</div>
					</div>
					<div class="row" ><!-- cont04 -->
						<div class="col-md-12 text-right mb-2"><button type="button" id="excelExport" onclick="excelDownload();" class="btn btn-primary btn-sm mr-2">엑셀다운</button><button type="button" id="printExport" onclick="content_print();" class="btn btn-primary btn-sm">프린트</button></div>
						<div class="table-area col-md-12" id="printarea">
							<div id="details_empty" style="text-align:center; font-size:22px; color:red; visibility:hidden;">데이터가 없습니다</div>
							<table class="table v2" id="details">
							  <thead>
								<tr>
								  <th rowspan="2">일자</th>
								  <th rowspan="2">태양광 발전량[kW]</th>
								  <th rowspan="2">충전량[kW]</th>
								  <th rowspan="2">방전량[kW]</th>
								  <th colspan="3">PV </th>
								  <th colspan="3">ESS</th>
								  <th rowspan="2">예상 수익 (원)</th>
								</tr>
								<tr>
								  <th>SMP 단가</th>
								  <th>가중치</th>
								  <th>수익</th>
								  <th>REC 단가</th>
								  <th>가중치</th>
								  <th>수익</th>
								</tr>
							  </thead>
							  <tbody id="benefit-list">
								
							  </tbody>
							</table>
							<div aria-label="Page navigation" id="navigation">
							  
							</div>

						</div>
					</div>
				</div>
			</div>
          </div>
          <form id="excelForm" action="/admin/statistics/benefit/downExcel" method="post">
          	<input type="hidden" name="data" id="data">
          	<input type="hidden" name="ptype" id="ptype" value="daily">
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
    <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script> -->  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
    <script src="/statics/js/bootstrap-datepicker.ko.min.js"></script>
    <!-- End custom js for this page-->
	<script>
	
	var closetime = 0;
	
	$(document).ready(function(){
		
		var sid = getCookie("sid");
		
		console.log("Sid:"+sid);
			
		if(!sid) sid = "";
		
		$('#sdate').datepicker({
         	minViewMode: "months",
         	format: 'yyyy-mm',
         	monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ]
        	 ,autoclose: true,
        	 language:'ko'
	       });
		//발전소 목록 조회
		
		var d = new Date();
		var dayOfMonth = d.getDate();
		var today = d.getFullYear() + "-" + ("" + (d.getMonth()+1)).padStart(2,"0"); 
		  	
		$("#sdate").datepicker("setDate", today);
		
		selectSite(sid, start);
		
		
		
	});
	
function selectPeriod(obj){
		
		if ($(obj).val() == 'daily'){
			
		/* 	$("#sdate").datepicker('option','dateFormat','yy-mm');
			var d = new Date();
			date = [
			  d.getFullYear(),
			  ('0' + (d.getMonth() + 1)).slice(-2)
			].join('-');
			
			$("#sdate").val(date); */
			
			initCalendar('yy-mm');
			
		} else {
		/* 	$("#sdate").datepicker('option','dateFormat','yy');
			var d = new Date();
			$("#sdate").val(d.getFullYear()); */
			initCalendar('yy');
		}
		
		$("#ptype").val($(obj).val());
	}
	
	var datepicker_default = null;
	
	
	function initCalendar(format){
		$('#sdate').datepicker('remove');
		console.log(format);
		
		if (!format || format == 'yy-mm'){
			
			$('#sdate').datepicker({
		         minViewMode: "months",
		         format: 'yyyy-mm',
		         autoclose: true,
		         language:'ko'
		       });
		} else {
			console.log("years picker");
		  $('#sdate').datepicker({
         	minViewMode: "years",
         	format: 'yyyy',
        	 autoclose: true,
        	 language:'ko'
	       });
		}
	}
	
	var datepicker_default = null;
	
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
	            yearSuffix : '',
	                viewMode: "years", 
	                minViewMode: "years"
	             
	           // showOn: 'both'
	            //buttonImage:'/resources/image/calendar.png',
	            //buttonImageOnly: true,
	             
	            //showButtonPanel: true
	        }
	      
	        datepicker_default.closeText = "선택";
	        datepicker_default.dateFormat = format;
	        datepicker_default.onClose = function (dateText, inst) {
	            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	            $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
	            $(this).datepicker('setDate', new Date(year, month, 1));
	        }
	      
	        datepicker_default.beforeShow = function () {
	            var selectDate = $("#sdate").val().split("-");
	            var year = Number(selectDate[0]);
	            var month = Number(selectDate[1]) - 1;
	            $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
	        }
	 
		$("#sdate").datepicker(datepicker_default);
		
		var d = new Date();
		date = [
		  d.getFullYear(),
		  ('0' + (d.getMonth() + 1)).slice(-2)
		].join('-');
		
		$("#sdate").val(date);
	}
	
	function start(){
		
		var sid = read_sid();
	
		var period = $("#period").val();
		var date = $("#sdate").val();
		
		read_statistics_benefit(sid,period, date, displayBenefit);
		displayCurrentTime();
	}
	
	var chartHandler;
	var sizePerPage = 10;
	
	function displayBenefit(period, datas){
		
		$("#benefit-list").html('');
		$("#data").val(JSON.stringify(datas));
		
		var generation = 0;
		var charge = 0;
		var discharge = 0;
		var benefit =0;
		
		var labels = [];
		var pv_benefits = [];
		var ess_benefits = [];
		var total_benefits = [];
		var pageSize = datas.data.length;
		
		for(i=0; i<datas.data.length ; i++) {

			var d = new Date(datas.data[i].reg_date);
			var strDate = '';
			if (period =='monthly'){
				strDate = d.getFullYear() + "년 " + ('0' + (d.getMonth() + 1)).slice(-2) +"월";
				labels.push(d.getFullYear() + "-" + ('0' + (d.getMonth() + 1)).slice(-2));
			} else {
				strDate = ('0' + (d.getMonth() + 1)).slice(-2) +"월 " +('0' + (d.getDate() )).slice(-2)+"일"
				labels.push(('0' + (d.getMonth() + 1)).slice(-2) +"-" +('0' + (d.getDate() )).slice(-2));
			}
			
			console.log(strDate);
			
			var item = "<tr>";
			item += '<td class="text-center">'+strDate+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].generation,3)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].charge,3)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].discharge,3)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].smp_price,2)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].smp_weight,0)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].pv_benefit,2)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].rec_price,2)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].rec_weight,0)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].rec_benefit,2)+'</td>';
			item += '<td class="text-right">'+$.number(datas.data[i].stotal_benefit,2)+'</td>';
			item += '</tr>';  
			
			$("#benefit-list").append(item);
			
			pv_benefits.push(datas.data[i].pv_benefit);
			ess_benefits.push(datas.data[i].rec_benefit);
			total_benefits.push(datas.data[i].stotal_benefit);
		}
		
		if(!datas.data || datas.data.length == 0) {
			var item = "<tr>";
			item += '<td class="text-center">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '<td class="text-right">-</td>';
			item += '</tr>'; 
			
			$("#benefit-list").append(item);
			
			$("button#excelExport,button#printExport").attr("disabled",true);
			$("button#excelExport,button#printExport").css("visibility","hidden");
			$("#details").css("visibility","hidden"); 
			$("#details_empty").css("visibility","visible");
		} else {
			$("button#excelExport,button#printExport").attr("disabled",false);
			$("button#excelExport,button#printExport").css("visibility","visible");
			$("#details").css("visibility","visible"); 
			$("#details_empty").css("visibility","hidden");
		}
		
		
		if(pageSize <= sizePerPage) {
			$("#navigation").attr("style","visibility:hidden");
		} else {
			$("#navigation").attr("style","visibility:");
		}
		
		$("#generation").text($.number(datas.info.sumGeneration,3) + " kW");
		$("#charge").text($.number(datas.info.sumCharge,3) + " kW");
		$("#discharge").text($.number(datas.info.sumDischarge,3) + " kW");
		$("#benefit").text($.number(datas.info.sumBenefit,2) + " 원");
		
		//displayNavigation();
		
		
		const mix = document.getElementById('mix').getContext('2d')

		if(chartHandler) {
			chartHandler.destroy();
		}
		
		chartHandler = new Chart(mix, {
		  type: 'bar',
			data: {
			  labels: labels,
			  datasets: [{
				  label: "ESS수익",
				  type: "line",
				  borderColor: "#ffd300",
				  data:ess_benefits,
				  fill: false,
				  backgroundColor: "#c4e9ff"
				}, 
				{
				  label: "PV수익",
				  type: "line",
				  borderColor: "#b5e004",
				  data: pv_benefits,
				  fill: false,
				  backgroundColor: "#b5e004"
				}, {
				  label: "예상 수익(원)",
				  type: "bar",
				  backgroundColor: "#0090b7",
				  data: total_benefits
				},
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
		    				labelString : '날짜 (date)'
		    			}
		    		  }],
		    		  yAxes: [{
		    			scaleLabel: {
		    				display: true,
		    				labelString : '수익 (원)'
		    			}
		    		  }]
		    	}
			}
		});
		
		
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
	
	function print_setLandscape() {
	    var css = '@page { size : landscape; };';
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
		var date = $("#sdate").val();
		
	    
    	var initBody = document.body.innerHTML;
    	window.onbeforeprint = function(){
    		print_setLandscape();
     		$("#printarea table *").css("font-size","5px");
     		document.body.innerHTML = document.getElementById("printarea").innerHTML;
    	}
    	window.onafterprint = function(){
     		document.body.innerHTML = initBody;
     		
     		initCalendar('yy-mm');
     		
     		$("#printarea table *").css("font-size","");
     		
     		$("#period").val(period);
     		$("#sdate").val(date);
     		
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