package com.fh.service.business.user;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.DateUtil;
import com.fh.util.PageData;


@Service("userDetailService")
public class UserDetailService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	public PageData findByUserCode(PageData pd)throws Exception{
	    return (PageData)dao.findForList("UserDetailMapper.findByUserCode", pd);
	}
	
	/*
    *用户列表(用户购买标识)
    */
    public List<PageData> listPdPageUserbuy(Page page)throws Exception{
        return (List<PageData>) dao.findForList("UserDetailMapper.userbuylistPage", page);
    }
    
    /**
     * @describe:更新订单状态
     * @author: kezhiyi
     * @date: 2016年9月25日
     * @param pd
     * @throws Exception
     * @return: void
     */
    public void updateBuyStatus(PageData pd)throws Exception{
        if(pd.getString("status").equals("1")){//审核通过,添加支付时间
            pd.put("pay_time", DateUtil.getTime());
            pd.put("caldate", DateUtil.getTime());
            pd.put("cntflag", "1");
        }
            pd.put("operator", "sys");
        dao.update("UserDetailMapper.updatebuyflag", pd);
           
    }
    
    public PageData getUserDetail(Page page)throws Exception{
        return (PageData)dao.findForList("UserDetailMapper.getUserDetail", page);
    }
}

