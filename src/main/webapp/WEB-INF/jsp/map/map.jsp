<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <title>매물찾기</title>
        <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

        <link rel="stylesheet" type="text/css" href="/scss/map/map.css">

        <%@include file="../commons/map.jspf"%>
        <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
    </head>

    <body>
        <div class="main-container p-0">
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
                            <div class="result aba">
                                <h2>결과가 존재하지 않아요 :(</h2>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="offer-list">
                    <div class="list-header">
                        전체 방
                        <strong class="aba">1234개</strong>
                    </div>
                    <ul class="list-container"></ul>
                </div>
            </div>
        </div>
    </body>
</html>

<script>
    let mapManager = new MapManager(document.getElementById('map'));

    $(document).ready(() => {
        mapManager.drawOverlays(1, mapManager.getSouthWest(), mapManager.getNorthEast());
        mapManager.updateOffersAndPages();
    });

    function pagingCaller(pageNum, isPrev = null) {
        if(isPrev !== null) {
            if(isPrev) {
                mapManager.startPage -= 5;
            } else {
                mapManager.startPage += 5;
            }
        }

        mapManager.updateOffersAndPages(pageNum);
    }

    function searchToggle() {
        $(".search-result").toggle();
        $(".overlay").toggle();
    }
</script>
