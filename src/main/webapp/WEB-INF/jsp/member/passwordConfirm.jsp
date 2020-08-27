<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="비밀번호 확인" />
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<h1 class="con flex-jc-c">비밀번호 확인</h1>

<script>
	var MemberPasswordConfirmForm__submitDone = false;
	function MemberPasswordConfirmForm__submit(form) {
		if (MemberPasswordConfirmForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length == 0) {
			form.loginPw.focus();
			alert('로그인 비밀번호를 입력해주세요.');

			return;
		}

		if (form.loginPw.value.length < 5) {
			form.loginPw.focus();
			alert('로그인 비밀번호를 5자 이상 입력해주세요.');

			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';

		form.submit();
		MemberPasswordConfirmForm__submitDone = true;
	}
</script>


<form method="POST" class="table-box passwordConfirm-box con flex-jc-c" action="doPasswordConfirm" onsubmit="MemberPasswordConfirmForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="${param.redirectUri}">
	<input type="hidden" name="loginPwReal">	
	<table>
		<colgroup>
			<col width="250">
		</colgroup>
		<tbody>
			<tr>
				<th>로그인 비번</th>
				<td>
					<div class="form-control-box">
						<input type="password" placeholder="로그인 비밀번호를 입력해주세요." name="loginPw" maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>확인</th>
				<td class="btn-info">
					<button class="btn" type="submit">확인</button>
					<button class="btn" onclick="history.back();" type="button">취소</button>
				</td>
			</tr>
		</tbody>
	</table>
</form>


<%@ include file="../part/foot.jspf"%>