<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="다음 지도" />
<%@ include file="../part/head.jspf"%>

<h1 class="con flex-jc-c">병원 찾기</h1>

<style>
	.administrative-district ul {
		background-color: #4BAF4B;
		border-radius: 10px;	
		width: 80%;
		padding: 10px;
		margin: 5px 0 15px 0;
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
		padding:10px 15px;
	}
</style>

<!-- 행정구역(동/면) 리스트 -->
<div class="administrative-district con">
	<nav>
		<div style="font-weight:bold; font-size: 1.2rem;">
			행정구역(동)
		</div>
	</nav>
	<ul class="flex">
		<li><a href="">한솔동</a></li>
		<li><a href="">도담동</a></li>
		<li><a href="">소담동</a></li>
		<li><a href="">새롬동</a></li>
		<li><a href="">보람동</a></li>
		<li><a href="">다정동</a></li>
		<li><a href="">아름동</a></li>
		<li><a href="">종촌동</a></li>
		<li><a href="">고운동</a></li>
		<li><a href="">대평동</a></li>
	</ul>
	<nav>
		<div style="font-weight:bold; font-size: 1.2rem;">
			행정구역(면)
		</div>
	</nav>
	<ul class="flex">
		<li><a href="">조치원읍</a></li>
		<li><a href="">연기면</a></li>
		<li><a href="">연동면</a></li>
		<li><a href="">부강면</a></li>
		<li><a href="">금남면</a></li>
		<li><a href="">장군면</a></li>
		<li><a href="">연서면</a></li>
		<li><a href="">전의면</a></li>
		<li><a href="">전동면</a></li>
		<li><a href="">소정면</a></li>
	</ul>
</div>

<!-- 병원 목록 -->
<div class="con flex-jc-c">
	<div class="con" id="map" style="width:100%; height:700px;"></div>
	<div class="con" style="width:40%; height:700px; padding-left: 20px;">
		<ul>
			<li>
				<a href="">1번 병원</a>
				<ul>
					<li><a href="">위치</a></li>
					<li><a href="">번호</a></li>
					<li><a href="">24시 운영여부</a></li>
					<li><a href="">주말 운영여부</a></li>
				</ul>			
			</li>
			<li><a href="">2번 병원</a></li>
			<li><a href="">3번 병원</a></li>
			<li><a href="">4번 병원</a></li>
		</ul>
	</div>
</div>

<!-- 카카오맵 -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=510e37db593be13becad502aecab0d79&libraries=clusterer"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(36.49334, 127.27856), // 지도의 중심좌표
        level: 6, // 지도의 확대 레벨
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
	var 데이터 = [
		[36.511513, 127.258927, '<div style="padding:5px;">도램마을 8단지</div>'],
		[36.514043, 127.263682, '<div style="padding:5px;">도담 고등학교</div>'],
		[36.514494, 127.254835, '<div style="padding:5px;">늘봄 초등학교</div>'],
		[36.511590, 127.262530, '<div style="padding:5px;">도담 초등학교</div>']
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
		    map: map, // 인포윈도우가 표시될 지도
		    position : iwPosition, 
		    content : 데이터[i][2],
		    removable : iwRemoveable
		});

		// 생성된 마커를 마커 저장하는 변수에 넣음
		markers.push(marker);

	 	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
	    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
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