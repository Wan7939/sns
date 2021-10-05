package com.sns.timeline;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.sns.timeline.bo.PostBO;

@RestController
public class TimelineRestController {
	
	@Autowired
	private PostBO postBO;
		@PostMapping("/timeline/timeline")
		public Map<String, Object> create(
				@RequestParam("content") String content,
				@RequestParam(value= "file", required = false) MultipartFile file,
				HttpServletRequest request) {
				
			// session에서 유저id 를 가져온다
			Map<String, Object> result = new HashMap<>();
			HttpSession session = request.getSession();
			Integer userId = (Integer) session.getAttribute("userId");
			String userName = (String) session.getAttribute("userName");
			
			
			
			
			
			result.put("result", "error");
			
			// DB에 인서트 BO  -> 유저id, userLoginId, content, file 
			int row = postBO.createPost(userId, userName, content, file);
			if (row > 0) {
				result.put("result", "success");
			} else {
				result.put("result", "error");
			}
			// 결과값 response
			return result;
		}
}

