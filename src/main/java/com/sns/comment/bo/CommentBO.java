package com.sns.comment.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.dao.CommentDAO;
import com.sns.comment.model.Comment;

@Service
public class CommentBO {
	@Autowired
	private CommentDAO commentDAO;
	
	public List<Comment> getCommentList(int postId) {
		return commentDAO.selectCommentList(postId);
	}
	
	public int createComment(int userId, String userName, int postId, String content) {
		return commentDAO.insertComment(userId, userName, postId, content);
	}
	
	public int deleteComment(int id) {
		return commentDAO.deleteComment(id);
	}
	
	public int deleteCommentByPostId(int postId) {
		return commentDAO.deleteCommentByPostId(postId);
		
	}

}
