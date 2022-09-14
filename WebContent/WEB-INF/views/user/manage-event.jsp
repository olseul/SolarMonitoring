<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./header.jsp" %>
<%@ include file="./LNB.jsp" %>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <script src="/statics/js/jquery.number.js"></script>
    <script src="/statics/js/jquery.cookie.js"></script> 
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
                  <h4 class="page-title">HOME | 운영 | 인버터 이벤트</h4>
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
							<div class="col-md-10">
								<div class="form-group row">
									<div class="col-sm-10">										
									  <label class="col-sm-1 col-form-label">기간</label>
									  <input type="text" class="form-control calendar" style="width: 20%" id="date_start" autocomplete="off">&nbsp;~&nbsp;<input type="text" class="form-control calendar" style="width: 20%" id="date_end"  autocomplete="off">
									</div>
								</div>
							</div>
							<div class="col-md-2 text-right">
							  <button type="button" onclick="start();" class="btn btn-success mr-2"><i class="fas fa-search"></i>검색</button>  
							</div>  
						  </div>
						</div>	
					  </div>
					</div>
					<div class="row"><!-- cont02 -->
						<div class="col-md-12 text-right mb-2"><button type="submit" class="btn btn-primary btn-sm mr-2" onclick="excelDownload();">엑셀다운</button><button type="submit" class="btn btn-primary btn-sm" onclick="content_print();">프린트</button></div>
						<div class="table-area col-md-12" id="printarea">
							<table class="table v2">
							  <colgroup>
								<col width="10%">
								<!-- <col width="*"> -->
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
							  </colgroup>
							  <thead>
								<tr>
								  <th>날짜</th>
								 <!--  <th>발전소</th> -->
								  <th>이벤트</th>
								</tr>
							  </thead>
							  <tbody id="event-list">
							
							  </tbody>
							</table>
							<div aria-label="Page navigation" id="navigation">
							  
							</div>

						</div>
					</div>
				</div>
			</div>
          </div>
          <form id="excelForm" action="/admin/manage/event/downExcel" method="post">
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

	<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker.css" rel="stylesheet">
<!--      -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.js"></script>
    <script src="/statics/js/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

    <!-- End custom js for this page-->
	<script>
	
	var closetime = 0;
	
	$(document).ready(function(){
		
		var sid = getCookie("sid");
		
		console.log("Sid:"+sid);
			
		if(!sid) sid = "";
		
		initCalendar('yyyy-mm-dd');
		//발전소 목록 조회
		selectSite(sid, start);
		
		var d = new Date();
	  	var dayOfMonth = d.getDate();
	  	var today = getDateStr(d);
	  	d.setDate(dayOfMonth - 7);
	  	var before_week =  getDateStr(d);
	  	
	  	console.log("before_week:"+before_week);
	  	
	  	$("#date_start").datepicker("setDate", before_week);
	  	$("#date_end").datepicker("setDate", today);
		
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
	
	var datepicker_default = null;
	
	function initCalendar(format){
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
	             
	        //    showOn: 'both',
	       //     buttonImage:'/statics/js/jquery.ui/images/calendar.png',
	       //     buttonImageOnly: true,
	             
	        //    showButtonPanel: true
	        }
	      
	      //  datepicker_default.closeText = "선택";
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
	 
		$(".calendar").datepicker({

            calendarWeeks: false,

            todayHighlight: true,

            autoclose: true,

            format: format,

            language: "ko"

        });
		
	
	}
	
	function start(){
		
		var sid = read_sid();
	
		var devicetype = "";
		var eventlevel = "";
		var date_start = $("#date_start").val();
		var date_end = $("#date_end").val();
		
		var today = new Date();
		
		if (!date_start) {
			$("#date_start").focus();
			
		} else if(!date_end){
			$("#date_end").focus();
		}else 	if (date_start && date_end) {
			read_device_event(sid,devicetype, eventlevel, date_start, date_end, displayEventlist)
		}  
		
		
		
		
		displayCurrentTime();

	}
	
	var curPage = 1;
	var sizePerPage = 10;
	var dataList = null;
	var m_period = null;
	
	var chartData = null; 
	
	function displayEventlist(datas){
		
		$("#event-list").html('');
		$("#data").val(JSON.stringify(datas));
		
		dataList = datas;
		pageSize = datas.events.length;
		
		var nextMaxPage = curPage * sizePerPage;
		
		if (nextMaxPage > datas.events.length) nextMaxPage = datas.events.length;
		
		if (!datas.events || datas.events.length == 0){
			item += '<td class="text-center">-</td>';
			/* item += '<td class="text-right">-</td>'; */
			item += '<td class="text-left">-</td>';
			item += '</tr>';  
				
			$("#event-list").append(item);
				
		}
		
		for(i=0; i<datas.events.length ; i++) {

			
			var item = ' <tr>';
				item +='<td class="text-center">'+datas.events[i].reg_date+'</td>';
			/* 	item +='  <td class="text-center">'+datas.events[i].name+'</td>'; */
				item +='  <td class="text-left">'+datas.events[i].eventphase+'</td>';
				item +='</tr>';
			
			if (i>=(curPage-1)*sizePerPage &&  i< nextMaxPage){
				
				$("#event-list").append(item);
			}
			
		}
		
		displayNavigation(datas.events);
		
		if(pageSize <= sizePerPage) {
			$("#navigation").attr("style","visibility:hidden");
		} else {
			$("#navigation").attr("style","visibility:");
		}
	}
	
	function goPage(iPage){
		curPage = iPage;
		displayEventlist( dataList);
	}
	
	function displayEventForPrint(){
		
		$("#event-list").html('');
		$("#data").val(JSON.stringify(datas));
		
		var datas = dataList;
		pageSize = datas.events.length;
		
		var nextMaxPage = curPage * sizePerPage;
		
		if (nextMaxPage > datas.events.length) nextMaxPage = datas.events.length;
		
		if (!datas.events || datas.events.length == 0){
			item += '<td class="text-center"></td>';
			/* item += '<td class="text-right">-</td>'; */
			item += '<td class="text-right">-</td>';
			item += '</tr>';  
				
			$("#event-list").append(item);
				
		}
		
		for(i=0; i<datas.events.length ; i++) {

			
			var item = ' <tr>';
				item +='<td class="text-center">'+datas.events[i].reg_date+'</td>';
				/* item +='  <td class="text-center">'+datas.events[i].name+'</td>'; */
				item +='  <td class="text-center">'+datas.events[i].eventphase+'</td>';
				item +='</tr>';
			
		
				
				$("#event-list").append(item);
		
			
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
	
	function print_setLandscape() {
	    var css = '@page { size : landscape; }';
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
		   var date_start = $("#date_start").val();
		   var date_end = $("#date_end").val();
		   
		   displayEventForPrint();
		   $("#navigation").html("");
		    
	    	var initBody = document.body.innerHTML;
	    	window.onbeforeprint = function(){
	    		print_setLandscape();
	     		$("#printarea table *").css("font-size","5px");
	     		document.body.innerHTML = document.getElementById("printarea").innerHTML;
	    	}
	    	window.onafterprint = function(){
	     		document.body.innerHTML = initBody;
	     		
	     		$("#date_start").val(date_start);
	     		$("#date_end").val(date_end);
	     		
	     		$('.calendar').datepicker( "remove" );
	     		
	     		$("#printarea table *").css("font-size","");
	     		
	     		initCalendar('yyyy-mm-dd');
	     		
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