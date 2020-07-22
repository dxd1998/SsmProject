package com.dxd.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dxd.dao.DepartmentMapper;
import com.dxd.pojo.Department;
import com.dxd.service.DepartmentService;

/**
 * 部门 业务层实现类
 * @author 99266
 *
 */
@Service("departmentService")
public class DepartmentServiceImpl implements DepartmentService{
	@Autowired
	private DepartmentMapper mapper;
	
	/**
	 * 查询所有部门信息
	 */
	public List<Department> getDepartment() {
		return mapper.getDepartment();
	}

	/**
	 * 修改部门负责人
	 */
	public int updatePerson_department(Integer pId, Integer pId2) {
		return mapper.updatePerson_department(pId, pId2);
	}

	/**
	 * 查询所有部门,条件查询,分页
	 */
	public List<Department> getDepartmentDesc(Map<String, Object> map) {
		return mapper.getDepartmentDesc(map);
	}

	/**
	 * 根据条件查询部门数量
	 */
	public int getDepartmentDescCount(Map<String, Object> map) {
		return mapper.getDepartmentDescCount(map);
	}

	/**
	 * 删除指定部门
	 */
	public int delDepartment(Integer dId) {
		return mapper.delDepartment(dId);
	}

	/**
	 * 判断该部门下是否存在员工
	 */
	public int checkDepartmentOfPerson(Integer dId) {
		return mapper.checkDepartmentOfPerson(dId);
	}

	/**
	 * 修改部门信息
	 */
	public int updateDepartment(Map<String,Object> map) {
		return mapper.updateDepartment(map);
	}

	/**
	 * 新增部门
	 */
	public int addDepartment(Map<String, Object> map) {
		return mapper.addDepartment(map);
	}

}
