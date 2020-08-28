<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="아이디 찾기" />
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<h1 class="con flex-jc-c">아이디 찾기</h1>

<script>
	var MemberFindIdForm__submitDone = false;
	function MemberFindIdForm__submit(form) {
		if (MemberFindIdForm__submitDone) {
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
		MemberFindIdForm__submitDone = true;
	}
</script>

<!-- 아이디 찾기 -->

<form method="POST" class="table-box table-box-vertical  con form1" action="doFindId" onsubmit="MemberFindIdForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="${param.redirectUri}">
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
				<td class="flex-jc-c" style="margin: auto;">
					<button class="btn" type="submit">아이디<br>찾기</button>
					<button class="btn" onclick="history.back();" type="button">취소</button>
				</td>
			</tr>
		</tbody>
	</table>
</form>



<h1 class="con flex-jc-c">비밀번호 찾기</h1>

<script>
	var MemberFindPwForm__submitDone = false;
	function MemberFindPwForm__submit(form) {
		if (MemberFindPwForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.loginId.value = form.loginId.value.trim();
		form.loginId.value = form.loginId.value.replaceAll('-', '');
		form.loginId.value = form.loginId.value.replaceAll('_', '');
		form.loginId.value = form.loginId.value.replaceAll(' ', '');

		if (form.loginId.value.length == 0) {
			form.loginId.focus();
			alert('아이디를 입력해주세요.');

			return;
		}
		
		form.organName.value = form.organName.value.trim();

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
		MemberFindPwForm__submitDone = true;
	}
</script>

<!-- 비밀번호 찾기 -->
<form method="POST" class="table-box table-box-vertical  con form1" action="doFindPw" onsubmit="MemberFindPwForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="${param.redirectUri}">
	<input type="hidden" name="loginPwReal">	
	<table>
		<colgroup>
			<col width="250">
		</colgroup>
		<tbody>
			<tr>
				<th>아이디</th>
				<td>
					<div class="form-control-box">
						<input type="text" placeholder="아이디를 입력해주세요." name="loginId" maxlength="30" autofocus="autofocus"/>
					</div>
				</td>
			</tr>
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
				<td class="btn-info">
					<button class="btn" type="submit">비밀번호<br>찾기</button>
					<button class="btn" onclick="history.back();" type="button">취소</button>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<%@ include file="../part/foot.jspf"%>