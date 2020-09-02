<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>매물 찾아주세요!</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/scss/component/form.css">
    <link rel="stylesheet" type="text/css" href="/scss/offer_request_create.css">

    <script src="/js/kakao/ajax/ajax-repository.js"></script>
    <script src="/js/kakao/kakao-address.js"></script>
    <script src="/js/validator.js"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">

    <%@include file="/WEB-INF/jsp/commons/tempory_header.jspf"%>
</head>

<body>
    <div class="main-container">
        <article class="content-wrap">
            <div class="content-name" id="top">
                <h3>
                    <span class="aba">내집</span>
                    <span class="header mini">찾아주세요</span>
                </h3>
            </div>

            <form action="/offers/create" id="offerForm" method="post" enctype="multipart/form-data">
                <input type="submit" id="submit" hidden>
                <div id="formWrap">
                    <section class="form-control mt-0">
                        <div class="form-warp">
                            <div class="form-label align-center">
                                <span>원하는 계약조건을 선택하세요 :)</span>
                            </div>
                            <ul class="checkbox-container form type pt-1 check-area">
                                <c:forEach begin="1" var="type" items="${dealTypes}" varStatus="vs">
                                    <li class="checkbox-list">
                                        <input id="dealType${vs.index}" type="radio" name="dealType" value="${type.code}" class="check">
                                        <label for="dealType${vs.index}">${type.value}</label>
                                    </li>
                                </c:forEach>
                                <div class="error-box"></div>
                            </ul>
                            <div id="salePriceBox">
                                <div class="form-label align-center">
                                    <span>매매가</span>
                                    <input type="text" class="aba middle txt-md" id="sale-amount" readonly style="border:0; font-weight:bold;">
                                </div>
                                <div class="form-control">
                                    <div id="sale-slider-range" class="slider"></div>
                                </div>
                            </div>
                            <div id="depositBox" class="pt-3">
                                <div class="form-label align-center">
                                    <span>보증금</span>
                                    <input type="text" class="aba middle txt-md" id="deposit-amount" readonly style="border:0; font-weight:bold;">
                                </div>
                                <div class="form-control">
                                    <div id="deposit-slider-range" class="slider"></div>
                                </div>
                            </div>
                            <div id="monthlyPriceBox" class="pt-3">
                                <div class="form-label align-center">
                                    <span>월세</span>
                                    <input type="text" class="aba middle txt-md" id="monthly-amount" readonly style="border:0; font-weight:bold;">
                                </div>
                                <div class="form-control">
                                    <div id="monthly-slider-range" class="slider"></div>
                                </div>
                            </div>
                            <div class="align-center pt-3">
                                <button type="button" class="login-button" onclick="processNavigator(true)">다음</button>
                            </div>
                        </div>
                    </section>
<%--                    <section class="form-control mt-0" hidden>--%>
<%--                        <div class="form-warp">--%>
<%--                            <div class="form-label">--%>
<%--                                <i class="fas fa-circle"></i>--%>
<%--                                <span>필수 선택 유형</span>--%>
<%--                            </div>--%>
<%--                            <ul class="checkbox-container form type pt-1 check-area">--%>
<%--                                <c:forEach begin="1" var="type" items="${conditions}" varStatus="vs">--%>
<%--                                    <li class="checkbox-list">--%>
<%--                                        <input id="required${vs.index}" type="checkbox" name="required" value="${type.code}" class="check">--%>
<%--                                        <label for="required${vs.index}">${type.value}</label>--%>
<%--                                    </li>--%>
<%--                                </c:forEach>--%>
<%--                                <div class="error-box"></div>--%>
<%--                            </ul>--%>
<%--                        </div>--%>
<%--                    </section>--%>
                </div>
            </form>
        </article>
    </div>
</body>
</html>

