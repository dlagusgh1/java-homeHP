<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="회원정보 변경" />
<%@ include file="../part/head.jspf"%>

<h1 class="con flex-jc-c">회원정보 변경</h1>

<script>
	var MemberMemberModifyForm__submitDone = false;
	function MemberMemberModifyForm__submit(form) {
		if (MemberMemberModifyForm__submitDone) {
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

		form.organCode.value = form.organCode.value.trim();

		if (form.organCode.value.length == 0) {
			form.organCode.focus();
			alert('기관코드를 입력해주세요.');

			return;
		}

		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			form.email.focus();
			alert('이메일을 입력해주세요.');

			return;
		}

		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		form.cellphoneNo.value = form.cellphoneNo.value.replaceAll('-', '');
		form.cellphoneNo.value = form.cellphoneNo.value.replaceAll(' ', '');

		if (form.cellphoneNo.value.length == 0) {
			form.cellphoneNo.focus();
			alert('휴대전화번호를 입력해주세요.');

			return;
		}

		if (form.cellphoneNo.value.length < 10) {
			form.cellphoneNo.focus();
			alert('휴대폰번호를 10자 이상 입력해주세요.');

			return;
		}

		if (isCellphoneNo(form.cellphoneNo.value)) {
			form.cellphoneNo.focus();
			alert('휴대전화번호를 정확히 입력해주세요.');
			
		}

		form.submit();
		MemberMemberModifyForm__submitDone = true;
	}
</script>

<!-- 회원 정보 변경 -->
<form method="POST" class="table-box table-box-vertical con form1" action="doMemberModify" onsubmit="MemberMemberModifyForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/usr/member/login">
	<table>
		<colgroup>
			<col width="250">
		</colgroup>
		<tbody>
			<tr>
				<th>회원 아이디</th>
				<td>
					<div class="form-control-box">
						<input type="hidden" name="loginId"	maxlength="30" value="${loginedMember.loginId}"/>${loginedMember.loginId}
					</div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<div class="form-control-box">
						<input type="hidden" name="name" maxlength="20" value="${loginedMember.name}"/>${loginedMember.name}
					</div>
				</td>
			</tr>
			<tr>
				<th>기관명</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="organName" maxlength="20" value="${loginedMember.organName}"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>기관 코드</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="organCode" maxlength="20" value="${loginedMember.organCode}"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div class="form-control-box">
						<input type="email" name="email" maxlength="50" value="${loginedMember.email}"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="cellphoneNo" maxlength="12" value="${loginedMember.phoneNo}"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>회원정보 변경</th>
				<td>
					<button class="btn btn-primary" type="submit">회원정보 변경</button>
					<button class="btn btn-info" type="button" onclick="history.back();">취소</button>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<%@ include file="../part/foot.jspf"%>