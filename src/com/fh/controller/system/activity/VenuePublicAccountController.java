package com.fh.controller.system.activity;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.service.system.activity.VenuePublicAccountService;
import com.fh.util.Const;
import com.fh.util.PageData;
/** 
 * 类名称：VenuePublicAccountController
 * 创建人：zhangchunming
 * 创建时间：2015年03月25日
 * @version
 */
@Controller
@RequestMapping(value="/account")
public class VenuePublicAccountController extends BaseController {
	
	@Resource(name="accountService")
	private VenuePublicAccountService accountService;
	/**
	 * 公众号查询列表列表
	 */
	@RequestMapping(value="/accountlist")
	public ModelAndView accountlist(Page page){
		logBefore(logger, "查询公众号列表");
		ModelAndView mv = this.getModelAndView();
		mv.clear();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			List<PageData> accountList = accountService.list(pd);
			this.getHC(); //调用权限
			mv.setViewName("business/account/venue_public_account_add");
			mv.addObject("varList", accountList);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 保存公众号到活动添加页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goEdit(){
		logBefore(logger, "保存公众号到活动添加页面");
		ModelAndView mv = this.getModelAndView();
		mv.clear();
		try{
			pd = this.getPageData();
			this.getHC(); //调用权限
			/*mv.setViewName("business/activity/offline_activity_add");*/
			mv.addObject("pd", pd);
			mv.addObject("msg","success");
			mv.setViewName("save_result");
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
