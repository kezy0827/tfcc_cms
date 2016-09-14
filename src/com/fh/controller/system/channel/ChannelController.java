package com.fh.controller.system.channel;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.system.Menu;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.service.system.channel.ChannelService;

/** 
 * 类名称：ChannelController
 * 创建人：zhangchunming 
 * 创建时间：2015-03-18
 */
@Controller
@RequestMapping(value="/channel")
public class ChannelController extends BaseController {
	
	@Resource(name="channelService")
	private ChannelService channelService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(Page page) throws Exception{
		logBefore(logger, "新增channel");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String caozuo = pd.getString("caozuo");
		if("save".equals(caozuo)){
			/*pd.put("CHANNEL_ID", this.get32UUID());	//主键
*/			String showobj = pd.getString("showobj");
			if("1".equals(showobj)){
				pd.put("c_isapp", 1);
				pd.put("c_isweb", -1);
			}else if("2".equals(showobj)){
				pd.put("c_isapp", -1);
				pd.put("c_isweb", 1);
			}else{
				pd.put("c_isapp", 1);
				pd.put("c_isweb", 1);
			}
			channelService.save(pd);
		}
		pd.put("c_parent_channel_id", "0");
		page.setPd(pd);
		List<PageData>	varList = channelService.list(page);	//分页列出Channel列表
		mv.setViewName("business/channel/channel_list");
		mv.addObject("varList", varList);
		/*mv.addObject("msg","success");
		mv.setViewName("save_result");*/
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除channel");
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			channelService.delete(pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, "修改channel");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String caozuo = pd.getString("caozuo");
		if("save".equals(caozuo)){
			String showobj = pd.getString("showobj");
			if("1".equals(showobj)){
				pd.put("c_isapp", 1);
				pd.put("c_isweb", -1);
			}else if("2".equals(showobj)){
				pd.put("c_isapp", -1);
				pd.put("c_isweb", 1);
			}else{
				pd.put("c_isapp", 1);
				pd.put("c_isweb", 1);
			}
			channelService.edit(pd);
		}
		Page page = new Page();
		pd.put("c_parent_channel_id", "0");
		page.setPd(pd);
		List<PageData>	varList = channelService.list(page);	//分页列出Channel列表
		mv.setViewName("business/channel/channel_list");
		mv.addObject("varList", varList);
		/*mv.addObject("msg","success");
		mv.setViewName("save_result");*/
		return mv;
	}
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page,HttpServletResponse response){
		logBefore(logger, "列表channel");
		response.setCharacterEncoding("utf-8");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			this.getHC(); //调用权限
			PrintWriter out = response.getWriter();
			String channel_add = pd.getString("channel_add");
			if("news".equals(channel_add)){
				pd.put("c_type", 1);
				List<PageData> listAll = channelService.listAll(pd);	//列出所有Channel列表
				mv.setViewName("business/news/news_channel_add");
				mv.addObject("listAll",listAll);
				return mv;
			}else if("activity".equals(channel_add)){
				pd.put("c_type", 2);
				List<PageData> listAll = channelService.listAll(pd);	//列出所有Channel列表
				mv.setViewName("business/activity/activity_channel_add");
				mv.addObject("listAll",listAll);
				return mv;
			}
			System.out.println(">>>>>>>>>>>"+pd.getString("c_parent_channel_id"));
			if(pd.getString("c_parent_channel_id")==null){
				pd.put("c_parent_channel_id", "0");
			}
			page.setPd(pd);
			List<PageData>	varList = channelService.list(page);	//分页列出Channel列表
			if(pd.getString("c_parent_channel_id")=="0"){
				mv.setViewName("business/channel/channel_list");
			}else{
				/*mv.addObject("msg","success");
				mv.setViewName("save_result");*/
				System.out.println("varList.size()="+varList.size());
				JSONArray channleList = JSONArray.fromObject(varList);
				//out.write("success");
				out.print(channleList);
				out.close();
				return null;
			}
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增Channel页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("business/channel/channel_edit");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去修改Channel页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = channelService.findById(pd);	//根据ID读取
			mv.setViewName("business/news/news_channel_add");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
			//上级分类下拉菜单列表查询
			pd.put("c_type", 1);
			List<PageData> listAll = channelService.listAll(pd);	//列出所有Channel列表
			mv.addObject("listAll",listAll);
			return mv;
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除Channel");
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				channelService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}
	
	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "导出channel到excel");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("频道名称");	//1
			titles.add("上级频道  跟为0");	//2
			titles.add("频道类型 1：新闻频道  2：活动频道");	//3
			titles.add("是否在web端显示   1:是  -1：否");	//4
			titles.add("是否在app端显示   1:是  -1：否");	//5
			titles.add("权重   展示在网站或app中 该频道的排序");	//6
			titles.add("是否是连接  1:是  -1：否");	//7
			titles.add("链接地址");	//8
			titles.add("频道描述");	//9
			dataMap.put("titles", titles);
			List<PageData> varOList = channelService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("c_name"));	//1
				vpd.put("var2", varOList.get(i).get("c_parent_channel_id").toString());	//2
				vpd.put("var3", varOList.get(i).get("c_type").toString());	//3
				vpd.put("var4", varOList.get(i).get("c_isweb").toString());	//4
				vpd.put("var5", varOList.get(i).get("c_isapp").toString());	//5
				vpd.put("var6", varOList.get(i).get("c_weight").toString());	//6
				vpd.put("var7", varOList.get(i).get("c_isurl").toString());	//7
				vpd.put("var8", varOList.get(i).getString("c_url"));	//8
				vpd.put("var9", varOList.get(i).getString("c_describe"));	//9
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/* ===============================权限================================== */
	public void getHC(){
		ModelAndView mv = this.getModelAndView();
		HttpSession session = this.getRequest().getSession();
		Map<String, String> map = (Map<String, String>)session.getAttribute(Const.SESSION_QX);
		mv.addObject(Const.SESSION_QX,map);	//按钮权限
		List<Menu> menuList = (List)session.getAttribute(Const.SESSION_menuList);
		mv.addObject(Const.SESSION_menuList, menuList);//菜单权限
	}
	/* ===============================权限================================== */
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
