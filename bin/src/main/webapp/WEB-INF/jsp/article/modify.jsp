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

		var fileInput1 = form["file__article__" + param.id + "__common__attachment__1"];
		var fileInput2 = form["file__article__" + param.id + "__common__attachment__2"];
		var fileInput3 = form["file__article__" + param.id + "__common__attachment__3"];

		var deleteFileInput1 = form["deleteFile__article__" + param.id + "__common__attachment__1"];
		var deleteFileInput2 = form["deleteFile__article__" + param.id + "__common__attachment__2"];
		var deleteFileInput3 = form["deleteFile__article__" + param.id + "__common__attachment__3"];

		if (fileInput1 && deleteFileInput1) {
			if (deleteFileInput1.checked) {
				fileInput1.value = '';
			}
		}

		if (fileInput2 && deleteFileInput2) {
			if (deleteFileInput2.checked) {
				fileInput2.value = '';
			}
		}
		
		if (fileInput3 && deleteFileInput3) {
			if (deleteFileInput3.checked) {
				fileInput3.value = '';
			}
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

		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024 //50MB

		if (fileInput1 && fileInput1.value) {
			if (fileInput1.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		if (fileInput2 && fileInput2.value) {
			if (fileInput2.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		if (fileInput3 && fileInput3.value) {
			if (fileInput3.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		var startUploadFiles = function(onSuccess) {

			var needToUpload = false;

			if (!needToUpload) {
				needToUpload = fileInput1 && fileInput1.value.length > 0;
			}
			
			if (!needToUpload) {
				needToUpload = deleteFileInput1 && deleteFileInput1.checked;
			}
			
			if (!needToUpload) {
				needToUpload = fileInput2 && fileInput2.value.length > 0;
			}
			
			if (!needToUpload) {
				needToUpload = deleteFileInput2 && deleteFileInput2.checked;
			}
			
			if (!needToUpload) {
				needToUpload = fileInput3 && fileInput3.value.length > 0;
			}
			
			if (!needToUpload) {
				needToUpload = deleteFileInput3 && deleteFileInput3.checked;
			}
			
			if (needToUpload == false) {
				onSuccess();
				return;
			}

			var fileUploadFormData = new FormData(form);

			$.ajax({
				url : './../file/doUploadAjax',
				data : fileUploadFormData,
				processData : false,
				contentType : false,
				dataType : "json",
				type : 'POST',
				success : onSuccess
			});
		}

		ArticleModifyForm__submitDone = true;
		
		startUploadFiles(function(data) {
			var fileIdsStr = '';
	
			if (data && data.body && data.body.fileIdsStr) {
				fileIdsStr = data.body.fileIdsStr;
			}
	
			form.fileIdsStr.value = fileIdsStr;
			
			if (fileInput1) {
				fileInput1.value = '';
			}
			
			if (fileInput2) {
				fileInput2.value = '';
			}
			
			if (fileInput3) {
				fileInput3.value = '';
			}
	
			form.submit();
		});

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
			<c:forEach var="i" begin="1" end="3" step="1">
				<c:set var="fileNo" value="${String.valueOf(i)}" />
				<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}" />
				<tr>
					<th>첨부파일 ${fileNo} ${appConfig.getAttachmentFileExtTypeDisplayName('article', i)}</th>
					<td>
						<div class="form-control-box">
							<input type="file" accept="${appConfig.getAttachemntFileInputAccept('article', i)}" name="file__article__${article.id}__common__attachment__${fileNo}">
						</div>
						<c:if test="${file != null && file.fileExtTypeCode == 'video'}">
							<div class="video-box">
								<video controls src="/file/streamVideo?id=${file.id}&updateDate=${file.updateDate}"></video>
							</div>
						</c:if>
						<c:if test="${file != null && file.fileExtTypeCode == 'img'}">
							<div class="img-box img-box-auto">
								<img src="/file/img?id=${file.id}&updateDate=${file.updateDate}">
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>첨부파일 ${fileNo} 삭제</th>
					<td>
						<div class="form-control-box">
							<label><input type="checkbox" name="deleteFile__article__${article.id}__common__attachment__${fileNo}" value="Y" />삭제</label>
						</div>
					</td>
				</tr>
			</c:forEach>
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