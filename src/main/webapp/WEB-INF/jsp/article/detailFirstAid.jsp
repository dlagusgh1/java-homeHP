<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="${firstAid.title}" />
<%@ include file="../part/head.jspf"%>

<!-- 토스트 UI -->
<%@ include file="/WEB-INF/jsp/part/toastUiEditor.jspf"%>

<h1 class="con flex-jc-c">응급처치 - ${firstAid.title}</h1>
	
<div class="table-box table-box-vertical con form1">
	<table>
		<colgroup>
			<col class="table-first-col">
		</colgroup>
		<tbody>
			<tr>
				<th>처치 방법</th>
				<td>
					<script type="text/x-template">${firstAid.body}</script>
                    <div class="toast-editor toast-editor-viewer"></div>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<div class="btn-box con margin-top-20 margin-bottom-20">
	<a href="/usr/article/firstAid" class="btn">응급처치 목록</a>
</div>

<%@ include file="../part/foot.jspf"%>