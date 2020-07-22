package com.dxd.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dxd.pojo.Address;

/**
 * 地址 dao接口
 * @author 99266
 *
 */
public interface AddressMapper {
	/**
	 * 得到指定员工的所有地址
	 * @param pId
	 * @return
	 */
	public List<Address> getPersonAllAddress(Integer pId);
	/**
	 * 查询所有已存地址
	 * @return
	 */
	public List<Address> getAddress();
	/**
	 * 添加新地址并返回id
	 * @param address
	 * @return
	 */
	public int addNewAddress(Address address);
	/**
	 * 删除指定员工的指定地址
	 * @param pId
	 * @param dId
	 * @return
	 */
	public int delPerson_address(@Param("pId")Integer pId,@Param("addressId")Integer dId);
	/**
	 * 判断员工有几个地址
	 * @param pId
	 * @return
	 */
	public int checkPerson_addressNum(Integer pId);
	/**
	 * 得到指定员工的所有地址
	 * @param pId
	 * @return
	 */
	public List<Address> getPerson_address(Integer pId);
}
