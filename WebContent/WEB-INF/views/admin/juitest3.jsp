<%@page import="com.sungchang.common.util.APIHostUtil"%>
<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./juitest_header.jsp" %> 

<style>
	html, body {
	    height: 100%;
	}
	
	#contents {
		margin-top: 65px!important;
	}
	
	#content-station {
		align-items:center;
		text-align:center;
		margin: 6vh 1vw 0px 0px;
		border-radius:10px;
		color: var(--paneltheme-fontcolor);
	}
	
	.unit_info {
		font-size: 11px;
		text-align: right;
		margin: 5px 0px;
	}
	
	.title {
		margin: 0px;
		padding-left: 20px;
	}
	
	#summary1, #summary2 {
    	display: flex;
	}
	
	#chart1-title-div {
		text-align: center;
	}
	
	#chart1-title {
		font-size: 13px;
	}	
	
	#chart1>svg {
		background: #303039!important;
	}
	
	#chart2>svg {
		background: #303039!important;
	}
	
	.expression {
		display: flex;
		flex:2;
		box-sizing: border-box;
		align-items: center;
	}
	
	.in-expression2 {
		width: 50%!important;
		box-sizing: border-box;
		text-align: right;
		color: #00b0f0;
	}
	
	.de-expression {
		width: 50%!important;
		box-sizing: border-box;
		text-align: right;
	}
	
	#yesterday-data {
		color: #94B49F;
	}
	
	#today-data {
		color: #F1D00A;
	}
	
	.big {
		font-size: 20px;
		margin: 10px 0px;
	}
	
	.small {
		font-size: 13px;
	}
	
	text {
		fill: #ffffff!important;
	}
	
	#today-chart>svg>g>.brush-column>path {
		fill: #12f2e8;
	}
	
	#summary {
		display: flex;
	}
	
	.sensor_context {
		display: flex;
		flex-wrap: wrap;
  		flex-direction: row;
	}
	
	/* 웹 */
	@media screen and (min-width: 1200px) {
		#mobile {
			display: none;
		}
		
		#tab-station-summary {
			display: none;
		}
		
		#station-summary {
			background-color: #303039;
			color: var(--paneltheme-fontcolor);
			/* -webkit-box-shadow: rgba(0,0,0,30%) 1px;*/
		}
	
		#station-chart {
			width: 100%;
			height: 380px;
			font-size:0.7vw;
			padding: 0px;
			border-radius:10px;
			color: var(--paneltheme-fontcolor);
			margin-top: 20px;
		}
		
 		#today-chart {
			color: #ffffff;
			width: 100%!important;
			height: 350px!important;
		}
		
		#today-chart>svg {
			background: #303039!important;
			height: 100%;
		}
		
		#chart1 {
			flex: 1;
	   		box-sizing: border-box;
	   		height: 8vw;
		}
		
		#chart2 {
			position: relative;
			flex: 1;
	   		box-sizing: border-box;
	   		background: #303039;
	   		height: 9vw;
		}
		
		#chart2_text {
			position: absolute;
			text-align: center;
			width: 50%;
			margin: 0px auto;
			height: 160px;
			line-height: 160px;
			left: 50%;
			top: 60%;
			transform: translate(-50%, -50%);
		}

		.unit_info {
			margin: 5px 5px 0px 5px;
		}
		
		.expression {
			flex:1;
		}
		
		.in-expression1 {
			font-size: 1vw;
			width: 50%!important;
			box-sizing: border-box;
			text-align: left;
		}
		
		.big {
			font-size: 1.5vw;
			margin: 5px 0px;
		}
			
		.small {
			font-size: 1vw;
		}
		
		#summary1 {
			margin: 0px 10px;
		}
		
		table {
			width: 100%;
		}
		
		#inverter-diagram {
			position: relative;
			padding: 1vh 0px;
			margin: 13px 0px;
			background-color: #303039;
			color: var(--paneltheme-fontcolor);
		}
		
		.inverter-info {
			text-align: left;
		}
		
		.inverter-data {
			text-align: right;
		}
		
		.diagram_info {
			color : #B4E197;
		}
		
		.info1_data {
			width: 25%;
			height: 68px;
			line-height: 18px;
			top: 23%;
			left: 3%;
			background: #656578;
			color: #ffffff;
			box-sizing: border-box;
			position: absolute;
			font-size: 12px;
			border-radius: 5px;
		}
		
		.info2_data {
			width: 43%;
			height: 90px;
			line-height: 18px;
			top: 38%;
			left: 38%;
			background: #656578;
			color: #ffffff;
			box-sizing: border-box;
			position: absolute;
			font-size: 12px;
			border-radius: 5px;
		}

		.info3_data {
			width: 25%;
			height: 45px;
			line-height: 18px;
			top: 10%;
			left: 70%;
			background: #656578;
			color: #ffffff;
			box-sizing: border-box;
			position: absolute;
			font-size: 12px;
			border-radius: 5px;
		}
		
		.title-div {
			padding: 1vh 0px;
			border-radius:10px;
			background-color: var(--paneltheme-bgcolor);
			color: var(--paneltheme-fontcolor);
			text-align: left;
			-webkit-box-shadow: rgba(0,0,0,30%) 4px 4px 2px;
			margin: 0px 10px;
		}
		
		.context-div {
			margin: 0px 15px;
		}
		
		#inverter-img {
			width: 85%;
			position: relative;
		}
	
		#sensor {
			display: flex;
			margin-top: 15px;
		}
		
		#sensor-col {
			flex: 1;
			font-size: 0.9vw;
		}
		
		#sensor-con {
			flex: 1;
			font-size: 0.9vw;
		}
		
		.sensor-data {
			color: #6A8ED4;
			font-size: 1.7vw;
		}
		
		.s-con {
			margin: 13px 0px;
		}
		
		.s-col {
			font-size: 1vw;
			margin-bottom: 0px;
		}
		
		.unit_s {
			font-size: 0.7vw;
			margin: 2px;
		}
	
		#sensor_context1{
			margin-top: 10px!important;
		}
		
		#sensor_context2 {
			margin-top: 15px!important;
		}
		
		#text1 {
			color: #00B0F0;
			font-size: 22px;
		}
		
		#text2 {
			color: #ffffff;
			font-size: 12px;
		}
	
	}
	
	/* 태블릿 */
	@media (min-width: 769px) and (max-width: 1199px) {
		#station-summary {
			display: none;
		}
		
		#mobile {
			display: none;
		}
		
		#tab-station-summary {
			background-color: #303039;
			color: var(--paneltheme-fontcolor);
			/* -webkit-box-shadow: rgba(0,0,0,30%) 1px;*/
		}
		
		#tab-two-div {
			display: flex;
			margin-top: 40px;
			height: 23vw;
		}
		
		#station-chart {
			width: 100%;
		}
		
 		#today-chart {
			color: #ffffff;
			width: 100%!important;
			height: 90%!important;
		}
		
		#today-chart>svg {
			background: #303039!important;
		}
		
		#chart1 {
			flex: 1;
	   		box-sizing: border-box;
		}
		
		#chart1>svg {
			height: 9.5vw;
		} 
		
		#chart2 {
			position: relative;
			flex: 1;
	   		box-sizing: border-box;
	   		background: #303039;
		}
		
		#chart2>svg {
			height: 9.5vw;
		}
		
		#chart2_text {
			position: absolute;
			text-align: center;
			width: 50%;
			margin: 0px auto;
			height: 160px;
			line-height: 160px;
			left: 50%;
			top: 60%;
			transform: translate(-50%, -50%);
		}
		
		#station-chart {
			font-size:0.7vw;
			padding: 0px;
			border-radius:10px;
			color: var(--paneltheme-fontcolor);
		}
		
		.unit_info {
			margin: 5px 5px 0px 5px;
		}
		
		.expression {
			flex:1;
		}
		
		.in-expression1 {
			font-size: 1.4vw;
			width: 50%!important;
			box-sizing: border-box;
			text-align: left;
		}
		
		.big {
			font-size: 1.8vw;
			margin: 5px 0px;
		}
			
		.small {
			font-size: 1.1vw;
		}
		
		#summary1 {
			margin: 0px 10px;
		}
		
		table {
			width: 100%;
		}
		
		#inverter-diagram {
			position: relative;
			padding: 1vh 0px;
			margin: 5px 0px;
			background-color: #303039;
			color: var(--paneltheme-fontcolor);
		}
		
		.inverter-info {
			text-align: left;
		}
		
		.inverter-data {
			text-align: right;
		}
		
		.diagram_info {
			color : #B4E197;
		}
		
		.info1_data {
			width: 33%;
			height: 45px;
			line-height: 10px;
			top: 35%;
			left: 3%;
			background: #656578;
			color: #ffffff;
			box-sizing: border-box;
			position: absolute;
			font-size: 10px;
			border-radius: 5px;
		}
		
		.info2_data {
			width: 48%;
			height: 58px;
			line-height: 10px;
			top: 38%;
			left: 38%;
			background: #656578;
			color: #ffffff;
			box-sizing: border-box;
			position: absolute;
			font-size: 10px;
			border-radius: 5px;
		}

		.info3_data {
			width: 30%;
			height: 30px;
			line-height: 10px;
			top: 15%;
			left: 68%;
			background: #656578;
			color: #ffffff;
			box-sizing: border-box;
			position: absolute;
			font-size: 10px;
			border-radius: 5px;
		}
		
		.diagram-text {
			background: #656578;
			color: #ffffff;
			display: flex;
			flex:2;
			box-sizing: border-box;
			position: absolute;
			font-size: 12px;
			border-radius: 5px;
		}
		
		.title-div {
			padding: 1vh 0px;
			border-radius:10px;
			background-color: var(--paneltheme-bgcolor);
			color: var(--paneltheme-fontcolor);
			text-align: left;
			-webkit-box-shadow: rgba(0,0,0,30%) 4px 4px 2px;
			margin: 0px 10px;
		}
		
		.context-div {
			margin: 0px 15px;
		}
		
		#inverter-img {
			margin-top: 10px;
			width: 100%;
			height: 100%;
			position: relative;
		}
	
		#sensor {
			display: flex;
			margin-top: 15px;
		}
		
		.sensor-data {
			color: #6A8ED4;
			font-size: 2vw;
		}
		
		.s-con {
			margin: 13px 0px;
		}
		
		.s-col {
			font-size: 1.3vw;
			margin: 0px;
		}
		
		.unit_s {
			font-size: 1vw;
			margin: 2px;
		}
		
		#sensor_context1{
			margin-top: 2vw!important;
		}
		
		#sensor_context2 {
			margin-top: 1vw!important;
		}
		
		#text1 {
			color: #00B0F0;
			font-size: 16px;
		}
		
		#text2 {
			color: #ffffff;
			font-size: 10px;
		}
	
	}
	
	/* 모바일 */
	@media (min-width: 360px) and (max-width: 768px) {
		#web {
			display: none;
		}
		
		.sidebar_menu {
			display: none;
		}
		
		/* 모바일 버전 모든 페이지에 적용해야 함 */				
		#contents {
			padding-left: 0px!important;
		}
		
		#content-station {
			align-items:center;
			text-align:center;
			margin: 6vh 15px 1vw;
			border-radius:10px;
			color: var(--paneltheme-fontcolor);
		}

		#station-title {
			padding: 1vh 0px;
			border-radius:10px;
			background-color: var(--paneltheme-bgcolor);
			color: var(--paneltheme-fontcolor);
			text-align: left;
			-webkit-box-shadow: rgba(0,0,0,30%) 4px 4px 2px;
		}
	
   		#today-chart {
   			width: 100%;
			height: 100%;
			color: #ffffff;
		}
		
		#today-chart>svg {
			background: #303039!important;
		}
		
		#chart1 {
			flex: 1;
	   		box-sizing: border-box;
	   		height: 90px;
		}
			
		#chart2 {
			position: relative;
			flex: 1;
	   		box-sizing: border-box;
	   		background: #303039;
	   		height: 95px;
		}
		
		#chart2_text {
			position: absolute;
			text-align: center;
			width: 50%;
			margin: 0px auto;
			height: 95px;
			line-height: 95px;
			left: 50%;
			top: 60%;
			transform: translate(-50%, -50%);
		}
		
		.in-expression1 {
			width: 50%!important;
			box-sizing: border-box;
			text-align: left;
		}
		
		
		#station-chart {
			width: 100%;
			height: 60%;
			margin: 0.5vw 1vw 1.5vw 1vw;
			font-size:0.7vw;
			padding: 0px;
			border-radius:10px;
			color: var(--paneltheme-fontcolor);
		}
			
		table {
			width: 100%;
		}
		
		#inverter-diagram {
			position: relative;
			margin: 5px 0px;
			background-color: #303039;
			color: var(--paneltheme-fontcolor);
		}
		
		.inverter-info {
			text-align: left;
		}
		
		.inverter-data {
			text-align: right;
		}
		
		.diagram_info {
			color : #B4E197;
		}
		
		.info1_data {
			width: 25%;
			height: 50px;
			line-height: 12px;
			top: 23%;
			left: 3%;
			background: #656578;
			color: #ffffff;
			box-sizing: border-box;
			position: absolute;
			font-size: 10px;
			border-radius: 5px;
		}
		
		.info2_data {
			width: 43%;
			height: 65px;
			line-height: 12px;
			top: 38%;
			left: 38%;
			background: #656578;
			color: #ffffff;
			box-sizing: border-box;
			position: absolute;
			font-size: 10px;
			border-radius: 5px;
		}

		.info3_data {
			width: 25%;
			height: 33px;
			line-height: 12px;
			top: 10%;
			left: 70%;
			background: #656578;
			color: #ffffff;
			box-sizing: border-box;
			position: absolute;
			font-size: 10px;
			border-radius: 5px;
		}
		
		.title-div {
			padding: 1vh 0px;
			border-radius:10px;
			background-color: var(--paneltheme-bgcolor);
			color: var(--paneltheme-fontcolor);
			text-align: left;
			-webkit-box-shadow: rgba(0,0,0,30%) 4px 4px 2px;
			margin: 0px 10px;
		}
		
		.context-div {
			margin: 0px 15px;
		}
		
		#inverter-img {
			width: 85%;
			position: relative;
		}
		
		#station-sensor {
			margin: 10px 0px;
		}
		
		#sensor {
			display: flex;
			align-items: center;
		}
		
		#sensor-block {
			border-radius: 3px;
			background: #6c6c6c;
			width: 80px;
			color: #ffffff;
			margin: 0px auto;
			font-size: 14px;
		}
	
		#sensor-info {
			padding: 5px;
			margin: 0px;
			font-size: 12px;
		}
		
		#text1 {
			color: #00B0F0;
			font-size: 16pt;
		}
		
		#text2 {
			color: #ffffff;
			font-size: 10px;
		}
	}
	
	
