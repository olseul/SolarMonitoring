package com.sungchang.web.controller;

import com.sungchang.common.util.APIHostUtil;
import com.sungchang.common.util.ComUtil;
import com.sungchang.common.util.StringUtil;
import com.sungchang.common.vo.User;
import com.sungchang.global.Global;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/")
public class CommonController {
	@RequestMapping(value = { "login" }, method = { RequestMethod.GET })
	public String login(HttpServletRequest request, Locale locale, Model model) {
		System.out.println("login called..."); 

		PublishRSAKey(request);
		
		return "/login";
	}
	
	@RequestMapping(value = {"policy"}, method = {RequestMethod.GET})
	public String policy() {
		return "/policy";
	}

	@RequestMapping(value = { "login/process" }, method = { RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> processLogin(HttpServletRequest request, Locale locale, Model model, @org.springframework.web.bind.annotation.RequestBody Map<String,Object> payload) throws Exception {
		String API_HOST = Global.G_SERVER_HOST_FROM_BROWSER;
		System.out.println("API_HOST:" + API_HOST);
		Map<String, Object> resMap = new HashMap<>();
		OkHttpClient client = new OkHttpClient();
		
		String phone = (String)payload.get("phone");
		String password = (String)payload.get("password");
		
		System.out.println("phone:" + phone + "/password:" + password);
		
		if(request.getSession().getAttribute("__rsaKp") == null) {
			PublishRSAKey(request);
		}
		
		KeyPair kp = (KeyPair)request.getSession().getAttribute("__rsaKp");
		PrivateKey pk = null;
		if(kp != null) 
			pk = (PrivateKey) kp.getPrivate();
		if (pk == null)	System.out.println("invalid pk.");

		phone = decryptRSA(pk, phone);
		password = decryptRSA(pk, password);

		System.out.println("phone:" + phone + "/password:" + password);

		MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");
		RequestBody body = RequestBody.create(mediaType,
				"{\n\t\"tel\" : \"" + phone + "\",\n\t\"password\" : \"" + password + "\"\n}");
		Request _request = (new Request.Builder()).url(String.valueOf(API_HOST) + "/api/login").post(body)
				.addHeader("cache-control", "no-cache").build();
		Response _response = client.newCall(_request).execute();
		System.out.println("headers:" + _response.headers().toString());
		System.out.println("authorization" + _response.header("authorization"));
		System.out.println("Sid" + _response.header("Sid"));
		String auth = _response.header("authorization");
		String sid = _response.header("Sid");
		_response.body().close();
		if (StringUtil.isEmpty(auth)) {
			resMap.put("code", "fail");
			resMap.put("lockcount", _response.header("LockCount"));
			resMap.put("locklogin", _response.header("LockLogin"));
			resMap.put("lockexpires", _response.header("LockExpires"));
		} else {
			resMap.put("code", _response.code() != 204 ? "success" : "success_default");			
			request.getSession(true).setAttribute("admin-authorization", auth);
			_request = (new Request.Builder()).url(String.valueOf(API_HOST) + "/api/users/" + phone).get()
					.addHeader("authorization", auth).addHeader("cache-control", "no-cache").build();
			_response = client.newCall(_request).execute();
			String userInfo = _response.body().string();
			System.out.println("userInfo : " + userInfo);
			User user = (User) ComUtil.getJsonToObject(userInfo, User.class);
			user.setSid(sid);
			_response.body().close();
			request.getSession(true).setAttribute("user", user);
			System.out.println("User : " + user);
			if ("ADMIN".equals(user.getRoles())) {
				request.getSession(true).setAttribute("ROLE", "ADMIN");
			} else {
				request.getSession(true).setAttribute("ROLE", "USER");
			}
			resMap.put("user", user);
		}
		System.out.println("Response:" + resMap);
		return resMap;
	}

	@RequestMapping(value = { "logout" }, method = { RequestMethod.GET })
	public String logout(HttpServletRequest request, Locale locale, Model model) {
		System.out.println("logout called...");
		request.getSession().setAttribute("admin-authorization",null);
		request.getSession(true).setAttribute("admin-authorization", null);
		request.getSession(true).setAttribute("user-authorization", null);

		PublishRSAKey(request);
		
		return "redirect:/login";
	}
	
	@RequestMapping(value = {"/juitest1"}, method = {RequestMethod.GET})
	  public String juiTest1View(HttpServletRequest request, HttpServletResponse response) {
//		  String API_HOST = APIHostUtil.getHost(request);
//		  String authorization = (String)request.getSession().getAttribute("admin-authorization");
		  
		  //if (authorization == null) return "redirect:/login";
		  return "/admin/juitest1";  
	  }
	
	@RequestMapping(value = {"/juitest1-1"}, method = {RequestMethod.GET})
	  public String juiTest1_1View(HttpServletRequest request, HttpServletResponse response) {
//		  String API_HOST = APIHostUtil.getHost(request);
//		  String authorization = (String)request.getSession().getAttribute("admin-authorization");
		  
		  //if (authorization == null) return "redirect:/login";
		  return "/admin/juitest1-1";  
	  }
	  
	  @RequestMapping(value = {"/juitest2"}, method = {RequestMethod.GET})
	  public String juiTest2View(HttpServletRequest request, HttpServletResponse response) {
//		  String API_HOST = APIHostUtil.getHost(request);
//		  String authorization = (String)request.getSession().getAttribute("admin-authorization");
		  
		  //if (authorization == null) return "redirect:/login";
		  return "/admin/juitest2";  
	  }
	  
	  @RequestMapping(value = {"/juitest3"}, method = {RequestMethod.GET})
	  public String juiTest3View(HttpServletRequest request, HttpServletResponse response) {
//		  String API_HOST = APIHostUtil.getHost(request);
//		  String authorization = (String)request.getSession().getAttribute("admin-authorization");
		  
		  //if (authorization == null) return "redirect:/login";
		  return "/admin/juitest3";  
	  }
	  
	  @RequestMapping(value = {"/juitest4"}, method = {RequestMethod.GET})
	  public String juiTest4View(HttpServletRequest request, HttpServletResponse response) {
//		  String API_HOST = APIHostUtil.getHost(request);
//		  String authorization = (String)request.getSession().getAttribute("admin-authorization");
		  
		  //if (authorization == null) return "redirect:/login";
		  return "/admin/juitest4";  
	  }
	  
	  @RequestMapping(value = {"/juitest5"}, method = {RequestMethod.GET})
	  public String juiTest5View(HttpServletRequest request, HttpServletResponse response) {
//		  String API_HOST = APIHostUtil.getHost(request);
//		  String authorization = (String)request.getSession().getAttribute("admin-authorization");
		  
		  //if (authorization == null) return "redirect:/login";
		  return "/admin/juitest5";  
	  }
	  
	  @RequestMapping(value = {"/juitest6"}, method = {RequestMethod.GET})
	  public String juiTest6View(HttpServletRequest request, HttpServletResponse response) {
//		  String API_HOST = APIHostUtil.getHost(request);
//		  String authorization = (String)request.getSession().getAttribute("admin-authorization");
		  
		  //if (authorization == null) return "redirect:/login";
		  return "/admin/juitest6";  
	  }
	  
	  @RequestMapping(value = {"/juitest7"}, method = {RequestMethod.GET})
	  public String juiTest7View(HttpServletRequest request, HttpServletResponse response) {
//		  String API_HOST = APIHostUtil.getHost(request);
//		  String authorization = (String)request.getSession().getAttribute("admin-authorization");
		  
		  //if (authorization == null) return "redirect:/login";
		  return "/admin/juitest7";  
	  }
	  
	  @RequestMapping(value = {"/juitest8"}, method = {RequestMethod.GET})
	  public String juiTest8View(HttpServletRequest request, HttpServletResponse response) {
//		  String API_HOST = APIHostUtil.getHost(request);
//		  String authorization = (String)request.getSession().getAttribute("admin-authorization");
		  
		  //if (authorization == null) return "redirect:/login";
		  return "/admin/juitest8";  
	  }
	  
	  @RequestMapping(value = {"/juitest9"}, method = {RequestMethod.GET})
	  public String juiTest9View(HttpServletRequest request, HttpServletResponse response) {
//		  String API_HOST = APIHostUtil.getHost(request);
//		  String authorization = (String)request.getSession().getAttribute("admin-authorization");
		  
		  //if (authorization == null) return "redirect:/login";
		  return "/admin/juitest9";  
	  }
	  
	  @RequestMapping(value = {"/rtu"}, method = {RequestMethod.GET})
	  public String RtuView(HttpServletRequest request, HttpServletResponse response) {
//		  String API_HOST = APIHostUtil.getHost(request);
//		  String authorization = (String)request.getSession().getAttribute("admin-authorization");
		  
		  //if (authorization == null) return "redirect:/login";
		  return "/admin/rtu";  
	  }

	public static void main(String[] args) throws Exception {
		OkHttpClient client = new OkHttpClient();
		MediaType mediaType = MediaType.parse("application/octet-stream");
		RequestBody body = RequestBody.create(mediaType,
				"{\n\t\"tel\" : \"010-0000-0000\",\n\t\"password\" : \"00001\"\n}");
		Request _request = (new Request.Builder()).url(Global.G_SERVER_HOST + "/api/login").post(body)
				.addHeader("cache-control", "no-cache").build();
		Response _response = client.newCall(_request).execute();
		System.out.println("headers:" + _response.headers().toString());
		System.out.println("authorization" + _response.header("authorization"));
		String auth = _response.header("authorization");
		_response.body().close();
	}

	private String decryptRSA(PrivateKey _pk, String _secure) throws Exception {

		Cipher cipher = Cipher.getInstance("RSA");
		cipher.init(Cipher.DECRYPT_MODE, _pk);

		return new String(cipher.doFinal(hexToByteArray(_secure)), "utf-8");
	}

	private byte[] hexToByteArray(String _hex) {
		if (_hex == null || _hex.length() % 2 != 0) {
			return new byte[] {};
		}

		byte[] _ba = new byte[(_hex.length() / 2)];

		for (int i = 0; i < _hex.length(); i += 2) {

			_ba[(int) Math.floor(i / 2)] = (byte) Integer.parseInt(_hex.substring(i, i + 2), 16);

			System.out.print(String.format("%02x", Integer.parseInt(_hex.substring(i, i + 2), 16)));
		}
		System.out.println();
		return _ba;
	}
	
	private void PublishRSAKey(HttpServletRequest request) {
		try {
			RSAPublicKeySpec rsaPublicKeySpec;
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			
			if(request.getSession().getAttribute("__rsaKp") == null) {
				KeyPairGenerator kpg = KeyPairGenerator.getInstance("RSA");

				KeyPair keyPair = kpg.generateKeyPair(); 
				
				request.getSession().setAttribute("__rsaKp",keyPair);

				rsaPublicKeySpec = (RSAPublicKeySpec) keyFactory.getKeySpec(keyPair.getPublic(),
						RSAPublicKeySpec.class);
				
				System.out.println("** a New KeyPair registered. ");
				
			} else {
				rsaPublicKeySpec = (RSAPublicKeySpec) keyFactory.getKeySpec(((KeyPair)request.getSession().getAttribute("__rsaKp")).getPublic(),
						RSAPublicKeySpec.class);
			}
			
			request.setAttribute("__md", rsaPublicKeySpec.getModulus().toString(16));
			request.setAttribute("__exp", rsaPublicKeySpec.getPublicExponent().toString(16));

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
