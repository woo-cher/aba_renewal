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
                            <div class="form-label align-center">
                                <span>매매가</span>
                                <input type="text" class="aba middle txt-md" id="amount2" readonly style="border:0; font-weight:bold;">
                            </div>
                            <div class="form-control">
                                <div id="slider-range" class="slider"></div>
                            </div>
                            <div class="align-center pt-3">
                                <button type="button" class="login-button" onclick="processNavigator(true)">다음</button>
                            </div>
                        </div>
                    </section>
                    <section class="form-control mt-0" hidden>
                        <div class="form-warp">
                            <div class="form-label">
                                <i class="fas fa-circle"></i>
                                <span>필수 선택 유형</span>
                            </div>
                            <ul class="checkbox-container form type pt-1 check-area">
                                <c:forEach begin="1" var="type" items="${conditions}" varStatus="vs">
                                    <li class="checkbox-list">
                                        <input id="required${vs.index}" type="checkbox" name="required" value="${type.code}" class="check">
                                        <label for="required${vs.index}">${type.value}</label>
                                    </li>
                                </c:forEach>
                                <div class="error-box"></div>
                            </ul>
                        </div>
                    </section>
                </div>
            </form>
        </article>
    </div>
</body>
</html>

<script>
    $("#slider-range").slider({
        range: true,
        min: 0,
        max: 19,
        step: 1,
        values: [2, 4],
        slide: function(event, ui) {
            $("#amount2").val((ui.values[0] + 1) + "억원 - " + (ui.values[1] + 1) + "억원");
        },
        create: function (event, ui) {
            setSliderTicks(event.target);
        }
    });
    $("#amount2").val(($("#slider-range").slider("values", 0) + 1) + "억원 - " + ($("#slider-range").slider("values", 1) + 1) + "억원");

    function setSliderTicks(el) {
        var $slider =  $(el);
        var max =  $slider.slider("option", "max");
        var min =  $slider.slider("option", "min");
        var spacing =  100 / (max - min);

        $slider.find('.ui-slider-tick-mark').remove();
        for (var i = 0; i <= max-min ; i++) {
            if((i + 6) % 5 === 0 || i === 0) {
                $('<span class="ui-slider-tick-mark"><h5>' + (i + 1) + '억<h5></span>').css('left', (spacing * i) +  '%').appendTo($slider);
            } else {
                $('<span class="ui-slider-tick-mark"></span>').css('left', (spacing * i) +  '%').appendTo($slider);
            }
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
