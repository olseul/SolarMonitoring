<%@page import="javax.swing.text.Document"%>
<%@page import="javax.swing.text.html.HTML"%>
<%@page import="com.sungchang.common.util.APIHostUtil"%>
<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./juitest_header.jsp" %> 

	
<script id="tpl_date" type="text/template">
    <td><!= date !></td>
</script>


<style>
	html, body {
	    height: 100%;
	}
	
	#contents {
		margin-top: 65px!important;
	}
	
	#search1 { 
		display:flex;
		align-items:center;
		text-align:center;
		margin: 6vh 1vw 0px 1vw;
		color:#ffffff;
		font-size:0.7vw;
		padding: 1vh 0px;
		border-radius:10px;
		background-color: var(--paneltheme-bgcolor);
		color: var(--paneltheme-fontcolor);
		-webkit-box-shadow: rgba(0,0,0,30%) 4px 4px 2px;
	}

	#search_filter {
		display:flex;
		align-items:center;
		flex-direction:row;
		flex-wrap:wrap;
	}

	#search_button_4 {
		display:flex;
		flex-flow: row;
		flex-wrap: wrap;
		height:100%;
		text-align:center;
		background-image:-webkit-linear-gradient(top,#21B7B5,#0F706F)!important;
		border:1px solid #0F706F;
		align-items:center;
		justify-content:center;
		font-size:0.7vw;
		margin-left:2vw;
	}
	
	.large {
		padding: 0px!important;
	}
	
	input {
		border: none;
		font-size: 12px;
	}
	
	#icon_4 {
		width: 25px!important;
		margin: 10px 0px;
		padding: 0px;
	}
	
	#content-chart {
		height:max-content;
		margin: 1vh 1vw 0px 1vw;
		font-size:0.7vw;
		padding: 0px;
		border-radius:10px;
		color: var(--paneltheme-fontcolor);
	}

	svg {
		background: #303039!important;
	}
	
	text {
		fill: #ffffff!important;
	}
	
	path {
		fill: #12f2e8;
	}
	
	line {
		stroke: #525E75!important;
	}
	
	.combo1 {
		width: 8.8vw;
		font-size: 0.8vw!important;
	}
	
	.combo2 {
		width: 1.3vw;
		font-size: 0.8vw!important;
		text-align: center!important;
	}
	
	.jui .combo>ul>li:not(.divider) {
		padding: 0 10px;
	    line-height: 1.3vw;
 	    font-size: 0.8vw;
	}
	
	#datepicker_1 {
		display: none;
		margin-left: 0px;
		border-radius: 4px!important;
		position: absolute;
    	z-index: 1;
	}
	
	#datepicker_2 {
		display: none;
		margin-left: 0px;
		border-radius: 4px!important;
		position: absolute;
    	z-index: 1;
	}
	
	#icon-div {
		border-radius: 4px!important;
	}

	
	
	/* 웹 */
	@media screen and (min-width: 1200px) {
		#content-chart {
			margin-top: 1.5vh!important;
		}
		
		#content-table {
			margin-top: 1.5vh!important;
		}
		
   		#chart {
			color: #ffffff;
			width: 100%!important;
			height: 430px!important;
		}
		
		#table {
			width: 100%!important;
			height: 370px!important;
			overflow: auto;
		}
		
		#button {
			background: #303039;
		}
		
		.right {
			text-align: right;
			padding: 8px;
			margin: 0px;
		}
		
		#content-table {
			height:max-content;
			margin: 1vh 1vw 0px 1vw;
			color:#ffffff;
			font-size:0.7vw;
			padding: 0px;
			border-radius:10px;
			background-color: var(--paneltheme-bgcolor);
			color: var(--paneltheme-fontcolor);
			-webkit-box-shadow: rgba(0,0,0,30%) 4px 4px 2px;
		}
		
		#fact_table>thead>tr>th {
			position: sticky;
			top: 0;
		}
		
		th, td{
			text-align : center!important;
		}
		
		thead {
			width: 100%;
			display: table-header-group;
		}
		
		tbody {
			width: 100%;
			display: table-row-group;
		}
	}
	
	/* 태블릿 */
	@media (min-width: 769px) and (max-width: 1199px) {
		.col-lg-1 {
		    width: 8.333333333%!important;
		}
		
		.combo1 {
			width: 11vw;
		}
	
		.combo2 {
			width: 2.2vw;
		}
		
		#content-chart {
			margin-top: 1.5vh!important;
		}
		
		#content-table {
			margin-top: 1.5vh!important;
		}
		
   		#chart {
			color: #ffffff;
			width: 100%!important;
			height: 430px!important;
		}
		
		#table {
			width: 100%!important;
			height: 370px!important;
			overflow: auto;
		}
		
		#button {
			background: #303039;
		}
		
		.right {
			text-align: right;
			padding: 8px;
			margin: 0px;
		}
		
		#content-table {
			height:max-content;
			margin: 1vh 1vw 0px 1vw;
			color:#ffffff;
			font-size:0.7vw;
			padding: 0px;
			border-radius:10px;
			background-color: var(--paneltheme-bgcolor);
			color: var(--paneltheme-fontcolor);
			-webkit-box-shadow: rgba(0,0,0,30%) 4px 4px 2px;
		}
		
		#fact_table>thead>tr>th {
			position: sticky;
			top: 0;
		}
		
		th, td{
			text-align : center!important;
		}
		
		thead {
			width: 100%;
			display: table-header-group;
		}
		
		tbody {
			width: 100%;
			display: table-row-group;
		}
	}
	
	/* 모바일 */
	@media (min-width: 360px) and (max-width: 768px) {
		.sidebar_menu {
			display: none;
		}
	
		/* 모바일 버전 모든 페이지에 적용해야 함 */				
		#contents {
			padding-left: 0px!important;
		}
		
		.combo1 {
			width: 30vw;
		}
	
		.combo2 {
			width: 5vw;
		}
	
		#chart {
			color: #ffffff;
			width: 100%!important;
			height: 200px!important;
		}
		
		#table {
			width: 100%!important;
			height: 310px!important;
			overflow: auto;
		}
		
		#button {
			background: #303039;
		}
		
		.right {
			text-align: right;
			padding: 8px;
			margin: 0px;
		}
		
		#content-table {
			height:max-content;
			margin: 1vh 1vw 0px 1vw;
			color:#ffffff;
			font-size:0.7vw;
			padding: 0px;
			border-radius:10px;
			background-color: var(--paneltheme-bgcolor);
			color: var(--paneltheme-fontcolor);
			-webkit-box-shadow: rgba(0,0,0,30%) 4px 4px 2px;
		}
		
		.col-sm-6 {
		    width: 40%!important;
		}
		
		#search_filter {
			width: 70%!important;
		}
		
		#fact_table>thead>tr>th {
			position: sticky;
			top: 0;
		}
		
		th, td{
			text-align : center!important;
		}
		
		thead {
			width: 100%;
			display: table-header-group;
		}
		
		tbody {
			width: 100%;
			display: table-row-group;
		}
	}
	
	
