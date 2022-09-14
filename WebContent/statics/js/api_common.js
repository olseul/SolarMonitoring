

var arr_weather = ['','맑음','약간흐림','흐림','우전','소나기','뇌우','눈'];



/**
 * SID 값 읽기
 */

function read_sid() {
	var sid = getCookie("sid");
	if (!sid ) {
		sid = $("#site-select").val();
		if(sid)
			setCookie("sid", sid);
	}
	
	return sid;
}


/*
 *  read new event
 * 
 * 
 */

function read_new_event(sid, callback){
	
	
	if (!sid) {
		console.log("[read_new_event] sid is not valid~~");
		return;
	}

	
	var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/newevent",
		  "method": "GET",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
		} 

		$.ajax(settings).done(function (res) {
		  
			console.log(res);
			callback(res);
	 
		});
	
}

function check_new_event(sid) {
	var settings = {
			  "async": true,
			  "crossDomain": true,
			  "url": api_host+"/api/sites/" + sid + "/newevent",
			  "method": "PUT",
			  "headers": {
			    "authorization": authorization,
			    "cache-control": "no-cache"
			  }
			} 

			$.ajax(settings).done(function (res) {		 
			});
}

/*
 *  update new event
 * 
 * 
 */

function update_new_event(sid, callback){
	
	
	if (!sid) {
		console.log("[update_new_event] sid is not valid~~");
		return;
	}

	
	var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/"+sid+"/newevent",
		  "method": "PUT",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
		} 

		$.ajax(settings).done(function (res) {
		  
			console.log(res);
			callback(res);
	 
		});
	
}



/**
 * 날씨정보 읽기
 */

function read_weather(){
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/dashboard/weather",
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  
	  response.current.temperature = (response.current.temperature != undefined) ? response.current.temperature : "-";
	  response.current.humidity = response.current.humidity != undefined ? response.current.humidity : "-";
	  
	  $("#weather-temperature").html(response.current.temperature+"<em> ℃</em>");
	  $("#weather-humidity").html(response.current.humidity+"<em> %</em>");
	  $("#weather-snow").text(response.current.snow);
	  $("#weather-wind").text(response.current.windspeed);
	  $("#weather-info0").html(make_weather_info(response.current.weathercode,response.current.weatherphrase,1));
	  $("#weather-info1").html(make_weather_info(response.tomorrow.weathercode,"내일"));
	  $("#weather-info2").html(make_weather_info(response.after2day.weathercode,"모레"));
	});
}

function make_weather_info(code, phrase ,today){
	
	phrase = (phrase != undefined) ? phrase : "";
	
	if (today) {
		if(code == undefined || code == 0)
			return '<div class="weather-icon01"><img src="/statics/assets/images/weather0.png"  style="width:80px;height:80px;" alt="weather" /></div><div>'+phrase+'</div>';
		else
		return '<div class="weather-icon01"><img src="/statics/assets/images/weather'+code+'.svg"  style="width:128px;height:128px; margin-top:-20px; margin-bottom:-20px;" alt="weather" /></div><div>'+phrase+'</div>';
	} 
	
	if(code == undefined || code == 0)
		return '<div class="weather-icon03"><img src="/statics/assets/images/weather0.png"  style="width:80px;height:80px;" alt="weather" /></div><div>'+phrase+'</div>';
	else 
		return '<div class="weather-icon03"><img src="/statics/assets/images/weather'+code+'.svg"  style="width:80px;height:80px;" alt="weather" /></div><div>'+phrase+'</div>';
}

/*
 * Dashboard State
 * 
 * 설비동작 상태 조회
 */

function read_dashboard_state(callback){
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/dashboard/state",
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  callback(response);
	});
}




/*
 * Dashboard total
 * 
 * 전체 발전정보 및 발전 차트데이터 조회
 * 
 */

function read_dashboard_total(callback){
	
	$("#site-select").attr("disabled",true);
	$('.loading-panel').show();
	$('.loading-panel-user').show();
	
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/dashboard/total",
	  "method": "GET",
	  "headers": {
	    "authorization": authorization, 
	    "cache-control": "no-cache" 
	  }
	} 

	$.ajax(settings).done(function (response) { 
		$("#site-select").attr("disabled",false);
		$('.loading-panel').hide();
		$('.loading-panel-user').hide();
		console.log(response);
		callback(response);
	});
}


/*
 * Dashboard Sub Total
 * 
 * 발전소별 발전 정보
 */

