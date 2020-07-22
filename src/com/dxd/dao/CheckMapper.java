package com.dxd.dao;

import java.util.List;
import java.util.Map;

import com.dxd.pojo.Check;
import com.dxd.pojo.CheckMessage;

/**
 * 考勤记录 dao接口
 * @author 99266
 *
 */
public interface CheckMapper {
	/**
	 * 查询所有考勤记录
	 * @param map
	 * @return
	 */
	public List<CheckMessage> getCheck(Map<String,Object> map);
	/**
	 * 动态查询考勤记录数
	 * @param map
	 * @return
	 */
	public int getCheckCount(Map<String,Object> map);
	/**
	 * 获得所有请假类型
	 * @return
	 */
	public List<Check> getCheckType();
	/**
	 * 删除指定记录
	 * @param checkId
	 * @return
	 */
	public int delCheck(Integer checkId);
	/**
	 * 添加记录
	 * @param map
	 * @return
	 */
	public int addCheck(Map<String,Object> map);
}
