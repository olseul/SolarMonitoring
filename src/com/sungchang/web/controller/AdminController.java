package com.sungchang.web.controller;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.Region;
import org.codehaus.jackson.JsonParser;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mysql.jdbc.StringUtils;
import com.nhncorp.lucy.security.xss.XssPreventer;
import com.sungchang.common.util.APIHostUtil;
import com.sungchang.common.util.DateUtil;
import com.sungchang.common.util.StringUtil;
import com.sungchang.common.vo.User;

//import jdk.nashorn.internal.parser.JSONParser;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Controller
@RequestMapping({"admin"})
public class AdminController {
  
  @RequestMapping(value = {""}, method = {RequestMethod.GET})
  public String admin(HttpServletRequest request, Locale locale, Model model) {
    System.out.println("login called..."); 
    
    System.out.println("timeout value : " + request.getSession().getMaxInactiveInterval());
    User user = (User)request.getSession().getAttribute("user");
    if (user == null) 
      return "redirect:/login"; 
    if ("ADMIN".equals(user.getRoles()))
      return "redirect:/admin/sitelist"; 
    return "redirect:/admin/dashboard";
  }
  
  @RequestMapping(value = {"/login"}, method = {RequestMethod.GET})
  public String login(HttpServletRequest request, Locale locale, Model model) {
    System.out.println("login called...");
    return "/login";
  }
  
