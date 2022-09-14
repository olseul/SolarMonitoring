<%@page import="java.net.URI"%>
<%@page import="com.sungchang.common.util.APIHostUtil"%>
<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
    <%@page import="java.net.URI"%>
    <%
    String msg = request.getParameter("msg");
    String uri = request.getRequestURI();
    %>
    
<style>
	/* rtu 고정(css파일로 묶지 않음) */
	html, body {
		height: 100%;
		width: 100%;
		margin: 0px;
		padding: 0px;
		background: #303039;
	}
	
	.rtu_context {
		height: 100%;
		width: 100%;
		margin: 0px;
		padding: 0px;
		overflow: auto;
	}
	
	.mp-zero {
		margin: 0px;
		padding: 0px;
	}
	
	.red_cir {
		width: 20px;
		height: 20px;
	}
	
	.rtu_search {
		margin: 0px;
		padding: 0px;
	}
	
	.bot_mar {
		margin-bottom: 20px;
	}
	
	.co {
		color: #ffffff;
	}
	
	.number {
		width: 195px;
	}
	
	.btn-size {
		height: 100%!important;
		font-weight: 800px!important;
		font-size: 13px!important;
		align-content: center!important;
 	   	display: inline-flex!important;
  	 	align-items: center!important;
	}
	
	th, td{
		text-align: center!important;
	}
	
	.right {
		float: right;
		margin: 20px 5px 0px 0px;
		color: #ffffff;
		font-size: 12px;
	}
	
	.time_right {
		float: right;
		margin: 0px 10px;
		color: #ffffff;
	}
	
	.search_div {
		margin-left: 30px;
	}
	
	.table_head {
		position: sticky;
		top: 0;
	}
	
	.text-c {
		overflow: auto;
	}
	
	.rtu_title {
		margin: 0px 0px 10px 0px; 
		color: #ffffff;
	}
</style>

<!DOCTYPE html>

<head>
		<meta name="viewport" content="width=device-width, height=device-height,initial-scale=1, maximum-scale=1">
		
		<title>RTU-Parsing</title> 		
		
		<link rel="stylesheet" href="/statics/assets/jui/dist/jui-ui.classic.css"/>
    	<link rel="stylesheet" href="/statics/assets/jui/dist/jui-ui.min.classic.css"/>
    	<!-- <link rel="stylesheet" href="/statics/assets/jui/dist/ui-jennifer.min.classic.css"/> -->
    	
    	<link rel="stylesheet" href="/statics/assets/jui-grid/dist/jui-grid.classic.css"/>
    	<link rel="stylesheet" href="/statics/assets/jui-grid/dist/jui-grid.dark.css"/>
    	<!-- <link rel="stylesheet" href="/statics/assets/jui-grid/dist/grid-jennifer.classic.css"/>  -->
    	<link rel="stylesheet" href="/statics/assets/css/monitoring/juitest_style.css"/>


