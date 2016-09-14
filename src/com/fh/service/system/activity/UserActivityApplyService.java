package com.fh.service.system.activity;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
/** 
 * 类名称：UserActivityApplyService
 * 创建人：zhangchunming
 * 创建时间：2015年03月29日
 * @version
 */
@Service("userActivityApplyService")
public class UserActivityApplyService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("UserActivityApplyMapper.userActivityApplyList", page);
	}
	public void updateStatus(PageData pd)throws Exception{
		dao.update("UserActivityApplyMapper.updateStatus", pd);
	}
}

