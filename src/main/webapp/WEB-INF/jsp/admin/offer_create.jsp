<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>아바 관리자모드</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/scss/component/form.css">
    <link rel="stylesheet" href="https://rawgit.com/enyo/dropzone/master/dist/dropzone.css">

    <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
</head>

<style>
    .left-navbar {
        position: fixed;
        text-align: center;
        left: 12.5%;
        top: 10%;
    }

    .left-navbar .active {
        background: #00adef;
        font-weight: bold;
        color: white;
        border: none;
    }

    .nav-left {
        font-size: 16px;
        font-weight: 500;
        letter-spacing: 1px;
        padding: 40px 20px;
        margin: 100px 0;
        background: #fff;
        border: 1px solid gray;
        border-radius: 100%;
        cursor: pointer;
        animation-name: go;
        animation-delay: 0s;
        animation-duration: 0.7s;
        animation-iteration-count: infinite;
        animation-timing-function: ease-in-out;
        animation-direction: alternate;
    }

    .nav-left:hover {
        background: white;
        border: 1px solid #00adef;
        color: #00adef;
    }

    .bottom-navbar {
        position: absolute;
        bottom: 5%;
        cursor: pointer;
    }

    .nav-bottom:hover {
        color: #00adef;
    }

    .bottom-navbar.prev {
        left: 25vw;
    }

    .bottom-navbar.next,
    .bottom-navbar.submit {
        right: 25vw;
    }

    .nav-bottom {
        color: black;
    }
</style>

