<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="병원/약국 24시/주말" />
<%@ include file="../part/head.jspf"%>

<h1 class="con flex-jc-c">우리동네 당직 의료기관(병원, 약국) 찾기</h1>

<div class="main-img-box con flex-jc-c">
	<div class="main-img">
	</div>
</div>

<div class="main-article-box con flex-jc-c">
	<div class="main-article-table-box main-article-notice">
		<h3 class="main-article-h">공지사항</h3>
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
				<c:forEach items="${nArticles}" var="article">
						<tr>
							<td><a class="tdaf">${article.id}</a></td>
							<td>
								<a href="${article.getDetailLink('notice')}">${article.forPrintTitle}</a>
							</td>
							<td><a>${article.regDate}</a></td>
						</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="main-article-table-box">
		<h3 class="main-article-h">최근 게시물</h3>
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
				<c:forEach items="${fArticles}" var="article">
						<tr>
							<td><a class="tdaf">${article.id}</a></td>
							<td>
								<a href="${article.getDetailLink('free')}">${article.forPrintTitle}</a>
							</td>
							<td><a>${article.regDate}</a></td>
						</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
</div>
<div class="con" style="margin-top: 10px;">
	<a href="https://donaricano.com/mypage/1461113623_Oh2ISH" target="_blank">
		<img src="https://d1u4yishnma8v5.cloudfront.net/donarincano_gift.png" alt="donaricano-btn" style="height:50px !important;width: 200px !important;" />
 	</a>
</div>

<%@ include file="../part/foot.jspf"%>