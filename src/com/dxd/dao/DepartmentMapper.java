package com.dxd.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.dxd.pojo.Department;

/**
 * 部门 dao接口
 * @author 99266
 *
 */
public interface DepartmentMapper {
	/**
	 * 查询所有部门信息
	 * @return
	 */
	public List<Department> getDepartment();
	/**
	 * 修改部门负责人
	 * @param pId
	 * @return
	 */
	public int updatePerson_department(@Param("newpId")Integer pId,@Param("oldpId")Integer pId2);
	/**
	 * 所有部门,条件查询,分页
	 * @param map
	 * @return
	 */
	public List<Department> getDepartmentDesc(Map<String,Object> map);
	/**
	 * 根据条件 部门条数
	 * @param map
	 * @return
	 */
	public int getDepartmentDescCount(Map<String,Object> map);
	/**
	 * 判断该部门下是否存在员工
	 * @param dId
	 * @return
	 */
	public int checkDepartmentOfPerson(Integer dId);
	/**
	 * 删除指定部门
	 * @param dId
	 * @return
	 */
	public int delDepartment(Integer dId);
	/**
	 * 修改指定部门
	 * @param department
	 * @return
	 */
	public int updateDepartment(Map<String,Object> map);
	/**
	 * 新增部门
	 * @param map
	 * @return
	 */
	public int addDepartment(Map<String,Object> map);
}
