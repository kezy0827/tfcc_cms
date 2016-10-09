package com.fh.service.business.trade;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.business.acc.AccService;
import com.fh.service.business.sms.SmsService;
import com.fh.service.business.user.UserDetailService;
import com.fh.util.DateUtil;
import com.fh.util.PageData;
import com.fh.util.SmsSend;


@Service("tradeDetailService")
public class TradeDetailService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	@Resource(name = "userDetailService")
	private UserDetailService userDetailService;
	@Resource(name = "accService")
	private AccService accService;
	@Resource(name = "smsService")
	private SmsService smsService;
	
	/**
	 * @describe:分页查询交易订单
	 * @author: zhangchunming
	 * @date: 2016年9月19日上午9:53:25
	 * @param page
	 * @throws Exception
	 * @return: List<PageData>
	 */
	public List<PageData> listPage(Page page)throws Exception{
		return (List<PageData>)dao.findForList("TradeDetailMapper.datalistPage", page);
	}
	 /*
	    *用户列表(全部)
	    */
	public List<PageData> listAllTrade(PageData pd)throws Exception{
	  return (List<PageData>) dao.findForList("TradeDetailMapper.listAllTrade", pd);
	}
	/**
	 * @describe:审核编辑
	 * @author: zhangchunming
	 * @date: 2016年9月19日上午9:53:50
	 * @param pd
	 * @throws Exception
	 * @return: void
	 */
	public void updateTradeDetail(PageData pd)throws Exception{
	    
	    if(pd.getString("status").equals("1")){//审核通过,添加支付时间
	        pd.put("pay_time", DateUtil.getTime());
	        pd.put("caldate", DateUtil.getTime());
	        pd.put("cntflag", "1");
	    }
	    pd.put("operator", "sys");
        dao.update("TradeDetailMapper.updateByIdSelective", pd);
        if(pd.getString("status").equals("1")){//审核通过
            PageData trade = getTradeById(pd);
            PageData accPd = new PageData();
            accPd.put("user_code", trade.get("user_code").toString());
            accPd.put("avb_amnt", trade.get("txnum").toString());//购买数量
            accPd.put("total_amnt", trade.get("txnum").toString());
            accPd.put("syscode", "tfcc");
            boolean result = accService.updateAcc(accPd);
            if(result&&trade!=null){
                pd = new PageData();
                pd.put("id", trade.get("id"));
                pd.put("user_code", trade.get("user_code"));
                /*PageData userDetail = userDetailService.findByUserCode(pd);
                if(userDetail!=null){
                    pd.put("phone", userDetail.getString("phone"));
                }*/
                
                rewardByBuy(pd);
                //审核通过给用户发送短信
                pd = new PageData();
                pd.put("user_code",trade.get("user_code").toString());
                PageData userDetail = userDetailService.findByUserCode(pd);
                if(userDetail!=null&&userDetail.get("phone")!=null&&!"".equals(userDetail.get("phone").toString())){
                    String phone = userDetail.get("phone").toString();
                    int num = smsService.findsmsPhone(phone);
                    if (num==0) {
                    	 String content = "尊敬的【"+phone+"】会员您好,您提交的订单号【"+trade.get("order_no").toString()+"】已审核通过，请登录网站查收！";
                         SmsSend.sendSms(phone, content);
					}else {
						System.out.println("此人已进入短信黑名单");
					}
                   
                }
            }
        }
    }
	/**
	 * @describe:通过主键查询交易订单
	 * @author: zhangchunming
	 * @date: 2016年9月19日上午9:54:10
	 * @param pd
	 * @throws Exception
	 * @return: PageData
	 */
	public PageData getTradeById(PageData pd)throws Exception{
	    return (PageData)dao.findForObject("TradeDetailMapper.selectById", pd);
	}
	public PageData selectBuyTimesByUserCode(PageData pd)throws Exception{
	    return (PageData)dao.findForObject("TradeDetailMapper.selectBuyTimesByUserCode", pd);
	}
	/**
	 * @describe:更新订单状态
	 * @author: zhangchunming
	 * @date: 2016年9月19日上午9:54:41
	 * @param pd
	 * @throws Exception
	 * @return: void
	 */
	public void updateStatus(PageData pd)throws Exception{
	    if(pd.getString("status").equals("1")){//审核通过,添加支付时间
            pd.put("pay_time", DateUtil.getTime());
            pd.put("caldate", DateUtil.getTime());
            pd.put("cntflag", "1");
        }
        pd.put("operator", "sys");
        dao.update("TradeDetailMapper.updateByIdSelective", pd);
        if(pd.getString("status").equals("1")){//审核通过
            PageData trade = getTradeById(pd);
            PageData accPd = new PageData();
            accPd.put("user_code", trade.get("user_code").toString());
            accPd.put("avb_amnt", trade.get("txnum").toString());//购买数量
            accPd.put("total_amnt", trade.get("txnum").toString());
            accPd.put("syscode", "tfcc");
           
            boolean result = accService.updateAcc(accPd);
            System.out.println("***************begin result "+result +",trade is "+trade);
            if(result&&trade!=null){
            	 System.out.println("***************begin rewardByBuy");
                pd = new PageData();
                pd.put("user_code", trade.get("user_code"));
                pd.put("id", trade.get("id"));
                /*PageData userDetail = userDetailService.findByUserCode(pd);
                if(userDetail!=null){
                    pd.put("phone", userDetail.getString("phone"));
                }*/
                rewardByBuy(pd);
                pd = new PageData();
                pd.put("user_code",trade.get("user_code").toString());
                PageData userDetail = userDetailService.findByUserCode(pd);
                if(userDetail!=null&&userDetail.get("phone")!=null&&!"".equals(userDetail.get("phone").toString())){
                    String phone = userDetail.get("phone").toString();
                    int num = smsService.findsmsPhone(phone);
                    if (num==0) {
                    	String content = "尊敬的会员【"+phone+"】您好,您提交的订单号【"+trade.get("order_no").toString()+"】已审核通过，请到'我的账户'中查看。";
                        SmsSend.sendSms(phone, content);
					}else {
						System.out.println("此人已进入短信黑名单");
					}
                    
                }
            }
            
        }
	   /* dao.update("TradeDetailMapper.updateStatus", pd);
	    if(pd.getString("status").equals("1")){
            PageData trade = getTradeById(pd);
            if(trade!=null){
                pd = new PageData();
                pd.put("user_code", trade.get("user_code"));
                pd.put("id", trade.get("id"));
                PageData userDetail = userDetailService.findByUserCode(pd);
                if(userDetail!=null){
                    pd.put("phone", userDetail.getString("phone"));
                }
                rewardByBuy(pd);
            }
            
        }*/
	}
	/**
	 * @describe:根据id删除交易订单
	 * @author: zhangchunming
	 * @date: 2016年9月19日上午9:55:27
	 * @param pd
	 * @throws Exception
	 * @return: void
	 */
	public void deleteById(PageData pd)throws Exception{
	    dao.update("TradeDetailMapper.updateIsShow", pd);
	}
	/**
	 * @describe:更新显示标志
	 * @author: zhangchunming
	 * @date: 2016年9月19日上午10:04:29
	 * @param pd
	 * @throws Exception
	 * @return: void
	 */
	public void updateIsShow(PageData pd)throws Exception{
	    dao.update("TradeDetailMapper.updateIsShow", pd);
	}
	/**
	 * @describe:购买奖励计算
	 * @author: zhangchunming
	 * @date: 2016年9月18日下午3:12:46
	 * @param pd
	 * @throws Exception
	 * @return: void
	 */
	public void rewardByBuy(PageData pd)throws Exception{
        
        List<PageData>  tfriendlist = (List<PageData>) dao.findForList("UserFriendshipMapper.find", pd);
        if(tfriendlist!=null &&tfriendlist.size()>0){//判断是否拥有上级会员，有计算上级会员奖励，否则不计算  
            //查询奖励规则
            pd.put("groupcode", "REWARD_DEF");
            List<PageData>  tcodelist = (List<PageData>) dao.findForList("SysGencodeMapper.find", pd);
            //推介购买奖励参数
            String tjgm1_temp="";
            String tjgm2_temp="";
            String tjgm3_temp=""; 
            String nedleva = "";
            String nedlevb = "";
            String nedlevc = "";
            BigDecimal tjgm1=new BigDecimal(1);  
            BigDecimal tjgm2=new BigDecimal(1);  
            BigDecimal tjgm3=new BigDecimal(1); 
            
           //购买奖励参数
           if(tcodelist!=null&&tcodelist.size()>0){
               for(PageData tcode:tcodelist){
                   if(tcode.get("codeName").toString().equals("TJGM1")){
                       tjgm1_temp = tcode.getString("codeValue").toString();
                   }
                   if(tcode.get("codeName").toString().equals("TJGM2")){
                       tjgm2_temp = tcode.getString("codeValue").toString();
                   }
                   if(tcode.get("codeName").toString().equals("TJGM3")){
                       tjgm3_temp = tcode.getString("codeValue").toString();
                   }           
                   if(tcode.get("codeName").toString().equals("NEDLEVA")){
                       nedleva = tcode.getString("codeValue").toString();
                   }           
                   if(tcode.get("codeName").toString().equals("NEDLEVB")){
                       nedlevb = tcode.getString("codeValue").toString();
                   }           
                   if(tcode.get("codeName").toString().equals("NEDLEVC")){
                       nedlevc = tcode.getString("codeValue").toString();
                   }           
               }       
           }
            try{
                tjgm1=new BigDecimal(tjgm1_temp);  
                tjgm2=new BigDecimal(tjgm2_temp);  
                tjgm3=new BigDecimal(tjgm3_temp);              
            }catch(Exception e){
                  System.out.println("BigDecimal convert fail,reason is "+e.getMessage());
            }
            System.out.println("************1111111 "+nedleva);
            String operator ="sys";//后台登陆用户
            System.out.println("tjgm1"+tjgm1);
            pd.put("sub_accno", "010101");
            pd.put("bouns_source1", "15");
            pd.put("bouns_source2", "1501");
            pd.put("tjgm1", tjgm1);
            pd.put("tjgm2", tjgm2);
            pd.put("tjgm3", tjgm3);       
            pd.put("nedleva", nedleva);       
            pd.put("nedlevb", nedlevb);       
            pd.put("nedlevc", nedlevc);     
            pd.put("operator", operator);
            dao.save("AccDetailMapper.update", pd); 
            //通过触发器汇总奖励
            /*List<PageData> levReward = (List<PageData>)dao.findForList("AccDetailMapper.selectLevReward", pd);
            pd.put("levReward", levReward);
            dao.batchUpdate("AccMapper.update", levReward);*/
        }

    }
	public void updateTriger()throws Exception{
	    dao.update("AccDetailMapper.testTriger",new PageData());
	}
	public static void main(String[] args) {
        System.out.println(DateUtil.getTime());
    }
}

