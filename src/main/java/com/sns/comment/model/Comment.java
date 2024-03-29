package com.sns.comment.model;

import java.util.Date;

public class Comment {
	private int id;  	// 댓글 번호
	private int postId;  	// 게시글 번호
	private int userId;  	// 댓글 작성자 (id)
	private String userName;  	// 댓글 작성자(이름)
	private String content;  	// 댓글 내용
	private Date createdAt;  	// 댓글 작성 일자
	private Date updatedAt;  	// 댓글 수정 일자
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	

}
