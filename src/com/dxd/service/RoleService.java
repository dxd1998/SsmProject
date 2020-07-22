package com.dxd.service;

import java.util.List;

import com.dxd.pojo.Role;
/**
 * 角色 业务层 接口
 * @author 99266
 *
 */
public interface RoleService {
	/**
	 * 查询所有角色
	 * @return
	 */
	public List<Role> getRole();
}
