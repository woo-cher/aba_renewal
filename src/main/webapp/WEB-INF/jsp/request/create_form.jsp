<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>매물 찾아주세요!</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/form.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/offer_request_create.css">

    <script src="/web-resources/js/kakao/ajax/ajax-repository.js"></script>
    <script src="/web-resources/js/kakao/kakao-address.js"></script>
    <script src="/web-resources/js/validator.js"></script>
    <script src="/web-resources/js/offer-request/offer-request.js"></script>
    <script src="/web-resources/js/offer-request/request-validator.js"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">

    <%@include file="/WEB-INF/jsp/commons/tempory_header.jspf"%>
    <%@include file="../commons/map.jspf"%>
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

            <form action="/requests/create" id="requestForm" method="post" enctype="multipart/form-data">
                <input type="submit" id="submit" hidden>
                <div id="formWrap">
                    <section class="form-control mt-0 mb-0">
                        <div class="form-warp mb-0">
                            <div class="form-label align-center">
                                <span>원하는 계약조건을 선택하세요 :)</span>
                            </div>
                            <ul class="checkbox-container form type pt-1 check-area">
                                <c:forEach begin="1" var="type" items="${dealTypes}" varStatus="vs">
                                    <li class="checkbox-list">
                                        <input id="dealType${vs.index}" type="radio" name="dealType" value="${type.code}" class="check">
                                        <label for="dealType${vs.index}" onclick="sliderTrigger($(this))">${type.value}</label>
                                    </li>
                                </c:forEach>
                                <div class="error-box"></div>
                            </ul>
                            <div id="salePriceBox" class="" hidden><br>
                                <div class="form-label align-center">
                                    <span class="px-3">매매가</span>
                                    <input type="text" class="aba middle txt-md" id="sale-amount" name="salePrice"
                                           readonly style="border:0; font-weight:bold;">
                                </div>
                                <div class="form-control">
                                    <div id="sale-slider-range" class="slider"></div>
                                </div>
                            </div>
                            <div id="depositBox" class="" hidden>
                                <div class="form-label align-center my-3">
                                    <span class="px-3">전세보증금</span>
                                    <input type="text" class="aba middle txt-md" id="deposit-amount" name="deposit"
                                           readonly style="border:0; font-weight:bold;">
                                </div>
                                <div class="form-control">
                                    <div id="deposit-slider-range" class="slider"></div>
                                </div>
                            </div><br>
                            <div id="monthlyDepositBox" class="" hidden>
                                <div class="form-label align-center my-3">
                                    <span class="px-3">월세보증금</span>
                                    <input type="text" class="aba middle txt-md" id="monthly-deposit-amount" name="monthlyDeposit"
                                           readonly style="border:0; font-weight:bold;"
                                    >
                                </div>
                                <div class="form-control">
                                    <div id="monthly-deposit-slider-range" class="slider"></div>
                                </div>
                            </div><br>
                            <div id="monthlyPriceBox" class="pt-3" hidden>
                                <div class="form-label align-center">
                                    <span class="px-3">월세</span>
                                    <input type="text" class="aba middle txt-md" id="monthly-amount" name="monthlyPrice"
                                           readonly style="border:0; font-weight:bold;">
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
                                    <input id="yes" type="radio" name="moveInOpener" class="check">
                                    <label for="yes" onclick="$('#want-move').hide()">예, 확정일이 있습니다.
                                        <span id="date-area" class="aba"></span>
                                    </label>
                                </li>
                            </ul>
                            <ul class="checkbox-container form type pt-1 pl-0 check-area flex-center">
                                <li class="checkbox-list w-65">
                                    <input id="no" type="radio" name="moveInOpener" class="check" onchange="wantMoveTrigger()">
                                    <label for="no">아니오, 희망 월만 있어요</label>
                                </li>
                            </ul>
                            <div class="form-control align-center" id="want-move" hidden>
                                <a class="select-box" id="select-moveIn">
                                    <span class="txt" id="moveIn-txt">11월중</span>
                                    <span class="icon">
                                    <img src="/web-resources/img/basic/keyboard_arrow_down-24px.svg">
                                </span>
                                    <input type="hidden" id="moveIn" name="moveIn">
                                </a>
                                <div id="moveIn-dialog" title="" hidden></div>
                            </div>
                        </div>
                    </section>

                    <section class="form-control mt-0" hidden>
                        <div class="offer-type">
                            <div class="form-label align-center">
                                <span>희망유형을 선택해주세요 (복수가능)</span>
                            </div>
                            <ul class="checkbox-container form type p-0 pt-1 flex-center check-area">
                                <c:forEach begin="1" var="type" items="${offerRequestTypes}" varStatus="vs">
                                    <li class="checkbox-list half">
                                        <input id="offerRequestTypes${vs.index}" type="checkbox" name="offerRequestTypes" value="${vs.index}" class="check">
                                        <label for="offerRequestTypes${vs.index}">
                                            <img src="/web-resources/img/offer/type/${fn:toLowerCase(type.code)}.png" width="40" height="auto">
                                            <p>${type.value}</p>
                                        </label>
                                    </li>
                                </c:forEach>
                                <div class="error-box"></div>
                            </ul>
                        </div>
                    </section>

                    <section class="form-control mt-0" hidden>
                        <div class="form-label">
                            <i class="fas fa-circle"></i>
                            <span>층</span>
                        </div>
                        <div class="form-control align-center">
                            <a class="select-box" id="select-floor">
                                <span class="txt" id="floor-txt">희망 층</span>
                                <span class="icon">
                                    <img src="/web-resources/img/basic/keyboard_arrow_down-24px.svg">
                                </span>
                                <input type="hidden" id="floor" name="floor">
                            </a>
                            <div id="floor-dialog" title="" hidden>
                                <li>상관없음</li>
                                <li>1층</li>
                                <li>2 ~ 4층</li>
                                <li>5층 이상</li>
                                <li>옥탑</li>
                                <li>반지하</li>
                            </div>
                        </div>

                        <div class="form-label">
                            <i class="fas fa-circle"></i>
                            <span>평수</span>
                        </div>
                        <div class="form-control align-center">
                            <a class="select-box" id="select-pyeong">
                                <span class="txt" id="pyeong-txt">평수</span>
                                <span class="icon">
                                    <img src="/web-resources/img/basic/keyboard_arrow_down-24px.svg">
                                </span>
                                <input type="hidden" id="pyeong" name="pyeong">
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
                                    <img src="/web-resources/img/basic/keyboard_arrow_down-24px.svg">
                                </span>
                                <input type="hidden" id="room" name="room">
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
                            <a class="select-box" onclick="addressInitializer('jibun')">
                                <input readonly type="text" class="txt p-0" id="jibun" name="location" style="border: 0; margin: 0;" placeholder="장소,주소,지역"></input>
                                <span class="icon">
                                        <img src="/web-resources/img/svg/search-24px.svg">
                                </span>
                                <input type="hidden" id="latitude" name="latitude">
                                <input type="hidden" id="longitude" name="longitude">
                            </a>
                            <div id="locationMap" style="width: 100%; height: 200px;" hidden></div>
                        </div>

                        <div class="form-control">
                            <div class="form-label">
                                <i class="fas fa-circle"></i>
                                <span>장소2</span>
                            </div>
                            <a class="select-box" onclick="addressInitializer('jibun2')">
                                <input readonly type="text" class="txt p-0" id="jibun2" name="location" style="border: 0; margin: 0;" placeholder="장소,주소,지역"></input>
                                <span class="icon">
                                        <img src="/web-resources/img/svg/search-24px.svg">
                                </span>
                                <input type="hidden" id="latitude2" name="latitude2">
                                <input type="hidden" id="longitude2" name="longitude2">
                            </a>
                            <div id="locationMap2" style="width: 100%; height: 200px;" hidden></div>
                        </div>
                    </section>

                    <section class="form-control mt-0" hidden>
                        <div class="form-warp">
                            <div class="form-label">
                                <span>반드시 고려해야 할 조건이 있으신가요? (최대 3개 선택 가능)</span>
                            </div>
                            <ul class="checkbox-container form type pt-3 check-area">
                                <c:forEach begin="1" var="type" items="${conditions}" varStatus="vs">
                                    <li class="checkbox-list">
                                        <input id="required${vs.index}" type="checkbox" name="requiredConditions" value="${vs.index}"
                                               class="check" onclick="checkboxLimitOn($(this), 3)">
                                        <label for="required${vs.index}">${type.value}</label>
                                    </li>
                                </c:forEach>
                                <div class="error-box"></div>
                            </ul>
                        </div>
                    </section>

                    <section class="form-control mt-0" hidden>
                        <div class="form-label pt-3">
                            <i class="fas fa-circle"></i>
                            <span>연락 받으실 전화번호</span>
                        </div>
                        <div class="input-group">
                            <input required type="text" class="short" placeholder="연락처" name="phone"
                                   pattern="^[0-9]{1,3}"
                                   oninvalid="this.setCustomValidity(`숫자를 입력해주세요 :)`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                                   onkeyup="formValidatorWithRegex($(this))"
                            >
                            <p class="short">-</p>
                            <input required type="text" class="short" placeholder="####" name="phone"
                                   pattern="^[0-9]{4}"
                                   oninvalid="this.setCustomValidity(`4자리 숫자 입력해주세요 :)`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                                   onkeyup="formValidatorWithRegex($(this), 'phone')"
                            >
                            <p class="short">-</p>
                            <input required type="text" class="short" placeholder="####" name="phone"
                                   pattern="^[0-9]{4}"
                                   oninvalid="this.setCustomValidity(`4자리 숫자 입력해주세요 :)`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                                   onkeyup="formValidatorWithRegex($(this), 'phone')"
                            >
                        </div>
                        <div class="form-warp pt-3">
                            <div class="form-label align-center">
                                <span>필요한 요구사항을 간단히 적어주세요!</span>
                            </div>
                            <div class="form-control">
                                <textarea class="w-full" name="demand" style="resize: none; height: 200px; padding: 2%;"></textarea>
                            </div>
                        </div>
                    </section>

                    <div class="form-control mt-0">
                        <p class="error w-half align-center" style="margin: 0 auto !important;" hidden>
                            <i class="fas fa-exclamation-circle" id="error"></i>
                        </p>
                        <div class="align-center my-1">
                            <button type="button" id="prev" class="login-button w-35 fl" onclick="processNavigator(false)" hidden>이전</button>
                            <button type="button" id="next" class="login-button w-35 fr" onclick="processNavigator(true)">다음</button>
                            <button type="button" id="request-submit" class="login-button w-35 fr" style="display: none !important;"
                                    onclick="$('#submit-trigger').click()">의뢰하기
                            </button>
                            <input hidden type="submit" id="submit-trigger">
                        </div>
                    </div>
                </div>
            </form>
        </article>
    </div>
