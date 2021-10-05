package com.sns.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/images/**")  //  http://localhost/images/s1727060_1633346649040/dodo2.jpg
		.addResourceLocations("file:///D:\\박경완\\6_spring_project\\quiz\\sns_workspace\\images/"); // 실제 파일 저장 위치		
	}									
}
