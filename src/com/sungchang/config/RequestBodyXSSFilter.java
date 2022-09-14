package com.sungchang.config;

import java.io.IOException;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RequestBodyXSSFilter implements Filter {
	private List<String> extUrl;
	RequestWrapper reqWrapper;
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		
		reqWrapper = null;
		String path = ((HttpServletRequest) req).getServletPath();
		
		try {
			Iterator<String> _iter = extUrl.iterator();
			boolean bMatchFlag = false;
			
			while(_iter.hasNext()) {
				if(path.matches(_iter.next())) {
					bMatchFlag = true;
				}
			}
			
			if(bMatchFlag) {
				chain.doFilter(req, resp);
			}
			else {
				reqWrapper = new RequestWrapper(req);
				chain.doFilter(reqWrapper, resp);
			}
			
//			if(!extUrl.contains(path)) {
//				reqWrapper = new RequestWrapper(req);
//				chain.doFilter(reqWrapper, resp);
//			} else {
//				chain.doFilter(req, resp);
//			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		String excludePattern = filterConfig.getInitParameter("extUrls");
		extUrl = Arrays.asList(excludePattern.split(","));
	}
	
	@Override
	public void destroy() {
	}

}
