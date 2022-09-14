package com.sungchang.global;

public class Global {
	public final static boolean G_SERVER_TEST_LOCALHOST = false;

	
	 public final static String G_SERVER_HOST_LOCALHOST = "http://localhost:8081";  
	 public final static String G_SERVER_HOST = "http://172.16.10.133:8081"; // when G_SERVER_TEST_LOCALHOST == false && ip start with 172.16. ... 
//	 public final static String G_SERVER_HOST_EXTERNAL = "http://121.188.121.253:8081"; // when G_SERVER_TEST_LOCALHOST == false && ip not start with 172.16. ...
	 public final static String G_SERVER_HOST_EXTERNAL = "http://112.165.212.156:8081"; // when G_SERVER_TEST_LOCALHOST == false && ip not start with 172.16. ...
	 
	 
	 public final static String G_SERVER_HOST_FROM_FRONTEND = G_SERVER_HOST;
	 public final static String G_SERVER_HOST_FROM_BROWSER = G_SERVER_HOST; 
	 // GS
	 // "http://59.25.196.93:8081";
}