</style>



<!DOCTYPE html>
		<div id="analysis">
		
			<div id="search1">
				   		<div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 col-xl-9" id="search_filter">
				   			<p class="col-xs-6 col-sm-6 col-md-5 col-lg-1 col-xl-1">범위</p>
				   			
				   			<div id="combo_1" class="combo">
							    <a class="btn combo1"></a>
							    <a class="btn toggle combo2"><i class="icon-arrow2"></i></a>
							    <ul>
							        <li value="1">시간별</li>
							        <li value="2">일별</li>
       								<li value="3">월별</li>
				   				</ul>
							</div>

				   			<p class="col-xs-6 col-sm-6 col-md-5 col-lg-1 col-xl-1">날짜</p>
				   			<div id="combo_2" class="combo">
							    <a class="btn combo1" id="today_date1"></a>
							    <a class="btn toggle combo2" id="icon-div"><i class="icon-calendar"></i></a>
							    <div id="datepicker_1" class="datepicker">
								    <div class="head">
								        <div class="prev"><i class="icon-chevron-left"></i></div>
								        <div class="title"></div>
								        <div class="next"><i class="icon-chevron-right"></i></div>
								    </div>
								    <table class="body">
								    	<thead>
											<tr>
												<th>SU</th><th>MO</th><th>TU</th><th>WE</th><th>TH</th><th>FR</th><th>SA</th>
											</tr>
										</thead>
								    </table>
								</div>
								<script id="tpl_date1" type="text/template"><td><!= date !></td></script>
							</div>
				   			 
				   			<p class="col-xs-6 col-sm-6 col-md-5 col-lg-1 col-xl-1">  </p>
				   			<div id="combo_3" class="combo">
							    <a class="btn combo1" id="today_date2"></a>
							    <a class="btn toggle combo2" id="icon-div"><i class="icon-calendar"></i></a>
							    <div id="datepicker_2" class="datepicker">
								    <div class="head">
								        <div class="prev"><i class="icon-chevron-left"></i></div>
								        <div class="title"></div>
								        <div class="next"><i class="icon-chevron-right"></i></div>
								    </div>
								    <table class="body">
										<thead>
											<tr>
												<th>SU</th><th>MO</th><th>TU</th><th>WE</th><th>TH</th><th>FR</th><th>SA</th>
											</tr>
										</thead>
								    </table>
								</div>
								<script id="tpl_date2" type="text/template"><td><!= date !></td></script>
							</div>
				   		</div>
				   		<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-3">
					   		<a class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8 btn focus" draggable="false" id="search_button_4">
					   			<img id="icon_4" class="col-xs-10 col-sm-4 col-md-1 col-lg-1 col-xl-1" src="/statics/assets/images/search.png"/> 
					   			<p id="label_4" class="col-xs-12 col-sm-12 col-md-4 col-lg-6 col-xl-8">검 색</p>
					   		</a> 
				   		</div>
			</div>
			
			<div id="content-chart">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 " id="chart">
			
				</div>
			</div>
				  
			<div id="content-table">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" id="button">
					<p class="right">
						<a class="btn"><strong>EXCEL</strong></a>
						<a class="btn"><strong>PRINT</strong></a>
					</p>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" id="table">
					<table class="table classic stripe" id="fact_table">
					
					<colgroup>
						<col style="width: 10%">
						<col style="width: 22%">
						<col style="width: 24%">
						<col style="width: 24%">
						<col style="width: 20%">
					</colgroup>
				
						<thead>
							<tr>
								<th>No</th>
								<th>날짜/시간</th>
								<th>발전량</th>
								<th>10~14시<br>발전량</th>
								<th>발전시간</th>
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td>1</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>2</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>3</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>8h 40m</td>
							</tr>
							<tr>
								<td>1</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>2h 50m</td>
							</tr>
							<tr>
								<td>2</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 30m</td>
							</tr>
							<tr>
								<td>3</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>5h 29m</td>
							</tr>
							<tr>
								<td>1</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>10h 13m</td>
							</tr>
							<tr>
								<td>2</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>3</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>1</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>2</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>3</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>3</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>1</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>2</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>3</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>3</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>3</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>1</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>2</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
							<tr>
								<td>3</td>
								<td>2022/04/08</td>
								<td>100,400</td>
								<td>85,270</td>
								<td>3h 10m</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>	   	
		
	</div>
