package com.dxd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dxd.pojo.Department;
import com.dxd.pojo.Person;
import com.dxd.service.DepartmentService;
import com.dxd.service.PersonService;
import com.dxd.utils.Pager;
import com.dxd.utils.PrintUtils;
import com.dxd.utils.ReturnResult;

/**
 * 部门 控制器
 * @author 99266
 *
 */
@Controller
@RequestMapping("department/")
public class DepartmentController {
	
	@Autowired
	private DepartmentService ds;
	@Autowired
	private PersonService ps;
	/**
	 * 部门列表展示
	 * @param pName
	 * @param dId
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@RequestMapping("index")
	public String toList(@RequestParam(value="pName",required=false)String pName,
			@RequestParam(value="dId",required=false)String dId,
			@RequestParam(value="currentPage",required=false)String currentPage,Model model) {
		//查询所有部门/下拉列表
		List<Department> deList = ds.getDepartment();
		Map<String,Object> map = new HashMap<>();
		map.put("pName", pName);
		map.put("dId", dId);
		int currentPage1 = 1;
		if(null != currentPage) {
			currentPage1 = Integer.parseInt(currentPage);
		}
		//得到部门条数
		int count = ds.getDepartmentDescCount(map);
		//分页对象
		Pager pager = new Pager(count,6,currentPage1);
		//设置url
		pager.setUrl("spring/department/index");
		//存储分页信息
		map.put("currentPage", pager.getCurrentPage());
		map.put("rowPerPage", pager.getRowPerPage());
		//得到部门集合
		List<Department> departmentList = ds.getDepartmentDesc(map);
		//存储到model对象
		model.addAttribute("pager",pager);
		model.addAttribute("deList",deList);
		model.addAttribute("departmentList",departmentList);
		//存储查询条件
		model.addAttribute("pName",pName);
		model.addAttribute("dId",dId);
		return "department/departmentList";
	}
	/**
	 * 删除指定部门
	 * @param dId
	 */
	@RequestMapping(value="delDepartment",method=RequestMethod.POST)
	public void delDepartment(String dId,HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		//判断需要删除的部门下是否存在员工
		int count = ds.checkDepartmentOfPerson(Integer.parseInt(dId));
		if(count > 0) { //不能删除
			PrintUtils.getJsonString(response, result.getFail("该部门下还存在员工!不能删除!"));
		}else { //可以删除
			int count1 = ds.delDepartment(Integer.parseInt(dId));
			if(count1 > 0) {
				PrintUtils.getJsonString(response, result.getSuccess("删除部门成功!"));
			}else {
				PrintUtils.getJsonString(response, result.getFail("系统出现异常!请联系管理员!"));
			}
		}
	}
	/**
	 * 修改页面
	 * @return
	 */
	@RequestMapping("toUpdate")
	public String toUpdate(String dId,String currentPage,Model model) {
		//获得所有员工信息
		Map<String,Object> map = new HashMap<>();
		map.put("pName", "");
		map.put("dId", "");
		List<Person> personList = ps.getPerson(map);
		//获得部门信息
		List<Department> departmentList = ds.getDepartment();
		Department de = null;
		for(Department dt : departmentList) {
			if(dt.getdId() == Integer.parseInt(dId)) {
				de = dt;
			}
		}
		//存储到model中
		model.addAttribute("department",de);
		model.addAttribute("personList",personList);
		model.addAttribute("currentPage",currentPage);
		return "department/addorupdate2";
	}
	/**
	 * 添加页面
	 * @return
	 */
	@RequestMapping("toAdd")
	public String toAdd(Model model) {
		//获得所有员工信息
		Map<String,Object> map = new HashMap<>();
		map.put("pName", "");
		map.put("dId", "");
		List<Person> personList = ps.getPerson(map);
		//存储
		model.addAttribute("personList",personList);
		return "department/addorupdate2";
	}
	/**
	 * 保存修改
	 * @param department
	 * @param pId
	 * @param response
	 */
	@RequestMapping(value="saveUpdate",method=RequestMethod.POST)
	public void saveUpdate(Department department,String pId,HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		Map<String,Object> map = new HashMap<>();
		map.put("dName", department.getdName());
		map.put("pId", pId);
		map.put("dId", department.getdId());
		int count = ds.updateDepartment(map);
		if(count > 0) {
			PrintUtils.getJsonString(response, result.getSuccess("修改部门成功!"));
		}else {
			PrintUtils.getJsonString(response, result.getFail("系统出现异常!请联系管理员!"));
		}
	}
	/**
	 * 新增部门
	 * @param department
	 * @param pId
	 * @param response
	 */
	@RequestMapping(value="add",method=RequestMethod.POST)
	public void add(Department department,String pId,HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		Map<String,Object> map = new HashMap<>();
		map.put("dName", department.getdName());
		map.put("pId", pId);
		map.put("dDate", department.getdDate());
		int count = ds.addDepartment(map);
		if(count > 0) {
			PrintUtils.getJsonString(response, result.getSuccess("添加部门成功!"));
		}else {
			PrintUtils.getJsonString(response, result.getFail("系统出现异常!请联系管理员!"));
		}
	}
	/**
	 * 获得当前登录员工
	 * @param request
	 * @return
	 */
	public Object getSessionLoginUser(HttpServletRequest request) {
		Person person = (Person)request.getSession().getAttribute("loginUser");
		return person;
	}
}
