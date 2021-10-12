package com.sns.post;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.sns.post.bo.PostBO;

@RestController
public class PostRestController {
	
	@Autowired
	private PostBO postBO;
	@RequestMapping("/post/create")
		public Map<String, Object> create(
				@RequestParam("content") String content,
				@RequestParam(value= "file", required = false) MultipartFile file,
				HttpServletRequest request) {
				
			// session에서 유저id 를 가져온다
			// sessionで ユーザid を 持ってくる
			Map<String, Object> result = new HashMap<>();
			HttpSession session = request.getSession();
			Integer userId = (Integer) session.getAttribute("userId");
			String userName = (String) session.getAttribute("userName");
			
			
			
			
			
			result.put("result", "error");
			
			// DB에 인서트 BO  -> 유저id, userLoginId, content, file 
			// DBに insert BO  -> ユーザid, userLoginId, content, file 
			int row = postBO.createPost(userId, userName, content, file);
			if (row > 0) {
				result.put("result", "success");
			} else {
				result.put("result", "error");
			}
			// 결과값 response
			// 結果の値 response
			return result;
		}
		@PostMapping("/post/delete")
		public Map<String, Object> delete(
				@RequestParam("postId") int postId) {
			
			// DB postId 데이터 삭제
			// DB postIdデータの削除
			postBO.deletePost(postId);
			
			// 결과 리턴
			// 結果のreturn
			Map<String, Object> result = new HashMap<>();
			result.put("result", "success");
			
			return result;
		}
	
		
}

