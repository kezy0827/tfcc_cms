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
@RequestMapping(value="/service/bank")
public class BankInfoController extends BaseController {

	@Resource(name="bankInfoService")
    private BankInfoService bankInfoService;
	
	
	
	@RequestMapping(value="/getbankinfo",method=RequestMethod.GET)
	@ResponseBody
	public  ModelAndView BankInfolist(Page page){//查询银行信息列表
	ModelAndView mv = this.getModelAndView();
	try {
		List<PageData> bankInfoList = bankInfoService.findBankInfoList(page);
		mv.addObject(bankInfoList);
	} catch (Exception e) {
		e.printStackTrace();
	}
		return mv;
	}
	
	@RequestMapping(value="/updatestatus",method=RequestMethod.GET)
	@ResponseBody
	public AjaxResponse updateBankStatus(){//更新银行账户启用状态
		try {
			System.out.println("+++++++++++++++++=");
			pd=this.getPageData();
			//int id = Integer.parseInt(pd.get("id").toString());
			int id=0;//测试用
			pd.put("id", id);
			bankInfoService.updateBankState(pd);
			ar.setSuccess(true);
			ar.setMessage("更新成功");
		} catch (Exception e) {
			ar.setSuccess(false);
			ar.setMessage("更新失败");
			e.printStackTrace();
		}
		return ar;
	}
	
	@RequestMapping(value="/addbankinfo",method=RequestMethod.GET)
	@ResponseBody
	public AjaxResponse addBankInfo(){//添加银行账户信息
		
		try {
			System.out.println("+++++++++++++++++=");
			pd=this.getPageData();
			pd.put("orgname", "北京区块链公司");//测试
			pd.put("payname", "王麻子");
			pd.put("checkphone", "17793178879");
			pd.put("payeeno", "296192942@qq.com");
			bankInfoService.addBankAccNo(pd);
			ar.setSuccess(true);
			ar.setMessage("添加成功");
			
		} catch (Exception e) {
			ar.setSuccess(false);
			ar.setMessage("添加失败");
			e.printStackTrace();
		}
		return ar;
	}
	
}
