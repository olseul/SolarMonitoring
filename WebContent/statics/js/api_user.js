

/**
 * 전체발전 정보 및 발전 차트
 */

function dashboard_ReadTotal(){
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
	  console.log(response);
	  
	});
}