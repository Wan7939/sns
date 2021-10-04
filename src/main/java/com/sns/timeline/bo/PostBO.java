package com.sns.timeline.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.timeline.dao.PostDAO;
import com.sns.timeline.model.Post;

@Service
public class PostBO {
	
	@Autowired
	private PostDAO postDAO;
	
	public List<Post> getPostList(int userId){
		return postDAO.selectPostList(userId);
	}

}
