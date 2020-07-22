package com.dxd.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.dxd.pojo.Person;
/**
 * 员工 业务层 接口
 * @author 99266
 *
 */
public interface PersonService {
	/**
	 * 所有员工,条件查询,分页
	 * @param map
	 * @return
	 */
	public List<Person> getPerson(Map<String,Object> map);
	/**
	 * 动态得到不能条件的员工信息数
	 * @param map
	 * @return
	 */
	public int getPersonCount(Map<String,Object> map);
	/**
	 * 删除指定员工
	 * @param pId
	 * @return
	 */
	public int delPerson(Integer pId);
	/**
	 * 删除指定员工地址信息
	 * @param pId
	 * @return
	 */
	public int delPerson_Address(Integer pId);
	/**
	 * 删除指定员工角色信息
	 * @param pId
	 * @return
	 */
	public int delPerson_role(Integer pId);
	/**
	 * 删除指定员工部门信息
	 * @param pId
	 * @return
	 */
	public int delPerson_Department(Integer pId);
	/**
	 * 删除指定员工请假记录
	 * @param pId
	 * @return
	 */
	public int delPerson_leave(Integer pId);
	/**
	 * 删除指定员工考勤记录
	 * @param pId
	 * @return
	 */
	public int delPerson_check(Integer pId);
	/**
	 * 修改员工信息
	 * @param person
	 * @return
	 */
	public int updatePerson(Person person);
	/**
	 * 修改员工角色
	 * @param pId
	 * @param rId
	 * @return
	 */
	public int updatePerson_Role(Integer pId,Integer rId);
	/**
	 * 修改员工部门
	 * @param pId
	 * @param dId
	 * @return
	 */
	public int updatePerson_Department(Integer pId,Integer dId);
	/**
	 * 绑定指定员工地址
	 * @param pId
	 * @param aId
	 * @return
	 */
	public int addPerson_Address(Integer pId,Integer aId);
	/**
	 * 判断该员工用户名是否存在
	 * @param pLoginName
	 * @return
	 */
	public int checkLoginName(String pLoginName);
	/**
	 * 添加员工
	 * @param person
	 * @return
	 */
	public int addPerson(Person person);
	/**
	 * 添加员工角色
	 * @param pId
	 * @param rId
	 * @return
	 */
	public int addPerson_role(@Param("pId")Integer pId,@Param("rId")Integer rId);
	/**
	 * 添加员工部门
	 * @param pId
	 * @param dId
	 * @return
	 */
	public int addPerson_department(@Param("pId")Integer pId,@Param("dId")Integer dId);
	
	/**
	 * 获得指定部门经理负责的部门
	 * @param pId
	 * @return
	 */
	public int getDepartmentManager(Integer pId);
	/**
	 * 获得指定部门下的所有员工
	 * @param dId
	 * @return
	 */
	public List<Person> getDepartmentPersonByDid(Map<String,Object> map);
	/**
	 * 获得指定部门下的员工数量
	 * @param dId
	 * @return
	 */
	public int getDepartmentPersonByDidCount(Integer dId);
}
