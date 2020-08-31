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

<style>	
	@media (min-width :1050px) {
		.firstAidList {
		 	max-width: 1200px;
			width: 100%;
			border: 1px solid rgb(160, 160, 160, 0.5);
			border-radius: 10px;
			padding-top: 20px;	
			margin-top: 20px;
			margin-bottom: 20px;
			margin-left: auto;
 			margin-right: auto;
		}
		.firstAidList > ul {
			font-size: 0;
		}
		.firstAidList > ul > li {
			display: inline-block;
			vertical-align: top;
			width: 24.8%;
		}
		.firstAidList > ul > li > a h3 {
			font-size: 14px;
			text-aligh: center;
			padding: 10px;
			color: #666;
		}
	}
	
	@media (max-width :1050px) {
		.firstAidList > ul > li {
			display: block;
			vertical-align: top;
			width: 100%;
		}
		.firstAidList > ul > li > a h3 {
			font-size: 18px;
			text-aligh: center;
			padding: 10px;
			color: #666;
		}
		.firstAidList > ul > li > a h3:hover {
			color: blue;
			font-weight: bold;
			font-size: 20px;
		}
		.firstAidList > ul > li > a .screen {
			display: none;
		}
	}
	.firstAidList > ul > li > a {
		display: block;
		width: auto;
		text-decoration: none;
		margin: 5px;
	}
	.firstAidList > ul > li > a .screen {
		position: relative;
		overflow: hidden;
		background-color: #4BAF4B;
		border-radius:10px;
	}
	.firstAidList > ul > li > a .screen .top {
		position: absolute;
		bottom: 150%;
		left: 30px;
		z-index: 2;
		color: #fff;
		font-size: 26px;
		font-weight: 900;
		transition: all .35s;
	}
	.firstAidList > ul > li > a .screen .bottom {
		position: absolute;
		top: 150%;
		left: 30px;
		z-index: 2;
		color: #fff;
		font-size: 12px;
		transition: all .35s;
	}
	.firstAidList > ul > li > a .screen img {
		width: 100%;
	}
	
	.firstAidList > ul > li > a:hover .top {
		bottom: 52%;
	}
	.firstAidList > ul > li > a:hover .bottom {
		top: 52%;
	}
	.firstAidList > ul > li > a .screen::after {
		content: '';
		display: block;
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, .5);
		z-index: 1;
		opacity: 0;
		transiton: all .35s;
	}
	.firstAidList > ul > li > a:hover .screen::after {
		opacity: 1;
	}
</style>
	
