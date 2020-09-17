<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="${board.name} 게시물 상세내용" />
<%@ include file="../part/head.jspf"%>

<!-- 토스트 UI -->
<%@ include file="/WEB-INF/jsp/part/toastUiEditor.jspf"%>

<h1 class="con flex-jc-c">${board.name} 게시판 상세내용</h1>
	
<div class="table-box table-box-vertical con form1">
	<table>
		<colgroup>
			<col class="table-first-col">
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
				<th>추천</th>
				<td><span>${article.extra.likePoint}</span></td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${article.forPrintTitle}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<script type="text/x-template">${article.body}</script>
                    <div class="toast-editor toast-editor-viewer"></div>
				</td>
			</tr>
			<c:forEach var="i" begin="1" end="3" step="1">
				<c:set var="fileNo" value="${String.valueOf(i)}" />
				<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}" />
				<c:if test="${file != null}">
					<tr>
						<th>첨부파일 ${fileNo}</th>
						<td>
							<c:if test="${file.fileExtTypeCode == 'video'}">
								<div class="video-box">
									<video controls src="/usr/file/streamVideo?id=${file.id}&updateDate=${file.updateDate}"></video>
								</div>
							</c:if>
							<c:if test="${file.fileExtTypeCode == 'img'}">
								<div class="img-box img-box-auto">
									<img src="/usr/file/img?id=${file.id}&updateDate=${file.updateDate}" alt="" />
								</div>
							</c:if>
						</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="btn-box con margin-top-20 margin-bottom-20">
	<c:if test="${article.extra.actorCanModify}">
		<a class="btn btn-primary"	href="${board.code}-modify?id=${article.id}&listUrl=${Util.getUriEncoded(listUrl)}">수정</a>
	</c:if>
	<c:if test="${article.extra.actorCanDelete}">
		<a class="btn btn-danger" href="${board.code}-doDelete?id=${article.id}" onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;">삭제</a>
	</c:if>
	<c:if test="${article.extra.loginedMemberCanLike}">
		<a class="btn btn-info"
			href="./doLike?id=${article.id}&redirectUri=/usr/article/${board.code}-detail?id=${article.id}"
			onclick="if ( confirm('추천하시겠습니까?') == false ) { return false; }">게시물 추천하기</a>
	</c:if> 
	<c:if test="${article.extra.loginedMemberCanCancelLike}">
		<a class="btn btn-danger"
			href="./doCancelLike?id=${article.id}&redirectUri=/usr/article/${board.code}-detail?id=${article.id}"
			onclick="if ( confirm('추천을 취소하시겠습니까?') == false ) { return false; }">추천 취소하기</a>
	</c:if>
	<a href="${listUrl}" class="btn">리스트</a>
</div>

<c:if test="${isLogined}">
	<h2 class="con">댓글 작성</h2>

	<script>
		var ArticleWriteReplyForm__submitDone = false;
		function ArticleWriteReplyForm__submit(form) {
			if ( ArticleWriteReplyForm__submitDone ) {
				alert('처리중입니다.');
			}
			
			form.body.value = form.body.value.trim();
			if (form.body.value.length == 0) {
				alert('댓글을 입력해주세요.');
				form.body.focus();
				return;
			}

			ArticleWriteReplyForm__submitDone = true;

			var startUploadFiles = function(onSuccess) {

				var fileUploadFormData = new FormData(form); 
				
				$.ajax({
					url : './../file/doUploadAjax',
					data : fileUploadFormData,
					processData : false,
					contentType : false,
					dataType:"json",
					type : 'POST',
					success : onSuccess
				});
			}

			var startWriteReply = function(fileIdsStr, onSuccess) {

				$.ajax({
					url : './../reply/doWriteReplyAjax',
					data : {
						fileIdsStr: fileIdsStr,
						body: form.body.value,
						relTypeCode: form.relTypeCode.value,
						relId: form.relId.value
					},
					dataType:"json",
					type : 'POST',
					success : onSuccess
				});
			};

			startUploadFiles(function(data) {
				
				var idsStr = '';
				if ( data && data.body && data.body.fileIdsStr ) {
					idsStr = data.body.fileIdsStr;
				}

				startWriteReply(idsStr, function(data) {
					
					if ( data.msg ) {
						alert(data.msg);
					}
					
					form.body.value = '';
					
					ArticleWriteReplyForm__submitDone = false;
				});
			});
		}
	</script>

	<form class="table-box table-box-vertical con form1" onsubmit="ArticleWriteReplyForm__submit(this); return false;">
		<input type="hidden" name="relTypeCode" value="article" /> 
		<input type="hidden" name="relId" value="${article.id}" />
		<table>
			<colgroup>
				<col class="table-first-col">
			</colgroup>
			<tbody>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea maxlength="200" name="body" placeholder="댓글 내용을 입력해주세요." class="height-200"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>작성</th>
					<td>
						<button class="btn btn-primary" type="submit">작성</button> 
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</c:if>

