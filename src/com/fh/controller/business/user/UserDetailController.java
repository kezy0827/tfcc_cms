package com.fh.controller.business.user;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.service.business.user.UserDetailService;
import com.fh.util.AjaxResponse;
import com.fh.util.Const;
import com.fh.util.PageData;

/** 
 * 类名称：UserController
 * 创建人：FH 
 * 创建时间：2014年6月28日
 * @version
 */
@Controller
@RequestMapping(value="/business/user")
public class UserDetailController extends BaseController {
	
	@Resource(name="userDetailService")
	private UserDetailService userDetailService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	

	/* ===============================权限================================== */
	public void getHC(){
		ModelAndView mv = this.getModelAndView();
		//shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		Map<String, String> map = (Map<String, String>)session.getAttribute(Const.SESSION_QX);
		mv.addObject(Const.SESSION_QX,map);	//按钮权限
		List<Menu> menuList = (List)session.getAttribute(Const.SESSION_menuList);
		mv.addObject(Const.SESSION_menuList, menuList);//菜单权限
	}
	/* ===============================权限================================== */
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/userbuyListPage")
	public ModelAndView userbuyListPage(Page page) throws Exception{
		logBefore(logger, "查询会员列表");
		ModelAndView mv = this.getModelAndView();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			List<PageData> list = userDetailService.listPdPageUserbuy(page);
			System.out.println("-----------------------------------------"+list.size());
			//调用权限
			this.getHC(); //================================================================================
			//调用权限
			mv.setViewName("business/user/userbuy_list");
			mv.addObject("varList", list);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	@RequestMapping(value="/getUserDetail")
	public ModelAndView getUserDetail(Page page) throws Exception{
	    logBefore(logger, "查询会员详情");
	    ModelAndView mv = this.getModelAndView();
	    try{
	        pd = this.getPageData();
	        page.setPd(pd);
	        PageData userDetail = userDetailService.getUserDetail(page);
	        //调用权限
	        this.getHC(); //================================================================================
	        //调用权限
	        mv.setViewName("business/user/userDetail");
	        mv.addObject("userDetail", userDetail);
	    } catch(Exception e){
	        logger.error(e.toString(), e);
	    }
	    return mv;
	}
	
	/**
	 * @describe:审核
	 * @author: kezhiyi
	 * @date: 2016年9月25日下午5:48:27
	 * @throws Exception
	 * @return: ModelAndView
	 */
	@RequestMapping(value="/updatebuyStatus")
	@ResponseBody
	public AjaxResponse updatebuyStatus() throws Exception{
	    logBefore(logger, "更新用户购买状态");
	    try{
	        pd = this.getPageData();
	        userDetailService.updateBuyStatus(pd);
	        ar.setSuccess(true);
	        ar.setMessage("更新完毕！");
	    } catch(Exception e){
	        logger.error(e.toString(), e);
	        ar.setSuccess(false);
            ar.setMessage("系统异常，审核失败！");
	    }
	    return ar;
	}
	
	
}
