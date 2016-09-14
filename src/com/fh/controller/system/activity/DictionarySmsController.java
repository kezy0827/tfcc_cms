package com.fh.controller.system.activity;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.entity.system.User;
import com.fh.service.system.activity.ActivityService;
import com.fh.service.system.activity.DictionarySmsService;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.ImageUtil;
import com.fh.util.ImgUtil;
import com.fh.util.PageData;

/** 
 * 类名称：DictionarySmsController
 * 创建人：LP
 * 创建时间：2015年03月23日
 * @version
 */
@Controller
@RequestMapping(value="/dictionarysms")
public class DictionarySmsController extends BaseController{
	@Resource(name="dictionarySmsService")
	private DictionarySmsService dictionarySmsService;
	
	@Resource(name="activityService")
	private ActivityService activityService;
	/**
	 * 列表
	 */
	@RequestMapping(value="/dlistAll")
	public ModelAndView listUsers(Page page) throws Exception{
		logBefore(logger, "短信列表Activity");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String activity_id = pd.getString("activity_id");
			pd.put("activity_id", activity_id);
			page.setPd(pd);
			List<PageData> list = dictionarySmsService.list(page);
			System.out.println("-----------------------------------------"+list.size());
			//调用权限
			this.getHC(); //================================================================================
			//调用权限
			mv.setViewName("business/sms/activity_sms_list");
			mv.addObject("varList", list);
			mv.addObject("activity_id", activity_id);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 保存
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(HttpServletRequest request,
			@RequestParam(value="ds_type",required=false) String ds_type,
			@RequestParam(value="ds_content",required=false) String ds_content,
			@RequestParam(value="activity_id",required=false) String activity_id 
	) throws Exception{
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);	
		mv.clear();
		pd = this.getPageData();
		PageData pd = new PageData();
		pd.put("activity_id", activity_id);
		PageData findById = activityService.findById(pd);
		pd.put("ds_type", ds_type);
		pd.put("ds_content", ds_content);
		pd.put("ds_obj", 1);//1:动a动 -1：场馆
	    pd.put("system_user_name", user.getNAME());
		pd.put("ds_create_datetime",DateUtil.getTime());//新增时间
		pd.put("activity_title",findById.get("a_title"));
		pd.put("activity_id",activity_id);
		pd.put("venue_public_account_nickname",findById.get("venue_public_account_nickname"));//
		pd.put("venue_public_account_id", findById.get("venue_public_account_id"));//
		dictionarySmsService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 去新增页面
	 */
	/*@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		mv.clear();
		pd = this.getPageData();
		try {
			String activity_id = pd.getString("activity_id");
			mv.setViewName("business/contestant/contestant_add");
			mv.addObject("activity_id", activity_id);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	*/
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		mv.clear();
		pd = this.getPageData();
		try {
			String activity_id = pd.getString("activity_id");
			mv.setViewName("business/sms/activity_sms_add");
			mv.addObject("activity_id", activity_id);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		mv.clear();
		try {
			pd = dictionarySmsService.findById(pd);
			mv.setViewName("business/sms/activity_sms_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	
	/**
	 * 修改
	 */
	/*@RequestMapping(value="/edit")
	public ModelAndView edit(
			HttpServletRequest request,
			@RequestParam(value="tp",required=false) MultipartFile tp,
			@RequestParam(value="id",required=false) String id,
			@RequestParam(value="tpz",required=false) String tpz,
			@RequestParam(value="stiename",required=false) String stiename,
			@RequestParam(value="sitecontent",required=false) String sitecontent,
			@RequestParam(value="type",required=false) String type,
			@RequestParam(value="sequence",required=false) String sequence,
			@RequestParam(value="status",required=false) String status,
			@RequestParam(value="tourl",required=false) String tourl
			) throws Exception{
		mv.clear();
		pd = this.getPageData();
		
		pd.put("id", id);
		pd.put("stiename", stiename);
		pd.put("sitecontent", sitecontent);
		pd.put("type", type);
		pd.put("status", status);
		pd.put("tourl", tourl);
		pd.put("sequence", "".equals(sequence)?0:sequence);
		pd.put("uptime", DateUtil.getTime());				//修改时间
		
		if(null == tpz){
			tpz = "";
		}
		
		//图片上传
				String pictureSaveFilePath = String.valueOf(Thread.currentThread().getContextClassLoader().getResource(""))+"../../";
				pictureSaveFilePath = pictureSaveFilePath.substring(6);		//去掉 'file:/'
				
				if (null != tp && !tp.isEmpty()) {
					try {
						String tpid = UuidUtil.get32UUID();
						
						// 扩展名格式：
						String extName = "";
						if (tp.getOriginalFilename().lastIndexOf(".") >= 0) {
							extName = tp.getOriginalFilename().substring(tp.getOriginalFilename().lastIndexOf("."));
						}
						
						this.copyFile(tp.getInputStream(), pictureSaveFilePath+"TP",tpid+extName).replaceAll("-", "");
						pd.put("stieurl", tpid+extName);
					} catch (IOException e) {
						logger.error(e.getMessage(), e);
					}
				}else{pd.put("stieurl", tpz);}
		
		
				linkService.edit(pd);
		
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	*//**
	 * 保存
	 */
	/*@RequestMapping(value="/save")
	public ModelAndView save(HttpServletRequest request,	
			@RequestParam(value="tp",required=false) MultipartFile tp,
			@RequestParam(value="activity_id",required=false) String activity_id,
			@RequestParam(value="ac_name",required=false) String ac_name,
			@RequestParam(value="ac_introduce",required=false) String ac_introduce,
			@RequestParam(value="ac_poll",required=false) String ac_poll,
			@RequestParam(value="ac_weight",required=false) String ac_weight
			) throws Exception{
		mv.clear();
		pd = this.getPageData();
		pd.put("activity_id", activity_id);
		pd.put("ac_name", ac_name);
		pd.put("ac_introduce", ac_introduce);
		pd.put("ac_poll", ac_poll);
		pd.put("ac_weight", ac_weight);
		pd.put("ac_create_datetime", DateUtil.getTime());				//新增时间
		
		pd.put("ac_original_img_width", ac_weight);
		pd.put("ac_original_img_height", ac_weight);
		pd.put("ac_original_img_size", ac_weight);
		//图片上传
				String pictureSaveFilePath = String.valueOf(Thread.currentThread().getContextClassLoader().getResource(""))+"../../";
				pictureSaveFilePath = pictureSaveFilePath.substring(6);		//去掉 'file:/'
				if (null != tp && !tp.isEmpty()) {
					try {
						String id = UuidUtil.get32UUID();
						// 扩展名格式：
						String extName = "";
						if (tp.getOriginalFilename().lastIndexOf(".") >= 0) {
							extName = tp.getOriginalFilename().substring(tp.getOriginalFilename().lastIndexOf("."));
						}
						this.copyFile(tp.getInputStream(), pictureSaveFilePath+"TP",id+extName).replaceAll("-", "");
						pd.put("ac_original_img_name", id+extName);
					} catch (IOException e) {
						logger.error(e.getMessage(), e);
					}
				}else{
					pd.put("ac_original_img_name", "");
				}
				contestantService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}*/
	/**
	 * 删除
	 *//*
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out)throws Exception{
		mv.clear();
		try{
			pd = this.getPageData();
			
			
			pd = linkService.findById(pd);						  							 	//通过ID获取数据
			String adurl = pd.getString("stieurl");
			
			//删除硬盘上的文件 start
			String xmpath = String.valueOf(Thread.currentThread().getContextClassLoader().getResource(""))+"../../";	//项目路径
			
			if(adurl != null && !adurl.equals("")){
				adurl = (xmpath.trim() + "TP/" + adurl.trim()).substring(6).trim();
				File f1 = new File(adurl.trim());
				if(f1.exists()){
					f1.delete();
				}else{
					System.out.println("===="+adurl+"不存在");
				}
			}
			
			
			linkService.delete(pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	//删除图片
	@RequestMapping(value="/deltp")
	public void deltp(PrintWriter out) {
		logBefore(logger, "删除图片");
		try{
			mv.clear();
			pd = this.getPageData();
			
			String tpurl = pd.getString("tpurl");													//图片路径
			if(tpurl != null){
				//删除硬盘上的文件 start
				String xmpath = String.valueOf(Thread.currentThread().getContextClassLoader().getResource(""))+"../../";	//项目路径
				tpurl = xmpath.trim() + "TP/" + tpurl.trim();
				tpurl = tpurl.substring(6);															//去掉 'file:/'
				File f = new File(tpurl.trim()); 
				if(f.exists()){
					f.delete();
				}else{
					System.out.println("===="+tpurl+"不存在");
				}
				//删除硬盘上的文件 end
				linkService.delTp(pd);														//删除数据中图片数据
			}	
				
				out.write("success");
				out.close();
		}catch(Exception e){
			logger.error(e.toString(), e);
		}
	}*/
	
	/**
	 * 写文件到当前目录的upload目录中
	 * 
	 * @param in
	 * @param fileName
	 * @throws IOException
	 */
	private String copyFile(InputStream in, String dir, String realName)
			throws IOException {
		File file = new File(dir, realName);
		if (!file.exists()) {
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			file.createNewFile();
		}
		FileUtils.copyInputStreamToFile(in, file);
		return realName;
	}
	
	
	/* ===============================权限================================== */
	public void getHC(){
		HttpSession session = this.getRequest().getSession();
		Map<String, Integer> map = (Map<String, Integer>)session.getAttribute("QX");
		mv.addObject("QX",map);	//按钮权限
		
		List<Menu> menuList = (List)session.getAttribute("menuList");
		mv.addObject("menuList", menuList);//菜单权限
	}
	/* ===============================权限================================== */
}

