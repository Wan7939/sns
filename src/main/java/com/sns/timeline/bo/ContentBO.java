package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.bo.CommentBO;
import com.sns.comment.model.Comment;
import com.sns.post.bo.PostBO;
import com.sns.post.model.Post;
import com.sns.timeline.model.Content;

@Service
public class ContentBO {
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private CommentBO commentBO;
	
	public List<Content> getContentList(Integer userId) {
		List<Content> contentList = new ArrayList<>();
		
		// Post 목록
		List<Post> postList = postBO.getPostList();
		for (Post post : postList) {
			Content content = new Content();
			content.setPost(post);
			
			// Post의 댓글 - Comment 목록
			List<Comment> commentList = commentBO.getCommentList(post.getId());
			content.setCommentList(commentList);
			
			contentList.add(content);
		}
		
		return contentList;
	}
}