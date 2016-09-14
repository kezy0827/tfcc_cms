package com.fh.service.system.activity;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
/** 
 * 类名称：ActivityVenueService
 * 创建人：zhangchunming
 * 创建时间：2015年03月27日
 * @version
 */
@Service("activityVenueListService")
public class ActivityVenueService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	
	public List<PageData> list(Page page)throws Exception{ 
		return (List<PageData>)dao.findForList("VenueActivityVenueMapper.venueactivityvenuelist", page);
	}
	public PageData getOneVenue(PageData pd)throws Exception{
		return (PageData)dao.findForObject("VenueActivityVenueMapper.getOneVenue", pd);
	}
	public void delVenue(PageData pd)throws Exception{
		dao.delete("VenueActivityVenueMapper.delVenue", pd);
	}
	public void save(PageData pd)throws Exception{
		dao.save("VenueActivityVenueMapper.save", pd);
	}
	public void update(PageData pd)throws Exception{
		dao.update("VenueActivityVenueMapper.edit", pd);
	}
}

