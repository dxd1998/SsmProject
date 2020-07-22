package com.dxd.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dxd.dao.LabelMapper;
import com.dxd.pojo.Power2;
import com.dxd.service.LabelService;

/**
 * 业务层实现类 快捷标签
 * @author 99266
 *
 */
@Service("labelService")
public class LabelServiceImpl implements LabelService{
	@Autowired
	private LabelMapper mapper;
	
	/**
	 * 得到员工所有快捷标签
	 */
	public List<Power2> getLabelLevel2(Integer pId) {
		return mapper.getLabelLevel2(pId);
	}

	/**
	 * 绑定新的快捷标签
	 */
	public int insertLabel(Map<String, Object> map) {
		return mapper.insertLabel(map);
	}

	/**
	 * 删除员工所有快捷标签
	 */
	public int delLabel(Integer pId) {
		return mapper.delLabel(pId);
	}

}