<div class="firstAidList">
	<ul>
		<li><a href="https://terms.naver.com/entry.nhn?docId=2099713&cid=51010&categoryId=51010" target="_blank">
				<div class="screen">
					<div class="top">우리동네 응급처치</div>
					<div class="bottom">by 우리동네</div>
					<img src="/resource/img/logo2W.png" />
				</div>
				<div>
					<h3><i class="fas fa-arrow-right"></i> 심폐 소생술</h3>
				</div>
			</a>
		</li>
		<li><a href="https://terms.naver.com/entry.nhn?docId=2099716&cid=51010&categoryId=51010" target="_blank">
				<div class="screen">
					<div class="top">우리동네 응급처치</div>
					<div class="bottom">by 우리동네</div>
					<img src="/resource/img/logo2W.png" />
				</div>
				<div>
					<h3><i class="fas fa-arrow-right"></i> 기도 이물 폐쇄</h3>
				</div>
			</a>
		</li>
		<li><a href="https://terms.naver.com/entry.nhn?docId=2099712&cid=51010&categoryId=51010" target="_blank">
				<div class="screen">
					<div class="top">우리동네 응급처치</div>
					<div class="bottom">by 우리동네</div>
					<img src="/resource/img/logo2W.png" />
				</div>
				<div>
					<h3><i class="fas fa-arrow-right"></i> 자동 심장 충격기</h3>
				</div>
			</a>
		</li>
		<li><a href="https://terms.naver.com/entry.nhn?docId=2099718&cid=51010&categoryId=51010" target="_blank">
				<div class="screen">
					<div class="top">우리동네 응급처치</div>
					<div class="bottom">by 우리동네</div>
					<img src="/resource/img/logo2B.png" />
				</div>
				<div>
					<h3><i class="fas fa-arrow-right"></i> 증상별 적정 자세</h3>
				</div>
			</a>
		</li>
		<li><a href="https://terms.naver.com/entry.nhn?docId=2099722&cid=51010&categoryId=51010" target="_blank">
				<div class="screen">
					<div class="top">우리동네 응급처치</div>
					<div class="bottom">by 우리동네</div>
					<img src="/resource/img/logo2B.png" />
				</div>
				<div>
					<h3><i class="fas fa-arrow-right"></i> 동물 및 곤충에 물렸을 때</h3>
				</div>
			</a>
		</li>
		<li><a href="https://terms.naver.com/entry.nhn?docId=2099727&cid=51010&categoryId=51010" target="_blank">
				<div class="screen">
					<div class="top">우리동네 응급처치</div>
					<div class="bottom">by 우리동네</div>
					<img src="/resource/img/logo2B.png" />
				</div>
				<div>
					<h3><i class="fas fa-arrow-right"></i> 이물질이 들어갔을 때</h3>
				</div>
			</a>
		</li>
		<li><a href="https://terms.naver.com/entry.nhn?docId=2099733&cid=51010&categoryId=51010" target="_blank">
				<div class="screen">
					<div class="top">우리동네 응급처치</div>
					<div class="bottom">by 우리동네</div>
					<img src="/resource/img/logo2W.png" />
				</div>
				<div>
					<h3><i class="fas fa-arrow-right"></i> 중독 되었을 때</h3>
				</div>
			</a>
		</li>
		<li><a href="https://terms.naver.com/entry.nhn?docId=2099739&cid=51010&categoryId=51010" target="_blank">
				<div class="screen">
					<div class="top">우리동네 응급처치</div>
					<div class="bottom">by 우리동네</div>
					<img src="/resource/img/logo2W.png" />
				</div>
				<div>
					<h3><i class="fas fa-arrow-right"></i> 뼈 및 근육이 손상되었을 때</h3>
				</div>
			</a>
		</li>
		<li><a href="https://terms.naver.com/entry.nhn?docId=2099743&cid=51010&categoryId=51010" target="_blank">
				<div class="screen">
					<div class="top">우리동네 응급처치</div>
					<div class="bottom">by 우리동네</div>
					<img src="/resource/img/logo2W.png" />
				</div>
				<div>
					<h3><i class="fas fa-arrow-right"></i> 열 및 냉에 의한 손상이 되었을 때</h3>
				</div>
			</a>
		</li>
		<li><a href="https://terms.naver.com/entry.nhn?docId=2099749&cid=51010&categoryId=51010" target="_blank">
				<div class="screen">
					<div class="top">우리동네 응급처치</div>
					<div class="bottom">by 우리동네</div>
					<img src="/resource/img/logo2B.png" />
				</div>
				<div>
					<h3><i class="fas fa-arrow-right"></i> 사고에 의한 응급 상황일 때</h3>
				</div>
			</a>
		</li>
		<li><a href="https://terms.naver.com/entry.nhn?docId=2099753&cid=51010&categoryId=51010" target="_blank">
				<div class="screen">
					<div class="top">우리동네 응급처치</div>
					<div class="bottom">by 우리동네</div>
					<img src="/resource/img/logo2B.png" />
				</div>
				<div>
					<h3><i class="fas fa-arrow-right"></i> 응급 증상일 때</h3>
				</div>
			</a>
		</li>
		<li><a href="https://terms.naver.com/entry.nhn?docId=2099761&cid=51010&categoryId=51010" target="_blank">
				<div class="screen">
					<div class="top">우리동네 응급처치</div>
					<div class="bottom">by 우리동네</div>
					<img src="/resource/img/logo2B.png" />
				</div>
				<div>
					<h3><i class="fas fa-arrow-right"></i> 소아 응급 증상일 때</h3>
				</div>
			</a>
		</li>
	</ul>
</div>


<%@ include file="../part/foot.jspf"%>