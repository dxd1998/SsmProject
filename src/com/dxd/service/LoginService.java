package com.dxd.service;

import com.dxd.pojo.Person;

/**
 * 登录 业务层 接口
 * @author 99266
 *
 */
public interface LoginService {
	/**
	 * 验证登录
	 * @param pLoginName
	 * @return
	 */
	public Person checkLogin(String pLoginName);
}
