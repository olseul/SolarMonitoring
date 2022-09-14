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
<!DOCTYPE html>
		   		<div id="totalinfo"> 
		   			<div id="totalinfo-capacity">total-capacity</div>
		   			<div id="totalinfo-generation">total-generation</div>
		   			<div id="totalinfo-co2reduce">total-co2reduce</div>
		   		</div>
		   		<div class="row">
			    	<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-xs-12 col" id="map">
			    		<svg id="map_image"/> 
			    		<div class="map-areaindicator"> 
				    		<!-- <div class="map-seoul">0</div>
				    		<div class="map-incheon">0</div>
				    		<div class="map-ulsan">0</div>
				    		<div class="map-daejeon">0</div>
				    		<div class="map-busan">0</div>
				    		<div class="map-daegu">0</div>
				    		<div class="map-kwangju">0</div>
				    		<div class="map-gyeonggi">0</div>
				    		<div class="map-gangwon">0</div>
				    		<div class="map-chungcheong">0</div>
				    		<div class="map-gyeongsang">0</div>
				    		<div class="map-jeonra">0</div>
				    		<div class="map-jeju">0</div> -->
			    		</div>
			    	</div>
			    	<div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-xs-12 col" id="areainfo_container"> 
			    		<div class="areainfo">
			    			<table id="gauge_board">
			    				<tbody>
			    					<%
			    						for(int i = 0; i < areaName.length; i++) {	
			    							if(i == 0) {	// 서울특별시
		    						%>	
				    						<tr>
					    						<td colspan="2">
					    							<div class="row">
						    							<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-xs-2 col areainfo-content-chart"></div>
						    							<div class="col-xl-10 col-lg-10 col-md-10 col-sm-10 col-xs-10 col areainfo-content">
						    								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 col areainfo-content-title"><%=areaName[i]%></div>
						    								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 col areainfo-content-generation">generation</div>
						    							</div>
					    							</div>
					    						</td>
				    						</tr>		
		    						<% 
			    							}	else { 
			    								if(i%2 != 0) {
			    					%>
			    							<tr>
					    						<td>
													<div class="row">
						    							<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-xs-3 col areainfo-content-chart"></div>
						    							<div class="col-xl-9 col-lg-9 col-md-9 col-sm-9 col-xs-9 col areainfo-content">
						    								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 col areainfo-content-title"><%=areaName[i]%></div>
						    								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 col areainfo-content-generation">generation</div>
						    							</div>
					    							</div>
												</td>
			    					<%				
			    								}	else {
			    					%>
				    							<td>
					    							<div class="row">
						    							<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-xs-3 col areainfo-content-chart"></div>
						    							<div class="col-xl-9 col-lg-9 col-md-9 col-sm-9 col-xs-9 col areainfo-content">
						    								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 col areainfo-content-title"><%=areaName[i]%></div>
						    								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 col areainfo-content-generation">generation</div>
						    							</div>
					    							</div>
					    						</td>
					    					</tr>
			    					<%				
			    								}
			    							}
			    						}
			    					%>
			    				</tbody>
			    			</table>
			    		</div>
			    	</div>
			    </div>
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
    </body>
</html>