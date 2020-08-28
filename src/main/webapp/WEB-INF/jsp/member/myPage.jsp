<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="마이 페이지" />
<%@ include file="../part/head.jspf"%>

<h1 class="con flex-jc-c">마이 페이지</h1>

<div class="mypage-box con flex-jc-c">
	<form method="POST" class="table-box con" action="myPage">
		<input type="hidden" name="redirectUri" value="/home/main">
		<table>
			<colgroup>
				<col width="250">
			</colgroup>
			<tbody>
				<tr>
					<th>회원 아이디</th>
					<td>
						<div class="form-control-box">
							<input type="hidden" name="loginId"	maxlength="30" />${loginedMember.loginId}
						</div>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<div class="form-control-box">
							<input type="hidden" name="name" maxlength="20" />${loginedMember.name}
						</div>
					</td>
				</tr>
				<tr>
					<th>기관명</th>
					<td>
						<div class="form-control-box">
							<input type="hidden" name="organName" maxlength="20" />${loginedMember.organName}
						</div>
					</td>
				</tr>
				<tr>
					<th>기관 코드</th>
					<td>
						<div class="form-control-box">
							<input type="hidden" name="organCode" maxlength="20" />${loginedMember.organCode}
						</div>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<div class="form-control-box">
							<input type="hidden" name="email"	maxlength="50" />${loginedMember.email}
						</div>
					</td>
				</tr>
				<tr>
					<th>이메일 인증여부</th>
					<td>
						<div class="form-control-box">
							<c:choose>
								<c:when test="${emailAuthed != \"\"}">
									인증 완료
								</c:when>
								<c:otherwise>
									비 인증
								</c:otherwise>
							</c:choose>
						</div>
					</td>
				</tr>
				<c:if test="${emailAuthed == \"\"}">
					<tr>
						<th>인증 메일 발송</th>
						<td>
							<button class="btn"><a href="/member/reAuthEmail" style="width:120px;">인증메일 재 발송</a></button>
						</td>
					</tr>
				</c:if>
				<tr>
					<th>휴대폰</th>
					<td>
						<div class="form-control-box">
							<input type="hidden" name="cellphoneNo"	maxlength="13" />${loginedMember.phoneNo}
						</div>
					</td>
				</tr>
				<tr>
					<th>회원정보 변경</th>
					<td>
						<button class="btn btn-primary" type="button"><a href="/member/checkPassword?redirectUri=${Util.getUriEncoded('/member/memberModify')}">회원정보 변경</a></button>
						<button class="btn btn-primary" type="button"><a href="/member/checkPassword?redirectUri=${Util.getUriEncoded('/member/memberModifyPw')}">비밀번호 변경</a></button>
					</td>
				</tr>
				<tr>
					<th>회원 탈퇴</th>
					<td>
						<button class="btn btn-primary" type="button"><a href="/member/checkPassword?redirectUri=${Util.getUriEncoded('/member/memberDelete')}">회원탈퇴</a></button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>