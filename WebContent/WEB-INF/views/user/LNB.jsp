<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <!-- partial -->

<%
	String uri = request.getRequestURI();

	System.out.println("uri:" + uri);
%>

        
       <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_sidebar.html -->
        <nav class="sidebar sidebar-offcanvas">
          <ul class="nav accordion" id="accordionSidebar">
          	<li class="nav-item" id="site-select-area" style="display:none;">
              <a class="nav-link" >
				<select class="form-control form-control-lg" name="site_select" id="site-select" onchange="changeSite(this);">
					
			    </select>
              </a>
            </li>
        
			<li class="nav-item">
              <a class="nav-link <%=uri.contains("dashboard")?"select":"" %>" href="/dashboard">
                <i class="fas fa-chart-pie icon-sm"></i>
                <span class="menu-title">대시보드</span>
              </a>
            </li>
            
			<li class="nav-item">
              <a class="nav-link <%=uri.contains("solar")?"":"collapsed" %> " href="#" data-toggle="collapse" data-target="#collapse01" aria-expanded="true" aria-controls="collapse01">
                <i class="fas fa-solar-panel icon-sm"></i>
                <span class="menu-title">태양광</span>
              </a>
              <div id="collapse01" class="collapse <%=uri.contains("solar")?"show":"" %>" aria-labelledby="heading01" data-parent="#accordionSidebar">
                <ul class="nav flex-column sub-menu">
                  <li class="nav-item">
                    <a class="nav-link <%=uri.contains("solar-monitoring")?"select":"" %>" href="/solar/monitoring">모니터링</a>
                  </li>
                
                </ul>
              </div>
            </li>
            <li class="nav-item">
              <a class="nav-link <%=uri.contains("ess")?"":"collapsed" %>" href="#" data-toggle="collapse" data-target="#collapse02" aria-expanded="true" aria-controls="collapse02"> 
				<i class="fas fa-server icon-sm"></i>
                <span class="menu-title">ESS</span>
              </a>
              <div id="collapse02" class="collapse <%=uri.contains("ess")?"show":"" %>" aria-labelledby="heading02" data-parent="#accordionSidebar">
                <ul class="nav flex-column sub-menu">
                  <li class="nav-item">
                    <a class="nav-link <%=uri.contains("ess-monitoring")?"select":"" %>" href="/ess/monitoring">모니터링</a>
                  </li>
                 
				  <li class="nav-item">
                    <a class="nav-link <%=uri.contains("trade-info")?"select":"" %>" href="/ess/trade/info">전력거래 현황 (KPX)</a>
                  </li>
                </ul>
              </div>
            </li>
			<li class="nav-item">
              <a class="nav-link <%=uri.contains("statistics")?"":"collapsed" %>" href="#" data-toggle="collapse" data-target="#collapse03" aria-expanded="true" aria-controls="collapse03"> 
                <i class="fas fa-chart-bar icon-sm"></i>
                <span class="menu-title">통계분석</span>
              </a>
              <div id="collapse03" class="collapse <%=uri.contains("statistics")?"show":"" %>" aria-labelledby="heading03" data-parent="#accordionSidebar">
                <ul class="nav flex-column sub-menu">
                  <li class="nav-item">
                    <a class="nav-link <%=uri.contains("statistics-current")?"select":"" %>" href="/statistics/current">태양광 현황</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link <%=uri.contains("statistics-benefit")?"select":"" %>" href="/statistics/benefit">발전수익 현황</a>
                  </li>
                </ul>
              </div>
            </li>
			<li class="nav-item">
              <a class="nav-link <%=uri.contains("manage")?"":"collapsed" %>" href="#" data-toggle="collapse" data-target="#collapse04" aria-expanded="true" aria-controls="collapse04"> 
                <i class="fas fa-file-alt icon-sm"></i>
                <span class="menu-title">운영</span>
              </a>
              <div id="collapse04" class="collapse <%=uri.contains("manage")?"show":"" %>" aria-labelledby="heading04" data-parent="#accordionSidebar">
                <ul class="nav flex-column sub-menu">
                  <li class="nav-item">
                    <a class="nav-link <%=uri.contains("manage-report")?"select":"" %>" href="/manage/report">월별 보고서</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link <%=uri.contains("manage-event")?"select":"" %>" href="/manage/event">인버터 이벤트</a>
                  </li>
                </ul>
              </div>
            </li>
            <%
            	if ("ADMIN".equals(roles)){
            %>
			<li class="nav-item">
              <a class="nav-link <%=uri.contains("device")||uri.contains("user")||uri.contains("site")?"":"collapsed" %>" href="#" data-toggle="collapse" data-target="#collapse05" aria-expanded="true" aria-controls="collapse05"> 
                <i class="fas fa-cog icon-sm"></i>
                <span class="menu-title">관리</span>
              </a>
              <div id="collapse05" class="collapse  <%=uri.contains("device")||uri.contains("user")||uri.contains("site")?"show":"" %>" aria-labelledby="heading05" data-parent="#accordionSidebar">
                <ul class="nav flex-column sub-menu">
                  <li class="nav-item">
                    <a class="nav-link <%=uri.contains("user")?"select":"" %>" href="/user/list">사용자 관리</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link <%=uri.contains("site")?"select":"" %>" href="/site/list">발전소 관리</a>
                  </li>
				  <li class="nav-item">
                    <a class="nav-link <%=uri.contains("device")&&!uri.contains("device-control")?"select":"" %>" href="/device/list">장치 관리</a>
                  </li>
                </ul>
              </div>
            </li>
            <%
            	}
            %>
            <li class="nav-item">
              <a class="nav-link" href="https://drive.google.com/file/d/1eMNCl-xZUTFa5TVWQuCkm-iaJeBqnGX_/view?usp=sharing">
                <i class="fas fa-question-circle icon-sm"></i>
                <span class="menu-title">도움말</span>
              </a>
            </li>
          </ul>
		  <div class="btm-footer">
			  <div><img src="/statics/assets/images/sungchang.png" alt="logo" /></div>
			  <a href="#" onClick="policy()">개인정보처리방침</a>
		  </div>
        </nav>
        
        <script>
		function policy() {
			window.open("/policy", "solarXEN v1.0 - 개인정보처리방침", "width=1200, height=300, scrollbar=yes, resizable=no ");
		}
		</script>