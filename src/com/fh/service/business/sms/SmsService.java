package com.fh.service.business.sms;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;

@Service("smsService")
public class SmsService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public boolean addSms(PageData pd) throws Exception{
		dao.save("SmsMapper.addSms", pd);
		return true;
	}

	public List<PageData> findSendSmsList(Page page) throws Exception{
		 List<PageData> list = (List<PageData>) dao.findForList("SmsMapper.findSendSmsListPage", page);
		return list;
	}
	
	public int findsmsPhone(String phone) throws Exception{
		int findForObject = (Integer) dao.findForObject("SmsMapper.findBlackPhoneIsExist", phone);
		return findForObject;
	}
	
}


