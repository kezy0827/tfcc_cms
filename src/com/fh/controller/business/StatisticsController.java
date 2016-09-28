package com.fh.controller.business;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.service.business.statistics.StatisticsService;
import com.fh.util.AjaxResponse;
import com.fh.util.PageData;

/** 
 * 类名称：StatisticsController
 * 创建人：zhangchunming
 * 创建时间：2016年09月27日
 * @version
 */
@Controller
@RequestMapping(value="/statistics")
public class StatisticsController extends BaseController{
	
	@Resource(name="statisticsService")
	private StatisticsService statisticsService;
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/getStatistics")
	public ModelAndView getStatistics(Page page) throws Exception{
		logBefore(logger, "网站统计");
		ModelAndView mv = this.getModelAndView();
		try{
			pd = this.getPageData();
			PageData registerNum = statisticsService.getRegisterNum(pd);
			PageData buySAN = statisticsService.getBuySAN(pd);
			PageData zZSAN = statisticsService.getZZSAN(pd);
			PageData reward = statisticsService.getReward(pd);
			PageData bonuses = statisticsService.getBonuses(pd);
			PageData sysSAN = statisticsService.getSysSAN(pd);
			//调用权限
			this.getHC(); //================================================================================
			//调用权限
			mv.setViewName("business/statistics/statistics");
			mv.addObject("registerNum", registerNum);
			mv.addObject("buySAN", buySAN);
			mv.addObject("zZSAN", zZSAN);
			mv.addObject("reward", reward);
			mv.addObject("bonuses", bonuses);
			mv.addObject("sysSAN", sysSAN);
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

