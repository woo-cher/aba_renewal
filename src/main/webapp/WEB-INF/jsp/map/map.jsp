<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <title>매물찾기</title>
        <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

        <link rel="stylesheet" type="text/css" href="/scss/map/map.css">

        <script type="text/javascript" src="/js/kakao/kakao-map.js"></script>
        <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
    </head>

    <body>
        <div class="overlay" hidden></div>

        <%-- Filter area --%>
        <%@include file="/WEB-INF/jsp/map/filter_bar.jsp"%>

        <div class="map-container">
            <div id="map" class="map">
                <div class="search-bar">
                    <input type="text" placeholder="지역, 매물번호를 입력하세요!"
                           onfocus="location.href=`javascript:searchToggle()`"
                           onfocusout="location.href=`javascript:searchToggle()`"
                    >
                    <button type="button" class="search-btn">
                        <img src="/img/svg/search-24px.svg" class="search-icon">
                    </button>
                    <div class="search-result" hidden>
                        <header class="result-header">
                            <span>
                                <i class="fas fa-map-marker-alt"></i>
                                행정구역
                            </span>
                        </header>
                        <div class="result">
                            <h2>결과가 존재하지 않아요 :(</h2>
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="/WEB-INF/jsp/map/offer_list.jsp"%>
        </div>

    </body>
</html>

<script>
    var container = document.getElementById('map');
    var options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 3
    };

    var map = new kakao.maps.Map(container, options);

    function searchToggle() {
        $(".search-result").toggle();
        $(".overlay").toggle();
    }
</script>
