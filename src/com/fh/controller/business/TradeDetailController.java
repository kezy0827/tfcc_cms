package com.fh.controller.business;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.fh.service.business.syscode.SysGencodeService;
import com.fh.service.business.trade.TradeDetailService;
import com.fh.util.AjaxResponse;
import com.fh.util.ObjectExcelView;
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
	
	@Resource(name="sysGencodeService")
	private SysGencodeService sysGencodeService;
	
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
			List<PageData> list = tradeDetailService.listPage(page);
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
	@ResponseBody
    public ModelAndView edit(Page page) throws Exception{
        logBefore(logger, "编辑");
        try{
            pd = this.getPageData();
            //查询购买上下限
            /*pd.put("groupcode", "REWARD_DEF");
            List<PageData>  tcodelist = sysGencodeService.list(pd);
            if(tcodelist == null ||tcodelist.size() == 0){
                ar.setSuccess(false);
                ar.setMessage("系统奖励规则设置有误，请修正后再进行操作！");
                logger.debug("t_code_group或者t_general_code表中没有对应的group_code(REWARD_DEF)的记录");
                return ar;
            }
            String total_times_limit = "";
            String single_times_lower_limit = "";
            String single_times_upper_limit = "";
            for(PageData tpd:tcodelist){
                if("TOTAL_TIMES_LIMIT".equals(tpd.getString("codeName"))){
                    total_times_limit = tpd.getString("codeValue");
                }
                if("SINGLE_TIMES_LOWER_LIMIT".equals(tpd.getString("codeName"))){
                    single_times_lower_limit = tpd.getString("codeValue");
                }
                if("SINGLE_TIMES_UPPER_LIMIT".equals(tpd.getString("codeName"))){
                    single_times_upper_limit = tpd.getString("codeValue");
                }
            }
            if(total_times_limit.equals("")||single_times_lower_limit.equals("")||single_times_upper_limit.equals("")){
                ar.setSuccess(false);
                ar.setMessage("购买上限下限设置有误，请修正后再进行操作！");
                logger.debug("购买上限下限设置有误！");
                return ar;
            }
            PageData tpd= tradeDetailService.selectBuyTimesByUserCode(pd);
            if(tpd != null && Integer.parseInt(tpd.getString("buyTimes"))>=Integer.parseInt(total_times_limit)){
                ar.setSuccess(false);
                ar.setMessage("对不起，您的购买次数已用完！");
                return ar;
            }*/
            tradeDetailService.updateTradeDetail(pd);
            return new ModelAndView("redirect:/trade/tradeListPage.do");
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
            tradeDetailService.updateIsShow(pd);
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
	@RequestMapping(value="/testTriger",method=RequestMethod.POST)
	@ResponseBody
	public AjaxResponse testTriger(){
	    try {
            tradeDetailService.updateTriger();
            ar.setSuccess(true);
            ar.setMessage("执行成功！");
        } catch (Exception e) {
            System.out.println("捕获数据库异常！");
            ar.setSuccess(false);
            ar.setMessage("捕获异常！");
            e.printStackTrace();
        }
	    return ar;
	}
	
	/*
	 * 导出用户信息到EXCEL
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			
//			titles.add("系统来源"); 		//1
			titles.add("订单号");  		//2
			titles.add("会员姓名");			//3
			titles.add("手机号");			//4
			titles.add("交易数量");			//5
			titles.add("交易金额");			//6
			titles.add("购买时间");		//7
			titles.add("支付时间");	//8
			titles.add("支付账号");	//9
			titles.add("订单状态");	//10
			
			dataMap.put("titles", titles);
			
			List<PageData> userList = tradeDetailService.listAllTrade(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<userList.size();i++){
				PageData vpd = new PageData();
//				vpd.put("var1", userList.get(i).getString("source_system"));		//1
				vpd.put("var1", userList.get(i).getString("order_no"));		//2
				vpd.put("var2", userList.get(i).getString("real_name"));			//3
				vpd.put("var3", userList.get(i).getString("phone"));	//4
				vpd.put("var4", userList.get(i).get("txnum")==null?"0.0000":String.format("%.4f",new BigDecimal(userList.get(i).get("txnum").toString()))); 
				vpd.put("var5", userList.get(i).get("txamnt")==null?"0.0000":String.format("%.4f",new BigDecimal(userList.get(i).get("txamnt").toString()))); 
				vpd.put("var6", userList.get(i).getString("txdate"));	//7
				vpd.put("var7", userList.get(i).getString("pay_time"));			//8
				vpd.put("var8", userList.get(i).getString("payno"));			//9
				vpd.put("var9", userList.get(i).getString("status"));			//10
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
}

