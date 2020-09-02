<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="회원 권한관리" />
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${logoText}-${pageTitle}</title>

<!-- 모바일에서 사이트가 PC에서의 픽셀크기 기준으로 작동하게 하기(반응형 하려면 필요) -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 구글 폰트 불러오기 -->
<!-- rotobo(400/700/900), notosanskr(400/600/900) -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">

<!-- 폰트어썸 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css">

<!-- 제이쿼리 불러오기 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- lodash 불러오기 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.20/lodash.min.js"></script>

<!-- 공통(라이브러리) CSS -->
<link rel="stylesheet" href="/resource/common.css" />
<!-- 공통(라이브러리) JS -->
<script src="/resource/common.js"></script>
<!-- 공통 CSS -->
<link rel="stylesheet" href="/resource/app.css" />
<link rel="stylesheet" href="/resource/keyframes.css" />
<!-- 공통 JS -->
<script src="/resource/app.js"></script>

<!-- 파비콘 -->
<link rel="shortcut icon" href="/resource/img/logo3B.ico">

</head>
<body style="padding-top: 0px; margin: 0 5px;">

<script>
	var MemberGrantForm__submitDone = false;
	
	function MemberGrantForm__submit(form) {
		if (MemberGrantForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.submit();
		MemberGrantForm__submitDone = true;
		//window.open("about:blank", "_self").close();
	}
</script>
<div class="con">
	<h1>회원 권한관리</h1>
</div>
<form method="POST" class="table-box table-box-data memberGrant-table-box con" action="doGrantLevel" onsubmit="MemberGrantForm__submit(this); return false;">
	<table>
		<colgroup>
			
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>기관명</th>	
				<th>권한</th>
				<th>권한1</th>	
				<th>권한2</th>
				<th>권한3</th>
				<th>비고</th>						
			</tr>
		</thead>
		<tbody>
			<c:if test="${loginedMember.level == 10}">
				<c:forEach items="${members}" var="member">
					<c:if test="${member.name != '관리자'}">
						<tr>
							<td>
								<a>${member.id}</a>
							</td>
							<td>
								<input type="hidden" name="memberId" value="${member.loginId}"/>
								<a>${member.loginId}</a>
							</td>	
							<td>
								<input type="hidden" name="organName" value="${member.organName}"/>
								<a>${member.organName}</a>
							</td>	
							<td>
								<a>${member.level}</a>
							</td>
							<td><input type="checkbox" name="grantLevel1" value="3"/>권한1</td>	
							<td><input type="checkbox" name="grantLevel2" value="5"/>권한2</td>	
							<td><input type="checkbox" name="grantLevel3" value="8"/>권한3</td>			
							<td>
								<button class="btn btn-info" type="submit">권한 설정</button>
							</td>				
						</tr>
					</c:if>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</form>

<%@ include file="../part/foot.jspf"%>