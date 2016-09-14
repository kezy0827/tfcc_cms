package com.fh.controller.system.activity;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.entity.system.User;
import com.fh.service.system.activity.ActivityService;
import com.fh.service.system.activity.VenuePublicAccountService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.ImageUtil;
import com.fh.util.ImgUtil;
import com.fh.util.PageData;
import com.fh.util.StaticUtil;
/** 
 * 类名称：ActivityController
 * 创建人：zhangchunming 
 * 创建时间：2015-03-17
 */
@Controller
@RequestMapping(value="/activity")
public class ActivityController extends BaseController {
	
	@Resource(name="activityService")
	private ActivityService activityService;
	
	@Resource(name="accountService")
	private VenuePublicAccountService accountService;
	/**
	 * 线上活动列表
	 */
	@RequestMapping(value="/onlinelist")
	public ModelAndView onlinelist(Page page){
		logBefore(logger, "线上活动列表Activity");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String a_title = pd.getString("a_title");
			System.out.println("liupeng>>"+a_title);
			if(a_title!=null&&!"".equals(a_title)){
				a_title = a_title.trim();
				pd.put("a_title", a_title);
			}
			pd.put("a_type", 1);
			page.setPd(pd);
			List<PageData> activityList = activityService.list(page);
			//活动收藏200*125
			String collect_activity_width_height = Const.RESOURCES_BASE+Const.COLLECT_ACTIVITY_WIDTH_HEIGHT;
			for (PageData pageData : activityList) {
				pageData.put("collect_activity_width_height",collect_activity_width_height+"collect_activityid"+pageData.get("activity_id")+"_width200_height125.png");
			}
			
			this.getHC(); //调用权限
			mv.setViewName("business/activity/online_activity_list");
			mv.addObject("varList", activityList);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 新增线上活动
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "新增线上活动Activity");
		ModelAndView mv = this.getModelAndView();
		try{
			this.getHC(); //调用权限
			mv.setViewName("business/activity/online_activity_add");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去编辑页啦");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			this.getHC(); //调用权限
			pd = activityService.findById(pd);	//根据ID读取
		    int activity_id = Integer.parseInt(String.valueOf(pd.get("activity_id")));
		    String a_original_img_name = String.valueOf(pd.get("a_original_img_name"));
			String activity_id_width_height = Const.RESOURCES_BASE+Const.ACTIVITY_ORIGINAL_IMG+a_original_img_name;int width640 = 640,height400=400;
			//线上活动详情225*360
			String activity_id_width225_height360 = Const.RESOURCES_BASE+Const.ACTIVITY_ID_WIDTH225_HEIGHT360+ "activity_id_"+activity_id+"_225_360.png";int width225 = 225,height360=360;
			String a_apply_start_datetime = String.valueOf(pd.get("a_apply_start_datetime"));
			String a_apply_end_datetime = String.valueOf(pd.get("a_apply_end_datetime"));
			pd.put("activity_id_width225_height360", activity_id_width225_height360);
			pd.put("activity_id_width_height", activity_id_width_height);
			System.out.println("------------activity_id_width_height------------"+activity_id_width_height);
			String[] split = a_apply_start_datetime.substring(0, 10).split("-");
			String[] split1 = a_apply_end_datetime.substring(0, 10).split("-");
			String a = split[0];
			pd.put("date_picker",split[1]+"/"+split[2]+"/"+split[0]+" - "+split1[1]+"/"+split1[2]+"/"+split1[0]);
			Map<String, String> imgInfo = new HashMap<String,String>();
			imgInfo.put("w", String.valueOf(pd.get("a_original_img_width")));
			imgInfo.put("h", String.valueOf(pd.get("a_original_img_height")));
			imgInfo.put("s", String.valueOf(pd.get("a_original_img_size")));
			pd.put("imgInfo", imgInfo);
			mv.addObject("pd", pd);
			mv.setViewName("business/activity/online_activity_add");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	@RequestMapping(value="/offline_goEdit")
	public ModelAndView offline_goEdit(){
		logBefore(logger, "去编辑页啦");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			this.getHC(); //调用权限
			pd = activityService.findById(pd);	//根据ID读取
			Map<String, Long> imgInfo = new HashMap();
			imgInfo.put("w", Long.valueOf(String.valueOf(pd.get("a_original_img_width"))));
			imgInfo.put("h", Long.valueOf(String.valueOf(pd.get("a_original_img_height"))));
			imgInfo.put("s", Long.valueOf(String.valueOf(pd.get("a_original_img_size"))));
			pd.put("imgInfo", imgInfo);
		    //int activity_id = Integer.parseInt(String.valueOf(pd.get("activity_id")));
		    String a_original_img_name = String.valueOf(pd.get("a_original_img_name"));
		    String http_img = Const.RESOURCES_BASE+Const.ACTIVITY_ORIGINAL_IMG+a_original_img_name;
		    pd.put("http_img", http_img);
			mv.addObject("pd", pd);
			//查询公众号列表
			List<PageData> accountList = accountService.list(pd);
			mv.addObject("varList", accountList);
			mv.setViewName("business/activity/offline_activity_add");
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
			@RequestParam(value="activity_id",required=false) String activity_id,
			@RequestParam(value="a_title",required=false) String a_title,
			@RequestParam(value="a_introduce",required=false) String a_introduce,
			@RequestParam(value="a_rule",required=false) String a_rule,
			@RequestParam(value="a_carousel",required=false) int a_carousel,
			@RequestParam(value="date-range-picker",required=false) String date_range_picker,
			@RequestParam(value="a_notice",required=false) String a_notice,
			@RequestParam(value="editorContent",required=false) String editorContent,
			@RequestParam(value="a_original_img_name",required=false) String a_original_img_name,
			@RequestParam(value="a_cut_img_x1",required=false) String a_cut_img_x1,
			@RequestParam(value="a_cut_img_y1",required=false) String a_cut_img_y1,
			@RequestParam(value="a_cut_img_x2",required=false) String a_cut_img_x2,
			@RequestParam(value="a_cut_img_y2",required=false) String a_cut_img_y2,
			@RequestParam(value="imgInfo",required=false) String imgInfo,
			@RequestParam(value="a_cut_img_width",required=false) String a_cut_img_width,
			@RequestParam(value="a_cut_img_height",required=false) String a_cut_img_height,
			@RequestParam(value="activityinfoimgname",required=false) String activityinfoimgname
	) throws Exception{
		JSONObject imgInfoMap = JSONObject.fromObject(imgInfo);
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);	
		mv.clear();
		pd = this.getPageData();
		pd.put("a_title", a_title);
		pd.put("a_introduce", a_introduce);
		pd.put("a_rule", a_rule);
		pd.put("a_notice", a_notice);
		System.out.println(date_range_picker+"-----------");
		String[] applyDatetime = date_range_picker.split(" - ");
		String[] start = applyDatetime[0].split("/");
		String[] end = applyDatetime[1].split("/");
		String a  =  start[2]+"-"+start[0]+"-"+start[1]+" 00:00:00" ;
	    pd.put("a_apply_start_datetime",start[2]+"-"+start[0]+"-"+start[1]+" 00:00:01" );//03/23/2015
		pd.put("a_apply_end_datetime", end[2]+"-"+end[0]+"-"+end[1]+" 23:59:59" );
		pd.put("a_carousel", a_carousel);
		pd.put("a_html", editorContent);
		pd.put("a_create_datetime",DateUtil.getTime());//新增时间
		pd.put("a_type",1);//活动类型 1：线上投票 -1：线下活动
		pd.put("a_ishtml_isapp",1);//1：原生 -1:html
		pd.put("a_ispay",-1);//是否需要在线支付  1：需要 -1 不需要
		pd.put("a_original_img_name",a_original_img_name);
		pd.put("a_original_img_width",imgInfoMap.getInt("w"));
		pd.put("a_original_img_height",imgInfoMap.getInt("h"));
		pd.put("a_original_img_size",imgInfoMap.getInt("s"));
		pd.put("a_operating_obj",1);
		pd.put("a_operating_user",user.getUSERNAME());
		pd.put("a_activity_venue_name", "场馆名称（举办活动）");//场馆名称（举办活动）
		if("".equals(a_cut_img_x1)){
			a_cut_img_x1 = "0";
			a_cut_img_y1 = "0";
			a_cut_img_x2 = "640";
			a_cut_img_y2 = "400";
			a_cut_img_width = "640";
			a_cut_img_height = "400";
		}else{
			if(a_cut_img_x2.contains(".")){
				a_cut_img_x2 = a_cut_img_x2.substring(0,a_cut_img_x2.lastIndexOf("."));
			}
			if(a_cut_img_y2.contains(".")){
				a_cut_img_y2 = a_cut_img_y2.substring(0,a_cut_img_y2.lastIndexOf("."));
			}
			if(a_cut_img_width.contains(".")){
				a_cut_img_width = a_cut_img_width.substring(0,a_cut_img_width.lastIndexOf("."));
			}
			if(a_cut_img_height.contains(".")){
				a_cut_img_height = a_cut_img_height.substring(0,a_cut_img_height.lastIndexOf("."));
			}
		}
		pd.put("a_cut_img_x1", a_cut_img_x1);
		pd.put("a_cut_img_y1", a_cut_img_y1);
		pd.put("a_cut_img_x2", a_cut_img_x2);
		pd.put("a_cut_img_y2",a_cut_img_y2);
		pd.put("a_cut_img_width", a_cut_img_width);
		pd.put("a_cut_img_height",a_cut_img_height);
		if(!"".equals(activity_id)){
			pd.put("activity_id",activity_id);
			activityService.update(pd);
		}else{
			long currentTimeMillis = System.currentTimeMillis();
			pd.put("a_currentTimeMillis", currentTimeMillis);
			activityService.save(pd);
			//获取活动的activity_id
			PageData activity_id_pd = activityService.getActivityId(pd);
			activity_id = String.valueOf(activity_id_pd.get("activity_id"));
		}
		
		//图片路径
		String pictureSaveFilePath = Const.RESOURCES_LOCAL+Const.ACTIVITY_ORIGINAL_IMG+a_original_img_name;
		
		//活动轮播、非轮播、列表路径640*400
		String activity_id_width_height = Const.RESOURCES_LOCAL+Const.ACTIVITY_ID_WIDTH_HEIGHT+"activity_"+activity_id+"_640_400.png";int width640 = 640,height400=400;
		

		/*//线上活动参赛选手图小图262*164
		String activity_contestant_id_width262_height164 = Const.RESOURCES_LOCAL+Const.ACTIVITY_CONTESTANT_ID_WIDTH262_HEIGHT164;int width262 = 262,height164=164;
		//线上活动参赛选手图大图640*400
		String activity_contestant_id_width640_height400 = Const.RESOURCES_LOCAL+Const.ACTIVITY_CONTESTANT_ID_WIDTH640_HEIGHT400;int widthc640 = 640,heightc400=400;*/
		

		//线上活动详情225*360
		String activity_id_width225_height360 = Const.RESOURCES_LOCAL+Const.ACTIVITY_ID_WIDTH225_HEIGHT360+ "activity_id_"+activity_id+"_225_360.png";int width225 = 225,height360=360;
		
		//活动收藏200*125
		String collect_activity_width_height = Const.RESOURCES_LOCAL+Const.COLLECT_ACTIVITY_WIDTH_HEIGHT+"collect_activityid"+activity_id+"_width200_height125.png";int width200 = 200,height125=125;
		
		//原图裁剪，裁剪成活动列表图
		ImgUtil.cut(Integer.parseInt(a_cut_img_x1), Integer.parseInt(a_cut_img_y1), width640, height400,pictureSaveFilePath,activity_id_width_height);
		
		//Thread.sleep(3000);
		//压缩收藏图
		ImageUtil.resize(activity_id_width_height, collect_activity_width_height, width200, height125,1f);
		if(!"".equals(activityinfoimgname)){
			//活动详情图重命名
			File file=new File(Const.RESOURCES_LOCAL+Const.ACTIVITY_ID_WIDTH225_HEIGHT360+activityinfoimgname); 
			System.out.println("活动详情图--->>>重命名前的路径"+Const.RESOURCES_LOCAL+Const.ACTIVITY_ID_WIDTH225_HEIGHT360+activityinfoimgname);
			if(file.exists()){
				file.renameTo(new File(activity_id_width225_height360));
				System.out.println("活动详情图--->>>重命名后的路径"+activity_id_width225_height360);
			}
		}
		//生成静态页
		String resources8383 = Const.RESOURCES_LOCAL;
		String resources_base = Const.RESOURCES_BASE;
		String share_activity = Const.SHARE_ACTIVITY;
		String template_activityshare = Const.TEMPLATE_ACTIVITYSHARE;
		//String htmlContent = editorContent.replace("<img", "<img style=\"width:100%;\"");
		Map<String, String> info = new HashMap<String, String>();
		if(a_title.length()>15){
			a_title = a_title.substring(0,15)+"...";
		}
		info.put("#title#", a_title);
		info.put("#content#",a_introduce);
		info.put("#activityimg#",Const.RESOURCES_BASE+Const.ACTIVITY_ID_WIDTH_HEIGHT+"activity_"+activity_id+"_640_400.png");
		
		System.out.println(resources_base+template_activityshare+"tow:"+resources8383+share_activity+"s_a_i"+activity_id+".html"+"tow:info"+info);
		StaticUtil.jsp2sta(resources_base+template_activityshare,resources8383+share_activity,"s_a_i"+activity_id+".html", info);
		
		//返回线上活动列表图
		Page page = new Page();
		pd.clear();
		mv.clear();
		pd.put("a_type", 1);
		page.setPd(pd);
		List<PageData> activityList = activityService.list(page);
		//活动收藏200*125
		String collectPicture = Const.RESOURCES_BASE+Const.COLLECT_ACTIVITY_WIDTH_HEIGHT;
		for (PageData pageData : activityList) {
			pageData.put("collect_activity_width_height",collectPicture+"collect_activityid"+pageData.get("activity_id")+"_width200_height125.png");
		}
		this.getHC(); //调用权限
		mv.setViewName("business/activity/online_activity_list");
		mv.addObject("varList", activityList);
		return mv;
	}
	/**
	 * 更新
	 */
	@RequestMapping(value="/update")
	public ModelAndView update(HttpServletRequest request,
			@RequestParam(value="activity_id",required=false) String activity_id,
			@RequestParam(value="a_title",required=false) String a_title,
			@RequestParam(value="a_introduce",required=false) String a_introduce,
			@RequestParam(value="a_rule",required=false) String a_rule,
			@RequestParam(value="a_carousel",required=false) int a_carousel,
			@RequestParam(value="date-range-picker",required=false) String date_range_picker,
			@RequestParam(value="a_notice",required=false) String a_notice,
			@RequestParam(value="editorContent",required=false) String editorContent,
			@RequestParam(value="a_original_img_name",required=false) String a_original_img_name,
			@RequestParam(value="a_cut_img_x1",required=false) String a_cut_img_x1,
			@RequestParam(value="a_cut_img_y1",required=false) String a_cut_img_y1,
			@RequestParam(value="a_cut_img_x2",required=false) String a_cut_img_x2,
			@RequestParam(value="a_cut_img_y2",required=false) String a_cut_img_y2,
			@RequestParam(value="imgInfo",required=false) String imgInfo,
			@RequestParam(value="a_cut_img_width",required=false) String a_cut_img_width,
			@RequestParam(value="a_cut_img_height",required=false) String a_cut_img_height,
			@RequestParam(value="activityinfoimgname",required=false) String activityinfoimgname
	) throws Exception{
		JSONObject imgInfoMap = JSONObject.fromObject(imgInfo);
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		
		User user = (User) session.getAttribute(Const.SESSION_USER);	
		pd.put("activity_id", activity_id);
		PageData activity_id_pd = activityService.findById(pd);
		mv.clear();
		
		a_original_img_name = a_original_img_name.trim();
		pd = this.getPageData();
		pd.put("a_title", a_title);
		pd.put("a_introduce", a_introduce);
		pd.put("a_rule", a_rule);
		pd.put("a_notice", a_notice);
		String[] applyDatetime = date_range_picker.split(" - ");
		String[] start = applyDatetime[0].split("/");
		String[] end = applyDatetime[1].split("/");
		String a  =  start[2]+"-"+start[0]+"-"+start[1]+" 00:00:00" ;
	    pd.put("a_apply_start_datetime",start[2].trim()+"-"+start[0].trim()+"-"+start[1].trim()+" 00:00:01" );//03/23/2015
		pd.put("a_apply_end_datetime", end[2].trim()+"-"+end[0].trim()+"-"+end[1].trim()+" 23:59:59" );
		pd.put("a_carousel", a_carousel);
		pd.put("a_html", editorContent);
		pd.put("a_original_img_name",a_original_img_name);
		int w = Integer.parseInt(String.valueOf(activity_id_pd.get("a_original_img_width")));
		int h = Integer.parseInt(String.valueOf(activity_id_pd.get("a_original_img_height")));
		int s = Integer.parseInt(String.valueOf(activity_id_pd.get("a_original_img_size")));
		if(!imgInfoMap.isEmpty()){
			w = imgInfoMap.getInt("w");
			h = imgInfoMap.getInt("h");
			s = imgInfoMap.getInt("s");
		}
		pd.put("a_original_img_width",w);
		pd.put("a_original_img_height",h);
		pd.put("a_original_img_size",s);
		pd.put("a_operating_user",user.getUSERNAME());
		pd.put("a_cut_img_x1", a_cut_img_x1);
		pd.put("a_cut_img_y1", a_cut_img_y1);
		pd.put("a_cut_img_x2", a_cut_img_x2);
		pd.put("a_cut_img_y2",a_cut_img_y2);
		pd.put("a_cut_img_width", a_cut_img_width);
		pd.put("a_cut_img_height",a_cut_img_height);
		pd.put("activity_id",activity_id);
		activityService.update(pd);
		
		
		
		String db_a_original_img_name = String.valueOf(activity_id_pd.get("a_original_img_name"));
		
		if(!db_a_original_img_name.equals(a_original_img_name)){
			 String pictureSaveFilePath = Const.RESOURCES_LOCAL+Const.ACTIVITY_ORIGINAL_IMG+a_original_img_name;
			 //活动轮播、非轮播、列表路径640*400
			 String activity_id_width_height = Const.RESOURCES_LOCAL+Const.ACTIVITY_ID_WIDTH_HEIGHT+"activity_"+activity_id+"_640_400.png";int width640 = 640,height400=400;
			
			 //活动收藏200*125
			 String collect_activity_width_height = Const.RESOURCES_LOCAL+Const.COLLECT_ACTIVITY_WIDTH_HEIGHT+"collect_activityid"+activity_id+"_width200_height125.png";int width200 = 200,height125=125;
			 
			 //原图裁剪，裁剪成活动列表图
			 ImgUtil.cut(Integer.parseInt(a_cut_img_x1), Integer.parseInt(a_cut_img_y1), width640, height400,pictureSaveFilePath,activity_id_width_height);
			
			 Thread.sleep(3000);
			 //压缩收藏图
			 ImageUtil.resize(activity_id_width_height, collect_activity_width_height, width200, height125,1f);
			 
		}
		//线上活动详情225*360
		String activity_id_width225_height360 = Const.RESOURCES_LOCAL+Const.ACTIVITY_ID_WIDTH225_HEIGHT360+ "activity_id_"+activity_id+"_225_360.png";int width225 = 225,height360=360;
		File file=new File(Const.RESOURCES_LOCAL+Const.ACTIVITY_ID_WIDTH225_HEIGHT360+activityinfoimgname); 
		if(file.exists()){
			file.renameTo(new File(activity_id_width225_height360));
		}
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		mv.setViewName("business/activity/online_activity_list");
		return mv;
	}
	@RequestMapping(value="/upload")
	public void upload(HttpServletRequest request,@RequestParam(value="tp",required=false) MultipartFile tp, HttpServletResponse response) throws Exception{
		//@RequestParam(value="uploadpushimg",required=false) String uploadpushimg,
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Content-Type", "text/html; charset=UTF-8");
		mv.clear();
		pd = this.getPageData();
		String pictureSaveFilePath = Const.RESOURCES_LOCAL+Const.ACTIVITY_ORIGINAL_IMG;
		if (null != tp && !tp.isEmpty()) {
			try {
				PrintWriter out = response.getWriter();
				long currentTimeMillis = System.currentTimeMillis();
				String extName = "";
				// 扩展名格式：
				if (tp.getOriginalFilename().lastIndexOf(".") >= 0) {
					extName = tp.getOriginalFilename().substring(tp.getOriginalFilename().lastIndexOf("."));
				}
				String imgName = currentTimeMillis+extName;
				pd.put("stieurl",imgName); 
				this.copyFile(tp.getInputStream(), pictureSaveFilePath,imgName).replaceAll("-", "");
				mv.addObject("msg","success");
				String http_img = Const.RESOURCES_BASE+ Const.ACTIVITY_ORIGINAL_IMG+ imgName;
				System.out.println("-------http_img--------"+http_img);
				Map<String, Long> imgInfo = ImgUtil.getImgInfo(pictureSaveFilePath+imgName);
				Long w = imgInfo.get("w");
				Long h = imgInfo.get("h");
				Long s = imgInfo.get("s");
				System.out.println(""+s+"---"+h+"---"+w);
				if(w<640||h<400){
					out.print("<script>parent.window.alert(\"请上传640*400以上的图片！\");</script>");
					out.close();
					return;
				}
				out.print("<script>parent.document.getElementById('element_id').src=\""+ http_img+ "\";parent.$('.activityimgname').val('"+imgName+"'); parent.$('.imgInfo').val('"+imgInfo+"');</script>");
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
	@RequestMapping(value="/uploadActivityInfo")
	public void uploadActivityInfo(HttpServletRequest request,@RequestParam(value="activityInfoFile",required=false) MultipartFile tp,HttpServletResponse response) throws Exception{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Content-Type", "text/html; charset=UTF-8");
		mv.clear();
		pd = this.getPageData();
		String pictureSaveFilePath = Const.RESOURCES_LOCAL+Const.ACTIVITY_ID_WIDTH225_HEIGHT360;
		if (null != tp && !tp.isEmpty()) {
			try {
				PrintWriter out = response.getWriter();
				long currentTimeMillis = System.currentTimeMillis();
				String extName = "";
				// 扩展名格式：
				if (tp.getOriginalFilename().lastIndexOf(".") >= 0) {
					extName = tp.getOriginalFilename().substring(tp.getOriginalFilename().lastIndexOf("."));
				}
				String imgName = currentTimeMillis+extName;
				//pd.put("stieurl",imgName); 
				this.copyFile(tp.getInputStream(), pictureSaveFilePath,imgName).replaceAll("-", "");
				Map<String, Long> imgInfo = ImgUtil.getImgInfo(pictureSaveFilePath+imgName);
				Long w = imgInfo.get("w");
				Long h = imgInfo.get("h");
				Long s = imgInfo.get("s");
				System.out.println(""+s+"---"+h+"---"+w);
				if(w!=225||h!=360){
					out.print("<script>parent.window.alert(\"图片尺寸不符合要求！\");</script>");
					out.close();
					return;
				}
				mv.addObject("msg","success");
				System.out.println("活动详情图httpurl=====>>>>>>>>>>"+Const.RESOURCES_BASE+Const.ACTIVITY_ID_WIDTH225_HEIGHT360+imgName);
				out.print("<script>parent.document.getElementById('showActivityInfo').src=\""+Const.RESOURCES_BASE+Const.ACTIVITY_ID_WIDTH225_HEIGHT360+imgName+"\";parent.$('.activityinfoimgname').val('"+imgName+"'); </script>");
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
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(@RequestParam String activity_id,PrintWriter out){
		logBefore(logger, "删除Activity");
		try{
			activityService.deleteActivityById(activity_id);
			out.write("success");
			out.flush();
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 写文件到当前目录的upload目录中
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
	/**
	 * 线下活动保存
	 */
	@RequestMapping(value="/offline_save")
	public ModelAndView offline_save(Page page){
		logBefore(logger, "保存线下Activity");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		JSONObject imgInfoMap = JSONObject.fromObject(pd.get("imgInfo"));
		try{
			this.getHC(); //调用权限
			int x = 0;
			int y = 0;
			int width = 640;
			int height = 400;
			System.out.println(pd.getString("a_cut_img_x1"));
			if(!"".equals(pd.getString("a_cut_img_x1"))){
				x = Integer.parseInt(pd.getString("a_cut_img_x1"));
				y = Integer.parseInt(pd.getString("a_cut_img_y1"));
				width = Integer.parseInt(pd.getString("a_cut_img_x2"))-x;
				height = Integer.parseInt(pd.getString("a_cut_img_y2"))-y;
				if(pd.getString("a_cut_img_x2").contains(".")){
					String a_cut_img_x2 = pd.getString("a_cut_img_x2").substring(0,pd.getString("a_cut_img_x2").lastIndexOf("."));
					pd.put("a_cut_img_x2", a_cut_img_x2);
				}
				if(pd.getString("a_cut_img_y2").contains(".")){
					String a_cut_img_y2 = pd.getString("a_cut_img_y2").substring(0,pd.getString("a_cut_img_y2").lastIndexOf("."));
					pd.put("a_cut_img_y2", a_cut_img_y2);
				}
				if(pd.getString("a_cut_img_width").contains(".")){
					String a_cut_img_width = pd.getString("a_cut_img_width").substring(0,pd.getString("a_cut_img_width").lastIndexOf("."));
					pd.put("a_cut_img_width", a_cut_img_width);
				}
				if(pd.getString("a_cut_img_height").contains(".")){
					String a_cut_img_height = pd.getString("a_cut_img_height").substring(0,pd.getString("a_cut_img_height").lastIndexOf("."));
					pd.put("a_cut_img_height", a_cut_img_height);
				}
			}else{
				pd.put("a_cut_img_x1", 0);
				pd.put("a_cut_img_y1", 0);
				pd.put("a_cut_img_x2", 640);
				pd.put("a_cut_img_y2", 400);
				pd.put("a_cut_img_width", 640);
				pd.put("a_cut_img_height", 400);
			}
			long currentTimeMillis = System.currentTimeMillis();
			pd.put("a_currentTimeMillis", currentTimeMillis);
			pd.put("a_operating_user", user.getNAME());
			pd.put("a_original_img_width",imgInfoMap.getInt("w"));
			pd.put("a_original_img_height",imgInfoMap.getInt("h"));
			pd.put("a_original_img_size",imgInfoMap.getInt("s"));
			pd.put("a_operating_obj",1);
			pd.put("a_html", pd.getString("editorContent"));
			Date a_apply_start_datetime = DateUtil.toDate(pd.getString("a_apply_start_datetime").substring(0, 10)+" 00:00:01","yyyy-MM-dd HH:mm:ss");
			Date a_apply_end_datetime = DateUtil.toDate(pd.getString("a_apply_end_datetime").substring(0, 10)+" 23:59:59","yyyy-MM-dd HH:mm:ss");
			Date a_activity_start_datetime = DateUtil.toDate(pd.getString("a_activity_start_datetime").substring(0, 10)+" 00:00:01","yyyy-MM-dd HH:mm:ss");
			Date a_activity_end_datetime = DateUtil.toDate(pd.getString("a_activity_end_datetime").substring(0, 10)+" 23:59:59","yyyy-MM-dd HH:mm:ss");
//			Date a_apply_start_datetime = DateUtil.fomatDate(pd.getString("a_apply_start_datetime").substring(0, 10)+" 00:00:01");
//			Date a_apply_end_datetime = DateUtil.fomatDate(pd.getString("a_apply_end_datetime").substring(0, 10)+" 23:59:59");
//			Date a_activity_start_datetime = DateUtil.fomatDate(pd.getString("a_activity_start_datetime").substring(0, 10)+" 00:00:01");
//			Date a_activity_end_datetime = DateUtil.fomatDate(pd.getString("a_activity_end_datetime").substring(0, 10)+" 23:59:59");
			pd.put("a_apply_start_datetime", a_apply_start_datetime);
			pd.put("a_apply_end_datetime", a_apply_end_datetime);
			pd.put("a_activity_start_datetime", a_activity_start_datetime);
			pd.put("a_activity_end_datetime", a_activity_end_datetime);
			String a_activity_venue_name = pd.getString("a_activity_venue_name");
			String []id_name = a_activity_venue_name.split("_");
			pd.put("a_activity_venue_id", id_name[0]);
			pd.put("a_activity_venue_name", id_name[1]);
			System.out.println("pd.getString(activity_id)="+pd.getString("activity_id"));
			String activity_id = pd.getString("activity_id");
			//通过activity_id判断是编辑还是保存
			if(!"".equals(activity_id)){
				activityService.offline_edit(pd);
			}else{
				activityService.offline_save(pd);
				//获取活动的activity_id
				PageData activity_id_pd = activityService.getActivityId(pd);
				activity_id = String.valueOf(activity_id_pd.get("activity_id"));
			}
			
			//原图保存路径
			String pictureSaveFilePath = Const.RESOURCES_LOCAL+Const.ACTIVITY_ORIGINAL_IMG+pd.getString("a_original_img_name");
			
			String activity_id_width_height_max = Const.RESOURCES_LOCAL+Const.ACTIVITY_ID_WIDTH_HEIGHT_MAX+"activity_"+activity_id+"_"+width+"_"+height+".png";
			
			//活动轮播图640*400
			String activity_id_width_height = Const.RESOURCES_LOCAL+Const.ACTIVITY_ID_WIDTH_HEIGHT+"activity_"+activity_id+"_640_400.png";int width640 = 640,height400=400;

			//活动收藏200*125
			String collect_activity_width_height = Const.RESOURCES_LOCAL+Const.COLLECT_ACTIVITY_WIDTH_HEIGHT+"collect_activityid"+activity_id+"_width200_height125.png";int width200 = 200,height125=125;
			
			//原图裁剪
			ImgUtil.cut(x, y, width, height,pictureSaveFilePath,activity_id_width_height_max);
			
			//压缩轮播图
			ImageUtil.resize(activity_id_width_height_max, activity_id_width_height, width640, height400,1f);
			
			//压缩收藏图
			ImageUtil.resize(activity_id_width_height_max, collect_activity_width_height, width200, height125,1f);
			
			//生成静态页
			String resources8383 = Const.RESOURCES_LOCAL;
			String resources_base = Const.RESOURCES_BASE;
			String share_activity = Const.SHARE_ACTIVITY;
			String template_activityshare = Const.TEMPLATE_ACTIVITYSHARE;
			//String htmlContent = pd.getString("editorContent").replace("<img", "<img style=\"width:100%;\"");
			Map<String, String> info = new HashMap<String, String>();
			String title = pd.getString("a_title");
			if(title.length()>15){
				title = title.substring(0,15)+"...";
			}
			info.put("#title#", title);
			info.put("#content#",pd.getString("a_introduce"));
			info.put("#activityimg#",Const.RESOURCES_BASE+Const.ACTIVITY_ID_WIDTH_HEIGHT+"activity_"+activity_id+"_640_400.png");
			StaticUtil.jsp2sta(resources_base+template_activityshare,resources8383+share_activity,"s_a_i"+activity_id+".html", info);
			
			//返回线下活动列表图
			pd.clear();
			String systemTime = DateUtil.toString(new Date(), "yyyy-MM-dd HH:mm:ss");
			pd.put("a_type", -1);
			pd.put("systemTime", systemTime);
			page.setPd(pd);
			List<PageData> activityList = activityService.list(page);
			this.getHC(); //调用权限
			mv.setViewName("business/activity/offline_activity_list");
			mv.addObject("varList", activityList);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 新增线下活动
	 */
	@RequestMapping(value="/Offline_goAdd")
	public ModelAndView offlineGoAdd(){
		logBefore(logger, "新增线下活动Activity");
		ModelAndView mv = this.getModelAndView();
		try{
			this.getHC(); //调用权限
			List<PageData> accountList = accountService.list(pd);
			mv.setViewName("business/activity/offline_activity_add");
			mv.addObject("varList", accountList);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 线下活动列表
	 */
	@RequestMapping(value="/offlinelist")
	public ModelAndView offlinelist(Page page){
		logBefore(logger, "线下活动列表Activity");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			/*//场馆名称（举办活动）
			String a_activity_venue_name = pd.getString("a_activity_venue_name");
			if(a_activity_venue_name!=null&&!"".equals(a_activity_venue_name)){
				a_activity_venue_name = a_activity_venue_name.trim();
				pd.put("a_activity_venue_name", a_activity_venue_name);
			}
			//主办方名称
			String a_sponsor_venue_name = pd.getString("a_sponsor_venue_name");
			if(a_sponsor_venue_name!=null&&!"".equals(a_sponsor_venue_name)){
				a_sponsor_venue_name = a_sponsor_venue_name.trim();
				pd.put("a_sponsor_venue_name", a_sponsor_venue_name);
			}
			//手机(格式11位)或座机(前必须加022-)
			String a_phone = pd.getString("a_phone");
			if(a_phone!=null&&!"".equals(a_phone)){
				a_phone = a_phone.trim();
				pd.put("a_phone", a_phone);
			}
			//活动状态 0:活动未开始 1：报名已结束 2：活动已结束 3：活动进行中   default:-1
			String a_status = pd.getString("a_status");
			if(a_status!=null&&!"".equals(a_status)){
				pd.put("a_status", a_status);
			}
			//活动开始时间
			String a_activity_start_datetime = pd.getString("a_activity_start_datetime");
			if(a_activity_start_datetime!=null&&!"".equals(a_activity_start_datetime)){
				pd.put("a_activity_start_datetime", a_activity_start_datetime);
			}
			//活动结束时间
			String a_activity_end_datetime = pd.getString("a_activity_end_datetime");
			if(a_activity_end_datetime!=null&&!"".equals(a_activity_end_datetime)){
				pd.put("a_activity_end_datetime", a_activity_end_datetime);
			}
			//报名或投票开始时间
			String a_apply_start_datetime = pd.getString("a_apply_start_datetime");
			if(a_apply_start_datetime!=null&&!"".equals(a_apply_start_datetime)){
				pd.put("a_apply_start_datetime", a_apply_start_datetime);
			}
			//报名或投票结束时间
			String a_apply_end_datetime = pd.getString("a_apply_end_datetime");
			if(a_apply_end_datetime!=null&&!"".equals(a_apply_end_datetime)){
				pd.put("a_apply_end_datetime", a_apply_end_datetime);
			}*/
			//活动类型 1：线上投票 -1：线下活动
			String systemTime = DateUtil.toString(new Date(), "yyyy-MM-dd HH:mm:ss");
			pd.put("a_type", -1);
			pd.put("systemTime", systemTime);
			page.setPd(pd);
			List<PageData> activityList = activityService.list(page);
			this.getHC(); //调用权限
			mv.setViewName("business/activity/offline_activity_list");
			mv.addObject("varList", activityList);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/* ===============================权限================================== */
	public void getHC(){
		ModelAndView mv = this.getModelAndView();
		HttpSession session = this.getRequest().getSession();
		Map<String, String> map = (Map<String, String>)session.getAttribute(Const.SESSION_QX);
		mv.addObject(Const.SESSION_QX,map);	//按钮权限
		List<Menu> menuList = (List)session.getAttribute(Const.SESSION_menuList);
		mv.addObject(Const.SESSION_menuList, menuList);//菜单权限
	}
	/* ===============================权限================================== */
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
