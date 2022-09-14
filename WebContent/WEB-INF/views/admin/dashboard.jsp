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
				  <div class="reload"><a><i class="fas fa-sync-alt"></i></a><span style="font-size:15px; font-weight:bold;">페이지 갱신 시각 : </span><span id="current-time">----.-.-- --:--:--</span></div>
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
						  	<div id="weather-info0" ><div class="weather-icon01" ><img src="/statics/assets/images/weather0.png" alt="weather" /></div><div></div></div>
						  </div>
						  <div class="col-md-3">
							  <div class="weather-area02">
								<div><span>온도</span><strong id="weather-temperature">- <em> ℃</em></strong></div>
								<div><span>습도</span><strong id="weather-humidity">- <em> %</em></strong></div>
							  </div>
						  </div>
						  <div class="col-md-3">
								<div class="weather-area03">
								 <div><div class="weather-icon02"><img src="/statics/assets/images/weather2.png" style="width:46px;height:46px;" alt="weather" /></div><div>풍속<br><span id="weather-wind">-</span> km/h</div></div>
								 <div><div class="weather-icon02"><img src="/statics/assets/images/weather7.png"  style="width:46px;height:46px;" alt="weather" /></div><div>적설<br><span id="weather-snow">-</span> cm</div></div>
								</div>
						  </div>
						  <div class="col-md-3">
							  <div class="weather-area04">
								<div  id="weather-info1"><div class="weather-icon03" ><img src="/statics/assets/images/weather0.png" alt="weather" /></div><div>내일</div></div>
								<div  id="weather-info2"><div class="weather-icon03"><img src="/statics/assets/images/weather0.png" alt="weather" /></div><div>모레</div></div>
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
						<div class="col-md-6"><span><button disabled class="ok" id="server-ok" style="cursor:default;">OK</button><button class="ng" id="server-ng" style="cursor:default;">NG</button></span></div>
					</div>
					<div class="row play-state">
						<div class="col-md-6"><h5><i class="fas fa-server"></i>ESS</h5></div>
						<div class="col-md-6"><span><button disabled class="ok" id="ess-ok" style="cursor:default;">OK</button><button class="ng" id="ess-ng" style="cursor:default;">NG</button></span></div>
					</div>
                  </div>
                </div>
              </div>
            </div>
			<div class="row"><!-- cont02 -->
				<div class="col-md-12 grid-margin stretch-card">
					<div class="card">
						<div class="card-header"><h4 class="card-title mb-0">태양광</h4></div>
						<div class="card-body">
							<div class="loading-panel">
							<img class="loading-icon" src="/statics/assets/images/89.png"/>
							</div>
							<!-- <a href="#" class="open-new"><i class="fas fa-external-link-alt"></i></a> -->
							<div class="row play-state">
								<div class="col-md-4">
									<div id="play" class="canvasCont text-center">
										<div class="total-graph-rate"><strong id="sum-capacity">0</strong> kW</div>
										<canvas id="playChart" width="400" height="400" style="display: inline-block; width:50%; height:50%;"></canvas>
									</div>
									<div class="totle-kwh">
										<div><span>순간 발전량 합계</span><span><strong id="sum-output">0</strong> kW</span></div>
										<div><span>오늘 발전량 합계</span><span><strong id="sum-generate">0</strong> kW</span></div>
									</div>
								</div>
								<div class="col-md-8"><canvas id="canvas" width="1000" height="390"></canvas></div> 
							</div>
						</div> 
					</div>
				</div>
			</div>
			<small style="color:#ffffff;">등록된 발전소를 발전소 3개 단위로 정보를 하단에 표시합니다.</small>
			<small style="color:#ffffff;">(5초마다 다른 발전소 정보로 순차적으로 변경되어 표시됩니다.)</small>  
			<div class="row"><!-- cont03 -->
				<div class="col-md-4 grid-margin stretch-card" id="chart-card-0">
					<div class="card">
						<div class="vcard-header text-center"><h4 class="card-title mb-0" id="chart-name-0"></h4></div>
						<div class="sub-card-body text-center">
							<canvas id="linechart0" width="*" height="100"></canvas>
							<div class="totle-kwh v1">
								<div><span>순간 발전량</span><span><strong id="output-0">0</strong> kW</span></div>
								<div><span>누적 발전량</span><span><strong id="generation-0">0</strong> kW</span></div>
							</div>
						</div>
					</div> 
				</div>
				<div class="col-md-4 grid-margin stretch-card"  id="chart-card-1">
					<div class="card">
						<div class="vcard-header text-center"><h4 class="card-title mb-0" id="chart-name-1"></h4></div>
						<div class="sub-card-body text-center">
							<canvas id="linechart1" width="*" height="100"></canvas>
							<div class="totle-kwh v1">
								<div><span>순간 발전량</span><span><strong id="output-1">0</strong> kW</span></div>
								<div><span>누적 발전량</span><span><strong id="generation-1">0</strong> kW</span></div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4 grid-margin stretch-card"  id="chart-card-2">
					<div class="card">
						<div class="vcard-header text-center"><h4 class="card-title mb-0" id="chart-name-2"></h4></div>
						<div class="sub-card-body text-center">
							<canvas id="linechart2" width="*" height="100"></canvas>
							<div class="totle-kwh v1">
								<div><span>순간 발전량</span><span><strong id="output-2">0</strong> kW</span></div>
								<div><span>누적 발전량</span><span><strong id="generation-2">0</strong> kW</span></div>
							</div>
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
	
		
		var state_intervalHandler;
		$(document).ready(function(){
		
			setInterval(function(){ start(); }, 15 * 60 * 1000);
			start();
		});
		
		
		function start(){
			read_weather();
			read_dashboard_state(displayState);
			read_dashboard_total(displayTotal);
			read_dashboard_subtotal(displaySubtotal);
			
			displayCurrentTime();
			
			clearInterval(state_intervalHandler);
			setInterval(function() { read_dashboard_state(displayState); }, 60 * 1000);
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
			
			if (datas != undefined){
				var rate1 = datas.info.generate_percent;
	
				createChart(getData(rate1),'play');
				
				$("#sum-capacity").text($.number(datas.info.sum_capacity,1));
				$("#sum-generate").text($.number(datas.info.sum_generate,3)); // 1
				$("#sum-output").text($.number(datas.info.sum_output,3)); // 2
				
				var chart_labels = [];
				var chart_today = [];
				var chart_yesterday = [];
				
				for(i=0; i<datas.chart_today.length ; i++){
					var regStr = datas.chart_today[i].reg_date.split(" ")[1].split(":");
					chart_labels.push(regStr[0]+"시 " + regStr[1]+"분");
					
					chart_today.push(datas.chart_today[i].generation);
				}
				
				var bLabelEmpty = false;
				if (chart_labels.length == 0){
					bLabelEmpty = true;
				}
				
				for(i=0; i<datas.chart_yesterday.length ; i++){
					var regStr = datas.chart_yesterday[i].reg_date.split(" ")[1].split(":");
					
					if (bLabelEmpty){
						var regStr = datas.chart_yesterday[i].reg_date.split(" ")[1].split(":");
						chart_labels.push(regStr[0]+"시 " + regStr[1]+"분");
					}
					
				//	chart_labels.push(regStr[0]+"시 " + regStr[1]+"분");
					
					chart_yesterday.push(datas.chart_yesterday[i].generation);
				}
				
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
					}, {

						label: '어제발전량',
						fill: true,
						backgroundColor: window.chartColors.red,
						borderColor: window.chartColors.red,
						data: chart_yesterday,
					}]
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
									labelString : '시 (Hour)'
								}
							}],
							yAxes: [{
								display: true,
								scaleLabel: {
									display: true,
									labelString : '발전량 (kW)'
								}
							}]
						}
					}
				};
				
				var ctx = document.getElementById('canvas').getContext('2d');
				if (window.myLine) window.myLine.destroy();
				window.myLine = new Chart(ctx, config);

				
			}
		}
		
		var viewCount=0;
		
		
		var mycharts = [];
		
		var timeoutHandler;
		
		function displaySubtotal(datas, viewC){
			clearTimeout(timeoutHandler);
			
			if (!viewC){
				viewCount = 0;
			}
			
			if (datas){
				
				console.log("subotal:" + datas.length);
				console.log("viewCount:" + viewCount);
				
				var startIndex = viewCount*3;
				
				if (startIndex >= datas.length){
					startIndex = 0;
					viewCount = 0;
				}
				
				for(i=0;i<mycharts.length; i++){
					if (mycharts[i]) mycharts[i].destroy();
				}
				
				mycharts = [];
				
				$("#chart-card-0").hide();
				$("#chart-card-1").hide();
				$("#chart-card-2").hide();
				
				for (i=startIndex; i<datas.length && i<startIndex + 3; i++){
					
					var index = i%3;
					
					$("#chart-card-"+index).show();
					
					$("#chart-name-"+index).text(datas[i].info.name);
					/* $("output-"+0).text(datas[i].name);
					$("chart-name-"+0).text(datas[i].name); */
					
					$("#output-"+index).html($.number(datas[i].info.current,3)); // 2
					$("#generation-"+index).html($.number(datas[i].info.accu_energy,3)); // 1
					
					var chart_labels = [];
					var chart_datas = [];
					
					for(j=0; j<datas[i].chart_data.length;j++){
						chart_labels.push(datas[i].chart_data[j].key);
						chart_datas.push(datas[i].chart_data[j].value);
					}
					
					var ctx = document.getElementById("linechart"+index);
					var mychart = new Chart(ctx, {
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
							scaleLabel: {
								display: true,
								labelString : '시 (Hour)'
							},
							ticks: {
							  maxRotation: 10,
							  minRotation: 5
							}
						  }],
						  yAxes: [{
							 scaleLabel: {
								display: true,
								labelString : '발전량 (kW)'
							 },
							 ticks: {
							  beginAtZero: true
							}
						  }]
						}
					  }
					});
					
					mycharts.push(mychart);
					
				}
				
			
				timeoutHandler = setTimeout(function(){ 
						viewCount++;
						displaySubtotal(datas,viewCount);
						},
					5000);
			
				
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
		var playPerc = null;
		function createChart(data, id){
		  //activate chart.js
			//var ctx = document.getElementById('playPerc');
		  
		  if(playPerc != null) playPerc.destroy();
		  
		  var ctx = document.getElementById(id+"Chart");
			//use data and options
		  playPerc = new Chart(ctx, {
			  type: 'doughnut',
			  data: data,
			  options: {
				  //options defined
				  responsive: false,
				  cutoutPercentage: 70,
				  legend: false,
				  layout: {padding: 10},
				  tooltips: {enabled: false},
				  elements: {arc: { borderWidth: 0}},
				  animation: {onComplete: function() {
					  //this.ctx.fillText("test%", 75, 75, 75);
					  //alert("Finished!");
					  $("#play > span").remove();
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