</head>
<body class="jui">
 
	<div class="rtu_context">
	
		<div class="col-12" style="height: 60px; line-height: 60px; align-items: center; justify-content: center; margin: 20px 0px 25px;">
			<div style="color:#ffffff; text-align: center; font-size: 30px; height: 60px;"><b>IoT Parsing Server 동시 접속 처리 가능</b></div>
			<p class="time_right">현재 시각 : 2022-07-27 16:56:58</p>
		</div>
		
		<div class="col-12" style="display:flex; margin: 70px 0px 0px;">
			<div class="col-5" style="sjustify-content: center; margin-left: 10px;">
				<div class="col-12" style="display: flex;">
					<div class="col-10" style="flex: 6;">
						<div class="col-12 bot_mar co" style="display: flex; flex-wrap: wrap; flex-direction: row;">
							<div class="col-6 search_div" style="flex: 1">
								<p class="rtu_search">* 측정 시작 시각</p>
								<input type="datetime-local" name="starttime"/>
							</div>
							
							<div class="col-6 search_div" style="flex: 1">
								<p class="rtu_search">* 데이터 통신 주기 (분)</p>
								<input type="number" class="number" name="min" min="1" max="59"/> min
							</div>
						</div>
						
						<div class="col-12 co" style="display: flex; flex-wrap: wrap; flex-direction: row;">
							<div class="col-6 search_div" style="flex: 1">
								<p class="rtu_search">* 측정 종료 시각</p>
								<input type="datetime-local" name="lasttime"/>
							</div>
							
							<div class="col-6 search_div" style="flex: 1">
								<p class="rtu_search">* 통신 허용 오차 시간 (초)</p>
								<input type="number" class="number" name="sec" min="1" max="59"/> sec
							</div>
						</div>
					</div>
					
					<div class="col-2 " style="flex: 1; width: 100%; text-align: center;">
						<a class="btn focus btn-size">설정 적용</a>
					</div>
				</div>
				
				<div class="col-12" style="margin-top: 30px;">
					<table class="table classic hover text-c">
						<thead>
						  <tr>
						    <th>측정 시작 시각</th>
						    <th>측정 종료 시각</th>
						    <th>데이터 통신 주기 (분)</th>
						    <th>통신 허용 오차 시간 (초)</th>
						  </tr>
						</thead>
						<tbody>
						  <tr> 
						    <td>2022-07-27 15:40:53</td>
						    <td>2022-07-27 16:40:47</td>
						    <td>1234</td>
						    <td>1234</td>
						   </tr>
						</tbody>
					</table>
				</div>
				
				<p class="right">호출 row 개수 : 20</p>
				<div class="col-12" style="margin-top: 40px; height: 660px; overflow: auto;">
					<table class="table classic hover text-c">
						<thead>
						  <tr class="table_head">
						    <th style="width:5%">No</th>
						    <th style="width:15%">CNUM</th>
						    <th style="width:18%">IMEI</th>
						    <th style="width:22%">CCID</th>
						    <th style="width:15%">FirstData</th>
						    <th style="width:15%">LastData</th>
						    <th style="width:10%">DataCount</th>
						  </tr>
						</thead>
						<tbody>
						  <tr> 
						    <td>100</td>
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr>
						    <td>2</td> 
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr> 
						    <td>3</td>
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr>
						    <td>4</td> 
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr> 
						    <td>5</td>
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr>
						    <td>6</td> 
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr> 
						    <td>7</td>
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr>
						    <td>8</td> 
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr> 
						    <td>9</td>
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr>
						    <td>10</td> 
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr> 
						    <td>11</td>
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr>
						    <td>12</td> 
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr> 
						    <td>13</td>
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr>
						    <td>14</td> 
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr> 
						    <td>15</td>
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr>
						    <td>16</td> 
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr>
						    <td>17</td> 
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr>
						    <td>18</td> 
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr>
						    <td>19</td> 
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						  <tr>
						    <td>20</td> 
						    <td>123456789012</td>
						    <td>123456789012345</td>
						    <td>1234567890123456789</td>
						    <td>2022-07-27<br>15:40:53</td>
						    <td>2022-07-27<br>16:40:47</td>
						    <td>5</td>
						  </tr>
						</tbody>
					</table>
				</div>
			</div>
		
			<div class="col-7" style=" justify-content: center;">
				<div class="col-12" style="display: flex; justify-content: center; margin-bottom: 30px;">
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #01</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #02</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #03</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #04</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #05</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #06</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #07</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #08</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #09</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #10</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
				</div>
				<div class="col-12" style="display: flex; justify-content: center; margin-bottom: 30px;">
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #11</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #12</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #13</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #14</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #15</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #16</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #17</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #18</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #19</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #20</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
				</div>
				<div class="col-12" style="display: flex; justify-content: center; margin-bottom: 30px;">
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #21</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #22</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #23</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #24</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #25</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #26</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #27</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #28</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #29</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #30</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
				</div>
				<div class="col-12" style="display: flex; justify-content: center; margin-bottom: 30px;">
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #31</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #32</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #33</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #34</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #35</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #36</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #37</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #38</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #39</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #40</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
				</div>
				<div class="col-12" style="display: flex; justify-content: center; margin-bottom: 30px;">
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #41</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #42</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #43</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #44</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #45</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #46</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #47</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #48</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #49</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #50</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
				</div>
				<div class="col-12" style="display: flex; justify-content: center; margin-bottom: 30px;">
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #51</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #52</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #53</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #54</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #55</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #56</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #57</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #58</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #59</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #60</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
				</div>
				<div class="col-12" style="display: flex; justify-content: center; margin-bottom: 30px;">
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #61</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #62</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #63</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #64</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #65</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #66</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #67</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #68</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #69</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #70</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
				</div>
				<div class="col-12" style="display: flex; justify-content: center; margin-bottom: 30px;">
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #71</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #72</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #73</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #74</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #75</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #76</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #77</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #78</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #79</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #80</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
				</div>
				<div class="col-12" style="display: flex; justify-content: center; margin-bottom: 30px;">
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #81</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #82</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #83</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #84</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #85</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #86</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #87</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #88</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #89</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #90</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
				</div>
				<div class="col-12" style="display: flex; justify-content: center; margin-bottom: 30px;">
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #91</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #92</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #93</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #94</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #95</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #96</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #97</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #98</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #99</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
					<div class="col-1" style="text-align: center; flex: 1;">
						<p class="rtu_title">RTU #100</p>
						<p style="margin: 0px; font-size: 23px; color: #ff0000;">●</p>
					</div>
				</div>
			</div>
		</div>

	</div>
	
</body>
<script>
	
</script>
</html>