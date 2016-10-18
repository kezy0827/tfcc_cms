package com.fh.controller.business;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.service.business.article.ArticleService;
import com.fh.util.PageData;


@Controller
@RequestMapping(value="/service")
public class ArticleController extends BaseController  {

	
	@Resource(name="articleService")
	private ArticleService articleService;
	
	
	@RequestMapping(value="/addarticleinfo",method=RequestMethod.POST)
	@ResponseBody
	private ModelAndView addArticleInfo(){
		
		try {
		    PageData pd = new PageData();
			pd=this.getPageData();
			articleService.addArticleInfo(pd);
			ar.setSuccess(true);
			ar.setMessage("保存文章信息成功");
		} catch (Exception e) {
			ar.setSuccess(false);
			ar.setMessage("保存文章信息失败");
			e.printStackTrace();
		}
		//return new ModelAndView("redirect:/service/getarticleinfo.do");
		return mv;
	}
  
}