</style>


<!DOCTYPE html>
	<div id="web">
	
   		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 " id="content-station">		
   		
   				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 " id="station-summary">

					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 " id="summary">
						<div class="col-5 ">
							<div class="title-div" id="station-title">
			   					<p class="title">발전소</p>
			   				</div>
			   				<div class="context-div">
				   				<div id="unit">
					   				<p class="unit_info">(단위 : kWh)</p>
					   			</div>
					   			<div class="col-12" id="summary1">
	   								<div class="col-6 " id="chart1">
	   						
	   								</div>
					   			
					   				<div class="col-6 expression">
					   					<div class="col-4 in-expression1">
											<p><b>어제 발전량</b></p>
											<p><b>오늘 발전량</b></p>
										</div>
									
										<div class="col-8 de-expression">
											<p class="big" id="yesterday-data"><b>12<span class="small">.00</span></b></p>
											<p class="big" id="today-data"><b>123<span class="small">.00</span></b></p>
										</div>
					   				</div>
								</div>
								
								<div class="col-12" id="summary2">
	   								<div class="col-6 " id="chart2">
				   						<div id="chart2_text"><b><span class="chart2_span" id="text1">123</span><span class="chart2_span" id="text2">kW</span></b></div>
				   					</div>
					   			
					   				<div class="col-6 expression">
					   					<div class="col-4 in-expression1">
											<p><b>현재 출력</b></p>
											<p><b>누적 발전량</b></p>
										</div>
										
										<div class="col-8 in-expression2">
											<p class="big"><b>1234<span class="small">.00</span></b></p>
											<p class="big"><b>123456<span class="small">.00</span></b></p>
										</div>
					   				</div>
								</div>
							</div>
						</div>
						
						
						<div class="col-5">
							<div class="title-div" id="inverter-title">
			   					<p class="title">인버터</p>
			   				</div>
							<div class="context-div" id="inverter-diagram">
				   				<div id="diagram-img">
				   					<img src="/statics/assets/images/final-diagram.png" id="inverter-img"/>
				   				</div>
			   					
					   			<div class="info1_data">		
				   					<table>
			   							<tr>
			   								<td class="inverter-info">PV 전압</td>
			   								<td class="inverter-data"><span class="diagram_info">1234</span> V</td>
			   							</tr>
			   							<tr>
			   								<td class="inverter-info">PV 전류</td>
			   								<td class="inverter-data"><span class="diagram_info">1234</span> A</td>
			   							</tr>
			   							<tr>
			   								<td class="inverter-info">PV 출력</td>
			   								<td class="inverter-data"><span class="diagram_info">1234</span> W</td>
			   							</tr>
			   						</table>
			   					</div>
				   					
			   					<div class="info2_data">		
				   					<table>
			   							<tr>
			   								<td class="inverter-info">역률</td>
			   								<td class="inverter-data"><span class="diagram_info">123.00</span> %</td>
			   							</tr>
			   							<tr>
			   								<td class="inverter-info">주파수</td>
			   								<td class="inverter-data"><span class="diagram_info">123.00</span> Hz</td>
			   							</tr>
			   							<tr>
			   								<td class="inverter-info">현재출력</td>
			   								<td class="inverter-data"><span class="diagram_info">123456789</span> W</td>
			   							</tr>
			   							<tr>
			   								<td class="inverter-info">누적발전량</td>
			   								<td class="inverter-data"><span class="diagram_info">123456789</span> kW</td>
			   							</tr>
			   						</table>
			   					</div>
			   					
			   					<div class="info3_data">		
				   					<table>
			   							<tr>
			   								<td class="inverter-info">계통전압</td>
			   								<td class="inverter-data"><span class="diagram_info">1234</span> V</td>
			   							</tr>
			  							<tr>
			  								<td class="inverter-info">계통전류</td>
			  								<td class="inverter-data"><span class="diagram_info">1234</span> A</td>
				   						</tr>
				   					</table>
				   				</div>
				   			</div>
						</div>
						
						<div class="col-2">
							<div class="title-div" id="sensor-title">
			   					<p class="title">센서 정보</p>
			   				</div>
			   				<div class="context-div">
								<div class="col-12 sensor_context" id="sensor_context1">
									<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 ">
										<p class="s-col">대기 온도</p>
										<p class="unit_s">( 단위 : ℃ )</p>
										<p class="s-con"><b><span class="sensor-data">12.3</span></b></p>
									</div>
									
									<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6">
										<p class="s-col">수직일사량</p>
										<p class="unit_s">( 단위 : w/㎡ )</p>
										<p class="s-con"><b><span class="sensor-data">123</span></b></p>
									</div>
								</div>
								
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 sensor_context" id="sensor_context2">
									<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 ">
										<p class="s-col">패널 온도</p>
										<p class="unit_s">( 단위 : ℃ )</p>
										<p class="s-con"><b><span class="sensor-data">12.3</span></b></p>
									</div>
									
									<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6">
										<p class="s-col">수평일사량</p>
										<p class="unit_s">( 단위 : w/㎡ )</p>
										<p class="s-con"><b><span class="sensor-data">123</span></b></p>
									</div>
								</div>
							</div>
						</div>
   					</div>
   				
   					<div id="station-chart">
   						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 " id="chart1-title-div">
   							<span id="chart1-title">오늘 발전량</span>
   						</div>
   						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" id="today-chart">
						
						</div>
   					</div>
   				</div>	
   				
   				<!-- 태블릿 화면 구성 시작 -->
   					
   					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 " id="tab-station-summary">

					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 " id="summary">
						<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 ">
							<div class="title-div" id="station-title">
			   					<p class="title">발전소</p>
			   				</div>
			   				<div class="context-div">
				   				<div id="unit">
					   				<p class="unit_info">(단위 : kWh)</p>
					   			</div>
					   			<div id="summary1">
	   								<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-3 " id="chart1">
	   						
	   								</div>
					   			
					   				<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-3 expression">
					   					<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 in-expression1">
											<p><b>어제 발전량</b></p>
											<p><b>오늘 발전량</b></p>
										</div>
									
										<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 de-expression">
											<p class="big" id="yesterday-data"><b>12<span class="small">.00</span></b></p>
											<p class="big" id="today-data"><b>123<span class="small">.00</span></b></p>
										</div>
					   				</div>
								</div>
								
								<div id="summary2">
	   								<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 " id="chart2">
				   						<div id="chart2_text"><b><span class="chart2_span" id="text1">123</span><span class="chart2_span" id="text2">kW</span></b></div>
				   					</div>
					   			
					   				<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-3 expression">
					   					<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 in-expression1">
											<p><b>현재 출력</b></p>
											<p><b>누적 발전량</b></p>
										</div>
										
										<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 in-expression2">
											<p class="big"><b>1234<span class="small">.00</span></b></p>
											<p class="big"><b>123456<span class="small">.00</span></b></p>
										</div>
					   				</div>
								</div>
							</div>
						</div>
						
						
						<div class="col-6">
							<div class="title-div" id="inverter-title">
			   					<p class="title">인버터</p>
			   				</div>
								<div class="context-div" id="inverter-diagram">
					   				<div id="diagram-img">
					   					<img src="/statics/assets/images/final-diagram.png" id="inverter-img"/>
					   				</div>
				   					
						   			<div class="info1_data">		
					   					<table>
				   							<tr>
				   								<td class="inverter-info">PV 전압</td>
				   								<td class="inverter-data"><span class="diagram_info">1234</span> V</td>
				   							</tr>
				   							<tr>
				   								<td class="inverter-info">PV 전류</td>
				   								<td class="inverter-data"><span class="diagram_info">1234</span> A</td>
				   							</tr>
				   							<tr>
				   								<td class="inverter-info">PV 출력</td>
				   								<td class="inverter-data"><span class="diagram_info">1234</span> W</td>
				   							</tr>
				   						</table>
				   					</div>
				   					
				   					<div class="info2_data">		
					   					<table>
				   							<tr>
				   								<td class="inverter-info">역률</td>
				   								<td class="inverter-data"><span class="diagram_info">123.00</span> %</td>
				   							</tr>
				   							<tr>
				   								<td class="inverter-info">주파수</td>
				   								<td class="inverter-data"><span class="diagram_info">123.00</span> Hz</td>
				   							</tr>
				   							<tr>
				   								<td class="inverter-info">현재출력</td>
				   								<td class="inverter-data"><span class="diagram_info">123456789</span> W</td>
				   							</tr>
				   							<tr>
				   								<td class="inverter-info">누적발전량</td>
				   								<td class="inverter-data"><span class="diagram_info">123456789</span> kW</td>
				   							</tr>
				   						</table>
				   					</div>
				   					
				   					<div class="info3_data">		
					   					<table>
				   							<tr>
				   								<td class="inverter-info">계통전압</td>
				   								<td class="inverter-data"><span class="diagram_info">1234</span> V</td>
				   							</tr>
				   							<tr>
				   								<td class="inverter-info">계통전류</td>
				   								<td class="inverter-data"><span class="diagram_info">1234</span> A</td>
				   							</tr>
				   						</table>
				   					</div>
				   				</div>
						</div>
   					</div>
   					
   					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" id="tab-two-div">
	   					<div class="col-7 " id="station-chart">
	   						<div id="chart1-title-div">
	   							<span id="chart1-title">오늘 발전량</span>
	   						</div>
	   						<div id="today-chart">
							
							</div>
	   					</div>
	   					<div class="col-5">
							<div class="title-div" id="sensor-title">
			   					<p class="title">센서 정보</p>
			   				</div>
			   				<div class="context-div">
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 sensor_context" id="sensor_context1">
									<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 right_border">
										<p class="s-col">대기 온도</p>
										<p class="unit_s">(단위 : ℃)</p>
										<p class="s-con"><b><span class="sensor-data">12.3</span></b></p>
									</div>
									
									<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6">
										<p class="s-col">수직일사량</p>
										<p class="unit_s">(단위 : w/㎡)</p>
										<p class="s-con"><b><span class="sensor-data">123</span></b></p>
									</div>
								</div>
								
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 sensor_context" id="sensor_context2">
									<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 right_border">
										<p class="s-col">패널 온도</p>
										<p class="unit_s">(단위 : ℃)</p>
										<p class="s-con"><b><span class="sensor-data">12.3</span></b></p>
									</div>
									
									<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6">
										<p class="s-col">수평일사량</p>
										<p class="unit_s">(단위 : w/㎡)</p>
										<p class="s-con"><b><span class="sensor-data">123</span></b></p>
									</div>
								</div>
							</div>
						</div>
					</div>
   				</div>
   					
   				<!-- 태블릿 화면 구성 끝 -->
 	  	</div>	
   	</div>
   	
   	
   	
   	<div id="mobile">
   		<div id="content-station">		
   		
   			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 " id="station">
   			
				<div id="station-title">
   					<p class="title">발전소</p>
   				</div>
   				
   				<div id="unit">
   					<p class="unit_info">(단위 : kWh)</p>
   				</div>
   				<div id="station-summary">
   					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 " id="summary1">
   						<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 " id="chart1">
   						
   						</div>
   						
   						
   						<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8 expression">
							<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 in-expression1">
								<p><b>어제 발전량</b></p>
								<p><b>오늘 발전량</b></p>
							</div>
							
							<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 de-expression">
								<p class="big" id="yesterday-data"><b>12<span class="small">.00</span></b></p>
								<p class="big" id="today-data"><b>123<span class="small">.00</span></b></p>
							</div>
   						</div>
   					</div>
   					
   					
   					
   					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 " id="summary2">
   						<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 " id="chart2">
   							<div id="chart2_text"><b><span class="chart2_span" id="text1">123</span><span class="chart2_span" id="text2">kW</span></b></div>
   						</div>
   						
   						
   						<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8 expression">
   							<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 in-expression1">
								<p><b>현재 출력</b></p>
								<p><b>누적 발전량</b></p>
							</div>
							
							<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 in-expression2">
								<p class="big"><b>1234<span class="small">.00</span></b></p>
								<p class="big"><b>123456<span class="small">.00</span></b></p>
							</div>
   						</div>
   					</div>
   				</div>
   				
   				
   				<div id="station-chart">
   					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 " id="chart1-title-div">
   						<span id="chart1-title">오늘 발전량</span>
   					</div>
   					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" id="today-chart">
						
					</div>
   				</div>
   				
   				
   				<div id="station-sensor">
   					<div class="col-12 " id="sensor">
   						<div class="col-4">
   							<p id="sensor-block">Sensor<br>정보</p> 
   						</div>
   						
   						
   						<div class="col-8">
   							<p id="sensor-info">
   								대기온도 12.3℃ | 수직일사량 123w/㎡<br>패널온도 12.3℃ | 수평일사량 123w/㎡
   							</p>
   						</div>
   					</div>
   				</div>
   				
   			</div>
   			
   			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 " id = "content-inverter">
   			
   			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 ">
				<div class="title-div" id="inverter-title">
			   		<p class="title">인버터</p>
				</div>
				<div class="context-div" id="inverter-diagram">
					<div id="diagram-img">
						<img src="/statics/assets/images/final-diagram.png" id="inverter-img"/>
					</div>
						
		   			<div class="info1_data">		
						<table>
							<tr>
			   					<td class="inverter-info">PV 전압</td>
			   					<td class="inverter-data"><span class="diagram_info">1234</span> V</td>
			   				</tr>
			   				<tr>
			   					<td class="inverter-info">PV 전류</td>
			   					<td class="inverter-data"><span class="diagram_info">1234</span> A</td>
			   				</tr>
			   				<tr>
			   					<td class="inverter-info">PV 출력</td>
			   					<td class="inverter-data"><span class="diagram_info">1234</span> W</td>
			   				</tr>
			   			</table>
			   		</div>
				   					
			   		<div class="info2_data">		
	   					<table>
							<tr>
								<td class="inverter-info">역률</td>
								<td class="inverter-data"><span class="diagram_info">123.00</span> %</td>
							</tr>
							<tr>
			   								<td class="inverter-info">주파수</td>
			   								<td class="inverter-data"><span class="diagram_info">123.00</span> Hz</td>
			   							</tr>
			   							<tr>
			   								<td class="inverter-info">현재출력</td>
			   								<td class="inverter-data"><span class="diagram_info">123456789</span> W</td>
			   							</tr>
			   							<tr>
			   								<td class="inverter-info">누적발전량</td>
			   								<td class="inverter-data"><span class="diagram_info">123456789</span> kW</td>
			   							</tr>
			   						</table>
			   					</div>
			   					
			   					<div class="info3_data">		
				   					<table>
			   							<tr>
			   								<td class="inverter-info">계통전압</td>
			   								<td class="inverter-data"><span class="diagram_info">1234</span> V</td>
			   							</tr>
			  							<tr>
			  								<td class="inverter-info">계통전류</td>
			  								<td class="inverter-data"><span class="diagram_info">1234</span> A</td>
				   						</tr>
				   					</table>
				   				</div>
				   			</div>
			</div>
   			
   		</div>	
   			
   			
   			
   		
   	
   	
   	</div>	
   			
   			
	</div>
