<%@page import="com.sungchang.common.util.APIHostUtil"%>
<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./juitest_header.jsp" %> 

<!-- 1-1 시안과 style 분리 -->
<style> 
	#search { 	
		position: relative;
	    display: flex;
	    align-items: center;
	    text-align: center;
	    margin: 6vh 1vw 0px 1vw;
	    color: #ffffff;
	    font-size: 0.7vw;
	    padding: 1vh 0px;
	    border-radius: 10px;
	    background-color: var(--paneltheme-bgcolor);
	    color: var(--paneltheme-fontcolor);
	    -webkit-box-shadow: rgb(0 0 0 / 30%) 4px 4px 2px;
	    width: auto;
	}
	
	#sitelist_header {
		position:relative;
		display:flex; 
		color:#ffffff;
		width:auto;
		border-radius:3px;
		margin-left:1vw;
		margin-top:4vh;
		margin-right: 1vw;
		text-align:center;
		background-color: var(--paneltheme-bgcolor);
		color: var(--paneltheme-fontcolor);
		-webkit-box-shadow: rgba(0,0,0,30%) 4px 4px 2px;
	}
	
	#sitelist {
		position:relative;
		width:97%;
		align-items:center;
		margin-left:1vw;
		color:#ffffff;
		text-align:center;
		margin-top: 0vh;
    	padding-top: 0vh;
	}
	
	#sitelist_body {
		position:relative;
		width:99%;
	}
	
	.sitelist_elements {
		position:relative;
		display:flex;
		width:auto!important;
		margin-top:0vh;
		margin-bottom:1.5vh;
		margin-right: 1.3vh;
		margin-left: 1.3vh;
		padding: 0vw;
		cursor:pointer;
		background-color:var(--paneltheme2-bgcolor);
		color:var(--paneltheme2-fontcolor);
		-webkit-box-shadow: rgba(0,0,0,30%) 4px 4px 2px;
		
		text-align:center;
	
	}
	
	#search_button {
	    display: flex;
	    flex-flow: row;
	    flex-wrap: wrap;
	    height: 100%;
	    text-align: center;
	    background-image: -webkit-linear-gradient(top,#21B7B5,#0F706F)!important;
	    border: 1px solid #0F706F;
	    align-items: center;
	    justify-content: center;
	    font-size: 0.7vw;
	    margin-left: 2vw;
	    padding: 0 12px;
    }
    
    #icon_5 {
	    width: 25px!important;
	    margin: 10px 0px;
	    padding: 0px;
	}
	
	
	
	
	
	/* 내가 추가한 코드 */
	#contents {
		margin-top: 65px!important;
	}
	
	#sitelist_header>* {
	    padding: 1vh;
	}
	
	table {
		width: 100%
	}
	
	.sitelist_elements>* {
	    padding: 2vh 1vh;
	    margin: auto;
	}
	
	.sitelist_elements_id {
	    border-radius: 0.5em;
	    font-size: 1vw;
	    background-color: #ffff00;
	    color: #000000;
	}
	
	
	
	.sitelist_elements_state {
		color: green;
	}
	
	/* 태블릿 */
	@media (min-width: 769px) and (max-width: 1199px) {
		.col-xl-6 {
		    width: 35%!important;
		}
		
		.col-md-1 {
		    width: 24%!important;
		}
		.col-sm-6 {
		    width: 45%!important;
		}
		
		.sitelist_elements_id{
		    width: 100%;
		    margin: auto;
		    height: 3vw;
		    line-height: 3vw;
		}
	}
	
	/* 모바일 */
	@media (min-width: 360px) and (max-width: 768px) {
		#contents {
			padding-left: 0px!important;
		}
		
		.col-xl-6 {
		    width: 50%!important;
		}
		
		#sitelist_header {
			margin-left: 0vw;
		    margin-right: 0vw;
		}
		
		.sitelist_elements {
		    margin-right: 0vh;
		    margin-left: 0vh;
		}
		
		table {
		    width: 180%;
		}
		
		.col-sm-1 {
		    width: 15%!important;
		}
		
		.sitelist_elements_id{
		    width:80%;
		    margin:auto;
		    height: 4vw;
		    line-height: 4vw;
		}
		
	
	
</style>

