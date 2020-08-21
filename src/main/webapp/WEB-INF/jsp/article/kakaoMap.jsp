<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="병원 찾기 카카오맵" />
<%@ include file="../part/head.jspf"%>

<h1 class="con flex-jc-c">병원 찾기</h1>

<style>
	.administrative-district ul {
		background-color: #4BAF4B;
		border-radius: 10px;	
		width: 100%;
		padding: 10px 0px;
		margin: 5px 0 7px 0;
		text-align: center;
	}
	.administrative-district ul li {
		color: white;
		text-align: center;
	}
	.administrative-district ul li:hover {
		color: black;
	}
	
	.administrative-district ul li a {
		padding:10px 5px;
		font-size: 1rem;
		margin-left: 5px;
	}

	.map_marker {
		padding:5px; 
		width: 400px;
	}
</style>

<!-- 행정구역(동/면) 리스트 -->
<div class="administrative-district con">
	<nav>
		<div style="font-weight:bold; font-size: 1.5rem;">
			행정구역(동/읍/면)
		</div>
	</nav>
	<ul class="flex">
		<c:forEach items="${adCateItems}" var="adCateItem">
			<li><a href="">${adCateItem.name}</a></li>
		</c:forEach>
	</ul>
</div>
<!--  
 기관명 : 엔케이(NK) 세종 병원
 기관주소 : 세종 한누리대로 161
 전화번호 : 044-850-7700
 진료시간 : 24시간
 주말운영여부 : 토요일 / 일요일 운영
 비고 : 응급실 운영기관
-->
<!-- 병원 목록 -->
<div class="con flex-jc-c">
	<div class="con" id="map" style="width:100%; height:650px; border: 2px solid green;"></div>
	<div class="con" style="width:40%; height:700px; padding-left: 20px;">
		<ul>
			<li>
				<a href="">기관명</a>
				<ul>
					<li><a href="">	- 주소 : </a></li>
					<li><a href="">	- 전화 번호 : </a></li>
					<li><a href="">	- 진료 시간 : </a></li>
					<li><a href="">	- 주말 운영여부 : </a></li>
					<li><a href="">	- 비고 : </a></li>
				</ul>			
			</li>
		</ul>
	</div>
</div>

