<%@page import="javax.swing.text.Document"%>
<%@page import="javax.swing.text.html.HTML"%>
<%@page import="com.sungchang.common.util.APIHostUtil"%>
<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./juitest_header.jsp" %>

<%
	String[] areaName = {
			"서울특별시",
			"인천광역시",
			"울산광역시",
			"대전광역시",
			"대구광역시",
			"부산광역시",
			"광주광역시",
			"경기도",
			"강원도",
			"충청도",
			"경상도",
			"전라도",
			"제주도"
	};
%>

<style>
	#container {
		overflow:hidden;
		padding: 40px 25px;
	}
	
	#nav {
		float: left;
	    position: fixed;
	    width: 34%;
	}
	
	#content {
		width: 60%;
		float: right;
	}
	
	#totalinfo2 {
		background-color: #FFFFFF;
		width: 100%;
	}
	
	.total {
		overflow: hidden;
	    display: inline-block;
	    width: 31.3333333%;
	    padding-left: 2%;
	}

	.total p{
		font-weight: bold;
		font-size: 18px;
	}
	
	.total > div{
		height: 100px;
	}

	.chart2 {
		position: relative;
	    display: inline-block;
	    border-radius: 50%;
	    float: left;
	    width: 65px;
    	height: 70px;
	    background: conic-gradient(#FD9F28 80%, #373737 20%);
	}
	
	.chart2 .center {
		top: 50%;
	    left: 50%;
	    background: #fff;
	    border-radius: 50%;
	    position: absolute;
	    transform: translate(-50%, -50%);
	    width: 50px;
	    height: 55px;
	    text-align: center;
	    line-height: 55px;
	    font-size: 20px;
	    color: #FD9F28;
	    font-weight: bold;
	}
	
	.totalinfo-value {
		float: left;
	    font-weight: bold;
	    color: #1187CF;
	    height: 75px;
	    line-height: 75px;
	    font-size: 23px;
	}
	
	.totalinfo-unit {
		float: left;
		height: 75px;
    	line-height: 75px;
	}
	
	#map {
		width: 100%!important;
	}
	
	#gauge_board {
		width: 100%;
    	height: 100%;
	}
	
	
	#gauge_board td {
		width: 25%;
	}
	
	.areainfo-content-title2{
		text-align: center;
		background: #CACACA;
		padding: 5px;
		font-weight: bold;
	}
	
	.areainfo-content > .areainfo-content-div2 {
		height: 230px;
		padding: 10px;
	}
	
	.areainfo-content {
		height: 100%;
		background: #414141;
		border-width: 2px;
  		border-style: solid;
  		border-color: #CACACA;
  		overflow: hidden;
	}
	
	.title{
		font-weight: bold;
	}
	
	.current-output > div{
		display: inline-block;
		padding: 5px;
		background: #18A8F1;
		border-radius: 10px;
	}
	
	.chart-content {
		height: 80px;
    	padding: 14px 0px;
	}
	
	.chart-content .chart2 {
		width: 70px;
	    height: 70px;
	    background: conic-gradient(#5EFFF0 80%, #373737 20%);
	}
	
	.chart-content .center {
		width: 55px;
	    height: 55px;
	    color: #5EFFF0;
	    background: #414141;
	}
	
	.areainfo-content-div2 .totalinfo-value{
		color: #FD9F28;
		font-size: 26px;
	}

	.Cumulative-usage > div{
		display: inline-block;
		padding: 5px;
		background: #B96BC6;
		border-radius: 10px;
	}
	
	.totalinfo-div {
		height: 70px;
	    float: right;
	}
	
	
	
</style>
<!DOCTYPE html>
		 <div id="container">
			<div id="nav">
				<div id="totalinfo2">
					<div id="totalinfo-capacity2" class="total">
						<p>전체 발전소 용량</p>
						<div>
							<div class="chart2"><span class="center">172k</span></div>
							<div class="totalinfo-value">1,234,567</div>
							<div class="totalinfo-unit">KW</div>
						</div>
					</div
					><div id="totalinfo-generation2" class="total">
						<p>총 누적발전량</p>
						<div>
							<div class="chart2"><span class="center">172k</span></div>
							<div class="totalinfo-value">1,234,567</div>
							<div class="totalinfo-unit">KW</div>
						</div>
					</div
					><div id="totalinfo-co2reduce2" class="total">
						<p>Co2 감축량</p>
						<div>
							<div class="chart2"><span class="center">172k</span></div>
							<div class="totalinfo-value">1,234,567</div>
							<div class="totalinfo-unit">KW</div>
						</div>
					</div>
				</div>
				<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-xs-12 col" id="map">
		    		<svg id="map_image"></svg>
		    		<div class="map-areaindicator"> 
		    		</div>
		    	</div>
			</div>
			<div id="content"> 
				<table id="gauge_board">
    				<tbody>
    					<%
    						for(int i = 0; i < areaName.length; i++) {
   						%>	
	    						<%
		    						if(i%4==0) {
		   						%>	
		   						<tr>
	    						<td>
	    							<div class="areainfo-content">
		    							<div class="areainfo-content-title2"><%=areaName[i]%></div>
		    							<div class="areainfo-content-div2">
			    							<div class="current-output"><div class="title">현재 출력량</div></div>
			    							<div class="chart-content">
												<div class="chart2"><span class="center">172k</span></div>
												<div class="totalinfo-div">
													<div class="totalinfo-value">1,234,567</div>
													<div class="totalinfo-unit">KW</div>
												</div>
											</div>
											<div class="Cumulative-usage"><div class="title">누적 이용량</div></div>
											<div class="totalinfo-div">
												<div class="totalinfo-value">1,234,567</div>
												<div class="totalinfo-unit">KW</div>
											</div>
										</div>
	    							</div>
	    						</td>
	    						<%
		    						}
		   						%>
		   						<%
		    						if(i%4==1) {
		   						%>	
	    						<td>
	    							<div class="areainfo-content">
		    							<div class="areainfo-content-title2"><%=areaName[i]%></div>
		    							<div class="areainfo-content-div2">
			    							<div class="current-output"><div class="title">현재 출력량</div></div>
			    							<div class="chart-content">
												<div class="chart2"><span class="center">172k</span></div>
												<div class="totalinfo-div">
													<div class="totalinfo-value">1,234,567</div>
													<div class="totalinfo-unit">KW</div>
												</div>
											</div>
											<div class="Cumulative-usage"><div class="title">누적 이용량</div></div>
											<div class="totalinfo-div">
												<div class="totalinfo-value">1,234,567</div>
												<div class="totalinfo-unit">KW</div>
											</div>
										</div>
	    							</div>
	    						</td>
	    						<%
		    						}
		   						%>
		   						<%
		    						if(i%4==2) {
		   						%>	
	    						<td>
	    							<div class="areainfo-content">
		    							<div class="areainfo-content-title2"><%=areaName[i]%></div>
		    							<div class="areainfo-content-div2">
			    							<div class="current-output"><div class="title">현재 출력량</div></div>
			    							<div class="chart-content">
												<div class="chart2"><span class="center">172k</span></div>
												<div class="totalinfo-div">
													<div class="totalinfo-value">1,234,567</div>
													<div class="totalinfo-unit">KW</div>
												</div>
											</div>
											<div class="Cumulative-usage"><div class="title">누적 이용량</div></div>
											<div class="totalinfo-div">
												<div class="totalinfo-value">1,234,567</div>
												<div class="totalinfo-unit">KW</div>
											</div>
										</div>
	    							</div>
	    						</td>
	    						<%
		    						}
		   						%>
		   						<%
		    						if(i%4==3) {
		   						%>	
	    						<td>
	    							<div class="areainfo-content">
		    							<div class="areainfo-content-title2"><%=areaName[i]%></div>
		    							<div class="areainfo-content-div2">
			    							<div class="current-output"><div class="title">현재 출력량</div></div>
			    							<div class="chart-content">
												<div class="chart2"><span class="center">172k</span></div>
												<div class="totalinfo-div">
													<div class="totalinfo-value">1,234,567</div>
													<div class="totalinfo-unit">KW</div>
												</div>
											</div>
											<div class="Cumulative-usage"><div class="title">누적 이용량</div></div>
											<div class="totalinfo-div">
												<div class="totalinfo-value">1,234,567</div>
												<div class="totalinfo-unit">KW</div>
											</div>
										</div>
	    							</div>
	    						</td>
	    						</tr>
	    						<%
		    						}
		   						%>
    					<% 
    						}
    					%>
    				</tbody>
    			</table>
			</div>
		</div>
		<script>
			// $(document).ready() {
			//}
		
			function windowResize() {
				var header = $(".header");
				var body = $("#body.row");
				
				var menu_container = $("#menu_container.col");
				var content_container = $("#content_container.col");
				
				var menu = $("#menu.panel");
				
				//$(header).width("100%");
				//$(header).height("5vh");
				
				/* $(body).height("90vh");
				
				$(menu_container).height("100%"); */
			}
			
			function makeChart(builder) {
				//var chart = jui.include("chart.builder");
				
				builder(".areainfo-content-chart",{
					padding:0,
					axis: [{
						c: {
							type:"panel"
						},
						data: [{
							value: Math.round(Math.random()*100),
							max: 100,
							min: 0,
						}]
					}],
					brush: [{
						type: "fullgauge",
						symbol: "round",
						startAngle: 0,
						colors:["#00fff2"],
						size: 10, 
						showText: true,
						format: function(value) {
							return value + "%";
						}
						
					}],
					style: {
						backgroundColor:"rgba(0,0,0,0)",
						gaugeFontSize:"14pt"
						/*gaugeBackgroundColor:"#ffffff",*/
						
					}
				});
				
			}
		
		
			jui.ready(["util.base"], function(_) {				
				
				/* var header = builder("#header", {
			   		width:"100%",
			   		height:200
			   	}); */
			   	
			   	windowResize();	
			});
			
			graph.ready(["chart.builder"], function(builder) {
				makeChart(builder);
			});
		
		   	
    	</script>
		
		<script>
			$(document).ready(function() {
				
			})
		</script>  	