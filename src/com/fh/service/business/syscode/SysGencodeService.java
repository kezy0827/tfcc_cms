package com.fh.service.business.syscode;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.util.PageData;


@Service("sysGencodeService")
public class SysGencodeService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	/**
	 * @describe:查询系统常量code
	 * @author: zhangchunming
	 * @date: 2016年9月19日上午9:31:12
	 * @param pd
	 * @throws Exception
	 * @return: List<PageData>
	 */
	public List<PageData> list(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("SysGencodeMapper.find", pd);
	}
}

