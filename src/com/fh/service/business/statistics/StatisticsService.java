package com.fh.service.business.statistics;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.util.DateUtil;
import com.fh.util.PageData;


@Service("statisticsService")
public class StatisticsService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	/**
	 * @describe:统计会员信息
	 * @author: zhangchunming
	 * @date: 2016年9月27日下午4:09:08
	 * @param page
	 * @throws Exception
	 * @return: List<PageData>
	 */
	public PageData getRegisterNum(PageData pd)throws Exception{
		return (PageData)dao.findForObject("StatisticsMapper.getRegisterNum", null);
	}
	/**
	 * @describe:购买SAN 统计
	 * @author: zhangchunming
	 * @date: 2016年9月27日下午4:14:54
	 * @param pd
	 * @throws Exception
	 * @return: PageData
	 */
	public PageData getBuySAN(PageData pd)throws Exception{
	    return (PageData)dao.findForObject("StatisticsMapper.getBuySAN", null);
	}
	/**
	 * @describe:统计转账SAN
	 * @author: zhangchunming
	 * @date: 2016年9月27日下午4:15:08
	 * @param pd
	 * @throws Exception
	 * @return: PageData
	 */
	public PageData getZZSAN(PageData pd)throws Exception{
	    return (PageData)dao.findForObject("StatisticsMapper.getZZSAN", null);
	}
	/**
	 * @describe:统计发放
	 * @author: zhangchunming
	 * @date: 2016年9月27日下午4:15:28
	 * @param pd
	 * @throws Exception
	 * @return: PageData
	 */
	public PageData getReward(PageData pd)throws Exception{
	    return (PageData)dao.findForObject("StatisticsMapper.getReward", null);
	}
	/**
	 * @describe:统计奖励
	 * @author: zhangchunming
	 * @date: 2016年9月28日下午8:34:13
	 * @param pd
	 * @throws Exception
	 * @return: PageData
	 */
	public PageData getBonuses(PageData pd)throws Exception{
	    return (PageData)dao.findForObject("StatisticsMapper.getBonuses", null);
	}
	/**
	 * @describe:SAN额度
	 * @author: zhangchunming
	 * @date: 2016年9月27日下午4:15:53
	 * @param pd
	 * @throws Exception
	 * @return: PageData
	 */
	public PageData getSysSAN(PageData pd)throws Exception{
	    return (PageData)dao.findForObject("StatisticsMapper.getSysSAN", null);
	}
	public static void main(String[] args) {
        System.out.println(DateUtil.getTime());
    }
}

