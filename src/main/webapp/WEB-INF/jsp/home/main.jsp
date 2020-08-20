<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="병원/약국 24시/주말" />
<%@ include file="../part/head.jspf"%>

<h1 class="con flex-jc-c">우리동네 24시 / 주말 운영 병원, 약국 찾기</h1>

<div class="con flex-jc-c" style="width:100%;">
	<img src="https://cdn.pixabay.com/photo/2020/08/03/09/39/medical-5459633_960_720.png" alt="" style="width:100%; height: 600px;"/>
</div>

<h2 class="con flex-jc-c">추가 예정 기능 리스트</h2>

<div class="con flex-jc-c">
	<ul>
		<li>- 병원 / 약국</li>
		<li>- 응급처치</li>
		<li>- 문의</li>
	</ul>
</div>

<%@ include file="../part/foot.jspf"%>