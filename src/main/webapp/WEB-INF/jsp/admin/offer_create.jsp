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
        left: 25%;
    }

    .bottom-navbar.next,
    .bottom-navbar.submit {
        right: 25%;
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

            <div id="formWrap">
                <section class="form-control mt-0">
                    <form action="/aws/s3/upload" method="post" enctype="multipart/form-data" onsubmit="return test();">
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

    <%--                    <div id="dropzone" class="dropzone align-center">--%>
    <%--                        <div class="dz-default dz-message">--%>
    <%--                            <img src="/img/offer/add_image.png">--%>
    <%--                            <p class="aba pt-3">사진을 끌어다 놓거나 눌러서 업로드 해주세요 :)</p>--%>
    <%--                        </div>--%>
    <%--                        <input type="hidden" name="offerIdForDirectory" value="1234"/>--%>
    <%--                        <input hidden type="file" id="files" name="files" multiple />--%>
    <%--                    </div>--%>
    <%--                    <div class="pt-1">--%>
    <%--                        <button class="login-button" type="submit">등록하기</button>--%>
    <%--                    </div>--%>
                    </form>
                </section>

                <section class="form-control mt-0" hidden>
                    SEC 2
                </section>

                <section class="form-control mt-0" hidden>
                    SEC 3
                </section>
            </div>
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

    activateWithSelector('#leftNav > li');
    switchContentViewWithIndex('#leftNav > li', '.form-control', '#formWrap');

    function test() {
        return true;
    }
</script>
