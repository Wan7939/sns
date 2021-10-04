package com.sns.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {
	// 요청 URL: http://localhost/user/sgin_up_view
	/**
	 * 회원가입
	 * @param model
	 * @return
	 */
	@RequestMapping("/sgin_up_view")
	public String signUpView(Model model) {
		model.addAttribute("viewName", "user/sign_up");
		return "template/layout";
	}
	/**
	 * 로그인
	 * @param model
	 * @return
	 */
	// 요청 URL: http://localhost/user/sign_in_view
				@RequestMapping("/sign_in_view")
				public String signInView(Model model) {
					model.addAttribute("viewName", "user/sign_in");
					return "template/layout";
				}
				/**
				 * 로그아웃
				 * @param request
				 * @return
				 */
				@RequestMapping("/sign_out")
				public String signOut(HttpServletRequest request) {
					HttpSession session = request.getSession();
					session.removeAttribute("userId");
					session.removeAttribute("userName");
					session.removeAttribute("userLoginId");
					return "redirect:/user/sign_in_view";
				}

}


