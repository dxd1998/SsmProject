package com.dxd.service;

import java.util.List;
import java.util.Map;

import com.dxd.pojo.Power2;

/**
 * 快捷标签 service 接口
 * @author 99266
 *
 */
public interface LabelService {
	/**
	 * 得到该用户所有快捷标签
	 * @param pId
	 * @return
	 */
	public List<Power2> getLabelLevel2(Integer pId);
	/**
	 * 绑定新标签
	 * @param map
	 * @return
	 */
	public int insertLabel(Map<String,Object> map);
	/**
	 * 删除员工所有标签
	 * @param pId
	 * @return
	 */
	public int delLabel(Integer pId);
}
