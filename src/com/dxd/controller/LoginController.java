package com.dxd.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dxd.pojo.Person;
import com.dxd.pojo.Power;
import com.dxd.pojo.Power2;
import com.dxd.service.LabelService;
import com.dxd.service.LoginService;
import com.dxd.service.PowerService;
import com.dxd.utils.PrintUtils;
import com.dxd.utils.ReturnResult;

/**
 * 登录 控制器
 * @author 99266
 *
 */
@Controller
@RequestMapping("login/")
public class LoginController {
	@Autowired
	private LoginService ls;
	
	@Autowired
	private PowerService ps;
	
	@Autowired
	private LabelService le;
	
	/**
	 * 验证登录   ajax
	 * @param loginName
	 * @param pPassword
	 * @param model
	 * @return
	 */
	@RequestMapping("checkLogin")
	public void checkLogin(@RequestParam(value="pLoginName",required=false)String loginName
			,@RequestParam(value="pPassword",required=false)String pPassword,
			@RequestParam(value="flag",required=false) String flag,Model model,HttpServletResponse response,HttpServletRequest request) {
		String contextPath = request.getContextPath();
		//得到当前用户名对应的对象
		Person person = ls.checkLogin(loginName);
		ReturnResult result = new ReturnResult();
		//判断是否为空
		if(null == person) {
			PrintUtils.getJsonString(response, result.getFail("登录错误!请核对后再试!"));
		}else {
			//判断密码
			if(!person.getpPassword().equals(pPassword)) {
				PrintUtils.getJsonString(response, result.getFail("密码错误!请核对后再试!"));
			}else {
				Map<String,Object> map = new HashMap<>();
				map.put("pId", person.getpId());
				//得到该员工绑定的所有子权限
				List<Power> parentPower = ps.getPowerByZero();  //获得所有0级节点
				for(Power po : parentPower) {
					map.put("parentId",po.getPowerId());
					//得到该员工1级权限下所有2级权限
					List<Power2> childList = ps.getPowerByChild(map);
					po.setChildPower(childList);
					//得到该员工所有三级权限
					List<Power2> level3Power = ps.getLevel3Power(person.getpId());
					po.setLevel3Power(level3Power);
					
				}
				//将员工对应的权限赋值
				person.setPowerList(parentPower);
				//存储该对象到Session中
				request.getSession().setAttribute("loginUser", person);
				//得到该员工所有快捷标签
				List<Power2> labelList = le.getLabelLevel2(person.getpId());
				request.getSession().setAttribute("labelList", labelList);
				//得到该员工所有二级权限
				List<Power> level2List = ps.getPowerByOne();
				request.getSession().setAttribute("level2List", level2List);
				if(flag != null && flag.equals("1")) {
					try {
						response.sendRedirect(contextPath+"/spring/login/index");
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				PrintUtils.getJsonString(response, result.getSuccess("登录成功!"));
			}
		}
	}
	/**
	 * 退出登录
	 * @return
	 */
	@RequestMapping("exit")
	public String toExit(HttpServletRequest request) {
		//清空该作用域
		request.getSession().removeAttribute("loginUser");
		request.getSession().removeAttribute("labelList");
		request.getSession().removeAttribute("level2List");
		return "Login";
	}
	
	/**
	 * 跳转至登录页面
	 * @return
	 */
	@RequestMapping("")
	public String toLogin() {
		return "Login";
	}
	/**
	 * 跳转至首页
	 * @return
	 */
	@RequestMapping("index")
	public String toIndex() {
		return "index";
	}
}
