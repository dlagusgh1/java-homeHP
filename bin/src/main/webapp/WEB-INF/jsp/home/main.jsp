<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="당직 의료기관 찾기" />
<%@ include file="../part/head.jspf"%>

<h1 class="con flex-jc-c">우리동네 당직 의료기관 찾기</h1>

<div class="main-img-box con flex-jc-c">
	<div class="main-img">
		<h1>ㅇㄹㄷㄴ</h1>
		<div>
			<p>서비스 소개<br>우리동네는 주말, 야간 당직 의료기관(병원/약국)을 찾는 서비스 입니다.<br><br>운영지역<br>현재 세종시만 한정하여 운영 중 이며 점차 확대할 예정입니다.</p>
		</div>
	</div>
</div>

<h3 class="main-article-h con">공지사항</h3>
<div class="table-box table-box-data con">
	<table>
		<colgroup>
			<col width="100" />
           	<col width="500" />
           	<col width="200" />
           	<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>	
				<th>작성일자</th>								
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${articles}" var="article">
				<c:if test="${boardId == article.boardId}">
					<tr>
						<td><a>${article.id}</a></td>
						<td>
							<a href="${article.getDetailLink('notice')}">${article.forPrintTitle}</a>
						</td>	
						<td class="writer">${article.extra.writer}</td>	
						<td><a>${article.regDate}</a></td>							
						<td class="visible-on-sm-down">
                        <a href="${article.getDetailLink('notice')}" class="flex flex-row-wrap flex-ai-c">
                            <span class="badge badge-primary bold margin-right-10">${article.id}</span>
                            <div class="title flex-1-0-0 text-overflow-el">${article.forPrintTitle}</div>
                            <div class="width-100p"></div>
                            <div class="writer">${article.extra.writer}</div>
                            &nbsp;|&nbsp;
                            <div class="reg-date">${article.regDate}</div>
                        </a>
                    </td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
</div>

<%@ include file="../part/foot.jspf"%>