package com.fh.controller.app;
/*package com.fh.controller.app.demo; 

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jalan.dao.DaoSupport;
import com.jalan.util.PageData;

@Service("appProductService")
public class AppKuService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	// 产品图片地址
	public List<PageData> getPicturePath(PageData pd) throws Exception{
		List<PageData> pictureList = (List<PageData>) dao.findForList("AppProductMapper.picture", pd);
		
		return pictureList;
	}
	
	// 产品详情
	public List<PageData> getProductInfo(PageData pd) throws Exception {
		List<PageData> product = (List<PageData>) dao.findForList("AppProductMapper.product", pd);
		
		return product;
	}
	
	//公共分类下产品列表-固定排名列表
	public List<PageData> getFixedProduct(PageData pd) throws Exception{
		List<PageData> fixedList = (List<PageData>) dao.findForList("AppProductMapper.fixedProduct", pd);
		
		return fixedList;
	}
	
	//公共分类下产品列表
	public List<PageData> selByProduct(PageData pd) throws Exception{
		List<PageData> productList = (List<PageData>) dao.findForList("AppProductMapper.selByProduct", pd);
		
		return productList;
	}
	
	//公共分类下供应商数
		public PageData selBySupplier(PageData pd) throws Exception{
			PageData supplierData = (PageData) dao.findForObject("AppProductMapper.selBySupplier", pd);
			
			return supplierData;
		}
	
	//公共分类下省份列表
	public List<PageData> selByCity(PageData pd) throws Exception{
		List<PageData> cityList = (List<PageData>) dao.findForList("AppProductMapper.selByCity", pd);
		
		return cityList;
	}
	
	//公共分类下按省份筛选产品
	public List<PageData> selCityProduct(PageData pd) throws Exception{
		List<PageData> productList = (List<PageData>) dao.findForList("AppProductMapper.selCityProduct", pd);
				
		return productList;
	}
}
*/