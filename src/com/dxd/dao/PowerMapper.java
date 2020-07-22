package com.dxd.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.dxd.pojo.Power;
import com.dxd.pojo.Power2;

/**
 * 权限接口
 * @author 99266
 *
 */
public interface PowerMapper {
	/**
	 * 得到某个父节点的所有子节点
	 * @param parentId
	 * @return
	 */
	public List<Power2> getPowerByChild(Map<String,Object> map);
	/**
	 * 得到所有1级节点
	 * @return
	 */
	public List<Power> getPowerByZero();
	/**
	 * 查询所有2级节点
	 * @return
	 */
	public List<Power> getPowerByOne();
	/**
	 * 查询该员工所有权限
	 * @param pId
	 * @return
	 */
	public List<Power> getPowerByPerson(Integer pId);
	/**
	 * 删除员工所有权限
	 * @param pId
	 * @return
	 */
	public int delPersonAllPower(Integer pId);
	/**
	 * 分配指定员工权限
	 * @param pId
	 * @param powerId
	 * @return
	 */
	public int givePower(@Param("pId")Integer pId,@Param("powerId")Integer powerId);
	/**
	 *查询该员工所有3级权限
	 */
	public List<Power2> getLevel3Power(Integer pId);
	/**
	 * 获得所有三级权限
	 * @return
	 */
	public List<Power2> getAllLevel3Power();
}
