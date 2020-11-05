<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="응급처치" />
<%@ include file="../part/head.jspf"%>

<!-- 토스트 UI -->
<%@ include file="/WEB-INF/jsp/part/toastUiEditor.jspf"%>

<h1 class="con flex-jc-c">응급처치</h1>
	
<div class="firstAidList">
	<ul>
		<c:forEach items="${firstAids}" var="firstAid">
			<li><a href="/usr/article/detailFirstAid?title=${firstAid.title}">
					<div class="screen">
						<div class="top">우리동네 응급처치</div>
						<div class="bottom">by 우리동네</div>
						<img src="/resource/img/logo.jpg" />
					</div>
					<div>
						<h3><i class="fas fa-arrow-right"></i> ${firstAid.title}</h3>
					</div>
				</a>
			</li>
		</c:forEach>
	</ul>
</div>


<%@ include file="../part/foot.jspf"%>