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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.service.business.user.UserDetailService;
import com.fh.util.AjaxResponse;
import com.fh.util.Const;
import com.fh.util.MD5Util;
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
			List<PageData> list = userDetailService.listPageUserDetail(page);
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
	@RequestMapping(value="/getUserDetail",produces = "text/html;charset=UTF-8")
	public ModelAndView getUserDetail(Page page) throws Exception{
	    logBefore(logger, "查询下级会员列表");
	    ModelAndView mv = this.getModelAndView();
	    try{
	        pd = this.getPageData();
	        //查询用户详细信息
	        PageData userDetail = userDetailService.findByPhone(pd);
	        pd.put("user_code", userDetail.get("user_code").toString());
	        
	        //查询会员数量
	        PageData vip = userDetailService.findcount(pd);
	        
	        //查询会员奖励列表
	        page.setPd(pd);
	        List<PageData> list = userDetailService.listPageVIP(page);
	        
	        System.out.println("-----------------------------------------"+list.size());
	        //调用权限
	        this.getHC(); //================================================================================
	        //调用权限
	        mv.setViewName("business/user/userDetail");
	        mv.addObject("vip", vip);
	        mv.addObject("userDetail", userDetail);
	        mv.addObject("varList", list);
	        mv.addObject("pd", pd);
	    } catch(Exception e){
	        logger.error(e.toString(), e);
	    }
	    return mv;
	}
	/*@RequestMapping(value="/getUserDetail")
	public ModelAndView getUserDetail(Page page) throws Exception{
	    logBefore(logger, "查询会员详情");
	    ModelAndView mv = this.getModelAndView();
	    try{
	        pd = this.getPageData();
	        page.setPd(pd);
	        PageData userDetail = userDetailService.findByPhone(pd);
	        //调用权限
	        this.getHC(); //================================================================================
	        //调用权限
	        mv.setViewName("business/user/userDetail");
	        mv.addObject("userDetail", userDetail);
	    } catch(Exception e){
	        logger.error(e.toString(), e);
	    }
	    return mv;
	}*/
	
	/**
	 * @describe:修改购买标识
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
	@RequestMapping(value="/disableStatus")
	@ResponseBody
	public AjaxResponse disableStatus() throws Exception{
	    logBefore(logger, "修改用户状态");
	    try{
	        pd = this.getPageData();
	        userDetailService.updateUserStatus(pd);
	        ar.setSuccess(true);
	    } catch(Exception e){
	        logger.error(e.toString(), e);
	        ar.setSuccess(false);
	        ar.setMessage("系统异常，修改失败！");
	    }
	    return ar;
	}
	@RequestMapping(value="/resetPassword")
	@ResponseBody
	public AjaxResponse resetPassword() throws Exception{
	    logBefore(logger, "重置密码");
	    try{
	        //密码重置为000000
	        pd = this.getPageData();
	        pd.put("pwdhash", MD5Util.getMd5Code("s111111"));
	        userDetailService.resetPassword(pd);
	        ar.setSuccess(true);
	        ar.setMessage("密码重置成功");
	    } catch(Exception e){
	        logger.error(e.toString(), e);
	        ar.setSuccess(false);
	        ar.setMessage("系统异常，修改失败！");
	    }
	    return ar;
	}
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
        mv.addObject(Const.SESSION_QX,map); //按钮权限
        List<Menu> menuList = (List)session.getAttribute(Const.SESSION_menuList);
        mv.addObject(Const.SESSION_menuList, menuList);//菜单权限
    }
    /* ===============================权限================================== */
	
}
