package com.sns.timeline.model;

import java.util.List;

import com.sns.comment.model.Comment;
import com.sns.post.model.Post;


public class Content {
	private Post post;
	private List<Comment> commentList;

	
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
	public List<Comment> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}
	
	
	
}
