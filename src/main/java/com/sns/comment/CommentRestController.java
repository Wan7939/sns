package com.sns.comment;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sns.comment.bo.CommentBO;


@RestController
public class CommentRestController {

private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CommentBO commentBO;
	
	/**
	 * 댓글 쓰기
	 * @param postId
	 * @param content
	 * @param request
	 * @return
	 */
	@RequestMapping("/comment/create")
	public Map<String, Object> create(
			@RequestParam("postId") int postId,
			@RequestParam("content") String content,
			HttpServletRequest request) {
		
		Map<String, Object> result = new HashMap<>();
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		String userName = (String) session.getAttribute("userName");
		if (userId == null || userName == null) {
			result.put("result", "error");
			logger.error("[댓글쓰기] 로그인 세션이 없습니다.");
			return result;
		}
		
		int row = commentBO.createComment(userId, userName, postId, content);
		if (row > 0) {
			result.put("result", "success");
		} else {
			result.put("result", "error");
			logger.error("[댓글쓰기] 댓글쓰기 중 실패하였습니다.");
		}
		return result;
	}
	
	@DeleteMapping("/comment/delete")
	public Map<String, Object> delete(
			@RequestParam("commentId") int commentId){
		
		// DB 삭제
		commentBO.deleteComment(commentId);
		// 결과 리턴
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		return result;
	}
	
	
	
}