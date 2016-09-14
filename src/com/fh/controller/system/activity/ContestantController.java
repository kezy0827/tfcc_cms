package com.fh.controller.system.activity;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.entity.system.User;
import com.fh.service.system.activity.ContestantService;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.ImageUtil;
import com.fh.util.ImgUtil;
import com.fh.util.PageData;

/** 
 * 类名称：ContestantController
 * 创建人：liupeng
 * 创建时间：2015年03月23日
 * @version
 */
@Controller
@RequestMapping(value="/contestant")
public class ContestantController extends BaseController{
	@Resource(name="contestantService")
	private ContestantService contestantService;
	
	@RequestMapping(value="/upload")
	public void upload(HttpServletRequest request,@RequestParam(value="tps",required=false) MultipartFile activityContestantImgFile, HttpServletResponse response) throws Exception{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Content-Type", "text/html; charset=UTF-8");
		mv.clear();
		pd = this.getPageData();
		String pictureSaveFilePath = Const.RESOURCES_LOCAL+Const.CONTESTANT_ORIGINAL_IMG;
		Map<String,String> map = new HashMap<String, String>();
		map.put(".jpg",".jpg");
		map.put(".png",".png");
		map.put(".jpeg",".jpeg");
		map.put(".png",".png");
		map.put(".gif",".gif");
		map.put(".bmp",".bmp");
		if (null != activityContestantImgFile && !activityContestantImgFile.isEmpty()) {
			try {
				PrintWriter out = response.getWriter();
				long currentTimeMillis = System.currentTimeMillis();
				String extName = "";
				// 扩展名格式：
				if (activityContestantImgFile.getOriginalFilename().lastIndexOf(".") >= 0) {
					extName = activityContestantImgFile.getOriginalFilename().substring(activityContestantImgFile.getOriginalFilename().lastIndexOf("."));
				}
				System.out.println("----------extName:"+extName);
				if(!map.containsKey(extName)){
					out.print("<script>parent.window.alert(\"请上传jpg、png、jpeg、png、gif、bmp格式的图片！\");</script>");
					out.close();
					return;
				}
				String imgName = currentTimeMillis+extName;
				pd.put("stieurl",imgName); 
				this.copyFile(activityContestantImgFile.getInputStream(), pictureSaveFilePath,imgName).replaceAll("-", "");
				mv.addObject("msg","success");
				String http_img = Const.RESOURCES_BASE+ Const.CONTESTANT_ORIGINAL_IMG+ imgName;
				System.out.println("-------http_img--------"+http_img);
				Map<String, Long> imgInfo = ImgUtil.getImgInfo(pictureSaveFilePath+imgName);
				Long w = imgInfo.get("w");
				Long h = imgInfo.get("h");
				Long s = imgInfo.get("s");
				if(w<640||h<400){
					out.print("<script>parent.window.alert(\"图片尺寸不符合要求，请上传尺寸640*400或者以上的图！\");</script>");
					out.close();
					return;
				}
				System.out.println(""+s+"---"+h+"---"+w);
				out.print("<script>parent.document.getElementById('original_img_http').src=\""+ http_img+ "\";parent.$('.original_img_name').val('"+imgName+"'); parent.$('.original_img_info').val('"+imgInfo+"');</script>");
				//out.print("<script>parent.document.getElementById('element_id').src=\""+ http_img+ "\";parent.$('.activityimgname').val('"+imgName+"'); parent.window.excutejcrop();parent.$('#coords input').val(''); </script>");
				out.close();
			} catch (IOException e) {
				logger.error(e.getMessage(), e);//原图名称
				mv.addObject("msg","error");
			}
		}else{
			mv.addObject("msg","error");
		}
	}
	
	
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/clistAll")
	public ModelAndView listUsers(Page page) throws Exception{
		logBefore(logger, "线上活动列表Activity");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String activity_id = pd.getString("activity_id");
			String ac_name = pd.getString("ac_name");
			if(ac_name!=null&&!"".equals(ac_name)){
				ac_name = ac_name.trim();
				pd.put("ac_name", ac_name);
			}
			pd.put("activity_id", activity_id);
			page.setPd(pd);
			List<PageData> contestantList = contestantService.list(page);
			
			//线上活动参赛选手图小图262*164
			String activity_contestant_id_width262_height164 = Const.RESOURCES_BASE+Const.ACTIVITY_CONTESTANT_ID_WIDTH262_HEIGHT164;
			for (PageData pageData : contestantList) {
				pageData.put("activity_contestant_img_http",activity_contestant_id_width262_height164+"a_c_"+pageData.get("activity_contestant_id")+"_262_164.png" );
			}
			//调用权限
			this.getHC(); //================================================================================
			//调用权限
			mv.setViewName("business/contestant/contestant_list");
			mv.addObject("varList", contestantList);
			mv.addObject("activity_id", activity_id);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 去新增页面
	 */
/*	@RequestMapping(value="/goAdd")
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
	}*/
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		mv.clear();
		pd = this.getPageData();
		try {
			String activity_id = pd.getString("activity_id");
			mv.setViewName("business/contestant/contestant_add");
			//mv.addObject("activity_id", activity_id);
			mv.addObject("pd", pd);
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
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			this.getHC(); //调用权限
			pd = contestantService.findById(pd);	//根据ID读取
			Map<String, String> imgInfo = new HashMap<String,String>();
			imgInfo.put("w", String.valueOf(pd.get("ac_original_img_width")));
			imgInfo.put("h", String.valueOf(pd.get("ac_original_img_height")));
			imgInfo.put("s", String.valueOf(pd.get("ac_original_img_size")));
			pd.put("imgInfo", imgInfo);
			String a_original_img_name = String.valueOf(pd.get("ac_original_img_name"));
			String http_img = Const.RESOURCES_BASE+ Const.CONTESTANT_ORIGINAL_IMG+a_original_img_name;
			pd.put("original_img_http", http_img);
			mv.setViewName("business/contestant/contestant_add");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	/**
	 * 删除菜单
	 * @param menuId
	 * @param out
	 */
	@RequestMapping(value="/delete")
	public void delete(@RequestParam String activity_contestant_id,PrintWriter out)throws Exception{
		try{
			PageData pd = new PageData();
			pd.put("activity_contestant_id", activity_contestant_id);
			contestantService.deleteContestantById(pd);
			out.write("success");
			out.flush();
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
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
	*/
	/**
	 * 保存
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(HttpServletRequest request,	
			@RequestParam(value="activity_id",required=false) String activity_id,
			@RequestParam(value="activity_contestant_id",required=false) String activity_contestant_id,
			@RequestParam(value="ac_name",required=false) String ac_name,
			@RequestParam(value="ac_introduce",required=false) String ac_introduce,
			@RequestParam(value="ac_poll",required=false) String ac_poll,
			@RequestParam(value="ac_weight",required=false) String ac_weight,
			@RequestParam(value="original_img_info",required=false) String original_img_info,
			@RequestParam(value="original_img_name",required=false) String original_img_name,
			@RequestParam(value="ac_cut_img_x1",required=false) String ac_cut_img_x1,
			@RequestParam(value="ac_cut_img_y1",required=false) String ac_cut_img_y1,
			@RequestParam(value="ac_cut_img_x2",required=false) String ac_cut_img_x2,
			@RequestParam(value="ac_cut_img_y2",required=false) String ac_cut_img_y2,
			@RequestParam(value="ac_cut_img_width",required=false) String ac_cut_img_width,
			@RequestParam(value="ac_cut_img_height",required=false) String ac_cut_img_height
			) throws Exception{
		JSONObject imgInfoMap = JSONObject.fromObject(original_img_info);
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);	
		ModelAndView mv = this.getModelAndView();
		mv.clear();
		pd = this.getPageData();
		pd.put("activity_id", activity_id);
		pd.put("ac_name", ac_name);
		pd.put("ac_introduce", ac_introduce);
		pd.put("ac_poll", ac_poll);
		pd.put("ac_weight", ac_weight);
		pd.put("ac_create_datetime", DateUtil.getTime());				//新增时间
		pd.put("ac_original_img_name", original_img_name);
		pd.put("ac_original_img_width", imgInfoMap.getInt("w"));
		pd.put("ac_original_img_height", imgInfoMap.getInt("h"));
		pd.put("ac_original_img_size", imgInfoMap.getInt("s"));
		
		if("".equals(ac_cut_img_x1)){
			ac_cut_img_x1 = "0";
			ac_cut_img_y1 = "0";
			ac_cut_img_x2 = "640";
			ac_cut_img_y2 = "400";
			ac_cut_img_width = "640";
			ac_cut_img_height = "400";
		}
		pd.put("ac_cut_img_x1", ac_cut_img_x1);
		pd.put("ac_cut_img_y1", ac_cut_img_y1);
		pd.put("ac_cut_img_x2", ac_cut_img_x2);
		pd.put("ac_cut_img_y2", ac_cut_img_y2);
		pd.put("ac_cut_img_width", ac_cut_img_width);
		pd.put("ac_cut_img_height", ac_cut_img_height);
		pd.put("ac_operating_user", user.getUSERNAME());
		if(!"".equals(activity_contestant_id)){
			pd.put("activity_contestant_id", activity_contestant_id);
			contestantService.update(pd);
		}else{
			contestantService.save(pd);
			PageData activityContestantId = contestantService.getActivityContestantId();
			activity_contestant_id = String.valueOf(activityContestantId.get("activity_contestant_id"));
		}
		//线上活动参赛选手原图
		String original_img_name_local = Const.RESOURCES_LOCAL+Const.CONTESTANT_ORIGINAL_IMG+original_img_name;
		//线上活动参赛选手图小图262*164
		String activity_contestant_id_width262_height164 = Const.RESOURCES_LOCAL+Const.ACTIVITY_CONTESTANT_ID_WIDTH262_HEIGHT164+"a_c_"+activity_contestant_id+"_262_164.png";int width262 = 262,height164=164;
		//线上活动参赛选手图大图640*400
		String activity_contestant_id_width640_height400 = Const.RESOURCES_LOCAL+Const.ACTIVITY_CONTESTANT_ID_WIDTH640_HEIGHT400+"a_c_"+activity_contestant_id+"_640_400.png";int widthc640 = 640,heightc400=400;
		
	
		//原图裁剪，裁剪成活动列表图
		ImgUtil.cut(Integer.parseInt(ac_cut_img_x1), Integer.parseInt(ac_cut_img_y1), widthc640, heightc400,original_img_name_local,activity_contestant_id_width640_height400);
		
		//Thread.sleep(3000);
		//压缩收藏图
		ImageUtil.resize(activity_contestant_id_width640_height400, activity_contestant_id_width262_height164, width262, height164,1f);
		
		//返回选手列表
		/*pd.clear();
		pd.put("activity_id", activity_id);
		Page page = new Page();
		page.setPd(pd);
		List<PageData> contestantList = contestantService.list(page);
		
		//线上活动参赛选手图小图262*164
		String contestant_id_width262_height164 = Const.RESOURCES_BASE+Const.ACTIVITY_CONTESTANT_ID_WIDTH262_HEIGHT164;
		for (PageData pageData : contestantList) {
			pageData.put("activity_contestant_img_http",contestant_id_width262_height164+"a_c_"+pageData.get("activity_contestant_id")+"_262_164.png" );
		}
		//调用权限
		this.getHC(); //================================================================================
		//调用权限
		mv.setViewName("business/contestant/contestant_list");
		mv.addObject("varList", contestantList);
		mv.addObject("activity_id", activity_id);
		mv.addObject("pd", pd);*/
		mv.addObject("activity_id",activity_id);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	/**
	 * 保存
	 */
	@RequestMapping(value="/update")
	public ModelAndView update(HttpServletRequest request,	
			@RequestParam(value="activity_contestant_id",required=false) String activity_contestant_id,
			@RequestParam(value="ac_name",required=false) String ac_name,
			@RequestParam(value="ac_introduce",required=false) String ac_introduce,
			@RequestParam(value="ac_poll",required=false) String ac_poll,
			@RequestParam(value="ac_weight",required=false) String ac_weight,
			@RequestParam(value="original_img_info",required=false) String original_img_info,
			@RequestParam(value="original_img_name",required=false) String original_img_name,
			@RequestParam(value="ac_clip_img_left_up",required=false) String ac_clip_img_left_up,
			@RequestParam(value="ac_clip_img_left_down",required=false) String ac_clip_img_left_down,
			@RequestParam(value="ac_clip_img_right_up",required=false) String ac_clip_img_right_up,
			@RequestParam(value="ac_clip_img_right_down",required=false) String ac_clip_img_right_down,
			@RequestParam(value="ac_clip_img_width",required=false) String ac_clip_img_width,
			@RequestParam(value="ac_clip_img_height",required=false) String ac_clip_img_height
			) throws Exception{
		JSONObject imgInfoMap = JSONObject.fromObject(original_img_info);
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);	
		PageData pd = new PageData();
		pd.put("id", activity_contestant_id);
		PageData activity_contestant_pd = contestantService.findById(pd);
		mv.clear();
		
		pd = this.getPageData();
		pd.put("activity_contestant_id", activity_contestant_id);
		pd.put("ac_name", ac_name);
		pd.put("ac_introduce", ac_introduce);
		pd.put("ac_poll", ac_poll);
		pd.put("ac_weight", ac_weight);
		pd.put("ac_original_img_name", original_img_name);
		
		int w = Integer.parseInt(String.valueOf(activity_contestant_pd.get("ac_original_img_width")));
		int h = Integer.parseInt(String.valueOf(activity_contestant_pd.get("ac_original_img_height")));
		int s = Integer.parseInt(String.valueOf(activity_contestant_pd.get("ac_original_img_size")));
		if(!imgInfoMap.isEmpty()){
			w = imgInfoMap.getInt("w");
			h = imgInfoMap.getInt("h");
			s = imgInfoMap.getInt("s");
		}
		pd.put("ac_original_img_width", w);
		pd.put("ac_original_img_height",h);
		pd.put("ac_original_img_size", s);
		
		pd.put("ac_clip_img_left_up", ac_clip_img_left_up);
		pd.put("ac_clip_img_left_down", ac_clip_img_left_down);
		pd.put("ac_clip_img_right_up", ac_clip_img_right_up);
		pd.put("ac_clip_img_right_down", ac_clip_img_right_down);
		pd.put("ac_clip_img_width", ac_clip_img_width);
		pd.put("ac_clip_img_height", ac_clip_img_height);
		pd.put("ac_operating_user", user.getUSERNAME());
		contestantService.update(pd);
		String db_a_original_img_name = String.valueOf(activity_contestant_pd.get("ac_original_img_name"));
		if(!db_a_original_img_name.equals(original_img_name)){
			//线上活动参赛选手图小图262*164
			String original_img_name_local = Const.RESOURCES_LOCAL+Const.CONTESTANT_ORIGINAL_IMG+original_img_name;
			//线上活动参赛选手图小图262*164
			String activity_contestant_id_width262_height164 = Const.RESOURCES_LOCAL+Const.ACTIVITY_CONTESTANT_ID_WIDTH262_HEIGHT164+"a_c_"+activity_contestant_id+"_262_164.png";int width262 = 262,height164=164;
			//线上活动参赛选手图大图640*400
			String activity_contestant_id_width640_height400 = Const.RESOURCES_LOCAL+Const.ACTIVITY_CONTESTANT_ID_WIDTH640_HEIGHT400+"a_c_"+activity_contestant_id+"_640_400.png";int widthc640 = 640,heightc400=400;
		
			//原图裁剪，裁剪成活动列表图
			ImgUtil.cut(Integer.parseInt(ac_clip_img_left_up), Integer.parseInt(ac_clip_img_right_up), widthc640, heightc400,original_img_name_local,activity_contestant_id_width640_height400);
			
			Thread.sleep(3000);
			//压缩收藏图
			ImageUtil.resize(activity_contestant_id_width640_height400, activity_contestant_id_width262_height164, width262, height164,1f);
		}
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
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

