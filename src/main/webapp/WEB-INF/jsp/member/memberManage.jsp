<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="회원 관리" />


<%@ include file="../part/head.jspf"%>

<h1 class="con flex-jc-c">회원 관리</h1>

<div class="table-box table-box-data articleManage-table-box con">
	<table>
		<colgroup>
			<col width="100" />
           	<col width="100" />
           	<col width="150" />
           	<col width="150" />
           	<col width="200" />
           	<col width="50" />
           	<col width="50" />
           	<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>기관명</th>	
				<th>등록일자</th>	
				<th>상태</th>
				<th>권한</th>
				<th>비고</th>						
			</tr>
		</thead>
		<tbody>
			<c:if test="${loginedMember.level == 10}">
				<c:forEach items="${members}" var="member">
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
						<c:if test="${article.displayStatus != true}">
							정상
						</c:if>
						</td>
							<td><a>${member.level}</a></td>
						<td>
						<button class="btn btn-danger" type="button">권한</button>
						<c:if test="${member.delStatus}">
							<button class="btn btn-danger" type="button">복구</button>
						</c:if>
						<c:if test="${member.delStatus != true}">
							<button class="btn btn-info" type="button">탈퇴</button>
						</c:if>
						</td>				
						<td class="visible-on-sm-down">
							<a class="flex flex-row-wrap flex-ai-c">
		                      	<span class="badge badge-primary bold margin-right-10">${member.id}</span>
			                  	<div class="title flex-1-0-0 text-overflow-el">${member.loginId}</div>
			                  	<div class="title flex-1-0-0 text-overflow-el">${member.organName}</div>
			                  	<div class="reg-date">
				                  	<button class="btn btn-danger" type="button">권한</button>
				                  	<c:if test="${member.delStatus}">
				                  		<button class="btn btn-danger" type="button">복구</button>
									</c:if>
									<c:if test="${member.delStatus != true}">
										<button class="btn btn-info" type="button">탈퇴</button>
									</c:if>
		                      	</div>
		                  	</a>
		               	</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>	

	
<%@ include file="../part/foot.jspf"%>