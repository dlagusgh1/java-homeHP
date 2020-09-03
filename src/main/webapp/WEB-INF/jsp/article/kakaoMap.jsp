<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!-- JSTL 데이터 포맷 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="병원/약국 찾기" />
<%@ include file="../part/head.jspf"%>

<h1 class="con flex-jc-c">당직 병원 / 약국 찾기</h1>

<div class="cateItem con flex-jc-c">
	<select name="cateItemName" id="cateItem" onchange="if(this.value) location.href=(this.value);">
		<option>찾기선택</option>	
		<option value="kakaoMap">당직 병원/약국 (${organ_ALLCount})</option>
		<option value="kakaoMap_HP">당직 병원 (${organ_HPCount})</option>
		<option value="kakaoMap_PM">당직 약국 (${organ_PMCount})</option>
		<option value="kakaoMap_All">모든 병원/약국</option>
	</select>
</div>

<!-- 행정구역(동/면) 리스트(administrativeDistrict) -->
<div class="administrative-district con">
	<nav>
		<div>
			행정구역(동/읍/면)&nbsp&nbsp
			<select name="adCateItemName" id="adCateItem" onchange="administrative(this.value)">
				<option>행정구역 선택</option>
				<c:forEach items="${adCateItems}" var="adCateItem">
					<c:set var="count" value="0" />
					<c:forEach items="${organes}" var="organ">
						<c:if test="${organ.organAdmAddress == adCateItem.name && count == 0}">
							<option value="${adCateItem.name}" style="height: 50px;">${adCateItem.name}</option>
							<c:set var="count" value="${count + 1}" />
						</c:if>
					</c:forEach>
				</c:forEach>
			</select>
		</div>
	</nav>
</div>

