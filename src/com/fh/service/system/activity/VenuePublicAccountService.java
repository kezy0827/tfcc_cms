package com.fh.service.system.activity;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 类名称：VenuePublicAccountService
 * 创建人：zhangchunming
 * 创建时间：2015年04月01日
 * @version
 */
@Service("accountService")
public class VenuePublicAccountService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	/*
	*列表
	*/
	public List<PageData> list(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("VenuePublicAccoutMapper.accountList", pd);
	}
	public PageData oneAccount(PageData pd)throws Exception{
		return (PageData)dao.findForObject("VenuePublicAccoutMapper.oneAccount", pd);
	}
}

