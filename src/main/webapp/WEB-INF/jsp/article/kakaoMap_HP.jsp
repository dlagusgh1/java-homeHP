<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="병원 찾기" />
<%@ include file="../part/head.jspf"%>

<style>
	.kakaoMap {
		width:100%; 
		height:650px; 
		border: 2px solid green; 
		margin-right: 10px;
	}
	.kakaoMap-info {
		width:100%; 
		height:650px; 
		overflow:auto; 
		border: 2px solid green;
		text-indent: 1rem;
	}
	.administrative-district div {
		font-weight:bold; 
		font-size: 1.5rem;
	}
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
	
	.administrative-district ul li a , .cate ul li a{
		padding:10px 5px;
		font-size: 1rem;
		margin-left: 5px;
	}

	.map_marker {
		padding:10px; 
		width: 550px;
		
	}
	.map_marker_header {
		font-size: 1.2rem;
		font-weight:bold;
	}
	.map_marker nav {
		padding: 3px 0;
		text-indent: 1rem;
	}
</style>

<h1 class="con flex-jc-c">병원 찾기</h1>

<div class="cate con flex-jc-c">
	<ul class="flex">
		<li><a href="kakaoMap">전체</a></li>
		<li><a href="kakaoMap_HP">병원</a></li>
		<li><a href="kakaoMap_PM">약국</a></li>
		<li><a href="kakaoMap_All">그외 작업중</a></li>
	</ul>	
</div>


<!-- 행정구역(동/면) 리스트 -->
<div class="administrative-district con">
	<nav>
		<div>
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
	<div class="kakaoMap con" id="map"></div>
	<div class="kakaoMap-info con">
		<ul>
			<li>
				<c:forEach items="${organes}" var="organ">
					<c:choose>
						<c:when test="${organ.organNumber == 1}">
							<ul>
								<li><a style="font-size: 1.3rem; font-weight: bold;">${organ.organName}</a></li>
								<li><a>주소 : ${organ.organAddress} (${organ.organAdmAddress})</a></li>
								<li><a>전화 번호 : ${organ.organTel}</a></li>
								<li><a>진료 시간 : ${organ.organTime}</a></li>
								<li><a>진료 시간(주말) : ${organ.organWeekendTime}</a></li>
								<li><a>주말 운영여부 : ${organ.organWeekend}</a></li>
								<li><a>비고 : ${organ.organRemarks}</a></li>
							</ul>		
							<br>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</c:forEach>	
			</li>
		</ul>
	</div>
</div>

<!-- 카카오맵 -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=510e37db593be13becad502aecab0d79&libraries=clusterer"></script>
<script>
	var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
	contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
	markers = [], // 마커를 담을 배열입니다
	currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다

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
	
	//for(var i = 1; i < ${fn:length(organes)}; i++ ) {
	
	var 데이터 = [
		<c:forEach items="${organes}" var="organ">
			<c:choose>
				<c:when test="${organ.organNumber == 1}">
					[${organ.organLocation1}, ${organ.organLocation2}, '<div class="map_marker"><div class="map_marker_header">${organ.organName}</div><nav>주소 : ${organ.organName} (${organ.organAdmAddress})</nav><nav>전화 : ${organ.organTel}</nav><nav>진료시간 : ${organ.organTime}</nav><nav>진료시간(주말) : ${organ.organWeekendTime}</nav><nav>주말운영여부 : ${organ.organWeekend}</nav><nav>비고 : ${organ.organRemarks}</nav></div>'],
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</c:forEach>
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