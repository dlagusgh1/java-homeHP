<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="비밀번호 변경" />
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<h1 class="con flex-jc-c">비밀번호 변경</h1>

<script>
	var MemberMemberModifyPwForm__submitDone = false;
	function MemberMemberModifyPwForm__submit(form) {
		if (MemberMemberModifyPwForm__submitDone) {
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

		if (form.loginPwConfirm.value.length == 0) {
			form.loginPwConfirm.focus();
			alert('로그인 비밀번호 확인을 입력해주세요.');

			return;
		}

		if (form.loginPw.value != form.loginPwConfirm.value) {
			form.loginPwConfirm.focus();
			alert('로그인 비밀번호 확인이 일치하지 않습니다.');

			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		form.loginPwConfirm.value = '';

		form.submit();
		MemberMemberModifyPwForm__submitDone = true;
	}
</script>

<div class="memeberModifyPw-box con flex-jc-c">
	<form method="POST" class="table-box con" action="doMemberModifyPw" onsubmit="MemberMemberModifyPwForm__submit(this); return false;">
		<input type="hidden" name="redirectUri" value="/member/login">
		<input type="hidden" name="loginId" value="${loginedMember.loginId}">
		<input type="hidden" name="loginPwReal">
		<table>
			<colgroup>
				<col width="250">
			</colgroup>
			<tbody>
				<tr>
					<th>새 로그인 비번</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="로그인 비밀번호를 입력해주세요." name="loginPw" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>새 로그인 비번 확인</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="로그인 비밀번호 확인을 입력해주세요." name="loginPwConfirm" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>비밀번호 변경</th>
					<td class="btn-info">
						<button class="btn" type="submit">비밀번호 변경</button>
						<button class="btn btn-info" type="button" onclick="history.back();">취소</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>