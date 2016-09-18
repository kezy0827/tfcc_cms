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
import com.fh.service.business.trade.TradeDetailService;
import com.fh.util.AjaxResponse;
import com.fh.util.PageData;

/** 
 * 类名称：TradeDetailController
 * 创建人：zhangchunming
 * 创建时间：2016年09月17日
 * @version
 */
@Controller
@RequestMapping(value="/trade")
public class TradeDetailController extends BaseController{
	@Resource(name="tradeDetailService")
	private TradeDetailService tradeDetailService;
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/tradeListPage")
	public ModelAndView tradeListPage(Page page) throws Exception{
		logBefore(logger, "交易订单列表");
		ModelAndView mv = this.getModelAndView();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			List<PageData> list = tradeDetailService.list(page);
			System.out.println("-----------------------------------------"+list.size());
			//调用权限
			this.getHC(); //================================================================================
			//调用权限
			mv.setViewName("business/trade/trade_list");
			mv.addObject("varList", list);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * @describe:编辑/审核
	 * @author: zhangchunming
	 * @date: 2016年9月17日下午4:22:18
	 * @return: void
	 */
	
	@RequestMapping(value="/edit")
    public ModelAndView edit(Page page) throws Exception{
        logBefore(logger, "编辑");
        ModelAndView mv = this.getModelAndView();
        try{
            pd = this.getPageData();
            tradeDetailService.edit(pd);
            pd = new PageData();
            page.setPd(pd);
            List<PageData> list = tradeDetailService.list(page);
            System.out.println("-----------------------------------------"+list.size());
            //调用权限
            this.getHC(); //================================================================================
            //调用权限
            mv.setViewName("business/trade/trade_list");
            mv.addObject("varList", list);
            mv.addObject("pd", pd);
        } catch(Exception e){
            logger.error(e.toString(), e);
        }
        return mv;
    }
	/**
	 * @describe:查看订单详情
	 * @author: zhangchunming
	 * @date: 2016年9月17日下午5:19:55
	 * @throws Exception
	 * @return: ModelAndView
	 */
	@RequestMapping(value="/toEdit")
    public ModelAndView toEdit() throws Exception{
        logBefore(logger, "交易订单详情");
        ModelAndView mv = this.getModelAndView();
        try{
            pd = this.getPageData();
            pd = tradeDetailService.getTradeById(pd);
            //调用权限
            this.getHC(); //================================================================================
            //调用权限
            mv.setViewName("business/trade/trade_edit");
            mv.addObject("pd", pd);
        } catch(Exception e){
            logger.error(e.toString(), e);
        }
        return mv;
    }
	/**
	 * @describe:审核
	 * @author: zhangchunming
	 * @date: 2016年9月17日下午5:48:27
	 * @throws Exception
	 * @return: ModelAndView
	 */
	@RequestMapping(value="/updateStatus")
	@ResponseBody
	public AjaxResponse updateStatus() throws Exception{
	    logBefore(logger, "更新订单状态");
	    try{
	        pd = this.getPageData();
	        tradeDetailService.updateStatus(pd);
	        ar.setSuccess(true);
	        ar.setMessage("审核完毕！");
	    } catch(Exception e){
	        logger.error(e.toString(), e);
	        ar.setSuccess(false);
            ar.setMessage("系统异常，审核失败！");
	    }
	    return ar;
	}
	/**
	 * @describe:删除订单
	 * @author: zhangchunming
	 * @date: 2016年9月17日下午5:48:50
	 * @throws: Exception
	 * @return: ModelAndView
	 */
	@RequestMapping(value="/del",method=RequestMethod.POST)
	@ResponseBody
    public AjaxResponse del() throws Exception{
        logBefore(logger, "删除订单");
        try{
            pd = this.getPageData();
            tradeDetailService.del(pd);
            ar.setSuccess(true);
            ar.setMessage("删除成功！");
        } catch(Exception e){
            logger.error(e.toString(), e);
            ar.setSuccess(false);
            ar.setMessage("系统异常，删除失败！");
        }
        return ar;
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

