<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="당직 의료기관 찾기" />
<%@ include file="../part/head.jspf"%>

<style>			

	#main{
		background: url("/resource/img/main1.png") center center / cover no-repeat;
		width:100vm;
		height:100vh;
		z-index:-2;
	}	
	#contents{
		position:absolute;
		top: 50%;
		transform: translateY(-50%);
		width:100%;
		color: white;
		font-weight: bold;	
		text-align: center;
		text-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -0.5px black;		
	}
	#contents::after {
		position:absolute;
		top: 53%;
  		left: 0;
		transform: translateY(-50%);
		width: 100%;
 		height: 100%;
		z-index: -1;
	 	content: "";
		background: black;
		opacity: 0.5;
		padding: 10px 0;
	}
	#contents h1 {
		font-size: 5rem;
		margin-bottom: 16px;
	}
	#contents p {
		font-size: 2rem;
		margin-bottom: 16px;
	}
    .main-contents {
		display: inline-block;
		width: 150px;
		height: 100%;
		vertical-align: middle;
		padding: 10px 0;
		border: 5px solid #4BAF4B;
		border-radius: 100px;
		font-weight: bold;	
	 	background-color: #4BAF4B;
	 	color: white;	
	 	font-size: 1.2rem;
	 	text-shadow: none;
	}
	.main-contents:not(:last-child) {
		margin-right: 20px;
	}
	#contents a:hover {
		color: black;
		text-shadow: none;
	}	
</style>

<div id="main">
	<div id="contents">
		<h1>우리동네</h1>
		<p>방문을 환영합니다.</p>
			<div class="main-contents">
				<a href="/usr/article/kakaoMap">병원&약국 찾기</a>
			</div>
			<div class="main-contents">
				<a href="/usr/article/covid19Status"><span>COVID-19 현황</span></a>
			</div>
			<div class="main-contents">
				<a href="/usr/article/firstAid"><span>응급처치</span></a>
			</div>
	</div>
</div>

<%@ include file="../part/foot.jspf"%>