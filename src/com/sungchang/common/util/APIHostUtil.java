package com.sungchang.common.util;

import javax.servlet.http.HttpServletRequest;

import com.sungchang.global.Global;

public class APIHostUtil {
  public static String getHost(HttpServletRequest request) {
    String remoteAddr = getIp(request);
    System.out.println("remoteAddr:" + remoteAddr);
    System.out.println("remoteAddr:" + request.getRemoteAddr());
    System.out.println("remoteAddr:" + remoteAddr);
    
    //if (remoteAddr.startsWith("172.16"))
//      return "http://172.16.40.133:8081";
    //return "http://59.25.196.93:8081"; 
//    if(Global.G_SERVER_TEST_LOCALHOST) {
//    	return Global.G_SERVER_HOST_LOCALHOST;
//    }
//    else if(remoteAddr.startsWith("172.")) {
//    	return Global.G_SERVER_HOST;
//    }
    return Global.G_SERVER_HOST_FROM_FRONTEND; 
  }
  
  private static String getIp(HttpServletRequest request) {
    String ip = request.getHeader("X-Forwarded-For");
    System.out.println(">>>> X-FORWARDED-FOR : " + ip);
    if (ip == null) {
      ip = request.getHeader("Proxy-Client-IP");
      System.out.println(">>>> Proxy-Client-IP : " + ip);
    } 
    if (ip == null) {
      ip = request.getHeader("WL-Proxy-Client-IP");
      System.out.println(">>>> WL-Proxy-Client-IP : " + ip);
    } 
    if (ip == null) {
      ip = request.getHeader("HTTP_CLIENT_IP");
      System.out.println(">>>> HTTP_CLIENT_IP : " + ip);
    } 
    if (ip == null) {
      ip = request.getHeader("HTTP_X_FORWARDED_FOR");
      System.out.println(">>>> HTTP_X_FORWARDED_FOR : " + ip);
    } 
    if (ip == null)
      ip = request.getRemoteAddr(); 
    System.out.println(">>>> Result : IP Address : " + ip);
    return ip;
  }
}