<h2 class="con">댓글 리스트</h2>

<div class="reply-list-box table-box table-box-data con">
	<table>
		<colgroup>
			<col class="table-first-col">
			<col width="300">
			<col width="150">
			<col width="200">
			<col width="150">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>내용</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			
		</tbody>
	</table>
</div>

<style>
.reply-modify-form-modal-actived, reply-modify-form-modal-actived>body {
	overflow: hidden;
}

.reply-modify-form-modal {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(0, 0, 0, 0.4);
	display: none;
	z-index: 20;
}

.reply-modify-form-modal>div {
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translateX(-50%) translateY(-50%);
	max-width: 100vw;
	min-width: 350px;
	max-height: 100vh;
	overflow-y: auto;
	border: 3px solid black;
	box-sizing: border-box;
}

.reply-modify-form-modal-actived .reply-modify-form-modal {
	display: flex;
}

.reply-modify-form-modal .form-control-label {
	width: 60px;
}

.reply-modify-form-modal .form-control-box {
	flex: 1 0 0;
}

.reply-modify-form-modal .video-box {
	width: 100px;
}
</style>

<div class="reply-modify-form-modal">
	<div class="bg-white">
		<h1 class="text-align-center">댓글 수정</h1>
		<form action="" class="form1 padding-10" onsubmit="ReplyList__submitModifyForm(this); return false;">
			<input type="hidden" name="id" />
			<div class="form-row">
				<div class="form-control-label">내용</div>
				<div class="form-control-box">
					<textarea name="body" placeholder="내용을 입력해주세요."></textarea>
				</div>
			</div>
			<div class="form-row">
				<div class="form-control-label">수정</div>
				<div class="form-control-box">
					<button class="btn btn-info" type="submit">수정</button>
					<button class="btn btn-danger" type="button" onclick="ReplyList__hideModifyFormModal();">취소</button>
				</div>
			</div>
		</form>
	</div>
</div>

