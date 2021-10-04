<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="d-flex justify-content-between">
	<div class="logo d-flex align-items-center">
		<h1 class="font-weight-bold p-4">marondalgram</h1>
	</div>
	<div class="login-info d-flex align-items-center p-2">
		<%-- session 정보가 있는경우에만 출력 --%>
		<c:if test="${not empty userId}">
			<span class="font-weight-bold mr-3">${userName}님 안녕하세요.</span> 
			<a href="/user/sign_out" class="font-weight-bold mr-3">로그아웃</a>
		</c:if>
	</div>
	
</div>

<!-- ctrl + shift + f = 정렬 -->