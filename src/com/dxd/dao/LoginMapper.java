package com.dxd.dao;

import com.dxd.pojo.Person;

/**
 * 登录 dao接口
 * @author 99266
 *
 */
public interface LoginMapper {
	/**
	 * 验证登录
	 * @param pLoginName
	 * @return
	 */
	public Person checkLogin(String pLoginName);
}