function read_dashboard_subtotal(callback){
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/dashboard/subtotal",
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  callback(response);
	});
}



/*
 * ESS 정보 조회
 *
*/

function read_ess_detail(sid, callback){
	
	if (!sid) {
		console.log("[read_ess_detail] sid is not valid~~");
		return;
	}

	
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/sites/"+sid,
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  
	  if (response.device && response.device.ess){
	  
		var deviceid = response.device.ess[0].deviceid;

		var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/"+sid+"/ess/"+deviceid+"/details",
		  "method": "GET",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
		} 

		$.ajax(settings).done(function (res) {
		  
			console.log(res);
			callback(res);
		 
		});
	 
		
	  } else {
		  callback(null);
	  }
	});
	
	
	
}


/*
 * 태양광 모니터링
 * 
 * 발전소지도 정보
 *
*/

function read_mapdata(sid, callback){
	
	if (!sid) {
		console.log("[read_mapdata] sid is not valid~~");
		return;
	}

	
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/sites/"+sid+"/mapdata",
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  
	  callback(response);
	});
	
	
}

/*
 * 태양광 모니터링
 * 
 * 발전소지도 센서 정보
 *
*/

function read_localsensor(sid, callback){
	
	if (!sid) {
		console.log("[read_localsensor] sid is not valid~~");
		return;
	}

	
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/sites/"+sid+"/localsensor",
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  
	  callback(response);
	});
	
	
}


/*
 * 태양광 모니터링
 * 
 * 발전소지도 발전현황
 *
*/

function read_sitegeneration(sid, callback){
	$("#site-select").attr("disabled",true);
	$(".site-info > .loading-panel").show();
	if (!sid) {
		console.log("[read_sitegeneration] sid is not valid~~");
		return;
	}

	
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/sites/"+sid+"/sitegeneration",
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
		$("#site-select").attr("disabled",false);
	  console.log(response);
	  $(".site-info > .loading-panel").hide();
	  callback(response);
	});
	
	
}

/*
 * 태양광 모니터링
 * 
 * 인버터별 발전현황 및 차트데이터
 *
*/

function read_invertersgeneration(sid, callback){
	if (!sid) {
		console.log("[read_invertersgeneration] sid is not valid~~");
		return;
	}
	console.log("read_invertersgeneration : " + "/api/sites/"+sid+"/invertersgeneration");
	console.log("Authorization : " + authorization);
	
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/sites/"+sid+"/invertersgeneration",
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  callback(response);
	});
	
	
}

/*
 * 태양광 모니터링
 * 
 * 오늘일별월별 차트 데이터
 *
*/

function read_chartdata(sid, callback){
	$("#site-select").attr("disabled",true);
	$("#pills-graph01 > .no-loading-panel > .loading-icon").show();
	$("#pills-graph01 > .loading-panel").show();
	if (!sid) {
		console.log("[read_invertersgeneration] sid is not valid~~");
		return;
	}

	
	var settings = [ {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/sites/"+sid+"/chartdata?period=today",
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	}, {
		"async" : true,
		"crossDomain" : true,
		"url": api_host+"/api/sites/"+sid+"/chartdata?period=daily",
		  "method": "GET",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
	}, {
		"async" : true,
		"crossDomain" : true,
		"url": api_host+"/api/sites/"+sid+"/chartdata?period=monthly",
		  "method": "GET",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
	}
	];

	$.ajax(settings[0]).always(function (response) {
	  $("#site-select").attr("disabled",false);
	  $("#pills-graph01 > .no-loading-panel > .loading-icon").hide();
	  $("#pills-graph01 > .loading-panel").hide();
	  console.log(response);
	  callback(response);
	  
	  	$.ajax(settings[1]).always(function (response) {
		  console.log(response);
		  callback(response); 
		  
		  $.ajax(settings[2]).done(function (response) {
			  console.log(response);
			  callback(response);  
			});
		});
	});
}


/*
 * ESS 동작 조회
 *
*/

function read_ess_state(sid, callback){
	
	if (!sid) {
		console.log("[read_ess_state] sid is not valid~~");
		return;
	}

	
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/sites/"+sid,
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  
	  if (response.device && response.device.ess){
	  
		var deviceid = response.device.ess[0].deviceid;

		var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/"+sid+"/ess/"+deviceid+"/state",
		  "method": "GET",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
		} 

		$.ajax(settings).done(function (res) {
		  
			console.log(res);
			callback(res);
		 
		});
	 
		
	  }
	});
	
	
}



