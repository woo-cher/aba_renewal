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
    <div class="overlay" style="background: black;" hidden></div>
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
                                        <label for="dealType${vs.index}" onclick="test($(this))">${type.value}</label>
                                    </li>
                                </c:forEach>
                                <div class="error-box"></div>
                            </ul>
                            <div id="salePriceBox" class="pt-3" hidden><br>
                                <div class="form-label align-center">
                                    <span class="px-3">매매가</span>
                                    <input type="text" class="aba middle txt-md" id="sale-amount" readonly style="border:0; font-weight:bold;">
                                </div>
                                <div class="form-control">
                                    <div id="sale-slider-range" class="slider"></div>
                                </div>
                            </div>
                            <div id="depositBox" class="pt-3" hidden>
                                <div class="form-label align-center pt-3 my-3">
                                    <span class="px-3">보증금</span>
                                    <input type="text" class="aba middle txt-md" id="deposit-amount" readonly style="border:0; font-weight:bold;">
                                </div>
                                <div class="form-control">
                                    <div id="deposit-slider-range" class="slider"></div>
                                </div>
                            </div><br>
                            <div id="monthlyPriceBox" class="pt-3" hidden>
                                <div class="form-label align-center">
                                    <span class="px-3">월세</span>
                                    <input type="text" class="aba middle txt-md" id="monthly-amount" readonly style="border:0; font-weight:bold;">
                                </div>
                                <div class="form-control">
                                    <div id="monthly-slider-range" class="slider"></div>
                                </div>
                            </div>
                        </div>
                    </section>
                    <section class="form-control mt-0" hidden>
                        <div class="form-warp">
                            <div class="form-label align-center">
                                <span>입주날짜는 정해졌나요?</span>
                            </div>
                            <ul class="checkbox-container form type pt-1 pl-0 check-area flex-center">
                                <li class="checkbox-list w-65">
                                    <input id="date" class="middle" type="text" hidden>
                                    <input id="yes" type="radio" name="aa" value="" class="check">
                                    <label for="yes" onclick="">예, 확정일이 있습니다.
                                        <span id="date-area" class="aba"></span>
                                    </label>
                                </li>
                            </ul>
                            <ul class="checkbox-container form type pt-1 pl-0 check-area flex-center">
                                <li class="checkbox-list w-65">
                                    <input id="no" type="radio" name="aa" value="" class="check">
                                    <label for="no" onclick="">아니오, 희망 월만 있어요</label>
                                </li>
                            </ul>
                            <div class="align-center">
                                <select class="w-65">
                                    <option value="">선택</option>
                                    <option>9월</option>
                                    <option>10월</option>
                                    <option>11월</option>
                                    <option>12월</option>
                                </select>
                            </div>
                        </div>
                    </section>

                    <section class="form-control mt-0" hidden>
                        <div class="offer-type">
                            <div class="form-label align-center">
                                <span>희망유형을 선택해주세요 (복수가능)</span>
                            </div>
                            <ul class="checkbox-container form type pt-1 check-area">
                                <c:forEach begin="1" var="type" items="${offerTypes}" varStatus="vs">
                                    <li class="checkbox-list half">
                                        <input id="offerType${vs.index}" type="checkbox" name="type" value="${type.code}" class="check">
                                        <label for="offerType${vs.index}">${type.value}</label>
                                    </li>
                                </c:forEach>
                                <div class="error-box"></div>
                            </ul>
                        </div>
                    </section>

                    <section class="form-control mt-0" hidden>
                        <div class="form-label">
                            <i class="fas fa-circle"></i>
                            <span>평수 선택</span>
                        </div>
                        <div class="form-control align-center">
                            <a class="select-box" id="select-pyeong">
                                <span class="txt" id="pyeong-txt">평수 선택</span>
                                <span class="icon">
                                    <img src="/img/basic/keyboard_arrow_down-24px.svg">
                                </span>
                                <input type="hidden" id="pyeong">
                            </a>
                            <div id="pyeong-dialog" title="" hidden>
                                <li>10평 이하</li>
                                <li>10평 이상</li>
                                <li>20평 이상</li>
                                <li>30평 이상</li>
                                <li>40평 이상</li>
                            </div>
                        </div>

                        <div class="form-label">
                            <i class="fas fa-circle"></i>
                            <span>방</span>
                        </div>
                        <div class="form-control align-center">
                            <a class="select-box" id="select-room">
                                <span class="txt" id="room-txt">방 갯수</span>
                                <span class="icon">
                                    <img src="/img/basic/keyboard_arrow_down-24px.svg">
                                </span>
                                <input type="hidden" id="room">
                            </a>
                            <div id="room-dialog" title="" hidden>
                                <li>1개(원룸) 이상</li>
                                <li>2개(투룸) 이상</li>
                                <li>3개(쓰리룸) 이상</li>
                                <li>4개(포룸) 이상</li>
                            </div>
                        </div>
                    </section>

                    <section class="form-control mt-0" hidden>
                        <div class="form-label align-center">
                            <span>직장, 학교 등 이사할 집에서 이동을 고려할 장소가 있으세요?</span>
                        </div>
                        <div class="form-control">
                            <div class="form-label">
                                <i class="fas fa-circle"></i>
                                <span>장소1</span>
                            </div>
                            <a class="select-box" onclick="getAddress()">
                                <input readonly type="text" class="txt p-0" id="jibun" style="border: 0; margin: 0;" placeholder="장소,주소,지역"></input>
                                <span class="icon">
                                        <img src="/img/svg/search-24px.svg">
                                </span>
                                <input type="hidden" id="road">
                            </a>
                        </div>

                        <div class="form-control">
                            <div class="form-label">
                                <i class="fas fa-circle"></i>
                                <span>장소2</span>
                            </div>
                            <a class="select-box" onclick="getAddress('jibun2')">
                                <input readonly type="text" class="txt p-0" id="jibun2" style="border: 0; margin: 0;" placeholder="장소,주소,지역"></input>
                                <span class="icon">
                                        <img src="/img/svg/search-24px.svg">
                                </span>
                            </a>
                        </div>
                    </section>

                    <section class="form-control mt-0" hidden>
                        <div class="form-warp">
                            <div class="form-label">
                                <span>반드시 고려해야 할 조건이 있으신가요?</span>
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

                    <section class="form-control mt-0" hidden>
                        <div class="form-warp">
                            <div class="form-label align-center">
                                <span>필요한 요구사항을 간단히 적어주세요!</span>
                            </div>
                            <div class="form-control">
                                <textarea class="w-full" name="request" style="resize: none; height: 200px; padding: 2%;"></textarea>
                            </div>
                        </div>
                    </section>

                    <section class="form-control mt-0" hidden>

                    </section>

                    <div class="form-control">
                        <div class="align-center">
                            <button type="button" class="login-button" onclick="processNavigator(true)">다음</button>
                        </div>
                    </div>
                </div>
            </form>
        </article>
    </div>
