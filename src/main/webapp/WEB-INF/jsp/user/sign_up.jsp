<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 참고: class container는 맨 바깥 레이아웃 잡을 때만 사용한다. --%>
<%-- d-flex로 하위 요소를 유동적으로 배치한다. --%>
<%-- justify-content-center로 d-flex 적용된 하위 요소를 가운데에 배치한다. --%>
<div class="d-flex justify-content-center">
	<div class="sign-up-box">
		<h1 class="mb-4">회원가입</h1>
		<form id="signUpForm" method="post" action="/user/sign_up">
			<table class="sign-up-table table table-bordered">
				<tr>
					<th>* 아이디(4자 이상)<br></th>
					<td>
						<%-- 인풋박스 옆에 중복확인을 붙이기 위해 div를 하나 더 만들고 d-flex --%>
						<div class="d-flex">
							<input type="text" id="loginId" name="loginId" class="form-control" placeholder="아이디를 입력하세요.">
							<button type="button" id="loginIdCheckBtn" class="btn btn-success">중복확인</button><br>
						</div>
						
						<%-- 아이디 체크 결과 --%>
						<%-- d-none 클래스: display none (보이지 않게) --%>
						<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
						<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
						<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
					</td>
				</tr>
				<tr>
					<th>* 비밀번호</th>
					<td><input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요."></td>
				</tr>
				<tr>
					<th>* 비밀번호 확인</th>
					<td><input type="password" id="confirmPassword" class="form-control" placeholder="비밀번호를 입력하세요."></td>
				</tr>
				<tr>
					<th>* 이름</th>
					<td><input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요."></td>
				</tr>
				<tr>
					<th>* 이메일</th>
					<td><input type="text" id="email" name="email" class="form-control" placeholder="이메일 주소를 입력하세요."></td>
				</tr>
			</table>
			<br>
		
			<button type=button id="signUpBtn" class="btn btn-success float-right mb-2">회원가입</button>
		</form>
	</div>
</div>
	
<script>
$(document).ready(function() {
	// 아이디 중복확인
	$('#loginIdCheckBtn').on('click', function(e) {
		// validation
		var loginId = $('#loginId').val().trim();
		// id가 4자 이상이 아니면 경고문구 노출하고 끝낸다.
		if (loginId.length < 4) {
			$('#idCheckLength').removeClass('d-none'); // 경고문구 노출
			$('#idCheckDuplicated').addClass('d-none'); // 숨김
			$('#idCheckOk').addClass('d-none'); // 숨김
			return;
		}
		
		// 중복여부는 DB를 조회해야 하므로 서버에 묻는다. 
		// 화면을 이동시키지 않고 ajax 통신으로 중복여부 확인하고 동적으로 문구 노출
		$.ajax({
			url: "/user/is_duplicated_id",
			data: {"loginId": loginId},
			success: function(data) {
				if (data.result == true) { // 중복인 경우
					$('#idCheckDuplicated').removeClass('d-none'); // 중복 경고문구 노출
					$('#idCheckLength').addClass('d-none'); // 숨김
					$('#idCheckOk').addClass('d-none'); // 숨김
				} else {
					$('#idCheckOk').removeClass('d-none'); // 사용가능 문구 노출
					$('#idCheckLength').addClass('d-none'); // 숨김
					$('#idCheckDuplicated').addClass('d-none'); // 숨김
				}
			},
			error: function(error) {
				alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	});
	
	// singUpBtn
	$('#signUpBtn').on('click', function(){
		let loginId = $('#loginId').val().trim();
		if (loginId == '') {
			alert("아이디를 입력하세요");
			return;
		}
		
		let password = $('#password').val();
		let confirmPassword = $('#confirmPassword').val();
		if (password =='' || confirmPassword == ''){
			alert("비밀번호를 입력하세요");
			return;
		}

	 	if (password != confirmPassword){
			alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요");
			$('#password').val('');
			$('#confirmPassword').val('');
			return;
		} 
		let name = $('#name').val().trim();
		if (name ==''){
			alert("이름을 입력하세요");
			return;
		}
		let email = $('#email').val().trim();
		if (email ==''){
			alert("이메일을 입력하세요");
			return;
		}
			
		// 아이디 중복확인이 완료됐는지 확인
		// -- #idCheckOk <div> 클래스에 d-none이 없으면 사용가능
		if ($('#idCheckOk').hasClass('d-none')){
			alert("아이디 중복확인을 해주세요");
			return;
		}
		
		// 서버에 요청!!
		let url = $('#signUpForm').attr('action');
		let data = $('#signUpForm').serialize();  // 폼태그에 있는 데이터를 한번에 보낼 수있게 구성한다. 그렇지 않으면 json
		console.log(data);
		// alert(url);
		 $.post(url, data)
		.done(function(data){
			if (data.result == 'success') {
				alert("가입을 환영합니다!! 로그인을 해주세요.");
				location.href ='/user/sign_in_view';
			
		} else {
			alert("가입에 실패했습니다.");
		}
			
	  });
		 
	})
});

</script>



