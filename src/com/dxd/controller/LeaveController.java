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

import com.dxd.pojo.Leave;
import com.dxd.pojo.LeaveMessage;
import com.dxd.pojo.Person;
import com.dxd.pojo.Type;
import com.dxd.service.LeaveService;
import com.dxd.service.PersonService;
import com.dxd.utils.Pager;
import com.dxd.utils.PrintUtils;
import com.dxd.utils.ReturnResult;

/**
 * 请假管理 控制器
 * @author 99266
 *
 */
@Controller
@RequestMapping("leave/")
public class LeaveController {
	
	@Autowired
	private LeaveService ls;
	@Autowired
	private PersonService ps;
	/**
	 * 请假记录显示页面
	 * @return
	 */
	@RequestMapping("index")
	public String toIndex(@RequestParam(value="pName",required=false)String pName,
			@RequestParam(value="tId",required=false)String tId,
			@RequestParam(value="currentPage",required=false)String currentPage,Model model) {
		Map<String,Object> map = new HashMap<>();
		map.put("pName", pName);
		map.put("tId", tId);
		//得到信息数
		int count = ls.getLeaveCount(map);
		int currentPage1 = 1;
		if(null != currentPage) {
			currentPage1 = Integer.parseInt(currentPage);
		}
		Pager pager = new Pager(count,5,currentPage1);
		pager.setUrl("spring/leave/index");
		map.put("currentPage", pager.getCurrentPage());
		map.put("rowPerPage", pager.getRowPerPage());
		//得到结果集
		List<LeaveMessage> leaveList = ls.getLeave(map);
		//得到所有处理类型
		List<Type> typeList = ls.getType();
		//判断是否存储类型查询条件
		if(tId != "") {
			model.addAttribute("tId",tId);
		}
		//存储到model中
		model.addAttribute("leaveList",leaveList);
		model.addAttribute("typeList", typeList);
		model.addAttribute("pager",pager);
		model.addAttribute("pName",pName);
		return "leave/leaveMessage";
	}
	/**
	 * 删除指定请假记录
	 * @param leaveId
	 * @param response
	 */
	@RequestMapping(value="del",method = RequestMethod.POST)
	public void delLeave(int leaveId,HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		//得到结果
		int count = ls.delLeave(leaveId);
		if(count > 0) {
			PrintUtils.getJsonString(response, result.getSuccess("删除该记录成功!"));
		}else {
			PrintUtils.getJsonString(response, result.getFail("系统出现异常!请联系管理员!"));
		}
	}
	/**
	 * 修改审核状态
	 * @param tId
	 * @param leaveId
	 * @param response
	 */
	@RequestMapping(value="updateLeave",method=RequestMethod.POST)
	public void updateLeaveType(int tId,int leaveId,HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		Map<String,Object> map = new HashMap<>();
		map.put("tId", tId);
		map.put("leaveId", leaveId);
		//得到结果
		int count = ls.updateLeaveType(map);
		if(count > 0) {
			PrintUtils.getJsonString(response, result.getSuccess("操作成功!"));
		}else {
			PrintUtils.getJsonString(response, result.getFail("系统出现异常!请联系管理员!"));
		}
	}
	/**
	 * 新增请假记录
	 * @return
	 */
	@RequestMapping("add")
	public String toAdd(Model model) {
		//获得所有员工信息
		Map<String,Object> map = new HashMap<>();
		List<Person> personList = ps.getPerson(map);
		//获得所有请假类型
		List<Leave> leaveType = ls.getLeaveType();
		
		//存储到model
		model.addAttribute("personList",personList);
		model.addAttribute("leaveType",leaveType);
		return "leave/addLeave";
	}
	/**
	 * 新增请假记录
	 * @param lm
	 * @param leaveType
	 * @param type
	 * @param response
	 */
	@RequestMapping(value="addLeave",method=RequestMethod.POST)
	public void addLeave(LeaveMessage lm,String leaveType,String pId,
			HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		Map<String,Object> map = new HashMap<>();
		map.put("leaveStart", lm.getLeaveStart());
		map.put("leaveEnd", lm.getLeaveEnd());
		map.put("pId", pId);
		map.put("leaveType", leaveType);
		//添加
		int count = ls.addLeave(map);
		if(count > 0) {
			PrintUtils.getJsonString(response, result.getSuccess("新增请假记录成功!"));
		}else {
			PrintUtils.getJsonString(response, result.getFail("系统出现异常!请联系管理员!"));
		}
	}
}