</body>
</html>

<script>
    $(document).ready(function () {
        $('#date').datepicker({
            dateFormat: 'yy.mm.dd',
            minDate: 0,
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
                $("#moveIn").val($(this).val());
            }
        });

        $('#yes').click(function () {
            $('#date').datepicker('show');
        });

        sliderInitialize();
        dialogInitialize();
    });

    function wantMoveTrigger() {
        if($('#no').prop('checked')) {
            $('#want-move').show();
            $('#date-area').empty();
            $('#date').attr('disabled', true);
        } else {
            $('#want-move').hide();
            $('#date').removeAttr('disabled');
        }
    }

    let formIndex = 0;

    function processNavigator(isNext) {
        const selector = $("#formWrap");

        if(isNext) {
            if(!validatorProvider(formIndex)) {
                return;
            }

            if(formIndex === selector.children('section').length - 2) {
                $('#next').hide();
                $('#request-submit').show()
            }

            $('#prev').show();
            selector.children().eq(formIndex).hide();
            selector.children().eq(++formIndex).show();
        } else {
            if(formIndex === 0) {
                selector.children().eq(formIndex).show();
                return;
            }

            $('#next').show();
            $('#request-submit').hide();
            selector.children().eq(formIndex).hide();
            selector.children().eq(--formIndex).show();
        }

        $('.error').hide();

        if(formIndex === 0) {
            $("#prev").hide();
        }
    }

    function checkboxLimitOn(el, limit) {
        let cnt = $("input:checked[name='requiredConditions']").length;

        if(cnt > limit) {
            el.attr("checked", false);
            errorHandle(false, "최대 " + limit + "개까지 선택가능해요 :)");
        }
    }

    function addressInitializer(inputId) {
        getAddress(inputId);

        let geoLocationElement = inputId === "jibun2" ? "latitude2" : "latitude";
        let geolocationValue = $(geoLocationElement).val();

        console.log(inputId, geoLocationElement, geolocationValue);

        if(inputId === "jibun2") {

        } else {

        }
    }

    switchContentViewWithIndex('#leftNav > li', '.form-control', '#formWrap');
</script>
