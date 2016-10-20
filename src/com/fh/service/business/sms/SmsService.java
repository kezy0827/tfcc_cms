package com.fh.service.business.sms;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.business.user.UserDetailService;
import com.fh.util.FlowNoGenerater;
import com.fh.util.PageData;
import com.fh.util.SmsSend;
import com.fh.util.Validator;

@Service("smsService")
public class SmsService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	@Resource
	private SmsService smsService;
	
	@Resource(name="userDetailService")
    private UserDetailService userDetailService;
	
	public boolean addSms(PageData pd) throws Exception{
	    return (Integer)dao.save("SmsMapper.insertSelective", pd)>0;
	}
	/**
	 * @describe:短信查询
	 * @author: zhangchunming
	 * @date: 2016年10月14日下午4:10:38
	 * @param page
	 * @throws Exception
	 * @return: List<PageData>
	 */
	public List<PageData> listPageSms(Page page) throws Exception{
	    return(List<PageData>)dao.findForList("SmsMapper.listPageSms", page);
	}
	/**
     * @describe:判断手机号是否加入
     * @author: zhengguodong
     * @date: 2016年10月12日下午4:08:50
     * @param phone
     * @throws Exception
     * @return: int
     */
	public int findsmsPhone(String phone) throws Exception{
		int findForObject = (Integer) dao.findForObject("SmsMapper.findBlackPhoneIsExist", phone);
		return findForObject;
	}
	/**
	 * @describe:修改发送短信状态
	 * @author: zhangchunming
	 * @date: 2016年10月14日下午5:00:54
	 * @param pd
	 * @throws Exception
	 * @return: void
	 */
	public void updateStatusByFlowId(PageData pd)throws Exception{
	     dao.update("SmsMapper.updateStatusByFlowId", pd);
	}
	/**
	 * @describe:根据id修改状态
	 * @author: zhangchunming
	 * @date: 2016年10月17日下午3:24:15
	 * @param pd
	 * @throws Exception
	 * @return: void
	 */
	public void updateStatusById(PageData pd)throws Exception{
	    dao.update("SmsMapper.updateStatusById", pd);
	}
	/**
	 * @describe:批量发送短信（新发短信先添加短信，后修改状态，再次发送短信的直接修改状态）
	 * @author: zhangchunming
	 * @date: 2016年10月14日下午4:46:57
	 * @param phoneStr
	 * @param pd
	 * @throws Exception
	 * @return: boolean
	 */
	public boolean sendBatchSms(String phoneStr,PageData pd) throws Exception{
	    boolean sendBool = false;
	    String[] phoneArr = null;
	    phoneArr = phoneStr.trim().split(",");
	    
	    if(StringUtils.isEmpty(pd.get("id").toString())){//id为空则为新发短信，否则为再次发送
	        smsService.addSms(pd);
        }
	    
        for(String phone:phoneArr){
            phone = phone.trim();
            if(Validator.isMobile(phone)){
                int num = smsService.findsmsPhone(phone);
                if(num==0){//判断是否在黑名单
                    //批量发送短信
                    String content = pd.getString("content");
                    content = content.substring(0, content.indexOf("【")+1)+phone+content.substring(content.indexOf("】"));
                    boolean result = SmsSend.sendSms(phone, content);//需添加发送日志
//                        boolean result = true;
                    if(result){
                        sendBool = true;
                    }
                }
            }
        }
        if(sendBool){//只要有一条发送成功，及成功
            if(StringUtils.isEmpty(pd.get("id").toString())){
                PageData smsData = new PageData();
                smsData.put("smsStatus", "1");//发送成功
                smsData.put("flowId", pd.get("flowId"));
                updateStatusByFlowId(smsData);
            }else{
                pd.put("smsStatus", "1");//发送成功
                updateStatusById(pd);//根据流水号修改状态
            }
            
        }else{
            if(StringUtils.isEmpty(pd.get("id").toString())){
                PageData smsData = new PageData();
                smsData.put("smsStatus", "0");//发送失败
                smsData.put("flowId", pd.get("flowId"));
                updateStatusByFlowId(smsData);
            }else{
                pd.put("smsStatus", "0");//发送失败
                updateStatusById(pd);//根据id修改状态
            }
        }
        return sendBool;
	}
	/**
	 * @describe:查询会员列表
	 * @author: zhangchunming
	 * @date: 2016年10月14日下午5:13:33
	 * @param pd
	 * @throws Exception
	 * @return: List<PageData>
	 */
	public List<PageData> listPageVip(Page page)throws Exception{
	    return (List<PageData>)dao.findForList("SmsMapper.listPageVip", page);
	}
	/**
	 * @describe:查询一条短信
	 * @author: zhangchunming
	 * @date: 2016年10月17日下午2:21:25
	 * @param page
	 * @throws Exception
	 * @return: PageData
	 */
	public PageData getOneSms(PageData pd)throws Exception{
	    return (PageData)dao.findForObject("SmsMapper.getOneSms", pd);
	}
	/**
	 * @describe:发送失败，继续发送,发送成功更新状态
	 * @author: zhangchunming
	 * @date: 2016年10月17日下午3:18:32
	 * @param phoneStr
	 * @param pd
	 * @throws Exception
	 * @return: boolean
	 */
	public boolean updateBatchSms(String phoneStr,PageData pd) throws Exception{
        boolean sendBool = false;
        String[] phoneArr = null;
        phoneArr = phoneStr.trim().split(",");
        for(String phone:phoneArr){
            phone = phone.trim();
            if(Validator.isMobile(phone)){
                int num = smsService.findsmsPhone(phone);
                if(num==0){//判断是否在黑名单
                    //批量发送短信
                    String content = pd.getString("content");
                    content = content.substring(0, content.indexOf("【")+1)+phone+content.substring(content.indexOf("】"));
                    boolean result = SmsSend.sendSms(phone, content);//需添加发送日志
//                        boolean result = true;
                    if(result){
                        sendBool = true;
                    }
                }
            }
        }
        if(sendBool){//只要有一条发送成功，及成功
            PageData smsData = new PageData();
            smsData.put("smsStatus", "1");//发送成功
            smsData.put("content", pd.getString("content"));
            smsData.put("phone", pd.getString("phone"));
            smsData.put("operator_accno", pd.getString("operator_accno"));
            smsData.put("operator_name", pd.getString("operator_name"));
            smsData.put("id", pd.get("id").toString());
            updateStatusById(smsData);
        }
        return sendBool;
    }
	
	/**
	 * @describe:全部发送
	 * @author: zhangchunming
	 * @date: 2016年10月20日下午4:55:57
	 * @param phoneStr
	 * @param pd
	 * @throws Exception
	 * @return: boolean
	 */
	public boolean sendAllSms(PageData pd) throws Exception{
        boolean sendBool = false;
        
        if(StringUtils.isEmpty(pd.get("id").toString())){//id为空则为新发短信，否则为再次发送
            smsService.addSms(pd);
        }
        List<PageData> phoneList = userDetailService.findAllPhoneByCondition(pd);
        for(PageData phoneData:phoneList){
            String phone = phoneData.getString("phone");
            int num = smsService.findsmsPhone(phone);
            if(num==0){//判断是否在黑名单
                //批量发送短信
                String content = pd.getString("content");
                content = content.substring(0, content.indexOf("【")+1)+phone+content.substring(content.indexOf("】"));
                boolean result = SmsSend.sendSms(phone, content);//需添加发送日志
                if(result){
                    sendBool = true;
                }
            }
        }
        if(sendBool){//只要有一条发送成功，及成功
            if(StringUtils.isEmpty(pd.get("id").toString())){
                PageData smsData = new PageData();
                smsData.put("smsStatus", "1");//发送成功
                smsData.put("flowId", pd.get("flowId"));
                updateStatusByFlowId(smsData);
            }else{
                pd.put("smsStatus", "1");//发送成功
                updateStatusById(pd);//根据流水号修改状态
            }
            
        }else{
            if(StringUtils.isEmpty(pd.get("id").toString())){
                PageData smsData = new PageData();
                smsData.put("smsStatus", "0");//发送失败
                smsData.put("flowId", pd.get("flowId"));
                updateStatusByFlowId(smsData);
            }else{
                pd.put("smsStatus", "0");//发送失败
                updateStatusById(pd);//根据id修改状态
            }
        }
        return sendBool;
    }
}


