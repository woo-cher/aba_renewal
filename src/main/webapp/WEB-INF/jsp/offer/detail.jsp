<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>매물상세페이지 공인중개사</title>

    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">
    <link rel="stylesheet" type="text/css" href="/web-resources/css/albery.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/offer_detail.css">

    <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
    <%@include file="../commons/map.jspf"%>
    <script src="/web-resources/js/albery.js"></script>
</head>

<body>
<div class="main-container" id="main">
    <a href="#main" class="go-top">
        <i class="fas fa-arrow-alt-circle-up"></i>
    </a>
    <!-- 매물옵션 상단바 -->
    <div class="offer-header">
        <div class="header-warp">
            <ul>
                <li onclick="location.href='#offer-info'"><a>매물 정보</a></li>
                <li onclick="location.href='#offer-option'"><a>옵션</a></li>
                <li onclick="location.href='#offer-desc'"><a>상세 설명</a></li>
                <li onclick="location.href='#offer-location'"><a>매물 위치</a></li>
            </ul>
        </div>
    </div>

    <!-- 매물정보  -->
    <div class="offer-info container" id="offer-info">
        <!-- 매물정보 헤드부분 -->
        <div class="info-summary">
            <div class="top01">
                <h3>${offer.type.value}</h3>
                <h4>
                    ${offer.dealType.value} ${offer.deposit}/${offer.monthlyPrice} +
                    <strong>${offer.managementPrice}</strong>
                </h4>
            </div>
            <div class="top02">
                <h3>매물번호
                <c:choose>
                    <c:when test="${isPremium}">${offer.id}</c:when>
                    <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
                </c:choose></h3>
                <h2>
                    매물상태 : ${offer.status.value}
                </h2>
            </div>
            <div class="top03">
                <!-- 공인중개사 페이지 신고아이콘 부분 -->
                <div class="icon-wrap">
                    <div class="icon-group">
                        <a href="#">
                            <img src="/web-resources/img/offer/detail_icon01.png" alt="정보변경신고">
                            <p>정보변경신고</p>
                        </a>
                        <a href="#">
                            <img src="/web-resources/img/offer/detail_icon02.png" alt="거래완료신고">
                            <p>거래완료신고</p>
                        </a>
                        <a href="#">
                            <img src="/web-resources/img/offer/detail_head_icon-01.png" alt="찜하기 아이콘">
                            <p>찜하기</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 매물정보 표 -->
        <div class="info-table">
            <div class="table-wrap">
                <div class="row bb">
                    <p class="key">소재지</p>
                    <p class="value">
                        <c:choose>
                            <c:when test="${isPremium}">${offer.offerAddress.jibun}</c:when>
                            <c:otherwise>${offer.offerAddress.belongsTo} ***-**</c:otherwise>
                        </c:choose>
                    </p>
                    <p class="key">도로명</p>
                    <p class="value">
                        <c:choose>
                            <c:when test="${isPremium}">${offer.offerAddress.road}</c:when>
                            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <div class="row bb">
                    <p class="key">관리비</p>
                    <p class="value aba">${offer.managementPrice} 만원</p>
                    <p class="key">준공년도</p>
                    <p class="value">${offer.completionYear} 년</p>
                </div>
                <div class="row bb">
                    <p class="key">반려동물</p>
                    <p class="value">${offer.offerAddition.canPet ? "가능" : "불가능"}</p>
                    <p class="key">주차</p>
                    <p class="value">${offer.offerAddition.canParking ? "가능" : "불가능"}</p>
                </div>
                <div class="row bb">
                    <p class="key">룸호실</p>
                    <p class="value">
                        <c:choose>
                            <c:when test="${isPremium}">${offer.offerAddress.ho}</c:when>
                            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
                        </c:choose>
                    </p>
                    <p class="key">세입자</p>
                    <p class="value">${offer.offerAddition.tenant}</p>
                </div>
                <div class="row">
                    <p class="key">단기임대</p>
                    <p class="value">
                        ${offer.offerAddition.term == null ? "불가능" : offer.offerAddition.term}
                        ${offer.offerAddition.term == null ? "" : "개월"}
                    </p>
                    <p class="key">중요위치</p>
                    <p class="value">
                        ${offer.offerAddress.nearLocation == null ? "정보없음" : offer.offerAddress.nearLocation}
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- 슬라이드 배너 -->
    <section id="jquery-script-menu">
        <div class="container">
            <div class="albery-container">
                <div class="albery-wrapper">
                    <c:forEach var="image" begin="0" items="${offer.imageUrls}" varStatus="vs">
                        <div class="albery-item">
                            <img src="${image.url}">
                        </div>
                    </c:forEach>
                </div>

                <div class="move-right">
                    <img src="/web-resources/img/offer/detail_slide_next.png" class="c-pointer" id="rightArrow">
                </div>
                <div class="move-left">
                    <img src="/web-resources/img/offer/detail_slide_prev.png" class="c-pointer" id="leftArrow">
                </div>

            </div>

            <div class="pagination-container">
                <div class="pagination-wrapper">
                    <c:forEach var="image" begin="1" items="${offer.imageUrls}" varStatus="vs">
                        <div class="pagination-item" data-item="${vs.index}">
                            <img src="${image.url}">
                        </div>
                    </c:forEach>
                </div>
            </div>
    </section>

    <div class="img-caption">
        <div class="caption-group">
            <div class="caption">
                <p>아바에서 직접 확인한 정보입니다<br>
                    <strong>최종 확인일 ${offer.updatedAt.toLocaleString()}</strong><br>
                    거래가능 여부는 시시각각 변하며, 방호수에 따라 구조, 옵션의 차이가<br>
                    있을 수 있으니 정확한 정보는 직접 문의를 통해 확인해주세요.
                </p>
            </div>
            <div class="download">
                <a href="#" class="btn">
                    <img src="/web-resources/img/downicon-02.png" alt="">
                </a>
            </div>
        </div>
    </div>

    <!-- 옵션&관리비 항목 -->
    <div class="offer-option" id="offer-option">
        <div class="option">
            <div class="line"></div>
            <h3>옵션</h3>
            <ul class="list">
                <c:forEach var="optionType" items="${offer.offerAddition.optionTypes}" varStatus="vs">
                    <li>
                        <img src="/web-resources/img/offer/option-${vs.index + 1}.png">
                        <h2>${optionType.value}</h2>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="management-category">
            <div class="line"></div>
            <h3>관리비 포함 항목</h3>
            <ul class="list">
                <c:forEach var="manageType" items="${offer.offerAddition.managementTypes}" varStatus="vs">
                    <li>
                        <img src="/web-resources/img/offer/manage-${vs.index + 1}.png">
                        <h2>${manageType.value}</h2>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <!-- 상세설명 -->
    <div class="offer-desc" id="offer-desc">
        <div class="desc-wrap">
            <div class="line"></div>
            <h3>상세설명</h3>
            <div class="desc">
                <p>${offer.description}</p>
            </div>
        </div>
    </div>

    <!-- 매물위치 -->
    <div class="offer-location" id="offer-location">
        <div class="location-wrap">
            <div class="line"></div>
            <h3>매물 위치</h3>
            <div class="map">
                <h2>
                    <c:if test="${isPremium}">${offer.offerAddress.jibun}</c:if>
                <div id="map-location" style="width: 75%; height: 400px; margin: 0 auto"></div>
                <p>본 매물의 위치는 반경 가로 100m x 세로 100m 의 임의 설정 값으로 정확한 위치가 아닙니다.</p>
            </div>
