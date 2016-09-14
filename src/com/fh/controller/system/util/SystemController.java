package com.fh.controller.system.util;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.controller.base.BaseController;
import com.fh.service.system.activity.util.SystemService;
import com.fh.util.PageData;

/** 
 * 类名称：SystemController
 * 创建人：zhangchunming 
 * 创建时间：2015-03-17
 */
@Controller
@RequestMapping(value="/util")
public class SystemController extends BaseController {
	
	@Resource(name="systemservice")
	private SystemService systemservice;
	
	/**
	 * 获取省市区
	 */
	@RequestMapping(value="/getCityList")
	@ResponseBody
	/*public Object getCityList() {
		logBefore(logger, "获取省、市、区");
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> cityList = new ArrayList<PageData>();
			cityList = systemservice.cityList(pd);
			System.out.println("cityList.size()="+cityList.size());
			map.put("list", cityList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}*/
	public void getCityList(HttpServletResponse response) {
		logBefore(logger, "获取省、市、区");
		PageData pd = new PageData();	
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Content-Type", "text/html; charset=UTF-8");
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			PrintWriter out = response.getWriter();         
			pd = this.getPageData();
			List<PageData> cityList = new ArrayList<PageData>();
			cityList = systemservice.cityList(pd);
			System.out.println("cityList.size()="+cityList.size());
			JSONArray fromObject = JSONArray.fromObject(cityList);
			
			map.put("list", fromObject);
			//out.write("success");
			out.print(fromObject);
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
	}
}
