<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${board.name == \"공지\"}">
		<c:set var="pageTitle" value="${board.name} 사항" />
	</c:when>
	<c:otherwise>
		<c:set var="pageTitle" value="${board.name} 게시판" />
	</c:otherwise>
</c:choose>

<%@ include file="../part/head.jspf"%>

<c:choose>
	<c:when test="${board.name == \"공지\"}">
		<h1 class="con flex-jc-c">${board.name} 사항</h1>
	</c:when>
	<c:otherwise>
		<h1 class="con flex-jc-c">${board.name} 게시물 리스트</h1>
	</c:otherwise>
</c:choose>


<!-- 
	boardId
	1번 : 자유 게시판
	2번 : 공지 게시판
 -->
<div class="article-table-box table-box-data con">
	<table>
		<colgroup>
			<col class="table-first-col">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${articles}" var="article">
				<c:if test="${board.id == article.boardId}">
					<tr>
						<td><a>${article.id}</a></td>
						<td>
							<a href="${article.getDetailLink(board.code)}">${article.forPrintTitle}</a>
						</td>
						<td><a>${article.regDate}</a></td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="btn-box con margin-top-20 margin-bottom-20">
	<c:choose>
		<c:when test="${board.code.equals('notice')}">
			<c:if test="${loginedMember.level == 10}">
				<a class="btn" href="./${board.code}-write">글쓰기</a>
			</c:if>
		</c:when>
		<c:otherwise>
			<a class="btn btn-primary" href="./${board.code}-write">글쓰기</a>
		</c:otherwise>
	</c:choose>
</div>
	
	
<%@ include file="../part/foot.jspf"%>