</body>
</html>

<script>
    $('#select-pyeong').on('click', function () {
        $('.overlay').toggle();
        $('#pyeong-dialog').dialog({
            close: function (event, ui) {
                $('.overlay').toggle();
            }
        });
    });

    $('#select-room').on('click', function () {
        $('.overlay').toggle();
        $('#room-dialog').dialog({
            close: function (event, ui) {
                $('.overlay').toggle();
            }
        });
    });

    $('#pyeong-dialog > li').click(function (e) {
        let val = e.currentTarget.innerHTML;

        $('#pyeong').val(val);
        $('#pyeong-txt').text(val);
        $('#pyeong-dialog').dialog('close');
    });

    $('#room-dialog > li').click(function (e) {
        let val = e.currentTarget.innerHTML;

        $('#room').val(val);
        $('#room-txt').text(val);
        $('#room-dialog').dialog('close');
    });

    $(document).ready(function () {
        $('#date').datepicker({
            dateFormat: 'yy.mm.dd',
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            dayNames: ['일','월','화','수','목','금','토'],
            dayNamesShort: ['일','월','화','수','목','금','토'],
            dayNamesMin: ['일','월','화','수','목','금','토'],
            showMonthAfterYear: true,
            changeMonth: true,
            yearSuffix: '년',
            onSelect: function () {
                $("#date-area").text("(" + $(this).val() + ")");
            }
        });

        $('#yes').click(function () {
            $('#date').datepicker('show');
        })
    });

    function test(el) {
        let code = el.prev('input').val();

        if(code === "MONTHLY") {
            $("#monthlyPriceBox").show();
            $("#depositBox").show();
            $("#salePriceBox").hide();
        } else if(code === "SALE") {
            $("#salePriceBox").show();
            $("#depositBox").hide();
            $("#monthlyPriceBox").hide();
        } else {
            $("#depositBox").show();
            $("#salePriceBox").hide();
            $("#monthlyPriceBox").hide();
        }
    }

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
            $("#sale-amount").val(($("#sale-slider-range").slider("values", 0) + 1) + "억원 ~ " + ($("#sale-slider-range").slider("values", 1) + 1) + "억원");
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

            $("#deposit-amount").val(convertPriceToString(priceFirst) + " ~ " + convertPriceToString(priceSecond));
        },
        create: function (event, ui) {
            setDepositSliderTicks(event.target);
            let priceFirst = $("#deposit-slider-range").slider("values", 0);
            let priceSecond = $("#deposit-slider-range").slider("values", 1);
            $("#deposit-amount").val(convertPriceToString(priceFirst) + " ~ " + convertPriceToString(priceSecond));
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
        values: [0, 40],
        slide: function(event, ui) {
            let priceFirst = ui.values[0];
            let priceSecond = ui.values[1];

            $("#monthly-amount").val(convertPriceToString(priceFirst) + " ~ " + convertPriceToString(priceSecond));
        },
        create: function (event, ui) {
            setMonthlySliderTicks(event.target);
            let priceFirst = $("#monthly-slider-range").slider("values", 0);
            let priceSecond = $("#monthly-slider-range").slider("values", 1);
            $("#monthly-amount").val(convertPriceToString(priceFirst) + " ~ " + convertPriceToString(priceSecond));
        }
    });

    function setMonthlySliderTicks(el) {
        let $slider =  $(el);
        let max =  $slider.slider("option", "max");
        let min =  $slider.slider("option", "min");
        let spacing =  100 / (max - min);

        $slider.find('.ui-slider-tick-mark').remove();
        for (let i = 0; i <= max-min ; i+=50) {
            $('<span class="ui-slider-tick-mark"><h5 class="thous">' + convertPriceToString(i) + '</h5></span>').css('left', (spacing * i) +  '%').appendTo($slider);
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