/*
* ESS동작 제어
*/

function update_ess_state(sid, isoperating, cb, laststate) {
	
	
	if (!sid) {
		console.log("[read_ess_state] sid is not valid~~");
		return;
	}

	
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/sites/"+sid,
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  
	  if (response.device && response.device.ess){
	  
		var deviceid = response.device.ess[0].deviceid;

		var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/"+sid+"/ess/"+deviceid+"/state",
		  "method": "PUT",
		  "headers": {
		    "content-type": "application/json;charset=utf-8",
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  },
		  "data": "{\r\n    \"isoperating\" : " + isoperating + "\r\n}"
		}

		
		$.ajax(settings).always(function (_res,r,t) {
			if(_res.status == 409) {
				alert("ESS 장치와 데이터 교환에 실패했습니다.\n네트워크 연결 상태를 확인해 주세요.");
				cb.prop("checked",laststate);
			}
			
			$("#control-operate").prop("disabled","");
		});
	  }
	});
	
	
}


/*
 * Solar Device Control
 * 동작모드 조회
 *
*/

function read_solar_state(sid, callback){
	
	if (!sid) {
		console.log("[read_solar_state] sid is not valid~~");
		return;
	}

	
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/sites/"+sid +"/trackers/state",
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  
	  callback(response);
	 
		
	});
	
	
}


/*
 * Solar Device control
 * 동작 모드 제어
 * 
 */

function update_solar_state(sid, update_type, isauto, modecode, callback){
	
	var res_json = {
			"res_code":0,
			"update_type":update_type,
			"isauto":isauto,
			"modecode":modecode
	}
	
	if (!sid) {
		console.log("[update_solar_state] sid is not valid~~");
		return;
	}

	
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/sites/"+sid,
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  
	  if (response.device && response.device.tracker){
	  
		var deviceid = response.device.tracker[0].deviceid;

		var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/"+sid+"/trackers/state",
		  "method": "PUT",
		  "headers": {
		    "content-type": "application/json;charset=utf-8",
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  },
		  "data": "{\r\n    \"isauto\" : "+isauto+",\r\n    \"modecode\" : "+modecode+"\r\n}"
		} 

		$.ajax(settings).always(function (res,t,r) {
		  
			if(r.status == 200) { 
				console.log(res);
				callback(res_json);
			} else if (res.status == 409) {
				alert("트랙커 네트워크와 통신에 실패하였습니다.\n네트워크 연결 상태를 다시 확인해 주세요.");
				$("#auto-mode").prop("checked", $("#last_automode") == true ? "" : "checked");
				// mode 
				
			}
			$("#auto-mode").prop("disabled","");
		 
		});
	 
		
	  } else {
		  res_json.res_code = 1;
		  callback(res_json);
	  }
	});
	
	
}


/*
 * ESS Soc
 * 
 * 
 */

function read_ess_soc(sid, callback){
	
	
	if (!sid) {
		console.log("[update_solar_state] sid is not valid~~");
		return;
	}

	
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/sites/"+sid,
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  
	  if (response.device && response.device.ess){
	  
		var deviceid = response.device.ess[0].deviceid;

		var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/"+sid+"/ess/socstate",
		  "method": "GET",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
		} 

		$.ajax(settings).done(function (res) {
		  
			console.log(res);
			callback(res);
		 
		});
	 
		
	  } else {
		 
		  callback(null);
	  }
	});
	
	
}

/*
 * ESS schedule list
 * 
 * 
 */

function read_ess_schedule_list(sid, callback){
	
	
	if (!sid) {
		console.log("[update_solar_state] sid is not valid~~");
		return;
	}

	
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/sites/"+sid,
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	} 

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  
	  if (response.device && response.device.ess){
	  
		var deviceid = response.device.ess[0].deviceid;

		var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/"+sid+"/ess/schedules",
		  "method": "GET",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
		} 

		$.ajax(settings).done(function (res) {
		  
			console.log(res);
			callback(res);
		 
		});
	 
		
	  } else {
		 
		  callback(null);
	  }
	});
	
	
}

/*
 * ESS schedule detail
 * 
 * 
 */

