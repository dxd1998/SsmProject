package com.dxd.pojo;
/**
 * 请假记录 实体类
 * @author 99266
 *
 */
public class LeaveMessage {
	private Integer leaveId;
	private String leaveStart; //请假开始日
	private String leaveEnd; //请假结束日
	private Person person; //请假员工
	private Leave leave; //请假原因
	private Type type; //审批状态
	
	public Type getType() {
		return type;
	}
	public void setType(Type type) {
		this.type = type;
	}
	public Integer getLeaveId() {
		return leaveId;
	}
	public void setLeaveId(Integer leaveId) {
		this.leaveId = leaveId;
	}
	public String getLeaveStart() {
		return leaveStart;
	}
	public void setLeaveStart(String leaveStart) {
		this.leaveStart = leaveStart;
	}
	public String getLeaveEnd() {
		return leaveEnd;
	}
	public void setLeaveEnd(String leaveEnd) {
		this.leaveEnd = leaveEnd;
	}
	public Person getPerson() {
		return person;
	}
	public void setPerson(Person person) {
		this.person = person;
	}
	public Leave getLeave() {
		return leave;
	}
	public void setLeave(Leave leave) {
		this.leave = leave;
	}
	
	
	
}
