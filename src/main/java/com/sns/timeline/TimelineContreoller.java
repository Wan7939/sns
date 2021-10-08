package com.sns.timeline;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.timeline.bo.PostBO;
import com.sns.timeline.model.Post;

@Controller
public class TimelineContreoller {
	
	
	
	// @Autowired는 BO마다 하나하나 만들어 줘야함!
	// @Autowiredは　BOごとに一つずつ作ってくれる！
	@Autowired		
	private PostBO postBO;
	
	// 요청 URL: http://localhost/timeline/timeline_view
	@RequestMapping("/timeline/timeline_view")
	public String timeline(Model model) {
		List<Post> postList = postBO.getPostList(0);
		model.addAttribute("postList", postList);
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
		
}
