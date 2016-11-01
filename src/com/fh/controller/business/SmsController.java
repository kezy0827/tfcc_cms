package com.fh.controller.business;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
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
import com.fh.util.FlowNoGenerater;
import com.fh.util.PageData;
import com.fh.util.Validator;


@Controller
@RequestMapping(value="/sms")
public class SmsController extends BaseController {
	
	@Resource(name="smsService")
	private SmsService smsService;
	
	@Resource(name="userDetailService")
	private UserDetailService userDetailService;
	
	@RequestMapping(value="/sendSms",method=RequestMethod.POST)
	@ResponseBody
	public AjaxResponse sendSms(HttpServletRequest request){
	    logBefore(logger,"SmsController.sendSms--------批量发送短信---------");
	    AjaxResponse ar = new AjaxResponse();
		try {
		   //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();  
            Session session = currentUser.getSession();
            User user = (User)session.getAttribute(Const.SESSION_USER);
            
			PageData pd = new PageData();
			pd=this.getPageData();
			if("1".equals(pd.getString("send_type"))){//全部发送时，根据条件从库里查询手机号
			    if(StringUtils.isEmpty(pd.getString("content"))){
			        ar.setSuccess(false);
                    ar.setMessage("请输入短信内容！"); 
                    return ar;
			    }
			    if("1".equals(pd.getString("send_range"))){//全部用户
			        pd.put("freeze_flag", "");
			    }else if("2".equals(pd.getString("send_range"))){//普通会员
			        pd.put("freeze_flag", "1");
			    }else if("3".equals(pd.getString("send_range"))){//投资机构
                    pd.put("freeze_flag", "0");
                }
			    if(StringUtils.isEmpty(pd.get("id").toString())){
                    pd.put("sms_status", "2");//发送中
                    pd.put("flow_id", FlowNoGenerater.generateOrderNo());
                }
                pd.put("operator_accno", user.getUSERNAME());
                pd.put("operator_name", user.getNAME());
			    boolean smsResult = smsService.sendAllSms(pd);
			    if(smsResult){
                    ar.setSuccess(true);
                    ar.setMessage("发送成功"); 
                    return ar;
                }else{
                    ar.setSuccess(false);
                    ar.setMessage("发送失败"); 
                    return ar;
                }
			}else{
			    String phoneStr=pd.getString("phone").trim();//要发送短信的手机号
	            if(!StringUtils.isEmpty(phoneStr)&&!StringUtils.isEmpty(pd.getString("content"))){//需添加手机号格式校验
	                if(!Validator.isPhoneStr(phoneStr)){
	                    ar.setSuccess(false);
	                    ar.setMessage("手机号格式有误！"); 
	                    return ar;
	                }
	                
	                if(StringUtils.isEmpty(pd.get("id").toString())){
	                    pd.put("sms_status", "2");//发送中
	                    pd.put("flow_id", FlowNoGenerater.generateOrderNo());
	                }
	                pd.put("operator_accno", user.getUSERNAME());
	                pd.put("operator_name", user.getNAME());
	                boolean  smsResult = smsService.sendBatchSms(phoneStr,pd);
	                if(smsResult){
	                    ar.setSuccess(true);
	                    ar.setMessage("发送成功"); 
	                    return ar;
	                }else{
	                    ar.setSuccess(false);
	                    ar.setMessage("发送失败"); 
	                    return ar;
	                }
	            }else{
	                if(StringUtils.isEmpty(phoneStr)){
	                    ar.setSuccess(false);
	                    ar.setMessage("手机号不能为空！");
	                    return ar;
	                }else if(StringUtils.isEmpty(pd.getString("content"))){
	                    ar.setSuccess(false);
	                    ar.setMessage("短信内容不能为空！");
	                    return ar;
	                }
	            }
			}
			
		} catch (Exception e) {
			ar.setSuccess(false);
			ar.setMessage("系统异常");
			e.printStackTrace();
		}finally{
		    logAfter(logger);
		}
		return ar;
	}

