<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    <head>
        <title>매물찾기</title>
        <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

        <link rel="stylesheet" type="text/css" href="/web-resources/scss/map/map.css">
        <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/paginator.css">

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
                    <div class="gps-control" onclick="mapManager.gps()">
                        <span>
                            <i class="fas fa-dot-circle aba"></i>
                            <p>GPS</p>
                        </span>
                    </div>
                    <div class="search-bar">
                        <input id="searchForm" type="text" placeholder="지역, 매물번호를 입력하세요!"
                               onfocus="searchResults($(this).val())"
                               onkeyup="searchResults($(this).val())"
                        >
                        <button type="button" class="search-btn">
                            <img src="/web-resources/img/svg/search-24px.svg" class="search-icon">
                        </button>
                        <div class="search-result" hidden>
                            <header class="result-header">
                                <div class="f-c" id="toggle" style="position: absolute; right: 15px; top: 20px; cursor: pointer">
                                    <i class="aba fas" onclick="searchToggle('hide')">&nbsp;닫기</i>
                                </div>
                                <span>
                                    <i class="fas fa-map-marker-alt"></i>
                                    <label id="result-type"></label>
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
        showLoader();
        mapManager.drawOverlays(1, mapManager.getSouthWest(), mapManager.getNorthEast());

        const pageInfo = getOffersOfMap(mapManager.getSouthWest(), mapManager.getNorthEast(), null, 1);
        mapManager.updateOffersAndPages(1, pageInfo);

        $(".overlay").click(function () { searchToggle('hide'); });

        let offerTypeIndex = getUrlParameter('type');
        if(offerTypeIndex !== undefined) {
            $('#offerType').children().eq(offerTypeIndex).find('label').click();
        }

        let keyword = getUrlParameter('keyword');
        if(keyword !== undefined) {
            $('#searchForm').val(keyword);
            searchResults(keyword);
        }
    });

    // TODO) pagingCaller()의 역할이 모호함
    function pagingCaller(page, isPrev = null, region = "") {
        if(isPrev !== null) {
            mapManager.pageHelper.prevOrNext(page, () => {})
        }

        let pageInfo = region !== "" ?
            getOffersOfMap(null, null, region, page) :
            getOffersOfMap(mapManager.southWest, mapManager.northEast, null, page);

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

    function searchResults(keyword) {
        clearTimeout(timeOut);

        let idRegex = new RegExp("^[0-9]*");
        let matcher = idRegex.exec(keyword);

        if (keyword === '' || keyword === ' ') {
            searchToggle('hide');
            return
        }

        timeOut = setTimeout(() => {
            const selector = $('.result > ul');
            let results = [];
            let result = '';

            selector.empty();
            selector.removeClass('f-c aba');

            if(matcher[0].length !== 0) {
                results = getOffersByIdKeyword(matcher[0]);

                $('#result-type').text('매물번호');
                errorBind(results, selector);

                results.map((offer) => {
                    result = offer.offerId + '번 매물 => ' + offer.jibun;

                    const element = $(`<li>` + result + `</li>`);
                    element.on('click', () => { clickOfSearchResult(4, offer)});

                    selector.append(element);
                })
            } else {
                results = getOverlaysByKeyword(keyword);

                $('#result-type').text('행정구역');
                errorBind(results, selector);

                results.map((overlay) => {
                    result = overlay.weight !== 1 ? overlay.belongsTo + ' ' + overlay.name : overlay.name;

                    const element = $(`<li>` + result + `</li>`);
                    element.on('click', () => { clickOfSearchResult(overlay.weight, overlay); });

                    selector.append(element);
                })
            }

            searchToggle('show');
        }, 300);
    }

    function errorBind(results, selector) {
        if(results.length === 0) {
            selector.addClass('f-c aba');
            selector.html(`<h2 class="align-center">결과가 존재하지 않아요 :(</h2>`);
            return
        }
    }

    function clickOfSearchResult(weight, clicked) {
        const level = mapManager.getLevelByWeight(weight);
        const lat = Number(clicked.latitude);
        const lng = Number(clicked.longitude);

        mapManager.setLevel(level, {});
        mapManager.setCenter(lat, lng);
        mapManager.relayout();
        mapManager.eventTrigger();

        const clickTargetId = (lat + lng).toString().replace('.', '');

        $('#' + clickTargetId).children().click();
    }
</script>
