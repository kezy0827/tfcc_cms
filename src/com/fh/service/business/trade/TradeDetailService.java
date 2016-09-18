package com.fh.service.business.trade;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("tradeDetailService")
public class TradeDetailService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("TradeDetailMapper.datalistPage", page);
	}
	public void edit(PageData pd)throws Exception{
        dao.update("TradeDetailMapper.updateByIdSelective", pd);
        if(pd.getString("status").equals("1")){
            PageData trade = getTradeById(pd);
            if(trade!=null){
                pd = new PageData();
                pd.put("userCode", trade.get("user_code"));
                rewardByBuy(pd);
            }
            
        }
    }
	public PageData getTradeById(PageData pd)throws Exception{
	    return (PageData)dao.findForObject("TradeDetailMapper.selectById", pd);
	}
	public void updateStatus(PageData pd)throws Exception{
	    dao.update("TradeDetailMapper.updateStatus", pd);
	}
	public void del(PageData pd)throws Exception{
	    dao.update("TradeDetailMapper.deleteById", pd);
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
        
        pd.put("groupcode", "REWARD_DEF");
        List<PageData>  tcodelist = (List<PageData>) dao.findForList("SysGencodeMapper.find", pd);
        String rSL1="1";
        String rSL2="1";
        String rSL3="1";    
        BigDecimal rsbns1=new BigDecimal(1);  
        BigDecimal rsbns2=new BigDecimal(1);  
        BigDecimal rsbns3=new BigDecimal(1);  
        
         //购买奖励参数
       if(tcodelist!=null&&tcodelist.size()>0){
           for(PageData tcode:tcodelist){
               if(tcode.get("codeName").toString().equals("SL1")){
                   rSL1 = tcode.getString("codeValue").toString();
               }
               if(tcode.get("codeName").toString().equals("SL2")){
                   rSL2 = tcode.getString("codeValue").toString();
               }
               if(tcode.get("codeName").toString().equals("SL3")){
                   rSL3 = tcode.getString("codeValue").toString();
               }           
           }       
       }
        try{
              rsbns1=new BigDecimal(rSL1);  
              rsbns2=new BigDecimal(rSL2);  
              rsbns3=new BigDecimal(rSL3);              
        }catch(Exception e){
              System.out.println("translation fail,reason is "+e.getMessage());
        }
        List<PageData>  tfriendlist = (List<PageData>) dao.findForList("UserFriendshipMapper.find", pd);
        if(tfriendlist!=null &&tfriendlist.size()>0){  
            String operator ="sys";//后台登陆用户
            pd.put("subAccno", "010101");
            pd.put("bounsSource1", "15");
            pd.put("bounsSource2", "1501");
            pd.put("rsbns1", rsbns1);
            pd.put("rsbns2", rsbns2);
            pd.put("rsbns3", rsbns3);       
            pd.put("operator", operator);
            dao.save("AccDetailMapper.save", pd);       
        }

    }
}

