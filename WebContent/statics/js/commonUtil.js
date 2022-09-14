  function isNullString(elem){
	    var flag =true;
	    if( typeof elem !="undefined" && ( elem!=null) && ( $.trim(elem)!="")){
	        flag=false;
	    }
	    return flag;
	}

  /*
   * 금액 3자리마다 콤마 삽입.
   */
  function numberWithCommas(val) {
      if(val.indexOf('.') >= 0){
          var tmp=val.split(".");//입력 문자열을 .으로 나누어 담음
          return (tmp[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")) +"."+tmp[1];
      }else return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }
  
  
  /*
   * Email 주소 검증
   */
  
  function verifyEmail(email) {
	  // 이메일 검증 스크립트 작성
	  var emailVal = email;

	  var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	  // 검증에 사용할 정규식 변수 regExp에 저장

	  if (emailVal.match(regExp) != null) {
	    return true;
	  }
	  else {
	   return false;
	  }
  };
  
  /*
  *	입력값을 숫자만 남도록 필터링함.
  */
  
  function onlyNumber(obj) { $(obj).keyup(function(){ $(this).val($(this).val().replace(/[^0-9.-]/g,"")); }); }
  function onlyNumberLimit(obj, limit) {
	  $(obj).keyup(function(){ 
		  
		  var val = $(this).val();
		  
		  console.log("length:" + val.length);
		  
		  $(this).val($(this).val().replace(/[^0-9.-]/g,""));   
		 
		  	
		  	if (val.length > limit) {
		  		$(this).val(val.substring(0,limit));
		  	}
	  }); 
  }
  
  function onlyInteger(obj) { $(obj).keyup(function(){ $(this).val($(this).val().replace(/[^0-9]/g,"")); }); }
  function onlyInteger(obj,limit) { $(obj).keyup(function(){ $(this).val(new RegExp("[0-9]{0," + limit +"}").exec($(this).val())); }); }
  
  function onlyFixedLimit(obj, limit) {
	  $(obj).keyup(function(){ 
		  
		  var val = $(this).val();
		  $(this).val(new RegExp("^[0-9]{1,}([.][0-9]{0," + $(limit) + "})?").exec($(this).val()));
	  }); 
  	  	
  }
  
  function onlyFixedLimit(obj, limit1,limit2) {
	  $(obj).keyup(function(){ 
		  
		  var val = $(this).val();	  
		  $(this).val(new RegExp("^[0-9]{0," + limit1 + "}([.][0-9]{0," + limit2 + "})?").exec($(this).val())[0]);
	  }); 
  	  	
  }
  
  function onlyPhone(obj) {
	  $(obj).keyup(function(){ 
		  
		  var val = $(this).val();
		  
		  $(this).val(new RegExp("^[0-9]{0,3}([-][0-9]{0,4})?([-][0-9]{0,4})?").exec($(this).val())[0]);
	  }); 
  	  	
  }
  
  function onlyDate(obj) {
	  $(obj).keyup(function(){ 
		  
		  var val = $(this).val();
		  
		  $(this).val(new RegExp("^[0-9]{0,4}([-](([1]{1}[0-2]{0,1})|[0]{1}[1-9]{0,1})?)?([-](([0]{1}[1-9]{0,1})|[1-2]{1}[0-9]{0,1}|([3]{1}[0-1]{0,1}))?)?").exec($(this).val())[0]);
	  }); 
  }
  
  function onlyIP(obj) {
	  $(obj).keyup(function(){ 
		  
		  var val = $(this).val();
		  
		  $(this).val(new RegExp("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$").exec($(this).val()));
	  }); 
  }
  
  function fillSpaceToZeroPad(value){
	  
	  var val = new String(value);
	  
	  var rtnStr = '';
	  
	  for(i=0; i<(4-val.length); i++){
		  rtnStr +='0';
	  }
	  
	  return rtnStr ;
  }
  
  
  /*
   * 쿠키 저장
   */
  
	function setCookie(key, value) {
		$.cookie(key, value, { expires: 1, path: '/',  secure: false });
	}
		  
	function getCookie(key){
		return $.cookie(key);
	}
	
	
	/*
	 * 2020.3.19(목) 15:12
	 */
	
	function getDateNow(){
		var days = ["일","월","화","수","목","금","토"];
		var date = new Date();
		var strDate = date.getFullYear() + "." + (date.getMonth()+1) + "." +date.getDate()+"("+days[date.getDay()]+") " +  ('0' + (date.getHours() )).slice(-2) +":"+('0' + (date.getMinutes() )).slice(-2) ;
		
		return strDate;
	}
	
	function getDateTime(){
		
		var date = new Date();
		var strDate = date.getFullYear() + "." + (date.getMonth()+1) + "." +date.getDate()+" " + ('0' + (date.getHours() )).slice(-2) +":"+('0' + (date.getMinutes() )).slice(-2)+":" + ('0' + (date.getSeconds())).slice(-2) ;
		
		return strDate;
	}
	
	function getDateStr(myDate){
		var year = myDate.getFullYear();
		var month = (myDate.getMonth() + 1);
		var day = myDate.getDate();
		
		month = (month < 10) ? "0" + String(month) : month;
		day = (day < 10) ? "0" + String(day) : day;
		
		return  year + '-' + month + '-' + day ;
	}
	
	function encrypt(p, m, e) {
		console.log(p.phone);
		console.log(p.password);
		console.log(m);
		console.log(e);
		
		var rsa = new RSAKey();
		
		rsa.setPublic(m,e);
		
		return { phone : rsa.encrypt(p.phone), password : rsa.encrypt(p.password)};
	}
	