<!-- 카카오맵 -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=510e37db593be13becad502aecab0d79&libraries=clusterer"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(36.504171, 127.267834), // 지도의 중심좌표
        level: 7, // 지도의 확대 레벨
        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
    }; 
    
	// 지도를 생성한다 
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 마커 클러스터러를 생성합니다 
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 6 // 클러스터 할 최소 지도 레벨 
    });
    
	// 지도 타입 변경 컨트롤을 생성한다
	var mapTypeControl = new kakao.maps.MapTypeControl();

	// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);	

	// 지도에 확대 축소 컨트롤을 생성한다
	var zoomControl = new kakao.maps.ZoomControl();

	// 지도의 우측에 확대 축소 컨트롤을 추가한다
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	// 다중 마커 생성
	// [좌표, '<div class="map_marker">기관명<br>- 주소 : (동)<br>- 전화 : <br>- 진료시간 : <br>- 주말운영여부 : <br>- 비고 : </div>'],
	var 데이터 = [
		[36.479739, 127.262182, '<div class="map_marker">엔케이(NK) 세종 병원<br>- 주소 : 세종 한누리대로 161(나성동)<br>- 전화 : 044-850-7700<br>- 진료시간 : 24시간<br>- 주말운영여부 : 토요일 / 일요일 운영<br>- 비고 : 응급실 운영기관</div>'],
		[36.502449, 127.248440, '<div class="map_marker">한사랑 의원<br>- 주소 : 세종 도움1로 106 (메가시티) 5층(종촌동)<br>- 전화 : 044-867-3569<br>- 진료시간 : 09:00 ~ 22:00<br>- 주말운영여부 : 토요일 / 일요일 운영<br>- 비고 : 내과</div>'],
		[36.507817, 127.258666, '<div class="map_marker">매일연합 의원<br>- 주소 : 세종 절재로 154 (홈플러스 세종점)(어진동)<br>- 전화 : 044-864-7975<br>- 진료시간 : 10:00 ~ 21:00<br>- 주말운영여부 : 토요일 / 일요일 운영<br>- 비고 : 매월 2, 4째주 일요일 휴무</div>'],
		[36.505392, 127.233847, '<div class="map_marker">365열린연합 의원<br>- 주소 : 세종 마음로 74 (그랜드 프라자) 3층(고운동)<br>- 전화 : 044-864-7757<br>- 진료시간 : 09:00 ~ 22:00 / 토요일 09:00 ~ 17:00<br>- 주말운영여부 : 토요일 운영<br>- 비고 : 가정의학과</div>'],
		[36.503031, 127.249820, '<div class="map_marker">곰돌이 소아청소년과 의원<br>- 주소 : 세종 달빛로 47 (종촌파크 프라자) 3층(종촌동)<br>- 전화 : 044-866-0275<br>- 진료시간 : 09:00 ~ 21:00 / 주말 및 공휴일 09:00 ~ 16:00<br>- 주말운영여부 : 토요일 / 일요일 운영<br>- 비고 : 소아과</div>'],
		[36.504356, 127.249962, '<div class="map_marker">세종 아이소아청소년과 의원<br>- 주소 : 세종 달빛로 59 (호만빌딩) 3층(종촌동)<br>- 전화 : 044-864-0800<br>- 진료시간 : 08:00 ~ 21:00 / 주말 및 공휴일 09:00 ~ 16:00<br>- 주말운영여부 : 토요일 / 일요일 운영<br>- 비고 : 소아과</div>'],
		[36.511513, 127.248695, '<div class="map_marker">웰키즈 소아청소년과 의원<br>- 주소 : 세종 보듬3로 95 (해피라움3) 4층(아름동)<br>- 전화 : 044-868-4880<br>- 진료시간 : 08:00 ~ 22:00 / 주말 및 공휴일 09:00 ~ 21:00<br>- 주말운영여부 : 토요일 / 일요일 운영<br>- 비고 : 소아과</div>'],
		[36.486285, 127.252042, '<div class="map_marker">라온 소아청소년과 의원<br>- 주소 : 세종 새롬중앙로 62-15 (해피라움W) 3층(새롬동)<br>- 전화 : 044-866-1350<br>- 진료시간 : 08:30 ~ 21:00 / 주말 및 공휴일 09:00 ~ 16:00<br>- 주말운영여부 : 토요일 / 일요일 운영<br>- 비고 : 소아과 </div>'],
		[36.502456, 127.248438, '<div class="map_marker">세종 가톨릭 정형외과 의원<br>- 주소 : 세종 도움1로 106 (메가시티) 4층(종촌동)<br>- 전화 : 044-867-7171<br>- 진료시간 : 09:00 ~ 20:00 / 토요일 및 공휴일 09:00 ~ 13:00<br>- 주말운영여부 : 토요일 운영<br>- 비고 : 정형외과</div>'],
		[36.504590, 127.249708, '<div class="map_marker">제일 한의원<br>- 주소 : 세종 도움3로 105-7 (메디케어빌딩)(종촌동)<br>- 전화 : 044-862-2555<br>- 진료시간 : 10:00 ~ 20:00 / 주말 및 공휴일 10:00 ~ 16:00<br>- 주말운영여부 : 토요일 / 일요일 운영<br>- 비고 : 한의원</div>'],
		[36.471025, 127.250953, '<div class="map_marker">모드니 치과 의원<br>- 주소 : 세종 금송로 687 (이마트 세종점)(가람동)<br>- 전화 : 044-864-2876<br>- 진료시간 : 10:00 ~ 21:00 / 주말 10:00 ~ 18:00<br>- 주말운영여부 : 토요일 / 일요일 운영<br>- 비고 : 치과 / 수요일, 매월 2, 4째주 일요일 휴무</div>'],
		[36.485157, 127.252407, '<div class="map_marker">새롬 숲 치과 의원<br>- 주소 : 세종 새롬중앙로 34 (크리스마스 빌딩) 3층(새롬동)<br>- 전화 : 044-999-2577<br>- 진료시간 : 10:00 ~ 21:00 / 토요일 10:00 ~ 16:00<br>- 주말운영여부 : 토요일 운영<br>- 비고 : 치과 / 수요일, 공휴일 휴무</div>'],
		[좌표, '<div class="map_marker">기관명<br>- 주소 : (동)<br>- 전화 : <br>- 진료시간 : <br>- 주말운영여부 : <br>- 비고 : </div>'],
		[좌표, '<div class="map_marker">기관명<br>- 주소 : (동)<br>- 전화 : <br>- 진료시간 : <br>- 주말운영여부 : <br>- 비고 : </div>'],
		[좌표, '<div class="map_marker">기관명<br>- 주소 : (동)<br>- 전화 : <br>- 진료시간 : <br>- 주말운영여부 : <br>- 비고 : </div>'],
		[좌표, '<div class="map_marker">기관명<br>- 주소 : (동)<br>- 전화 : <br>- 진료시간 : <br>- 주말운영여부 : <br>- 비고 : </div>'],
		[좌표, '<div class="map_marker">기관명<br>- 주소 : (동)<br>- 전화 : <br>- 진료시간 : <br>- 주말운영여부 : <br>- 비고 : </div>'],
		[좌표, '<div class="map_marker">기관명<br>- 주소 : (동)<br>- 전화 : <br>- 진료시간 : <br>- 주말운영여부 : <br>- 비고 : </div>'],
		[좌표, '<div class="map_marker">기관명<br>- 주소 : (동)<br>- 전화 : <br>- 진료시간 : <br>- 주말운영여부 : <br>- 비고 : </div>'],
		[좌표, '<div class="map_marker">기관명<br>- 주소 : (동)<br>- 전화 : <br>- 진료시간 : <br>- 주말운영여부 : <br>- 비고 : </div>'],
		[좌표, '<div class="map_marker">기관명<br>- 주소 : (동)<br>- 전화 : <br>- 진료시간 : <br>- 주말운영여부 : <br>- 비고 : </div>'],
		[좌표, '<div class="map_marker">기관명<br>- 주소 : (동)<br>- 전화 : <br>- 진료시간 : <br>- 주말운영여부 : <br>- 비고 : </div>'],
		[좌표, '<div class="map_marker">기관명<br>- 주소 : (동)<br>- 전화 : <br>- 진료시간 : <br>- 주말운영여부 : <br>- 비고 : </div>'],
	];

	// 마커들을 저장할 변수 생성
	var markers = [];
	for (var i = 0; i < 데이터.length; i++ ) {
		// 지도에 마커를 생성하고 표시한다.
		var marker = new kakao.maps.Marker({
			position: new kakao.maps.LatLng(데이터[i][0], 데이터[i][1]), // 마커의 좌표
			map: map // 마커를 표시할 지도 객체
		});

		iwPosition = new kakao.maps.LatLng(데이터[i][0], 데이터[i][1]),
	    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

		// 인포윈도우를 생성하고 지도에 표시합니다
		var infowindow = new kakao.maps.InfoWindow({
		    //map: map, // 인포윈도우가 표시될 지도
		    //position : iwPosition, 
		    content : 데이터[i][2],
		    //removable : iwRemoveable
		});

		// 생성된 마커를 마커 저장하는 변수에 넣음
		markers.push(marker);

	 	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
	    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    kakao.maps.event.addListener(
    	    marker, 
    	    'mouseover',
    	    makeOverListener(map, marker, infowindow)
   	    );
	    kakao.maps.event.addListener(
    	    marker, 
    	    'mouseout', 
    	    makeOutListener(infowindow)
   	    );
	}	

	// 클러스터러에 마커들을 추가합니다
    clusterer.addMarkers(markers);
	
 	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
    function makeOverListener(map, marker, infowindow) {
        return function() {
            infowindow.open(map, marker);
        };
    }

    // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
    function makeOutListener(infowindow) {
        return function() {
            infowindow.close();
        };
    }
</script>

<%@ include file="../part/foot.jspf"%>