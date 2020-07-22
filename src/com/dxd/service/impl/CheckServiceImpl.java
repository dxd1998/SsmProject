package com.dxd.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dxd.dao.CheckMapper;
import com.dxd.pojo.Check;
import com.dxd.pojo.CheckMessage;
import com.dxd.service.CheckService;

/**
 * 考勤 业务层实现类
 * @author 99266
 *
 */
@Service("checkService")
public class CheckServiceImpl implements CheckService{
	
	@Autowired
	private CheckMapper mapper;
	
	/**
	 * 查询所有考勤记录,条件查询,分页
	 */
	public List<CheckMessage> getCheck(Map<String, Object> map) {
		return mapper.getCheck(map);
	}

	/**
	 * 动态查询考勤记录数
	 */
	public int getCheckCount(Map<String, Object> map) {
		return mapper.getCheckCount(map);
	}

	/**
	 * 所有考勤类型
	 */
	public List<Check> getCheckType() {
		return mapper.getCheckType();
	}

	/**
	 * 删除指定记录
	 */
	public int delCheck(Integer checkId) {
		return mapper.delCheck(checkId);
	}

	/**
	 * 新增考勤记录
	 */
	public int addCheck(Map<String, Object> map) {
		return mapper.addCheck(map);
	}

}
