/**
 * 관리자 공통 폼 제이에스
 */



var oEditors = [];
$(document).ready(function() {
	
	// 추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "substance",
		sSkinURI: "/article/skin?output=embed",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
		oEditors.getById["substance"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
		var sHTML = oEditors.getById["substance"].getIR();
		alert(sHTML);
	}
		
	function submitContents(elClickedObj) {
		oEditors.getById["substance"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}
	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["substance"].setDefaultFont(sDefaultFont, nFontSize);
	}
	
	// 파일 업로드 이벤트
	$("#file").on( "change" , function() {
		if (jQuery(this).val() != '') {
			
			var obj = {
					
				type : "POST", dataType : "JSON",
				beforeSubmit : function(data, form, options){
					return true;
				},
				success : function(data, status){
					
					//var urls	 = data.url.split('/');
					//var splitStr = urls[urls.length-1];
					
					//var thumbUrl = data.url.replace(splitStr, 'thumb_'+splitStr)
					
					
					var _fileId = data.id;
					var _fileName = data.fileName;
					var _fileType = data.fileType;
					var _url = data.url;
					
					if(_fileType == "VOD") {
						$("#isImage").val("Y");
						
						var sHTML =  '<p>';
							sHTML += '	<video width="760" height="400" controls="controls">';
							sHTML += '		<source src="'+_url+'" />';
							sHTML += '	</video>';
							sHTML += '</p>';
							
						oEditors.getById["substance"].exec("PASTE_HTML", [sHTML]);
					}
					
					if(_fileType == "IMAGE") {
						$("#isImage").val("Y");
						
						var sHTML = "<img src='" + _url + "' />";
						
						oEditors.getById["substance"].exec("PASTE_HTML", [sHTML]);
					}
					
					var outHtml =  '<p style="vertical-align: 3px;"><span>'+ data.fileName +'</span>';
						outHtml += '<button class="btn btn-sm btn-primary" onclick="fncDelFile(this); return false;" style="float: right;" > 삭제</button>'
						outHtml += '<input type="hidden" name="fileId" value="'+data.id+'" /></p>';
						
					$("#fileArea").append(outHtml);
					
					jQuery(this).val('');
					
					fncFileAddAndEvent();

				},
				
				error : function(error){
					alert("지원하는 확장자가 아닙니다.");
				}
			}
			jQuery("#fileUploadForm").ajaxSubmit(obj);
		}
	});
});

function fncOpenFileWindow() {
	$("#file").click();
}

function fncFileAddAndEvent() {
	var outHtml = '<input name="file" id="file" type="file" style="display:none;" />';
	$("#file").remove();
	
	$("#fileUploadForm").append(outHtml);
	
	// 파일 업로드 이벤트
	$("#file").on( "change" , function() {
		if (jQuery(this).val() != '') {
			
			var obj = {
					
				type : "POST", dataType : "JSON",
				beforeSubmit : function(data, form, options){
					return true;
				},
				success : function(data, status){
					
					//var urls	 = data.url.split('/');
					//var splitStr = urls[urls.length-1];
					
					//var thumbUrl = data.url.replace(splitStr, 'thumb_'+splitStr)
					
					
					var _fileId = data.id;
					var _fileName = data.fileName;
					var _fileType = data.fileType;
					var _url = data.url;
					
					if(_fileType == "VOD") {
						$("#isImage").val("Y");
						
						var sHTML =  '<p>';
							sHTML += '	<video width="760" height="400" controls="controls">';
							sHTML += '		<source src="'+_url+'" />';
							sHTML += '	</video>';
							sHTML += '</p>';
							
						oEditors.getById["substance"].exec("PASTE_HTML", [sHTML]);
					}
					
					if(_fileType == "IMAGE") {
						$("#isImage").val("Y");
						
						var sHTML = "<img src='" + _url + "' />";
						
						oEditors.getById["substance"].exec("PASTE_HTML", [sHTML]);
					}
					
					var outHtml =  '<p style="vertical-align: 3px;"><span>'+ data.fileName +'</span>';
						outHtml += '<button class="btn btn-sm btn-primary" onclick="fncDelFile(this); return false;" style="float: right;" > 삭제</button>'
						outHtml += '<input type="hidden" name="fileId" value="'+data.id+'" /></p>';
						
					$("#fileArea").append(outHtml);
					
					jQuery(this).val('');
					
					fncFileAddAndEvent();

				},
				
				error : function(error){
					alert("지원하는 확장자가 아닙니다.");
				}
			}
			jQuery("#fileUploadForm").ajaxSubmit(obj);
		}
	});
	
}

function fncDelFile(obj) {
	$(obj).parent().remove();
}