<script>
    function convertPriceToString(price) {
        if(price === 0) {
            return price + "원";
        }

        if (price.toString().length <= 4) {
            return price + "만";
        } else {
            return (price / 10000).toString() + "억";
        }
    }
    $("#sale-slider-range").slider({
        range: true,
        min: 0,
        max: 19,
        step: 1,
        values: [2, 4],
        slide: function(event, ui) {
            $("#sale-amount").val((ui.values[0] + 1) + "억원 - " + (ui.values[1] + 1) + "억원");
        },
        create: function (event, ui) {
            setSliderTicks(event.target);
            $("#sale-amount").val(($("#sale-slider-range").slider("values", 0) + 1) + "억원 - " + ($("#sale-slider-range").slider("values", 1) + 1) + "억원");
        }
    });

    function setSliderTicks(el) {
        let $slider =  $(el);
        let max =  $slider.slider("option", "max");
        let min =  $slider.slider("option", "min");
        let spacing =  100 / (max - min);

        $slider.find('.ui-slider-tick-mark').remove();
        for (let i = 0; i <= max-min ; i++) {
            if((i + 6) % 5 === 0 || i === 0) {
                $('<span class="ui-slider-tick-mark"><h5>' + (i + 1) + '억<h5></span>').css('left', (spacing * i) +  '%').appendTo($slider);
            } else {
                $('<span class="ui-slider-tick-mark"></span>').css('left', (spacing * i) +  '%').appendTo($slider);
            }
        }
    }

    $("#deposit-slider-range").slider({
        range: true,
        min: 0,
        max: 100000,
        step: 1000,
        values: [2000, 10000],
        slide: function(event, ui) {
            let priceFirst = ui.values[0];
            let priceSecond = ui.values[1];

            $("#deposit-amount").val(convertPriceToString(priceFirst) + " - " + convertPriceToString(priceSecond));
        },
        create: function (event, ui) {
            setDepositSliderTicks(event.target);
            let priceFirst = $("#deposit-slider-range").slider("values", 0);
            let priceSecond = $("#deposit-slider-range").slider("values", 1);
            $("#deposit-amount").val(convertPriceToString(priceFirst) + " - " + convertPriceToString(priceSecond));
        }
    });

    function setDepositSliderTicks(el) {
        let $slider =  $(el);
        let max =  $slider.slider("option", "max");
        let min =  $slider.slider("option", "min");
        let spacing =  100 / (max - min);

        $slider.find('.ui-slider-tick-mark').remove();
        for (let i = 0; i <= max-min ; i+=10000) {
            $('<span class="ui-slider-tick-mark"><h5>' + convertPriceToString(i) + '<h5></span>').css('left', (spacing * i) +  '%').appendTo($slider);
        }
    }

    $("#monthly-slider-range").slider({
        range: true,
        min: 0,
        max: 500,
        step: 5,
        values: [30, 40],
        slide: function(event, ui) {
            let priceFirst = ui.values[0];
            let priceSecond = ui.values[1];

            $("#monthly-amount").val(convertPriceToString(priceFirst) + " - " + convertPriceToString(priceSecond));
        },
        create: function (event, ui) {
            setMonthlySliderTicks(event.target);
            let priceFirst = $("#monthly-slider-range").slider("values", 0);
            let priceSecond = $("#monthly-slider-range").slider("values", 1);
            $("#monthly-amount").val(convertPriceToString(priceFirst) + " - " + convertPriceToString(priceSecond));
        }
    });

    function setMonthlySliderTicks(el) {
        let $slider =  $(el);
        let max =  $slider.slider("option", "max");
        let min =  $slider.slider("option", "min");
        let spacing =  100 / (max - min);

        $slider.find('.ui-slider-tick-mark').remove();
        for (let i = 0; i <= max-min ; i+=50) {
            $('<span class="ui-slider-tick-mark"><h5>' + convertPriceToString(i) + '</h5></span>').css('left', (spacing * i) +  '%').appendTo($slider);
        }
    }

    let formIndex = 0;

    function processNavigator(isNext) {
        const selector = $("#formWrap");

        selector.children().eq(formIndex).hide();

        if(isNext) {
            selector.children().eq(++formIndex).show()
        } else {
            selector.children().eq(--formIndex).show()
        }
    }

    switchContentViewWithIndex('#leftNav > li', '.form-control', '#formWrap');
</script>
