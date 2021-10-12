package com.sns.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.sns.comment.model.Comment;

@Repository
public interface CommentDAO {
	
	public List<Comment> selectCommentList(int postId);
	
	public int insertComment(
			@Param("userId") int userId, 
			@Param("userName") String userName, 
			@Param("postId") int postId, 
			@Param("content") String content);
	
	public int deleteComment(int id);

	public int deleteCommentByPostId(int postId);
}