<!DOCTYPE html>
		   		<div id="search">
			   		<div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 col-xl-9" id="search_filter">
			   			<p class="col-xs-6 col-sm-6 col-md-5 col-lg-1 col-xl-1">지역</p>
			   			<select class="col-xs-6 col-sm-6 col-md-5 col-lg-2 col-xl-2 input" id="area">
		   					<option selected value="지역">지역</option>
		   					<option value="충청북도">충청북도</option>
		   					<option value="충청남도">충청남도</option>
		   					<option value="경상북도">경상북도</option>
		   					<option value="경상남도">경상남도</option>
		   					<option value="전라북도">전라북도</option>
		   					<option value="전라남도">전라남도</option>
		   				</select>
			   			<p class="col-xs-6 col-sm-6 col-md-5 col-lg-1 col-xl-1">발전소</p>
			   			<input class="col-xs-6 col-sm-6 col-md-5 col-lg-2 col-xl-2 input" id="sitename"/>
			   			<p class="col-xs-6 col-sm-6 col-md-5 col-lg-1 col-xl-1">설치연도</p>
			   			<select class="col-xs-6 col-sm-6 col-md-5 col-lg-2 col-xl-2 input" id="buildyear">
		   					<option selected value="설치연도">설치연도</option>
		   					<option value="2022">2022</option>
		   				</select><br>
			   			<p class="col-xs-6 col-sm-6 col-md-5 col-lg-1 col-xl-1">상태</p>
			   			<select class="col-xs-6 col-sm-6 col-md-5 col-lg-1 col-xl-1 input" id="state">
		   					<option selected value="상태">상태</option>
		   					<option value="발전중">발전중</option>
		   					<option value="발전이상">발전이상</option>
		   					<option value="발전중지">발전중지</option>
		   				</select>		
			   		</div>
			   		<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-3">
				   		<a class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8 btn focus" draggable="false" id="search_button">
				   			<img id="icon_5" class="col-xs-10 col-sm-4 col-md-1 col-lg-1 col-xl-1" src="/statics/assets/images/search.png"/> 
				   			<p id="label_5" class="col-xs-12 col-sm-12 col-md-4 col-lg-6 col-xl-8">검 색</p>
				   		</a> 
			   		</div>
				   	<!-- <div id="sitelist_header">
				   		<p class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">ID</p>
				   		<p class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6">발전소명</p> 
				   		<p class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">담당자</p>
				   		<p class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">설비용량</p>
				   		<p class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">현재출력</p>
				   		<p class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">누적발전량</p>
				   		<p class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">설치연도</p>
				   		<p class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">상태</p>
				   	</div> -->
			   	</div>
			   	
			   	<%-- <div id="sitelist">
			   		
			   		<div id="sitelist_body">
			   		
			   		<%
			   			for(int i = 0; i < 20; i++) {
			   		%>
			   		
			   			<div class="sitelist_elements" onclick="moveTo()">
			   				<div class="sitelist_elements_id col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
			   					0001
			   				</div>
			   				<div class="sitelist_elements_sitename col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6">
			   					가나다라
			   				</div>
			   				<div class="sitelist_elements_manager col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
			   					담당자
			   				</div>
			   				<div class="sitelist_elements_capacity col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
			   					123.00 kW
			   				</div>
			   				<div class="sitelist_elements_output col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
			   					12,345.00 kW
			   				</div>
			   				<div class="sitelist_elements_accuoutput col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
			   					123,456.00 kWh
			   				</div>
			   				<div class="sitelist_elements_builddate col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
			   					2000 년도
			   				</div>
			   				<div class="sitelist_elements_state col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
			   					R
			   				</div>
			   			</div>
			   		<%
			   			}
			   		%>
			   		</div>
			   </div> 		 --%>
			   
			   <table>
			   		<thead>
				   		<tr id="sitelist_header">
					   			<td class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">ID</td>
					   			<td class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6">발전소명</td>
					   			<td class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">담당자</td>
					   			<td class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">설비용량</td>
					   			<td class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">현재출력</td>
					   			<td class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">누적발전량</td>
					   			<td class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">설치연도</td>
					   			<td class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">상태</td>
				   		</tr>
			   		</thead>
			   		<tbody>
			   			<%
				   			for(int i = 0; i < 20; i++) {
				   		%>
				   		
			   			<tr class="sitelist_elements" onclick="moveTo()">
			   				<td class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1"><div class="sitelist_elements_id"><a>0001</a></div></td>
				   			<td class="sitelist_elements_sitename col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6">가나다라가나다라가나다라</td>
				   			<td class="sitelist_elements_manager col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">담당자</td>
				   			<td class="sitelist_elements_capacity col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">123.00 kW</td>
				   			<td class="sitelist_elements_output col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">12,345.00 kW</td>
				   			<td class="sitelist_elements_accuoutput col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">123,456.00 kWh</td>
				   			<td class="sitelist_elements_builddate col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">2000 년도</td>
				   			<td class="sitelist_elements_state col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">●</td>
			   			</tr>
			   			
			   			<%
				   			}
				   		%>
			   		</tbody>		   		
			   </table>
		
		<script>
			function moveTo() {
				document.location = "#";
			}
		
			$(document).ready(function() {
				
			})
		</script>   	
    </body>
</html>