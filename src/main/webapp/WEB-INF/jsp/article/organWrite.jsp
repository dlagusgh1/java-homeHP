<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="기관 정보 등록" />
<%@ include file="../part/head.jspf"%>


<h1 class="con flex-jc-c">기관 정보 등록</h1>
<div class="con flex-jc-c" style="margin-bottom: 5px; font-size: 1rem;">
	<a href="/article/searchMap" style="background-color: #4BAF4B; color: white; padding: 5px; border-radius: 10px;" onclick="window.open(this.href,'지도 검색', 'width=860px, height=560px, scrollbars=no, resizeble=0, directories=0' ); return false;">지도 검색하기</a>
</div>

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

		form.orgamLocation.value = form.orgamLocation.value.trim();

		if (form.orgamLocation.value.length == 0) {
			form.orgamLocation.focus();
			alert('주소의 좌표를 입력해주세요.');

			return;
		}

		form.organAddress.value = form.organAddress.value.trim();

		if (form.organAddress.value.length == 0) {
			form.organAddress.focus();
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

		form.organTime.value = form.organTime.value.trim();
		
		if (form.organTime.value.length == 0) {
			form.organTime.focus();
			alert('진료 시간을 입력해주세요.');

			return;
		}

		form.organWeekendTime.value = form.organWeekendTime.value.trim();
		
		if (form.organWeekendTime.value.length == 0) {
			form.organWeekendTime.focus();
			alert('주말 진료 시간을 입력해주세요.');

			return;
		}

		form.organWeekend.value = form.organWeekend.value.trim();
		
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

<form method="POST" class="table-box table-box-vertical con form1" action="doOrganWrite" onsubmit="OrganWriteForm__submit(this); return false;">
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
						<input type="text" placeholder="기관명을 입력해주세요." name="organName" maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>좌표</th>
				<td>
					<div class="form-control-box">
						<input type="text" placeholder="위도, 경도(좌표)를 입력해주세요. " name="orgamLocation" maxlength="30" />
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
				<th>행정 주소 (동/면)</th>
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
				<th>진료 시간 (주말)</th>
				<td>
					<div class="form-control-box">
						<input type="text" placeholder="주말 진료 시간을 입력해 주세요." name="organWeekendTime" maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>주말 운영여부</th>
				<td>
					<div class="form-control-box">
						<input type="text" placeholder="주말 운영 입력 예) 미 운영, 토요일, 일요일 운영" name="organWeekend" maxlength="30" />
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
				<td class="btn-info">
					<button class="btn" type="submit">등록</button>
					<button class="btn" type="button" onclick="history.back();">취소</button>
				</td>
			</tr>
		</tbody>
	</table>
</form>


<%@ include file="../part/foot.jspf"%>