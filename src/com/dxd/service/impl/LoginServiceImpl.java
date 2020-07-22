package com.dxd.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dxd.dao.LoginMapper;
import com.dxd.pojo.Person;
import com.dxd.service.LoginService;

/**
 * 登录 业务层实现类
 * @author 99266
 *
 */
@Service("loginService")
public class LoginServiceImpl implements LoginService{
	@Autowired
	private LoginMapper loginmapper;
	
	/**
	 * 登录
	 */
	public Person checkLogin(String pLoginName) {
		return loginmapper.checkLogin(pLoginName);
	}
	
}
