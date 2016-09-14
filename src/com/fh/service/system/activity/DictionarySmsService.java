package com.fh.service.system.activity;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;

@Service("dictionarySmsService")
public class DictionarySmsService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/*public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DictionarySmsMapper.findById", pd);
	}*/
	
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("DictionarySmsMapper.dictionarylist", page);
	}
	/*
	* 保存
	*/
	public void save(PageData pd)throws Exception{
		dao.save("DictionarySmsMapper.save", pd);
	}
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DictionarySmsMapper.findById", pd);
	}
}

