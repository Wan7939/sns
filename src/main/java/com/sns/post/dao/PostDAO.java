package com.sns.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.sns.post.model.Post;



@Repository
public interface PostDAO {
	
	public List<Post> selectPostList();

	public int insertPost(
			@Param("userId") int userId,
			@Param("userName") String userName,
			@Param("content") String content,
			@Param("imagePath") String imagePath);
	
	public Post selectPost(int id);
	
	public void deletePost(int id);

}

