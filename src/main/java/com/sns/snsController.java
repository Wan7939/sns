package com.sns;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class snsController {
	// 요청 URL: http://localhost/user/sgin_in_view1
	@RequestMapping("/user/sgin_in_view1")
	public String memo() {
		return "sns/login";
	}
	

	// 요청 URL: http://localhost/user/sgin_in_view1
		@RequestMapping("/user/sgin_up_view1")
		public String join() {
			return "sns/join";
		}
	
}
