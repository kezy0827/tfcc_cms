package com.fh.service.business.logmgr;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("logPushService")
public class LogPushService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("LogPushMapper.datalistPage", page);
	}
	
	
	public void save(PageData pd)throws Exception{
		dao.save("LogPushMapper.save", pd);
		throw  new Exception("1111111");


	}


	public void update(PageData pd)throws Exception{
		// TODO Auto-generated method stub
		dao.save("LogPushMapper.edit", pd);
	}
}
