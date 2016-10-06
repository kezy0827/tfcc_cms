package com.fh.service.business.article;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.util.PageData;



@Service("articleService")
public class ArticleService {
	
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	//添加文章信息
	public boolean addArticleInfo(PageData pd) throws Exception{
		dao.save("ArticleInfoMapper.addArticleInfo", pd);
		return true;
		}
	
	
}
