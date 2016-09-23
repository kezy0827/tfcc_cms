package com.fh.service.business.acc;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.util.PageData;

@Service("accService")
public class AccService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;
    
	/**
	 * @describe:更新账户信息
	 * @author: zhangchunming
	 * @date: 2016年9月24日上午2:19:26
	 * @param pd
	 * @return: boolean
	 */
	public boolean updateAcc(PageData pd)throws Exception{
	    return Integer.parseInt(dao.update("AccMapper.updateAmnt", pd).toString())>0;
	}
}
