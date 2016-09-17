package com.fh.service.business.trade;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.util.PageData;



@Service("tradeService")
public class TradeService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	
	public void editU(PageData pd)throws Exception{
		
		pd.put("groupcode", "REWARD_DEF");
		List<PageData>  tcodelist = (List<PageData>) dao.findForObject("SysGencodeMapper.find", pd);
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
		String operator ="sys";//后台登陆用户
		pd.put("subAccno", "010101");
		pd.put("bounsSource1", "15");
		pd.put("bounsSource2", "1501");
		pd.put("rsbns1", rsbns1);
		pd.put("rsbns2", rsbns2);
		pd.put("rsbns3", rsbns3);		
		pd.put("operator", operator);
		List<PageData>  tfriendlist = (List<PageData>) dao.findForObject("UserFriendshipMapper.find", pd);
		if(tfriendlist!=null &&tfriendlist.size()>0){	
			dao.save("AccDetailMapper.save", pd);		
		}

	}
	
	
	
	
}
