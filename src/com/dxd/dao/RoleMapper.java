package com.dxd.dao;

import java.util.List;

import com.dxd.pojo.Role;

/**
 * 角色dao接口
 * @author 99266
 *
 */
public interface RoleMapper {
	/**
	 * 查询所有角色
	 * @return
	 */
	public List<Role> getRole();
}
