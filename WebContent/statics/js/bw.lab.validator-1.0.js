
//lab-bluewaves-validator 에서 ValidatorForm 을 사용할경우 true
//일반적으로 사용시 false 로 사용
//true => 다국어 지원
//false => 한글만 지원

//<![CDATA[

var _isUseAnnotationValidatorForm = true;

var _isSubmit = false;

var _this = [];

jQuery(document).ready(function() {
	
	jQuery("form").each(function(i) {
		
		this._submit = this.submit; //submit copy
		_this.push(this); //this copy
		
		//submit override
		jQuery.prototype.submit = function(submitByOriginal) {
			
			var idx = jQuery("form").index(this);
			
			if(!submitByOriginal) { //일반적인 사용
				
				if(_isSubmit) {
					//다국어 처리시 아래 문장을 다국어 js 를 활용하여 처리하세요.
					alert("이미 처리중입니다. 잠시만 기다려 주십시오.");
					return;
				}
				
				//_isSubmit = true;
				
				if(privateFormValidator(_this[idx], false)) {
					_this[idx]._submit(); //submit
				} else {
					_isSubmit = false;
				}
				
			} else { //강제로 true 값 사용
				
				privateFormValidator(_this[idx], true);
				
				_this[idx]._submit(); //submit
			}
		};
	});
});

