<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="지도 정보 수정" />
<%@ include file="../part/head.jspf"%>


<h1 class="con flex-jc-c">지도 정보 수정 요청</h1>

<script>
	var OrganModifyForm__submitDone = false;
	function OrganModifyForm__submit(form) {
		if (OrganModifyForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.organNumber.value = form.organNumber.value.trim();

		if (form.organNumber.value.length == 0) {
			form.name.focus();
			alert('기관 구분을 입력해주세요.');

			return;
		}
		
		form.organName.value = form.organName.value.trim();

		if (form.organName.value.length == 0) {
			form.organName.focus();
			alert('기관명을 입력해주세요.');

			return;
		}

		

		form.modifyRequests.value = form.modifyRequests.value.trim();
		
		if (form.modifyRequests.value.length == 0) {
			form.modifyRequests.focus();
			alert('수정 요청사항을 입력해주세요.');

			return;
		}
		
		form.submit();
		OrganWriteForm__submitDone = true;
	}

</script>

<div class="organModify-form-box con flex-jc-c">
	<form method="POST" class="table-box con" action="doOrganModify" onsubmit="OrganModifyForm__submit(this); return false;">
		<input type="hidden" name="redirectUri" value="/home/main">
		<table>
			<colgroup>
				<col width="250">
			</colgroup>
			<tbody>
				<tr>
					<th>기관 구분</th>
					<td>
						<div class="form-control-box">
							<select name="organNumber" id="organNum">
								<c:forEach items="${cateItems}" var="cateItem">
									<option id="organNumber" value="${cateItem.id}">${cateItem.name}</option>
								</c:forEach>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th>기관명</th>
					<td>
						<div class="form-control-box">
							<input name="organName" type="hidden" value="${loginedMember.organName}" />${loginedMember.organName}
						</div>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<div class="form-control-box">
							<input name="organEmail" type="hidden" value="${loginedMember.email}" />${loginedMember.email}
						</div>
					</td>
				</tr>
				<tr>
					<th>수정요청</th>
					<td>
						<div class="form-control-box">
							<textarea name="modifyRequests" placeholder="지도 정보에 문제가 있으신가요?&#13;&#10;&#13;&#10;문의사항을 자유롭게 입력해 주세요.&#13;&#10;&#13;&#10;결과는 등록된 이메일로 회신됩니다."></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>요청</th>
					<td class="btn-info">
						<button class="btn" type="submit">요청하기</button>
						<button class="btn" type="button" onclick="history.back();">취소</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>