package com.fh.service.system.activity;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 类名称：ActivityService
 * 创建人：zhangchunming
 * 创建时间：2015年03月25日
 * @version
 */
@Service("activityService")
public class ActivityService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ActivityMapper.datalistPage", page);
	}
	/*
	*线下活动列表
	*/
	public List<PageData> offlinelist(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ActivityMapper.offlinePage", page);
	}
	
	/*
	* 保存线上活动
	*/
	public void save(PageData pd)throws Exception{
		dao.save("ActivityMapper.save", pd);
	}
	/*
	 * 保存线下活动
	 */
	public void offline_save(PageData pd)throws Exception{
		dao.save("ActivityMapper.offline_save", pd);
	}
	
	/*
	* 编辑线上活动
	*/
	public void update(PageData pd)throws Exception{
		dao.save("ActivityMapper.edit", pd);
	}
	/*
	 * 编辑线上活动
	 */
	public void update_alert_html(PageData pd)throws Exception{
		dao.save("ActivityMapper.update_alert_html", pd);
	}
	/*
	 * 编辑线下活动
	 */
	public void offline_edit(PageData pd)throws Exception{
		dao.update("ActivityMapper.offline_edit", pd);
	}
	/*
	 *取出新增的活动
	 */
	public PageData getActivityId(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ActivityMapper.getActivityId", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ActivityMapper.findById", pd);
	}
	public void deleteActivityById(String activity_id) throws Exception {
		dao.save("ActivityMapper.deleteActivityById", activity_id);
		
	}
}