<%--            <div class="road-map">--%>
<%--                <img src="/web-resources/img/offer/roadview.jpg" alt="">--%>
<%--            </div>--%>
        </div>
    </div>
</div>

<!-- footer -->
<%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
</body>
</html>

<script type="text/javascript">
    $(document).ready(function () {
        console.log('${isPremium}')
    <c:choose>
        <c:when test="${isPremium}">
        let lat = ${offer.offerAddress.latitude};
        let lng = ${offer.offerAddress.longitude};

        let map = new kakao.maps.Map(document.getElementById("map-location"), {
            center: new kakao.maps.LatLng(${offer.offerAddress.latitude}, ${offer.offerAddress.longitude}),
            level: 3,
            minLevel: 2,
            maxLevel: 3
        });

        let imageSrc = '/web-resources/img/offer/detail_map_icon.png',
            imageSize = new kakao.maps.Size(25, 35),
            imageOption = { offset: new kakao.maps.Point(20, 35) }; // ??
            let marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(lat, lng),
                image: new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
            });

            marker.setMap(map);
        </c:when>
        <c:otherwise>
            let selector = $('#map-location');
            selector.addClass('f-c');
            selector.css('border', '1px solid gray');
            selector.append(`<i class="fas fa-lock" style="font-size: 5rem;"></i>`)
        </c:otherwise>
    </c:choose>
    });

    $(".albery-container").albery({
        speed: 500,
        imgWidth: 780,
    });
</script>
