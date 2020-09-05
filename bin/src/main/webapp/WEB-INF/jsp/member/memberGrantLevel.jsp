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
	var ChangeAuthoritiesForm__data = {};
	
	function ChangeAuthoritiesForm__changeItem(el) {
	  var $el = $(el);

	  // name="member__authority__hideArticle__${member.id}"
	  var keyName = $el.prop('name');

	  // 체크관련
	  if ( $el.prop('checked') ) {
	    if ( $el.attr('data-origin-value') == 'N' ) {
	      ChangeAuthoritiesForm__data[keyName] = "Y";
	    }
	    else {
	      delete ChangeAuthoritiesForm__data[keyName];
	    }
	  }
	  else {
	    if ( $el.attr('data-origin-value') == 'N' ) {
	      delete ChangeAuthoritiesForm__data[keyName];
	    }
	    else {
	      ChangeAuthoritiesForm__data[keyName] = "N";
	    }
	  }
	
	  var form = document['change-authorities-form'];
	  form.body.value = JSON.stringify(ChangeAuthoritiesForm__data);
	}
	
	var ChangeAuthoritiesForm__submitDone = false;
	
	function ChangeAuthoritiesForm__submit(form) {
		if (ChangeAuthoritiesForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		
		form.submit();
		var ChangeAuthoritiesForm__submitDone = true;
	}
</script>
<div class="con">
	<h1>회원 권한관리</h1>
</div>

<div class="table-box table-box-data memberGrant-table-box con">
	<table>
		<colgroup>
			
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>게시물숨김 권한</th>	
				<th>사용정지 권한</th>						
			</tr>
		</thead>
		<tbody>
			<c:if test="${loginedMember.level == 10}">
				<c:forEach items="${members}" var="member">
					<input type="hidden" name="member__${member.id}__inputed" value="Y">
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
					          <label>
					          	<!-- data-origin-value 의 속성값은 기존상태(DB에 저장되어 있는)를 의미한다. -->
				          		<input type="checkbox" name="member__${member.id}__authority__hideArticle" onchange="ChangeAuthoritiesForm__changeItem(this)" data-origin-value="N">
					            권한부여
					          </label>
				        	</td>	
				        	<td>
					          <label>
				            	<input type="checkbox" name="member__${member.id}__authority__stopUsing" onchange="ChangeAuthoritiesForm__changeItem(this)" data-origin-value="N">
					            권한부여
					          </label>
					        </td>					
						</tr>
					</c:if>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>

<form name="change-authorities-form" class="con margin-top-20" onsubmit="ChangeAuthoritiesForm__submit(); return false;">
  <textarea class="flex margin-bottom-10" name="body" style="width: 800px; height: 100px;"></textarea>
  <input class="btn btn-info" type="submit" value="권한 일괄수정">
</form>

<%@ include file="../part/foot.jspf"%>