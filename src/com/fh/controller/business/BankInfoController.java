package com.fh.controller.business;
import java.util.List;
import javax.annotation.Resource;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.business.acc.BankInfoService;
import com.fh.util.AjaxResponse;
import com.fh.util.PageData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/bank")
public class BankInfoController extends BaseController {

	@Resource(name="bankInfoService")
    private BankInfoService bankInfoService;
	
	
	
	@RequestMapping(value="/getbankinfo",method=RequestMethod.GET)
	@ResponseBody
	public  ModelAndView BankInfolist(Page page){//查询银行信息列表
	ModelAndView mv = this.getModelAndView();
	try {
		List<PageData> bankInfoList = bankInfoService.findBankInfoList(page);
		
		mv.setViewName("business/account/bankinfo_list");
		mv.addObject("varList",bankInfoList);
	} catch (Exception e) {
		e.printStackTrace();
	}
		return mv;
	}
	
	@RequestMapping(value="/updatestatus",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView updateBankStatus(PageData pd){//更新银行账户启用状态
		ModelAndView mv = this.getModelAndView();
		try {
			System.out.println("+++++++++++++++++=");
			pd=this.getPageData();
			String id = pd.get("id").toString();		
			bankInfoService.updateBankState(pd);
			

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping(value="/addbankinfo",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView addBankInfo(){//添加银行账户信息
		//ModelAndView mv = this.getModelAndView();
		try {
			pd=this.getPageData();
			pd.put("status", "0");
			pd.put("operator", "sys");
			bankInfoService.addBankAccNo(pd);
			
		} catch (Exception e) {
			ar.setSuccess(false);
			
		}
		return  new ModelAndView("redirect:/bank/getbankinfo.do");
	}
	
}
