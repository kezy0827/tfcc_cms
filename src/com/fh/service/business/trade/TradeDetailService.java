package com.fh.service.business.trade;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.business.user.UserDetailService;
import com.fh.util.PageData;


@Service("tradeDetailService")
public class TradeDetailService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	@Resource(name = "userDetailService")
	private UserDetailService userDetailService;
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
	/**
	 * @describe:审核编辑
	 * @author: zhangchunming
	 * @date: 2016年9月19日上午9:53:50
	 * @param pd
	 * @throws Exception
	 * @return: void
	 */
	public void updateTradeDetail(PageData pd)throws Exception{
        dao.update("TradeDetailMapper.updateByIdSelective", pd);
        if(pd.getString("status").equals("1")){
            PageData trade = getTradeById(pd);
            if(trade!=null){
                pd = new PageData();
                pd.put("user_code", trade.get("user_code"));
                /*PageData userDetail = userDetailService.findByUserCode(pd);
                if(userDetail!=null){
                    pd.put("phone", userDetail.getString("phone"));
                }*/
                rewardByBuy(pd);
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
	    dao.update("TradeDetailMapper.updateStatus", pd);
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
            String operator ="sys";//后台登陆用户
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
            dao.save("AccDetailMapper.save", pd); 
            //通过触发器汇总奖励
            /*List<PageData> levReward = (List<PageData>)dao.findForList("AccDetailMapper.selectLevReward", pd);
            pd.put("levReward", levReward);
            dao.batchUpdate("AccMapper.update", levReward);*/
        }

    }
	public void updateTriger()throws Exception{
	    dao.update("AccDetailMapper.testTriger",new PageData());
	}
}

