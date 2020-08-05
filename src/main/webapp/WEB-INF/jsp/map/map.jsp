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
                               onfocus="searchOverlays($(this).val())"
                               onkeyup="searchOverlays($(this).val())"
                        >
                        <button type="button" class="search-btn">
                            <img src="/img/svg/search-24px.svg" class="search-icon">
                        </button>
                        <div class="search-result" hidden>
                            <header class="result-header">
                                <div class="f-c" id="toggle" style="position: absolute; right: 15px; top: 20px; cursor: pointer">
                                    <i class="aba fas" onclick="searchToggle('hide')">&nbsp;닫기</i>
                                </div>
                                <span>
                                    <i class="fas fa-map-marker-alt"></i>
                                    행정구역
                                </span>
                            </header>
                            <div class="result">
                                <ul></ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="offer-list">
                    <div class="list-header">
                        전체 방
                        <strong class="aba">? 개</strong>
                    </div>
                    <ul class="list-container"></ul>
                </div>
            </div>
        </div>
    </body>
</html>

<script>
    let mapManager = new MapManager(document.getElementById('map'));
    let timeOut;

    $(document).ready(() => {
        mapManager.drawOverlays(1, mapManager.getSouthWest(), mapManager.getNorthEast());

        const pageInfo = getOffersPageInfo(mapManager.getSouthWest(), mapManager.getNorthEast(), null, 1);
        mapManager.updateOffersAndPages(1, pageInfo);

        $(".overlay").click(function () { searchToggle('hide'); })
    });

    function pagingCaller(page, isPrev = null, region = "") {
        if(isPrev !== null) {
            if(page < 0 || page > mapManager.endPage) {
                return
            }

            if(isPrev) {
                mapManager.startPage -= 5;
            } else {
                mapManager.startPage += 5;
            }
        }

        let pageInfo = region !== "" ?
            getOffersPageInfo(null, null, region, page) :
            getOffersPageInfo(mapManager.southWest, mapManager.northEast, null, page);

        mapManager.updateOffersAndPages(page, pageInfo, region);
    }

    function searchToggle(action) {
        if(action === 'hide') {
            $(".search-result").hide();
            $(".overlay").hide();
        } else {
            $(".search-result").show();
            $(".overlay").show();
        }
    }

    function searchOverlays(keyword) {
        clearTimeout(timeOut);

        if (keyword === '' || keyword === ' ') {
            return
        }

        timeOut = setTimeout(() => {
            let overlays = getOverlaysByKeyword(keyword);
            let area = '';

            const selector = $('.result > ul');
            selector.empty();
            selector.removeClass('f-c aba');
            searchToggle('show');

            if(overlays.length === 0) {
                selector.addClass('f-c aba');
                selector.html(`<h2 class="align-center">결과가 존재하지 않아요 :(</h2>`);

                return
            }

            overlays.map((overlay) => {
                area = overlay.weight !== 1 ? overlay.belongsTo + ' ' + overlay.name : overlay.name;

                selector.append(`<li>` + area + `</li>`);
            })
        }, 300);
    }
</script>
