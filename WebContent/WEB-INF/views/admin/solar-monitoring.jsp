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
                  <h4 class="page-title">HOME | 태양광 | 모니터링</h4>
				  <div class="reload"><a><i class="fas fa-sync-alt"></i></a><span style="font-size:15px; font-weight:bold;">페이지 갱신 시각 : </span><span id="current-time">----.--.-- --:--:--</span></div>
                </div>
              </div>
            </div>
            <!-- Page Title Header Ends-->
			<div class="row">
				<div class="w-box">
					<div class="row"><!-- cont01 -->
						
						<div class="col-md-2 col-lg-6 col-xl-6">
							<div class="map-area">
								<div class="map-img" id="map-canvas" style="width:100%; height:100%; z-index:1;"/></div>
								<div class="map-layer-wrap">
									<div class="map-layer">
										<div class="map-info" style="z-index:2">
											<li id="temperature_panel">패널 온도: - ℃</li>
											<li id="temperature_atmosphere">대기 온도: - ℃</li>
											<li id="illumination_panel_horizontal">수평 일사량: - w/㎡</li>
											<li id="illumination_panel_slope">경사 일사량: - w/㎡</li>
										</div>
										<div class="balloon-area" style="position: absolute; top: 10px; left: 10px"></div>
										<!-- <div class="map-type-change">
											<button id="maptype_normal" onclick="changeMapType('NORMAL')">NormalMap</button>
											<button id="maptype_hybrid" onclick="changeMapType('HYBRID')">HybridMap</button>
										</div> -->
									</div>
								</div>
								
							</div>
						</div>
						<div class="site-info col-md-10 col-lg-6 col-xl-6">
							<div class="loading-panel">
								<img class="loading-icon" src="/statics/assets/images/89.png"/> 
							</div>
						
							<div class="row">
								<div id="play" class="canvasCont text-center col-12 col-sm-12 col-md-7 col-lg-6 col-xl-6" style="align-self:center;">
									<div class="total-graph-rate col-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="font-size:3vh; margin-bottom:5px;"><strong id="sum_capacity"></strong> kw</div>
									<canvas id="playChart_solar" height="250" style="display:block;"></canvas>
									<span id="playChart-val" class="col-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="font-size:2vh; padding-top:3vh;"></span>
									
								</div>
								<div class="totle-kwh col-5 col-sm-5 col-md-5 col-lg-6 col-xl-6 mt-5">
									<div><span>어제 발전량</span><span><strong id="sum_generate_yesterday"></strong> kW</span></div>
									<div><span>오늘 발전량</span><span><strong id="sum_generate_today"></strong> kW</span></div>
								</div>
							</div>
							<table class="table v5" style="width:100%; font-size:32px;">
								<colgroup>
									<col width="30%">
									<col width="*">
								</colgroup>
								<tbody>
								<tr>
									<th>순간발전량</th>
									<td><strong id="sum_output"></strong> kW</td>
								</tr>
								<tr>
									<th>누적발전량</th>
									<td><strong id="sum_accuenergy"></strong> kW</td>
								</tr>
								</tbody>
							</table>
							<div class="detail-area">
								<h6>인버터별 상세</h6>
								<div class="detail-scroll">
									<div class="row" id="chart-list"><!-- cont03 -->
										
									
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row"><!-- cont02 -->
						<div class="text-right">
							<ul class="nav nav-pills mb-3 mt-5" id="pills-tab" role="tablist">
							  <li class="nav-item" role="presentation">
								<a class="nav-link active" id="pills-graph01-tab" data-toggle="pill" href="#pills-graph01" role="tab" aria-controls="pills-graph01" aria-selected="true">오늘</a>
							  </li>
							  <li class="nav-item" role="presentation">
								<a class="nav-link" id="pills-graph02-tab" data-toggle="pill" href="#pills-graph02" role="tab" aria-controls="pills-graph02" aria-selected="false">일별</a>
							  </li>
							  <li class="nav-item" role="presentation">
								<a class="nav-link" id="pills-graph03-tab" data-toggle="pill" href="#pills-graph03" role="tab" aria-controls="pills-graph03" aria-selected="false">월별</a>
							  </li>
							</ul>
						</div>
						<div class="tab-content graph-area" id="pills-tabContent" >
						  <div class="tab-pane fade show active" id="pills-graph01" role="tabpanel" aria-labelledby="pills-graph01-tab"  style="position: relative; height: 500px">
						  	<div class="no-loading-panel">
							  <img class="loading-icon" src="/statics/assets/images/89.png"/> 
						    </div>
						  	<canvas id="canvas-today" width="*" height="200"></canvas>
						  </div>
						  <div class="tab-pane fade" id="pills-graph02" role="tabpanel" aria-labelledby="pills-graph02-tab" style="position: relative; height: 500px"><canvas id="canvas-daily" width="*" height="200"></canvas></div>
					 	  <div class="tab-pane fade" id="pills-graph03" role="tabpanel" aria-labelledby="pills-graph03-tab" style="position: relative; height: 500px"><canvas id="canvas-monthly" width="*" height="200"></canvas></div>
						</div>
						<div>
							<p style="font-size:8pt; color:red;"> 마이너스 발전량 발생하는 경우, 서로 다른 누적발전량이 반복 전송되어 누적발전량 사이의 차를 표시하는 상태입니다.<br>트랙커 제어기와 인버터 간 배선을 확인해 주세요.</p>
						</div>
					</div>
				</div>
			</div>
          </div>
    <!-- container-scroller -->
    <!-- plugins:js -->
 <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=36d5b7cc4e118b280950b289f51126b6&libraries=services,clusterer,drawing"></script>

    <!-- End custom js for this page-->
	<script>
	
	
	$(document).ready(function(){
		
		var sid = getCookie("sid");
		
		console.log("Sid:"+sid);
			
		if(!sid) sid = "";
		
		//발전소 목록 조회
		selectSite(sid, start);
		
		setInterval(function(){ start(); }, 15 * 60 * 1000);
		
		

		
	});
	
	function start(){
		
		var sid = getCookie("sid");
		if (!sid ) {
			sid = $("#site-select").val();
			setCookie("sid", sid);
		}
		
		//window.myLine = new Chart(document.getElementById('canvas-today').getContext('2d'), { type : 'line', data : {} } );

		read_mapdata(sid, displayMapdata);
		read_localsensor(sid, displayLocalsensor);
		read_sitegeneration(sid, displaySiteGeneration);
		read_invertersgeneration(sid, displayInvertersGeneration);
		read_chartdata(sid, displayChartData);
		
		displayCurrentTime();
	}
	
	
	
	
	function displayMapdata(datas){
		console.log("displayMapdata~" );
		console.log(datas);	

      if (datas.mapdata.latitude && datas.mapdata.latitude != '0' && datas.mapdata.longitude && datas.mapdata.longitude != '0' ){
    	  
    	
	      var   mapCenter = new kakao.maps.LatLng( datas.mapdata.latitude, datas.mapdata.longitude);
	         
	      	document.getElementById('map-canvas').innerHTML = "";
	         var mapContainer = document.getElementById('map-canvas'), // 지도를 표시할 div
		          mapOption = {
		            center: mapCenter, // 지도의 중심좌표
		            level: 2 // 지도의 확대 레벨
		          };
	
	         map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	         map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);
	         
	         var marker = new kakao.maps.Marker({
           	  position: mapCenter
             });
	         marker.setMap(null);
             
             marker.setMap(map);
	         
      } else {
    	  var address = datas.mapdata.address + " " + datas.mapdata.address2;
    	  
    	  geocoder.addressSearch(address, function (result, status) {

              // 정상적으로 검색이 완료됐으면
              if (status === kakao.maps.services.Status.OK) {

                  var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                  $("#lat").val(result[0].y); 
                  $("#lng").val(result[0].x);
                  console.log("lat:" + result[0].y);
                  console.log("lng:" + result[0].x);
                  
                 
     	         
     	         var mapContainer = document.getElementById('map-canvas'), // 지도를 표시할 div
     		          mapOption = {
     		            center: coords, // 지도의 중심좌표
     		            level: 2 // 지도의 확대 레벨
     		          };
     	
                  
                  map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
     	         map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);                  
              } else {
            	  alert("주소의 위치를 찾을 수 없습니다.\n"+address);
              }
         });
      }         
			
	}
	
	function displayLocalsensor(datas){
		console.log("displayLocalsensor~" + datas); 
		
		
		$("#temperature_panel").text('패널 온도: '+datas.temperature_panel+' ℃');
		$("#temperature_atmosphere").text('대기 온도: '+datas.temperature_atmosphere+' ℃');
		$("#illumination_panel_horizontal").text('수평 일사량: '+datas.illumination_panel_horizontal+' w/㎡');
		$("#illumination_panel_slope").text('경사 일사량: '+datas.illumination_panel_slope+' w/㎡');
		
			
	}
	
	function displaySiteGeneration(datas){
		console.log("displaySiteGeneration~" + datas);
	   
	    $("#sum_capacity").text($.number(datas.sum_capacity,1));
	    $("#sum_output").text($.number(datas.sum_output,3)); // .2
	    $("#sum_generate_today").text($.number(datas.sum_generate_today,3)); //.1
	    //$("#generate_percent").text(datas.generate_percent);
	    $("#sum_accuenergy").text($.number(datas.sum_accuenergy,3)); // .1
	    $("#sum_generate_yesterday").text($.number(datas.sum_generate_yesterday,3)); //.1
	    
		
	    var rate1 = datas.generate_percent;
	    
	    console.log("rate1:" + rate1);

		createChart(getData(rate1),'play');



			
	}
	
	function displayInvertersGeneration(datas){
		console.log("displayInvertersGeneration~");
		console.log( datas);
		
		 $("#chart-list").html("");
			 
		
		if (datas) {
			
			for (i=0; i<datas.length; i++){
				
				var id = datas[i].id;
				
				
				
				var chart_html = '<div class="col-md-6">';
				 chart_html += '<div class="text-center">';
				 chart_html += '	<div class="totle-kwh v1">';
				 chart_html += '		<div><span>'+datas[i].info.name+'</span><span>'+$.number(datas[i].info.current_output,3)+' kW / '+$.number(datas[i].info.capacity,2)+' kW</span></div>';
				 chart_html += '	</div>';
				 chart_html += '	<canvas id="linechart'+i+'" width="*" height="100"></canvas>';
				 chart_html += '	<div class="totle-kwh v1">';
				 chart_html += '		<div><span>순간발전량</span><span><strong>'+$.number(datas[i].info.current_output,3)+' </strong> kW</span></div>';
				 chart_html += '		<div><span>누적발전량</span><span><strong>'+$.number(datas[i].info.accu_energy,3)+' </strong> kW</span></div>';
				 chart_html += '	</div>';
				 chart_html += '</div>';
				 chart_html += '</div>';
			
				 
				 $("#chart-list").append(chart_html);
			
				
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
						},
						scaleLabel: {
							display: true,
							labelString : '시 (Hour)'
						}
					  }],
					  yAxes: [{
						ticks: {
						  beginAtZero: true
						  //max : (datas[i].info.capacity != null ? datas[i].info.capacity : 0)
						},
						scaleLabel: {
							display: true,
							labelString : '발전량 (kW)'
						}
					  }]
					}
				  }
				});
				
		
				
				
			}
		}
		
			
	}
	
	function displayChartData(datas){
		console.log("displayChartData~" + datas);
		
		var today_labels = [];
		var today_yst = [];
		var today_today = [];
		var today_lastyear = [];
		
		
		var daily_labels = [];
		var daily_lastyear = [];
		var daily_thismonth = [];
		var daily_lastmonth = [];
		
		var monthly_labels = [];
		var monthly_lastyear = []; 
		var monthly_thisyear = [];
		
		
		if(datas.today != undefined) {
			for (i=0; i<23; i++){
				var hour = i+1;
				hour = hour<10 ? "0"+hour : hour+"";
				today_labels.push(hour+"시 " + "00분");
				
				var val_lastyear = '0';
				var val_yesterday = '0';
				var val_today ='0';
				
				 for(ii=0; ii<datas.today.lastyear.length; ii++){
	
					var regStr = datas.today.lastyear[ii].reg_date.split(" ")[1].split(":");
					//today_labels.push(regStr[0]+"시 " + regStr[1]+"분");
				
					if ( hour == regStr[0]){
						val_lastyear = datas.today.lastyear[ii].generation;//sum_generate;
						break;
					} 
				}
				 
				today_lastyear.push(val_lastyear);
				 
			 	for(ii=0; ii<datas.today.yesterday.length; ii++){
					
					var regStr = datas.today.yesterday[ii].reg_date.split(" ")[1].split(":");
					//today_labels.push(regStr[0]+"시 " + regStr[1]+"분");
					
					if ( hour == regStr[0]){
						val_yesterday = datas.today.yesterday[ii].generation;//sum_generate;
						break;
					} 		
				}
			 	
			 	today_yst.push(val_yesterday);
			 	
				for(ii=0; ii<datas.today.today.length; ii++){
					
					var regStr = datas.today.today[ii].reg_date.split(" ")[1].split(":");
					//today_labels.push(regStr[0]+"시 " + regStr[1]+"분");
					
					if ( hour == regStr[0]){
						val_today = datas.today.today[ii].generation;//sum_generate;
						break;
					} 
				}
				
				today_today.push(val_today);
				
			}
			
			console.log("today_yst:" + JSON.stringify(today_yst));
			
			var config_today = {
					type: 'line',
					data: {
						labels: today_labels,
						datasets: [{
							label: '오늘발전량',
							fill: false,
							backgroundColor: window.chartColors.blue,
							borderColor: window.chartColors.blue,
							data: today_today,
						}, {

							label: '어제발전량',
							backgroundColor: window.chartColors.red,
							borderColor: window.chartColors.red,
							data: today_yst,
							fill: false,
						},{

							label: '지난해발전량',
							backgroundColor: window.chartColors.green,
							borderColor: window.chartColors.green, 
							data: today_lastyear,
							fill: true,
						}
						]
						},
						options: {
							responsive: true,
							maintainAspectRatio: false,
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
			
			if(window.myLine != undefined){
				window.myLine.destroy(); 
		    }
			
			var ctx = document.getElementById('canvas-today').getContext('2d');
			
			window.myLine = new Chart(ctx, config_today);
		}
		
		if(datas.daily != undefined) {
			for (i=0; i<31 ; i++) {
				
				var day = i+1;
				day = day<10? "0"+day : day+"";
				
				daily_labels.push(day+"일");
				
				var val_lastyear = '';
				var val_lastmonth = '';
				var val_thismonth = '';
				
				for(ii=0; ii<datas.daily.lastyear.length; ii++){
					//	console.log("reg_date_day:" + datas.daily.lastyear[i].reg_date_day);	
					var regStr = datas.daily.lastyear[ii].reg_date.split("-");
										
					if (day == regStr[2]){
						val_lastyear = datas.daily.lastyear[ii].generation;
						break;
					}
						
				}
				
				daily_lastyear.push(val_lastyear);
				
				for(ii=0; ii<datas.daily.lastmonth.length; ii++){
					//	console.log("reg_date_day:" + datas.daily.lastyear[i].reg_date_day);	
					var regStr = datas.daily.lastmonth[ii].reg_date.split("-");
										
					if (day == regStr[2]){
						val_lastmonth = datas.daily.lastmonth[ii].generation;
						break;
					}
						
				}
				
				daily_lastmonth.push(val_lastmonth);
				
				for(ii=0; ii<datas.daily.thismonth.length; ii++){
					//	console.log("reg_date_day:" + datas.daily.lastyear[i].reg_date_day);	
					var regStr = datas.daily.thismonth[ii].reg_date.split("-");
						
					if (day == regStr[2]){
						val_thismonth = datas.daily.thismonth[ii].generation;
						break;
					}
						
				}
				
				daily_thismonth.push(val_thismonth);
					
			}
			
			var config_daily = {
					type: 'line',
					data: {
						labels: daily_labels,
						datasets: [{
							label: '이번달발전량',
							fill: false,
							backgroundColor: window.chartColors.blue,
							borderColor: window.chartColors.blue,
							data: daily_thismonth,
						}, {

							label: '지난달발전량',
							backgroundColor: window.chartColors.red,
							borderColor: window.chartColors.red,
							data: daily_lastmonth,
							fill: false,
						},{

							label: '지난해발전량',
							backgroundColor: window.chartColors.green,
							borderColor: window.chartColors.green,
							data: daily_lastyear,
							fill: true,
						}
						]
						},
						options: {
							responsive: true,
							maintainAspectRatio: false,
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
										labelString : '일 (Day)'
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
			
			if(window.myLine2!=undefined){
				window.myLine2.destroy(); 
		    }
			
			var ctx2 = document.getElementById('canvas-daily').getContext('2d');
			window.myLine2 = new Chart(ctx2, config_daily);
		}
		
		if(datas.monthly != undefined) {
			for(i=0; i<12;i++){
				var month = i+1;
				month = month<10? "0"+month : month+"";
				monthly_labels.push(month+"월 ");
				
				var val_lastyear = '';
				var val_thisyear = '';
				
				for(ii=0; ii<datas.monthly.lastyear.length; ii++){
				//	console.log("reg_date_month:" + datas.monthly.lastyear[i].reg_date_month);
					var regStr = datas.monthly.lastyear[ii].reg_date.split("-");
					//monthly_labels.push(regStr[1]+"월 ");
					
					if ( month == regStr[1]){
						val_lastyear = datas.monthly.lastyear[ii].generation;
						break;
					}
				}
				
				monthly_lastyear.push(val_lastyear);
					
				for(ii=0; ii<datas.monthly.thisyear.length; ii++){
				//	console.log("reg_date_month:" + datas.monthly.lastyear[i].reg_date_month);
					var regStr = datas.monthly.thisyear[ii].reg_date.split("-");
					//monthly_labels.push(regStr[1]+"월 ");
					
					if ( month == regStr[1]){
						val_thisyear = datas.monthly.thisyear[ii].generation;
						break;
					}
				}
				
				monthly_thisyear.push(val_thisyear);
			}
			
			console.log("today lables:" + today_labels);
			
			var config_monthly = {
					type: 'line',
					data: {
						labels: monthly_labels,
						datasets: [{
							label: '올해발전량',
							fill: false,
							backgroundColor: window.chartColors.blue,
							borderColor: window.chartColors.blue,
							data: monthly_thisyear,
						},{

							label: '지난해발전량',
							backgroundColor: window.chartColors.green,
							borderColor: window.chartColors.green,
							data: monthly_lastyear,
							fill: true,
						}
						]
						},
						options: {
							responsive: true,
							maintainAspectRatio: false,
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
										labelString : '월 (Month)'
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
			
			if(window.myLine3!=undefined){
				window.myLine3.destroy();
		    }
			
			var ctx3 = document.getElementById('canvas-monthly').getContext('2d');
			window.myLine3 = new Chart(ctx3, config_monthly);
		}		
		//ctx.height = 500;
		
	}
	
	
	
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
	  var ctx = document.getElementById(id+"Chart_solar");
		//use data and options
		if (playPerc) playPerc.destroy();
		
		document.getElementById("playChart-val").innerHTML = "";
		
		playPerc = new Chart(ctx, {
		  type: 'doughnut',
		  data: data,
		  options: {
			  //options defined
			  responsive: true,
			  cutoutPercentage: 80,
			  legend: false,
			  layout: {padding: 10},
			  tooltips: {enabled: false},
			  //elements: {arc: { borderWidth: 0}},
			  animation: {onComplete: function() {
				  //this.ctx.fillText("test%", 75, 75, 75);
				  //alert("Finished!");
				  
				  var percent_value = data.datasets[0].data[0] === "NaN" ? 0 : data.datasets[0].data[0];
				  
				  document.getElementById("playChart-val").innerHTML=percent_value+"%";
				}
			  }
			}
		});

	}
	
	
	// 지도 타입 변경 함수
	var currentMapType;
	function changeMapType(maptype){
		var tochangeMapType;
		if (maptype === 'NORMAL') {
			tochangeMapType = kakao.maps.MapTypeId.NORMAL;
			
		} else if (maptype === 'HYBRID') {
			tochangeMapType = kakao.maps.MapTypeId.HYBRID;		
		}
	
		if (currentMapType != tochangeMapType) {
			if (currentMapType) {
				map.removeOverlayMapTypeId(currentMapType);
			}
			map.addOverlayMapTypeId(tochangeMapType);
		}
		
		currentMapType = tochangeMapType;
	}
	
	/* 	//bar01	
	var ctx = document.getElementById("linechart");
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
			},
			scaleLabel: {
				display: true,
				labelString : '시 (Hour)'
			}
		  }],
		  yAxes: [{
			ticks: {
			  beginAtZero: true
			},
			scaleLabel: {
				display: true,
				labelString : '발전량 (kW)'
			}
		  }]
		}
	  }
	});
	//bar02
		
	var ctx = document.getElementById("linechart2");
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
			},
			scaleLabel: {
				display: true,
				labelString : '시 (Hour)'
			}
		  }],
		  yAxes: [{
			ticks: {
			  beginAtZero: true
			},
			scaleLabel: {
				display: true,
				labelString : '발전량 (kW)'
			}
		  }]
		}
	  }
	}); */
	//line
		
	window.onload = function() {
		
	};
	</script>
  </body>
</html>