function read_ess_schedule_detail(sid,schedule_id, callback){
	
	
	if (!sid) {
		console.log("[read_ess_schedule_detail] sid is not valid~~");
		return;
	}

	
	var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/"+sid+"/ess/schedules/"+schedule_id,
		  "method": "GET",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
		} 

		$.ajax(settings).done(function (res) {
		  
			console.log(res);
			callback(res);
		 
			});
	
	
}

/*
 * create ESS schedule
 * 
 * 
 */

function create_ess_schedule(sid,data, callback){

var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": "/admin/" + sid + "/schedules",
		  "method": "POST",
		  "headers": {
			  "content-type": "application/json;charset=utf-8",
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  },
		  "data": data
		}

		$.ajax(settings).always(function (response,t,r) {
		  console.log(response);
		  
		  if (callback){
			  callback(response,t,r);
		  }
		  
		});

		

}

/*
 * update ESS schedule
 * 
 * 
 */

function update_ess_schedule(sid,schedule_id,data, callback){

var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": "/admin/" + sid + "/schedules/"+schedule_id,
		  "method": "PUT",
		  "headers": {
			 "content-type": "application/json;charset=utf-8",
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  },
		  "data": data
		}

		$.ajax(settings).always(function (response,t,r) {
		  console.log(response);
		  
		  if (callback){
			  callback(response,t,r);
		  }
		  
		});

}


/*
 * Delete ESS schedule
 * 
 * 
 */

function delete_ess_schedule(sid,schedule_id, callback){

	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/sites/"+sid+"/ess/schedules/"+schedule_id,
	  "method": "DELETE",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	}

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  
	  if (callback){
		  callback(response);
	  }
	  
	});

}


/*
 *  read ess trade info
 * 
 * 
 */

function read_trade_info(sid,subject, callback){
	
	
	if (!sid) {
		console.log("[read_trade_info] sid is not valid~~");
		return;
	}

	
	var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/"+sid+"/ess/trade?subject="+subject,
		  "method": "GET",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
		} 

		$.ajax(settings).done(function (res) {
		  
			console.log(res);
			callback(subject, res);
	 
		});
	
}




/*
 *  read statistics generation 
 * 
 * 
 */

function read_statistics_current(sid,period, start_date,end_date, callback){
	$("#site-select").attr("disabled",true);
	$(".col-md-12.mb-5 > .loading-panel").show();
	
	if (!sid) {
		console.log("[read_statistics_current] sid is not valid~~");
		return;
	}

	
	var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/"+sid+"/statistics/generation?period="+period+"&date_start="+start_date+"&date_end="+end_date,
		  "method": "GET",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
		} 

		$.ajax(settings).done(function (res) {
			$("#site-select").attr("disabled",false);
		    $(".col-md-12.mb-5 > .loading-panel").hide();
			console.log(res);
			callback(period, res);
	 
		});
	
}



/*
 *  read statistics Benefit 
 * 
 * 
 */

function read_statistics_benefit(sid,period, date, callback){
	$("#site-select").attr("disabled",true);
	$(".col-md-12.mb-5 > .loading-panel").show(); 
	
	if (!sid) {
		console.log("[read_statistics_benefit] sid is not valid~~");
		return;
	}

	
	var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/"+sid+"/statistics/benefit?period="+period+"&date="+date,
		  "method": "GET",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
		} 

		$.ajax(settings).done(function (res) {
			$("#site-select").attr("disabled",false);
			$(".col-md-12.mb-5 > .loading-panel").hide();
			console.log(res);
			callback(period, res);
	 
		});
	
}


/*
 *  read management Export report 
 * 
 * 
 */

function read_export_report(sid,period, year, callback){
	
	
	if (!sid) {
		console.log("[read_export_report] sid is not valid~~");
		return;
	}

	
	var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/"+sid+"/reports?period="+period+"&year="+year,
		  "method": "GET",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
		} 

		$.ajax(settings).done(function (res) {
		  
			console.log(res);
			callback(period, res);
	 
		});
	
}


/*
 *  read management device event 
 * 
 * 
 */

function read_device_event(sid,devicetype, eventlevel, date_start, date_end, callback){
	
	
	if (!sid) {
		console.log("[read_device_vent] sid is not valid~~");
		return;
	}
	
	console.log("url:" + api_host+"/api/sites/"+sid+"/deviceevent?devicetype="+devicetype+"&eventlevel="+eventlevel+"&date_start="+date_start+"&date_end="+date_end);

	
	var settings = {
		  "async": true,
		  "crossDomain": true,
		  "url": api_host+"/api/sites/"+sid+"/deviceevent?devicetype="+devicetype+"&eventlevel="+eventlevel+"&date_start="+date_start+"&date_end="+date_end,
		  "method": "GET",
		  "headers": {
		    "authorization": authorization,
		    "cache-control": "no-cache"
		  }
		} 

		$.ajax(settings).done(function (res) {
		  
			console.log(res);
			callback( res );
	 
		});
	
}