<body>
    <div class="main-container p-1">
        <ul class="left-navbar" id="leftNav">
            <li class="nav-left active">기본정보</li>
            <li class="nav-left">주소정보</li>
            <li class="nav-left">추가정보</li>
        </ul>
        <div class="bottom-navbar prev" onclick="bottomNavigator(false)" hidden>
            <p class="nav-bottom aba txt-lg">
                <i class="fas fa-arrow-alt-circle-left"></i>
                Prev
            </p>
        </div>
        <div class="bottom-navbar next" onclick="bottomNavigator(true)">
            <p class="nav-bottom aba txt-lg">
                Next
                <i class="fas fa-arrow-alt-circle-right"></i>
            </p>
        </div>
        <div class="bottom-navbar submit" hidden>
            <p class="nav-bottom aba txt-lg">
                등록하기
                <i class="fas fa-check-circle"></i>
            </p>
        </div>

        <article class="content-wrap">
            <div class="content-name" id="top">
                <h3>
                    <span class="aba">아바</span>
                    <span class="header mini">매물등록</span>
                </h3>
            </div>

            <form action="/aws/s3/upload" method="post" enctype="multipart/form-data" onsubmit="return false;">
            <div id="formWrap">
                <section class="form-control mt-0">
                        <div class="form-warp">
                            <div class="deal-type">
                                <div class="form-label">
                                    <i class="fas fa-circle"></i>
                                    <span>거래유형</span>
                                </div>
                                <ul class="checkbox-container form type">
                                    <c:forEach begin="1" var="type" items="${dealTypes}" varStatus="vs">
                                        <li class="checkbox-list">
                                            <input id="dealType${vs.index}" type="radio" name="dealType" value="${type.code}" class="check">
                                            <label for="dealType${vs.index}">${type.value}</label>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>

                            <div class="offer-type">
                                <div class="form-label">
                                    <i class="fas fa-circle"></i>
                                    <span>매물분류</span>
                                </div>
                                <ul class="checkbox-container form type">
                                    <c:forEach begin="1" var="type" items="${offerTypes}" varStatus="vs">
                                        <li class="checkbox-list half">
                                            <input id="offerType${vs.index}" type="radio" name="offerType" value="${type.code}" class="check">
                                            <label for="offerType${vs.index}">${type.value}</label>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>

                            <div class="heating-type">
                                <div class="form-label">
                                    <i class="fas fa-circle"></i>
                                    <span>난방방식</span>
                                </div>
                                <ul class="checkbox-container form type">
                                    <c:forEach begin="1" var="type" items="${heatingTypes}" varStatus="vs">
                                        <li class="checkbox-list half">
                                            <input id="heatingType${vs.index}" type="radio" name="heatingType" value="${type.code}" class="check">
                                            <label for="heatingType${vs.index}">${type.value}</label>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>

                            <div class="offer-deal">
                                <div class="form-label">
                                    <i class="fas fa-circle"></i>
                                    <span>매물가격 (보증금 / 달세 + 관리비)</span>
                                </div>
                                <div class="form-category full">
                                    <div class="input-group">
                                        <input type="text" class="short" id="deposit" placeholder="보증금" name="">
                                        <p class="icon"><i class="fas">만</i></p>
                                        <p class="short">/</p>
                                        <input type="text" class="short" id="monthlyPrice" placeholder="달세" name="">
                                        <p class="icon"><i class="fas">만</i></p>
                                        <p class="short">+</p>
                                        <input type="text" class="short" id="managementPrice" placeholder="관리비" name="">
                                        <p class="icon"><i class="fas">만</i></p>
                                    </div>
                                </div>
                            </div>

                            <div class="year pt-3">
                                <div class="form-label">
                                    <i class="fas fa-circle"></i>
                                    <span>준공년도</span>
                                </div>
                                <div class="form-category">
                                    <div class="input-group">
                                        <input type="text" class="short" id="completionYear" placeholder="1991" name="">
                                        <p class="icon"><i class="fas">년</i></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                </section>

                <section class="form-control mt-0" hidden>
                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>소재지</span>
                    </div>
                    <div class="input-group">
                        <input autofocus readonly type="text" class="middle" id="jibun" placeholder="지번주소" name="jibunAddr">
                        <p class="short">/</p>
                        <input autofocus readonly type="text" class="middle" id="road" placeholder="도로명주소" name="roadAddr">
                        <p class="icon addr" onclick="getAddress()"><i class="fas fa-search"></i></p>
                    </div>

                    <div class="input-group">
                        <input type="text" class="middle" placeholder="예) 아바아파트, 아바빌, 아바빌딩">
                        <p class="icon-with-check" onclick="noneAction($(this))"><i class="fas">없음</i></p>
                    </div>

                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>호실 정보</span>
                    </div>
                    <div class="input-group">
                        <input type="hidden" id="latitude" name="locationX">
                        <input type="hidden" id="longitude" name="locationY">
                        <input type="text" class="short" placeholder="예) 3동" name="dong" id="dong">
                        <p class="icon"><i class="fas">동</i></p>
                        <p class="short"></p>
                        <input type="text" class="short" placeholder="예) 401호" name="">
                        <p class="icon"><i class="fas">호</i></p>
                    </div>
                    <ul class="checkbox-container p-0 w-half">
                        <li class="checkbox-list w-65">
                            <input type="checkbox" class="check" id="isExistDong"
                                   onclick="dongTrigger($('#dong'))"
                            >
                            <label for="isExistDong">등본에 동 정보가 없습니다</label>
                        </li>
                    </ul>

                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>해당층</span>
                    </div>
                    <div class="input-group">
                        <ul class="checkbox-container p-0 w-half">
                            <li class="checkbox-list w-25">
                                <input type="radio" class="check" id="floorUp" name="none" checked
                                       onchange="floorTrigger()"
                                >
                                <label for="floorUp">지상</label>
                            </li>
                            <li class="checkbox-list w-25">
                                <input type="radio" class="check" id="floorUnder" name="none"
                                       onchange="floorTrigger()"
                                >
                                <label for="floorUnder">반지하</label>
                            </li>
                            <li class="checkbox-list w-25">
                                <input type="radio" class="check" id="floorTop" name="none"
                                       onchange="floorTrigger()"
                                >
                                <label for="floorTop">옥탑방</label>
                            </li>
                        </ul>
                        <input type="text" class="short" placeholder="예) 3층" name="" id="floor">
                        <p class="icon"><i class="fas">층</i></p>
                    </div>

                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>입구 / 호실 비밀번호</span>
                    </div>
                    <div class="input-group">
                        <input type="text" class="short" placeholder="123* 또는 전화문의" name="dong" id="entrance">
                        <p class="icon-with-check" onclick="noneAction($(this))"><i class="fas">없음</i></p>
                        <p class="short">/</p>
                        <input type="text" class="short" placeholder="1234* 또는 전화문의" name="dong" id="door">
                        <p class="icon-with-check" onclick="noneAction($(this))"><i class="fas">없음</i></p>
                    </div>

                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>주요 위치</span>
                    </div>
                    <div class="input-group">
                        <input type="text" class="short" placeholder="아바경찰서" name="">
                        <p class="icon"><i class="fas">부근</i></p>
                    </div>
                </section>

                <section class="form-control mt-0" hidden>
                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>옵션 정보</span>
                    </div>
                    <ul class="checkbox-container p-1">
                        <c:forEach var="option" items="${options}" begin="1" varStatus="vs">
                            <li class="checkbox-list" style="width: 15%;">
                                <input id="option${vs.index}" type="checkbox" name="option" value="${vs.index}" class="check">
                                <label for="option${vs.index}">
                                        ${option.value}
                                </label>
                            </li>
                        </c:forEach>
                    </ul>

                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>부가 정보</span>
                    </div>
                    <ul class="checkbox-container p-1">
                        <li class="checkbox-list" style="width: 15%;">
                            <input id="tenant" type="checkbox" class="check" onchange="dynamicFormTrigger($(this))">
                            <label for="tenant">세입자 있음</label>
                        </li>
                        <li class="checkbox-list" style="width: 15%;">
                            <input id="term" type="checkbox" class="check" onchange="dynamicFormTrigger($(this))">
                            <label for="term">단기 가능</label>
                        </li>
                        <li class="checkbox-list" style="width: 15%;">
                            <input id="elvator" type="checkbox" name="hasElevator" value=true class="check"
                                   onchange="elevatorTrigger($(this))"
                            >
                            <label for="elvator">승강기 있음</label>
                        </li>
                        <li class="checkbox-list" style="width: 15%;">
                            <input id="parking" type="checkbox" name="isParking" value=true class="check">
                            <label for="parking">주차 가능</label>
                        </li>
                        <li class="checkbox-list" style="width: 15%;">
                            <input id="pet" type="checkbox" name="isPet" value=true class="check">
                            <label for="pet">반려 가능</label>
                        </li>
                    </ul>

                    <div id="tenantDesc" hidden>
                        <div class="input-group">
                            <label class="form-label">* 세입자 : </label>
                            <input type="text" class="short" name="tenant" placeholder="예) 유(3월말)">
                        </div>
                    </div>

                    <div id="howTerm" hidden>
                        <div class="input-group">
                            <label class="form-label">* 단기 가능일 : <span class="aba">최대</span></label>
                            <input type="text" class="short" placeholder="예) 3">
                            <p class="icon"><i class="fas">개월</i></p>
                        </div>
                    </div>

                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>관리비 항목</span>
                    </div>
                    <ul class="checkbox-container p-1">
                        <c:forEach var="manage" items="${manages}" begin="1" varStatus="vs">
                            <li class="checkbox-list" style="width: 15%;">
                                <input id="manage${vs.index}" type="checkbox" name="management" value="${vs.index}" class="check">
                                <label for="manage${vs.index}">
                                        ${manage.value}
                                </label>
                            </li>
                            <c:if test="${manage.value eq '엘리베이터'}">
                                <script>$('#manage5').parent().hide()</script>
                            </c:if>
                        </c:forEach>
                    </ul>

                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>부가 설명</span>
                    </div>
                    <input type="text" placeholder="예) 벽지 재공사 예정이라고 합니다~">

                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>사진 등록</span>
                    </div>
                    <div class="image-area pt-3">
                        <div id="dropzone" class="dropzone align-center">
                            <div class="dz-default dz-message">
                                <img src="/img/offer/add_image.png">
                                <p class="aba pt-3">사진을 끌어다 놓거나 눌러서 업로드 해주세요 :)</p>
                            </div>
                            <input type="hidden" name="offerIdForDirectory" value="1234"/>
                            <input hidden type="file" id="files" name="files" multiple />
                        </div>
                    </div>
                </section>
            </div>
            </form>
        </article>
    </div>