	/**
	 * @describe:发送查询
	 * @author: zhangchunming
	 * @date: 2016年10月17日下午4:44:05
	 * @param page
	 * @return: ModelAndView
	 */
	@RequestMapping(value="/listPageSms")
	public ModelAndView listPageSms(Page page){
		try {
			PageData pd = new PageData();
			pd=this.getPageData();
			page.setPd(pd);
			List<PageData> smsList = smsService.listPageSms(page);
			mv.setViewName("business/sms/sms_list");
			mv.addObject("varList", smsList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	/**
	 * @describe:回收站
	 * @author: zhangchunming
	 * @date: 2016年10月17日下午4:43:52
	 * @param page
	 * @return: ModelAndView
	 */
	@RequestMapping(value="/listPageRecycle")
	public ModelAndView listPageRecycle(Page page){
	    try {
	        PageData pd = new PageData();
	        pd=this.getPageData();
	        pd.put("sms_status", "0");
	        page.setPd(pd);
	        List<PageData> smsList = smsService.listPageSms(page);
	        mv.setViewName("business/sms/recycle_list");
	        mv.addObject("varList", smsList);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return mv;
	}
	
	/*@RequestMapping(value="/toSingleSend",method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView toSingleSend(){
		try {
			mv.setViewName("business/sms/single_send");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}*/
	/**
	 * @describe:查询会员
	 * @author: zhangchunming
	 * @date: 2016年10月14日下午5:07:35
	 * @return: ModelAndView
	 */
	@RequestMapping(value="/toSingleSend")
    public ModelAndView toSingleSend(Page page){
	    logBefore(logger, "SmsController.listPageVip----查询会员列表");
        try {
            PageData pd = new PageData();
            pd = this.getPageData();
            if("1".equals(pd.getString("send_range"))){//全部用户
                pd.put("freeze_flag", "");
            }else if("2".equals(pd.getString("send_range"))){//普通用户
                pd.put("freeze_flag", "1");
            }else if("3".equals(pd.getString("send_range"))){//投资机构
                pd.put("freeze_flag", "0");
            }
            /*pd.put("send_type", "1");
            pd.put("send_range", "1");
            pd.put("interface_type", "1");*/
            page.setPd(pd);
            List<PageData> varList = smsService.listPageVip(page);
            mv.setViewName("business/sms/single_send");
            mv.addObject("varList", varList);
            mv.addObject("pd", pd);
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            logAfter(logger);
        }
        return mv;
    }
	/**
	 * @describe:查询短信详细/编辑重新发送
	 * @author: zhangchunming
	 * @date: 2016年10月17日下午4:54:19
	 * @param page
	 * @return: ModelAndView
	 */
	@RequestMapping(value="/toEditSmsSend")
	public ModelAndView toEditSmsSend(Page page){
	    logBefore(logger, "SmsController.toEditSmsSend----查询会员列表");
	    try {
	        PageData pd = new PageData();
	        pd = this.getPageData();
	        PageData sms = smsService.getOneSms(pd);
	        page.setPd(pd);
	        pd.put("id", sms.get("id"));
	        pd.put("title", sms.getString("title"));
	        pd.put("content", sms.getString("content"));
	        pd.put("phone", sms.getString("phone"));
	        pd.put("sms_type", sms.getString("sms_type"));
	        pd.put("sms_status", sms.getString("sms_status"));
	        pd.put("send_type", sms.getString("send_type"));
	        pd.put("send_range", sms.getString("send_range"));
	        pd.put("interface_type", sms.getString("interface_type"));
	        mv.setViewName("business/sms/single_send");
	        if(sms.getString("sms_status").equals("0")&&"2".equals(sms.getString("send_type"))){//发送失败且单个发送时显示会员列表
	            List<PageData> varList = smsService.listPageVip(page);
	            mv.addObject("varList", varList);
	        }
	        mv.addObject("pd", pd);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }finally{
	        logAfter(logger);
	    }
	    return mv;
	}
	/**
	 * @describe:回收站短信重新发送
	 * @author: zhangchunming
	 * @date: 2016年10月17日下午4:57:08
	 * @param page
	 * @return: ModelAndView
	 */
	@RequestMapping(value="/reSend")
    @ResponseBody
    public AjaxResponse reSend(Page page){
        logBefore(logger, "SmsController.reSend----重新发送短信");
        try {
            PageData pd = new PageData();
            pd = this.getPageData();
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();  
            Session session = currentUser.getSession();
            User user = (User)session.getAttribute(Const.SESSION_USER);
            
            PageData sms = smsService.getOneSms(pd);
            if("1".equals(sms.getString("send_type"))){//全部发送时，根据条件从库里查询手机号
                if("1".equals(sms.getString("send_range"))){//全部用户
                    sms.put("freeze_flag", "");
                }else if("2".equals(sms.getString("send_range"))){//普通会员
                    sms.put("freeze_flag", "1");
                }else if("3".equals(sms.getString("send_range"))){//投资机构
                    sms.put("freeze_flag", "0");
                }
                sms.put("operator_accno", user.getUSERNAME());
                sms.put("operator_name", user.getNAME());
                boolean smsResult = smsService.sendAllSms(sms);
                if(smsResult){
                    ar.setSuccess(true);
                    ar.setMessage("发送成功"); 
                    return ar;
                }else{
                    ar.setSuccess(false);
                    ar.setMessage("发送失败"); 
                    return ar;
                }
            }else{//单个发送
                boolean result = smsService.sendBatchSms(sms.getString("phone"),sms);
                if(result){
                    ar.setSuccess(true);
                    ar.setMessage("发送成功！");
                }else{
                    ar.setSuccess(false);
                    ar.setMessage("发送失败！");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            ar.setSuccess(false);
            ar.setMessage("发送失败！");
        }finally{
            logAfter(logger);
        }
        return ar;
    }
}
