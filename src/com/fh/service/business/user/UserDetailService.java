package com.fh.service.business.user;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.util.PageData;


@Service("userDetailService")
public class UserDetailService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	public PageData findByUserCode(PageData pd)throws Exception{
	    return (PageData)dao.findForList("UserDetailMapper.findByUserCode", pd);
	}
}

