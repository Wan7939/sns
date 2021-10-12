package com.sns.post.bo;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.common.FileManagerService;
import com.sns.post.dao.PostDAO;
import com.sns.post.model.Post;

@Service
public class PostBO {
	
	private Logger logger = LoggerFactory.getLogger(PostBO.class);
	
	@Autowired
	private PostDAO postDAO;
	
		
	@Autowired
	private FileManagerService fileManagerService;
	
	public List<Post> getPostList() {
		return postDAO.selectPostList();
	}
		
		public int createPost(int userId, String userName, String content, MultipartFile file) {
			
			String imagePath = null;
			if (file != null) {
				try {
					imagePath = fileManagerService.saveFile(userId, file);
				} catch (IOException e) {
					imagePath = null;
				}
			}
			
			return postDAO.insertPost(userId, userName, content, imagePath);
			
		}
		
		public void deletePost(int postId) {
			
			Post post = postDAO.selectPost(postId);
			if (post == null) {
				logger.warn("[글 삭제] 이미 삭제되었습니다.");
				return;
			}
			
			// post 삭제
			postDAO.deletePost(postId);
			
			// image 삭제
			String imagePath = post.getImagePath();
			if (imagePath != null) {
				try {
					fileManagerService.deleteFile(imagePath);
				} catch (IOException e) {
					logger.warn("[삭제에 실패했습니다.] " + imagePath);
				}
			}
		}
		
}