</body>
</html>

<script src="https://rawgit.com/enyo/dropzone/master/dist/dropzone.js"></script>
<script>
    Dropzone.options.dropzone = {
        url: '/aws/s3/upload',
        autoProcessQueue: false,
        uploadMultiple: true,
        addRemoveLinks: true,
        maxFiles: 8,
        thumbnailWidth: 100,
        thumbnailHeight: 100,
        acceptedFiles: 'image/*',
        addedfiles: function (file) {
            $('.dz-progress').remove();
            $('.dz-image').css('width', 100);
            $('.dz-image').css('height', 100);
            $('.dz-remove').html(`<i class='fas fa-minus-circle' style="cursor: pointer;"></i>`)
            $('.dz-remove').css('margin-top', 10);

            $("#files")[0].files = file;
        }
    };

    $('#leftNav > li').click(function(e) {
        let navIndex = $(e.currentTarget).index();

        if(navIndex === 0) {
            $('.prev').hide();
        } else if(navIndex === 2) {
            $('.next').hide();
            $('.submit').show();
        } else {
            $('.prev').show();
            $('.next').show();
            $('.submit').hide();
        }
    });

    function findNavIndex() {
        let nav = $('#leftNav > li');

        for(let i = 0; i < nav.length; i++) {
            if($(nav[i]).hasClass('active')) {
                return $(nav[i]).index();
            }
        }
    }

    function bottomNavigator(isNext) {
        let selector = $('#leftNav');

        if(findNavIndex() === selector.children('li').length) {
            return;
        }

        if(isNext) {
            $('#leftNav').children().eq(findNavIndex() + 1).click();
        } else if(findNavIndex() !== 0){
            $('#leftNav').children().eq(findNavIndex() - 1).click();
        }
    }

    function dongTrigger(selector) {
        selector.prop('readonly', !selector.prop('readonly'));
    }

    function floorTrigger() {
        let isFloorUp = $('#floorUp').prop('checked');
        let selector = $('#floor');

        selector.prop('readonly', !isFloorUp)

        if($('#floorUnder').prop('checked')) {
            selector.prop('placeholder', '반지하')
        } else if($('#floorTop').prop('checked')) {
            selector.prop('placeholder', '옥탑방')
        } else {
            selector.prop('placeholder', '예) 3층')
        }
    }

    function noneAction(focus) {
        let bool = focus.css('background-color') === 'rgb(0, 173, 239)';
        bool ? focus.css('background', 'red') : focus.css('background', '#00adef');
        focus.prev('input').prop('readonly', bool)
    }

    function elevatorTrigger(focus) {
        let isChecked = focus.prop('checked');

        console.log(isChecked);

        isChecked ? $('#manage5').parent().show() : $('#manage5').parent().hide();
        $('#manage5').prop('checked', false);
    }

    function dynamicFormTrigger(focus) {
        let elementId = focus.attr('id');

        console.log(elementId);

        elementId === 'tenant' ? $('#tenantDesc').toggle() : $('#howTerm').toggle();
    }

    activateWithSelector('#leftNav > li');
    switchContentViewWithIndex('#leftNav > li', '.form-control', '#formWrap');
</script>
