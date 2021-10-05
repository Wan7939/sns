package com.sns.timeline.bo;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.common.FileManagerService;
import com.sns.timeline.dao.PostDAO;
import com.sns.timeline.model.Post;

@Service
public class PostBO {
	
	@Autowired
	private PostDAO postDAO;
		
	@Autowired
	private FileManagerService fileManagerService;
	
	public List<Post> getPostList(int userId){
		return postDAO.selectPostList(userId);
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

	
}