<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="COVID-19 현황" />

<%@ include file="../part/head.jspf"%>

<h1 class="con flex-jc-c">지역별 COVID-19 현황</h1>

<div class="main-covid19-box con flex-jc-c margin-top-10">
	<div class="covid19-counter">
		<c:forEach items="${covidDataList}" var="covid">
		<c:if test="${covid.country == '세종' || covid.country == '대전' || covid.country == '충북' || covid.country == '충남' || covid.country == '합계'}">
			<c:choose>
				<c:when test="${covid.country == '합계'}">
					<h3 class="con">전체 COVID-19 현황</h3>
				</c:when>
				<c:otherwise>
					<h3 class="con">${covid.country} COVID-19 현황</h3>
				</c:otherwise>
			</c:choose>
			<div class="box1">
				<span class="box-head">전일대비확진환자 증감 <span class="head-info">(*발생률 인구 10만 명당)</span></span>
				<span class="data">
					<span>누적확진자</span>
					<em>${covid.total} 명</em>
				</span>
				<span class="data">
					<span>전일대비확진자</span>
					<em style="color: red;">${covid.diffFromPrevDay} 명</em>
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

<%@ include file="../part/foot.jspf"%>