<script>
	var ReplyList__$box = $('.reply-list-box');
	var ReplyList__$tbody = ReplyList__$box.find('tbody');

	var ReplyList__lastLodedId = 0;

	var ReplyList__submitModifyFormDone = false;

	function ReplyList__submitModifyForm(form) {
		if (ReplyList__submitModifyFormDone) {
			alert('처리중입니다.');
			return;
		}

		form.body.value = form.body.value.trim();

		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();

			return;
		}

		var id = form.id.value;
		var body = form.body.value;

		ReplyList__submitModifyFormDone = true;

		// 파일 업로드 시작
		var startUploadFiles = function() {
			var needToUpload = false;

			var fileUploadFormData = new FormData(form); 
			
			$.ajax({
				url : './../file/doUploadAjax',
				data : fileUploadFormData,
				processData : false,
				contentType : false,
				dataType:"json",
				type : 'POST',
				success : onUploadFilesComplete
			});
		}

		// 파일 업로드 완료시 실행되는 함수
		var onUploadFilesComplete = function(data) {
			
			var fileIdsStr = '';
			if ( data && data.body && data.body.fileIdsStr ) {
				fileIdsStr = data.body.fileIdsStr;
			}

			startModifyReply(fileIdsStr);
		};

		// 댓글 수정 시작
		var startModifyReply = function(fileIdsStr) {
			$.post('../reply/doModifyReplyAjax', {
				id : id,
				body : body,
				fileIdsStr: fileIdsStr
			}, onModifyReplyComplete, 'json');
		};

		// 댓글 수정이 완료되면 실행되는 함수
		var onModifyReplyComplete = function(data) {
			if (data.resultCode && data.resultCode.substr(0, 2) == 'S-') {
				// 성공시에는 기존에 그려진 내용을 수정해야 한다.!!
				$('.reply-list-box tbody > tr[data-id="' + id + '"]').data('data-originBody', body);
				$('.reply-list-box tbody > tr[data-id="' + id + '"] .reply-body').empty().append(body);
			}

			if ( data.msg ) {
				alert(data.msg);
			}

			ReplyList__hideModifyFormModal();
			ReplyList__submitModifyFormDone = false;
		};

		startUploadFiles();
	}

	function ReplyList__showModifyFormModal(el) {
		$('html').addClass('reply-modify-form-modal-actived');
		var $tr = $(el).closest('tr');
		var originBody = $tr.data('data-originBody');

		var id = $tr.attr('data-id');

		var form = $('.reply-modify-form-modal form').get(0);

		form.id.value = id;
		form.body.value = originBody;
	}

	function ReplyList__hideModifyFormModal() {
		$('html').removeClass('reply-modify-form-modal-actived');
	}

	// 5초
	ReplyList__loadMoreInterval = 1 * 5000;

	function ReplyList__loadMoreCallback(data) {
		if (data.body.replies && data.body.replies.length > 0) {
			ReplyList__lastLodedId = data.body.replies[data.body.replies.length - 1].id;
			ReplyList__drawReplies(data.body.replies);
		}

		setTimeout(ReplyList__loadMore, ReplyList__loadMoreInterval);
	}

	function ReplyList__loadMore() {

		$.get('../reply/getForPrintReplies', {
			articleId : param.id,
			from : ReplyList__lastLodedId + 1
		}, ReplyList__loadMoreCallback, 'json');
	}

	function ReplyList__drawReplies(replies) {
		for (var i = 0; i < replies.length; i++) {
			var reply = replies[i];
			ReplyList__drawReply(reply);
		}
	}

	function ReplyList__delete(el) {
		if (confirm('삭제 하시겠습니까?') == false) {
			return;
		}

		var $tr = $(el).closest('tr');

		var id = $tr.attr('data-id');

		$.post('./../reply/doDeleteReplyAjax', {
			id : id
		}, 'json');
	}

	function ReplyList__drawReply(reply) {
		var html = '';
		html += '<tr data-id="' + reply.id + '">';
		html += '<td>' + reply.id + '</td>';
		html += '<td>';
		html += '<div class="reply-body">' + reply.body + '</div>';
		html += '</td>';
		html += '<td class="visible-on-md-up">' + reply.extra.writer + '</td>';
		html += '<td class="visible-on-md-up">' + reply.regDate + '</td>';
		
		html += '<td>';

		if (reply.extra.actorCanModify) {
			html += '<button class="btn btn-info" type="button" onclick="ReplyList__showModifyFormModal(this);">수정</button>';
		}

		if (reply.extra.actorCanDelete) {
			html += '<button class="btn btn-danger" type="button" onclick="ReplyList__delete(this);">삭제</button>';
		}

		html += '</td>';

		html += '<td class="visible-on-sm-down">';


    	html += '<div class="flex flex-row-wrap flex-ai-c">';
        html += '<span class="badge badge-primary bold margin-right-10">' + reply.id + '</span>';
        html += '<div class="writer">' + reply.extra.writer + '</div>';
        html += '&nbsp; | &nbsp;';
        html += '<div class="reg-date">' + reply.regDate + '</div>';
        html += '<div class="width-100p"></div>';
        html += '<div class="body flex-1-0-0 margin-top-10 reply-body">' + reply.body + '</div>';
        html += '</div>';

        html += '<div class="margin-top-10 btn-inline-box">';

        if (reply.extra.actorCanModify) {
            html += '<button class="btn btn-info" type="button" onclick="ReplyList__showModifyFormModal(this);">수정</button>';
        }
        
        if (reply.extra.actorCanDelete) {
            html += '<button class="btn btn-danger" type="button" onclick="ReplyList__delete(this);">삭제</button>';
        }

        html += '</div>';

        html += '</td>';
        html += '</tr>';

        var $tr = $(html);
        $tr.data('data-originBody', reply.body);
        ReplyList__$tbody.prepend($tr);
	}

	ReplyList__loadMore();
</script>

<%@ include file="../part/foot.jspf"%>