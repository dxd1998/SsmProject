package com.dxd.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dxd.pojo.Address;
import com.dxd.pojo.Department;
import com.dxd.pojo.Person;
import com.dxd.pojo.Role;
import com.dxd.service.AddressService;
import com.dxd.service.DepartmentService;
import com.dxd.service.PersonService;
import com.dxd.service.RoleService;
import com.dxd.utils.Pager;
import com.dxd.utils.PrintUtils;
import com.dxd.utils.ReturnResult;

/**
 * 员工控制器
 * @author 99266
 *
 */
@Controller
@RequestMapping("person/")
public class PersonController {
	//员工业务层对象
	@Autowired
	private PersonService ps;
	//部门业务层对象
	@Autowired
	private DepartmentService ds;
	//地址业务层对象
	@Autowired
	private AddressService as;
	//角色业务层对象
	@Autowired
	private RoleService rs;
	
	/**
	 * 查询所有员工,条件查询,分页
	 * @param pName
	 * @param dId
	 * @param model
	 * @return
	 */
	@RequestMapping("getPerson")
	public String getPerson(@RequestParam(value="pName",required=false)String pName,
			@RequestParam(value="dId",required=false)String dId,
			@RequestParam(value="currentPage",required=false)String currentPage,Model model,HttpServletRequest request) {
		//根据条件查询满足条件的信息数
		Map<String,Object> map = new HashMap<>();
		String dId1 = "";
		if(null != dId && !dId.equals("0")) {
			dId1 = dId;
		}
		String currentPage1 = "1";
		if(null != currentPage) {
			currentPage1 = currentPage;
		}
		int count = 0; //信息数
		Pager pager = null;
		List<Person> list = null;
		//获得当前登录员工
		Person loginPerson = (Person)this.getSessionLoginUser(request);
		//判断当前登录员工权限
		if(loginPerson.getRole().getrId() == 1) { //管理员
			map.put("pName", pName);
			map.put("dId", dId1);
			count = ps.getPersonCount(map);
			//创建分页工具类
			pager = new Pager(count,6,Integer.parseInt(currentPage1));
			map.put("rowPerPage", pager.getRowPerPage());
			map.put("currentPage", pager.getCurrentPage());
			//得到员工集合
			list = ps.getPerson(map);
		}else if(loginPerson.getRole().getrId() == 2) {  //部门经理
			map.put("pName", pName);
			//获得该部门经理部门下的所有员工
			int departmentId = ps.getDepartmentManager(loginPerson.getpId());
			count = ps.getDepartmentPersonByDidCount(departmentId);
			//创建分页工具类
			pager = new Pager(count,6,Integer.parseInt(currentPage1));
			map.put("rowPerPage", pager.getRowPerPage());
			map.put("currentPage", pager.getCurrentPage());
			map.put("dId", departmentId);
			//得到结果集
			list = ps.getDepartmentPersonByDid(map);
		}else { //普通员工
			list = new ArrayList<>();
			list.add((Person)this.getSessionLoginUser(request));
			//创建分页工具类
			pager = new Pager(list.size(),6,Integer.parseInt(currentPage1));
			map.put("rowPerPage", pager.getRowPerPage());
			map.put("currentPage", pager.getCurrentPage());
		}
		//设置url
		pager.setUrl("spring/person/getPerson");
		//循环添加每个员工的所有地址
		for(Person per : list) {
			per.setAddress(as.getPersonAllAddress(per.getpId()));
		}
		//得到所有部门集合
		List<Department> deList = ds.getDepartment();
		//存储到model中
		model.addAttribute("personList",list);
		model.addAttribute("pager",pager);
		model.addAttribute("deList",deList);
		//存储查询条件
		model.addAttribute("pName",pName);
		model.addAttribute("dId",dId);
		return "person/personList";
	}
	/**
	 * 删除指定用户
	 * @param pId
	 * @return
	 */
	@RequestMapping(value="delPerson",method=RequestMethod.POST)
	public void delPerson(@RequestParam(value="pId",required=false)int pId,HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		boolean flag = false;  //记录是否为部门负责人
		String departmentName = "";
		//判断需要删除的用户是否为部门负责人
		//得到所有部门信息
		List<Department> deList = ds.getDepartment();
		for(Department de : deList) {
			if(de.getPerson().getpId() == pId) {
				flag = true;
				departmentName = de.getdName();
			}
		}
		//判断
		if(flag) { //该员工为负责人
			PrintUtils.getJsonString(response, result.getFail("该员工为"+departmentName+"的负责人,请先修改该部门负责人,再执行操作!"));
		}else { //该员工为普通员工
			//删除该员工请假记录
			ps.delPerson_leave(pId);
			//删除该员工考勤记录
			ps.delPerson_check(pId);
			//删除该员工身份
			ps.delPerson_role(pId);
			//删除该员工地址
			ps.delPerson_Address(pId);
			//删除该员工部门
			ps.delPerson_Department(pId);
			//删除该员工
			int count = ps.delPerson(pId);
			if(count > 0) {
				PrintUtils.getJsonString(response, result.getSuccess("删除员工成功!"));
			}else {
				PrintUtils.getJsonString(response, result.getSuccess("程序出现异常!请联系管理员!"));
			}
		}
	}
	/**
	 * 回显需要修改的员工信息
	 * @param pId
	 * @param model
	 * @return
	 */
	@RequestMapping("toUpdate")
	public String toUpdate(@RequestParam(value="pId",required=false)String pId,String currentPage,Model model) {
		//得到该用户信息
		Map<String,Object> map = new HashMap<>();
		Person person = null;
		map.put("pName", "");
		map.put("dId", "");
		List<Person> list = ps.getPerson(map);
		//循环遍历
		for(Person per : list) {
			if(per.getpId() == Integer.parseInt(pId)) {
				person = per;
			}
		}
		//查询该员工所有地址
		person.setAddress(as.getPersonAllAddress(Integer.parseInt(pId)));
		//查询所有部门信息
		List<Department> deList = ds.getDepartment();
		//查询角色
		List<Role> roleList = rs.getRole();
		//查询所有地址
		List<Address> addressList = as.getAddress();
		//存储
		model.addAttribute("person",person);
		model.addAttribute("deList",deList);
		model.addAttribute("roleList",roleList);
		model.addAttribute("addressList",addressList);
		model.addAttribute("currentPage",currentPage);
		return "person/addorupdate";
	}
	/**
	 * 添加员工页面
	 * @return
	 */
	@RequestMapping("toAdd")
	public String toAdd(Model model) {
		//查询所有部门信息
		List<Department> deList = ds.getDepartment();
		//查询角色
		List<Role> roleList = rs.getRole();
		//查询所有地址
		List<Address> addressList = as.getAddress();
		//存储
		model.addAttribute("deList",deList);
		model.addAttribute("roleList",roleList);
		model.addAttribute("addressList",addressList);
		return "person/addorupdate";
	}
	/**
	 * 保存修改
	 * @param person
	 * @param addressId
	 * @param newAddress
	 * @param rId
	 * @param dId
	 */
	@RequestMapping(value="saveUpdate",method=RequestMethod.POST)
	public void saveUpdate(@ModelAttribute Person person,String addressId,
			String newAddress,String rId,String dId,HttpServletResponse response) {
		//判断已存地址不为空
		if(!addressId.equals("")) {
			//给该员工绑定已存地址
			ps.addPerson_Address(person.getpId(), Integer.parseInt(addressId));
		}
		Address address = new Address();
		//判断新增地址不为空
		if(!newAddress.equals("")) {
			//新增地址
			address.setAddressName(newAddress);
			address.setCreateDate("2020-6-18");
			as.addNewAddress(address);
			ps.addPerson_Address(person.getpId(), address.getAddressId());
		}
		//修改员工角色
		ps.updatePerson_Role(person.getpId(), Integer.parseInt(rId));
		//修改员工部门
		ps.updatePerson_Department(person.getpId(),Integer.parseInt(dId));
		//修改用户
		int count = ps.updatePerson(person);
		ReturnResult result = new ReturnResult();
		if(count > 0) {
			PrintUtils.getJsonString(response, result.getSuccess("修改员工成功!"));
		}else {
			PrintUtils.getJsonString(response, result.getFail("系统出现异常!请联系管理员!"));
		}
	}
	/**
	 * 删除指定员工指定地址
	 * @param pId
	 * @param addressId
	 * @param response
	 */
	@RequestMapping("delAddress")
	public void delAddress(String pId,String addressId,HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		//得到员工地址数
		int addressNum = as.checkPerson_addressNum(Integer.parseInt(pId));
		//必须保证员工有一个地址
		if(addressNum == 1) {
			PrintUtils.getJsonString(response, result.getFail("员工必须有一个地址!"));
		}else {
			int count = as.delPerson_address(Integer.parseInt(pId), Integer.parseInt(addressId));
			if(count > 0) {
				PrintUtils.getJsonString(response, result.getSuccess("删除成功!即将刷新页面!"));
			}else {
				PrintUtils.getJsonString(response, result.getSuccess("系统出现异常!请联系管理员!"));
			}
		}
	}
	/**
	 * 判断员工是否存在某个地址
	 * @param pId
	 * @param dId
	 * @param response
	 */
	@RequestMapping(value="checkAddress",method=RequestMethod.POST)
	public void checkAddress(@RequestParam(value="pId",required=false)String pId,String dId
			,HttpServletResponse response) {
		boolean flag = false;
		ReturnResult result = new ReturnResult();
		if(null != pId) {
			//判断该员工是否存在该地址
			List<Address> list = as.getPerson_address(Integer.parseInt(pId));
			for(Address address : list) {
				if(address.getAddressId() == Integer.parseInt(dId)) {
					flag = true;
				}
			}
			if(flag) {
				PrintUtils.getJsonString(response, result.getFail("该员工已存在该地址!"));
			}else {
				PrintUtils.getJsonString(response, result.getSuccess("可以使用!"));
			}
		}
	}
	/**
	 * 判断员工用户名是否存在
	 * @param pLoginName
	 * @param response
	 */
	@RequestMapping(value="checkName",method=RequestMethod.POST)
	public void checkLoginName(@RequestParam(value="pLoginName",required=false)String pLoginName,HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		int count = ps.checkLoginName(pLoginName);
		if(count > 0) { //已存在无法使用
			PrintUtils.getJsonString(response, result.getFail("该用户名已经存在,无法使用!"));
		}else {
			PrintUtils.getJsonString(response, result.getSuccess("用户名可以使用!"));
		}
	}
	/**
	 * 添加员工信息
	 * @param person
	 * @param addressId
	 * @param newAddress
	 * @param rId
	 * @param dId
	 */
	@RequestMapping(value="addPerson",method=RequestMethod.POST)
	public void addPerson(@ModelAttribute Person person,String addressId,
			String newAddress,String rId,String dId,HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		int count = ps.addPerson(person);
		//判断已存地址不为空
		if(!addressId.equals("")) {
			//给该员工绑定已存地址
			ps.addPerson_Address(person.getpId(), Integer.parseInt(addressId));
		}
		Address address = new Address();
		//判断新增地址不为空
		if(!newAddress.equals("")) {
			//新增地址
			address.setAddressName(newAddress);
			address.setCreateDate(person.getpDate());
			as.addNewAddress(address);
			ps.addPerson_Address(person.getpId(), address.getAddressId());
		}
		//绑定员工部门
		ps.addPerson_department(person.getpId(), Integer.parseInt(dId));
		//绑定员工角色
		ps.addPerson_role(person.getpId(), Integer.parseInt(rId));
		
		if(count > 0) {
			PrintUtils.getJsonString(response, result.getSuccess("添加员工成功!"));
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