function displayCurrentTime(){
	var time = getDateTime();
	
	$("#current-time").text(time);
}



function displayNavigation(datas){
	
	console.log("displayNavigationNew called..");
	
	if ( !datas || datas.length == 0){
		var nav_html = '<ul class="pagination justify-content-center"> ';
		nav_html += '<li class="page-item active"  ><a class="page-link" >1</a></li>';
		nav_html += '</ul>';
		$("#navigation").html(nav_html);
		
		return;
	}
	
	var totalCount = datas.length;
	var pageNo = 1;
	var pageSize = 10;
	var countPerPage = 10;
	if (curPage) pageNo = curPage;
	if (sizePerPage) countPerPage = sizePerPage;
	
	
	
	var currentPage = 0;
	var zone = parseInt(pageNo/pageSize);
	
	var nav_html = '<ul class="pagination justify-content-center"> ';
	
	if (zone > 0) {
		nav_html += '<li class="page-item "><a class="page-link" href="javascript:goPage('+1+');">처음</a>';
		nav_html += '</li>';
		
		nav_html += '<li class="page-item "><a class="page-link" href="javascript:goPage('+((pageNo>2)?(pageNo-1):1)+');">이전</a>';
		nav_html += '</li>';
	}
	
	var count = 0;
	
//	for(i=zone; i<totalCount && i<(zone+pageSize)*countPerPage; i+=countPerPage) {
//		count++;
//		currentPage = zone+count;
//		
//		if(currentPage == pageNo){
//			nav_html += '<li class="page-item active"  ><a class="page-link" >'+currentPage+'</a></li>';
//
//		} else {
//			nav_html += '<li class="page-item "  ><a class="page-link" href="javascript:goPage('+currentPage+')">'+currentPage+'</a></li>';
//
//		}
//	}
	
	// mod #1
	
//	for(i=zone; i<=Math.ceil(totalCount/countPerPage); i+=countPerPage) {
//		count++;
//		currentPage = (zone*(pageSize))+count;
//		
//		if(currentPage == pageNo){
//			nav_html += '<li class="page-item active"  ><a class="page-link" >'+currentPage+'</a></li>';
//
//		} else {
//			nav_html += '<li class="page-item "  ><a class="page-link" href="javascript:goPage('+currentPage+')">'+currentPage+'</a></li>';
//
//		}
//	}
	
	// mod #2, 21-09-06 ; add first/last page & fix paging bug when turn over 12 page
	for(i=0; i<= pageSize && (zone*pageSize)+i <= Math.ceil(totalCount/countPerPage); i++) {
		count+=pageSize;
		currentPage = (zone*pageSize)+i;
		
		if (currentPage == pageNo) {
			nav_html += '<li class="page-item active"  ><a class="page-link" >'+currentPage+'</a></li>';
		} else if (currentPage != 0) {
			nav_html += '<li class="page-item "  ><a class="page-link" href="javascript:goPage('+currentPage+')">'+currentPage+'</a></li>';
		}
	}
	
	currentPage = count+1;
	// End of mod #2 
	
	//currentPage=Math.ceil(i/pageSize)+1;
	
	console.log("totalCount : "+ totalCount);
	console.log("zone : "+ zone);
	console.log("(totalCount/countPerPage) : "+ (totalCount/countPerPage));
	console.log("(zone+1)*pageSize : "+ (zone+1)*pageSize);
	
	if ( (totalCount/countPerPage) > (zone+1)*pageSize ) {
		nav_html += '<li class="page-item">';
		nav_html += '<a class="page-link" href="javascript:goPage('+(((pageNo+1)<currentPage)?(pageNo+1):currentPage)+')">다음</a>';
		nav_html += '</li>';
		
		nav_html += '<li class="page-item">';
		nav_html += '<a class="page-link" href="javascript:goPage('+Math.ceil(totalCount/countPerPage)+')">마지막</a>';
		nav_html += '</li>';
	}
	
	nav_html += '</ul>';
	
	$("#navigation").html(nav_html);
	
}
