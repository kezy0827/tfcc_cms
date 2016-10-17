package com.fh.service.business.logmgr;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("interfaceLogService")
public class InterfaceLogService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	/**
	 * @describe:根据id查询转账日志
	 * @author: zhangchunming
	 * @date: 2016年10月13日上午10:15:41
	 * @param id
	 * @throws Exception
	 * @return: PageData
	 */
    public PageData selectById(Long id) throws Exception{
        return (PageData) dao.findForObject("InterfaceLogMapper.selectById", id);
    }
    /**
     * @describe:分页查询转账日志
     * @author: zhangchunming
     * @date: 2016年10月13日上午10:17:43
     * @param page
     * @throws Exception
     * @return: List<PageData>
     */
    public List<PageData> listPageLog(Page page) throws Exception{
        return (List<PageData>)dao.findForList("InterfaceLogMapper.listPageLog", page);
    }
    /**
     * @describe:导出报表
     * @author: zhangchunming
     * @date: 2016年10月13日上午10:18:03
     * @param pd
     * @throws Exception
     * @return: List<PageData>
     */
    public List<PageData> listAllLog(PageData pd) throws Exception{
        return (List<PageData>)dao.findForList("InterfaceLogMapper.listAllLog", pd);
    }
}
