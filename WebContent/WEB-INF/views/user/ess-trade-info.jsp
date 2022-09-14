<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./header.jsp" %>
<%@ include file="./LNB.jsp" %>
    <%
    String msg = request.getParameter("msg");
   
    %>
          <div class="main-panel">
          <div class="content-wrapper">
            <!-- Page Title Header Starts-->
            <div class="row page-title-header">
              <div class="col-12">
                <div class="page-header">
                  <h4 class="page-title">HOME | ESS | 전력 거래</h4>
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
						<div class="form-group row">
							<label class="col-sm-4 col-form-label">종목</label>
							<div class="col-sm-8">
							  <select class="form-control" id="subject">
                                <option value="main">육지</option>
                                <option value="jeju">제주</option>
                              </select>
							</div>
						</div>
					</div>
					<div class="col-md-10 text-right">
					  <button type="button" onclick="start();" class="btn btn-success mr-2"><i class="fas fa-search"></i>검색</button>  
					</div>  
                  </div>
				</div>	
              </div>
            </div>
			<div class="row"><!-- cont02 -->
              <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-header"><h4 class="card-title mb-0">오늘 SMP</h4></div>
				  <div class="card-body">
                    <div class="table-area col-md-12 smp-area">
						<p class="text-right">(단위 : 원/kW)</p>
						<table class="table v3">
						  <tbody>
							<tr>
							  <th>거래일</th>
							  <td class="text-right" id="smp-date"></td>
							</tr>
							<tr>
							  <th>최대</th>
							  <td class="text-right max" id="smp-high"></td>
							</tr>
							<tr>
							  <th>최소</th>
							  <td class="text-right min" id="smp-low"></td>
							</tr>
							<tr>
							  <th>평균</th>
							  <td class="text-right average" id="smp-avg"></td>
							</tr>
						  </tbody>
						</table>
					</div>
                  </div>
                </div>
              </div>
              <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-header"><h4 class="card-title mb-0">최근 REC</h4></div>
				  <div class="card-body">
				  	<small style="color:#ff0000;">REC 데이터는 화,목요일 오후 5시 ~ 8시 사이 갱신됩니다.</small>
                    <div class="table-area col-md-12 smp-area">
						<p>1 REC = 1 MW(가중치에 따라 변동)<span class="text-right">(단위 : 원/REC)</span></p>
						<table class="table v3">
						  <tbody>
							<tr>
							  <th>거래일</th>
							  <td class="text-right" id="rec-date"></td>
							</tr>
							<tr>
							  <th>거래량</th>
							  <td class="text-right max" id="rec-amount-trade"></td>
							</tr>
							<tr>
							  <th>평균가</th>
							  <td class="text-right min" id="rec-avg"></td>
							</tr>
							<tr>
							  <th>최고가</th>
							  <td class="text-right average" id="rec-high"></td>
							</tr>
							<tr>
							  <th>최저가</th>
							  <td class="text-right average" id="rec-low"></td>
							</tr>
							<tr>
							  <th>종가</th>
							  <td class="text-right" id="rec-end"></td>
							</tr>
						  </tbody>
						</table>
					</div>
                  </div>
                </div>
              </div>
            </div>
             <div class="row">
            <div style="color: #fff; position: absolute;right: 30px;">( 출처 : KPX ) </div>
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
		
		
		$("#ptype").val($(obj).val());
		
		
	}
	
	
	
	function start(){
		
		displayCurrentTime();
		
		var sid = read_sid();
	
		var subject = $("#subject").val();
			
		read_trade_info(sid, subject, displayTradeInfo);

	}
	
		
	function displayTradeInfo(project, datas){

		if (datas){
			
			console.log(JSON.stringify(datas));
			
			$("#smp-date").text(datas.smpinfo.date);
			$("#smp-high").text($.number(datas.smpinfo.price_high,2));
			$("#smp-low").text($.number(datas.smpinfo.price_low,2));
			$("#smp-avg").text($.number(datas.smpinfo.price_avg, 2));
			
			$("#rec-date").text(datas.recinfo.date);
			$("#rec-amount-trade").text($.number(datas.recinfo.amount_trade));
			$("#rec-avg").text($.number(datas.recinfo.price_avg));
			$("#rec-high").text($.number(datas.recinfo.price_high));
			$("#rec-low").text($.number(datas.recinfo.price_low));
			$("#rec-end").text($.number(datas.recinfo.price_end));
			
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