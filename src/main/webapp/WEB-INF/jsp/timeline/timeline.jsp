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
				<textarea id="content" placeholder="내용을 입력해주세요" class="w-100 border-0"></textarea>
				
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
		<%-- my: margin 위아래(y축) --%>
		<div class="timeline-box my-5">
			<%-- 반복문 --%>
			<c:forEach var="content" items="${contentList}">
			
				<%-- 카드 하나하나마다 영역을 border로 나눔 --%>
				<div class="card border rounded mt-3">
					
					<%-- 글쓴이 아이디 및 ... 버튼(삭제) : 이 둘을 한 행에 멀리 떨어뜨려 나타내기 위해 d-flex, between --%>
					<div class="p-2 d-flex justify-content-between">
						<span class="font-weight-bold">${content.post.userName}</span>
						
						<%-- 클릭할 수 있는 ... 버튼 이미지 --%>
						<%-- 로그인 된 사용자가 작성한 경우에만 버튼 노출 --%>
						<%-- 삭제될 글번호를 modal창에 넣기 위해 더보기 클릭시 이벤트에서 심어준다. --%>
						<c:if test="${userName eq content.post.userName}">							
							<a href="#" class="more-btn" data-toggle="modal" data-target="#moreModal" data-post-id="${content.post.id}">
								<img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="30">
							</a>
						</c:if>
					</div>
					
					<%-- 카드 이미지 --%>
					<div class="card-img">
						<%-- 이미지가 존재하는 경우에만 노출 --%>
						<c:if test="${not empty content.post.imagePath}">
							<img src="${content.post.imagePath}" class="w-100" alt="이미지">
						</c:if>
					</div>
					
					<%-- 좋아요 --%>
					
					<%-- 글(Post) --%>
					<div class="card-post m-3">
						<span class="font-weight-bold">${content.post.userName}</span> 
						<span>
							${content.post.content}
						</span>
					</div>
					
					<%-- 댓글(Comment) --%>
					
					<%-- "댓글" - 댓글이 있는 경우에만 댓글 영역 노출 --%>
					<c:if test="${not empty content.commentList}">
						<div class="card-comment-desc border-bottom">
							<div class="ml-3 mb-1 font-weight-bold">댓글</div>
						</div>
						<div class="card-comment-list m-2">
							<%-- 댓글 목록 --%>
							<c:forEach var="comment" items="${content.commentList}">
								<div class="card-comment m-1">
									<span class="font-weight-bold">${comment.userName} : </span>
									<span>${comment.content}</span>
									
									<%-- 댓글쓴이가 본인이면 삭제버튼 노출 --%>
									<c:if test="${userName eq comment.userName}">
										<a href="#" class="commentDelBtn" data-comment-id="${comment.id}">
											<img src="https://www.iconninja.com/files/603/22/506/x-icon.png" width="10px" height="10px">
										</a>
									</c:if>
								</div>
							</c:forEach>
						</div>
					</c:if>
					
					<%-- 댓글 쓰기 --%>
					<%-- 로그인 된 상태에서만 쓸 수 있다. --%>
					<c:if test="${not empty userId}">
						<div class="comment-write d-flex border-top mt-2">
							<input type="text" id="commentText${content.post.id}" class="form-control border-0 mr-2" placeholder="댓글 달기"/> 
							<button type="button" class="btn btn-light commentBtn" data-post-id="${content.post.id}">게시</button>
						</div>
					</c:if>
				</div>
			</c:forEach>
		</div>
	</div>
</div>


