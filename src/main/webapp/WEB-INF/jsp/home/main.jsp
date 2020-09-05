<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="당직 의료기관 찾기" />
<%@ include file="../part/head.jspf"%>

<h1 class="con flex-jc-c"><a href="/usr/article/kakaoMap">우리동네 당직 의료기관 찾기</a></h1>

<div class="main-covid19-box con flex-jc-c margin-top-10">
	<div class="covid19-counter">
		<c:forEach items="${covidDataList}" var="covid">
		<c:if test="${covid.country == '세종' || covid.country == '대전' || covid.country == '충북' || covid.country == '충남'}">
			<h3 class="con">${covid.country} COVID-19 현황</h3>
			<div class="box1">
				<span class="box-head">전일대비확진환자 증감 <span class="head-info">(*발생률 인구 10만 명당)</span></span>
				<span class="data">
					<span>확진자</span>
					<em>${covid.total} 명</em>
				</span>
				<span class="data">
					<span>전일대비확진자</span>
					<em>${covid.diffFromPrevDay} 명</em>
				</span>
				<span class="data">
					<span>발생률</span>
					<em>${covid.incidence} 명</em>	
				</span>
			</div>
			<div class="box2">
				<span class="box-head">격리 / 사망자수</span>
				<span class="data">
					<span>격리중</span>
					<em>${covid.quarantine} 명</em>
				</span>
				<span class="data">
					<span>격리해제</span>
					<em>${covid.quarantineRelease} 명</em>
				</span>
				<span class="data">
					<span>사망자</span>
					<em>${covid.death} 명</em>
				</span>
			</div>
		</c:if>
		</c:forEach>	
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
							<a href="/usr${article.getDetailLink('notice')}">${article.forPrintTitle}</a>
						</td>	
						<td class="writer">${article.extra.writer}</td>	
						<td><a>${article.regDate}</a></td>							
						<td class="visible-on-sm-down">
                        <a href="/usr${article.getDetailLink('notice')}" class="flex flex-row-wrap flex-ai-c">
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