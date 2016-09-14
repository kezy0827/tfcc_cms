package com.fh.service.business.logmgr;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("logSmsService")
public class LogSmsService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("LogSmsMapper.datalistPage", page);
	}
}

