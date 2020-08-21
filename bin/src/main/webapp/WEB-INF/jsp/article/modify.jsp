<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="${board.name} 게시물 수정" />
<%@ include file="../part/head.jspf"%>

<!-- 토스트 UI -->
<%@ include file="/WEB-INF/jsp/part/toastUiEditor.jspf"%>
<h1 class="con flex-jc-c">게시물 수정</h1>

<script>
	var ArticleModifyForm__submitDone = false;
	function ArticleModifyForm__submit(form) {
		if (ArticleModifyForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.title.value = form.title.value.trim();

		if (form.title.value.length == 0) {
			form.title.focus();
			alert('제목을 입력해주세요.');

			return;
		}

		var editor = $(form).find('.toast-editor').data('data-toast-editor');

		var body = editor.getMarkdown();
		body = body.trim();
		
		form.body.value = form.body.value.trim();

		if (body.length == 0) {
			editor.focus();
			alert('내용을 입력해주세요.');

			return;
		}

		form.body.value = body;
		
		form.submit();
		ArticleModifyForm__submitDone = true;
	}
</script>

<form method="POST" class="modify-table-box con" action="${board.code}-doModify" onsubmit="ArticleModifyForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/article/${board.code}-detail?id=${article.id}" /> 
	<input type="hidden" name="id" value="${article.id}"/>
	<table>
	   <colgroup>
            <col class="table-first-col" width="250">
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
				<th>제목</th>
				<td>
					<div class="form-control">
						<input type="text" value="${article.title}" placeholder="제목을 입력해주세요." name="title" maxlength="100"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<div class="form-control">
						<input name="body" type="hidden">
						<script type="text/x-template">${article.bodyForXTemplate}</script>
						<div class="toast-editor"></div>
					</div>
				</td>
			</tr>
			<tr>
				<th>수정</th>
				<td class="btn-info">
					<button class="btn" type="submit">수정</button> 
					<button class="btn" ><a href="${listUrl}">리스트</a></button>
				</td>
			</tr>
		</tbody>
	</table>
</form>
	
<%@ include file="../part/foot.jspf"%>