package com.dxd.pojo;

import java.io.Serializable;

/**
 * 员工 二级权限
 * @author 99266
 *
 */
public class Power2 implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2105257265104769642L;
	private int powerId;
	private String powerName;
	private int parentId;
	private int type;
	private String powerDesc;
	
	public String getPowerDesc() {
		return powerDesc;
	}
	public void setPowerDesc(String powerDesc) {
		this.powerDesc = powerDesc;
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
