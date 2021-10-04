<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="d-flex justify-content-center">
	<div class="contents-box col-6">
	
			<%-- 글쓰기 영역 - 로그인 된 상태에서만 보임 --%>
		<c:if test="${not empty userId}">
			<%-- textarea의 테두리는 없애고 div에 테두리를 준다. --%>
			<div class="write-box border rounded m-3">
				<textarea id="writeTextArea" placeholder="내용을 입력해주세요" class="w-100 border-0"></textarea>
				
				<%-- 이미지 업로드를 위한 아이콘과 업로드 버튼을 한 행에 멀리 떨어뜨리기 위한 div --%>
				<div class="d-flex justify-content-between">
					<div class="file-upload d-flex">
						<%-- file 태그는 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것처럼 이벤트를 줄 것이다. --%>
						<input type="file" id="file" class="d-none" accept=".gif, .jpg, .png, .jpeg">
						<%-- 이미지에 마우스 올리면 마우스커서가 링크 커서가 변하도록 a 태그 사용 --%>
						<a href="#" id="fileUploadBtn"><img width="35" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>

						<%-- 업로드 된 임시 파일 이름 저장될 곳 --%>
						<div id="fileName" class="ml-2">
						</div>
					</div>
					<button id="writeBtn" class="btn btn-info">게시</button>
				</div>
			</div>
		</c:if>
	
	<%-- 타임라인 영역 --%>
		<div class="timeline-name-box my-5">
			<div class="card border rounded mt-3">
				
				<div class="p-2 d-flex justify-content-between bg-warning">
					<c:forEach var="post" items="${postList}">
						<span class="font-weight-bold"><%-- 작성자 아이디 --%>${post.userName}</span>
					</c:forEach>
					<a href="#" class="more-btn">
						<img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="30">
					</a>
				</div>
				<div class="card-img">
				<c:forEach var="post" items="${postList}">
					<img src="/static/images/dodo.jpg" class="w-100"> <%-- 게시물 사진 --%>
				</c:forEach>
				</div>
				<%-- 좋아요 --%>
				<div class="card-like m-3">
					<a href="#"><img src="https://cdn.pixabay.com/photo/2016/04/24/05/52/heart-1348869__340.png" width="18px" height="18px"></a>
					<a href="#">좋아요 <%-- 좋아요 갯수 --%>1025개</a>
				</div>
				<%-- 글(Post) --%>
				<div class="card-post m-3">
					<c:forEach var="post" items="${postList}">
						<span class="font-weight-bold"><%-- 작성자 아이디 --%>${post.userName}</span> 
					</c:forEach>
				<c:forEach var="post" items="${postList}">
				
					<span>
						${post.content}<%-- 글 내용 --%> 글 내용
					</span>
				</c:forEach>
				</div>
				<%-- 댓글(Comment) --%>
				
				<%-- "댓글" --%>
				<div class="card-comment-desc border-bottom bg-warning">
					<div class="ml-3 mb-1 font-weight-bold">댓글</div>
				</div>
				
				<div class="card-comment-list m-2">
					<%-- 댓글 목록 --%>
					<div class="card-comment m-1">
						<span class="font-weight-bold"><%-- 댓글쓴이 --%>댓글쓴이: </span>
						<span> <%-- 댓글 내용 --%> 댓글 내용</span>
						
						<%-- TODO: 댓글쓴이가 본인이면 삭제버튼 노출 
						<a href="#" class="commentDelBtn">
							<img src="https://www.iconninja.com/files/603/22/506/x-icon.png" width="10px" height="10px">
						</a> --%>
					</div>
					
					<div class="card-comment m-1">
						<span class="font-weight-bold"><%-- 댓글쓴이 --%>댓글쓴이: </span>
						<span> <%-- 댓글 내용 --%> 댓글 내용</span>
						<%-- TODO: 댓글쓴이가 본인이면 삭제버튼 노출
						<a href="#" class="commentDelBtn">
							<img src="https://www.iconninja.com/files/603/22/506/x-icon.png" width="10px" height="10px">
						</a> --%>
					</div>
				</div>
				
				<%-- 댓글 쓰기 --%>
				<%-- 로그인 된 상태에서만 쓸 수 있다. --%>
					<c:if test="${not empty userId}">
				
					<div class="comment-write d-flex border-top mt-2">
						<input type="text" id="commentText" class="form-control border-0 mr-2" placeholder="댓글 달기"/> 
						<button type="button" class="btn btn-light commentBtn">게시</button>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>
					

<script>
$(document).ready(function(){
	// 파일 업로드 이미지 버튼 클릭 => 파일 선택 창이 뜸
	$('#fileUploadBtn').on('click', function(e){
		e.preventDefault(); // 제일 위로 올라가는 동작 중지
		$('#file').click(); // 사용자가 input file을 클릭한 것과 같은 동작
	});
	
	// 사용자가 파일을 선택했을 때 => 파일명이 옆에 노출시킨다
	$('#file').on('change', function(e) {
		let fileName = e.target.files[0].name;
		console.log("fileName" + fileName);
		
		let fileNameArr = fileName.split('.');
		if (fileNameArr[fileNameArr.length - 1] != 'png'
				&& fileNameArr[fileNameArr.length - 1] !='gif'
				&& fileNameArr[fileNameArr.length - 1] !='jpg'
				&& fileNameArr[fileNameArr.length - 1] !='jpeg') {
			
			alert("이미지 파일만 업로드 할수있습니다.")
			$(this).val('');  // 올라가있는 잘못된 파일을 비워준다.
			$('#fileName').text('') // 잘못된 파일명도 비워준다.
			return;
		}
		
		$('#fileName').text(fileName); // 파일명을 div사이에 노출 시킨다
	});
});
</script>
		
		
		
		