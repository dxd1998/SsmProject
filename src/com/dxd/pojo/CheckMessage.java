package com.dxd.pojo;
/**
 * 考勤记录 实体类
 * @author 99266
 *
 */
public class CheckMessage {
	private Integer checkId;
	private String checkDate;
	private Person person; //被考勤员工
	private Check check; //考勤状态
	
	public Integer getCheckId() {
		return checkId;
	}
	public void setCheckId(Integer checkId) {
		this.checkId = checkId;
	}
	public String getCheckDate() {
		return checkDate;
	}
	public void setCheckDate(String checkDate) {
		this.checkDate = checkDate;
	}
	public Person getPerson() {
		return person;
	}
	public void setPerson(Person person) {
		this.person = person;
	}
	public Check getCheck() {
		return check;
	}
	public void setCheck(Check check) {
		this.check = check;
	}
	
}
