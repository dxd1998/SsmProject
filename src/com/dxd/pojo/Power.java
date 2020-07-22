package com.dxd.pojo;

import java.io.Serializable;
import java.util.List;

/**
 * 员工一级权限
 * @author 99266
 *
 */
public class Power implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7741036305639529457L;
	private int powerId;
	private String powerName;
	private int parentId;
	private int type;
	private String powerDesc;
	//二级权限
	private List<Power2> childPower;
	//三级权限
	private List<Power2> level3Power;
	
	public List<Power2> getLevel3Power() {
		return level3Power;
	}
	public void setLevel3Power(List<Power2> level3Power) {
		this.level3Power = level3Power;
	}
	public String getPowerDesc() {
		return powerDesc;
	}
	public void setPowerDesc(String powerDesc) {
		this.powerDesc = powerDesc;
	}
	
	
	public List<Power2> getChildPower() {
		return childPower;
	}
	public void setChildPower(List<Power2> childPower) {
		this.childPower = childPower;
	}
	public int getPowerId() {
		return powerId;
	}
	public void setPowerId(int powerId) {
		this.powerId = powerId;
	}
	public String getPowerName() {
		return powerName;
	}
	public void setPowerName(String powerName) {
		this.powerName = powerName;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	
	
}
