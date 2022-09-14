<%@page import="com.sungchang.common.util.APIHostUtil"%>
<%@page import="com.sungchang.common.util.StringUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="./juitest_header.jsp" %> 

<style>

	#contents {
		margin-top: 65px!important;
	}
	
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
	
	#search_filter {
	    display: flex;
	    align-items: center;
	    flex-direction: row;
	    flex-wrap: wrap;
	}
	
	#search_button_5 {
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
    }
	
	#icon_5 {
		width: 25px!important;
	    margin: 10px 0px;
	    padding: 0px;
	}
	
	#select1, #select2 {
	    width: 40%!important;
    	margin: 0px 35px;
	}
	
	.list_main {
		width: 100%;
    	margin: 20px auto 0px;
    	text-align: center;
	}	
	
	.contents {
		display: inline-block;
    	width: 28%;
		border: 1px solid #ffffff;
		border-radius: 3px;
    	margin: 0px 5px 30px;
    	background-color: #464650;
	}
	
	.month_title {
		margin: 10px 0px 0px 0px;
		color: #ffffff;
	}
	
	.icon-report:before {
		content: "\E98F";
		font-size: 40px;
		color: #8c8c8f;
	}
	
	/* 태블릿 */
	@media (min-width: 769px) and (max-width: 1199px) {
		#select1, #select2 {
		    width: 33%!important;
   			margin: 0px 35px;
		}
	}
	
	/* 모바일 */
	@media (min-width: 360px) and (max-width: 768px) {
		#contents {
			padding-left: 0px!important;
		}
		
		#select1, #select2 {
		    width: 38%!important;
    		margin: 0px 15px;
		}
	}
	
</style>


<!DOCTYPE html>
   				<div id="search">
				   		<div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 col-xl-9" id="search_filter">
				   			
				   			<select class="col-xs-12 col-sm-12 col-md-10 col-lg-2 col-xl-2 input" id="select1" onchange="func1(this)">
			   					<option selected value="연도">연도</option>
			   					<option value="분기">분기</option>
			   				</select>
			   					
				   				<select class="col-xs-12 col-sm-12 col-md-10 col-lg-2 col-xl-2 input" id="select2">
			   						<option selected value="2022">2022</option>
			   						<option value="2021">2021</option>
			   						<option value="2020">2020</option>
			   						<option value="2019">2019</option>
			   						<option value="2018">2018</option>
			   						<option value="2017">2017</option>
			   						<option value="2016">2016</option>
			   					</select><br>
			   					
				   		</div>
				   		<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-3">
					   		<a class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8 btn focus" draggable="false" id="search_button_5">
					   			<img id="icon_5" class="col-xs-10 col-sm-4 col-md-1 col-lg-1 col-xl-1" src="/statics/assets/images/search.png"/> 
					   			<p id="label_5" class="col-xs-12 col-sm-12 col-md-4 col-lg-6 col-xl-8">검 색</p>
					   		</a> 
				   		</div>
				   	</div>
				   	
				   	<div class="list_main">
				   			<div class = "contents"> 
				   				<p class = "month_title"> 1월 </p>
				   				<p class = 'icon-report'></p>
				   			</div>
				   			
				   			<div class = "contents">
				   				<p class = "month_title"> 2월 </p>
				   				<p class = 'icon-report'></p>
				   			</div>
				   			
				   			<div class = "contents">
				   				<p class = "month_title"> 3월 </p>
				   				<p class = 'icon-report'></p>
				   			</div>
					   		
					   		<div class = "contents">
					   			<p class = "month_title"> 4월 </p>
				   				<p class = 'icon-report'></p>
					   		</div>

					   		<div class = "contents">
					   			<p class = "month_title"> 5월 </p>
				   				<p class = 'icon-report'></p>
					   		</div>

					   		<div class = "contents">
					   			<p class = "month_title"> 6월 </p>
				   				<p class = 'icon-report'></p>
					   		</div>

				   			<div class = "contents">
				   				<p class = "month_title"> 7월 </p>
				   				<p class = 'icon-report'></p>
				   			</div>

				   			<div class = "contents">
				   				<p class = "month_title"> 8월 </p>
				   				<p class = 'icon-report'></p>
				   			</div>

				   			<div class = "contents">
				   				<p class = "month_title"> 9월 </p>
				   				<p class = 'icon-report'></p>
				   			</div>

					   		<div class = "contents">
					   			<p class = "month_title"> 10월 </p>
				   				<p class = 'icon-report'></p>
					   		</div>

					   		<div class = "contents">
					   			<p class = "month_title"> 11월 </p>
				   				<p class = 'icon-report'></p>
					   		</div>

					   		<div class = "contents">
					   			<p class = "month_title"> 12월 </p>
				   				<p class = 'icon-report'></p>
					   		</div>

				   		</div>
				   	</div>
			   	</div>

  
		
		<script>
			function func1(str) {
				var func1_a = ["2022", "2021", "2020", "2019", "2018", "2017", "2016"];
				var func1_b = ["1분기", "2분기", "3분기", "4분기"];
				var target = document.getElementById("select2");
				
				if(str.value == "연도") var d = func1_a;
				else if (str.value == "분기") var d = func1_b;
				
				target.options.length = 0;
				
				for (x in d) {
					var opt = document.createElement("option");
					opt.value = d[x];
					opt.innerHTML = d[x];
					target.appendChild(opt);
				}
			}
			
			
			
			$(document).ready(function() {
			
			})
			
		</script>   	
    </body>
</html>