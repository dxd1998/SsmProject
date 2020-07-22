package com.dxd.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dxd.dao.PersonMapper;
import com.dxd.pojo.Person;
import com.dxd.service.PersonService;

/**
 * 员工业务层 实现类
 * @author 99266
 *
 */
@Service("personService")
public class PersonServiceImpl implements PersonService{
	@Autowired
	private PersonMapper personMapper;
	
	/**
	 * 查询所有员工,条件查询,分页
	 */
	public List<Person> getPerson(Map<String, Object> map) {
		return personMapper.getPerson(map);
	}

	/**
	 * 根据条件动态查询员工信息数
	 */
	public int getPersonCount(Map<String, Object> map) {
		return personMapper.getPersonCount(map).size();
	}

	
	/**
	 * 删除指定用户
	 */
	public int delPerson(Integer pId) {
		return personMapper.delPerson(pId);
	}

	/**
	 * 删除指定用户地址
	 */
	public int delPerson_Address(Integer pId) {
		return personMapper.delPerson_Address(pId);
	}

	/**
	 * 删除指定用户身份
	 */
	public int delPerson_role(Integer pId) {
		return personMapper.delPerson_role(pId);
	}

	/**
	 * 删除指定用户部门
	 */
	public int delPerson_Department(Integer pId) {
		return personMapper.delPerson_Department(pId);
	}

	/**
	 * 删除指定用户请假记录
	 */
	public int delPerson_leave(Integer pId) {
		return personMapper.delPerson_leave(pId);
	}

	/**
	 * 删除指定用户考勤记录
	 */
	public int delPerson_check(Integer pId) {
		return personMapper.delPerson_check(pId);
	}

	/**
	 * 修改员工信息
	 */
	public int updatePerson(Person person) {
		return personMapper.updatePerson(person);
	}

	/**
	 * 修改员工角色
	 */
	public int updatePerson_Role(Integer pId, Integer rId) {
		return personMapper.updatePerson_Role(pId, rId);
	}

	/**
	 * 修改员工部门
	 */
	public int updatePerson_Department(Integer pId, Integer dId) {
		return personMapper.updatePerson_Department(pId, dId);
	}

	/**
	 * 绑定指定员工地址
	 */
	public int addPerson_Address(Integer pId, Integer aId) {
		return personMapper.addPerson_Address(pId, aId);
	}

	/**
	 * 判断员工用户名是否存在
	 */
	public int checkLoginName(String pLoginName) {
		return personMapper.checkLoginName(pLoginName);
	}

	/**
	 * 添加员工
	 */
	public int addPerson(Person person) {
		return personMapper.addPerson(person);
	}

	/**
	 * 添加员工角色
	 */
	public int addPerson_role(Integer pId, Integer rId) {
		return personMapper.addPerson_role(pId, rId);
	}

	/**
	 * 添加员工部门
	 */
	public int addPerson_department(Integer pId, Integer dId) {
		return personMapper.addPerson_department(pId, dId);
	}

	/**
	 * 查找部门经理负责的部门id
	 */
	public int getDepartmentManager(Integer pId) {
		return personMapper.getDepartmentManager(pId);
	}

	/**
	 * 获得指定部门下所有员工
	 */
	public List<Person> getDepartmentPersonByDid(Map<String,Object> map) {
		return personMapper.getDepartmentPersonByDid(map);
	}

	/**
	 * 获得指定部门下员工数量
	 */
	public int getDepartmentPersonByDidCount(Integer dId) {
		return personMapper.getDepartmentPersonByDidCount(dId);
	}

}
