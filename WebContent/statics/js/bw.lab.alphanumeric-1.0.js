(function(jQuery){

	//내부에서만 사용
	jQuery.fn.alphanumeric = function(p) { 

		p = jQuery.extend({
			ichars: "!@#$%^&*()+=[]\\\';,/{}|\":<>?~`.-_ ",
			nchars: "",
			allow: ""
		  }, p);	
		
		return this.each
			(
				function() 
				{

					if (p.nocaps) p.nchars += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
					if (p.allcaps) p.nchars += "abcdefghijklmnopqrstuvwxyz";
					
					s = p.allow.split('');
					for ( i=0;i<s.length;i++) if (p.ichars.indexOf(s[i]) != -1) s[i] = "\\" + s[i];
					p.allow = s.join('|');
					
					var reg = new RegExp(p.allow,'gi');
					var ch = p.ichars + p.nchars;
					ch = ch.replace(reg,'');
					jQuery(this).keypress
						(
							function (e)
								{
								
									if (!e.charCode) k = String.fromCharCode(e.which);
										else k = String.fromCharCode(e.charCode);
										
									if (ch.indexOf(k) != -1) e.preventDefault();
									if (e.ctrlKey&&k=='v') e.preventDefault();
									if (e.ctrlKey && e.keyCode == 86) e.preventDefault(); //ctrl + v 복사붇여넣기 방지
									
								}
								
						);
						
					jQuery(this).bind('contextmenu',function () {return false});
									
				}
			);

	};

	//숫자만 입력
	jQuery.fn.numeric = function(p) {
	
		var az = "abcdefghijklmnopqrstuvwxyz";
		az += az.toUpperCase();

		p = jQuery.extend({
			nchars: az
		  }, p);	
		  	
		return this.each (function()
			{
				jQuery(this).css('ime-mode', 'disabled');
				jQuery(this).alphanumeric(p);
				jQuery(this).keydown
				(
					function (e)
						{
							if (e.ctrlKey && e.keyCode == 86) e.preventDefault(); //ctrl + v 복사붇여넣기 방지
							
							//크롬 대응 한글 입력 제한
							if(e.keyCode == 229) {
								e.preventDefault();
							}
						}
						
				);
			}
		);
			
	};
	
	jQuery.fn.numericSpecialcharacter = function(p) {
		
		var az = "abcdefghijklmnopqrstuvwxyz";
		az += az.toUpperCase();

		p = jQuery.extend({
			ichars: "",
			nchars: az
		  }, p);	
		
		return this.each (function()
			{
				jQuery(this).css('ime-mode', 'disabled');
				jQuery(this).alphanumeric(p);
				jQuery(this).keydown
				(
					function (e)
						{
							if (e.ctrlKey && e.keyCode == 86) e.preventDefault(); //ctrl + v 복사붇여넣기 방지
							
							//크롬 대응 한글 입력 제한
							if(e.keyCode == 229) {
								e.preventDefault();
							}
						}
						
				);
			}
		);
			
	};
	
	jQuery.fn.alpha = function(p) {

		var nm = "1234567890";

		p = jQuery.extend({
			nchars: nm
		  }, p);	

		return this.each (function()
			{
				jQuery(this).css('ime-mode', 'disabled');
				jQuery(this).alphanumeric(p);
				jQuery(this).keydown
				(
					function (e)
						{
							if (e.ctrlKey && e.keyCode == 86) e.preventDefault(); //ctrl + v 복사붇여넣기 방지
							
							//크롬 대응 한글 입력 제한
							if(e.keyCode == 229) {
								e.preventDefault();
							}
						}
						
				);
			}
		);
			
	};
	
	jQuery.fn.numericAlphaSpecailcharacter = function(p) {

		var nm = "";

		p = jQuery.extend({
			nchars: nm
		  }, p);	

		return this.each (function()
			{
				jQuery(this).numericSpecialcharacter(p);
				jQuery(this).keydown
				(
					function (e)
						{
							if (e.ctrlKey && e.keyCode == 86) e.preventDefault(); //ctrl + v 복사붇여넣기 방지
						}
						
				);
			}
		);
			
	};
	
	jQuery.fn.numericAlpha = function(p) {

		var nm = "";

		p = jQuery.extend({
			nchars: nm
		  }, p);	

		return this.each (function()
			{
				jQuery(this).css('ime-mode', 'disabled');
				jQuery(this).alphanumeric(p);
				jQuery(this).keydown
				(
					function (e)
						{
							if (e.ctrlKey && e.keyCode == 86) e.preventDefault(); //ctrl + v복사붇여넣기 방지
							
							//크롬 대응 한글 입력 제한
							if(e.keyCode == 229) {
								e.preventDefault();
							}
						}
						
				);
			}
		);
			
	};
	
	jQuery.fn.hangle = function(p) {

		var nm = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

		p = jQuery.extend({
			nchars: nm
		  }, p);	

		return this.each (function()
			{
				jQuery(this).css('ime-mode', 'active');
				jQuery(this).alphanumeric(p);
				jQuery(this).keydown
				(
					function (e)
						{
							if (e.ctrlKey && e.keyCode == 86) e.preventDefault(); //ctrl + v 복사붇여넣기 방지
						}
						
				);
			}
		);
			
	};
	
	jQuery.fn.hangleAlpha = function(p) {

		var nm = "1234567890";

		p = jQuery.extend({
			nchars: nm
		  }, p);	

		return this.each (function()
			{
				jQuery(this).css('ime-mode', 'active');
				jQuery(this).alphanumeric(p);
				jQuery(this).keydown
				(
					function (e)
						{
							if (e.ctrlKey && e.keyCode == 86) e.preventDefault(); //ctrl + v 복사붇여넣기 방지
						}
						
				);
			}
		);
			
	};
	
	jQuery.fn.hangleNumeric = function(p) {

		var nm = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

		p = jQuery.extend({
			nchars: nm
		  }, p);	

		return this.each (function()
			{
				jQuery(this).css('ime-mode', 'active');
				jQuery(this).alphanumeric(p);
				jQuery(this).keydown
				(
					function (e)
						{
							if (e.ctrlKey && e.keyCode == 86) e.preventDefault(); //ctrl + v 복사붇여넣기 방지
						}
						
				);
			}
		);
			
	};

})(jQuery);
