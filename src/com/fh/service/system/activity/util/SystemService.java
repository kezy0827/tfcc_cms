package com.fh.service.system.activity.util;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.util.PageData;
/** 
 * 类名称：SystemService
 * 创建人：zhangchunming
 * 创建时间：2015年03月25日
 * @version
 */
@Service("systemservice")
public class SystemService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 获取省、市、列表
	*/
	public List<PageData> cityList(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SystemMapper.cityList", pd);
	}
}