function privateFormValidator(formObject, isBypass) {
	
	var isReturn = true;

	jQuery(formObject).find(':input').each(function() {
		
		if(!isBypass) {
			
			// Test for REQUIRED
			if(String(jQuery(this).attr('class')) != "undefined" && jQuery(this).attr('class').indexOf('[REQUIRED') > -1) {
				//치환 메시지 있음
				var tmpMsg = "";
				var _klibMsg = "";
				
				if(jQuery(this).attr('class').indexOf('[REQUIRED:') > -1) {
					tmpMsg = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('[REQUIRED:') + 10);
					_klibMsg = tmpMsg.substring(0, tmpMsg.indexOf(']'));
				}
				
				var jQueryval = jQuery.trim(jQuery(this).val());
				//var jQuerytext = jQuery.trim(jQuery(this).text());
				var jQueryname = jQuery(this).attr("name");
				var jQuerycheck = this.type.toLowerCase() == "checkbox" ? "" : true;
				var jQueryradio = this.type.toLowerCase() == "radio" ? "" : true;
				
				if (jQueryval.length == 0 || !jQuerycheck || !jQueryradio) {
					if(this.tagName.toLowerCase() == "select") {
						
						if(_isUseAnnotationValidatorForm) {
							alert(_klibMsg);
						} else {
							alert(_klibMsg + " 선택해 주십시오.");
						}
						
					} else {
						if (this.type.toLowerCase() == "checkbox") {
							if(_isUseAnnotationValidatorForm) {
								alert(_klibMsg);
							} else {
								alert(_klibMsg + " 체크해 주십시오.");
							}
						} else if (this.type.toLowerCase() == "radio") {
							if(_isUseAnnotationValidatorForm) {
								alert(_klibMsg);
							} else {
								alert(_klibMsg + " 선택해 주십시오.");
							}
						} else if (this.type.toLowerCase() == "textarea") {
							if(_isUseAnnotationValidatorForm) {
								alert(_klibMsg);
							} else {
								alert(_klibMsg + " 입력해 주십시오.");
							}
							
						} else {
							if(_isUseAnnotationValidatorForm) {
								alert(_klibMsg);
							} else {
								alert(_klibMsg + " 입력해 주십시오.");
							}
						}
					}
					
					jQuery(this).focus();
					
					isReturn = false;
					
					return false;
				}
			}
		}
		
		//최소 입력 금액 확인
		if(!isBypass && isReturn){
			if(String(jQuery(this).attr('class')) != "undefined" && jQuery(this).attr('class').indexOf('[MINLIMITNUMBER') > -1) {
				//치환 메시지 있음
				var tmpMinLimitNumber = "";
				var _minLimitNumber = "";
				var _klibMsg = "";
				
				if(jQuery(this).attr('class').indexOf('[MINLIMITNUMBER:') > -1) {
					tmpMinLimitNumber = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('[MINLIMITNUMBER:') + 16);
					_minLimitNumber = tmpMinLimitNumber.substring(0, tmpMinLimitNumber.indexOf(':'));
					_klibMsg = tmpMinLimitNumber.substring(tmpMinLimitNumber.indexOf(':') + 1, tmpMinLimitNumber.indexOf(']'));
				}
				
				var jQueryval = jQuery(this).val().replace(/,/g, "");
				
				if(jQueryval != ""){
					if (Number(jQueryval) > -1 && Number(jQueryval) < Number(_minLimitNumber.replace(/,/g, ""))) {
						
						if(_isUseAnnotationValidatorForm) {
							alert(_klibMsg);
						} else {
							alert(_klibMsg + " " + _minLimitNumber + " 이상 입력 가능합니다.");
						}
						
						jQuery(this).focus();
						isReturn = false;
						return false;
					}
				}
			}
		}
		
		//최대 입력 금액 확인
		if(!isBypass && isReturn){
			if(String(jQuery(this).attr('class')) != "undefined" && jQuery(this).attr('class').indexOf('[MAXLIMITNUMBER') > -1) {
				//치환 메시지 있음
				var tmpMaxLimitNumber = "";
				var _maxLimitNumber = "";
				var _klibMsg = "";
				
				if(jQuery(this).attr('class').indexOf('[MAXLIMITNUMBER:') > -1) {
					tmpMaxLimitNumber = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('[MAXLIMITNUMBER:') + 16);
					_maxLimitNumber = tmpMaxLimitNumber.substring(0, tmpMaxLimitNumber.indexOf(':'));
					_klibMsg = tmpMaxLimitNumber.substring(tmpMaxLimitNumber.indexOf(':') + 1, tmpMaxLimitNumber.indexOf(']'));
				}
				
				var jQueryval = jQuery(this).val().replace(/,/g, "");
				
				if(jQueryval != ""){
					if (Number(jQueryval) > -1 && Number(jQueryval) > Number(_maxLimitNumber.replace(/,/g, ""))) {
						
						if(_isUseAnnotationValidatorForm) {
							alert(_klibMsg);
						} else {
							alert(_klibMsg + " " + _maxLimitNumber + " 이하 입력 가능합니다.");
						}
						
						jQuery(this).focus();
						isReturn = false;
						return false;
					}
				}
			}
		}
		
		//이전 날짜인지 확인
		if(!isBypass && isReturn) {
			
			if(String(jQuery(this).attr('class')) != "undefined" && jQuery(this).attr('class').indexOf('[DATEPAST') > -1) {
				
				//치환 메시지 있음
				var tmpMsg = "";
				var _klibMsg = "";
				var _inputDate = null;
				
				if(jQuery(this).attr('class').indexOf('[DATEPAST:') > -1) {
					tmpMsg = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('[DATEPAST:') + 10);
					_klibMsg = tmpMsg.substring(0, tmpMsg.indexOf(']'));
				}
				
				var jQueryval = jQuery(this).val();
				
				if(jQueryval != ""){
					
					var isDateValid = true;
					
					if((jQueryval.length != 8 && jQueryval.length != 10)) {
						isDateValid = false;
					} else {
						
						if(jQueryval.length == 8) {
							
							var tmpYyyy = Number(jQueryval.substring(0, 4));
							var tmpMm = Number(jQueryval.substring(4, 6))-1;
							var tmpDd = Number(jQueryval.substring(6, 8));
							
							var tmpDate = new Date(tmpYyyy, tmpMm, tmpDd);
							
							if(tmpDate.toString() == "NaN" || tmpDate.toString() == "Invalid Date") {
								isDateValid = false;
							}
							
							_inputDate = tmpDate;
							
						} else if(jQueryval.length == 10 && jQueryval.indexOf('.') > -1) {
							
							var tmpDateAttr = jQueryval.split(".");
							
							if(tmpDateAttr.length != 3) {
								isDateValid = false;
							} else {
								var tmpYyyy = Number(tmpDateAttr[0]);
								var tmpMm = Number(tmpDateAttr[1])-1;
								var tmpDd = Number(tmpDateAttr[2]);
								
								var tmpDate = new Date(tmpYyyy, tmpMm, tmpDd);
								
								if(tmpDate.toString() == "NaN" || tmpDate.toString() == "Invalid Date") {
									isDateValid = false;
								}
								
								_inputDate = tmpDate;
							}
							
						} else if(jQueryval.length == 10 && jQueryval.indexOf('-') > -1) {
							
							var tmpDateAttr = jQueryval.split("-");
							
							if(tmpDateAttr.length != 3) {
								isDateValid = false;
							} else {
								var tmpYyyy = Number(tmpDateAttr[0]);
								var tmpMm = Number(tmpDateAttr[1])-1;
								var tmpDd = Number(tmpDateAttr[2]);
								
								var tmpDate = new Date(tmpYyyy, tmpMm, tmpDd);
								
								if(tmpDate.toString() == "NaN" || tmpDate.toString() == "Invalid Date") {
									isDateValid = false;
								}
								
								_inputDate = tmpDate;
							}
							
						} else {
							isDateValid = false;
						}
						
					}
					
					if(!isDateValid) {

						if(_isUseAnnotationValidatorForm) {
							alert(_klibMsg);
						} else {
							alert(_klibMsg + " 현재 날짜 부터 이전으로 가능합니다.");
						}
						
						jQuery(this).focus();
						isReturn = false;
						return false;
					} else {
						
						var now = new Date();
						
						if(now < _inputDate) {
							
							if(_isUseAnnotationValidatorForm) {
								alert(_klibMsg);
							} else {
								alert(_klibMsg + " 현재 날짜 부터 이전으로 가능합니다.");
							}
							
							jQuery(this).focus();
							isReturn = false;
							return false;
						}
						
					}
				}
			}
		}
		
		//이후 날짜인지 확인
		if(!isBypass && isReturn) {
			
			if(String(jQuery(this).attr('class')) != "undefined" && jQuery(this).attr('class').indexOf('[DATEFUTURE') > -1) {
				
				//치환 메시지 있음
				var tmpMsg = "";
				var _klibMsg = "";
				var _inputDate = null;
				
				if(jQuery(this).attr('class').indexOf('[DATEFUTURE:') > -1) {
					tmpMsg = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('[DATEFUTURE:') + 12);
					_klibMsg = tmpMsg.substring(0, tmpMsg.indexOf(']'));
				}
				
				var jQueryval = jQuery(this).val();
				
				if(jQueryval != ""){
					
					var isDateValid = true;
					
					if((jQueryval.length != 8 && jQueryval.length != 10)) {
						isDateValid = false;
					} else {
						
						if(jQueryval.length == 8) {
							
							var tmpYyyy = Number(jQueryval.substring(0, 4));
							var tmpMm = Number(jQueryval.substring(4, 6))-1;
							var tmpDd = Number(jQueryval.substring(6, 8));
							
							var tmpDate = new Date(tmpYyyy, tmpMm, tmpDd);
							
							if(tmpDate.toString() == "NaN" || tmpDate.toString() == "Invalid Date") {
								isDateValid = false;
							}
							
							_inputDate = tmpDate;
							
						} else if(jQueryval.length == 10 && jQueryval.indexOf('.') > -1) {
							
							var tmpDateAttr = jQueryval.split(".");
							
							if(tmpDateAttr.length != 3) {
								isDateValid = false;
							} else {
								var tmpYyyy = Number(tmpDateAttr[0]);
								var tmpMm = Number(tmpDateAttr[1])-1;
								var tmpDd = Number(tmpDateAttr[2]);
								
								var tmpDate = new Date(tmpYyyy, tmpMm, tmpDd);
								
								if(tmpDate.toString() == "NaN" || tmpDate.toString() == "Invalid Date") {
									isDateValid = false;
								}
								
								_inputDate = tmpDate;
							}
							
						} else if(jQueryval.length == 10 && jQueryval.indexOf('-') > -1) {
							
							var tmpDateAttr = jQueryval.split("-");
							
							if(tmpDateAttr.length != 3) {
								isDateValid = false;
							} else {
								var tmpYyyy = Number(tmpDateAttr[0]);
								var tmpMm = Number(tmpDateAttr[1])-1;
								var tmpDd = Number(tmpDateAttr[2]);
								
								var tmpDate = new Date(tmpYyyy, tmpMm, tmpDd);
								
								if(tmpDate.toString() == "NaN" || tmpDate.toString() == "Invalid Date") {
									isDateValid = false;
								}
								
								_inputDate = tmpDate;
							}
							
						} else {
							isDateValid = false;
						}
						
					}
					
					if(!isDateValid) {

						if(_isUseAnnotationValidatorForm) {
							alert(_klibMsg);
						} else {
							alert(_klibMsg + " 현재 날짜 부터 이후로 가능합니다.");
						}
						
						jQuery(this).focus();
						isReturn = false;
						return false;
					} else {
						
						var now = new Date();
						
						if(now > _inputDate) {
							
							if(_isUseAnnotationValidatorForm) {
								alert(_klibMsg);
							} else {
								alert(_klibMsg + " 현재 날짜 부터 이후로 가능합니다.");
							}
							
							jQuery(this).focus();
							isReturn = false;
							return false;
						}
						
					}
				}
			}
		}
		
		//정규식 패턴 확인
		if(!isBypass && isReturn) {
			
			if(String(jQuery(this).attr('class')) != "undefined" && jQuery(this).attr('class').indexOf('[REGEXP') > -1) {
				
				//치환 메시지 있음
				var tmpMsg = "";
				var _klibMsg = "";
				var _regexp = "";
				
				if(jQuery(this).attr('class').indexOf('[REGEXP:') > -1) {
					tmpMsg = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('[REGEXP:') + 8);
					_regexp = tmpMsg.substring(0, tmpMsg.indexOf(':'));
					_klibMsg = tmpMsg.substring(tmpMsg.indexOf(':') + 1, tmpMsg.lastIndexOf(']'));
				}
				
				var jQueryval = jQuery(this).val();
				
				if(jQueryval != "") {
					
					var pattern = new RegExp(_regexp, "gi");

					for(var k=0; k < jQueryval.length; k++) {
						
						var ch = String(jQueryval.charAt(k));
						
						if(!ch.match(pattern)) {
							
							if(_isUseAnnotationValidatorForm) {
								alert(_klibMsg);
							} else {
								alert(_klibMsg + " 형식에 맞지 않습니다.");
							}
							
							jQuery(this).focus();
							isReturn = false;
							return false;
						}
						
					}
					
				}
			}
		}
		
		//최소 길이 입력 제한 
		if(!isBypass && isReturn){
			if(String(jQuery(this).attr('class')) != "undefined" && jQuery(this).attr('class').indexOf('[MINLENGTH') > -1) {
				//치환 메시지 있음
				var tmpMaxLength = "";
				var _minLength = "";
				var _klibMsg = "";
				
				if(jQuery(this).attr('class').indexOf('[MINLENGTH:') > -1) {
					tmpMaxLength = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('[MINLENGTH:') + 11);
					_minLength = tmpMaxLength.substring(0, tmpMaxLength.indexOf(':'));
					_klibMsg = tmpMaxLength.substring(tmpMaxLength.indexOf(':') + 1, tmpMaxLength.indexOf(']'));
				}
				
				var jQueryval = jQuery(this).val();
				
				if (jQueryval.length < Number(_minLength)) {
					
					if(_isUseAnnotationValidatorForm) {
						alert(_klibMsg);
					} else {
						alert(_klibMsg + " 최소 " + _minLength + " 자리 이상 입력 가능합니다.");
					}
					
					jQuery(this).focus();
					isReturn = false;
					return false;
				}
			}
		}
		
		//최대 자리 이상 입력 확인
		if(!isBypass && isReturn){
			if(String(jQuery(this).attr('class')) != "undefined" && jQuery(this).attr('class').indexOf('[MAXLENGTH') > -1) {
				//치환 메시지 있음
				var tmpMinLength = "";
				var _maxLength = "";
				var _klibMsg = "";
				
				if(jQuery(this).attr('class').indexOf('[MAXLENGTH:') > -1) {
					tmpMinLength = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('[MAXLENGTH:') + 11);
					_maxLength = tmpMinLength.substring(0, tmpMinLength.indexOf(':'));
					_klibMsg = tmpMinLength.substring(tmpMinLength.indexOf(':') + 1, tmpMinLength.indexOf(']'));
				}
				
				var jQueryval = jQuery(this).val();
				
				if(jQueryval != ""){
					if (jQueryval.length > Number(_maxLength)) {
						if(_isUseAnnotationValidatorForm) {
							alert(_klibMsg);
						} else {
							alert(_klibMsg + " 최대 " + _maxLength + " 자리 까지 입력 가능합니다.");
						}
						jQuery(this).focus();
						isReturn = false;
						return false;
					}
				}
			}
		}
		
		//빈값 확인
		if(!isBypass && isReturn) {
			
			if(String(jQuery(this).attr('class')) != "undefined" && jQuery(this).attr('class').indexOf('[BLANK') > -1) {
				//치환 메시지 있음
				var tmpMsg = "";
				var _klibMsg = "";
				
				if(jQuery(this).attr('class').indexOf('[BLANK:') > -1) {
					tmpMsg = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('[BLANK:') + 6);
					_klibMsg = tmpMsg.substring(0, tmpMsg.indexOf(']'));
				}
				
				var jQueryval = jQuery(this).val();
				
				if(jQueryval != ""){
					
					if(jQuery.trim(jQueryval) == "" && jQueryval != "") {
						
						if(_isUseAnnotationValidatorForm) {
							alert(_klibMsg);
						} else {
							alert(_klibMsg + " 빈값을 입력할 수 없습니다..");
						}
						
						jQuery(this).focus();
						isReturn = false;
						return false;
					}
				}
			}
		}
		
		//쉼표(,) 를 제외한 최소 자리 이상 입력 확인
		if(!isBypass && isReturn){
			if(String(jQuery(this).attr('class')) != "undefined" && jQuery(this).attr('class').indexOf('[MINNUMBER') > -1) {
				//치환 메시지 있음
				var tmpMinLength = "";
				var _minLength = "";
				var _klibMsg = "";
				
				if(jQuery(this).attr('class').indexOf('[MINNUMBER:') > -1) {
					tmpMinLength = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('[MINNUMBER:') + 11);
					_minLength = tmpMinLength.substring(0, tmpMinLength.indexOf(':'));
					_klibMsg = tmpMinLength.substring(tmpMinLength.indexOf(':') + 1, tmpMinLength.indexOf(']'));
				}
				
				var jQueryval = jQuery(this).val().replace(/,/g, "");
				
				if(jQueryval != ""){
					if (Number(jQueryval.length) < Number(_minLength)) {
						if(_isUseAnnotationValidatorForm) {
							alert(_klibMsg);
						} else {
							alert(_klibMsg + " 최소 " + _minLength + " 자리 이상 입력 가능합니다.");
						}
						jQuery(this).focus();
						isReturn = false;
						return false;
					}
				}
			}
		}
		
		//쉼표(,) 를 제외한 최대 길이 입력 제한 
		if(!isBypass && isReturn){
			if(String(jQuery(this).attr('class')) != "undefined" && jQuery(this).attr('class').indexOf('[MAXNUMBER') > -1) {
				//치환 메시지 있음
				var tmpMaxLength = "";
				var _maxLength = "";
				var _klibMsg = "";
				
				if(jQuery(this).attr('class').indexOf('[MAXNUMBER:') > -1) {
					tmpMaxLength = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('[MAXNUMBER:') + 11);
					_maxLength = tmpMaxLength.substring(0, tmpMaxLength.indexOf(':'));
					_klibMsg = tmpMaxLength.substring(tmpMaxLength.indexOf(':') + 1, tmpMaxLength.indexOf(']'));
				}
				
				var jQueryval = jQuery(this).val().replace(/,/g, "");
				
				if (Number(jQueryval.length) > Number(_maxLength) || jQueryval.indexOf("e") > -1) {
					if(_isUseAnnotationValidatorForm) {
						alert(_klibMsg);
					} else {
						alert(_klibMsg + " 최대 " + _maxLength + " 자리 이하 입력 가능합니다.");
					}
					jQuery(this).focus();
					isReturn = false;
					return false;
				}
			}
		}
		
		//날자 포멧 확인
		if(!isBypass && isReturn) {
			
			if(String(jQuery(this).attr('class')) != "undefined" && jQuery(this).attr('class').indexOf('[DATEFORMAT') > -1) {
				//치환 메시지 있음
				var tmpMsg = "";
				var _klibMsg = "";
				
				if(jQuery(this).attr('class').indexOf('[DATEFORMAT:') > -1) {
					tmpMsg = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('[DATEFORMAT:') + 12);
					_klibMsg = tmpMsg.substring(0, tmpMsg.indexOf(']'));
				}
				
				var jQueryval = jQuery(this).val();
				
				if(jQueryval != ""){
					
					var isDateValid = true;
					
					if((jQueryval.length != 8 && jQueryval.length != 10)) {
						isDateValid = false;
					} else {
						
						if(jQueryval.length == 8) {
							
							var tmpYyyy = Number(jQueryval.substring(0, 4));
							var tmpMm = Number(jQueryval.substring(4, 6))-1;
							var tmpDd = Number(jQueryval.substring(6, 8));
							
							var tmpDate = new Date(tmpYyyy, tmpMm, tmpDd);
							
							if(tmpDate.toString() == "NaN" || tmpDate.toString() == "Invalid Date") {
								isDateValid = false;
							}
							
						} else if(jQueryval.length == 10 && jQueryval.indexOf('.') > -1) {
							
							var tmpDateAttr = jQueryval.split(".");
							
							if(tmpDateAttr.length != 3) {
								isDateValid = false;
							} else {
								var tmpYyyy = Number(tmpDateAttr[0]);
								var tmpMm = Number(tmpDateAttr[1])-1;
								var tmpDd = Number(tmpDateAttr[2]);
								
								var tmpDate = new Date(tmpYyyy, tmpMm, tmpDd);
								
								if(tmpDate.toString() == "NaN" || tmpDate.toString() == "Invalid Date") {
									isDateValid = false;
								}
							}
							
						} else if(jQueryval.length == 10 && jQueryval.indexOf('-') > -1) {
							
							var tmpDateAttr = jQueryval.split("-");
							
							if(tmpDateAttr.length != 3) {
								isDateValid = false;
							} else {
								var tmpYyyy = Number(tmpDateAttr[0]);
								var tmpMm = Number(tmpDateAttr[1])-1;
								var tmpDd = Number(tmpDateAttr[2]);
								
								var tmpDate = new Date(tmpYyyy, tmpMm, tmpDd);
								
								if(tmpDate.toString() == "NaN" || tmpDate.toString() == "Invalid Date") {
									isDateValid = false;
								}
							}
							
						} else {
							isDateValid = false;
						}
						
					}
					
					if(!isDateValid) {
						if(_isUseAnnotationValidatorForm) {
							alert(_klibMsg);
						} else {
							alert(_klibMsg + " 날짜 형식에 맞지 않습니다.");
						}
						jQuery(this).focus();
						isReturn = false;
						return false;
					}
				}
			}
		}
		
		//null 값 확인
		//[NULL:FORKEY:title:FORVALUE:123:1번 선택시 2번 입력값은 필수 입니다.]
		if(!isBypass && isReturn) {
			
			if(String(jQuery(this).attr('class')) != "undefined" && jQuery(this).attr('class').indexOf('[NULL') > -1) {
				
				//치환 메시지 있음
				var tmpMsg = "";
				var _klibMsg = "";
				
				if(jQuery(this).attr('class').indexOf('[NULL:') > -1) {
					tmpMsg = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('[NULL:') + 6);
					_klibMsg = tmpMsg.substring(tmpMsg.lastIndexOf(":") + 1, tmpMsg.indexOf(']'));
				}
				
				var offerValue = "";
				var forValue = "";
				
				if(jQuery(this).attr('class').indexOf('FORVALUE:') > -1) {
					var offerText = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('FORVALUE:') + 9);
					forValue = offerText.substring(0, offerText.indexOf(":"));
				}
				
				if(forValue != "") {
					if(jQuery(this).attr("type").toLowerCase() == "radio" || jQuery(this).attr("type").toLowerCase() == "checkbox") {
						offerValue = jQuery(this).filter(":checked").val(); 
					} else {
						offerValue = jQuery(this).val();
					}
				}
				
				var forKey = jQuery(this).attr('class').substring(jQuery(this).attr('class').indexOf('FORKEY:') + 7);
				forKey = forKey.substring(0, forKey .indexOf(":")); 
				
				var isDateValid = true;
				
				if(forValue != "" && offerValue == forValue && jQuery("#"+forKey).size() == 0) {
					isDateValid = false;
				} else if(forValue == "" && jQuery("#"+forKey).size() == 0) {
					isDateValid = false;
				}
				

				if(!isDateValid) {
					if(_isUseAnnotationValidatorForm) {
						alert(_klibMsg);
					} else {
						alert(_klibMsg + " 존재해야 합니다.");
					}
					jQuery(this).focus();
					isReturn = false;
					return false;
				}
				
			}
		}
		
	});
	
	//숫자 필드 숫자만
	if(isReturn) {
		jQuery("input[class*='[NUMERIC]']").each(function() {
			jQuery(this).val(jQuery(this).getOnlyNumeric());
		});
	}
	
	//날짜 필드 숫자만
	if(isReturn) {
		jQuery("input[class*='[DATE]']").each(function() {
			jQuery(this).val(jQuery(this).getOnlyNumeric());
		});
	}
	
	return isReturn;
}
//]]>