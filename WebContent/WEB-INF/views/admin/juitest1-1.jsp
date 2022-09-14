<%@page import="com.sungchang.common.util.APIHostUtil"%>
<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./juitest_header.jsp" %>

<style>
	div#body {
		overflow: hidden;
	}

	#contents {
		padding-right: 2vw;
		margin-top:5vh;
		padding-left: 10%;
	}
	
	div#header {
		poisition: relative;
		display:block;
		padding-left: 2px;
		background:#303039;
		z-index:10;
		padding-right:20px;
		margin-top:10vh;
	}
	
	#search {
		position:relative;
		display:flex;
		width:100%;
		align-items:center;
		text-align:center;
		margin-left:1vw;
		margin-top:4vh;
		color:#ffffff;
		padding: 2vh 0px 2vh 0px;
		border-radius:10px;
		background-color: var(--paneltheme-bgcolor);
		color: var(--paneltheme-fontcolor);
		-webkit-box-shadow: rgba(0,0,0,30%) 4px 4px 2px;
	}
	
	#sitelist_header {
		position:relative;
		display:flex; 
		color:#ffffff;
		width:100%;
		border-radius:3px;
		margin-left:1vw;
		margin-top:5vh;
		text-align:center;
		background-color: var(--paneltheme-bgcolor);
		color: var(--paneltheme-fontcolor);
		-webkit-box-shadow: rgba(0,0,0,30%) 4px 4px 2px;
	}
	
	#sitelist {
		position:relative;
		width:99%;
		align-items:center;
		margin-left:1.4%;
		color:#ffffff;
		margin-top: 0vh;
		padding-top: 0vh;
		text-align:center;
	}
	
	#sitelist_body {
		position:relative;
		padding-right: 1vw;
		overflow-x:hidden;
		height:72vh;
	}
	
	.sitelist_elements {
	position:relative;
	display:flex;
	width:100%!important;
	margin-top:1.5vh;
	margin-bottom:1.5vh;
	padding-top:1.5vh;
	padding-bottom:1.5vh;
	padding-left:0.5vw; 
	cursor:pointer;
	background-color:var(--paneltheme2-bgcolor);
	color:var(--paneltheme2-fontcolor);
	-webkit-box-shadow: rgba(0,0,0,30%) 4px 4px 2px;
	
	}
	
</style> 
<!DOCTYPE html>
				<div id="header">
			   		<div id="search">
				   		<div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 col-xl-9" id="search_filter">
				   			<p class="col-xs-6 col-sm-6 col-md-6 col-lg-1 col-xl-1">지역</p>
				   			<select class="col-xs-6 col-sm-6 col-md-6 col-lg-2 col-xl-2 input" id="area">
			   					<option selected value="지역">지역</option>
			   					<option value="충청북도">충청북도</option>
			   					<option value="충청남도">충청남도</option>
			   					<option value="경상북도">경상북도</option>
			   					<option value="경상남도">경상남도</option>
			   					<option value="전라북도">전라북도</option>
			   					<option value="전라남도">전라남도</option>
			   				</select>
				   			<p class="col-xs-6 col-sm-6 col-md-6 col-lg-1 col-xl-1">발전소</p>
				   			<input class="col-xs-6 col-sm-6 col-md-6 col-lg-2 col-xl-2 input" id="sitename"/>
				   			<p class="col-xs-6 col-sm-6 col-md-6 col-lg-1 col-xl-1">설치연도</p>
				   			<select class="col-xs-6 col-sm-6 col-md-6 col-lg-1 col-xl-1 input" id="buildyear">
			   					<option selected value="설치연도">설치연도</option>
			   					<option value="2022">2022</option>
			   				</select><br>
				   			<p class="col-xs-6 col-sm-6 col-md-6 col-lg-1 col-xl-1">상태</p>
				   			<select class="col-xs-6 col-sm-6 col-md-6 col-lg-1 col-xl-1 input" id="state">
			   					<option selected value="상태">상태</option>
			   					<option value="발전중">발전중</option>
			   					<option value="발전이상">발전이상</option>
			   					<option value="발전중지">발전중지</option>
			   				</select>		
				   		</div>
				   		<a class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 btn large focus" draggable="false" id="search_button">
				   			<img id="icon" class="col-xs-1 col-sm-1 col-md-12 col-lg-12 col-xl-1" src="/statics/assets/images/search.png"/> 
				   			<p id="label" class="col-xs-2 col-sm-2 col-md-12 col-lg-12 col-xl-2">검색</p>
				   		</a> 
				   	</div>
				   	
				   	<div id="sitelist_header">
					   		<p class="col-lg-1 col-xl-1">ID</p>
					   		<p class="col-lg-6 col-xl-6">발전소명</p> 
					   		<p class="col-lg-1 col-xl-1">담당자</p>
					   		<p class="col-lg-1 col-xl-1">설비용량</p>
					   		<p class="col-lg-1 col-xl-1">현재출력</p>
					   		<p class="col-lg-1 col-xl-1">누적발전량</p>
					   		<p class="col-lg-1 col-xl-1">설치연도</p>
					   		<p class="col-lg-1 col-xl-1">상태</p>
			   		</div>
			   	</div>
			   	
			   	<div id="sitelist">
			   		
			   		<div id="sitelist_body">
			   		
			   		<%
			   			for(int i = 0; i < 20; i++) {
			   		%>
			   		
			   			<div class="sitelist_elements" onclick="moveTo()">
			   				<div class="sitelist_elements_id col-xl-1">
			   					0001
			   				</div>
			   				<div class="sitelist_elements_sitename col-xl-6">
			   					가나다라
			   				</div>
			   				<div class="sitelist_elements_manager col-xl-1">
			   					담당자
			   				</div>
			   				<div class="sitelist_elements_capacity col-xl-1">
			   					123.00 kW
			   				</div>
			   				<div class="sitelist_elements_output col-xl-1">
			   					12,345.00 kW
			   				</div>
			   				<div class="sitelist_elements_accuoutput col-xl-1">
			   					123,456.00 kWh
			   				</div>
			   				<div class="sitelist_elements_builddate col-xl-1">
			   					2000 년도
			   				</div>
			   				<div class="sitelist_elements_state col-xl-1">
			   					R
			   				</div>
			   			</div>
			   		<%
			   			}
			   		%>
			   		</div>
			   	</div>   		
		   	</div>
		</div>
		
		<script>
			function moveTo() {
				document.location = "#";
			}
		
			$(document).ready(function() {
				
			})
		</script>   	
    </body>
</html>