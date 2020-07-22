package com.dxd.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dxd.pojo.Person;
import com.dxd.pojo.Power;
import com.dxd.pojo.Power2;
import com.dxd.service.PersonService;
import com.dxd.service.PowerService;
import com.dxd.utils.PrintUtils;
import com.dxd.utils.ReturnResult;

/**
 * 权限控制器
 * @author 99266
 *
 */
@Controller
@RequestMapping("power/")
public class PowerController {
	
	@Autowired 
	private PowerService ps;
	@Autowired
	private PersonService pc;
	
	/**
	 * 显示权限修改页面
	 * @param model
	 * @return
	 */
	@RequestMapping("toPower")
	public String toPower(Model model) {
		Map<String,Object> map = new HashMap<>();
		map.put("pName", "");
		map.put("dId", "");
		//获得所有员工
		List<Person> personList = pc.getPerson(map);
		//获得所有二级权限
		List<Power> power1List = ps.getPowerByOne();
		//获得所有三级权限
		List<Power2> level3List = ps.getAllLevel3Power();
		//存储
		model.addAttribute("personList",personList);
		model.addAttribute("power1List",power1List);
		model.addAttribute("level3List",level3List);
		return "power/givePower";
	}
	/**
	 * 回显指定员工的权限
	 * @param pId
	 * @param response
	 */
	@RequestMapping(value="backPower",method=RequestMethod.POST)
	public void backPower(Integer personId,HttpServletResponse response) {
		StringBuffer sb = new StringBuffer("[");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//得到员工所有权限
		List<Power> personPower = ps.getPowerByPerson(personId);
		for(int i=0;i<personPower.size();i++) {
			Power power = personPower.get(i);
			sb.append("{\"powerId\":\""+power.getPowerId()+"\"}");
			if((i+1) != personPower.size()) {
				sb.append(",");
			}
		}
		sb.append("]");
		out.print(sb);
		out.flush();
		out.close();
	}
	/**
	 * 分配权限
	 * @param array
	 * @param pId
	 * @param response
	 */
	@RequestMapping(value="givePower",method=RequestMethod.POST)
	public void givePower(String[] array,Integer pId,HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		try {
			//删除该员工所有权限
			int count = ps.delPersonAllPower(pId);
			//分配新权限
			if(null != array && array.length != 0) {
				//循环添加权限
				for(int i=0;i<array.length;i++) {
					ps.givePower(pId,Integer.parseInt(array[i]));
				}
			}
			PrintUtils.getJsonString(response, result.getSuccess("分配权限成功!"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			PrintUtils.getJsonString(response, result.getFail("系统出现异常!请联系管理员!"));
		}
	}
}
