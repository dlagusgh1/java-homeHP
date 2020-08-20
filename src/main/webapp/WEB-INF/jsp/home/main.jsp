<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="병원/약국 24시/주말" />
<%@ include file="../part/head.jspf"%>

<style>
	h3 {
		text-indent: 1rem;
	}	
	.main-img {
		width:100%; 
		height: 300px; 
		background:url("https://cdn.pixabay.com/photo/2020/08/03/09/39/medical-5459633_960_720.png") no-repeat;
		background-size: cover;
	}
	.main-article {
		text-indent: 1rem;
		width: 49.999%; 
		height:400px; 
		border:2px solid #168; 	
	}
	
	.main-article-notice {
		margin-right: 5px;
	}
</style>

<h1 class="con flex-jc-c">우리동네 24시 / 주말 운영 병원, 약국 찾기</h1>

<div class="con flex-jc-c" style="width:100%;">
	<div class="main-img">
	</div>
</div>

<div class="con flex-jc-c" style="margin-top: 10px;">
	<div class="main-article main-article-notice">
		<div>
			<h3>공지사항</h3>
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
								<td>${article.id}</td>
								<td>
									<a href="${article.getDetailLink(nBoard.code)}">${article.forPrintTitle}</a>
								</td>
								<td>${article.regDate}</td>
							</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<div class="main-article">
		<div>
			<h3>최근 게시물</h3>
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
								<td>${article.id}</td>
								<td>
									<a href="${article.getDetailLink(fBoard.code)}">${article.forPrintTitle}</a>
								</td>
								<td>${article.regDate}</td>
							</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>


<%@ include file="../part/foot.jspf"%>