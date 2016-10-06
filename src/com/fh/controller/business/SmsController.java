package com.fh.controller.business;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.business.sms.SmsService;
import com.fh.service.business.user.UserDetailService;
import com.fh.util.AjaxResponse;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.PageData;
import com.fh.util.SmsSend;


@Controller
@RequestMapping(value="/sms")
public class SmsController extends BaseController {
	
	@Resource(name="smsService")
	private SmsService smsService;
	
	@Resource(name="userDetailService")
	private UserDetailService userDetailService;
	
	@RequestMapping(value="/sendsms",method=RequestMethod.POST)
	@ResponseBody
	public AjaxResponse sendSms(HttpServletRequest request){
		try {
			User user = (User)request.getSession().getAttribute(Const.SESSION_USER);
			pd=this.getPageData();
			String phones=pd.getString("phone");//要发送短信的手机号
			String content = pd.getString("content");//获取发送短信的内容
			//List<PageData> findsmsPhone = smsService.findsmsPhone(pd);
			/*for (PageData pageData : findsmsPhone) {
				String phone = pageData.getString("phone");//查询黑名单中的手机号
				if (phone.equals(phones)) {
					System.out.println("此人已进入黑名单");
				}else{
					SmsSend.sendSms(phones, content);
				}
			}*/
			
			pd.put("sendtime", DateUtil.getDays());
			pd.put("updatetime", DateUtil.getDays());
			pd.put("createtime", DateUtil.getDays());
			pd.put("operatorname", user.getNAME());
			pd.put("operatoraccno", user.getUSERNAME());
			smsService.addSms(pd);
			ar.setSuccess(true);
			ar.setMessage("发送成功");
			
		} catch (Exception e) {
			ar.setSuccess(false);
			ar.setMessage("发送失败");
			e.printStackTrace();
		}
		return ar;
	}

	
	@RequestMapping(value="/getsmslist",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView findSendSmsInfo(Page page){
		try {
			pd=this.getPageData();
			page.setPd(pd);
			List<PageData> smsList = smsService.findSendSmsList(page);
			mv.setViewName("business/smss/sms_list");
			mv.addObject("smsList", smsList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping(value="/toSingleSend",method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView toSingleSend(){
		try {
			mv.setViewName("business/smss/single_send");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	
}
