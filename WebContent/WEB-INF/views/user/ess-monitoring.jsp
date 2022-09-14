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
                  <h4 class="page-title">HOME | ESS | 모니터링</h4>
				  <div class="reload"><a><i class="fas fa-sync-alt"></i></a><span style="font-size:15px; font-weight:bold;">페이지 갱신 시각 : </span><span id="current-time">----.--.-- --:--:--</span></div>
                </div>
              </div>
            </div>
            <!-- Page Title Header Ends-->
            <div class="row"><!-- cont01 -->
              <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-header"><h4 class="card-title mb-0">PCS</h4></div>
				  <div class="card-body">
                    <div class="row operation">
						<div class="col-md-4"><h5 class="mt-4">운전상태</h5><div class="text-center mt-3"><i class="fas fa-server" style="font-size: 100px"></i></div></div>
						<div class="col-md-8">
							<div class="text-right setting-switch">
							</div>
							<div class="operation-state">
								<a  id="state-idling">대기</a>
								<a  id="state-charging">충전</a>
								<a  id="state-discharging">방전</a>
							</div>
						</div>
					</div>
					<div class="mt-5 mb-5">
						<table class="table v5">
							<colgroup>
								<col width="30%">
								<col width="*">
							</colgroup>
							<tbody>
							<tr>
								<th>전압</th>
								<td><strong id="pcs-voltage">-</strong>V</td>
							</tr>
							<tr>
								<th>전류</th>
								<td><strong id="pcs-current">-</strong>A</td>
							</tr>
							<tr>
								<th>주파수</th>
								<td><strong id="pcs-frequency">-</strong>Hz</td>
							</tr>
							</tbody>
						</table>
					</div>
					<div><canvas id="line-chart1"></canvas></div> 
                  </div>
                </div>
              </div>
              <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-header"><h4 class="card-title mb-0">BMS</h4></div>
				  <div class="card-body">
                    <div class="row">
						<div class="col-md-6">
							<div id="play1" class="canvasCont text-center d-chart">
								<!-- <div class="total-graph-rate v1"><strong>SOC</strong></div>
								<canvas id="play1Chart" width="250" height="250" style="display: inline-block;"></canvas>
								<span id="play1Chart-rate" style="    margin-top: 10px;    margin-left: 10px;"></span> -->
							</div>
						</div>
						<div class="col-md-6">
							<div id="play2" class="canvasCont text-center d-chart">
								<!-- <div class="total-graph-rate v1"><strong>SOH</strong></div>
								<canvas id="play2Chart" width="250" height="250" style="display: inline-block;"></canvas>
								<span id="play2Chart-rate" style="   margin-top: 10px;    margin-left: 10px;"></span> -->
							</div>
						</div>
					</div>
					<div class="mt-5 mb-5">
						<table class="table v5">
							<colgroup>
								<col width="30%">
								<col width="*">
							</colgroup>
							<tbody>
							<tr>
								<th>전압</th>
								<td><strong id="bms-voltage">-</strong>V</td>
							</tr>
							<tr>
								<th>전류</th>
								<td><strong id="bms-current">-</strong>A</td>
							</tr>
							<tr>
								<th>전력</th>
								<td><strong id="bms-output">-</strong>W</td>
							</tr>
							</tbody>
						</table>
					</div>
					<div><canvas id="line-chart2"></canvas></div> 
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
					<span id="modal-msg">ESS장치가 없습니다.</span>
					<p id="close-msg">5초 뒤에 창이 닫힙니다</p>
				  </div>
				  <div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
				  </div>
				</div>
			  </div>
			</div>	
    <!-- container-scroller -->
    <!-- plugins:js -->

    <!-- End custom js for this page-->
	<script>
	
	
	$(document).ready(function(){
		
		var sid = getCookie("sid");
		
		console.log("Sid:"+sid);
			
		if(!sid) sid = "";
		
		//발전소 목록 조회
		selectSite(sid, start);
		
		setInterval(function(){ start(); }, 1 * 60 * 1000);
		
	});
	
	function start(){
		
		var sid = getCookie("sid");
		if (!sid ) {
			sid = $("#site-select").val();
			setCookie("sid", sid);
		}
	

		read_ess_detail(sid, displayEssData);
		read_ess_state(sid, displayEssState);
		
		displayCurrentTime();
	}
	
	function initEssdisplay() {
		$("#state-idling").removeClass("select");
		$("#state-charging").removeClass("select");
		$("#state-discharging").removeClass("select");
		$("#state-operating").removeClass("select");
		
		$("#play1Chart-rate").text("");
		$("#play2Chart-rate").text("");
		
		$("#bms-output").text("-");
		$("#bms-voltage").text("-");
		$("#bms-current").text("-");
		
		$("#pcs-frequency").text("-");
		$("#pcs-voltage").text("-");
		$("#pcs-current").text("-");
		
		if(window.play1Chart != null){
			window.play1Chart.destroy();
	    }
		
		if(window.playChart2 != null){
			window.playChart2.destroy();
	    }
		
		if(window.myLine2!=null){
			window.myLine2.destroy();
	    }
		
		if(window.myLine1!=null){
			window.myLine1.destroy(); 
	    }
	}
	
	function displayEssData(datas){
		console.log("displayEssData~" + datas);
		
		if (!datas) {
			
			closetime=5;
			$("#infoModalCenter").modal("show");
			setTimeout(displayCloseTime, 1000);
			
			initEssdisplay();
			
			return;
		}
		
		if (datas && datas.bmsdata){
			
			$("#bms-output").text($.number(datas.bmsdata.output,1));
			$("#bms-voltage").text($.number(datas.bmsdata.voltage,1));
			$("#bms-current").text($.number(datas.bmsdata.current,1));
			
			

			var rate1 = datas.bmsdata.soc;
			var rate2 = datas.bmsdata.soh;

			//createChart(getData(rate1),'play1');
			//createChart(getData(rate2),'play2');
			
			console.log(window.play1Chart);
			
			if(window.playChart1){
				window.playChart1.destroy();
		    }
			
			if(window.playChart2){
				window.playChart2.destroy();
		    }
			
			/* var datas1 = getData(rate1);
				//var ctx = document.getElementById('playPerc');
		   var ctx = document.getElementById("play1Chart");
			//use data and options
			window.play1Chart = new Chart(ctx, {
			  type: 'doughnut',
			  data: datas1,
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
					  document.getElementById("play1Chart-rate").innerHTML=datas1.datasets[0].data[0]+"%";
					}
				  }
				}
			}); 
			
			var datas2 = getData(rate2);
			
			var ctx2 = document.getElementById("play2Chart");
			//use data and options
			window.playChart2 = new Chart(ctx2, {
			  type: 'doughnut',
			  data: datas2,
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
					  document.getElementById("play2Chart-rate").innerHTML =datas2.datasets[0].data[0]+"%";
					}
				  }
				}
			}); */
			
			
			var v = [];
			var a = [];
			var label = [];
			
			for(i=0; i<datas.bmsdata.chartdata.length; i++){
				
				v.push(datas.bmsdata.chartdata[i].bms_vbms);
				a.push(datas.bmsdata.chartdata[i].bms_ibms);
				label.push(datas.bmsdata.chartdata[i].reg_date);
				
			}
			
			console.log("v:"+v);
			
			if(window.myLine2!=null){
				window.myLine2.destroy();
		    }
			
			if(window.myLine1!=null){
				window.myLine1.destroy(); 
		    }
			
			//line
			window.myLine2 = new Chart(document.getElementById("line-chart2"), {
		        type: 'line',
		        data: {
		            labels: label,
		            datasets: [{
		                data: v,
		                label: "전압",
		                borderColor: "#ff7c00",
		                fill: false
		            }, {
		                data: a,
		                label: "전류",
		                borderColor: "#35322f",
		                fill: false
		            }
		            ]
		        },
		        options: {
		            title: {
		                display: false,
		            },
		            scales: {
		    			xAxes: [{
		    				scaleLabel: {
		    					display: true,
		    					labelString : '시간 (time)'
		    				}
		    			  }],
		    			  yAxes: [{
		    				scaleLabel: {
		    					display: true,
		    					labelString : '전압(V), 전류(A)'
		    				}
		    			  }]
		    		}
		        }
		    });
			
		}
		
		if (datas && datas.pcsdata){
			
			$("#pcs-frequency").text($.number(datas.pcsdata.frequency,1));
			$("#pcs-voltage").text($.number(datas.pcsdata.voltage,1));
			$("#pcs-current").text($.number(datas.pcsdata.current,1));
			
			
			
			var v = [];
			var a = [];
			var label = [];
			
			for(i=0; i<datas.pcsdata.chartdata.length; i++){
				
				v.push(datas.pcsdata.chartdata[i].pcs_vpcs);
				a.push(datas.pcsdata.chartdata[i].pcs_ipcs);
				label.push(datas.pcsdata.chartdata[i].reg_date);
				
			}
			
			
			//line
		 	window.myLine1 = new Chart(document.getElementById("line-chart1"), {
		        type: 'line',
		        data: {
		            labels: label,
		            datasets: [{
		                data: v,
		                label: "전압",
		                borderColor: "#ff7c00",
		                fill: false
		            }, {
		                data: a,
		                label: "전류",
		                borderColor: "#35322f",
		                fill: false
		            }
		            ]
		        },
		        options: {
		            title: {
		                display: false,
		            },
		            scales: {
		    			xAxes: [{
		    				scaleLabel: {
		    					display: true,
		    					labelString : '시간 (time)'
		    				}
		    			  }],
		    			  yAxes: [{
		    				scaleLabel: {
		    					display: true,
		    					labelString : '전압(V), 전류(A)'
		    				}
		    			  }]
		    		} 
		        }
		    }); 
			
		}
		
		
	}
	
	function displayEssState(datas){
		console.log(datas);
		
		if (datas.isoperating){
			$("#state-operating").addClass("select");
			$("#control-operate").prop("checked",true);
		} else {
			$("#state-operating").removeClass("select");
			$("#control-operate").prop("checked",false);
		}
		
		if (datas.isidling){
			$("#state-idling").addClass("select");
		} else {
			$("#state-idling").removeClass("select");
		}
				
		if (datas.ischarging){
			$("#state-charging").addClass("select");
		} else {
			$("#state-charging").removeClass("select");
		}
		
		if (datas.isdischarging){
			$("#state-discharging").addClass("select");
		} else {
			$("#state-discharging").removeClass("select");
		}


		$("#read-date").text(datas.upt_date);
		
		
	}
	
	function changeOperate(control){
		console.log("change operate~~");
		
		var sid = getCookie("sid");
		if (!sid ) {
			sid = $("#site-select").val();
			setCookie("sid", sid);
		}
	
		
		if ($(control).prop("checked")){
			update_ess_state(sid, 0);
		} else {
			update_ess_state(sid, 1);
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
						  "#f672a7",
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
		
/* 		//line
		new Chart(document.getElementById("line-chart2"), {
        type: 'line',
        data: {
            labels: [1500,1600,1700,1750,1800,1850,1900,1950,1999,2050],
            datasets: [{
                data: [86,114,106,106,107,111,133,221,783,2478],
                label: "전압",
                borderColor: "#ff7c00",
                fill: false
            }, {
                data: [282,350,411,502,635,809,947,1402,3700,5267],
                label: "전류",
                borderColor: "#35322f",
                fill: false
            }
            ]
        },
        options: {
            title: {
                display: false,
            }
        }
    }); */
    
	</script>
  </body>
</html>