</div>
		
		<script>
		graph.ready([ "chart.builder" ], function(builder) {
	        builder("#today-chart", {
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
	                    step : 5,
	                    line : false
	                },
	                data : [
	                    { quarter : "00", sales : 50 },
	                    { quarter : "01", sales : 20 },
	                    { quarter : "02", sales : 0 },
	                    { quarter : "03", sales : 30 },
	                    { quarter : "04", sales : 44 },
	                    { quarter : "05", sales : 22 },
	                    { quarter : "06", sales : 21 },
	                    { quarter : "07", sales : 36 },
	                    { quarter : "08", sales : 56 },
	                    { quarter : "09", sales : 30 },
	                    { quarter : "10", sales : 32 },
	                    { quarter : "11", sales : 25 },
	                    { quarter : "12", sales : 50 },
	                    { quarter : "13", sales : 20 },
	                    { quarter : "14", sales : 10 },
	                    { quarter : "15", sales : 30 },
	                    { quarter : "16", sales : 44 },
	                    { quarter : "17", sales : 22 },
	                    { quarter : "18", sales : 21 },
	                    { quarter : "19", sales : 36 },
	                    { quarter : "20", sales : 56 },
	                    { quarter : "21", sales : 30 },
	                    { quarter : "22", sales : 32 },
	                    { quarter : "23", sales : 25 }
	                ]
	            },
	            brush : [{
	                type : "column",
	                size : 10,
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
		
		
		if (matchMedia("screen and (min-width: 1200px)").matches) {
			graph.ready([ "chart.builder" ], function(builder) {
		        builder("#chart1", {
		            theme : "classic",
		            axis : {
		                x : {
		                    type : "block",
		                    domain : "quarter",
		                    line : false,
		                    color: "#50505f"
		                },
		                y : {
		                    type : "range",
		                    domain : function(d) { return Math.max(d.sales) + 20; },
		                    step : 5,
		                    line : "dashed",
		                    color: "#50505f"
		                    /* line : "dashed rect" */
		                },
		                data : [
		                    { quarter : "", sales : 50 },
		                    { quarter : "", sales : 20 }
		                ]
		            },
		            brush : [{
		                type : "column",
		                size : 35,
		                target : [ "sales" ],
		                colors : function (data) {
		                	if(data.sales > 30) {
		                		return "#94B49F";
		                	}
		                	return "#F1D00A";
		                }
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
		                "mouseover": function(d, e) {
		                    console.log(d, e);
		                }
		            }
		        });
		    });
		  
		  graph.ready([ "chart.builder" ], function(builder) {
				builder("#chart2",{
					padding:0,
					axis: [{
						data: [{
							value: Math.round(Math.random()*100),
							max: 100,
							min: 0
						}]
					}],
					brush: [{
						type: "fullgauge",
						symbol: "round",
						startAngle: 0,
						colors:["#00fff2"],
						size: 15, 
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
			});
		} else if (matchMedia("(min-width: 769px) and (max-width: 1199px)").matches) {
			  graph.ready([ "chart.builder" ], function(builder) {
			        builder("#chart1", {
			            theme : "classic",
			            axis : {
			                x : {
			                    type : "block",
			                    domain : "quarter",
			                    line : false,
			                    color: "#50505f"
			                },
			                y : {
			                    type : "range",
			                    domain : function(d) { return Math.max(d.sales) + 20; },
			                    step : 3,
			                    line : "dashed",
			                    color: "#50505f"
			                    /* line : "dashed rect" */
			                },
			                data : [
			                    { quarter : "", sales : 50 },
			                    { quarter : "", sales : 20 }
			                ]
			            },
			            brush : [{
			                type : "column",
			                size : 25,
			                target : [ "sales" ],
			                colors : function (data) {
			                	if(data.sales > 30) {
			                		return "#94B49F";
			                	}
			                	return "#F1D00A";
			                }
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
			                "mouseover": function(d, e) {
			                    console.log(d, e);
			                }
			            }
			        });
			    });
			  
			  graph.ready([ "chart.builder" ], function(builder) {
					builder("#chart2",{
						padding:0,
						axis: [{
							data: [{
								value: Math.round(Math.random()*100),
								max: 100,
								min: 0
							}]
						}],
						brush: [{
							type: "fullgauge",
							symbol: "round",
							startAngle: 0,
							colors:["#00fff2"],
							size: 8, 
							showText: true,
							format: function(value) {
								return value + "%";
							}
							
						}],
						style: {
							backgroundColor:"rgba(0,0,0,0)",
							gaugeFontSize:"12pt"
							
							/*gaugeBackgroundColor:"#ffffff",*/
							
						}
					});
				});
		  } else {
			  graph.ready([ "chart.builder" ], function(builder) {
			        builder("#chart1", {
			            theme : "classic",
			            axis : {
			                x : {
			                    type : "block",
			                    domain : "quarter",
			                    line : false,
			                    color: "#50505f"
			                },
			                y : {
			                    type : "range",
			                    domain : function(d) { return Math.max(d.sales) + 20; },
			                    step : 5,
			                    line : "dashed",
			                    color: "#50505f"
			                    /* line : "dashed rect" */
			                },
			                data : [
			                    { quarter : "", sales : 50 },
			                    { quarter : "", sales : 20 }
			                ]
			            },
			            brush : [{
			                type : "column",
			                size : 20,
			                target : [ "sales" ],
			                colors : function (data) {
			                	if(data.sales > 30) {
			                		return "#94B49F";
			                	}
			                	return "#F1D00A";
			                }
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
			                "mouseover": function(d, e) {
			                    console.log(d, e);
			                }
			            }
			        });
			    });
				
				graph.ready([ "chart.builder" ], function(builder) {
					builder("#chart2",{
						padding:0,
						axis: [{
							data: [{
								value: Math.round(Math.random()*100),
								max: 100,
								min: 0
							}]
						}],
						brush: [{
							type: "fullgauge",
							symbol: "round",
							startAngle: 0,
							colors:["#00fff2"],
							size: 8, 
							showText: true,
							format: function(value) {
								return value + "%";
							}
							
						}],
						style: {
							backgroundColor:"rgba(0,0,0,0)",
							gaugeFontSize:"12pt"
							
							/*gaugeBackgroundColor:"#ffffff",*/
							
						}
					});
				});
			  
		  }
		
		 // window.setTimeout('window.location.reload()', 3000);
		
		</script>   	
    </body>
</html>