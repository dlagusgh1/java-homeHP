<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="아이디 찾기" />
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<h1 class="con flex-jc-c">아이디 찾기</h1>

<script>
	var MemberFindForm__submitDone = false;
	function MemberFindForm__submit(form) {
		if (MemberFindForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		
		form.organName.value = form.organName.value.trim();
		form.organName.value = form.organName.value.replaceAll('-', '');
		form.organName.value = form.organName.value.replaceAll('_', '');
		form.organName.value = form.organName.value.replaceAll(' ', '');

		if (form.organName.value.length == 0) {
			form.organName.focus();
			alert('기관명을 입력해주세요.');

			return;
		}

		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			form.email.focus();
			alert('이메일을 입력해주세요.');

			return;
		}		

		form.submit();
		MemberFindForm__submitDone = true;
	}
</script>

<!-- 아이디 찾기 -->
<div class="findId-form-box con flex-jc-c">
	<form method="POST" class="table-box con" action="doFindId" onsubmit="MemberFindForm__submit(this); return false;">
		<input type="hidden" name="redirectUri" value="${param.redirectUri}">
		<input type="hidden" name="loginPwReal">	
		<table>
			<colgroup>
				<col width="250">
			</colgroup>
			<tbody>
				<tr>
					<th>기관명</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="기관명을 입력해주세요." name="organName" maxlength="30" autofocus="autofocus"/>
						</div>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<div class="form-control-box">
							<input type="email" placeholder="이메일을 입력해주세요." name="email" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>찾기</th>
					<td class="flex-jc-c">
						<button class="btn" type="submit">아이디 찾기</button>
						<button class="btn" onclick="history.back();" type="button">취소</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>