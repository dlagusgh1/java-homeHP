<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 리스트" />
<%@ include file="../part/head.jspf"%>
	
<h1 class="con flex-jc-c">${board.name} 게시물 리스트</h1>

<!-- 
	boardId
	1번 : 자유 게시판
	2번 : 공지 게시판
 -->
<div class="article-table-box con visible-on-md-up">
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
						<td>${article.id}</td>
						<td>
							<a href="${article.getDetailLink(board.code)}">${article.forPrintTitle}</a>
						</td>
						<td>${article.regDate}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="btn-box con margin-top-20">
	<a class="btn" href="./${board.code}-write">글쓰기</a>
</div>
	
	
<%@ include file="../part/foot.jspf"%>