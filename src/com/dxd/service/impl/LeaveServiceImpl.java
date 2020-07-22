package com.dxd.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dxd.dao.LeaveMapper;
import com.dxd.pojo.Leave;
import com.dxd.pojo.LeaveMessage;
import com.dxd.pojo.Type;
import com.dxd.service.LeaveService;

/**
 * 请假记录 业务层实现类
 * @author 99266
 *
 */
@Service("leaveService")
public class LeaveServiceImpl implements LeaveService{
	@Autowired
	private LeaveMapper mapper;
	
	/**
	 * 查询所有请假记录,条件查询,分页
	 */
	public List<LeaveMessage> getLeave(Map<String, Object> map) {
		return mapper.getLeave(map);
	}

	/**
	 * 根据条件得到请假记录条数
	 */
	public int getLeaveCount(Map<String, Object> map) {
		return mapper.getLeaveCount(map);
	}

	/**
	 * 得到所有处理类型
	 */
	public List<Type> getType() {
		return mapper.getType();
	}

	/**
	 * 删除指定请假记录
	 */
	public int delLeave(Integer leaveId) {
		return mapper.delLeave(leaveId);
	}

	/**
	 * 修改审核状态
	 */
	public int updateLeaveType(Map<String, Object> map) {
		return mapper.updateLeaveType(map);
	}

	/**
	 * 获得所有请假类型
	 */
	public List<Leave> getLeaveType() {
		return mapper.getLeaveType();
	}

	/**
	 * 新增请假记录
	 */
	public int addLeave(Map<String, Object> map) {
		return mapper.addLeave(map);
	}

}
