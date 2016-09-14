package com.fh.service.system.news;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 类名称：NewsService
 * 创建人：zhangchunming
 * 创建时间：2015年03月22日
 * @version
 */
@Service("newsService")
public class NewsService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("NewsMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("NewsMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("NewsMapper.edit", pd);
	}
	/*
	 * 修改置顶状态
	 */
	public void update_top(PageData pd)throws Exception{
		dao.update("NewsMapper.update_top", pd);
	}
	/*
	 * 修改删除标志位
	 */
	public void edit_isDelete(PageData pd)throws Exception{
		dao.update("NewsMapper.edit_isDelete", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("NewsMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("NewsMapper.listAll", pd);
	}
	/*
	 *取出新增的新闻news_id
	 */
	public PageData getNewsId(PageData pd)throws Exception{
		return (PageData)dao.findForObject("NewsMapper.getNewsId", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("NewsMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("NewsMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

