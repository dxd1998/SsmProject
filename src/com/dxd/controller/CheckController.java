package com.dxd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dxd.pojo.Check;
import com.dxd.pojo.CheckMessage;
import com.dxd.pojo.Person;
import com.dxd.service.CheckService;
import com.dxd.service.PersonService;
import com.dxd.utils.Pager;
import com.dxd.utils.PrintUtils;
import com.dxd.utils.ReturnResult;

/**
 * 考勤 控制器
 * @author 99266
 *
 */
@Controller
@RequestMapping("check/")
public class CheckController {
	@Autowired
	private CheckService cs;
	@Autowired
	private PersonService ps;
	
	/**
	 * 考勤记录显示
	 * @param pName
	 * @param cId
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@RequestMapping("index")
	public String getCheck(@RequestParam(value="pName",required=false)String pName,
			@RequestParam(value="cId",required=false)String cId,
			@RequestParam(value="currentPage",required=false)String currentPage,
			Model model) {
		Map<String,Object> map = new HashMap<>();
		map.put("pName", pName);
		map.put("cId", cId);
		//查询考勤记录数
		int count = cs.getCheckCount(map);
		int currentPage1 = 1;
		if(null != currentPage) {
			currentPage1 = Integer.parseInt(currentPage);
		}
		Pager pager = new Pager(count,5,currentPage1);
		pager.setUrl("spring/check/index");
		map.put("currentPage", pager.getCurrentPage());
		map.put("rowPerPage", pager.getRowPerPage());
		//得到结果集
		List<CheckMessage> checkList = cs.getCheck(map);
		//得到所有考勤类型
		List<Check> typeList = cs.getCheckType();
		
		//存储到model
		model.addAttribute("checkList",checkList);
		model.addAttribute("typeList",typeList);
		model.addAttribute("pager",pager);
		model.addAttribute("pName",pName);
		model.addAttribute("cId",cId);
		return "check/checkList";
	}
	/**
	 * 删除记录
	 * @param checkId
	 * @param response
	 */
	@RequestMapping(value="delCheck",method=RequestMethod.POST)
	public void delCheck(int checkId,HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		int count = cs.delCheck(checkId);
		if(count > 0) {
			PrintUtils.getJsonString(response, result.getSuccess("删除记录成功!"));
		}else {
			PrintUtils.getJsonString(response, result.getFail("系统出现异常!请联系管理员!"));
		}
	}
	/**
	 * 新增考勤记录页面
	 * @param model
	 * @return
	 */
	@RequestMapping("toAdd")
	public String toAdd(Model model) {
		//查询所有员工
		Map<String,Object> map = new HashMap<>();
		map.put("pName", "");
		map.put("dId", "");
		List<Person> personList = ps.getPerson(map);
		//查询所有考勤类型
		List<Check> checkList = cs.getCheckType();
		
		model.addAttribute("personList",personList);
		model.addAttribute("checkList",checkList);
		return "check/addCheck";
	}
	/**
	 * 添加记录
	 * @param pId
	 * @param checkDate
	 * @param checkType
	 * @param response
	 */
	@RequestMapping(value="Add",method=RequestMethod.POST)
	public void add(int pId,String checkDate,int checkType,HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		Map<String,Object> map = new HashMap<>();
		map.put("pId", pId);
		map.put("cId", checkType);
		map.put("checkDate", checkDate);
		//得到结果
		int count = cs.addCheck(map);
		if(count > 0) {
			PrintUtils.getJsonString(response, result.getSuccess("添加记录成功!"));
		}else {
			PrintUtils.getJsonString(response, result.getFail("系统出现异常!请联系管理员!"));
		}
	}
}