<%-- 글 삭제를 위한 Modal Layer --%>
<div class="modal fade" id="moreModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<a href="#" class="del-post">삭제하기</a>

		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
						// 파일 업로드 이미지 버튼 클릭 => 파일 선택 창이 뜸
						$('#fileUploadBtn').on('click', function(e) {
							e.preventDefault(); // 제일 위로 올라가는 동작 중지
							$('#file').click(); // 사용자가 input file을 클릭한 것과 같은 동작
						});

						// 사용자가 파일을 선택했을 때 => 파일명이 옆에 노출시킨다
						$('#file').on('change',function(e) {
											let fileName = e.target.files[0].name;
											console.log("fileName" + fileName);

											let fileNameArr = fileName
													.split('.');
											if (fileNameArr[fileNameArr.length - 1] != 'png'
													&& fileNameArr[fileNameArr.length - 1] != 'gif'
													&& fileNameArr[fileNameArr.length - 1] != 'jpg'
													&& fileNameArr[fileNameArr.length - 1] != 'jpeg') {

												alert("이미지 파일만 업로드 할수있습니다.")
												$(this).val(''); // 올라가있는 잘못된 파일을 비워준다.
												$('#fileName').text('') // 잘못된 파일명도 비워준다.
												return;
											}

											$('#fileName').text(fileName); // 파일명을 div사이에 노출 시킨다
										});
					

	/// 게시글 올리기 
	// 글 내용 게시버튼 클릭
	$('#writeBtn').on('click', function() {
		let content = $('#content').val();
		console.log(content);
		if (content == '') {
			alert('내용을 입력해주세요.');
			return;
		}

		// 폼태그를 자바스크립트에서 만든다.
		let formData = new FormData();
		formData.append('content', content);
		formData.append('file', $('#file')[0].files[0]);
		
		

		// ajax
		$.ajax({
			type : 'post' // get은 body가 없어서 url로 받아버림 그래서 무조건 post로 해야함!
			,
			url : '/post/create',
			data : formData,
			enctype : 'mulitpart/form-data'// 파일 업로드 필수 설정
			,
			processData : false // 파일 업로드 필수 설정
			,
			contentType : false // 파일 업로드 필수 설정
			,
			success : function(data) {
				if (data.result == 'success') {
					alert("게시글이 저장 됐습니다.");
					location.href = "/timeline/timeline_view";

				}
			},
			error : function(e) {
				alert("게시글이 저장에 실패했습니다." + e);
			}
		});

	});
	
	

	// ... 버튼 클릭 (삭제를 하기 위해)
	$('.more-btn').on('click',function(e){
		e.preventDefault();
	
		
		
		// 포스트 아이디를 가져온다 => 지금 클릭된 태그의 포스트 아이디
		let postId = $(this).data('post-id');
		// alert(postId);
		// 모달에 포스트 아이디를 넣어준다
		$('#moreModal').data('post-id', postId)
		
		// 모달안에 있는 삭제하기 클릭
		$('#moreModal .del-post').on('click', function(e){
			e.preventDefault();
			
			let postId = $('#moreModal').data('post-id')
			// alert(postId);
			// 서버한테 글 삭제 요청(ajax)
			$.ajax({
				type: 'post'
				, url:'/post/delete'
				, data: {'postId' : postId}
				, success: function(data){
					if(data.result == 'success') {
						alert("삭제됐습니다.");
						location.reload(true);
					}
				}, error: function(e) {
					alert("게시글을 삭제하는데 실패했습니다" + e); 
				}
			});
		});
	});
	
		// 좋아요 클릭 - 좋아요/해제
		<%-- $('.like-btn').on('click', function(e){
			e.preventDefault();
			
			let postId = $(this).data('post-id');
			
			$.ajax({
				type:'post'
				, url:'/like/' + postId
				, success: function(data){
					if (data.result == 'success'){
						location.reload(true); 	// 새로고침
					}
				}, error: function(e){
					
				}
			});
			
			
		}); --%>
		// 댓글 쓰기
		$('.commentBtn').on('click', function(e) {
			e.preventDefault();
			
			let postId = $(this).data('post-id');
			alert(postId);
			
			let commentText = $('#commentText' + postId).val().trim(); // 글에 대한 댓글을 가져오기 위해 아이디 뒤에 동적으로 postId를 붙인다.
			if (commentText.length < 1) {
				alert("댓글 내용을 입력해주세요.");
				return;
			}
			
			$.ajax({
				type:'post',
				url:'/comment/create',
				data: {"postId" : postId, "content" : commentText},
				success: function(data) {
					if (data.result == 'success') {
						location.reload(); // 새로고침
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					var errorMsg = jqXHR.responseJSON.status;
					alert(errorMsg + ":" + textStatus);
				}
			});
		});
		
		// 댓글 삭제
		$('.commentDelBtn').on('click', function(e) {
			e.preventDefault();
			//alert('삭제버튼클릭');
			
			let commentId = $(this).data('commentId');
			alert(commentId);
			
			// AJAX 요청하기
			$.ajax({
				type: 'delete'
				, url: '/comment/delete'
				, data: {'commentId' : commentId}
				, success: function(data){
					if(data.result == 'success') {
						alert("삭제됐습니다.");
						location.reload();
					}
				}, error: function(e) {
					alert('삭제하는데 실패했습니다.' + e);
				}
			});
		})
		
	});
</script>
	