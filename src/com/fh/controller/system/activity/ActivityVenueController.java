package com.fh.controller.system.activity;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.service.system.activity.ActivityService;
import com.fh.service.system.activity.ActivityVenueService;
import com.fh.service.system.activity.VenuePublicAccountService;
import com.fh.util.PageData;

/** 
 * 类名称：ActivityVenueController
 * 创建人：zhangchunming
 * 创建时间：2015年03月23日
 * @version
 */
@Controller
@RequestMapping(value="/activityvenue")
public class ActivityVenueController extends BaseController{
	@Resource(name="activityVenueListService")
	private ActivityVenueService activityVenueListService;
	
	@Resource(name="accountService")
	private VenuePublicAccountService accountService;
	
	@Resource(name="activityService")
	private ActivityService activityService;
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView listUsers(Page page) throws Exception{
		logBefore(logger, "场馆列表Activity");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String activity_id = pd.getString("activity_id");
			pd.put("activity_id", activity_id);
			page.setPd(pd);
			List<PageData> list = activityVenueListService.list(page);
			System.out.println("-----------------------------------------"+list.size());
			//调用权限
			this.getHC(); //================================================================================
			//调用权限
			mv.setViewName("business/venues/activity_venue_list");
			mv.addObject("varList", list);
			mv.addObject("activity_id", activity_id);
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
		mv.clear();
		pd = this.getPageData();
		try {
			String activity_id = pd.getString("activity_id");
			mv.setViewName("business/venues/activity_venue_edit");
			mv.addObject("activity_id", activity_id);
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
		mv.clear();
		pd = this.getPageData();
		try {
			pd = activityVenueListService.getOneVenue(pd);
			mv.setViewName("business/venues/activity_venue_edit");
			mv.addObject("pd", pd);
			mv.addObject("activity_id", String.valueOf(pd.get("activity_id")));
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	
	/**
	 * 保存
	 */
	/*@RequestMapping(value="/save")
	public ModelAndView save(Page page) throws Exception{
		logBefore(logger, "添加场馆");
		ModelAndView mv = this.getModelAndView();
		mv.clear();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			activityVenueListService.save(pd);
			mv.addObject("msg","success");
			mv.setViewName("save_result");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error(e.toString(), e);
		}
		return mv;
	}*/
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "添加场馆");
		ModelAndView mv = this.getModelAndView();
		mv.clear();
		PageData pd = new PageData();
		PageData pd2 = new PageData();
		pd = this.getPageData();
		if(!pd.isEmpty()){
			try {
				pd2.put("activity_id", pd.getString("activity_id"));
				pd.remove("activity_id");
				Set<Map.Entry<String, String>> entryseSet=pd.entrySet();
				  for (Map.Entry<String, String> entry:entryseSet) {  
					  pd2.put("id", entry.getValue());
					  PageData account = accountService.oneAccount(pd2);
					  pd2.put("venue_public_account_id", String.valueOf(account.get("id")));
					  pd2.put("venue_name", account.getString("nickname"));
					  pd2.put("venue_address", account.getString("address"));
					/*String []key_value =  entry.getValue().split("-"); 
					pd2.put("venue_public_account_id", key_value[0]);
					pd2.put("venue_name", key_value[1]);
				   System.out.println(entry.getKey()+","+entry.getValue());  */
				   activityVenueListService.save(pd2);
				  }
				  activityService.update_alert_html(pd2);
				//activityVenueListService.save(pd);
				//PageData accout = accountService.oneAccount(pd);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				logger.error(e.toString(), e);
			}
		}
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out)throws Exception{
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			activityVenueListService.delVenue(pd);
			out.write("success");
			out.flush();
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}
	/**
	 * 修改
	 */
	@RequestMapping(value="/update")
	public ModelAndView update(Page page)throws Exception{
		logBefore(logger, "添加场馆");
		ModelAndView mv = this.getModelAndView();
		mv.clear();
		try {
			pd = this.getPageData();
			activityVenueListService.update(pd);
			mv.addObject("msg","success");
			mv.setViewName("save_result");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/* ===============================权限================================== */
	public void getHC(){
		HttpSession session = this.getRequest().getSession();
		Map<String, Integer> map = (Map<String, Integer>)session.getAttribute("QX");
		mv.addObject("QX",map);	//按钮权限
		
		List<Menu> menuList = (List)session.getAttribute("menuList");
		mv.addObject("menuList", menuList);//菜单权限
	}
	/* ===============================权限================================== */
}

