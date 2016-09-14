package com.fh.controller.business.logMgr;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.service.business.logmgr.LogSmsService;
import com.fh.util.PageData;

/** 
 * 类名称：LogSmsController
 * 创建人：LZH
 * 创建时间：2015年04月03日
 * @version
 */
@Controller
@RequestMapping(value="/logsms")
public class LogSmsController extends BaseController{
	@Resource(name="logSmsService")
	private LogSmsService logSmsService;
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/logSmsListAll")
	public ModelAndView listLogSms(Page page) throws Exception{
		logBefore(logger, "日志短信列表");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			List<PageData> list = logSmsService.list(page);
			System.out.println("-----------------------------------------"+list.size());
			//调用权限
			this.getHC(); //================================================================================
			//调用权限
			mv.setViewName("business/log/log_sms_list");
			mv.addObject("varList", list);
			mv.addObject("pd", pd);
		} catch(Exception e){
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