<!-- 병원 목록(organization) -->
<div class="kakaoMap-box con flex-jc-c margin-bottom-20">
	<div class="kakaoMap con" id="map"></div>
	<div class="kakaoMap-info con">
		<ul>
			<li>
				<c:forEach items="${organes}" var="organ">
					<ul>
						<li><a style="font-size: 1.3rem; font-weight: bold;">${organ.organName}</a></li>
						<li><a>주소 : ${organ.organAddress}</a></li>
						<li><a>행정구역 : ${organ.organAdmAddress}</a></li>
						<li><a>전화 번호 : ${organ.organTel}</a></li>
						<li><a>진료 시간 : ${organ.organTime}</a></li>
						<li><a>진료 시간(주말) : ${organ.organWeekendTime}</a></li>
						<li><a>주말 운영여부 : ${organ.organWeekend}</a></li>
						<li><a>비고 : ${organ.organRemarks}</a></li>
					</ul>		
					<br>
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
        center: new kakao.maps.LatLng(36.478631, 127.270530), // 지도의 중심좌표
        level: 7, // 지도의 확대 레벨
        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
    }; 
    
	// 지도를 생성한다 
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 마커 클러스터러를 생성합니다 
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 6, // 클러스터 할 최소 지도 레벨 
        styles: [{
        	width : '60px', height : '60px',
            background: 'rgba(75, 175, 75, .8)',
            borderRadius: '30px',
            color: 'white',
            textAlign: 'center',
            fontWeight: 'bold',
            lineHeight: '61px'
        }]
    });
    
	// 지도 타입 변경 컨트롤을 생성한다
	var mapTypeControl = new kakao.maps.MapTypeControl();

	// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);	

	// 지도에 확대 축소 컨트롤을 생성한다
	var zoomControl = new kakao.maps.ZoomControl();

	// 지도의 우측에 확대 축소 컨트롤을 추가한다
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);	
	
	// 마커 이미지
	var imageSrc = 'https://img.icons8.com/clouds/100/000000/hospital.png', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(70, 70), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
      
	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

	// 마커들을 저장할 변수 생성
	var markers = [];


	// 다중 마커 생성
	var 데이터 = [		
			<c:forEach items="${organes}" var="organ">
				[
					${organ.organLocation1}, 
					${organ.organLocation2}, 
					'<div class="map_marker"><div class="map_marker_header">${organ.organName}</div><nav>주소 : ${organ.organAddress}</nav><nav>행정구역 : (${organ.organAdmAddress}) / 전화 : ${organ.organTel}</nav><nav>진료시간 : ${organ.organTime}</nav><nav>진료시간(주말) : ${organ.organWeekendTime}</nav><nav>주말운영여부 : ${organ.organWeekend}</nav><nav>비고 : ${organ.organRemarks}</nav></div>', 
					'${organ.organAdmAddress}'
				],
			</c:forEach>
		];

	// select박스 onchange로 넘겨받은 행정구역 값에 해당하는 마커 생성
	function administrative(adCateItemName) {

		// 클러스터 지우기
		clusterer.clear();
		// 기존 마커들 지우기.
		removeMarker();

		var adCateName = adCateItemName;

		var arr = [];
		var x = 0;
		for ( var i = 0; i < 데이터.length; i++ ) {

			if (adCateName == 데이터[i][3]) {
				arr.push(i);
				x++;
			}
		}

		// 2차원 배열 생성 함수
		function create2DArray(rows, columns) {
		    var 선택된데이터 = new Array(rows);
		    for (var i = 0; i < rows; i++) {
		    	선택된데이터[i] = new Array(columns);
		    }
		    return 선택된데이터;
		}

		// 함수를 이용하여 2차원 배열 생성 (선택된데이터[x][3] 생성 됨)
		var 선택된데이터 = create2DArray(x, 3);
		
		for ( var i = 0; i < arr.length; i++ ) {
			// arr.length = 2 => 0, 1
			for ( var k = i; k <= i; k++ ) {
				// x = 2, 0 1    arr 0 = 0 1, arr 1 = 0 1
				선택된데이터[i][0] = 데이터[arr[i]][0],
				선택된데이터[i][1] = 데이터[arr[i]][1],
				선택된데이터[i][2] = 데이터[arr[i]][2]
			}
		}
		
		for (var i = 0; i < 선택된데이터.length; i++ ) {
			// 지도에 마커를 생성하고 표시한다.
			marker = new kakao.maps.Marker({
				position: new kakao.maps.LatLng(선택된데이터[i][0], 선택된데이터[i][1]), // 마커의 좌표
				map: map, // 마커를 표시할 지도 객체
				image: markerImage // 마커에 이미지 추가
			});

			iwPosition = new kakao.maps.LatLng(선택된데이터[i][0], 선택된데이터[i][1]),
		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

			// 인포윈도우를 생성하고 지도에 표시합니다
			infowindow = new kakao.maps.InfoWindow({
			    //map: map, // 인포윈도우가 표시될 지도
			    position : iwPosition, 
			    content : 선택된데이터[i][2],
			    removable : iwRemoveable
			});

			// 생성된 마커를 마커 저장하는 변수에 넣음
			markers.push(marker);

		 	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
		    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
		    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
		    kakao.maps.event.addListener(
	    	    marker, 
	    	    'click',
	    	    makeClickListener(map, marker, infowindow)
	   	    );
		    
		}
		
		// 클러스터러에 마커들을 추가합니다
	    clusterer.addMarkers(markers);
	}
	
	
	for (var i = 0; i < 데이터.length; i++ ) {
		// 지도에 마커를 생성하고 표시한다.
		var marker = new kakao.maps.Marker({
			position: new kakao.maps.LatLng(데이터[i][0], 데이터[i][1]), // 마커의 좌표
			map: map, // 마커를 표시할 지도 객체
			image: markerImage // 마커에 이미지 추가
		});

		iwPosition = new kakao.maps.LatLng(데이터[i][0], 데이터[i][1]),
	    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

		// 인포윈도우를 생성하고 지도에 표시합니다
		var infowindow = new kakao.maps.InfoWindow({
		    //map: map, // 인포윈도우가 표시될 지도
		    position : iwPosition, 
		    content : 데이터[i][2],
		    removable : iwRemoveable
		});

		// 생성된 마커를 마커 저장하는 변수에 넣음
		markers.push(marker);

	 	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
	    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    kakao.maps.event.addListener(
    	    marker, 
    	    'click',
    	    makeClickListener(map, marker, infowindow)
   	    );
	    
	}
	
	// 클러스터러에 마커들을 추가합니다
    clusterer.addMarkers(markers);

	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
    function makeClickListener(map, marker, infowindow) {
        // 마커 위에 인포윈도우를 표시합니다
	  
        return function() {
        	infowindow.open(map, marker);  
        };
    } 	

 	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}
	
</script>

<%@ include file="../part/foot.jspf"%>