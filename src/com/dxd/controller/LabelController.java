package com.dxd.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dxd.service.LabelService;
import com.dxd.utils.PrintUtils;
import com.dxd.utils.ReturnResult;

/**
 * 快捷标签 控制器
 * @author 99266
 *
 */
@Controller
@RequestMapping("label/")
public class LabelController {
	@Autowired
	private LabelService ls;
	/**
	 * 修改快捷标签
	 * @param labels
	 * @param pId
	 * @param response
	 */
	@RequestMapping(value="saveLabel",method=RequestMethod.POST)
	public void updateLabel(String[] labels,int pId,HttpServletResponse response) {
		ReturnResult result = new ReturnResult();
		Map<String,Object> map = new HashMap<>();
		//清空该用户所有快捷标签
		int count = ls.delLabel(pId);
		int count2 = 0;
		map.put("pId", pId);
		//循环添加新的快捷标签
		if(labels != null && labels.length != 0) {
			for(String aa : labels) {
				map.put("powerId", Integer.parseInt(aa));
				count2= ls.insertLabel(map);
			}
		}
		if(count2 > 0) {
			PrintUtils.getJsonString(response, result.getSuccess("修改快捷标签成功!"));
		}else {
			PrintUtils.getJsonString(response, result.getFail("系统出现异常!请联系管理员!"));
		}
	}
}
