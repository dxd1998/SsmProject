package com.dxd.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dxd.dao.PowerMapper;
import com.dxd.pojo.Power;
import com.dxd.pojo.Power2;
import com.dxd.service.PowerService;

/**
 * 员工权限 业务层实现类
 * @author 99266
 *
 */
@Service("powerService")
public class PowerServiceImpl implements PowerService{
	
	@Autowired
	private PowerMapper mapper;
	/**
	 * 根据员工权限,得到某个父节点的所有子节点
	 */
	public List<Power2> getPowerByChild(Map<String, Object> map) {
		return mapper.getPowerByChild(map);
	}
	/**
	 * 获得所有0级节点
	 */
	public List<Power> getPowerByZero() {
		return mapper.getPowerByZero();
	}
	/**
	 * 获得所有1级节点
	 */
	public List<Power> getPowerByOne() {
		return mapper.getPowerByOne();
	}
	/**
	 * 获得员工所有权限
	 */
	public List<Power> getPowerByPerson(Integer pId) {
		return mapper.getPowerByPerson(pId);
	}
	/**
	 * 删除指定员工所有权限
	 */
	public int delPersonAllPower(Integer pId) {
		return mapper.delPersonAllPower(pId);
	}
	/**
	 * 分配权限
	 */
	public int givePower(Integer pId, Integer powerId) {
		return mapper.givePower(pId, powerId);
	}
	/**
	 * 查询员工所有三级权限
	 */
	public List<Power2> getLevel3Power(Integer pId) {
		return mapper.getLevel3Power(pId);
	}
	/**
	 * 查询所有3级权限
	 */
	public List<Power2> getAllLevel3Power() {
		return mapper.getAllLevel3Power();
	}

}