</div>
			


		<script>
		
		jui.ready([ "ui.combo" ], function(combo) {
		    combo_1 = combo("#combo_1", {
		        index: 0,
		        event: {
		            change: function(data) {
		            }
		        }
		    });
		});
		
		
		$(document).ready(function(){
	    	 
	        $('#combo_2').on('click', function(){
	        	
	        	var display = $('#datepicker_1').css("display");
	        	
	        	if (display == "none") {
	        		$('#datepicker_1').show();
	        		
	        		$('#datepicker_1>.head').on('click', function(){
	        			$('#datepicker_1').show();
	        		});
	        	} else {
	        		$('#datepicker_1').hide();
	        		
	        		$('#tpl_date1').on('click', function(){
	        			$('#datepicker_1').hide();
	        		});
	        	}
	        });
	        
			$('#combo_3').on('click', function(){
	        	
	        	var display = $('#datepicker_2').css("display");
	        	
	        	if (display == "none") {
	        		$('#datepicker_2').show();
	        		
	        		$('#datepicker_2>.head').on('click', function(){
	        			$('#datepicker_2').show();
	        		});
	        	} else {
	        		$('#datepicker_2').hide();
	        		
	        		$('=#tpl_date2').on('click', function(){
	        			$('#datepicker_2').hide();
	        		});
	        	}
	        });
	    });
		
		
		jui.ready([ "ui.datepicker" ], function(datepicker) {
		    datepicker_1 = datepicker("#datepicker_1", {
		        titleFormat: "yyyy MM",
		        format: "yyyy-MM-dd",
		        event: {
		            select: function(date, e) {
		            	$('#today_date1').html(date);
		            },
		            prev: function(e) {
		            },
		            next: function(e) {
		            }
		        },
		        tpl: {
		            date: $("#tpl_date1").html()
		        }
		    });
		    
		    datepicker_2 = datepicker("#datepicker_2", {
		        titleFormat: "yyyy MM",
		        format: "yyyy-MM-dd",
		        event: {
		            select: function(date, e) {
		            	$('#today_date2').html(date);
		            },
		            prev: function(e) {
		            },
		            next: function(e) {
		            }
		        },
		        tpl: {
		            date: $("#tpl_date2").html()
		        }
		    });
		});
		
		
		
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		if (month <= 9) {
			month = "0" + month;
		}
		var day = date.getDate();
		if (day <= 9) {
			day = "0" + day;
		}
		
		document.getElementById("today_date1").innerHTML = year + "-" + month + "-" + day;
		document.getElementById("today_date2").innerHTML = year + "-" + month + "-" + day;
		
		
		graph.ready([ "chart.builder" ], function(builder) {
	        builder("#chart", {
	            theme : "classic",
	            axis : {
	                x : {
	                    type : "block",
	                    domain : "quarter",
	                    line : false
	                },
	                y : {
	                    type : "range",
	                    domain : function(d) { return [d.sales]; },
	                    step : 10,
	                    line : true
	                },
	                data : [
	                    { quarter : "01", sales : 50 },
	                    { quarter : "02", sales : 20 },
	                    { quarter : "03", sales : 10 },
	                    { quarter : "04", sales : 30 },
	                    { quarter : "05", sales : 44 },
	                    { quarter : "06", sales : 22 },
	                    { quarter : "07", sales : 21 },
	                    { quarter : "08", sales : 36 },
	                    { quarter : "09", sales : 56 },
	                    { quarter : "10", sales : 30 },
	                    { quarter : "11", sales : 32 },
	                    { quarter : "12", sales : 25 },
	                    { quarter : "01", sales : 50 },
	                    { quarter : "02", sales : 20 },
	                    { quarter : "03", sales : 0 },
	                    { quarter : "04", sales : 30 },
	                    { quarter : "05", sales : 44 },
	                    { quarter : "06", sales : 22 },
	                    { quarter : "07", sales : 21 },
	                    { quarter : "08", sales : 36 },
	                    { quarter : "09", sales : 56 },
	                    { quarter : "10", sales : 30 },
	                    { quarter : "11", sales : 32 },
	                    { quarter : "12", sales : 25 }
	                ]
	            },
	            brush : [{
	                type : "column",
	                size : 12,
	                target : [ "sales" ]
	            }],
	            widget : [{
	                type: "tooltip",
	                format : function(data, key) {
	                    return {
	                        key: key,
	                        value: data[key]
	                    }
	                }
	            }],
	            event: {
	                "click": function(obj, e) {
	                    console.log(obj, e);
	                }
	            }
	        });
	    });
			</script>
    </body>
</html>