package com.fh.service.system.activity;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;

@Service("contestantService")
public class ContestantService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>) dao.findForList("ContestantMapper.datalistPage", page);
	}
	/*
	* 通过id获取选手数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ContestantMapper.findById", pd);
	}
	
	/*
	* 保存
	*/
	public void save(PageData pd)throws Exception{
		dao.save("ContestantMapper.save", pd);
	}
	
	/*
	* 更新
	*/
	public void update(PageData pd)throws Exception{
		dao.save("ContestantMapper.edit", pd);
	}
	/*
	* 删除
	*/
	public void deleteContestantById(PageData pd)throws Exception{
		dao.update("ContestantMapper.deleteContestantById", pd);
	}
	
	/*
	* 删除图片
	*/
	public void delTp(PageData pd)throws Exception{
		dao.update("LinkMapper.delTp", pd);
	}
	
	/*
	 *取出新增的选手
	 */
	public PageData getActivityContestantId()throws Exception{
		return (PageData)dao.findForObject("ContestantMapper.getActivityContestantId", null);
	}
}

