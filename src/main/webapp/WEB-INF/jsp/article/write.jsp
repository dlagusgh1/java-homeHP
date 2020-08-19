<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="병원/약국 추가" />
<%@ include file="../part/head.jspf"%>
	
<h1 class="con flex-jc-c">병원/약국 추가</h1>

<script>
	var OrganWriteForm__submitDone = false;
	function OrganWriteForm__submit(form) {
		if (OrganWriteForm__submitDone) {
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

		form.organAddress.value = form.organAddress.value.trim();

		if (form.organCode.value.length == 0) {
			form.organCode.focus();
			alert('기관 주소를 입력해주세요.');

			return;
		}

		form.organAdmAddress.avlue = form.organAdmAddress.value.trim();
		
		if (form.organAdmAddress.value.length == 0) {
			form.organAdmAddress.focus();
			alert('행정 주소를 입력해주세요.');

			return;
		}

		form.organTel.value = form.organTel.value.trim();
		form.organTel.value = form.organTel.value.replaceAll('-', '');
		form.organTel.value = form.organTel.value.replaceAll(' ', '');

		if (form.organTel.value.length == 0) {
			form.organTel.focus();
			alert('전화번호를 입력해주세요.');

			return;
		}

		if (form.organTel.value.length < 10) {
			form.organTel.focus();
			alert('전화번호를 10자 이상 입력해주세요.');

			return;
		}

		if (isCellphoneNo(form.organTel.value)) {
			form.organTel.focus();
			alert('전화번호를 정확히 입력해주세요.');
			
		}

		form.organTime.avlue = form.organTime.value.trim();
		
		if (form.organTime.value.length == 0) {
			form.organTime.focus();
			alert('진료 시간을 입력해주세요.');

			return;
		}

		form.organWeekend.avlue = form.organWeekend.value.trim();
		
		if (form.organWeekend.value.length == 0) {
			form.organWeekend.focus();
			alert('주말 운영 여부를 입력해주세요.');

			return;
		}

		
		

		form.submit();
		OrganWriteForm__submitDone = true;
	}
</script>

<!-- 
 == Organization info == 
 기관 구분 선택(병원/약국)
 기관명 : 엔케이(NK) 세종 병원
 기관 주소 : 세종 한누리대로 161
 행정 주소 선택(동/면) : (나성동)
 전화 번호 : 044-850-7700
 진료 시간 : 24시간
 주말운영여부 : 토요일 / 일요일 운영
 비고 : 응급실 운영기관
 -->
<div class="organWrite-form-box con flex-jc-c">
	<form method="POST" class="table-box con" action="doJoin" onsubmit="OrganWriteForm__submit(this); return false;">
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
							<select name="organNumber">
								<c:forEach items="${cateItems}" var="cateItem">
									<option value="${cateItem.id}">${cateItem.name}</option>
								</c:forEach>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th>기관명</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="기관명을 입력해주세요." name="organName" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>기관 주소</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="기관의 주소를 입력해주세요." name="organAddress" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>행정 주소(동/면)</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="행정 주소 입력 예) 도담동" name="organAdmAddress" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>전화 번호</th>
					<td>
						<div class="form-control-box">
							<input type="tel" placeholder="전화번호를 입력해주세요." name="organTel" maxlength="12" />
						</div>
					</td>
				</tr>
				<tr>
					<th>진료 시간</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="진료 시간을 입력해 주세요." name="organTime" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>주말 운영여부</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="주말 운영 입력 예) 미 운영, 토요일, 일요일" name="organWeekend" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>비고</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="추가사항 입력 예) 응급실 운영" name="organRemarks" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>등록하기</th>
					<td class="flex-jc-c">
						<button class="btn" type="submit">등록</button>
						<button class="btn" type="button" onclick="history.back();">취소</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>