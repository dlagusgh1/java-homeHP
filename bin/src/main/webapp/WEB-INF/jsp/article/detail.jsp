<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="${board.name} 게시물 상세내용" />
<%@ include file="../part/head.jspf"%>

<!-- 토스트 UI -->
<%@ include file="/WEB-INF/jsp/part/toastUiEditor.jspf"%>

<h1 class="con flex-jc-c">${board.name} 게시판 상세내용</h1>
	
<div class="article-detail-box table-box table-box-vertical con">
	<table>
		<colgroup>
			<col class="table-first-col">
		</colgroup>
		<tbody>
			<tr>
				<th>번호</th>
				<td>${article.id}</td>
			</tr>
			<tr>
				<th>날짜</th>
				<td>${article.regDate}</td>
			</tr>
			<tr>
				<th>좋아요</th>
				<td>
					<span>${article.extra.likePoint}</span>
					/
					<a href="./doLike?id=${article.id}&redirectUri=/usr/article/${board.code}-detail?id=${article.id}"
					onclick="if ( confirm('추천하시겠습니까?') == false ) { return false; }">좋아요</a>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${article.forPrintTitle}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<script type="text/x-template">${article.body}</script>
                    <div class="toast-editor toast-editor-viewer"></div>
				</td>
			</tr>
			<c:forEach var="i" begin="1" end="3" step="1">
				<c:set var="fileNo" value="${String.valueOf(i)}" />
				<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}" />
				<c:if test="${file != null}">
					<tr>
						<th>첨부파일 ${fileNo}</th>
						<td>
							<c:if test="${file.fileExtTypeCode == 'video'}">
								<div class="video-box">
									<video controls src="/usr/file/streamVideo?id=${file.id}&updateDate=${file.updateDate}"></video>
								</div>
							</c:if>
							<c:if test="${file.fileExtTypeCode == 'img'}">
								<div class="img-box img-box-auto">
									<img src="/usr/file/img?id=${file.id}&updateDate=${file.updateDate}" alt="" />
								</div>
							</c:if>
						</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="btn-box con margin-top-20 margin-bottom-20">
	<c:if test="${article.extra.actorCanModify}">
		<a class="btn btn-primary"	href="${board.code}-modify?id=${article.id}&listUrl=${Util.getUriEncoded(listUrl)}">수정</a>
	</c:if>
	<c:if test="${article.extra.actorCanDelete}">
		<a class="btn btn-info" href="${board.code}-doDelete?id=${article.id}" onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;">삭제</a>
	</c:if>
	<a href="${listUrl}" class="btn">리스트</a>
	<a href="doLike?id=${article.id}&redirectUri=/usr/article/${board.code}-detail?id=${article.id}" class="btn" onclick="if ( confirm('추천하시겠습니까?') == false ) return false;">좋아요</a>
	<a href="doLike?id=${article.id}&redirectUri=/usr/article/${board.code}-detail?id=${article.id}" class="btn btn-danger" onclick="if ( confirm('싫어요 하시겠습니까?') == false ) return false;">싫어요</a>
</div>

<%@ include file="../part/foot.jspf"%>