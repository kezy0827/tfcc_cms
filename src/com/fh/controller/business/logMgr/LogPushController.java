package com.fh.controller.business.logMgr;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.service.business.logmgr.LogPushService;
import com.fh.util.PageData;

/**
 * 类名称：LogPushController 创建人：LZH 创建时间：2015年04月08日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/logpush")
public class LogPushController extends BaseController {
	@Resource(name = "logPushService")
	private LogPushService logPushService;

	/**
	 * 列表
	 */
	@RequestMapping(value = "/logPushListAll")
	public ModelAndView listLogPush(Page page) throws Exception {
		logBefore(logger, "推送日志列表");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			page.setPd(pd);
			List<PageData> list = logPushService.list(page);
			System.out.println("-----------------------------------------"
					+ list.size());
			// 调用权限
			this.getHC(); // ================================================================================
			// 调用权限
			mv.setViewName("business/log/log_push_list");
			mv.addObject("varList", list);
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 测试事务
	 */
	@RequestMapping(value = "/deleteAAA")
	public ModelAndView deleteAAA(Page page) {
		logBefore(logger, "测试事务");
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			page.setPd(pd);
			// logPushService.save(pd);
			// 调用权限
			this.getHC(); // ================================================================================
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		try {
			logPushService.update(pd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	/* ===============================权限================================== */
	public void getHC() {
		HttpSession session = this.getRequest().getSession();
		Map<String, Integer> map = (Map<String, Integer>) session
				.getAttribute("QX");
		mv.addObject("QX", map); // 按钮权限

		List<Menu> menuList = (List) session.getAttribute("menuList");
		mv.addObject("menuList", menuList);// 菜单权限
	}
	/* ===============================权限================================== */
}
