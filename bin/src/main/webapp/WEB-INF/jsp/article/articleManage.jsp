<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="게시물 관리" />


<%@ include file="../part/head.jspf"%>

<h1 class="con flex-jc-c">게시물 관리</h1>

<div class="table-box table-box-data con">
	<table>
		<colgroup>
			<col width="100" />
           	<col width="300" />
           	<col width="200" />
           	<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>	
				<th>작성일자</th>	
				<th>구분</th>
				<th>상태</th>
				<th>숨기기</th>
				<th>보이기</th>							
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
						<td class="writer">${article.extra.writer}</td>	
						<td><a>${article.regDate}</a></td>	
						<td>${board.name}</td>
						<td>
							<c:if test="${article.displayStatus}">
								보임
							</c:if>
							<c:if test="${article.displayStatus != true}">
								숨김
							</c:if>
						</td>
						<td>
							<a class="btn btn-primary"	href="${board.code}-modify?id=${article.id}&listUrl=${Util.getUriEncoded(listUrl)}">숨기기</a>					
						</td>
						<td>
							<a class="btn btn-primary"	href="${board.code}-modify?id=${article.id}&listUrl=${Util.getUriEncoded(listUrl)}">보이기</a>		
						</td>					
						<td class="visible-on-sm-down">
                        <a href="${article.getDetailLink(board.code)}" class="flex flex-row-wrap flex-ai-c">
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