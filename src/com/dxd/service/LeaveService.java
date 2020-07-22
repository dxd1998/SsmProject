package com.dxd.service;

import java.util.List;
import java.util.Map;

import com.dxd.pojo.Leave;
import com.dxd.pojo.LeaveMessage;
import com.dxd.pojo.Type;

/**
 * 请假记录 业务层 接口
 * @author 99266
 *
 */
public interface LeaveService {
	/**
	 * 查询所有请假记录,条件查询,分页
	 * @param map
	 * @return
	 */
	public List<LeaveMessage> getLeave(Map<String,Object> map);
	/**
	 * 根据条件查询请假记录条数
	 * @param map
	 * @return
	 */
	public int getLeaveCount(Map<String,Object> map);
	/**
	 * 获得所有处理类型
	 * @return
	 */
	public List<Type> getType();
	/**
	 * 获得所有请假类型
	 * @return
	 */
	public List<Leave> getLeaveType();
	/**
	 * 删除指定请假记录
	 * @param leaveId
	 * @return
	 */
	public int delLeave(Integer leaveId);
	/**
	 * 修改审核状态
	 * @param map
	 * @return
	 */
	public int updateLeaveType(Map<String,Object> map);
	/**
	 * 新增请假记录
	 * @param map
	 * @return
	 */
	public int addLeave(Map<String,Object> map);
}
