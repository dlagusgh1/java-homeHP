<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="알약 정보 찾기" />
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<h1 class="con flex-jc-c">알약 정보 찾기</h1>

<form method="POST" class="table-box table-box-vertical con form1" action="doLogin" onsubmit="MemberLoginForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="${param.redirectUri}">
	<table>
		<colgroup>
			<col width="250">
		</colgroup>
		<tbody>
			<tr>
				<th>약 정보로 검색</th>
				<td>
					<div class="form-control-box">
						<input type="text" placeholder="약 정보 찾기 준비중입니다." name="loginId" maxlength="30" autofocus="autofocus"/>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</form>


<%@ include file="../part/foot.jspf"%>