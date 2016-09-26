package com.fh.service.business.acc;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;



@Service("bankInfoService")
public class BankInfoService {

	
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public List<PageData> findBankInfoList(Page page) throws Exception{
		return (List<PageData>) dao.findForList("BankInfoMapper.findBankInfoList",page);
	}
	
	public boolean updateBankState(PageData pd) throws Exception{
		
		return (Boolean) dao.update("BankInfoMapper.updateBankStatus", pd);
	}
	
	
	public boolean addBankAccNo(PageData pd) throws Exception{
		
		
		return (Boolean) dao.save("BankInfoMapper.addBankaccno", pd);
	}
}
