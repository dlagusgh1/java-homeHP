<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="회원 관리" />


<%@ include file="../part/head.jspf"%>

<h1 class="con flex-jc-c">회원 관리</h1>

<div class="con flex-jc-c margin-bottom-10">
	<a class="btn btn-info" href="/adm/member/memberGrantLevel" onclick="window.open(this.href,'권한 설정', 'width=950px, height=550px, scrollbars=no, resizeble=0, directories=0' ); return false;">권한 설정하기</a>
</div>

<div class="table-box table-box-data memberManage-table-box con">
	<table>
		<colgroup>
			<col width="100" />
           	<col width="100" />
           	<col width="150" />
           	<col width="150" />
           	<col width="200" />
           	<col width="50" />
           	<col width="200" />
		</colgroup>
		<thead>
			<tr >
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>기관명</th>	
				<th>등록일자</th>	
				<th>상태</th>
				<th>비고</th>						
			</tr>
			
		</thead>
		<tbody>
			<c:if test="${loginedMember.level == 10}">
				<c:forEach items="${members}" var="member">
					<c:if test="${member.name != '관리자'}">
						<tr>
							<td><a>${member.id}</a></td>
							<td><a>${member.loginId}</a></td>	
							<td><a>${member.name}</a></td>	
							<td><a>${member.organName}</a></td>	
							<td><a>${member.regDate}</a></td>	
							<td>
							<c:if test="${member.delStatus}">
								탈퇴
							</c:if>
							<c:if test="${member.delStatus != true}">
								정상
							</c:if>
							</td>
							<td>
							<c:if test="${member.delStatus}">
								<button class="btn btn-info" type="button" onclick="member__recovery(this,'${member.loginId}');">복구</button>
							</c:if>
							<c:if test="${member.delStatus != true}">
								<button class="btn btn-danger" type="button" onclick="member__Delete(this,'${member.loginId}');">정지</button>
							</c:if>
							</td>				
							<td class="visible-on-sm-down">
								<a class="flex flex-row-wrap flex-ai-c">
			                      	<span class="badge badge-primary bold margin-right-10">${member.id}</span>
				                  	<div class="title flex-1-0-0 text-overflow-el">${member.loginId}</div>
				                  	<div class="title flex-1-0-0 text-overflow-el">${member.organName}</div>
				                  	<div class="itle flex-1-0-0 text-overflow-el">
					                  	<c:if test="${member.delStatus}">
					                  		<button class="btn btn-info" type="button" onclick="member__recovery(this,'${member.loginId}');">복구</button>
										</c:if>
										<c:if test="${member.delStatus != true}">
											<button class="btn btn-danger" type="button" onclick="member__Delete(this,'${member.loginId}');">정지</button>
										</c:if>
			                      	</div>
			                  	</a>
			               	</td>
						</tr>
					</c:if>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>	

<script>
	//회원 권한 ajax
	

	// 회원 복구 ajax
	function member__recovery(el, memberLoginId) {
		if (confirm('복구처리 하시겠습니까?') == false) {
			return;
		}
		
		$.post('./../member/doMemberRecoveryAjax', {
			loginId : memberLoginId
		}, 'json');
	}

	// 회원 탈퇴(숨기기) ajax
	function member__Delete(el, memberLoginId) {
		if (confirm('탈퇴처리 하시겠습니까?') == false) {
			return;
		}
		
		$.post('./../member/doMemberDeleteAjax', {
			loginId : memberLoginId
		}, 'json');
	}

</script>
	
<%@ include file="../part/foot.jspf"%>