  @RequestMapping(value = {"/login/submit"}, method = {RequestMethod.POST})
  public String processLogin(HttpServletRequest request, Locale locale, Model model, String phone, String password) throws Exception {
	  
	String API_HOST = APIHostUtil.getHost(request); 
	OkHttpClient client = new OkHttpClient();
    MediaType mediaType = MediaType.parse("application/octet-stream");
    RequestBody body = RequestBody.create(mediaType, "{\n\t\"tel\" : \"" + phone + "\",\n\t\"password\" : \"" + password + "\"\n}");
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + "/api/login")
      .post(body)
      .addHeader("cache-control", "no-cache")
      .build();
    Response _response = client.newCall(_request).execute();
    System.out.println("authorization" + _response.header("authorization"));
    String auth = _response.header("authorization");
    _response.body().close();
    if (StringUtil.isEmpty(auth))
      return "redirect:/login?msg=fail";
    request.getSession(true).setAttribute("admin-authorization", auth);    
    return "redirect:/admin/user/list";
  }
  
  @RequestMapping(value = {"/sitelist"}, method = {RequestMethod.GET})
  public String sitelist(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("list called...");
    return "/admin/company-list";
  }
  
  @RequestMapping(value = {"/dashboard"}, method = {RequestMethod.GET})
  public String dashboard(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("dashboard called...");
    User user = (User)request.getSession().getAttribute("user");
    if (user == null)
      return "redirect:/login"; 
    if ("ADMIN".equals(user.getRoles()))
      return "/admin/dashboard"; 
    return "/admin/dashboard-user";
  }
  
  @RequestMapping(value = {"/solar/monitoring"}, method = {RequestMethod.GET})
  public String solarMonitoring(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("solarMonitoring called...");
    return "/admin/solar-monitoring";
  }
  
  @RequestMapping(value = {"/solar/deivce/control"}, method = {RequestMethod.GET})
  public String solarDeviceControl(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("solarDeviceControl called...");
    return "/admin/solar-control";
  }
  
  @RequestMapping(value = {"/ess/monitoring"}, method = {RequestMethod.GET})
  public String essMonitoring(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("essMonitoring called...");
    return "/admin/ess-monitoring";
  }
  
  @RequestMapping(value = {"/ess/schedule"}, method = {RequestMethod.GET})
  public String essSchedule(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("essSchedule called...");
    return "/admin/ess-schedule";
  }
  
  @RequestMapping(value = {"/{sid}/schedules"}, method = {RequestMethod.POST})
  public ResponseEntity<String> essAddSchedule(HttpServletRequest request,@PathVariable int sid, @org.springframework.web.bind.annotation.RequestBody Map<String,Object> payload, Locale locale, Model model) throws Exception {
	  String API_HOST = APIHostUtil.getHost(request); 
		System.out.println("schedule-add");       
	    String authorization = (String)request.getSession().getAttribute("admin-authorization");
	    if (authorization == null)
	      return new ResponseEntity<String>("redirect:/login",HttpStatus.BAD_REQUEST);
	    
	    System.out.println();
	     
	    System.out.println("Authorization : " + authorization); 
	    String socMin = "30"; //fixed limit // XssPreventer.escape((String)payload.get("socMin"));
	    String socMax = "90"; //fixed limit //XssPreventer.escape((String)payload.get("socMax")); //request.getParameter("tel");
	    String reqOutput = XssPreventer.escape((String)payload.get("reqoutput"));
//	    String opmode = XssPreventer.escape((String)payload.get("opmode"));
	    String monthStart = XssPreventer.escape((String)payload.get("monthStart"));
	    String monthEnd = XssPreventer.escape((String)payload.get("monthEnd"));
	    int weekcode = Integer.parseInt((String)payload.get("weekcode"),2);
	    String chargemode = XssPreventer.escape((String)payload.get("chargemode"));
	    String timeStart = XssPreventer.escape((String)payload.get("timeStart"));
	    String timeEnd = XssPreventer.escape((String)payload.get("timeEnd"));
	    String memo = XssPreventer.escape((String)payload.get("memo"));
	    String params = "{\t\r\n\t\"socMin\" : " + socMin + ",\r\n\t\"socMax\" : " + socMax + ",\r\n\t\"reqOutput\" : " + reqOutput +  ",\r\n\t\"monthStart\" : " + monthStart + ",\r\n\t\"monthEnd\" : " + monthEnd + ",\r\n\t\"weekcode\" : " + weekcode + ",\r\n\t\"chargemode\" : " + chargemode + ",\r\n\t\"timeStart\" : \"" + timeStart + "\",\r\n\t\"timeEnd\" : \"" + timeEnd + "\",\r\n\t\"memo\": \"" + memo + "\"\r\n}";
	    System.out.println("params:" + params);
	    OkHttpClient client = new OkHttpClient();
	    MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");
	    RequestBody body = RequestBody.create(mediaType, params);
	    Request _request = (new Request.Builder())
	      .url(String.valueOf(API_HOST) + "/api/sites/" + sid + "/ess/schedules")
	      .post(body)
	      .addHeader("content-type", "application/json;charset=UTF-8")
	      .addHeader("authorization", authorization)
	      .addHeader("cache-control", "no-cache")
	      .build();
	    Response _response = client.newCall(_request).execute();
	    System.out.println("response:" + _response.toString());
	    _response.body().close();

	    switch(_response.code()) {
	    case 201:
	    	return new ResponseEntity<String>("",HttpStatus.CREATED);
	    case 406:
	    	return new ResponseEntity<String>("",HttpStatus.NOT_ACCEPTABLE);
	    case 409:
	    	return new ResponseEntity<String>("",HttpStatus.CONFLICT);
	    default:
	    	return new ResponseEntity<String>("",HttpStatus.NOT_FOUND);
	    }
  }
  
  @RequestMapping(value = {"/{sid}/schedules/{id}"}, method = {RequestMethod.PUT})
  public ResponseEntity<String> essUpdateSchedule(HttpServletRequest request,@PathVariable int sid,@PathVariable int id,@org.springframework.web.bind.annotation.RequestBody Map<String,Object> payload, Locale locale, Model model) throws Exception {
	  String API_HOST = APIHostUtil.getHost(request); 
		System.out.println("schedule-update");
	    String authorization = (String)request.getSession().getAttribute("admin-authorization");
	    if (authorization == null)
	      return new ResponseEntity<String>("redirect:/login",HttpStatus.BAD_REQUEST);
	    
	    System.out.println();
	     
	    System.out.println("Authorization : " + authorization); 
	    String socMin = "30"; //fixed limit // XssPreventer.escape((String)payload.get("socMin"));
	    String socMax = "90"; //fixed limit //XssPreventer.escape((String)payload.get("socMax")); //request.getParameter("tel");
	    String reqOutput = XssPreventer.escape((String)payload.get("reqoutput"));
//	    String opmode = XssPreventer.escape((String)payload.get("opmode"));
	    String monthStart = XssPreventer.escape((String)payload.get("monthStart"));
	    String monthEnd = XssPreventer.escape((String)payload.get("monthEnd"));
	    int weekcode = Integer.parseInt((String)payload.get("weekcode"),2);
	    String chargemode = XssPreventer.escape((String)payload.get("chargemode"));
	    String timeStart = XssPreventer.escape((String)payload.get("timeStart"));
	    String timeEnd = XssPreventer.escape((String)payload.get("timeEnd"));
	    String memo = XssPreventer.escape((String)payload.get("memo"));
	    String params = "{\t\r\n\t\"socMin\" : " + socMin + ",\r\n\t\"socMax\" : " + socMax + ",\r\n\t\"reqOutput\" : " + reqOutput + ",\r\n\t\"monthStart\" : " + monthStart + ",\r\n\t\"monthEnd\" : " + monthEnd + ",\r\n\t\"weekcode\" : " + weekcode + ",\r\n\t\"chargemode\" : " + chargemode + ",\r\n\t\"timeStart\" : \"" + timeStart + "\",\r\n\t\"timeEnd\" : \"" + timeEnd + "\",\r\n\t\"memo\": \"" + memo + "\"\r\n}";
	    System.out.println("params:" + params);
	    OkHttpClient client = new OkHttpClient();
	    MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");
	    RequestBody body = RequestBody.create(mediaType, params);
	    Request _request = (new Request.Builder())
	      .url(String.valueOf(API_HOST) + "/api/sites/" + sid + "/ess/schedules/" + id)
	      .put(body)
	      .addHeader("content-type", "application/json;charset=UTF-8")
	      .addHeader("authorization", authorization)
	      .addHeader("cache-control", "no-cache")
	      .build();
	    Response _response = client.newCall(_request).execute();
	    System.out.println("response:" + _response.toString());
	    _response.body().close();

	    switch(_response.code()) {
	    case 200:
	    	return new ResponseEntity<String>("",HttpStatus.OK);
	    case 406:
	    	return new ResponseEntity<String>("",HttpStatus.NOT_ACCEPTABLE);
	    case 409:
	    	return new ResponseEntity<String>("",HttpStatus.CONFLICT);
	    default:
	    	return new ResponseEntity<String>("",HttpStatus.NOT_FOUND);
	    }
  }
  
  @RequestMapping(value = {"/ess/trade/info"}, method = {RequestMethod.GET})
  public String tradeInfo(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("ess trade info called...");
    return "/admin/ess-trade-info";
  }
  
  @RequestMapping(value = {"/statistics/current"}, method = {RequestMethod.GET})
  public String statisticsCurrent(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("statisticsCurrent called...");
    return "/admin/statistics-current";
  }
  
  @RequestMapping(value = {"/statistics/current/downExcel"}, method = {RequestMethod.POST})
  public String currentExcelForm(Model model, String data, HttpServletRequest request, HttpServletResponse response) {
    System.out.println("data:" + data);
    String type = request.getParameter("ptype");
    HSSFWorkbook workbook = new HSSFWorkbook();
    HSSFSheet sheet = workbook.createSheet("�깭�뼇愿묓쁽�솴");
    HSSFCellStyle hSSFCellStyle = workbook.createCellStyle();
    hSSFCellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
    hSSFCellStyle.setFillPattern((short)1);
    hSSFCellStyle.setAlignment((short)6);
    hSSFCellStyle.setVerticalAlignment((short)1);
    sheet.setColumnWidth(0, 3000);
    sheet.setColumnWidth(1, 4500);
    sheet.setColumnWidth(2, 4500);
    sheet.setColumnWidth(3, 4500);
    sheet.setColumnWidth(4, 4500);
    sheet.setColumnWidth(5, 4500);
    HSSFRow row = sheet.createRow(0);
    HSSFCell cell = row.createCell(0);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("No.");
    cell = row.createCell(1);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("�씪�옄");
    cell = row.createCell(2);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("�깭�뼇愿� 諛쒖쟾�웾(kW)");
    cell = row.createCell(3);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("10:00~15:59 諛쒖쟾�웾(kW)");
    cell = row.createCell(4);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("異⑹쟾�웾(kW)");
    cell = row.createCell(5);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("諛⑹쟾�웾(kW)");
    int rowcount = 1;
    try {
      JSONObject datajson = JSONObject.fromObject(data);
      JSONArray datas = datajson.getJSONArray("data");
      for (int i = 0; i < datas.size(); i++) {
        String strDate = "";
        String[] dates = datas.getJSONObject(i).getString("reg_date").split(" ")[0].split("-");
        if (type.equals("daily")) {
          strDate = String.valueOf(dates[1]) + "�썡" + dates[2] + "�씪";
        } else if (type.equals("monthly")) {
          strDate = String.valueOf(dates[0]) + "�뀈" + dates[1] + "�썡";
        } else {
          strDate = String.valueOf(dates[2]) + "�씪" + datas.getJSONObject(i).getString("unit") + "�떆";
        } 
        row = sheet.createRow(rowcount++);
        row.createCell(0).setCellValue((i + 1));
        row.createCell(1).setCellValue(strDate);
        row.createCell(2).setCellValue(datas.getJSONObject(i).getString("generation"));
        row.createCell(3).setCellValue(datas.getJSONObject(i).getString("gen10to16"));
        row.createCell(4).setCellValue(datas.getJSONObject(i).getString("charge"));
        row.createCell(5).setCellValue(datas.getJSONObject(i).getString("discharge"));
      } 
    } catch (Exception e) {
      e.printStackTrace();
    } 
    String fileN = "statistics-current-" + DateUtil.getCurrDate("yyyy-MM-dd");
    response.setContentType("application/msexcel");
    response.setHeader("Content-disposition", "inline; filename=" + fileN + ".xls");
    try {
      ServletOutputStream sos = response.getOutputStream();
      workbook.write((OutputStream)sos);
      sos.close();
      sos.flush();
    } catch (Exception e) {
      e.printStackTrace();
    } 
    return null;
  }
  
  @RequestMapping(value = {"/statistics/benefit"}, method = {RequestMethod.GET})
  public String statisticsBenefit(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("statisticsBenefit called...");
    return "/admin/statistics-benefit";
  }
  
  @RequestMapping(value = {"/statistics/benefit/downExcel"}, method = {RequestMethod.POST})
  public String contractUserExcelForm(Model model, String data, HttpServletRequest request, HttpServletResponse response) {
    System.out.println("data:" + data);
    String type = request.getParameter("ptype");
    HSSFWorkbook workbook = new HSSFWorkbook();
    HSSFSheet sheet = workbook.createSheet("諛쒖쟾�닔�씡 �쁽�솴");
    HSSFCellStyle hSSFCellStyle = workbook.createCellStyle();
    hSSFCellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
    hSSFCellStyle.setFillPattern((short)1);
    hSSFCellStyle.setAlignment((short)6);
    hSSFCellStyle.setVerticalAlignment((short)1);
    sheet.setColumnWidth(0, 3000);
    sheet.setColumnWidth(1, 4500);
    sheet.setColumnWidth(2, 4500);
    sheet.setColumnWidth(3, 4500);
    sheet.setColumnWidth(4, 4500);
    sheet.setColumnWidth(5, 4500);
    sheet.setColumnWidth(6, 4500);
    sheet.setColumnWidth(7, 4500);
    sheet.setColumnWidth(8, 4500);
    sheet.setColumnWidth(9, 4500);
    sheet.setColumnWidth(10, 6000);
    HSSFRow row = sheet.createRow(0);
    HSSFCell cell = row.createCell(0);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("�씪�옄");
    cell = row.createCell(1);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("�깭�뼇愿묐컻�쟾�웾(kW)");
    cell = row.createCell(2);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("異⑹쟾�웾(kW)");
    cell = row.createCell(3);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("諛⑹쟾�웾(kW)");
    cell = row.createCell(10);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("珥� �닔�씡 �삁�긽(�썝)");
    sheet.addMergedRegion(new Region(0, (short)4, 0, (short)6));
    cell = row.createCell(4);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("PV");
    sheet.addMergedRegion(new Region(0, (short)7, 0, (short)9));
    cell = row.createCell(7);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("ESS");
    row = sheet.createRow(1);
    sheet.addMergedRegion(new Region(0, (short)0, 1, (short)0));
    sheet.addMergedRegion(new Region(0, (short)1, 1, (short)1));
    sheet.addMergedRegion(new Region(0, (short)2, 1, (short)2));
    sheet.addMergedRegion(new Region(0, (short)3, 1, (short)3));
    cell = row.createCell(4);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("SMP�떒媛�");
    cell = row.createCell(5);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("媛�以묒튂");
    cell = row.createCell(6);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("�닔�씡");
    cell = row.createCell(7);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("REC�떒媛�");
    cell = row.createCell(8);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("媛�以묒튂");
    cell = row.createCell(9);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("�닔�씡");
    sheet.addMergedRegion(new Region(0, (short)10, 1, (short)10));
    int rowcount = 2;
    try {
      JSONObject datajson = JSONObject.fromObject(data);
      JSONArray datas = datajson.getJSONArray("data");
      for (int i = 0; i < datas.size(); i++) {
        String strDate = "";
        String[] dates = datas.getJSONObject(i).getString("reg_date").split(" ")[0].split("-");
        if (type.equals("daily")) {
          strDate = String.valueOf(dates[1]) + "�썡" + dates[2] + "�씪";
        } else {
          strDate = String.valueOf(dates[0]) + "�뀈" + dates[1] + "�썡";
        } 
        row = sheet.createRow(rowcount++);
        row.createCell(0).setCellValue(strDate);
        row.createCell(1).setCellValue(datas.getJSONObject(i).getString("generation"));
        row.createCell(2).setCellValue(datas.getJSONObject(i).getString("charge"));
        row.createCell(3).setCellValue(datas.getJSONObject(i).getString("discharge"));
        row.createCell(4).setCellValue(datas.getJSONObject(i).getString("smp_price"));
        row.createCell(5).setCellValue(datas.getJSONObject(i).getString("smp_weight"));
        row.createCell(6).setCellValue(datas.getJSONObject(i).getString("pv_benefit"));
        row.createCell(7).setCellValue(datas.getJSONObject(i).getString("rec_price"));
        row.createCell(8).setCellValue(datas.getJSONObject(i).getString("rec_weight"));
        row.createCell(9).setCellValue(datas.getJSONObject(i).getString("rec_benefit"));
        row.createCell(10).setCellValue(datas.getJSONObject(i).getString("stotal_benefit"));
      } 
    } catch (Exception e) {
      e.printStackTrace();
    } 
    String fileN = "statistics-benefit-" + DateUtil.getCurrDate("yyyy-MM-dd");
    response.setContentType("application/msexcel");
    response.setHeader("Content-disposition", "inline; filename=" + fileN + ".xls");
    try {
      ServletOutputStream sos = response.getOutputStream();
      workbook.write((OutputStream)sos);
      sos.close();
      sos.flush();
    } catch (Exception e) {
      e.printStackTrace();
    } 
    return null;
  }
  
  @RequestMapping(value = {"/manage/report"}, method = {RequestMethod.GET})
  public String manageReport(HttpServletRequest request, Locale locale, Model model) {
    System.out.println("manage report called...");
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    return "/admin/manage-report";
  }
  
  @RequestMapping(value = {"/manage/report/pdf"}, method = {RequestMethod.POST})
  public String reportPdf(HttpServletRequest request, HttpServletResponse response, Locale locale, Model model, String url) throws Exception {
    
	String API_HOST = APIHostUtil.getHost(request);   
	System.out.println("Url:" + url);
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    OkHttpClient client = new OkHttpClient();
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + url)
      .get()
      .addHeader("content-type", "application/pdf;charset=UTF-8")
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    Response _response = client.newCall(_request).execute();
    response.setHeader("Content-Type", "application/pdf;charset=UTF-8");
    ServletOutputStream sos = response.getOutputStream();
    byte[] data = _response.body().bytes();
    sos.write(data);
    sos.flush();
    sos.close();
    _response.body().close();
    return null;
  }
  
  @RequestMapping(value = {"/manage/event"}, method = {RequestMethod.GET})
  public String manageEvent(HttpServletRequest request, Locale locale, Model model) {
    System.out.println("manage event called...");
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    return "/admin/manage-event";
  }
  
  @RequestMapping(value = {"/manage/event/downExcel"}, method = {RequestMethod.POST})
  public String eventExcelForm(Model model, String data, HttpServletRequest request, HttpServletResponse response) {
    System.out.println("data:" + data);
    String type = request.getParameter("ptype");
    HSSFWorkbook workbook = new HSSFWorkbook();
    HSSFSheet sheet = workbook.createSheet("�옣移섏씠踰ㅽ듃");
    HSSFCellStyle hSSFCellStyle = workbook.createCellStyle();
    hSSFCellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
    hSSFCellStyle.setFillPattern((short)1);
    hSSFCellStyle.setAlignment((short)6);
    hSSFCellStyle.setVerticalAlignment((short)1);
    sheet.setColumnWidth(0, 3500);
    sheet.setColumnWidth(1, 5000);
    sheet.setColumnWidth(2, 31500);
    HSSFRow row = sheet.createRow(0);
    HSSFCell cell = row.createCell(0);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("No.");
    cell = row.createCell(1);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("�궇吏�");
    cell = row.createCell(2);
    cell.setCellStyle((CellStyle)hSSFCellStyle);
    cell.setCellValue("�씠踰ㅽ듃");
    
    int rowcount = 1;
    try {
      JSONObject datajson = JSONObject.fromObject(data);
      JSONArray datas = datajson.getJSONArray("events");
      for (int i = 0; i < datas.size(); i++) {
        String strDate = datas.getJSONObject(i).getString("reg_date");
        row = sheet.createRow(rowcount++);
        row.createCell(0).setCellValue(i);
        row.createCell(1).setCellValue(strDate);
        row.createCell(2).setCellValue(datas.getJSONObject(i).getString("eventphase"));
      } 
    } catch (Exception e) {
      e.printStackTrace();
    } 
    String fileN = "device-event-" + DateUtil.getCurrDate("yyyy-MM-dd");
    response.setContentType("application/msexcel");
    response.setHeader("Content-disposition", "inline; filename=" + fileN + ".xls");
    try {
      ServletOutputStream sos = response.getOutputStream();
      workbook.write((OutputStream)sos);
      sos.close();
      sos.flush();
    } catch (Exception e) {
      e.printStackTrace();
    } 
    return null;
  }
  
  @RequestMapping(value = {"/user/list"}, method = {RequestMethod.GET})
  public String users(HttpServletRequest request, Locale locale, Model model) {
    System.out.println("list called...");
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    return "/admin/user-list";
  }
  
  @RequestMapping(value = {"/user/form"}, method = {RequestMethod.GET})
  public String userForm(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("user-form");
    return "/admin/user-form";
  }
  
  @RequestMapping(value = {"/user/add"}, method = {RequestMethod.POST})
  public ResponseEntity<String> userAdd(HttpServletRequest request,@org.springframework.web.bind.annotation.RequestBody Map<String,Object> payload, Locale locale, Model model) throws Exception {
	  
	String API_HOST = APIHostUtil.getHost(request); 
	System.out.println("user-add");
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return new ResponseEntity<String>("redirect:/login",HttpStatus.BAD_REQUEST);
    
    System.out.println();
     
    System.out.println("Authorization : " + authorization); 
    String roles = XssPreventer.escape((String)payload.get("roles"));
    String tel = XssPreventer.escape((String)payload.get("tel")); //request.getParameter("tel");
    String address = XssPreventer.escape((String)payload.get("address"));
    String address2 = XssPreventer.escape((String)payload.get("address2"));
    String postcode = XssPreventer.escape((String)payload.get("postcode"));
    String password = (String)payload.get("password");
    String email = XssPreventer.escape((String)payload.get("email"));
    String memo = XssPreventer.escape((String)payload.get("memo"));
    String name = XssPreventer.escape((String)payload.get("name"));
    String params = "{\t\r\n\t\"tel\" : \"" + tel + "\",\r\n\t\"password\" : \"" + password + "\",\r\n\t\"name\" : \"" + name + "\",\r\n\t\"postcode\" : \"" + postcode + "\",\r\n\t\"address\" : \"" + address + "\",\r\n\t\"address2\" : \"" + address2 + "\",\r\n\t\"email\" : \"" + email + "\",\r\n\t\"memo\" : \"" + memo + "\",\r\n\t\"active\": \"1\",\r\n\t\"roles\": \"" + roles + "\"\r\n}";
    System.out.println("params:" + params);
    OkHttpClient client = new OkHttpClient();
    MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");
    RequestBody body = RequestBody.create(mediaType, params);
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + "/api/users")
      .post(body)
      .addHeader("content-type", "application/json;charset=UTF-8")
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    Response _response = client.newCall(_request).execute();
    System.out.println("response:" + _response.toString());
    _response.body().close();

    switch(_response.code()) {
    case 201:
    	return new ResponseEntity<String>("",HttpStatus.CREATED);
    case 406:
    	return new ResponseEntity<String>("",HttpStatus.NOT_ACCEPTABLE);
    case 409:
    	return new ResponseEntity<String>("",HttpStatus.CONFLICT);
    default:
    	return new ResponseEntity<String>("",HttpStatus.NOT_FOUND);
    }
  }
  
  @RequestMapping(value = {"/user/reauth/update"}, method = {RequestMethod.POST})
  public ResponseEntity<String> userReAuth(HttpServletRequest request ,@org.springframework.web.bind.annotation.RequestBody Map<String,Object> payload, Locale locale, Model model) throws Exception {
    
	String API_HOST = APIHostUtil.getHost(request);
	String tel = (String)payload.get("tel");
	System.out.println("user-reauth-update");
	System.out.println(tel);
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return new ResponseEntity<String>("redirect:/login",HttpStatus.BAD_REQUEST);
    
//    System.out.println("Authorization : " + authorization);
//    String address = XssPreventer.escape((String)payload.get("address"));
//    String address2 = XssPreventer.escape((String)payload.get("address2"));
//    String postcode = XssPreventer.escape((String)payload.get("postcode"));
//    String password = (String)payload.get("password");
//    String email = XssPreventer.escape((String)payload.get("email"));
//    String memo = XssPreventer.escape((String)payload.get("memo"));
//    String name = XssPreventer.escape((String)payload.get("name"));
    String passwordauth = (String)payload.get("passwordauth");
    String params = "{\r\n\t\"tel\" : \"" + tel + "\",\r\n\t\"passwordauth\" : \"" + passwordauth + "\"\r\n}";
    
    System.out.println("params:" + params);
    OkHttpClient client = new OkHttpClient();
    MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");
    RequestBody body = RequestBody.create(mediaType, params);
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + "/api/users/reauth")
      .post(body)
      .addHeader("content-type", "application/json;charset=UTF-8")
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    Response _response = client.newCall(_request).execute();
    System.out.println("response:" + _response.toString());
    _response.body().close();
    
    switch(_response.code()) {
    case 200: 
    	return new ResponseEntity<String>("/admin/user/view?tel=" + tel ,HttpStatus.OK);
    case 405:
    	return new ResponseEntity<String>("",HttpStatus.METHOD_NOT_ALLOWED);
    case 406:
    	return new ResponseEntity<String>("",HttpStatus.NOT_ACCEPTABLE);
    case 409:
    	return new ResponseEntity<String>("",HttpStatus.CONFLICT);
    default:
    	return new ResponseEntity<String>("",HttpStatus.NOT_FOUND);
    }
  }
  
  @RequestMapping(value = {"/user/update/{tel}"}, method = {RequestMethod.PUT})
  public ResponseEntity<String> userUpdate(HttpServletRequest request, @PathVariable String tel ,@org.springframework.web.bind.annotation.RequestBody Map<String,Object> payload, Locale locale, Model model) throws Exception {
	  
	String API_HOST = APIHostUtil.getHost(request);   
	System.out.println("user-update");
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return new ResponseEntity<String>("redirect:/login",HttpStatus.BAD_REQUEST);
    
    System.out.println("Authorization : " + authorization);
    String address = XssPreventer.escape((String)payload.get("address"));
    String address2 = XssPreventer.escape((String)payload.get("address2"));
    String postcode = XssPreventer.escape((String)payload.get("postcode"));
    String password = (String)payload.get("password");
    String email = XssPreventer.escape((String)payload.get("email"));
    String memo = XssPreventer.escape((String)payload.get("memo"));
    String name = XssPreventer.escape((String)payload.get("name"));
    String passwordauth = (String)payload.get("passwordauth");
    String params = "{\r\n\t\"password\" : \"" + password + "\",\r\n\t\"name\" : \"" + name + "\",\r\n\t\"postcode\" : " + postcode + ",\r\n\t\"address\" : \"" + address + "\",\r\n\t\"address2\" : \"" + address2 + "\",\r\n\t\"email\" : \"" + email + "\",\r\n\t\"memo\" : \"" + memo + "\",\r\n\t\"passwordauth\" : \"" + passwordauth +"\",\r\n\t\"active\": 1\r\n}";
    
    System.out.println("params:" + params);
    OkHttpClient client = new OkHttpClient();
    MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");
    RequestBody body = RequestBody.create(mediaType, params);
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + "/api/users/" + tel)
      .put(body)
      .addHeader("content-type", "application/json;charset=UTF-8")
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    Response _response = client.newCall(_request).execute();
    System.out.println("response:" + _response.toString());
    _response.body().close();
    
    switch(_response.code()) {
    case 200:
    	return new ResponseEntity<String>("",HttpStatus.OK);
    case 405:
    	return new ResponseEntity<String>("",HttpStatus.METHOD_NOT_ALLOWED);
    case 406:
    	return new ResponseEntity<String>("",HttpStatus.NOT_ACCEPTABLE);
    case 409:
    	return new ResponseEntity<String>("",HttpStatus.CONFLICT);
    default:
    	return new ResponseEntity<String>("",HttpStatus.NOT_FOUND);
    }
  }
  
  @RequestMapping(value = {"/site/add"}, method = {RequestMethod.POST})
  public ResponseEntity<String> siteAdd(HttpServletRequest request,@org.springframework.web.bind.annotation.RequestBody Map<String,Object> payload, Locale locale, Model model) throws Exception {
	  
	String API_HOST = APIHostUtil.getHost(request); 
	System.out.println("site-add");
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return new ResponseEntity<String>("redirect:/login",HttpStatus.BAD_REQUEST);
    
    System.out.println();
     
    System.out.println("Authorization : " + authorization); 
    String sid = XssPreventer.escape((String)payload.get("sid"));
    String name = XssPreventer.escape((String)payload.get("name")); //request.getParameter("tel");
    String address = XssPreventer.escape((String)payload.get("address"));
    String address2 = XssPreventer.escape((String)payload.get("address2"));
    String builder = XssPreventer.escape((String)payload.get("builder"));
    String owner = XssPreventer.escape((String)payload.get("owner"));
    String tel = XssPreventer.escape((String)payload.get("tel"));
    String latitude = XssPreventer.escape((String)payload.get("latitude"));
    String longitude = XssPreventer.escape((String)payload.get("longitude"));
    String memo = XssPreventer.escape((String)payload.get("memo"));
    String build_date = XssPreventer.escape((String)payload.get("build_date"));
    String tracker_ip = XssPreventer.escape((String)payload.get("tracker_ip"));
    String tracker_port = XssPreventer.escape((String)payload.get("tracker_port"));
    
    LinkedHashMap<String, Object> _linked_hash = (LinkedHashMap)payload.get("device");    
    
    String device = org.json.simple.JSONObject.toJSONString(_linked_hash);

    String params = "{\t\r\n\t\"sid\" : \"" + sid + "\",\r\n\t\"name\" : \"" + name + "\",\r\n\t\"address\" : \"" + address + "\",\r\n\t\"address2\" : \"" + address2 + "\",\r\n\t\"builder\" : \"" + builder + "\",\r\n\t\"owner\" : \"" + owner + "\",\r\n\t\"tel\" : \"" + tel + "\",\r\n\t\"latitude\" : \"" + latitude + "\",\r\n\t\"longitude\" : \"" + longitude + "\",\r\n\t\"memo\" : \"" + memo + "\",\r\n\t\"build_date\": \"" + build_date + "\",\r\n\t\"tracker_ip\": \"" + tracker_ip + "\",\r\n\t\"tracker_port\": \"" + tracker_port + "\",\r\n\t\"device\": " + device + "\r\n}";
    System.out.println("params:" + params);
    OkHttpClient client = new OkHttpClient();
    MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");
    RequestBody body = RequestBody.create(mediaType, params);
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + "/api/sites")
      .post(body)
      .addHeader("content-type", "application/json;charset=UTF-8")
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    Response _response = client.newCall(_request).execute();
    System.out.println("response:" + _response.toString());
    _response.body().close();

    switch(_response.code()) {
    case 201:
    	return new ResponseEntity<String>("",HttpStatus.CREATED);
    case 406:
    	return new ResponseEntity<String>("",HttpStatus.NOT_ACCEPTABLE);
    case 409:
    	return new ResponseEntity<String>("",HttpStatus.CONFLICT);
    default:
    	return new ResponseEntity<String>("",HttpStatus.NOT_FOUND);
    }
  }
  
  @RequestMapping(value = {"/site/update/{sid}"}, method = {RequestMethod.PUT})
  public ResponseEntity<String> siteUpdate(HttpServletRequest request,@PathVariable int sid ,@org.springframework.web.bind.annotation.RequestBody Map<String,Object> payload, Locale locale, Model model) throws Exception {
	  
	String API_HOST = APIHostUtil.getHost(request); 
	System.out.println("site-update");
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return new ResponseEntity<String>("redirect:/login",HttpStatus.BAD_REQUEST);
    
    System.out.println();
     
    System.out.println("Authorization : " + authorization); 
    String address = XssPreventer.escape((String)payload.get("address"));
    String address2 = XssPreventer.escape((String)payload.get("address2"));
    String builder = XssPreventer.escape((String)payload.get("builder"));
    String owner = XssPreventer.escape((String)payload.get("owner"));
    String tel = XssPreventer.escape((String)payload.get("tel"));
    String latitude = XssPreventer.escape((String)payload.get("latitude"));
    String longitude = XssPreventer.escape((String)payload.get("longitude"));
    String memo = XssPreventer.escape((String)payload.get("memo"));
    String build_date = XssPreventer.escape((String)payload.get("build_date"));
    String tracker_ip = XssPreventer.escape((String)payload.get("tracker_ip"));
    String tracker_port = XssPreventer.escape((String)payload.get("tracker_port"));
    
    LinkedHashMap<String, Object> _linked_hash = (LinkedHashMap)payload.get("device");    
    
    String device = org.json.simple.JSONObject.toJSONString(_linked_hash);
    
    String params = "{\t\r\n\t\"address\" : \"" + address + "\",\r\n\t\"address2\" : \"" + address2 + "\",\r\n\t\"builder\" : \"" + builder + "\",\r\n\t\"owner\" : \"" + owner + "\",\r\n\t\"tel\" : \"" + tel + "\",\r\n\t\"latitude\" : \"" + latitude + "\",\r\n\t\"longitude\" : \"" + longitude + "\",\r\n\t\"memo\" : \"" + memo + "\",\r\n\t\"build_date\": \"" + build_date + "\",\r\n\t\"tracker_ip\": \"" + tracker_ip + "\",\r\n\t\"tracker_port\": \"" + tracker_port + "\",\r\n\t\"device\": " + device + "\r\n}";
    System.out.println("params:" + params);
    OkHttpClient client = new OkHttpClient();
    MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");
    RequestBody body = RequestBody.create(mediaType, params);
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + "/api/sites/" + sid)
      .put(body)
      .addHeader("content-type", "application/json;charset=UTF-8")
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    Response _response = client.newCall(_request).execute();
    System.out.println("response:" + _response.toString());
    _response.body().close();

    switch(_response.code()) {
    case 200:
    	return new ResponseEntity<String>("",HttpStatus.OK);
    case 406:
    	return new ResponseEntity<String>("",HttpStatus.NOT_ACCEPTABLE);
    case 409:
    	return new ResponseEntity<String>("",HttpStatus.CONFLICT);
    default:
    	return new ResponseEntity<String>("",HttpStatus.NOT_FOUND);
    }
  }
  
  @RequestMapping(value = {"/devices/add"}, method = {RequestMethod.POST})
  public ResponseEntity<String> deviceAdd(HttpServletRequest request,@org.springframework.web.bind.annotation.RequestBody Map<String,Object> payload, Locale locale, Model model) throws Exception {
	  
	String API_HOST = APIHostUtil.getHost(request); 
	System.out.println("device-add");
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return new ResponseEntity<String>("redirect:/login",HttpStatus.BAD_REQUEST);
    
    System.out.println();
     
    System.out.println("Authorization : " + authorization); 
    String devicetype = XssPreventer.escape((String)payload.get("devicetype"));
    String devicemodel = XssPreventer.escape((String)payload.get("model"));
    String manufacturer = XssPreventer.escape((String)payload.get("manufacturer"));
    String capacity = XssPreventer.escape(StringUtil.nvl((String)payload.get("capacity"), "0"));
    String pcs_capacity = XssPreventer.escape(StringUtil.nvl((String)payload.get("pcs_capacity"), "0"));
    String batt_capacity = XssPreventer.escape(StringUtil.nvl((String)payload.get("batt_capacity"), "0"));
    String batt_type = XssPreventer.escape((String)payload.get("batt_type"));
    String manager = XssPreventer.escape((String)payload.get("manager"));
    String manager_tel = XssPreventer.escape((String)payload.get("manager_tel"));
    String memo = XssPreventer.escape((String)payload.get("memo"));
    String params = "{\n\t\"devicetype\" : \"" + devicetype + "\",\n\t\"model\" : \"" + devicemodel + "\",\n\t\"manufacturer\" : \"" + manufacturer + "\",\n\t\"capacity\" : " + capacity + ",\n\t\"pcs_capacity\" : " + pcs_capacity + ",\n\t\"batt_capacity\" : " + batt_capacity + ",\n\t\"batt_type\" : \"" + batt_type + "\",\n\t\"manager\" : \"" + manager + "\",\n\t\"manager_tel\" : \"" + manager_tel + "\",\n\t\"memo\" : \"" + memo + "\"\n}";    
    System.out.println("params:" + params);
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
    Response _response = client.newCall(_request).execute();
    System.out.println("response:" + _response.toString());
    _response.body().close();

    switch(_response.code()) {
    case 201:
    	return new ResponseEntity<String>("",HttpStatus.CREATED);
    case 406:
    	return new ResponseEntity<String>("",HttpStatus.NOT_ACCEPTABLE);
    case 409:
    	return new ResponseEntity<String>("",HttpStatus.CONFLICT);
    default:
    	return new ResponseEntity<String>("",HttpStatus.NOT_FOUND);
    }
  }
  
  @RequestMapping(value = {"/devices/update"}, method = {RequestMethod.PUT})
  public ResponseEntity<String> deviceUpdate(HttpServletRequest request,@org.springframework.web.bind.annotation.RequestBody Map<String,Object> payload, Locale locale, Model model) throws Exception {
	  
	String API_HOST = APIHostUtil.getHost(request); 
	System.out.println("device-update");
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return new ResponseEntity<String>("redirect:/login",HttpStatus.BAD_REQUEST);
    
    System.out.println();
     
    System.out.println("Authorization : " + authorization); 
    String devicetype = XssPreventer.escape((String)payload.get("devicetype"));
    String devicemodel = XssPreventer.escape((String)payload.get("model"));
    String manufacturer = XssPreventer.escape((String)payload.get("manufacturer"));
    String capacity = XssPreventer.escape(StringUtil.nvl((String)payload.get("capacity"), "0"));
    String pcs_capacity = XssPreventer.escape(StringUtil.nvl((String)payload.get("pcs_capacity"), "0"));
    String batt_capacity = XssPreventer.escape(StringUtil.nvl((String)payload.get("batt_capacity"), "0"));
    String batt_type = XssPreventer.escape((String)payload.get("batt_type"));
    String manager = XssPreventer.escape((String)payload.get("manager"));
    String manager_tel = XssPreventer.escape((String)payload.get("manager_tel"));
    String memo = XssPreventer.escape((String)payload.get("memo"));
    String params = "{\n\t\"capacity\" : " + capacity + ",\n\t\"pcs_capacity\" : " + pcs_capacity + ",\n\t\"batt_capacity\" : " + batt_capacity + ",\n\t\"batt_type\" : \"" + batt_type + "\",\n\t\"manager\" : \"" + manager + "\",\n\t\"manager_tel\" : \"" + manager_tel + "\",\n\t\"memo\" : \"" + memo + "\"\n}";    
    System.out.println("params:" + params);
    OkHttpClient client = new OkHttpClient();
    MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");
    RequestBody body = RequestBody.create(mediaType, params);
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + "/api/devices/" + devicetype + "/" + manufacturer + "/" + devicemodel) 
      .put(body)
      .addHeader("content-type", "application/json;charset=UTF-8")
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    Response _response = client.newCall(_request).execute();
    System.out.println("response:" + _response.toString());
    _response.body().close();

    switch(_response.code()) {
    case 200:
    	return new ResponseEntity<String>("",HttpStatus.OK);
    case 406:
    	return new ResponseEntity<String>("",HttpStatus.NOT_ACCEPTABLE);
    case 409:
    	return new ResponseEntity<String>("",HttpStatus.CONFLICT);
    default:
    	return new ResponseEntity<String>("",HttpStatus.NOT_FOUND);
    }
  }
  
  @RequestMapping(value = {"/user/view"}, method = {RequestMethod.GET})
  public String userView(HttpServletRequest request, Locale locale, Model model, String tel) {
    System.out.println("user-view");
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    
    String referer = (String)request.getHeader("Referer");
    
    System.out.println(referer);
    
    if(referer != null) {
	    String[] aa = referer.split("/");
	    for(int i = 0; i < aa.length ; i++) {
	    	System.out.println(aa[i]);
	    }
	    
	    if (aa[5].equals("reauth"))
	    return "/admin/user-form2";
    }
    
    return "";
  }
  
  @RequestMapping(value = {"/user/reauth/view"}, method = {RequestMethod.GET})
  public String userReAuthView(HttpServletRequest request, Locale locale, Model model, String tel) {
    System.out.println("user-reauth-view");
    String authorization = (String)request.getSession().getAttribute("admin-authorization"); 
    if (authorization == null)
      return "redirect:/login";  
    return "/admin/user-reauth";
  }
  
  @RequestMapping(value = {"/device/list"}, method = {RequestMethod.GET})
  public String deviceList(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("device list called..."); 
//    XssPreventer.escape(request.getParameter("devicetype"));
    return "/admin/device-list";
  }
  
  @RequestMapping(value = {"/device/form"}, method = {RequestMethod.GET})
  public String deviceForm(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("device form called...");
    return "/admin/device-form";
  }
  
  @RequestMapping(value = {"/device/view"}, method = {RequestMethod.GET})
  public String deviceView(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("device form2 called...");
    return "/admin/device-form2";
  }
  
  @RequestMapping(value = {"/site/list"}, method = {RequestMethod.GET})
  public String siteList(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("site list called...");
    return "/admin/site-list";
  }
  
  @RequestMapping(value = {"/site/form"}, method = {RequestMethod.GET})
  public String siteForm(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("site form called...");
    return "/admin/site-form";
  }
  
  @RequestMapping(value = {"/site/view"}, method = {RequestMethod.GET})
  public String siteView(HttpServletRequest request, Locale locale, Model model) {
    String authorization = (String)request.getSession().getAttribute("admin-authorization");
    if (authorization == null)
      return "redirect:/login"; 
    System.out.println("site form2 called...");
    return "/admin/site-form2";
  }
  
  @RequestMapping(value = {"/site/image/view"}, method = {RequestMethod.GET})
  public String siteImageView(HttpServletRequest request, HttpServletResponse response, Locale locale, Model model, String sid) throws Exception {
	String API_HOST = APIHostUtil.getHost(request); 
    String authorization = (String)request.getSession().getAttribute("admin-authorization"); 
    if (authorization == null)
      return "redirect:/login"; 
    OkHttpClient client = new OkHttpClient();
    Request _request = (new Request.Builder())
      .url(String.valueOf(API_HOST) + "/api/sites/" + sid + "/image")
      .get()
      .addHeader("content-type", "image/png;charset=UTF-8")
      .addHeader("authorization", authorization)
      .addHeader("cache-control", "no-cache")
      .build();
    Response _response = client.newCall(_request).execute();
    response.setHeader("Content-Type", "image/png;charset=UTF-8");
    ServletOutputStream sos = response.getOutputStream();
    byte[] data = _response.body().bytes();
    sos.write(data);
    sos.flush();
    sos.close();
    _response.body().close();
    return null;
  }
  
  
  
  private void sendJson(HttpServletResponse response, String str) throws Exception {
    response.setHeader("Content-Type", "application/json;charset=utf-8");
    PrintWriter out = response.getWriter();
    out.print(str);
    out.flush();
    out.close();
  }
}
