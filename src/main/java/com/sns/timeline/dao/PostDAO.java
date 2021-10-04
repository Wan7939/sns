package com.sns.timeline.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sns.timeline.model.Post;

@Repository
public interface PostDAO {
	
	public List<Post> selectPostList(int userId);
}
