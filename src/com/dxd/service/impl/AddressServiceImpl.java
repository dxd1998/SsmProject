package com.dxd.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dxd.dao.AddressMapper;
import com.dxd.pojo.Address;
import com.dxd.service.AddressService;

/**
 * 地址 业务层 实现类
 * @author 99266
 *
 */
@Service("addressService")
public class AddressServiceImpl implements AddressService{
	@Autowired
	private AddressMapper mapper;
	
	/**
	 * 查询指定员工的所有地址
	 */
	public List<Address> getPersonAllAddress(Integer pId) {
		return mapper.getPersonAllAddress(pId);
	}

	/**
	 * 查询所有已存地址
	 */
	public List<Address> getAddress() {
		return mapper.getAddress();
	}

	/**
	 * 添加新地址并返回id
	 */
	public int addNewAddress(Address address) {
		return mapper.addNewAddress(address);
	}

	/**
	 * 删除指定员工指定地址
	 */
	public int delPerson_address(Integer pId, Integer dId) {
		return mapper.delPerson_address(pId, dId);
	}

	/**
	 * 得到指定员工地址数量
	 */
	public int checkPerson_addressNum(Integer pId) {
		return mapper.checkPerson_addressNum(pId);
	}

	/**
	 * 查找指定员工的所有地址
	 */
	public List<Address> getPerson_address(Integer pId) {
		return mapper.getPerson_address(pId);
	}

}
