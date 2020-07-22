package com.dxd.pojo;

import java.util.List;

/**
 * 员工实体类
 * @author 99266
 *
 */
public class Person {
	private Integer pId;  //编号
	private String pName; //姓名
	private String pLoginName; //登录名
	private String pPassword; //登录密码
	private int pAge;  //年龄
	private String pSex; //性别
	private String pDate; //入职时间
	//所属部门
	private Department department;
	//员工身份
	private Role role;
	//员工地址表
	private List<Address> address;
	//员工根权限
	private List<Power> powerList;
	
	
	public List<Power> getPowerList() {
		return powerList;
	}
	public void setPowerList(List<Power> powerList) {
		this.powerList = powerList;
	}
	public List<Address> getAddress() {
		return address;
	}
	public void setAddress(List<Address> address) {
		this.address = address;
	}
	public Integer getpId() {
		return pId;
	}
	public void setpId(Integer pId) {
		this.pId = pId;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpLoginName() {
		return pLoginName;
	}
	public void setpLoginName(String pLoginName) {
		this.pLoginName = pLoginName;
	}
	public String getpPassword() {
		return pPassword;
	}
	public void setpPassword(String pPassword) {
		this.pPassword = pPassword;
	}
	public int getpAge() {
		return pAge;
	}
	public void setpAge(int pAge) {
		this.pAge = pAge;
	}
	public String getpSex() {
		return pSex;
	}
	public void setpSex(String pSex) {
		this.pSex = pSex;
	}
	public String getpDate() {
		return pDate;
	}
	public void setpDate(String pDate) {
		this.pDate = pDate;
	}
	public Department getDepartment() {
		return department;
	}
	public void setDepartment(Department department) {
		this.department = department;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	
}
