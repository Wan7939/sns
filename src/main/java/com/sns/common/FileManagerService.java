package com.sns.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManagerService {
	// WebMvcConfig도 같이 볼것 => 실제 저장된 파일과 이미지 패스릴 매핑해줌
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
												
	// 실제 이미지가 저장될 경로							// D:\박경완\6_spring_project\quiz\sns_workspace
	public final static String FILE_UPLOAD_PATH = "D:\\박경완\\6_spring_project\\quiz\\sns_workspace\\images/";
	
	public String saveFile(Integer userId, MultipartFile file) throws IOException {
		//  파일 디렉토리 경로 예	: marobiana_162099585780/apple.png
		//  파일명이 겹치지 않게 현재시간을 경로에 붙여준다.
		String directoryName = userId + "_" + System.currentTimeMillis() + "/";
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			logger.error("[파일업로드] 디렉토리 생성 실패" + directoryName + ", filePath : " + filePath);
			return null;
		} 
		
		// 파일 업로드: byte 단위로 업로드 된다.
		byte[] bytes = file.getBytes();
		Path path = Paths.get(filePath + file.getOriginalFilename()); // input에 올린 파일명이다.
		Files.write(path, bytes);
		
		// 이미지 URL path를 리턴한다.
		// 예) http://localhost/images/s1727060_1633346649040/dodo2.jpg
		return "/images/" + directoryName + file.getOriginalFilename();
	}
	
	public void deleteFile(String imagePath) throws IOException {

		// 실제경로 + 파라미터 => images 겹치기 때문에 한쪽(파라미터) /images/를 제거 해줌.
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));
		if (Files.exists(path)) {
			// 파일이 존재하면 삭제한다.
			Files.delete(path);
		}
		
		// 디렉토리 삭제
		path = path.getParent();
		if (Files.exists(path)) {
			// 디렉토리가 존재하면 삭제한다.
			Files.delete(path);
		}
	}
}