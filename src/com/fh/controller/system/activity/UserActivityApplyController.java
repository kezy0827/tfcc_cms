package com.fh.controller.system.activity;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.service.system.activity.UserActivityApplyService;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

/** 
 * 类名称：UserActivityApplyController
 * 创建人：zhangchunming
 * 创建时间：2015年03月23日
 * @version
 */
@Controller
@RequestMapping(value="/useractivityapply")
public class UserActivityApplyController extends BaseController{
	@Resource(name="userActivityApplyService")
	private UserActivityApplyService userActivityApplyService;
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView listUsers(Page page) throws Exception{
		logBefore(logger, "报名用户列表Activity");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			List<PageData> userList = userActivityApplyService.list(page);
			System.out.println("-----------------------------------------"+userList.size());
			//调用权限
			this.getHC(); //================================================================================
			//调用权限
			mv.setViewName("business/user/activity_user_list");
			mv.addObject("userList", userList);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 修改订单状态
	 */
	@RequestMapping(value="updateStatus")
	public void updateStatus(){
		logBefore(logger, "修改订单状态");
		pd.clear();
		pd = this.getPageData();
		try {
			userActivityApplyService.updateStatus(pd);
			//调用权限
			this.getHC(); //================================================================================
			//调用权限
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error(e.toString(), e);
		}
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
	
	*//**
	 * 去修改页面
	 *//*
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		mv.clear();
		pd = this.getPageData();
		try {
			
			pd = contestantService.findById(pd);
			
			mv.setViewName("information/link/link_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}*/
	
	
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
	/*
	 * 导出报名用户到到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(Page page){
		logBefore(logger, "导出News到excel");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("支付宝订单号");	//1
			titles.add("商户订单号");	//2
			titles.add("用户名");	//3
			titles.add("用户电话");	//4
			titles.add("报名状态");	//5
			titles.add("是否线上支付");	//6
			titles.add("订单状态");	//7
			titles.add("订单价格");	//8
			titles.add("创建时间");	//9
			dataMap.put("titles", titles);
			page.setPd(pd);
			List<PageData> varOList = userActivityApplyService.list(page);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				String uaa_ispay = "";
				if(varOList.get(i).get("uaa_ispay").toString().equals("1")){
					uaa_ispay = "是";
				}else{
					uaa_ispay = "否";
				}
				String uaa_pay_status="";
				switch(Integer.parseInt(varOList.get(i).get("uaa_pay_status").toString())){
					case 0:uaa_pay_status="用户未支付";break;
					case 1:uaa_pay_status="报名成功";break;
					case 2:uaa_pay_status="支付失败";break;
					case 3:uaa_pay_status="退款中";
				}
				String uo_status="";
				System.out.println("varOList.get(i).get('uo_status')=="+varOList.get(i).get("uo_status"));
				System.out.println("=======================================");
				if(uaa_ispay.equals("是")&&varOList.get(i).get("uo_status")==null){
					uo_status="";
				}else if(uaa_ispay.equals("否")&&varOList.get(i).get("uo_status")==null){
					uo_status="线下支付";
				}else{
					switch(Integer.parseInt(varOList.get(i).get("uo_status").toString())){
						case 1:uo_status="已付款";break;
						case 2:uo_status="已消费";break;
						case 3:uo_status="已关闭";break;
						case 4:uo_status="已过期";break;
						case 5:uo_status="已退款";break;
						case 6:uo_status="未付款";
					}
				}
				String uo_total_price = "";
				if(varOList.get(i).get("uo_total_price")!=null){
					uo_total_price=varOList.get(i).get("uo_total_price").toString();
				}
				vpd.put("var1", varOList.get(i).getString("uo_trade_no"));	//1
				vpd.put("var2", varOList.get(i).getString("user_order_number"));	//2
				vpd.put("var3", varOList.get(i).getString("nick_name"));	//3
				vpd.put("var4", varOList.get(i).getString("user_mobile"));	//4
				vpd.put("var5", uaa_pay_status);	//5
				vpd.put("var6", uaa_ispay);	//6
				vpd.put("var7", uo_status);	//7
				vpd.put("var8", uo_total_price);	//8
				vpd.put("var9", varOList.get(i).get("uaa_create_datetime").toString().substring(0, 19));	//9
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
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

