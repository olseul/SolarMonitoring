<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./header.jsp" %>
<%@ include file="./LNB.jsp" %>
    <%
    String msg = request.getParameter("msg");
    String siteId = request.getParameter("siteId");
    String sid = (String)request.getAttribute("sid");
   
    %>

  <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
            <!-- Page Title Header Starts-->
            <div class="row page-title-header">
              <div class="col-12">
                <div class="page-header">
                  <h4 class="page-title">HOME | 대시보드</h4>
				  <div class="reload"><a href="javascript:start();"><i class="fas fa-sync-alt"></i></a><span id="current-time">2020.3.19 15:27:43</span></div>
                </div>
              </div>
            </div>
            <!-- Page Title Header Ends-->
            <div class="row"><!-- cont01 -->
              <div class="col-md-8 grid-margin stretch-card">
                <div class="card">
                  <div class="card-header"><h4 class="card-title mb-0">날씨</h4></div>
				  <div class="card-body">
					  <div class="row">
						  <div class="col-md-3 weather-area01">
						  	<div id="weather-info0" ><div class="weather-icon01" ><img src="assets/images/weather1.png" alt="weather" /></div><div>흐림</div></div>
						  </div>
						  <div class="col-md-3">
							  <div class="weather-area02">
								<div><span>온도</span><strong id="weather-temperature">0 <em>℃</em></strong></div>
								<div><span>습도</span><strong id="weather-humidity">0 <em>%</em></strong></div>
							  </div>
						  </div>
						  <div class="col-md-3">
								<div class="weather-area03">
								 <div><div class="weather-icon02"><img src="/statics/assets/images/weather_wind.png" alt="weather" /></div><div >바람<br><span id="weather-wind">0</span>km/h</div></div>
								 <div><div class="weather-icon02"><img src="/statics/assets/images/weather7.png" alt="weather" /></div><div>적설<br><span id="weather-snow">0</span>cm</div></div>
								</div>
						  </div>
						  <div class="col-md-3">
							  <div class="weather-area04">
								<div  id="weather-info1"><div class="weather-icon03" ><img src="assets/images/weather4.png" alt="weather" /></div><div>내일</div></div>
								<div  id="weather-info2"><div class="weather-icon03"><img src="assets/images/weather5.png" alt="weather" /></div><div>모레</div></div>
							  </div>
						  </div>
					  </div>
                  </div>
                </div>
              </div>
              <div class="col-md-4 grid-margin stretch-card">
                <div class="card">
                  <div class="card-header"><h4 class="card-title mb-0">설비 동작상태</h4></div>
				  <div class="card-body">
                    <div class="row play-state">
						<div class="col-md-6"><h5><i class="fas fa-hdd"></i>SERVER</h5></div>
						<div class="col-md-6"><span><button class="ok" id="server-ok">OK</button><button disabled class="ng" id="server-ng">NG</button></span></div>
					</div>
					<div class="row play-state">
						<div class="col-md-6"><h5><i class="fas fa-server"></i>ESS</h5></div>
						<div class="col-md-6"><span><button disabled class="ok" id="ess-ok">OK</button><button class="ng" id="ess-ng">NG</button></span></div>
					</div>
                  </div>
                </div>
              </div>
            </div>
			<div class="row"><!-- cont02 -->
				<div class="col-md-12 grid-margin stretch-card user-info">
					<div class="card">
						<div class="card-header"><h4 class="card-title mb-0">태양광</h4></div>
						
						<div class="card-body" id="dashboard-list">
							
						</div>
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
    <!-- container-scroller -->
    
    <script src="/statics/js/api_admin.js"></script>
    <script src="/statics/js/api_common.js"></script>
	<script>
	
		
		
		$(document).ready(function(){
		
			start();
		});
		
		
		function start(){
			read_weather();
			read_dashboard_state(displayState);
			read_dashboard_total(displayTotal);
			//read_dashboard_subtotal(displaySubtotal);
			
			displayCurrentTime();
		}
		
		function displayState(datas){
			
			if (datas.server){
				$('#server-ok').prop("disabled", false);
				$('#server-ng').prop("disabled", true);
			} else {
				$('#server-ok').prop("disabled", true);
				$('#server-ng').prop("disabled", false);
			}
			
			if (datas.ess){
				$('#ess-ok').prop("disabled", false);
				$('#ess-ng').prop("disabled", true);
			} else {
				$('#ess-ok').prop("disabled", true);
				$('#ess-ng').prop("disabled", false);
			}
		}
		
		function displayTotal(datas){
			
			
			
			if (datas){
				
				for(i=0; i<datas.length; i++){
					
					var site='<div class="user-info-box">';
					site+='	<h5><i class="fas fa-industry"></i>'+datas[i].info.name+'</h5>';
					site+='	<a href="#" class="open-new"><i class="fas fa-external-link-alt"></i></a>';
					site+='	<div class="row play-state">';
					site+='		<div class="col-md-4">';
					site+='			<div id="play1" class="canvasCont text-center">';
					site+='				<div class="total-graph-rate"><strong>'+$.number(datas[i].info.sum_capacity,2)+'</strong>kw</div>';
					site+='				<canvas id="play'+i+'Chart" width="250" height="250" style="display: inline-block;"></canvas>';
					site+='			</div>';
					site+='			<div class="totle-kwh">';
					site+='				<div><span>총 현재 출력</span><span><strong>'+$.number(datas[i].info.sum_output,2)+'</strong>kWh</span></div>';
					site+='				<div><span>총 오늘 발전량</span><span><strong>'+$.number(datas[i].info.sum_generate,2)+'</strong>kWh</span></div>';
					site+='			</div>';
					site+='		</div>';
					site+='		<div class="col-md-8"><canvas id="line-chart'+i+'"></canvas></div>';
					site+='	</div>';
					site+='</div>';
					
					$("#dashboard-list").append(site);
					
					var rate1 = datas[0].info.generate_percent;
					
					createChart(getData(rate1),'play'+i);
					
					
					var chart_labels = [];
					var chart_today = [];
					var chart_yesterday = [];
					
					for(ii=0; ii<datas[i].chart_today.length ; ii++){
						var regStr = datas[i].chart_today[ii].reg_date.split(" ")[1].split(":");
						chart_labels.push(regStr[0]+"시 " + regStr[1]+"분");
						
						chart_today.push(datas[i].chart_today[ii].sum_generate);
					}
					
				/* 	for(ii=0; ii<datas[i].chart_yesterday.length ; i++){
						var regStr = datas[i].chart_yesterday[ii].reg_date.split(" ")[1].split(":");
					//	chart_labels.push(regStr[0]+"시 " + regStr[1]+"분");
						
						chart_yesterday.push(datas[i].chart_yesterday[ii].sum_generate);
					} */
					
					//line
					var config = {
					type: 'line',
					data: {
						labels: chart_labels,//['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24'],
						datasets: [{
							label: '오늘발전량',
							fill: false,
							backgroundColor: window.chartColors.blue,
							borderColor: window.chartColors.blue,
							data: chart_today,
						}/* , {

							label: '어제발전량',
							backgroundColor: window.chartColors.red,
							borderColor: window.chartColors.red,
							data: chart_yesterday,
							fill: true,
						} */
						
						]
						},
						options: {
							responsive: true,
							tooltips: {
								mode: 'index',
								intersect: false,
							},
							hover: {
								mode: 'nearest',
								intersect: true
							},
							scales: {
								xAxes: [{
									display: true,
									scaleLabel: {
										display: true,
									}
								}],
								yAxes: [{
									display: true,
									scaleLabel: {
										display: true,
									}
								}]
							}
						}
					};
					
					var ctx = document.getElementById('line-chart'+i).getContext('2d');
					new Chart(ctx, config);
					
					
				}
								

				
			}
		}
		
		function displaySubtotal(datas){
			
			if (datas){
				
				for (i=0; i<datas.length && i<3; i++){
					
					$("chart-name-"+0).text(datas[i].name);
					/* $("output-"+0).text(datas[i].name);
					$("chart-name-"+0).text(datas[i].name); */
					
					var chart_labels = [];
					var chart_datas = [];
					
					for(j=0; j<datas[i].chartdata.length;j++){
						chart_labels.push(datas[i].chartdata[j].key);
						chart_datas.push(datas[i].chartdata[j].value);
					}
					
					var ctx = document.getElementById("linechart"+i);
					var myChart = new Chart(ctx, {
					  type: 'bar',
					  data: {
						labels: chart_labels,
						datasets: [{
						  data: chart_datas,
						  backgroundColor: '#ffc000'

						}]
					  },
					  options: {
						legend: false,  
						responsive: true,
						scales: {
						  xAxes: [{
							ticks: {
							  maxRotation: 10,
							  minRotation: 5
							}
						  }],
						  yAxes: [{
							ticks: {
							  beginAtZero: true
							}
						  }]
						}
					  }
					});
					
				}
			}
			
		}
		
		//canvas

		



		function getData(rate){
		  var leftover = 100- rate;

		  var data = {

			  datasets: [
				  {
					  data: [rate, leftover],
					  backgroundColor: [
						  "#da1b6c",
						  //"#c0c0c0"
						  "#7f7f7f"
					  ]
				  }]
		  };
		  return data;
		}

		function createChart(data, id){
		  //activate chart.js
			//var ctx = document.getElementById('playPerc');
		  var ctx = document.getElementById(id+"Chart");
			//use data and options
			var playPerc = new Chart(ctx, {
			  type: 'doughnut',
			  data: data,
			  options: {
				  //options defined
				  responsive: false,
				  cutoutPercentage: 80,
				  legend: false,
				  layout: {padding: 10},
				  tooltips: {enabled: false},
				  elements: {arc: { borderWidth: 0}},
				  animation: {onComplete: function() {
					  //this.ctx.fillText("test%", 75, 75, 75);
					  //alert("Finished!");
					  document.getElementById(id).insertAdjacentHTML('beforeend',"<span>"+data.datasets[0].data[0]+"%</span>");
					}
				  }
				}
			});

		}


	//bar01
		
	
	//bar02
		
	/* var ctx = document.getElementById("linechart2");
	var myChart = new Chart(ctx, {
	  type: 'bar',
	  data: {
		labels: ["1", "3", "5", "9", "13", "15", "17", "19", "21", "23", "25"],
		datasets: [{
		  data: [5, 5, 3, 5, 2, 3, 5, 3, 5, 6, 2, 1],
		  backgroundColor: '#ffc000'

		}]
	  },
	  options: {
		legend: false,  
		responsive: true,
		scales: {
		  xAxes: [{
			ticks: {
			  maxRotation: 10,
			  minRotation: 5
			}
		  }],
		  yAxes: [{
			ticks: {
			  beginAtZero: true
			}
		  }]
		}
	  }
	});
	//bar03
		
	var ctx = document.getElementById("linechart3");
	var myChart = new Chart(ctx, {
	  type: 'bar',
	  data: {
		labels: ["1", "3", "5", "9", "13", "15", "17", "19", "21", "23", "25"],
		datasets: [{
		  data: [5, 5, 3, 5, 2, 3, 5, 3, 5, 6, 2, 1],
		  backgroundColor: '#ffc000'

		}]
	  },
	  options: {
		legend: false,  
		responsive: true,
		scales: {
		  xAxes: [{
			ticks: {
			  maxRotation: 10,
			  minRotation: 5
			}
		  }],
		  yAxes: [{
			ticks: {
			  beginAtZero: true
			}
		  }]
		}
	  }
	}); */
	
 
	</script>
  </body>
</html>