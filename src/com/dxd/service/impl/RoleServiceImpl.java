package com.dxd.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dxd.dao.RoleMapper;
import com.dxd.pojo.Role;
import com.dxd.service.RoleService;

/**
 * 角色 业务层 实现类
 * @author 99266
 *
 */
@Service("roleService")
public class RoleServiceImpl implements RoleService{
	@Autowired
	private RoleMapper mapper;
	
	/**
	 * 查询所有角色
	 */
	public List<Role> getRole() {
		return mapper.getRole();
	}
	
}
