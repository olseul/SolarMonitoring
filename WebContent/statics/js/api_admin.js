

/*
 * 
 */

function changeSite(select){
	
	setCookie("sid", $(select).val());
	start();
}

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


/*
 *발전소 선택 목록 
 *
 *
*/

function selectSite(sid, callback){
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/selectsite",
	  "method": "GET",
	  "headers": {
	    "authorization": authorization,
	    "cache-control": "no-cache"
	  }
	}

	$.ajax(settings).done(function (response) {
	  console.log(response);
	  
	  for(i=0; i< response.length; i++) {
		  
		  var selected = '';
		  
		  if (sid && sid == response[i].sid) {
			  selected = " selected ";
		  }
		  
		  
		  var option = "<option value="+response[i].sid+selected+">"+response[i].name + "</option>";
		  
		  $("#site-select").append(option);
		  
		
	  }
	  
	  
	  $("#site-select-area").show();
	  
	  callback();
	  
	});
}


/*
 *select User List 
 *
 *
*/

function selectUserList(tel,name, callback){
	var settings = {
	  "async": true,
	  "crossDomain": true,
	  "url": api_host+"/api/users?tel="+tel+"&name="+name,
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

