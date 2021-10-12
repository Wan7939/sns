package com.sns.timeline;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.timeline.bo.ContentBO;
import com.sns.timeline.model.Content;

@Controller
public class TimelineContreoller {
	
	
	
	// @Autowired는 BO마다 하나하나 만들어 줘야함!
	// @Autowiredは　BOごとに一つずつ作ってくれる！
	@Autowired		
	private ContentBO contentBO;
	
	// 요청 URL: http://localhost/timeline/timeline_view
	@RequestMapping("/timeline/timeline_view")
	public String timeline(Model model) {
		List<Content> contentList = contentBO.getContentList(0);
		model.addAttribute("contentList", contentList);
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
		
}
