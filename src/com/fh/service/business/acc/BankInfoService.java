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
		return (List<PageData>) dao.findForList("BankInfoMapper.findBankInfoListPage",page);
	}
	
	public void updateBankState(PageData pd) throws Exception{
		
		  dao.update("BankInfoMapper.updateBankStatus", pd);
		  dao.update("BankInfoMapper.updateBankStatusEx", pd);
	}
	
	
	public void addBankAccNo(PageData pd) throws Exception{
		
		
		 dao.save("BankInfoMapper.addBankaccno", pd);
	}
}
