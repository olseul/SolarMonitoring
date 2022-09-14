package com.sungchang.web.controller;

import com.sungchang.common.util.APIHostUtil;
import com.sungchang.common.util.StringUtil;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping({"api"})
public class ApiAdminController {
  @RequestMapping(value = {"/user/list"}, method = {RequestMethod.GET})
  public String userList(HttpServletRequest request, HttpServletResponse response) throws Exception {
    String API_HOST = APIHostUtil.getHost(request);
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "[]"; 
    System.out.println("Authorization : " + authorization);
    OkHttpClient client = new OkHttpClient();
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + "/api/users")
      .get()
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    Response _response = client.newCall(_request).execute();
    System.out.println("Response:" + _response.toString());
    sendJson(response, _response.body().string());
    _response.body().close();
    return null;
  }
  
  @RequestMapping(value = {"/user/view"}, method = {RequestMethod.GET})
  public String userView(HttpServletRequest request, HttpServletResponse response, String tel) throws Exception {
    String API_HOST = APIHostUtil.getHost(request);
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "{}"; 
    System.out.println("Authorization : " + authorization);
    OkHttpClient client = new OkHttpClient();
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + "/api/users/" + tel)
      .get()
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    Response _response = client.newCall(_request).execute();
    sendJson(response, _response.body().string());
    _response.body().close();
    return null;
  }
  
  @RequestMapping(value = {"/user/delete"}, method = {RequestMethod.POST})
  @ResponseBody
  public ResponseEntity<String> deletUsers(HttpServletRequest request, HttpServletResponse response, String telList) throws Exception {
    String API_HOST = APIHostUtil.getHost(request);
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    boolean isPresentAccount = false;
    
    if (authorization == null)
      return new ResponseEntity<String>("{}",HttpStatus.OK); 
    System.out.println("Authorization : " + authorization);
    System.out.println("telList : " + telList);
    String[] userTels = telList.split(",");
    OkHttpClient client = new OkHttpClient();
    for (int i = 0; i < userTels.length; i++) {
      Request _request = (new Request.Builder())
        .url(String.valueOf(API_HOST) + "/api/users/" + userTels[i])
        .delete(null)
        .addHeader("authorization", authorization)
        .addHeader("cache-control", "no-cache")
        .build();
      Response _response = client.newCall(_request).execute();
      System.out.println(_response.toString());
      _response.body().close();
      
      System.out.println("_response code ::::: " + _response.code());
      
      if (_response.code() == 409) isPresentAccount = true;
    } 
    
    if(isPresentAccount)
    	return new ResponseEntity<String>("", HttpStatus.CONFLICT);
    else 
    	return new ResponseEntity<String>("", HttpStatus.OK);
  }
  
  @RequestMapping(value = {"/device/list"}, method = {RequestMethod.GET})
  public String deviceList(HttpServletRequest request, HttpServletResponse response) throws Exception {
    String API_HOST = APIHostUtil.getHost(request);
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "[]"; 
    System.out.println("Authorization : " + authorization);
    OkHttpClient client = new OkHttpClient();
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + "/api/devices")
      .get()
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    Response _response = client.newCall(_request).execute();
    System.out.println("Response:" + _response.toString());
    sendJson(response, _response.body().string());
    _response.body().close();
    return null;
  }
  
  @RequestMapping(value = {"/device/add"}, method = {RequestMethod.POST})
  @ResponseBody
  public String deviceAdd(HttpServletRequest request, HttpServletResponse response) throws Exception {
    String API_HOST = APIHostUtil.getHost(request);
    System.out.println("user-add");
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "10"; 
    System.out.println("Authorization : " + authorization);
    String devicetype = request.getParameter("devicetype");
    String model = request.getParameter("model");
    String manufacturer = request.getParameter("manufacturer");
    String capacity = StringUtil.nvl(request.getParameter("capacity"), "0");
    String pcs_capacity = StringUtil.nvl(request.getParameter("pcs_capacity"), "0");
    String batt_capacity = StringUtil.nvl(request.getParameter("batt_capacity"), "0");
    String batt_type = request.getParameter("batt_type");
    String manager = request.getParameter("manager");
    String manager_tel = request.getParameter("manager_tel");
    String memo = request.getParameter("memo");
    String params = "{\n\t\"devicetype\" : \"" + devicetype + "\",\n\t\"model\" : \"" + model + "\",\n\t\"manufacturer\" : \"" + manufacturer + "\",\n\t\"capacity\" : \"" + capacity + "\",\n\t\"pcs_capacity\" : " + pcs_capacity + ",\n\t\"batt_capacity\" : " + batt_capacity + ",\n\t\"batt_type\" : \"" + batt_type + "\",\n\t\"manager\" : \"" + manager + "\",\n\t\"manager_tel\" : \"" + manager_tel + "\",\n\t\"memo\" : \"" + memo + "\"\n}";
    OkHttpClient client = new OkHttpClient();
    MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");
    RequestBody body = RequestBody.create(mediaType, params);
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + "/api/devices")
      .post(body)
      .addHeader("content-type", "application/json;charset=UTF-8")
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    System.out.println("params:" + params);
    Response _response = client.newCall(_request).execute();
    System.out.println("response:" + _response.toString());
    int code = _response.code();
    _response.body().close();
    return (new StringBuilder(String.valueOf(code))).toString();
  }
  
  @RequestMapping(value = {"/device/update"}, method = {RequestMethod.POST})
  @ResponseBody
  public String deviceUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
    String API_HOST = APIHostUtil.getHost(request);
    System.out.println("update device");
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "10"; 
    System.out.println("Authorization : " + authorization);
    String devicetype = request.getParameter("devicetype");
    String model = request.getParameter("model");
    String manufacturer = request.getParameter("manufacturer");
    String capacity = StringUtil.nvl(request.getParameter("capacity"), "0");
    String pcs_capacity = StringUtil.nvl(request.getParameter("pcs_capacity"), "0");
    String batt_capacity = StringUtil.nvl(request.getParameter("batt_capacity"), "0");
    String batt_type = request.getParameter("batt_type");
    String manager = request.getParameter("manager");
    String manager_tel = request.getParameter("manager_tel");
    String memo = request.getParameter("memo");
    String params = "{\n\t\"manufacturer\" : \"" + manufacturer + "\",\n\t\"capacity\" : \"" + capacity + "\",\n\t\"pcs_capacity\" : " + pcs_capacity + ",\n\t\"batt_capacity\" : " + batt_capacity + ",\n\t\"batt_type\" : \"" + batt_type + "\",\n\t\"manager\" : \"" + manager + "\",\n\t\"manager_tel\" : \"" + manager_tel + "\",\n\t\"memo\" : \"" + memo + "\"\n}";
    String url = String.valueOf(API_HOST) + "/api/devices/" + devicetype + "/" + manufacturer + "/" + model;
    OkHttpClient client = new OkHttpClient();
    MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");
    RequestBody body = RequestBody.create(mediaType, params);
    Request _request = (new Request.Builder())
      .url(url)
      .put(body)
      .addHeader("content-type", "application/json;charset=UTF-8")
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    System.out.println("url:" + url);
    System.out.println("params:" + params);
    Response _response = client.newCall(_request).execute();
    System.out.println("response:" + _response.toString());
    int code = _response.code();
    _response.body().close();
    return (new StringBuilder(String.valueOf(code))).toString();
  }
  
  @RequestMapping(value = {"/device/delete"}, method = {RequestMethod.POST})
  @ResponseBody
  public String deletDevices(HttpServletRequest request, HttpServletResponse response, String modelList) throws Exception {
    String API_HOST = APIHostUtil.getHost(request);
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "10"; 
    System.out.println("Authorization : " + authorization);
    System.out.println("modelList : " + modelList);
    String[] deviceList = modelList.split(",");
    OkHttpClient client = new OkHttpClient();
    String result = "success";
    for (int i = 0; i < deviceList.length; i++) {
      Request _request = (new Request.Builder())
        .url(String.valueOf(API_HOST) + "/api/devices/" + deviceList[i])
        .delete(null)
        .addHeader("authorization", authorization)
        .addHeader("cache-control", "no-cache")
        .build();
      Response _response = client.newCall(_request).execute();
      if (_response.code() != 200)
        result = "fail"; 
      System.out.println(_response.toString());
      _response.body().close();
    } 
    return result;
  }
  
  @RequestMapping(value = {"/site/info"}, method = {RequestMethod.GET})
  @ResponseBody
  public String siteInfo(HttpServletRequest request, HttpServletResponse response, String sid) throws Exception {
    String API_HOST = APIHostUtil.getHost(request);
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "10"; 
    System.out.println("Authorization : " + authorization);
    OkHttpClient client = new OkHttpClient();
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + "/api/sites/" + sid)
      .get()
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    Response _response = client.newCall(_request).execute();
    System.out.println("Response:" + _response.toString());
    String resultStr = _response.body().string();
    _response.body().close();
    return resultStr;
  }
  
  private void sendJson(HttpServletResponse response, String str) throws Exception {
    response.setHeader("Content-Type", "application/json;charset=utf-8");
    PrintWriter out = response.getWriter();
    out.print(str);
    out.flush();
    out.close();
  }
}
