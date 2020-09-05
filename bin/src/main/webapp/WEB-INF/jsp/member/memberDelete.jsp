<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="회원 탈퇴" />
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<h1 class="con flex-jc-c">회원 탈퇴</h1>

<script>
	var MemberDeleteForm__submitDone = false;
	function MemberDeleteForm__submit(form) {
		if (MemberDeleteForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		
		form.deleteConfirm.value = form.deleteConfirm.value.trim();
		
		form.deleteRealConfirm.value = form.deleteRealConfirm.value.trim();

		if (form.deleteRealConfirm.value.length == 0) {
			form.deleteRealConfirm.focus();
			alert('회원 탈퇴를 위해 탈퇴 문구를 입력해주세요.');

			return;
		}	

		if ( form.deleteConfirm.value != form.deleteRealConfirm.value ) {
			form.deleteRealConfirm.focus();
			alert('입력하신 정보가 잘못되었습니다.\n'+ '입력하신 정보 : ' + form.deleteRealConfirm.value );

			return;
		}
	

		form.submit();
		MemberDeleteForm__submitDone = true;
	}
</script>

<!-- 회원 탈퇴 -->
<form method="POST" class="table-box table-box-vertical  con form1" action="doMemberDelete" onsubmit="MemberDeleteForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/usr/home/main">
	<table>
		<colgroup>
			<col width="250">
		</colgroup>
		<tbody>
			<tr>
				<th>탈퇴 문구</th>
				<td>
					<div class="form-control-box">
						<input type="hidden" name="deleteConfirm" value="우리동네 회원 탈퇴를 희망합니다"/> 우리동네 회원 탈퇴를 희망합니다
					</div>
				</td>
			</tr>
			<tr>
				<th>탈퇴 문구 입력</th>
				<td>
					<div class="form-control-box">
						<input type="text"  name="deleteRealConfirm" placeholder="탈퇴를 위해 탈퇴 문구를 입력해주세요." maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>탈퇴</th>
				<td class="flex-jc-c" style="margin: auto;">
					<button class="btn btn-primary" type="submit">탈퇴하기</button>
					<button class="btn btn-info" onclick="history.back();" type="button">취소</button>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<%@ include file="../part/foot.jspf"%>